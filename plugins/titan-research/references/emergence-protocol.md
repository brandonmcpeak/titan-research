---
type: reference
status: active
version: 1.0
date: 2026-04-08
tags: [titan-research, emergence, discovery, adaptation]
usage: Load during Phase 0.5, Phase 2, and Phase 4 for discovery-first research
---

# Emergence Protocol: Discovery-First Research

Prevents premature convergence in research. The brief is a starting point,
not a boundary. This protocol ensures important discoveries that fall outside
the original brief structure are captured and elevated, not suppressed.

## Core Principle: The Socratic Paradox

> A brief that claims to identify all blind spots IS itself a blind spot.

The brief captures what you THINK you need to know. Research reveals what you
ACTUALLY need to know. These are rarely identical. The gap between them is
where the highest-value discoveries live.

Emergence protocol ensures the report structure adapts to what was discovered,
not just what was planned.

## When This Activates

- Phase 0.5 (Socratic Stress Test): set expectations that the brief will evolve
- Phase 2 (Deep Investigation): detect and flag emergent patterns during research
- Phase 4 (Output): adapt report structure to accommodate discoveries

## The Brief as Starting Point

The brief defines:
- WHERE to start looking
- WHAT questions to prioritize
- HOW rigorous to be

The brief does NOT define:
- What you are allowed to find
- What sections the report must be limited to
- When to stop following a productive thread

Rule: if a discovery is important enough to change the user's decision, it
belongs in the report regardless of whether the brief asked for it.

## Report Section Type Library

### Category A: Nearly Universal

Include these sections in most reports. They emerge from almost every deep dive.

| Section Type | Description |
|-------------|-------------|
| Practitioner Patterns | What people who actually do this say works/fails |
| Anti-Patterns | Common mistakes, failure modes, things that look right but aren't |
| Decision Framework | Structured way to choose between options discovered |

### Category B: Common Patterns

Include when the topic supports them. Most reports will use 2-4 of these.

| Section Type | Description |
|-------------|-------------|
| Competing Frameworks | Different schools of thought or methodological approaches |
| Tactical How-To | Step-by-step implementation guidance |
| Adoption Curve | Maturity model, where the field is in its evolution |
| Cross-Domain Parallels | Insights from analogous domains or industries |
| Regulatory/Compliance | Legal, regulatory, or policy considerations |
| Cost-Benefit Analysis | Economic modeling of options |
| Historical Context | How we got here, why current state exists |
| Stakeholder Map | Who cares about this, what their incentives are |
| Technology Landscape | Tools, platforms, infrastructure involved |
| Cultural/Organizational | Human factors, change management, adoption challenges |

## Emergent Section Slots

During Phase 2, maintain a running list of findings that do not fit existing sections.

### Detection Triggers

Flag a finding as emergent when:
- It contradicts the brief's hypothesis
- It suggests the core question is wrong or incomplete
- It reveals a dependency the brief did not anticipate
- It connects two domains the brief treated as separate
- Multiple independent sources converge on something the brief ignored
- It would change the user's decision even if the core question is answered

### Promotion Criteria

An emergent finding gets its own report section when:

1. **Significance**: it would change the decision or action
2. **Evidence**: supported by at least 2 independent sources
3. **Novelty**: not already captured in an existing section
4. **Actionability**: the user can do something with this information

Findings that meet 3 of 4 criteria get a section. Findings that meet 2 of 4
go in "Blind Spots & Conflicts." Findings that meet 1 of 4 go in a footnote.

## Active Pattern Detection (Phase 2)

During research, actively scan for these emergence signals:

**Convergence signal**: Multiple unrelated sources point to the same
unexpected conclusion. Elevate this; it is likely important.

**Divergence signal**: Sources that should agree are contradicting each other.
Investigate why. The contradiction often reveals a hidden variable.

**Silence signal**: An expected topic gets no coverage in the literature.
This absence is itself a finding. Note it and hypothesize why.

**Recurrence signal**: The same concept keeps appearing across different
sub-topics. It may be a unifying theme the brief missed.

**Discomfort signal**: A finding that feels inconvenient or unwelcome.
This is the most important signal. Suppress the instinct to minimize it.

## Report Structure Adaptation

The standard report template (see `report-standardization.md`) provides the skeleton.
Emergence protocol modifies it:

1. **Add sections** for promoted emergent findings (after Key Findings, before
   Blind Spots & Conflicts)
2. **Reorder sections** if an emergent finding is more important than planned content
3. **Expand Blind Spots** to include emergence that did not meet promotion criteria
4. **Update the BLUF** if emergence changes the core answer
5. **Flag in Research Success Report** all emergent targets for potential follow-up research

Never remove planned sections to make room for emergent ones. Add, do not replace.

## Integration with Brief

After research, the brief may need updating:

- Add emergent questions to "Unknown Unknowns (Anticipated)" retroactively
- Note in Claude Working Notes what emergence revealed about brief quality
- If emergence fundamentally reframes the core question, note this in the
  Research Success Report, not by silently editing the brief
