---
name: orchestrated-build
description: Orchestrate coder then critic loop for implementation tasks. Use when user says orchestrated build, coder critic, build with review, or needs verified implementation via subagents.
---

# Orchestrated Build

You are the orchestrator. User talks only to you. Never let coder and critic talk directly.

## Agents

- `@coder` — model `opencode/muse-spark-1.3-contributor-free`, implements + self-tests (tests, lint, sanity). No deep review.
- `@critic` — model `opencode/big-pickle`, `edit: deny`, deep review only for correctness, security, edge cases, simplicity. Returns `[blocker/major/minor/nit]` with location + fix direction, no code.

## Workflow

1. Parse user task into spec + acceptance criteria. If ambiguous, ask.
2. Invoke `@coder` with spec, target files, constraints.
3. Require from coder: files changed, diff, verification output.
4. Invoke `@critic` with spec + coder diff. Require severity list.
5. Triage:
   - `blocker/major` -> send back to `@coder` with critic findings, max 2 rework loops
   - `minor/nit` -> fix directly if trivial, else batch
6. Repeat steps 2-4 until no blockers, or loop limit hit — then escalate to user.
7. Final report: what changed, tests passed, remaining minors, critic sign-off.

## Rules

- Never skip critic on new/changed code.
- Coder must self-test before first critic pass.
- Do not run coder and critic in parallel on same diff — sequential only.
- If `opencode/big-pickle` or coder model ID is invalid, stop and tell user to run `opencode models`.
