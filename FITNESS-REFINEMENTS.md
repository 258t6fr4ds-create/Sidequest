# Fitness refinement and Operation: Defusal

## Activity classification

`lib/activity.ts` is the shared classification boundary: `morning-cycle`, `main-workout`, `recovery`. New sessions explicitly store it; older sessions resolve from their source and the dedicated `morning:YYYY-MM-DD` identifier. No historical rows are rewritten. A full cycling workout remains a main workout when recorded through the regular workout flow.

Morning rides do not complete the main workout, inflate main-workout counts, satisfy main-training consistency, or supply the baseline for a full cycling workout recommendation. They retain Early Rider XP, cycling minutes, cycling achievements, cycling-habit goals and relevant activity quests. The pre-existing custom activity-day quests explicitly include morning rides; main workout goals explicitly exclude them. Already-earned achievement/quest ledgers remain intact. Correcting a ride to zero updates activity totals without revoking previously earned XP.

Today displays morning and main activity independently. Calendar preserves both classifications. Main-workout duration averages exclude supplementary morning rides. Intentional rest can support plan adherence without being mislabelled as a main workout.

## Existing fitness tools refined

- Muscle metadata identifies primary/secondary groups for all current exercises and is stored with new session snapshots. History prefers stored metadata, with catalogue-based interpretation for older records. Seven-day set exposure and the last training date appear inside the existing coach/analytics; frequent exposure and gaps are prompts to review the plan, not recovery diagnoses.
- The existing variation control now offers confirmed substitutions matching movement intent and a primary muscle group. Saved filters cover available supports, difficulty and load/balance preferences. No automatic swap occurs. Previous sets retain their original exercise ID, and the alternative begins with its own conservative target. Unsuitable-filter results offer skipping, not a fabricated safe substitute.
- Easy/moderate/difficult feedback is retained with optional pain/discomfort feedback. Feedback supplied after completion updates that session's effort without adding a session or XP. Pain blocks accepting progression suggestions for the affected exercise. The guide offers alternatives without promising they are pain-free.
- Existing instruction overlays and video components are retained. Technique notes add common mistakes, easier/harder options, muscle labels and safety considerations. No new video URLs or paid dependencies were introduced.
- Personal training goals live inside Progress → Analytics. Up to five goals use real best sets, rolling-seven-day cycling days or rolling-seven-day main workout days. Repetition and timed exercises remain separate. The coach uses exercise goals as a modest ceiling on progression, not a command to jump to the final target. Goals carry no new rewards or currencies.

## Rest-day protocol

The explicit Declare a rest day button, a recovery intention, choosing a recovery session, or explicitly completing a previously scheduled recovery day starts the protocol. Merely opening a scheduled rest day does not arm a device. Declaring rest leaves working sets, notes, previous completions, morning data and session records untouched. Main tracking controls are gated while the current declaration is active; food, settings, recovery check-ins and historical review remain usable.

Every device has an absolute declaration and expiration timestamp, with exactly two hours between them. No background JavaScript is required. The UI reconstructs remaining time on mount, foregrounding and each visible tick. Dates use the existing Australia/Melbourne training-day boundary (the user's local timezone), rather than a UTC date slice, preserving the existing cloud day locks.

The optional minigame has eight tested configurations: match a named colour/symbol, complete an explicitly defined number sequence, then hold DEFUSE for three seconds. Labels make colour recognition unnecessary. Keyboard Space/Enter supports the hold; release, pointer cancellation, blur, backgrounding, expiry and a changed protocol cancel it. A changed declaration ID rejects stale gameplay actions.

Wrong answers have no penalty or added delay. A persistent Skip minigame & log activity option is always available. Expiry shows cartoon confetti and an instant cleanup action, preserves rest, and never damages data. Both clearing routes leave workout completion unchanged. Reduced motion disables animated lights/confetti; ticking is off by default, requires user interaction to start audio, stops offscreen and respects the existing sound preference.

Complete rest day records a separate recovery session. Its ID is fixed per date, so re-arming/completing repeatedly cannot create more recovery sessions or XP. Existing 40/day workout/recovery and 25/day morning reward caps remain. Defusal, skipping, declaring and expiry award nothing. Original declarations remain in the calendar even after a change of plans. A declaration alone can support intentional-rest adherence, but never counts as a completed workout or receives completion XP.

## Storage and conflicts

Optional `Day.restProtocols` and additive exercise/session/preference fields use the existing JSON backup, account-scoped device copy and revision-controlled Supabase row. No SQL change is needed. One unresolved protocol is presented at a time; re-arming creates a new generation only after clearing the previous device. A bound of 12 declarations per date prevents unbounded payload growth without preventing normal logging.

Protocol IDs are deterministic per training date/generation. Concurrent declarations of the same generation converge on the earliest declaration and its puzzle, with a deterministic tie-break. Puzzle progress is monotonic only for matching configurations. Terminal clearing and recovery-completion events survive stale copies, and the original expiration is never extended by refresh or merge. A newer generation remains distinct from a stale action against an older device. The existing cloud conflict dialog still requires choosing a daily draft; its merge preserves both completed-session and protocol histories. No rewards are removed by that choice.

Update all devices before editing the new fields. Existing old-day locks and the restriction on syncing edits after midnight remain unchanged. Offline device copies and backups still retain those records. Payload-limit failures retain the previous saved state and show an error.

## Verification

Automated gates:

```sh
node scripts/test-refinements.mjs
node scripts/test-refinement-ui.mjs
node scripts/test-rpg.mjs
node scripts/test-rpg-ui.mjs
node scripts/test-mornings.mjs
node scripts/test-quotes.mjs
node node_modules/typescript/bin/tsc --noEmit --pretty false
node scripts/build-standalone.mjs
```

Tests cover explicit/legacy activity classification, main and cycling statistics, retained XP, full cycling workouts, rest-day routing/gating, all puzzle answers, wrong attempts, minimum hold duration, absolute-time reconstruction, expiry/skip, unchanged workout drafts, repeated declarations/recovery completion, concurrent canonical timers, stale action IDs, cloud-compatible serialization, backups, muscle/effort records, substitution filters, goals, every minigame screen and full tracker server rendering. Existing quote, morning, progression, overlay cleanup and PWA-contract tests also pass.

Limits: server rendering and state-machine tests do not prove physical touch/keyboard interactions. A real iPhone and supported local browser runner are unavailable. Actual iPhone home-screen behavior, live authenticated multi-device sync and network-offline browser relaunch remain device checks. User logs and private cloud credentials were not used in tests.
