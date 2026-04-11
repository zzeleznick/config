# Housekeeping

Periodic maintenance tasks for keeping the machine healthy.

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
