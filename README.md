# gray-git-merge

`/merge <branch>` runs `git merge` in the session repo; conflicts hand the model a resolve prompt plus the `git_conflicts` tool. Port of pi's `git-merge-and-resolve` extension.

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

pi merged the upstream tracking ref after every turn automatically; gray has
no wire hook that fits, so merging is the explicit `/merge` command.

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
