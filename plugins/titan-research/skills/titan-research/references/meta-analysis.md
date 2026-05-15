---
type: reference
status: active
version: 1.0
date: 2026-04-08
tags: [titan-research, meta-analysis, synthesis, cross-report]
usage: Load post-research when synthesizing findings across multiple reports
---

# Meta-Analysis: Cross-Report Synthesis

Three-phase process for synthesizing findings across multiple research reports
into tentative decisions with explicit confidence levels and validation needs.

Use when: 2+ TITAN reports exist on related topics, and the user needs to make
a decision that spans multiple research domains.

## File Setup

### Naming

```
META_ANALYSIS_topic-kebab-case_v1_YYYY-MM-DD.md
```

### Metadata Block

Place at the top of the meta-analysis document:

```markdown
## Meta-Analysis Metadata

| Field | Value |
|-------|-------|
| PURPOSE | [What decision this synthesis informs] |
| PROCESS STAGE | [Sweep / Analysis / Direction Setting] |
| SOURCE DOCUMENTS | [List of report filenames] |
| OUTCOME | [Tentative / Validated / Superseded] |
| CONFIDENCE | [0-100%] |
| VALIDATION NEEDS | [What must be true for these conclusions to hold] |
```

Update PROCESS STAGE as you move through phases.

## Phase 1: Meta Sweep (Discovery & Extraction)

Goal: catalog what exists and extract decision-relevant content.

### Steps

1. **Document inventory**: List all source reports with their dates, topics,
   and confidence levels from their BLUF assessments

2. **Decision extraction**: From each report, pull:
   - Core findings (what was discovered)
   - Recommendations (what was suggested)
   - Confidence levels (how certain)
   - Caveats (what could invalidate)
   - Emergent findings (what surprised)

3. **Gap identification**: Map what questions remain unanswered across all reports.
   Note questions that appear in multiple reports' "Remaining Questions" sections.

4. **Source catalog**: Aggregate all citations. Flag sources that appear across
   multiple reports (high-signal) and domains with no primary sources (blind spots).

### Checkpoint: Before Proceeding to Phase 2

- Are all relevant reports included?
- Are the extraction categories consistent across reports?
- Are there reports that should exist but don't? (gap signal)
- Is the purpose statement still accurate given what you found?

## Phase 2: Analysis (Pattern Detection & Contradiction Hunting)

Goal: find what the individual reports could not see alone.

### Pattern Recognition

Look for findings that:
- Appear independently in 2+ reports (convergent signal)
- Are framed differently but point to the same conclusion
- Build on each other in ways the individual reports did not anticipate

Document each pattern with:
- Which reports contribute to it
- Strength of evidence (how many independent sources)
- Whether any report contradicts it

### Contradiction Detection

Actively search for:
- Reports that reach different conclusions on the same question
- Recommendations that conflict with each other
- Confidence levels that don't match the evidence cited
- Assumptions in one report that another report's evidence undermines

For each contradiction:
- State both positions clearly
- Identify the root cause (different time frames? different definitions? different evidence?)
- Assess which position has stronger evidence
- If unresolvable, flag for validation

### Assumption Archaeology

Dig out implicit assumptions:
- What does each report take for granted?
- Are those assumptions consistent across reports?
- Has any assumption been invalidated by evidence in another report?
- What shared assumption, if wrong, would change everything?

### Confidence Calibration

Reassess confidence based on cross-report evidence:
- Findings confirmed by multiple reports: increase confidence
- Findings contradicted by another report: decrease confidence
- Findings with no cross-report signal: maintain original confidence
- Findings where assumptions conflict: flag, do not average

### Checkpoint: Before Proceeding to Phase 3

- Are contradictions explained, not just listed?
- Are patterns supported by evidence from multiple reports?
- Have you identified the highest-risk assumptions?
- Is anything being suppressed because it is inconvenient?

## Phase 3: Direction Setting (Decisions & Validation)

Goal: translate analysis into tentative decisions with clear validation paths.

### Tentative Decisions

For each decision the meta-analysis informs:

```markdown
### Decision: [Statement]

**Confidence**: [0-100%]
**Based on**: [Which reports and findings support this]
**Assumes**: [What must be true for this to hold]
**Invalidated if**: [What evidence would reverse this decision]
**Validation method**: [How to test before committing]
```

### Confidence Assignment Rules

| Level | Meaning | Evidence Standard |
|-------|---------|-------------------|
| 80-100% | Act on this | 3+ reports converge, primary sources, no unresolved contradictions |
| 60-79% | Probably right, validate | 2+ reports converge, some contradictions explained |
| 40-59% | Coin flip, need more data | Mixed signals, unresolved contradictions |
| 20-39% | Probably wrong, but can't rule out | Weak evidence, strong counter-arguments |
| 0-19% | Actively disconfirmed | Evidence opposes this conclusion |

### Validation Requirements

For each tentative decision, specify:
- What data would confirm it (and where to get it)
- What data would refute it (and where to look)
- Estimated effort to validate
- Cost of being wrong without validating

### Implementation Implications

If decisions are acted on:
- What changes immediately?
- What dependencies exist between decisions?
- What is the sequence (what must happen first)?
- What is reversible vs. irreversible?

### Pre-Mortem

Before finalizing, run a pre-mortem:
- "It's one year from now. These decisions failed. What happened?"
- Identify the 3 most likely failure modes
- For each: probability, detectability, mitigation

### Checkpoint: Final Review

- Does every decision have a confidence level and validation path?
- Are irreversible decisions held to a higher evidence bar?
- Is the pre-mortem honest, not performative?
- Would you bet your own money on these conclusions?
