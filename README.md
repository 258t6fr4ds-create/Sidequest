# Sidequest — independent app

This is the ready-to-upload app, now the primary Sidequest version. It does not need ChatGPT or Plus. Device-only mode works immediately; optional cloud sync needs your own Supabase project. Use this package, not the original Sites source project.

## 1. Save your existing logs first

In the existing Sidequest app, open **Guide → Your data & backups → Download backup**. Save the JSON file privately in Files or iCloud Drive. Do not upload it to GitHub. This backup contains your personal workout and meal data.

## 2. Publish with GitHub Pages (free)

A computer is easiest for uploading the folder structure.

1. Sign in at https://github.com (create a free account if needed).
2. Create a new repository named **sidequest**. Choose **Public**, enable **Add README**, then create it. GitHub Free provides Pages for public repositories.
3. Extract this ZIP on your computer. Open the extracted folder containing **index.html**, **assets**, **sw.js** and the icon files.
4. In the repository, choose **Add file → Upload files**. Drag all the extracted contents into the upload area, including the **assets** folder. Do not upload the ZIP itself or a wrapper folder. Choose **Commit changes**. The repository's top level must contain **index.html** and **assets/**.
5. Open **Settings → Pages**. Under **Build and deployment**, choose **Deploy from a branch**. Select **main**, then **/(root)**, and **Save**.
6. Wait for publication; GitHub says this can take up to 10 minutes. On the same Pages settings screen, choose **Visit site**. Its address will normally be **https://YOUR-USERNAME.github.io/sidequest/**. Keep the trailing slash.

The app interface and its code are public. Your logs are created inside your browser on your device and are not uploaded to GitHub. The package contains no existing logs, account IDs, passwords or private keys. The SQL setup script creates your cloud tables when you run it in your own project. Anyone opening the public app gets their own local data.

If GitHub skips the hidden `.nojekyll` file during upload, you can create a file named `.nojekyll` at the repository root using **Add file → Create new file**, then commit it.

## 3. Install it on your iPhone and move your logs

1. Open your new GitHub Pages URL in Safari while online.
2. Choose **Share → Add to Home Screen**, keep **Open as Web App** enabled if shown, and tap **Add**.
3. Open the new Home Screen icon while online. In **Guide**, wait for **Offline ready**. The first visit downloads the app files. Repeat this online setup in the installed app even if Safari was already opened.
4. Inside that installed app, open **Guide → Import backup** and select the JSON backup you downloaded earlier. Import adds missing dates; it never overwrites existing dates or imports future dates. If you already created today's log on the new app, it is kept rather than replaced by the backup.
5. Check a few older logs in Progress. Export another backup from the installed app and save it in Files. You can now use this version without ChatGPT or Plus.
6. To verify offline access on your actual phone, close the app, turn on Airplane Mode, reopen it, and check that your logs load. If it does not reopen, go online, revisit Guide and wait for Offline ready before trying again.

The old Sites and new GitHub Home Screen shortcuts are separate apps. Safari and the installed app may also have separate device storage. Import your backup in the app you intend to use. Removing a shortcut or clearing website data may remove its local records.

## 4. Enable independent cloud sync

1. Create a project at https://supabase.com/dashboard using the **Free** plan if it suits you. Choose an Australian region if available. Keep the database password private; it is not your app password.
2. In the project, open **SQL Editor → New query**. Open **setup/supabase.sql** from this package, copy its entire contents into the editor, and **Run**. This creates private per-user tables and the sync functions. Do not skip this step: the frontend alone cannot provision a cloud database.
3. Under **Authentication → Users → Add user → Create new user**, create your own app login using your email and a strong, unique app password. Confirm your own account using the offered **Auto Confirm User** option. You are creating your own account as this project's administrator; you do not need a public signup flow or email service. If dashboard labels differ, use its Users page to create a confirmed email/password user. For this personal app, turn off new public user signups after creating your account. Do not turn off database row-level security.
4. Get the **Project URL** (https://your-project.supabase.co) from the project's Connect dialog or API settings, and the **publishable key** from **Settings → API Keys**. A legacy **anon** key also works. Never use a secret key, service_role key or database password in this app, in GitHub, or in chat. Publishable keys are designed to be public; the database's account checks protect your logs.
5. Upload this updated app package to the same GitHub Pages repository and URL. Open the app online and expand **Cloud sync** at the top. Enter the Project URL and publishable key, then **Connect project**.
6. Before signing in, use **Guide → Download backup** to save any device-only logs. Then sign in with the **app login from step 3**, not your GitHub/Supabase dashboard/ChatGPT password. Account copies are kept separate; an empty history immediately after first sign-in does not delete your device-only logs.
7. Inside the signed-in app, choose **Guide → Import backup**. Today's imported log syncs normally. To move old logs too, import your complete history and then choose **Upload imported history once**. This one-time migration only adds missing past dates and cannot overwrite existing records. After migration, old dates stay locked.
8. To avoid entering project settings on every device, click **Download public project settings** in the Cloud sync panel. Upload that **cloud-config.json** file to the root of the GitHub repository and commit it. This file contains only the public project URL and publishable key. Keep personal backup files private.
9. Open the same GitHub Pages address on another device, sign in to the same app account, and check that its saved logs appear. A visible open app checks for cloud changes about every 30 seconds, on focus/reconnection, or via **Guide → Check cloud**. This is not background sync after the app closes.

Free Supabase projects currently pause after one week of inactivity and have plan limits. If paused, resume the project in the Supabase dashboard. Device saving continues while offline; keep JSON backups too. Current pricing: https://supabase.com/pricing

## Icon still showing the old image?

The Home Screen can retain its installation-time icon. This release also changes the icon asset URLs. Download a backup first, then close all copies of Sidequest, remove the old Home Screen shortcut, open the current GitHub Pages address in Safari online and add it again. Open the new icon, reconnect/sign in if needed, and check your logs before removing the backup. Safari and the installed app may keep separate local storage. The old Sites shortcut and new GitHub shortcut are different installations.

## Saving and day locks

- Edits save immediately on this device. Check the bottom bar for **Saved on this device**.
- With Cloud sync configured and signed in, today's changes sync automatically while the app is open and online. Without sign-in, it remains device-only. Keep regular JSON backups in Files/iCloud Drive too; storing a file there does not itself synchronize the app.
- Only today is editable, with midnight defined in **Australia/Melbourne**. Other days are viewable but locked.
- Cloud saves enforce the day lock with the database clock. Device-only/offline editing uses the available local clock; it cannot make the cloud accept changes to past or future days. Apart from the explicit one-time history migration, past logs that missed midnight stay device-only.
- Web quotes are fetched from DummyJSON when available, cached locally, and shuffled without repeats until the available collection is exhausted. The provider's author attribution is shown as supplied. If the feed is unavailable, cached quotes or the smaller built-in collection remain available. No quotation database is literally infinite.
- Your logs are never sent to the quote service. Fresh web quotes require internet; the rest of the installed app can work offline after its files have been cached.

## Later updates

GitHub does not automatically receive changes made to the ChatGPT Sites version. Upload a new independent build to the same repository, preserving the **assets** folder structure, then commit. Export your logs first. Wait for GitHub Pages to publish, visit while online, then close every open copy of this app and reopen it so the updated offline files can activate. Keep the same site address; browser storage belongs to that address. A new address needs an export/import transfer.

Do not delete old hashed files in **assets** during an update: an already-open older app may still use them. No secrets or personal backups should be committed to this public repository.

## Troubleshooting

- **404:** check Settings → Pages is main / root and index.html is at repository root, not inside an extra folder. Wait for the deployment in the Actions tab to finish.
- **Blank page:** confirm the assets folder was uploaded with its files inside, then use the full URL ending in /sidequest/.
- **Cloud setup failed:** confirm the SQL script completed in the same project as your URL/key, and that your app user exists. Use the publishable key, not a secret.
- **Cloud session expired:** sign out and sign in again. The device copy remains saved.
- **No old logs:** return to the old Sidequest app and download its backup, then import it inside the new Home Screen app.
- **Device save failed:** export a backup before closing; browser storage may be blocked or full.
- **Old version after update:** open online, close all tabs and the Home Screen app, then reopen. Do not clear website data unless you have a backup.

## Official references

- GitHub Pages creation and free/public-repository requirements: https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site
- GitHub Pages branch publishing: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site
- iPhone Home Screen installation: https://support.apple.com/en-au/guide/iphone/iphea86e5236/ios
- Web quote feed: https://dummyjson.com/docs/quotes

Prepared 9 October 2026. The client build, authentication request/refresh flow with simulated responses, local data handling and offline cache have been checked. A real Supabase project and GitHub repository have not been connected in this session: live database setup and end-to-end sync must be verified with your project using step 9. Physical iPhone offline installation still needs the check in step 6 above.

Supabase security references: https://supabase.com/docs/guides/getting-started/api-keys and https://supabase.com/docs/guides/database/postgres/row-level-security

## Fitness RPG expansion

Progress now includes Analytics, Calendar/replay and Character. Today offers optional readiness check-ins and conservative coaching. Workout → Your session customises targets and starts additional sessions. New completion XP is capped at 40 per date; the existing morning badge remains 25. Recovery counts positively. Questlines, the weekly Iron Warden and occasional encounters provide cosmetic rewards.

All expansion data uses the existing device backup and cloud sync. No new SQL setup is needed. Update Sidequest on all devices before editing new records. Historical missing timestamps and durations stay unknown. The current working log and completed session snapshots are retained separately; use New session or calendar replay to create another workout. Past-day locks and the existing offline-history restrictions remain unchanged.

## Morning separation and Operation: Defusal

Today now displays morning cycling and main workouts independently. Morning rides retain cycling XP and relevant goals but do not count as the main workout. Personal targets are in Progress → Analytics; muscle history, substitutions and pain feedback extend the existing exercise tools.

Declare a rest day to activate the optional fictional two-hour device. Its countdown and puzzle progress persist. Match a labelled wire, solve a short sequence and hold DEFUSE—or use Skip minigame at any time. Expired devices have an instant cleanup button. Neither gameplay nor timer expiry changes XP or fabricates workouts. Complete rest day records recovery at most once per date. All earlier workout entries remain intact.

See FITNESS-REFINEMENTS.md for storage, behavior and verification details. Update all devices before using the new saved fields; no database migration is required.
