# Sidequest fitness RPG expansion

## Use

Today keeps the current workout or morning ride first. Optional readiness (energy, soreness, sleep quality, motivation, notes) and the adaptive coach sit beside it. Choose an activity, recovery or flexible intention; recording recovery counts positively. Existing habits, food, sleep, water and quotes remain available.

Workout → Your session lets you customise exercises, 1–4 sets and per-set targets, report difficulty, optionally record session duration and label cycling. Enter actual results in the existing cards or guided workout. Completed snapshots are kept in addition to the daily working log. **New session** starts another workout after completion. An unfinished workout must be finished before a replay can replace its working fields. Replay is available in Progress → Calendar, preserves its original session, and retains previous results for comparison. The coach supplies optional recent-history targets. Normal workouts still open at noon Melbourne time.

Progress has Analytics, Calendar and Character sections. Charts provide date buttons with exact values, 7/30/90-day and all-time ranges, best sets, totals and set counts. Cycling is distinct from unlabelled cardio; per-leg counts and holds are never added to ordinary reps. Average duration uses only recorded durations. The existing summaries remain under “Original daily summaries, weekly wrap & history”; those continue to describe daily working logs.

Character progression starts with the existing Early Rider XP, unchanged, plus 40 XP for the first new completed workout or recovery session per date. Subsequent sessions award zero additional workout XP. A level is 100 XP; the prior app had no general character-level system. Morning target rewards stay capped at 25 XP per day. Attribute gains are also capped by date, rather than exercise volume. Titles, achievements, quest and encounter rewards are cosmetic. No existing XP or historical records are rewritten.

Questlines cover three activity/recovery days in a fortnight, cycling on two days in each of three weeks, three strength-practice days, and a seven-day activity/recovery run. The Iron Warden uses the prior four weeks to set 2–4 distinct activity/recovery days, a modest cycling target and a strength day. Low readiness eases objectives, never raises them. Completed rewards persist even if subsequent progress falls or a week is missed. Encounter opportunities are deterministic by date (roughly one in eight); extra sessions and refreshes cannot reroll them. Declining carries no penalty.

## Architecture and compatibility

- `lib/rpg/schema.ts`: additive optional `Day.sessions`, `readiness`, `training`, `adventure` schemas. The original daily fields and backup version 1 remain valid.
- `lib/rpg/sessions.ts`: compatibility projections, completion snapshots, replay preparation and conflict-safe session/reward unions.
- `lib/rpg/statistics.ts`: shared completed-session analytics, exercise series, comparable-period insights and unit-aware totals.
- `lib/rpg/coach.ts`: transparent suggestion rules. Two comfortable successful sessions on distinct days can suggest one extra rep/second; poor readiness, struggled targets, recent same-exercise training, frequency and workload increases prevent escalation. This is not a validated recovery measurement.
- `lib/rpg/progression.ts`: date-capped XP/attributes, achievement/quest ledger, frozen weekly boss targets and deterministic encounters.
- `app/rpg/`: compact calendar, analytics, coach, editable plan and character components.
- `useLocalLogs` captures completion and unlocks in one device transaction before the existing cloud revision save. No new service or database migration.

Historical sessions are projected at read time, without rewriting past days. Their missing occurrence/creation timestamps, durations, effort and XP allocation remain unknown. An archived legacy workout remains a legacy record when a new same-day session begins. New occurrence timestamps denote completion/logging time; optional duration is user reported, never inferred from a browser left open.

IDs deduplicate sessions; reward IDs deduplicate unlocks across reloads, sync and backup import. The original manual cloud conflict flow is retained. Resolving a conflict chooses the daily draft but unions completed session IDs and rewards from both copies; matching IDs use the chosen result with the highest earned XP. Distinct concurrent sessions survive. Persisted encounter acceptance/decline survives an older offered state. Existing server revision checks still prevent blind overwrites.

Safety bounds: at most 12 recorded sessions in a day and a conservative payload-size check beneath the existing 30 KB cloud JSON limit. Rejected edits leave the previous record untouched and show a message. Past-day edit locks, account-scoped local copies, explicit non-overwriting history import and pending offline records are retained. Offline records that miss midnight follow the pre-existing device-copy/history-import restriction; the app does not bypass server past-day locks.

Update all open devices to this version before editing the expanded records. Old app builds do not understand the new optional JSON fields. Downloadable backups include the expansion data automatically.

## Verification

Run:

```sh
node scripts/test-rpg.mjs
node scripts/test-rpg-ui.mjs
node scripts/test-mornings.mjs
node scripts/test-quotes.mjs
node node_modules/typescript/bin/tsc --noEmit --pretty false
node scripts/build-standalone.mjs
```

Tests cover legacy preservation, unknown timestamps, new replay IDs, same-day totals, duplicate completions, daily XP/attribute caps, progression/recovery rules, quest unlocks, boss reduction, encounter reload protection, backup round trips, cloud conflicts, acknowledgement of concurrent edits, date boundaries, UI server rendering, existing morning rules, quote rotation and the PWA/closed-overlay contracts.

Verification limits: server-render tests do not replace touch/browser testing. A supported local browser runner and a real iPhone are unavailable in this environment. No user account or live Supabase history was modified for testing. Physical home-screen launch, touch interaction, network-offline reload and actual multi-device Supabase synchronization remain device checks. Service-worker scope, precache, icons and manifest were retained.
