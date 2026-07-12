---
name: bootstrap-repository
description: Create or improve a reproducible local developer setup with runnable automation and setup-oriented documentation. Use when the user asks to initialize, scaffold, bootstrap, modernize, or make a repository easy to set up, including requests for Makefiles, package-manager setup, environment templates, development services, or onboarding instructions.
---

# Bootstrap Repository

Leave a repository that a developer can set up, run, verify, and understand using a small, coherent command surface.

## Workflow

1. Inspect the repository, applicable guidance, current working tree, existing package managers, lockfiles, runtime versions, task runners, CI, and documentation.
2. Derive the intended local workflow from the request. Preserve established tools and avoid introducing a second package manager or overlapping task runner without a concrete reason.
3. Design the smallest useful command surface for setup, development, verification, and cleanup. Prefer runnable targets over prose-only instructions.
4. Make setup reproducible and safe to rerun. Pin or lock dependencies where the ecosystem supports it, preserve existing user files, and keep generated or machine-local state out of version control.
5. Keep credentials outside tracked files. Add narrowly scoped example configuration and fail with actionable messages when required local values or tools are missing.
6. Document the shortest successful path first, then explain profiles, optional services, troubleshooting, and destructive operations only as needed.
7. Run the setup or a representative smoke path in the available environment. Exercise help and validation commands and confirm that documented commands match actual behavior.
8. Report what was created, what was verified, platform-specific assumptions, and any remaining manual steps.
