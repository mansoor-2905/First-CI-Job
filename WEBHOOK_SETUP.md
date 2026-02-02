# GitHub Webhook Setup Guide

Complete guide to enable automatic builds in Jenkins when you push code to GitHub.

## Prerequisites
- Jenkins server accessible from the internet (or GitHub can reach it)
- Admin access to your GitHub repository
- Jenkins job already created

---

## Part 1: Configure Jenkins

### Step 1: Install GitHub Integration Plugin

1. Go to **Jenkins Dashboard** → **Manage Jenkins** → **Manage Plugins**
2. Click **Available** tab
3. Search for: **GitHub Integration Plugin**
4. Check the box and click **Install without restart**

### Step 2: Configure Jenkins System Settings

1. Go to **Dashboard** → **Manage Jenkins** → **Configure System**
2. Find the **Jenkins Location** section
3. Set **Jenkins URL** to your server's public URL:
   ```
   http://your-public-ip-or-domain:8080/
   ```
4. Click **Save**

### Step 3: Configure Your Pipeline Job

1. Go to your Jenkins job: **First-CI-Job**
2. Click **Configure**
3. Under **Build Triggers** section:
   - ✅ Check **"GitHub hook trigger for GITScm polling"**
4. Click **Save**

---

## Part 2: Configure GitHub Webhook

### Step 1: Go to Repository Settings

1. Open your GitHub repository: https://github.com/mansoor-2905/First-CI-Job
2. Click **Settings** (top right)
3. In left sidebar, click **Webhooks**
4. Click **Add webhook**

### Step 2: Configure Webhook

Enter the following settings:

- **Payload URL:** 
  ```
  http://your-jenkins-server-ip:8080/github-webhook/
  ```
  ⚠️ **Important:** Don't forget the trailing slash `/`

- **Content type:** 
  ```
  application/json
  ```

- **Secret:** Leave blank (or add one for extra security)

- **Which events would you like to trigger this webhook?**
  - ✅ Select **"Just the push event"**

- **Active:** 
  - ✅ Make sure this is checked

Click **Add webhook**

### Step 3: Verify Webhook

After creating the webhook, GitHub will send a test ping. You should see:
- ✅ Green checkmark next to the webhook
- Recent delivery shows a `200` response

---

## Part 3: Test the Webhook

### Method 1: Make a Small Change

```bash
# On your local machine
cd "d:\Mansoor Projects\CI-project"

# Make a small change to README
echo "" >> README.md
echo "Testing webhook automation" >> README.md

# Commit and push
git add README.md
git commit -m "Test webhook trigger"
git push origin main
```

### Method 2: Redeliver from GitHub

1. Go to **GitHub → Settings → Webhooks**
2. Click on your webhook
3. Scroll to **Recent Deliveries**
4. Click **Redeliver** on the ping event

---

## Verification

After pushing code, you should see:
1. ✅ Jenkins automatically starts a new build
2. ✅ Build appears in Jenkins job history
3. ✅ No need to click "Build Now"

---

## Troubleshooting

### Webhook Shows Red X (Failed)

**Problem:** Jenkins server not reachable from GitHub

**Solutions:**
1. **Check firewall:** Ensure port 8080 is open
2. **Use ngrok for testing:**
   ```bash
   # On your Jenkins server
   ngrok http 8080
   ```
   Then use the ngrok URL in webhook: `https://xxxxx.ngrok.io/github-webhook/`
3. **Check Jenkins URL:** Must be publicly accessible

### Builds Not Triggering

**Check:**
1. Webhook is **Active** (green checkmark)
2. Jenkins job has **"GitHub hook trigger for GITScm polling"** enabled
3. Recent Deliveries show **200 OK** response

### Permission Denied

**Solution:**
1. Go to **Manage Jenkins** → **Configure Global Security**
2. Under **Authorization**, temporarily enable **"Allow anonymous read access"**
3. Or add a GitHub API token in Jenkins credentials

---

## Security Enhancement (Optional)

### Add Webhook Secret

1. Generate a secret token:
   ```bash
   openssl rand -hex 20
   ```

2. **In GitHub webhook:** Add secret to **Secret** field

3. **In Jenkins:**
   - Go to **Manage Jenkins** → **Configure System**
   - Find **GitHub** section
   - Add **GitHub Server** with secret configured

---

## Next Steps

Once webhooks are working:
✅ Every `git push` triggers a build automatically
✅ Pull requests can trigger builds (configure separately)
✅ You have true Continuous Integration!

---

**URLs to Remember:**
- Jenkins webhook endpoint: `http://your-jenkins-ip:8080/github-webhook/`
- GitHub webhook settings: https://github.com/mansoor-2905/First-CI-Job/settings/hooks
