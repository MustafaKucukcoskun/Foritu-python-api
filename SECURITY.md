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

### Docker & Deployment
- Do NOT hardcode credentials in Dockerfile
- Use Docker secrets or environment variables at runtime
- Scan images for vulnerabilities

### Dependencies
- Keep dependencies updated
- Use `pip audit` to check for vulnerable packages

## Current Protections
✅ `.env` files excluded from git  
✅ `.env.example` provides safe template  
✅ No hardcoded credentials in Dockerfile  
✅ Secrets managed via environment variables
