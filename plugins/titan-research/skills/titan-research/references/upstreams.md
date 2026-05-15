---
type: reference
skill: titan-research
module: upstreams
phase: "Cross-cutting — periodically reviewed for incorporation opportunities"
date: 2026-05-13
note: >
  Durable register of external systems, methodologies, and prior art that
  inform or could inform titan-research. Some entries are tracked-only;
  some are partially incorporated; some have been evaluated and passed on.
  Re-evaluate at each major skill version.
---

# Upstreams: External Systems & Prior Art

Tracks external research systems, methodologies, and adjacent prior art that
inform titan-research's design — whether or not they are currently incorporated.
The purpose is durable evaluation memory: a future skill maintainer (human or
agent) should be able to read this file and understand what we have looked at,
what we adopted, what we passed on, and why.

## Status Legend

| Status | Meaning |
|---|---|
| `incorporated` | One or more concepts from this upstream are encoded in titan-research's skill files. The "what's applicable" column names which. |
| `tracked` | Evaluated, found relevant, but not currently incorporated. Re-evaluate at next major skill version. |
| `passed` | Evaluated and judged not-applicable. Recorded so we don't re-evaluate the same upstream blindly in future. |
| `monitoring` | Watching for changes; not yet evaluated in detail. |

## Convention for Other Skills

This file's pattern (`references/upstreams.md` with this table shape) is
proposed as a cross-skill convention. Skill-forge, copy-writer, doppelganger,
and other skills that benefit from durable prior-art tracking should adopt
the same structure. Naming consistency aids cross-skill maintenance.

## Register

| Source | URLs | License | Status | Last evaluated | What's applicable | What's not |
|---|---|---|---|---|---|---|
| Feynman (AI research agent) | https://www.feynman.is/ ; https://github.com/companion-inc/feynman | MIT | `tracked` (partial-incorporated: Verifier sub-agent pattern → see `multi-phase-protocol.md` Standalone-Readability Lens) | 2026-05-13 | (a) Role-based agent specialization (Researcher → Reviewer → Writer → Verifier) as a layer on top of topic-based pillar allocation; (b) Verifier-as-sub-agent pattern for runtime citation/quality enforcement (partially adopted in Change 9, 2026-05-13); (c) Slash-command workflow library (/lit /audit /replicate as composable skills) — pattern suggestive for future /titan-lit, /titan-audit decomposition. | Tooling stack (AlphaXiv paper search, HuggingFace Hub, Docker/Modal/RunPod GPU providers) — scientific-experimental tooling out of scope for titan-research's "decision-ready intelligence" framing. |

## Re-Evaluation Cadence

Review this register:
- At each major version bump of titan-research (currently v2.0)
- When a tracked upstream releases a major version itself
- When a new run surfaces a discipline gap that an upstream may already have solved

## Adding an Entry

When evaluating a new external system, add a row with:
1. **Source name + URLs** (canonical landing page + repo/docs if open source)
2. **License** — must support reading + concept adoption; if proprietary, note any concept-attribution requirements
3. **Status** — initial entry usually `monitoring` or `tracked`; never `incorporated` without an actual encoded reference in another skill file
4. **Last evaluated date** — ISO 8601
5. **What's applicable** — concrete concepts, primitives, or patterns. If `incorporated`, name the specific skill file where the concept lives.
6. **What's not** — explicit non-applicable scope. Useful so future evaluation knows what NOT to re-investigate.

A brief evaluation memo (1-2 pages, in `_workspace/` of the calling project)
should accompany the first entry. Subsequent re-evaluations append to that
memo with date stamps.
