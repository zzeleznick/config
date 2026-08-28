# Housekeeping

Periodic maintenance tasks for keeping the machine healthy.

## Runtime

For when the machine feels slow *right now*, rather than when the disk is full.

Worktree-per-branch workflows leak background work. Delete a worktree and the
dev server, headless browser, and container stack it started keep running with
nothing left to serve. They accumulate silently over days.

```bash
# What is orphaned (read-only)
stale

# Terminate it — stops containers, never removes them, so volumes survive
stale --clean

# Also remove the orphaned stacks' containers, to reclaim disk
stale --prune

# Longer grace period for idle browsers; higher crash-loop threshold
stale --hours 12 --restarts 50
```

`stale` looks for processes whose working directory has been deleted, processes
waiting on a port nothing listens on any more, headless browsers left running
for hours, container stacks whose project directory is gone, and containers
stuck in a restart loop.

### Diagnosing before you clean

Check what kind of problem you have first, or you will clean up the wrong thing.

```bash
# Memory-bound or CPU-bound? Heavy swap use means memory.
sysctl vm.swapusage
vm_stat | awk '/Pages free/ {printf "%.0f MB free\n", $3 * 16384 / 1048576}'

# Sustained CPU, not the one-second snapshot ps gives you
top -l 2 -n 10 -o cpu -stats pid,cpu,mem,command | tail -12
```

Two things that mislead:

- **Idle processes do not raise load average.** A hung browser waiting on a
  dead socket sits at 0% CPU. Killing it frees memory, ports, and process
  slots — it will not lower load. If load is the problem, find what is actually
  running.
- **`ps` RSS understates VM-based runtimes.** OrbStack's helper can show under
  1 GB in `ps` while holding 8 GB of guest memory. Use the `MEM` column from
  `top`, which reports the physical footprint.

Attribute improvements carefully. Measure before and after, and check whether a
build or test run finished on its own in the same window.

### Container stacks

Per-branch tooling (Supabase CLI and similar) starts a full stack per workspace,
and those outlive the workspace. Find the orphans by the directory recorded in
the container's labels:

```bash
# Which stack came from where, and does that directory still exist?
for c in $(docker ps --format '{{.Names}}'); do
  docker inspect "$c" --format '{{.Name}} {{index .Config.Labels "com.supabase.cli.workdir"}}'
done | sort -u -k2
```

Test the *full* recorded path, not just the workspace root — a workspace often
still exists while the specific stack directory inside it has been removed.

### Reclaiming container disk

`stale --prune` removes containers, but only for stacks it has proven orphaned.
Avoid the blanket version:

```bash
docker container prune     # takes EVERY stopped container
```

That includes stacks that are merely stopped at the moment — a dev environment
you stopped an hour ago and plan to bring back this afternoon.

The bigger hazard is what pruning containers does to volumes. A stopped
container is the only thing keeping its named volume out of the "dangling"
bucket. Remove the container and the volume becomes eligible for a command that
otherwise feels routine:

```bash
# Before: local dev database, protected by a stopped container
# After a container prune: dangling, and this deletes it
docker volume prune
```

So check what is actually dangling, with sizes, before running that:

```bash
docker volume ls -qf dangling=true | while read -r v; do
  docker system df -v | awk -v n="$v" '$1 == n {printf "%-55s %s\n", $1, $NF}'
done
```

Images are the other large bucket, and are safe to remove in the sense that
nothing is lost — but a re-pull is slow, so do it when you have the bandwidth,
not while you are trying to get unblocked.

```bash
docker system df           # where the space actually is
docker image prune -a      # unused images
docker builder prune       # build cache
```

### Crash loops

A container that restarts forever burns CPU continuously and never recovers.
Docker keeps a count:

```bash
docker inspect NAME --format '{{.RestartCount}} {{.State.ExitCode}} {{.State.Restarting}}'
docker logs --tail 5 NAME   # the last line is usually the whole diagnosis

# Stop it for good — clear the restart policy first, or it comes straight back
docker update --restart=no NAME && docker stop NAME
```

`.State.OOMKilled` only reflects per-container cgroup kills. If containers die
together with mixed exit codes (0, 137, 143) and that flag is false, suspect
memory exhaustion in the VM itself and check `~/.orbstack/log/vmgr.log` for
guest kernel OOM messages.

### Shell gotchas when scripting cleanup

```bash
# zsh does NOT word-split unquoted parameters. This passes ONE mangled argument
# and silently does nothing, while still exiting 0:
docker stop $IDS          # broken in zsh

# Pipe to xargs, or expand a real array:
docker ps -q --filter ... | xargs -r docker stop
kill -TERM "${PIDS[@]}"
```

Two more that cost real debugging time:

- `docker stop` exits 0 even when its argument list was garbage. Verify from
  `.State.FinishedAt`, not from the exit status or from `docker ps`.
- A bare `local x` on an already-declared local prints `x=value` in zsh.
  Declare loop variables once, outside the loop.
- Signals are asynchronous. `kill -0` right after `kill` reports processes that
  are merely mid-exit. Poll for a moment before declaring failure.

## Disk Space

### Docker / OrbStack

Docker images and containers are the biggest space hog. Check and clean regularly.

```bash
# See what's using space
docker system df

# Remove stopped containers, unused networks, dangling images, and build cache
docker system prune

# Nuclear option — remove ALL unused images, not just dangling ones
docker system prune -a

# Remove specific unused volumes (careful — this deletes data)
docker volume prune
```

### Homebrew

```bash
# Remove old versions of installed formulae
brew cleanup

# See what would be removed first
brew cleanup --dry-run

# Remove stale downloads from cache
brew cleanup -s
```

### Rust / Cargo

```bash
# Remove build artifacts from all projects
cargo clean  # (run inside a project directory)

# Check ~/.cargo/registry/ size — can grow large over time
du -sh ~/.cargo/registry/
```

### System

```bash
# Quick disk space overview
df -h /

# Find large files in home directory
du -sh ~/Dev/*/ | sort -rh | head -20

# Clear macOS system caches (safe to do periodically)
sudo purge

# Flush DNS cache
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

### Node / Bun

```bash
# Find and optionally remove node_modules directories
find ~/Dev -name "node_modules" -type d -maxdepth 3 | xargs du -sh | sort -rh

# Remove all node_modules (only in inactive projects — re-install with npm/bun install)
# find ~/Dev -name "node_modules" -type d -maxdepth 3 -exec rm -rf {} +
```

## Updates

```bash
# Homebrew
brew update && brew upgrade

# Rust toolchain
rustup update

# Cargo-installed binaries (no built-in way — reinstall individually)
cargo install bat  # etc.

# Oh My Zsh
omz update

# yt-dlp (updates frequently — video sites change often)
brew upgrade yt-dlp
```
