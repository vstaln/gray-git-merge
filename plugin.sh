#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-git-merge.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-git-merge" ;;
    *) rel="x86_64-apple-darwin/gray-git-merge" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-git-merge" ;;
    *) rel="x86_64-unknown-linux-musl/gray-git-merge" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-git-merge.exe" "$here/target/release/gray-git-merge" "$here/target/debug/gray-git-merge.exe" "$here/target/debug/gray-git-merge"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-git-merge binary not found in $here" >&2
exit 1
