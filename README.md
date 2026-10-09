# Sidequest — independent app

This is the ready-to-upload app. It does not need ChatGPT, ChatGPT Plus, a developer subscription, a database, a build command or an API key. Use the files in this package, not the original Sites source project.

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

The app interface and its code are public. Your logs are created inside your browser on your device and are not uploaded to GitHub. The package contains no existing logs, account IDs, credentials or cloud database. Anyone opening the public app gets their own local data.

If GitHub skips the hidden `.nojekyll` file during upload, you can create a file named `.nojekyll` at the repository root using **Add file → Create new file**, then commit it.

## 3. Install it on your iPhone and move your logs

1. Open your new GitHub Pages URL in Safari while online.
2. Choose **Share → Add to Home Screen**, keep **Open as Web App** enabled if shown, and tap **Add**.
3. Open the new Home Screen icon while online. In **Guide**, wait for **Offline ready**. The first visit downloads the app files. Repeat this online setup in the installed app even if Safari was already opened.
4. Inside that installed app, open **Guide → Import backup** and select the JSON backup you downloaded earlier. Import adds missing dates; it never overwrites existing dates or imports future dates. If you already created today's log on the new app, it is kept rather than replaced by the backup.
5. Check a few older logs in Progress. Export another backup from the installed app and save it in Files. You can now use this version without ChatGPT or Plus.
6. To verify offline access on your actual phone, close the app, turn on Airplane Mode, reopen it, and check that your logs load. If it does not reopen, go online, revisit Guide and wait for Offline ready before trying again.

The old and new Home Screen shortcuts are separate apps. Safari and the installed app may also have separate device storage. Import your backup in the app you intend to use. Removing a shortcut or clearing website data may remove its local records.

## Saving and day locks

- Edits save immediately on this device. Check the bottom bar for **Saved on this device**.
- This independent version has **no automatic cloud sync**. Keep regular JSON backups in Files or iCloud Drive and import them on another device when needed. iCloud Drive stores the backup file; it does not automatically synchronize the app's records.
- Only today is editable, with midnight defined in **Australia/Melbourne**. Other days are viewable but locked.
- Without a server, the day lock uses your device's clock. Changing the clock can defeat a purely local lock; the Sites version still validates saves using its server clock.
- Web quotes are fetched from DummyJSON when available, cached locally, and shuffled without repeats until the available collection is exhausted. The provider's author attribution is shown as supplied. If the feed is unavailable, cached quotes or the smaller built-in collection remain available. No quotation database is literally infinite.
- Your logs are never sent to the quote service. Fresh web quotes require internet; the rest of the installed app can work offline after its files have been cached.

## Later updates

GitHub does not automatically receive changes made to the ChatGPT Sites version. Upload a new independent build to the same repository, preserving the **assets** folder structure, then commit. Export your logs first. Wait for GitHub Pages to publish, visit while online, then close every open copy of this app and reopen it so the updated offline files can activate. Keep the same site address; browser storage belongs to that address. A new address needs an export/import transfer.

Do not delete old hashed files in **assets** during an update: an already-open older app may still use them. No secrets or personal backups should be committed to this public repository.

## Troubleshooting

- **404:** check Settings → Pages is main / root and index.html is at repository root, not inside an extra folder. Wait for the deployment in the Actions tab to finish.
- **Blank page:** confirm the assets folder was uploaded with its files inside, then use the full URL ending in /sidequest/.
- **No old logs:** return to the old Sidequest app and download its backup, then import it inside the new Home Screen app.
- **Device save failed:** export a backup before closing; browser storage may be blocked or full.
- **Old version after update:** open online, close all tabs and the Home Screen app, then reopen. Do not clear website data unless you have a backup.

## Official references

- GitHub Pages creation and free/public-repository requirements: https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site
- GitHub Pages branch publishing: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site
- iPhone Home Screen installation: https://support.apple.com/en-au/guide/iphone/iphea86e5236/ios
- Web quote feed: https://dummyjson.com/docs/quotes

Prepared 9 October 2026. Tested with production builds and storage/backup checks; physical iPhone offline installation still needs the check in step 6 above.
