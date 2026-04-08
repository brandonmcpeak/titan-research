---
type: reference
skill: titan-research
module: sequential-chaining
phase: "Post-research (after Phase 4)"
date: 2026-04-08
note: >
  This module was planned but never built for the original claude.ai system.
  Created for the Claude Code skill based on behavioral specs scattered across
  the original system instructions, definitions-concepts, brief-scaffolding,
  report-standardization, thinking-file, and discussion-documents modules.
---

# Sequential Research Chaining: Multi-Pass Protocol

Defines how research runs build on each other. Transforms ad-hoc "do more
research" into structured iterative refinement where each run inherits context,
fills gaps, and compounds knowledge from prior runs.

## Core Concept

```
Research N completes → identifies gaps/targets → Brief N+1 inherits context → Research N+1
```

Every research run compounds previous knowledge. The chaining module automates
the bridge between runs so context isn't lost and gaps are systematically filled.

## When to Activate

**Trigger conditions (any of these):**
- Research report's "Remaining Questions" section identifies unresolved targets
- User says "continue research", "go deeper", "investigate [emergent target]"
- Report's confidence score is below the brief's validation standard threshold
- Meta-analysis identifies cross-report gaps needing targeted fill

**Do NOT chain when:**
- The topic is entirely new (start fresh with Phase 0)
- User explicitly wants a standalone report
- Previous research is stale (>3 months old without domain changes)

## Chaining Process

### Step 1: Harvest from Report N

Extract from the completed report's Research Success Report section:

| Harvest Target | Source Section | Maps To in Brief N+1 |
|----------------|---------------|----------------------|
| Remaining questions | "Remaining Questions & Hypotheses" | Specific Questions |
| Emergent research targets | "Emergent Research Targets" | New pillars or scope expansion |
| Blind spots identified | "Blind Spots & Conflicts" | Anti-Patterns / Known Unknowns |
| Unvalidated claims | Low-confidence findings | Divergence Requirements |
| Key findings (confirmed) | Executive Summary / Key Findings | Context (background, not re-researched) |

### Step 2: Generate Brief N+1

Auto-scaffold a new brief with inherited context:

```yaml
---
type: RESEARCH_BRIEF
status: Draft
topic: topic-kebab-case
version: 2.0  # incremented from Report N's associated brief
date: YYYY-MM-DD
titan_ready: false
chain_parent: RESEARCH_REPORT_topic_v1_YYYY-MM-DD.md
chain_depth: 2  # how many runs deep in this chain
tags: [sequential-research, topic-tags]
source: titan-research
---
```

**Brief N+1 structure:**

```markdown
# Research Brief: [Topic] — Run [N+1]

## Chain Context
**Parent report:** [Report N filename]
**Chain depth:** [N+1]
**What Run N established:** [2-3 sentence summary of confirmed findings]
**What Run N+1 targets:** [the gap this run fills]

## Core Question
[Narrowed from Report N's remaining questions. More specific than Run N.]

## Inherited Context (Do Not Re-Research)
[Key findings from Report N. These are BACKGROUND, not research targets.
The orchestrator should not allocate agents to re-validate these.]

## New Scope
**IN scope (Run N+1 only):**
- [Gaps identified in Report N]
- [Emergent targets worth pursuing]

**OUT of scope (already covered in Run N):**
- [Topics with high-confidence findings in Report N]

## Specific Questions
[Derived from Report N's remaining questions + emergent targets]

## Research Execution Plan
[New pillar allocation targeting the gaps. Typically fewer, more focused pillars
than Run N. 3-4 pillars instead of 5-6.]
```

### Step 3: Validate Chain Brief

Before launching Run N+1:

- [ ] Chain parent report is referenced and accessible
- [ ] Inherited context is clearly separated from new research targets
- [ ] Core question is narrower than Run N (not a repeat)
- [ ] New pillars target identified gaps, not re-covering old ground
- [ ] Version number is incremented
- [ ] User approves the chain brief

### Step 4: Execute Run N+1

Standard Titan phases (0.5 → 1 → 2 → 3 → 4), with these adjustments:

- **Phase 1 (Architect):** Start from Report N's MECE tree. Extend, don't rebuild.
- **Phase 2 (Miner):** Focus search on gap areas. Skip topics with high-confidence
  findings from Run N.
- **Phase 3 (Critic):** Red team against BOTH Run N and Run N+1 findings combined.
- **Phase 4 (Output):** Report can reference Run N findings without repeating them.
  Use: "As established in Run N [citation], ..."

### Step 5: Update Chain Metadata

After Report N+1 is delivered:

- Update Brief N+1's `research_completed: true` and `research_report` field
- Update Report N+1's YAML with `chain_parent` reference
- If Run N's brief has a `research_report` field, it stays pointing to Report N
  (don't overwrite)

## Chain Depth Guidance

| Chain Depth | Signal | Action |
|-------------|--------|--------|
| 1 (initial) | Normal research | Standard Titan protocol |
| 2 | Targeted gap fill | Narrower scope, fewer pillars |
| 3 | Diminishing returns likely | Ask: is more research worth the ROI? |
| 4+ | Likely over-researched | Strong recommendation to synthesize and stop |

At depth 3+, explicitly ask the user: "We've done [N] runs on this topic. The
marginal value of another run is likely low. Should we synthesize what we have,
or is there a specific critical gap that justifies another pass?"

## Thinking File for Chained Research

Create a NEW thinking file for each run: `_THINKING_topic_v[N+1]_date.md`

In the Initial Analysis section, reference the previous thinking file:
```
**Previous Research:** _THINKING_topic_v[N]_date.md
**Key Learnings Carried Forward:**
- [Insight 1 from previous research]
- [Insight 2 from previous research]
**New Focus for This Iteration:** [what Run N+1 explores]
```

## Discussion Documents as Chain Inputs

If post-research discussion documents exist from Run N, they may contain
refined questions or insights that should feed into Brief N+1:

- Check for `DISCUSSION_topic_*.md` files from Run N
- Extract questions that weren't fully answered in the discussion
- These become Specific Questions in Brief N+1

## Platform Notes

**Claude Code:** Chain metadata lives in the filesystem. Brief N+1 can read
Report N directly. Subagents can be pointed at both the new brief and the
parent report for context.

**Claude.ai:** Chain context must be included in the brief itself (no filesystem
access). Copy key findings from Report N into the "Inherited Context" section.
Keep this section under 500 words to preserve context budget for new research.
