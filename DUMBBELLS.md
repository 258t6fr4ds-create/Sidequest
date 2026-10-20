# Dumbbell support — 20 October 2026

Equipment settings reflect four 1.5 kg and four 2.5 kg plates. The starting selection is one 1.5 kg plate at each end: 3 kg plates per dumbbell, with handle/collar weight unknown. A confirmed total is a distinct load basis; it is never inferred or converted automatically.

Choose the light dumbbell upper-body session in Workout before entering sets. It replaces the current unstarted strength plan with two sets each of floor press, supported row, curls and plank. Review setup and limitations with the coach. Manual exercise selection and confirmed substitutions also remain available. Normal and guided logging share the same weight control. Existing bodyweight schedules remain available.

## Data and compatibility

Optional Day.exerciseLoads selects future set weights. Day.setLoads captures actual weights alongside individual sets. Session.exercises[].loads preserves these in completed snapshots. Existing positive-set rep corrections retain the old load; explicit weight correction changes that set only and requires reconfirming completion. Recompletion keeps session ID and daily XP. Replay starts an empty draft and carries an initial selected weight; mixed original weights remain visible in the original record. No old weights or handle masses are fabricated.

Dumbbell preferences and load-pinned personal goals use existing timestamped preferences, account-scoped local backup and cloud JSON storage. Existing conflict handling retains distinct sessions and resolves competing versions of the same draft through the established flow. No SQL migration is required for these fields. Older builds must update before editing these records.

## Coaching and analytics

Coaching uses only comparable same-load sessions; mixed-load sessions do not trigger rep progression. Pain feedback still blocks the exercise across load changes. Setup, limitations, recent muscles and readiness remain in effect. The coach never changes weight automatically.

Charts filter by exact kg and basis, with unknown weights kept separate. Personal records compare known matching loads. Goals capture their load at creation. Lifetime totals explicitly combine loads; unweighted day/week performance highlights omit dumbbell comparisons. Rows use reps per arm rather than doubling or mixing them with bilateral reps. No weight or extra-volume XP is introduced.

Technique diagrams are original offline SVGs with written steps. They are simplified position guides, not filmed demonstrations. No new embedded video requests or advertisements.

## Verification

Run scripts/test-dumbbells.mjs plus the seven existing regression suites, TypeScript and the standalone production build. New tests cover mixed loads, rep edits, same-load charts/records/goals, per-arm counts, pain/setup checks, backup round trips, durable merges, replay and XP idempotence. UI tests are server renders and source contracts. Real-device iPhone, offline relaunch and authenticated multi-device sync require device QA; no real user records are used in tests.

The previously packaged late-sync.sql migration remains unapplied; this update does not alter that status.
