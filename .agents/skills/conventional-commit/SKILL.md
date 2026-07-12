---
name: conventional-commit
description: Create focused Conventional Commits from local repository changes while preserving unrelated work. Use when the user asks Codex to commit staged or unstaged changes, create a conventional commit, organize changes into commits, or finish a local change with a commit. Do not use merely to suggest a commit message without performing Git operations.
---

# Conventional Commit

Create commits that match the user's intended scope and leave the repository in a clearly reported state.

## Workflow

1. Read applicable repository guidance and inspect `git status`, staged changes, unstaged changes, and recent commit style.
2. Infer the intended commit scope from the current request and work completed in the conversation. If materially different scopes remain plausible, ask before committing.
3. Preserve unrelated edits. Stage explicit paths or hunks; never use `git add .` or `git add -A` without first reviewing and confirming that every included change belongs to the requested scope.
4. Choose a substantial, reviewable commit boundary. Prefer a completed feature slice with its tests over line-level changes, arbitrary work-in-progress snapshots, or individual red-green micro-steps. Separate independently reviewable changes when one commit would mix unrelated purposes.
5. Run relevant focused checks when they have not already been run. Do not bypass hooks.
6. Write a concise message in the form `type(scope): summary`, omitting the scope when it adds no value. Use the type that describes the change, such as `feat`, `fix`, `docs`, `test`, `refactor`, `build`, `ci`, or `chore`.
7. Create the commit, then verify the resulting commit and remaining working-tree state.
8. Report the commit hash, subject, checks, and any changes intentionally left uncommitted. Do not rewrite existing commits or push unless explicitly requested.
