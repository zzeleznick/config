# Machine Setup

Opinionated guide for setting up a new Mac for development. Dotfiles included.

## First Steps

1. **Homebrew** — package manager for everything else
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

2. **Git & GitHub CLI**
   ```bash
   brew install git gh git-lfs
   gh auth login
   ```

3. **Rust toolchain** — install via [rustup](https://rustup.rs/) for toolchain management (nightly, cross-compilation, components)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
   This installs `rustup`, `cargo`, `rustc` to `~/.cargo/bin/` (added to PATH in `.zshrc`).

4. **Oh My Zsh** — shell framework
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

5. **Copy dotfiles and scripts** — then restart your terminal
   ```bash
   cp dotfiles/.zshrc ~/.zshrc
   cp dotfiles/.gitconfig ~/.gitconfig
   cp bin/* ~/.local/bin/
   ```

## Apps

| App | Install |
|-----|---------|
| [VS Code](https://code.visualstudio.com/) | Editor of choice. Install the `code` CLI from the command palette. |
| [iTerm2](https://iterm2.com/) | Terminal. Import your profile/theme from iTerm2 preferences. |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | `brew install claude-code` or `npm install -g @anthropic-ai/claude-code` |
| [OrbStack](https://orbstack.dev/) | Docker & Linux VMs, lighter than Docker Desktop. |
| [Chrome](https://www.google.com/chrome/) | Primary browser. |

## Languages & Runtimes

Preferred runners in **bold** — use these for new projects.

| Language | Install | Preferred Runner |
|----------|---------|-----------------|
| Python | `brew install python` | **[uv](https://docs.astral.sh/uv/)** — `brew install uv` |
| Node.js | `brew install node` | **npx** (bundled with node) |
| Bun | `brew install oven-sh/bun/bun` | **bun** (runtime + package manager) |
| Rust | [rustup.rs](https://rustup.rs/) | **cargo** (bundled with rust) |
| Go | `brew install go` | `go run` / `go build` |
| Deno | `brew install deno` | **deno** (runtime + package manager) |

### Notes

- **Python**: Use `uv` over `pip` for everything — venvs (`uv venv`), installs (`uv pip install`), and running scripts (`uv run`). It's 10-100x faster.
- **Node/Bun**: Prefer `bun` for new projects, `node`/`npx` for compatibility.
- **Rust**: Prefer `rustup` over `brew install rust` — gives you toolchain management, nightly builds, and cross-compilation targets.

## CLI Tools

```bash
# Search & filtering
brew install jq yq ripgrep

# File viewing — bat is preferred over cat for syntax highlighting
cargo install bat

# Media — yt-dlp is the actively maintained fork of youtube-dl
brew install ffmpeg yt-dlp

# Infrastructure
brew install awscli tree wget curl
```

## Directory Structure

```
~/Dev/
  Semgrep/           # Work (employer repos)
    semgrep-app/
    employee-scripts/
    ...
  rust-workspace/    # Rust side projects
  go-workspace/      # Go side projects
  python-playground/ # Python experiments
  config/            # This repo
  ...
```

Keep work repos under `~/Dev/Semgrep/` and personal projects directly under `~/Dev/`. The `.gitconfig` supports per-directory config overrides via `includeIf` if you need different git identities.

## Shell

- **Framework**: Oh My Zsh with a custom `zz` theme (lives in `~/.oh-my-zsh/custom/themes/`)
- **Plugins**: `git` (default), optionally `zsh-autosuggestions` and `zsh-syntax-highlighting`
- **History**: 50k lines, shared across terminals, ISO timestamps, deduped
- **Git aliases**: Extensive set in `.gitconfig` — run `git aliases` or the shell alias `ga` to list them

See [docs/housekeeping.md](docs/housekeeping.md) for periodic maintenance tasks.
