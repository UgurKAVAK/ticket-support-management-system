# Security Cleanup Notes

This repository was sanitized for a public portfolio demo.

Changed:
- Replaced visible product/company branding with `Ticket System Demo`.
- Replaced real domains with `ticketsystemdemo.local` demo domains.
- Replaced real email addresses with demo addresses such as `support@ticketsystemdemo.local`.
- Replaced database connection strings, SMTP/IMAP hosts, passwords, JWT signing keys, and client secrets with demo-only placeholders.
- Replaced company-specific mail headers with generic demo headers (`X-TSD-*`).
- Replaced local publish/user paths and obvious personal identifiers with demo values.
- Replaced logo PNG artwork with generic `Ticket System Demo` assets while preserving existing file names/import paths.
- Removed generated `.NET` `bin`, `obj`, and `.vs` caches that contained stale copied configuration or local machine paths.

Intentionally left unchanged:
- Existing namespaces, solution names, project names, and folder names, per the cleanup rules.

Important:
- The demo placeholder credentials are not production secrets and must be changed before any real deployment.
- Nested `.git` text metadata was sanitized where it was present, but git object history was not rewritten. Do not publish embedded `.git` directories unless history has been removed or rewritten separately.
