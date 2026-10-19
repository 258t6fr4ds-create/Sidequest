# Sidequest reliability and cycling update — 19 October 2026

## What changed

- Shared read projections include completed sessions and the active partial draft exactly once. Daily/weekly summaries, older records and strength markers use them. In-workout prompts use the last comparable session; daily comparisons compare aggregate days.
- Intentional recovery is counted from stored sessions, without changing the preserved main-workout draft. Recovery headline totals use distinct dates.
- Post-completion difficulty, duration, cycling classification, distance and exercise-note amendments update the current session. Original IDs, creation/occurrence timestamps, XP and unlock ledgers are retained.
- Morning defaults are 20 minutes Monday–Friday and open-ended weekends (stored target 0). A positive-duration open-ended ride earns the existing 25 XP once per day. A new versioned morning preference leaves historical frozen targets and older settings intact. Preferences can still change future targets.
- All cycling sessions support optional kilometres. New sessions start with unknown distance, never the previous ride's value. Known older morning distances are projected from their actual daily log. Cycling charts offer minutes/km; no missing distance is fabricated.
- The coach's five-day frequency flag uses main workouts, while actual cycling volume still participates in workload change checks. Non-cycling cardio uses non-cycling history. Setup/limitation conflicts block target acceptance with an explanation; no exercise is silently replaced. Targets can be accepted individually.
- Main workouts are available before noon through an explicit control; morning mode remains the default. Guided checkpoints retain exercise/set identity through plan changes. The technique library includes existing variations. Charts update the detail on focus as well as click.
- Ad-free in-app walkthroughs replace embedded third-party players. They use original simplified position diagrams and existing written instructions, work offline, and support manual steps/optional playback. They are not filmed demonstrations. Original provider videos remain external links, with an explicit note that those sites may show ads. No videos were downloaded or rehosted.

## Late-sync database migration — deployment action required

The frontend supports queued pre-midnight edits for seven days, with revision conflict handling and no general past-date editing. `standalone/setup/late-sync.sql` is additive and does not reset data. Run it once in the existing Supabase project's SQL Editor. The download is also exposed in Guide and at `setup/late-sync.sql` in the deployed bundle.

The RPC authenticates the user, confines writes to that account, checks the date/queue window and revision, serializes same-day late writes, and refuses loss of existing session/reward/rest IDs. The queue timestamp is client metadata, not cryptographic proof of when an offline event occurred. This is an integrity feature for personal logs, not an anti-cheat service. Imports and older edits remain under the existing explicit migration/backup flow.

This environment has no Supabase administration connection. The migration has been prepared and source-reviewed, **not applied or executed against the live database**. Missing-RPC responses preserve the device copy and explain the required update. Normal same-day syncing continues through the existing RPC.

## Validation and boundaries

Added `scripts/test-audit-fixes.mjs` for multi-session totals, active draft deduplication, recovery counts, metadata amendments and XP preservation, morning defaults/workload, full-ride km/corrections/backup, pending-queue eligibility/conflicts, setup constraints and ad-free demo contracts. Run alongside the six existing suites and TypeScript.

Real iPhone pointer interaction, actual offline browser relaunch, live multi-device authenticated syncing, external video availability and execution of the SQL migration are not verified here. Existing render/contract tests do not substitute for those checks. No user logs or credentials are used in testing. No travel mode or new RPG system was introduced.
