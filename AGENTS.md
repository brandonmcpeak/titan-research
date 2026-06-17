# AGENTS: titan-research

## What this is

The public-shareable Claude Code plugin carve-out of the Titan deep-research system, published as `brandonmcpeak/titan-research` on GitHub and installed via `/plugin marketplace add brandonmcpeak/titan-research`.

This repo keeps its own `.git` and GitHub remote. On disk it lives under the AI Operations System's publishing location:

```
everything/resources/ai-operations-system/published/titan-research/
```

per the `published/` on-disk convention (a sibling of `published/prometheus-forge/`). The parent build repo ignores `published/` wholesale so the nested repo cannot foot-gun the parent's index.

> **Placement history (resolved):** This carve-out previously lived at the vault root (`/Users/brandonmcpeak/GitHub & Projects/titan-research/`), flagged as a file-placement anomaly on 2026-05-20. Relocated to the `published/` home on 2026-06-16; the parent `.gitignore` nested-repo boundary and the vault-root `ARCHITECTURE.md` map were updated at the same time. The GitHub remote and `/plugin marketplace` install path are unaffected by the local move.

## Scope

- **Public-shareable plugin discipline** — `LICENSE`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, and semver per `STABILITY.md`. Treat this repo as an external-facing artifact: no private vault paths, client data, or internal-only references in committed content.
- **Source of truth** — the source skill lives in the AI Operations System at `everything/resources/ai-operations-system/` (and is deployed to `~/.claude/skills/titan-research/`). This published repo is a carve-out of that source, produced by the build/publish pipeline. Changes to research behavior flow source → carve-out, not the reverse.

## Inherited Governance

- Root safety and Git boundary controls: `/Users/brandonmcpeak/GitHub & Projects/AGENTS.md`
- Vault-wide content taxonomy: `/Users/brandonmcpeak/GitHub & Projects/everything/ARCHITECTURE.md`
- Cross-repo traversal map: `/Users/brandonmcpeak/GitHub & Projects/ARCHITECTURE.md` (Repository Map section)
