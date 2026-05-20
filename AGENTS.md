# AGENTS: titan-research (Vault-Root Placement Anomaly)

## ⚠️ Open System Issue (flag for next chat in this subtree)

**Issue:** titan-research lives at the vault root (`/Users/brandonmcpeak/GitHub & Projects/titan-research/`), outside the `everything/` content container. The vault-root location is reserved for governance, config, and structural files per `/Users/brandonmcpeak/GitHub & Projects/AGENTS.md` "File placement policy" (no ad hoc files at root).

**Discovered:** 2026-05-20 (cross-repo traversal audit; handoff at `everything/resources/ai-operations-system/handoffs/HANDOFF_traversal-and-handoff-evolution_2026-05-20.md`).

**Context:** titan-research is the public-shareable Claude Code plugin carve-out, published as `brandonmcpeak/titan-research` on GitHub and installed via `/plugin marketplace add brandonmcpeak/titan-research`. The build pipeline for the public version landed it at the vault root, which Brandon flagged as an unintended outcome.

**Recommended action when next touching this subtree:**
1. Decide canonical home for the public-shareable carve-out. Candidate paths:
   - `~/GitHub & Projects/everything/resources/titan-research/` (most consistent with vault content taxonomy)
   - Outside the vault entirely (allowlist alongside `~/skill-forge` and `~/awesome-claude-skills` per `~/.claude/CLAUDE.md` Canonical Paths section)
2. Update the build/publish pipeline (the GitHub-publish capability in `everything/resources/ai-operations-system/`) so future carve-outs land at the chosen home, not the vault root.
3. Move the repo using `git mv` style operations so `.git` history is preserved. Update the GitHub remote URL if necessary.
4. Remove this flag once resolved.

## Scope (when resolved)

Once placement is corrected, this AGENTS.md (or its successor at the new location) should document:
- Public-shareable plugin discipline (LICENSE, CONTRIBUTING, semver per `STABILITY.md`)
- Cross-link to the build/publish pipeline that produced the carve-out
- Cross-link to the source skill in `everything/resources/ai-operations-system/`

## Inherited Governance

- Root safety and Git boundary controls: `/Users/brandonmcpeak/GitHub & Projects/AGENTS.md`
- Vault-wide content taxonomy: `/Users/brandonmcpeak/GitHub & Projects/everything/ARCHITECTURE.md`
- Cross-repo traversal map: `/Users/brandonmcpeak/GitHub & Projects/ARCHITECTURE.md` (Repository Map section; this anomaly should appear there until resolved)
