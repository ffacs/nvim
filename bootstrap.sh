#!/usr/bin/env bash
set -euo pipefail
config_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mode="${1:-install}"
case "$mode" in install|--check|--no-system) ;; *) echo 'Usage: bash bootstrap.sh [--check|--no-system]' >&2; exit 2 ;; esac
nvim_bin="${NVIM_BIN:-nvim}"
if ! command -v "$nvim_bin" >/dev/null 2>&1; then
  echo 'Install Neovim >= 0.10 first (or set NVIM_BIN to its executable).' >&2
  exit 1
fi
"$nvim_bin" --headless -u NONE -i NONE '+lua if vim.fn.has("nvim-0.10") == 0 then vim.cmd("cquit 1") end' '+qa!' || {
  echo 'Neovim >= 0.10 is required.' >&2; exit 1;
}
missing=()
for tool in git curl tar gzip unzip rg node npm python3; do
  command -v "$tool" >/dev/null 2>&1 || missing+=("$tool")
done
if command -v python3 >/dev/null 2>&1 && ! python3 -c 'import venv, ensurepip' >/dev/null 2>&1; then
  missing+=(python3-venv)
fi
if [ "${#missing[@]}" -gt 0 ]; then
  echo "Missing system dependencies: ${missing[*]}"
  if [ "$mode" != install ]; then exit 1; fi
  as_root() {
    if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi
  }
  case "$(uname -s)" in
    Darwin)
      command -v brew >/dev/null 2>&1 || { echo 'Install Homebrew from https://brew.sh, then rerun this script.' >&2; exit 1; }
      brew install git curl unzip ripgrep node python
      ;;
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        as_root apt-get update
        as_root apt-get install -y git curl tar gzip unzip ripgrep nodejs npm python3 python3-venv python3-pip ca-certificates build-essential
      elif command -v dnf >/dev/null 2>&1; then
        as_root dnf install -y git curl tar gzip unzip ripgrep nodejs npm python3 python3-pip gcc gcc-c++ make
      elif command -v pacman >/dev/null 2>&1; then
        as_root pacman -S --needed git curl tar gzip unzip ripgrep nodejs npm python python-pip base-devel
      else
        echo 'Unsupported package manager. Install the listed dependencies, then rerun.' >&2; exit 1
      fi
      ;;
    *) echo 'This script supports macOS and Linux.' >&2; exit 1 ;;
  esac
  bash "$config_dir/bootstrap.sh" --check
fi
node -e 'if (Number(process.versions.node.split(".")[0]) < 20) process.exit(1)' || {
  echo 'Node.js >= 20 is required for language servers; upgrade Node.js and rerun.' >&2; exit 1;
}
python3 -c 'import sys; assert sys.version_info >= (3, 10), "Python >= 3.10 is required"'
if [ "$mode" = --check ]; then
  echo 'System prerequisites are available.'
  exit 0
fi
export NVIM_BOOTSTRAP_CONFIG="$config_dir"
"$nvim_bin" --headless -i NONE -u "$config_dir/init.lua" \
  --cmd 'lua vim.opt.rtp:prepend(vim.env.NVIM_BOOTSTRAP_CONFIG)' \
  '+lua dofile(vim.env.NVIM_BOOTSTRAP_CONFIG .. "/scripts/bootstrap.lua")'
