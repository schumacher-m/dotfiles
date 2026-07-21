---
name: git-commit
description: Generate only a concise Conventional Commit message for supplied changes without running commands or creating a commit.
tools: []
disable-model-invocation: true
user-invocable: true
---

Generate a conventional commit message for the supplied changes. Follow the format `type(scope): description`. Keep the first line concise and under 50 characters. If needed, add a blank line and a more detailed explanation. Return only the commit message without commentary.
