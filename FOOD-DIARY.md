# Sidequest Kitchen — 22 October 2026

The approved update is a food library and meal diary, without calorie totals, intake targets, macro targets, weight controls, food scores or meal streak rewards.

## Catalogue and use

Food now contains 282 entries across eight categories: rice/breads/breakfast; protein preparations; vegetarian curries and sides; meat/seafood curries; rice dishes/meals; snacks/sweets; everyday foods; drinks. Search includes common transliterations and selected Malayalam names. This is an extensible catalogue, not an exhaustive list of every regional or household recipe.

Every entry has an original symbolic SVG illustration. These use a set of dish shapes and colour variations; they are not photographs or serving-size guides. No image network requests, external image APIs or new subscriptions are needed. Short descriptions are original common-ingredient summaries, not recipes or allergen guarantees. Names and regional context were checked against Kerala Tourism's vegetarian dishes and Malabar cuisine pages, linked in Food.

Choose breakfast, lunch, snacks or dinner, then a food. Its name, category, ingredients, cooking method, accompaniments and illustration can be changed before adding it. Existing entries can be edited, moved or removed with an undo option. Recent foods open for review before being repeated. Favourites (up to 200) and custom recipes (up to 20) use timestamped preferences. Recipe changes never rewrite previously logged meals. Capacity is bounded by the existing 29 KB day guard; a rejected meal save leaves the editor open.

## Compatibility and storage

Original Day.meals text is untouched and displayed under the corresponding meal. No inference or automatic conversion is performed. The optional foodDiary field holds item IDs, a dish snapshot, meal slot, preparation, changes, createdAt and updatedAt. The diary allows up to 60 records including removed entries. Date editing follows existing Melbourne day locks; browsing past meals remains available.

Entries merge by stable ID. A removal is a timestamped tombstone; stale copies cannot restore it during durable conflict merge. Newer edits win, with a deterministic tie-breaker favouring removal. Both local patches and the existing conflict-resolution flow merge diary items. The global undo action records a fresh diary edit, including removal tombstones when undoing an addition, so it survives later conflict resolution. Undoing a diary edit clears older undo history to avoid applying an obsolete state.

Food does not modify workout completion, morning cycling, XP, quests, achievements or rest protocols. Normal JSON backups include the diary and preferences. New JSON fields use the existing cloud transport; no new SQL migration is required. Update older app instances before editing new-format records. Existing account-scoped conflict review and storage failure messages remain in effect. The prior seven-day late-sync SQL migration remains unapplied.

## Personal photos

Optional JPG/PNG/WebP uploads up to 8 MB are resized to a maximum dimension of 640 pixels and stored as JPEG data in an account-scoped IndexedDB store. Diary JSON contains only a photo key. Photos do not sync to Supabase and are not included in the regular log backup. Missing photos fall back to illustrations, including on another device.

Food's catalogue-notes panel provides a separate photo JSON export/import; restore adds missing photos only and never overwrites an existing key. The regular log backup is also needed when transferring meals. Imports validate image data URLs and file size, and are limited to 25 MB / 500 images. Clearing browser data can remove device photos. Source code and the deployment never include personal photos or real diary data.

## Verification

New gate: node scripts/test-food.mjs. Covers 282 unique schema-valid foods, names/aliases/Malayalam searches, all SVG renderings, meal add/edit/move/remove/undo, duplicate IDs, merge idempotence and removal retention, repeated-item IDs, retained free-text notes, JSON backup restore, unchanged XP, rest-day compatibility, bounded 24-card rendering, read-only past dates and rejected malformed photo backups.

Run alongside the eight existing suites (audit fixes, refinements, refinement UI, RPG, RPG UI, mornings, quotes and dumbbells), TypeScript and the standalone production build. Browser preview origin approval was denied, so no alternate browser path was attempted. Visual layout, real iPhone interactions, browser photo upload/restore, offline relaunch and authenticated multi-device syncing remain unverified. Tests use synthetic data only.
