# Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in this repository, please email **security** concerns to **m.kucukcoskunn@gmail.com** instead of using the issue tracker.

## Security Best Practices

### Environment Variables
- **NEVER** commit `.env` files to the repository
- Use `.env.example` as a template for developers
- All sensitive data (API keys, tokens, URLs) must be in `.env` files only
- CI/CD systems should use secret management (GitHub Secrets, etc.)

### API Keys & Tokens
- Rotate Supabase keys regularly
- Use environment-specific keys when possible
- Monitor key usage for suspicious activity
- If a key is exposed, rotate it immediately from Supabase Dashboard before any code cleanup

### Docker & Deployment
- Do NOT hardcode credentials in Dockerfile
- Use Docker secrets or environment variables at runtime
- Scan images for vulnerabilities

## Credential Leak Incident Runbook

If credentials are committed, follow all steps below in order.

### 1) Rotate exposed Supabase credentials
1. Supabase Dashboard → **Settings** → **API**
2. Rotate/Revoke exposed keys
3. Update runtime secrets in deployment platform
4. Verify application can access Supabase with new values

### 2) Purge credentials from git history
Use one of the following approaches from a fresh mirror clone.

#### Option A: BFG Repo-Cleaner
```bash
git clone --mirror git@github.com:MustafaKucukcoskun/Foritu-python-api.git
cd Foritu-python-api.git
cat > secrets.txt <<'EOF'
kjoenbrfqxljeklnmbev
SUPABASE_KEY=
SUPABASE_URL=
EOF
bfg --replace-text secrets.txt
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force --all
git push --force --tags
```

#### Option B: git filter-branch
```bash
git clone --mirror git@github.com:MustafaKucukcoskun/Foritu-python-api.git
cd Foritu-python-api.git
git filter-branch --force --tree-filter \
'if [ -f Dockerfile ]; then
   sed -i "/SUPABASE_URL=/d;/SUPABASE_KEY=/d;/SUPABASE_BUCKET=/d" Dockerfile
 fi' --prune-empty --tag-name-filter cat -- --all
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force --all
git push --force --tags
```

### 3) Verify no credentials remain
```bash
git grep -n "kjoenbrfqxljeklnmbev\\|SUPABASE_KEY=\\|SUPABASE_URL=" $(git rev-list --all)
git log --all -S"kjoenbrfqxljeklnmbev" --oneline
git log --all -S"SUPABASE_KEY=" --oneline
git log --all -S"SUPABASE_URL=" --oneline
```
All commands above must return no matches.

### Dependencies
- Keep dependencies updated
- Use `pip audit` to check for vulnerable packages

## Current Protections
✅ `.env` files excluded from git  
✅ `.env.example` provides safe template  
✅ No hardcoded credentials in Dockerfile  
✅ Secrets managed via environment variables  
✅ Pre-commit secret scanning is configured
