---
name: titan-research
description: >
  Deep research protocol for comprehensive, multi-phase investigations. Use when:
  user invokes /titan, "deep research", "deep dive", "systematic research",
  "research protocol", "TITAN mode", "comprehensive research", "investigate this
  thoroughly", "I need a thorough analysis", "research this topic deeply".
  Enforces structured intake, multi-source synthesis, and rigorous output formatting.
user-invocable: true
argument-hint: "[research topic or question]"
---

# TITAN Research Protocol

Structured deep research system. Not for quick lookups; use for genuine investigations
that benefit from multi-phase rigor.

## Phase 0: Intake Gatekeeper (Mandatory)

Before researching, validate the request:

**Reject if:**
- Too vague ("research AI" without scope)
- Better answered with a quick search
- No clear decision or action the research will inform

**If rejected:** Ask for specific variables:
- What decision does this research inform?
- What scope boundaries exist?
- What would a useful answer look like?

**If accepted:** State the research question, scope, and success criteria before proceeding.

## Phase 1: Landscape Scan

- Map the territory: key players, frameworks, schools of thought
- Identify 3-5 primary tension points or debates in the space
- Flag areas where conventional wisdom may be wrong
- Note information gaps (what we can't easily find)

## Phase 2: Deep Investigation

- Go beyond surface-level sources
- Cross-reference claims across multiple perspectives
- Look for disconfirming evidence (not just supporting)
- Track confidence levels on each finding

## Phase 3: Synthesis

- Identify patterns across findings
- Resolve apparent contradictions (or flag genuine tensions)
- Build a coherent narrative, not just a list of facts
- Distinguish "known" from "likely" from "speculative"

## Phase 4: Output Schema

Structure all research output as:

### 1. BLUF (2 sentences max)
The core finding. What the research says you should know/do.

### 2. Confidence Assessment
- **Rating:** [0-100%]
- **Modifiers:** Why not 100% (missing data, conflicting sources, etc.)

### 3. Decision Matrix (if applicable)
| Option | Evidence Strength | Risk | Effort vs Impact |
|--------|------------------|------|-------------------|

### 4. Key Findings (Executive Summary)
Bullet points. No fluff. What matters.

### 5. Blind Spots & Unknowns
What the research couldn't answer. Where the data is thin.
What would change the conclusion if discovered.

### 6. Technical Details / Evidence Base
The full analysis. If long, create as artifact using naming standard:
`RESEARCH_topic_vX.X_YYYY-MM-DD.md`

## Phase 5: Meta-Check

Before delivering:
- Did I actually answer the question asked?
- Am I presenting the most effective answer or the most obvious one?
- Where would this analysis fail?
- What assumption, if wrong, would invalidate the conclusion?

## Usage Notes

- This protocol is for genuine deep dives, not quick questions
- Expect multi-tool usage (web search, file reads, synthesis)
- Output should be "ready for implementation", not "here's what I found"
- Use artifact naming standard for all research deliverables
