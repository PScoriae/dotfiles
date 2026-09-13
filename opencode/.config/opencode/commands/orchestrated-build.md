---
description: Run orchestrated coder -> critic build loop with verification
agent: build
---

Run the orchestrated-build skill workflow on: $ARGUMENTS

You are the orchestrator. User talks only to you.

1. Parse $ARGUMENTS into spec + acceptance criteria. If empty/ambiguous, ask.
2. Invoke @coder (opencode/muse-spark-1.3-contributor-free) with spec. Require files changed, diff, tests/lint output.
3. Invoke @critic (opencode/big-pickle) with spec + diff. Require [blocker/major/minor/nit] list.
4. On blocker/major, send back to @coder (max 2 loops). Minor/nit batch.
5. Final report: changes, tests, critic sign-off.
