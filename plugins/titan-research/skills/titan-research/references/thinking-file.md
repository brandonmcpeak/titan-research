---
type: reference
skill: titan-research
module: thinking-file
phase: "Phase 0 (creation) through Phase 4 (completion)"
date: 2026-04-08
source: SYSTEM_MOD_thinking-file_v0.1_2025-12-19.md
---

# Thinking File: Claude's Reasoning Capture Protocol

External reasoning workspace that keeps the chat stream clean while preserving
Claude's meta-cognitive trail for audit and learning.

## When to Create

**Activate immediately when:**
- User requests research (any trigger phrase)
- Phase 0 begins
- This is the FIRST action, BEFORE brief creation

**Do NOT activate when:**
- Simple Q&A that doesn't need research
- Express mode with explicit "skip scaffolding"
- Continuing research in same session (append to existing file)

## File Naming

```
_THINKING_topic-kebab-case_v1_YYYY-MM-DD.md
```

- Prepend underscore sorts to top of directory
- Topic matches the corresponding BRIEF file
- v1 for first run; v2 for re-run from scratch; append for continuation

## File Location

Same directory as the brief: `resources/research/briefs/`

## WRITE-ONLY Rule

**Thinking files are never loaded back into context.**

- Claude writes to the thinking file but does not read it during the same session
- It is an artifact for Brandon (or future Claude) to review
- This prevents token explosion and recursive loading problems
- Enables transparent reasoning without performance cost

## Template

```markdown
---
type: THINKING_PROCESS
status: Active
version: 1.0
date: YYYY-MM-DD
associated_brief: BRIEF_topic_v1_date.md
associated_report: [filled after report created]
tags: [thinking-process, topic-keywords]
---

# Thinking Process Log: [Topic]

**Research Start:** [timestamp]
**Research End:** [filled at completion]
**Total Checkpoints:** [increments]

---

## Pre-Brief: First Impressions

**User's Request:** [exact phrase]

**What I think user actually needs:**
- [Interpretation of real underlying need]

**Possible blind spots in their framing:**
- [Blind spot I suspect]

**Initial Hypotheses:**
- H1: [working theory] — If true: [implication]. If false: [alternative].

**Research Strategy Gut Check:**
- Phase 1 approach (likely): [how I'll map problem space]
- Biggest risk: [what I'm most likely to get wrong]

---

## Checkpoint 1: Phase 1 Architect

**Key Insights:**
1. [Insight] — Confidence: [high/medium/low because X]

**Assumptions I'm Making:**
- [Assumption] — If wrong, this breaks: [consequence]

**Blind Spots Check:**
- What am I systematically missing?
- What would a domain expert flag?

---

## Checkpoint 2: Phase 2 Miner

**Triangulation Status:**
- [Claim]: triangulated / single source / conflicting

**Surprises & Pivots:**
- Expected X, found Y

**Updated Hypotheses:**
- Original: [from brief]. Current: [validated/refuted/revised]

---

## Checkpoint 3: Phase 3 Critic

**Pre-Mortem Red Team:**
- If this research is wrong, why?
- Data quality risk: [assessment]
- Selection bias risk: [assessment]

**Confidence Calibration:**
- Where am I overconfident?
- Where am I underconfident?

---

## Checkpoint 4: Phase 4 Synthesis

**NOW/NEXT/NEVER Decisions:**
- NOW: [immediate actions]
- NEXT: [queued after validation]
- NEVER: [anti-patterns to avoid]

**Meta-Learning:**
- What did this research teach me about research?
- What would I do differently next time?

---

## Final Summary

**Confidence in Final Output:** [%]
**Primary Risk Factor:** [what could make this wrong]
**Recommended Follow-Up:** [if any]
```

## When to Update

**Mandatory (at every phase transition):**
- Phase 0 → 1: Initial Analysis (after brief complete)
- Phase 1 → 2: Checkpoint 1
- Phase 2 → 3: Checkpoint 2
- Phase 3 → 4: Checkpoint 3
- Phase 4 complete: Checkpoint 4

**Optional (during phases):**
- After major insight discovered
- When assumption violated
- When significant pivot made

## What to Log vs. Skip

**Always log:** Assumptions, blind spot checks, confidence calibrations, red team
challenges, surprising findings, hypothesis updates.

**Skip:** Verbatim source content (link instead), redundant confirmations, generic
observations without specifics.

## Writing Style

Be candid: "I'm making a big assumption here that might be wrong."
Use questions: "What if the opposite were true?"
Be specific: Not "need to be careful" but "if assumption A is wrong, recommendation 1 breaks because B."

## Edge Cases

**Simple research:** Still create file. Keep checkpoints brief (1-2 sentences each).

**Research pivots midstream:** Add a PIVOT checkpoint between regular checkpoints.
Document what changed and why.

**Sequential research (chained):** Create NEW thinking file with incremented version.
Reference previous thinking file in Initial Analysis section.
