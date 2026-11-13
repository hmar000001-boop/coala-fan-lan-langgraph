#!/usr/bin/env bash
set -Eeuo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run this installer with sudo." >&2
  exit 2
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
  ca-certificates curl perl tar gzip xz-utils fontconfig \
  poppler-utils make nodejs npm

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT
cd "$workdir"

# The CTAN tlnet endpoint follows the latest available TeX Live distribution.
curl --fail --location --retry 5 --retry-delay 3 \
  https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
  --output install-tl.tar.gz
tar -xzf install-tl.tar.gz
installer_dir="$(find . -maxdepth 1 -type d -name 'install-tl-*' -print -quit)"
if [[ -z "$installer_dir" ]]; then
  echo "Unable to locate extracted TeX Live installer." >&2
  exit 3
fi

"${installer_dir}/install-tl" --profile "${ROOT}/.github/texlive.profile"

export PATH="/opt/texlive/bin/x86_64-linux:${PATH}"
export PATH
tlmgr update --self
while IFS= read -r package; do
  [[ -z "$package" || "$package" =~ ^# ]] && continue
  tlmgr install "$package"
done < "${ROOT}/.github/texlive.packages"

xelatex --version | head -n 2
latexmk -v | head -n 2
biber --version | head -n 1
