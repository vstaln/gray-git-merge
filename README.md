<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-git-merge</h1>
<p align="center">/merge plus a git_conflicts tool for agent-driven merge-conflict resolution.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-git-merge/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

`/merge <branch>` runs `git merge` in the session repo; conflicts hand the
model a resolve prompt plus the `git_conflicts` tool.

A sidecar plugin for [gray](https://github.com/vstaln/gray), scaffolded by
[gray-account](https://github.com/vstaln/gray-account).

## What it does

- `/merge <branch>` → `git -C <session.cwd> merge <branch>`.
  - Clean merge → reported back as `{text}`.
  - Conflicted merge → `{prompt}` (fed to the model): lists the unmerged
    files and tells it to fix the markers and stage each file.
- `git_conflicts` tool:
  - `{action:"list"}` → every `git diff --diff-filter=U` path, flagging files
    whose `<<<<<<<` markers are still present.
  - `{action:"mark-done", file}` → refuses while markers remain, otherwise
    `git add file` and reports what's left.
  - `cwd` arg optional; defaults to the cwd `/merge` recorded in
    `~/.gray/git-merge/last.json`, then the sidecar's own cwd.

Merging is explicit: gray's wire has no per-turn merge hook that fits, so
run `/merge` when you want the merge to happen.

## Wire methods

`plugin/manifest`, `tool/call`, `command/run`, `plugin/shutdown`.

## Install

```sh
gray plugin install git-merge
```

## Develop

```sh
cargo test
cargo build --release
gray account check      # entry point + manifest handshake
```

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
