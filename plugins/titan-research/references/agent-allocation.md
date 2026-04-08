---
type: reference
skill: titan-research
module: agent-allocation
phase: "Phase 1: Landscape Scan"
date: 2026-04-08
---

# Multi-Agent Orchestration

How research agents are allocated across pillars during Phase 1.

## Baseline Configuration

6 parallel agents (pillars) for comprehensive research. Each pillar is a structured
object with the following properties:

| Property | Type | Description |
|----------|------|-------------|
| pillar_id | string | Unique identifier (e.g., `P1`, `P2`) |
| pillar_name | string | Human-readable label |
| provenance | enum | `user_specified`, `ai_expanded`, `collaborative` |
| priority | enum | `high`, `medium`, `low`, `emergent` |
| weight_target | percentage | 10-50% of total research capacity |
| depth_vs_breadth | enum | `deep`, `balanced`, `wide` |
| topics | list | Specific search topics assigned to this pillar |
| search_strategy | string | How this pillar should approach sourcing |
| validation_standard | enum | `standard`, `high`, `paranoid` |

## Allocation Protocol

1. Parse the research brief for explicit pillar requests
2. Identify implicit pillars from the problem decomposition
3. Tag each pillar's provenance (user-specified vs AI-expanded)
4. Assign priority weights ensuring user-specified pillars get adequate coverage
5. Reserve emergence capacity (see below)
6. Confirm allocation with the user before launching

### Priority Weighting

- `high` pillars: 25-50% weight each
- `medium` pillars: 15-25% weight each
- `low` pillars: 10-15% weight each
- `emergent` pillars: allocated dynamically from emergence reserve

User-specified pillars default to `high` priority unless the user explicitly
deprioritizes them. AI-expanded pillars default to `medium`.

### Emergence Allowance

Reserve 10-50% of total research capacity for discoveries that don't fit the
original pillar structure. The reserve percentage scales with topic novelty:

- Well-understood topic: 10% reserve
- Moderately novel: 25% reserve
- Highly novel / exploratory: 50% reserve

Emergent findings that justify their own pillar get promoted from the reserve.

## Platform-Specific Mapping

### Claude Code (Agent tool)

Map each pillar to a subagent via the Agent tool:

```
For each pillar in allocation:
  spawn Agent(
    prompt: pillar.search_strategy + pillar.topics,
    tools: [WebSearch],
    output: structured findings per pillar schema
  )
```

Orchestrator collects all agent outputs and synthesizes into the final report.
Agents run in parallel; orchestrator waits for all to complete.

### Claude.ai (Extended Search)

Map pillars to sequential extended search allocations:

```
For each pillar in priority order:
  execute extended_search(
    queries: pillar.topics,
    target: 100+ links per pillar,
    filter: pillar.validation_standard
  )
```

Sequential execution within a single context window. Higher-priority pillars
run first to ensure coverage if context limits are reached.

## Provenance Tracking

Every finding in the final report must trace back to its source pillar:

- `[P1]` tags on findings from Pillar 1
- Provenance column in the Decision Matrix
- Emergence findings tagged `[E]` with the pillar they were discovered under

This lets the user distinguish "I asked for this" from "the system found this."

## Orchestration Handoff Protocol

The search tool orchestrator (whether Claude Code's Agent tool or Claude.ai's extended
search) is not omniscient. It receives a brief and attempts to interpret intent, but
without explicit structure it often reallocates pillars arbitrarily, treats all pillars
equally, or tries to "research" context that's already known.

### Context vs. Research Targets

**Context** (background): Information that informs HOW research is done, not WHAT to research.
User's situation, strategic goals, constraints, team composition, budget.

**Research Targets**: Explicit topics/questions that need investigation.
Best practices, frameworks, case studies, implementation mechanics, failure modes.

**Rule**: Never allocate research capacity to validate or expand context. Use context to
filter and prioritize findings in the research targets. In the brief, label the Context
section with: "Orchestrator Instruction: Background only. Do not research."

### Provenance Pass-Through

When handing off pillars to agents, communicate provenance explicitly:

- `user_specified` → "This pillar is user-specified. Coverage is mandatory. Do not
  reinterpret intent."
- `ai_expanded` → "This pillar is AI-expanded. Coverage is flexible. Adjust based on
  discovery."
- `collaborative` → "This pillar was jointly specified. Coverage is expected but scope
  can flex."

### MECE with Hedging

Pillars should be Mutually Exclusive, Collectively Exhaustive where feasible, but:

- Some topics span multiple pillars. Keep core content in the primary pillar, cross-reference
  from the secondary. Aim for <10% overlap.
- Collective Exhaustiveness is aspirational. The emergence buffer handles discoveries.
- Comparison baselines may need cross-pillar presence (e.g., a benchmark product referenced
  in multiple pillars). Explicitly note these in the brief.
- Acknowledge overlaps: "P2 and P4 both touch on X; P2 covers framework, P4 covers implementation."

### Pre-Search Validation Checklist

Before launching research, verify:

- [ ] All user-specified pillars have `provenance: user_specified` and `priority: high`
- [ ] Weight targets sum to ≤90% (leaving emergence buffer)
- [ ] Context section is clearly separated from research targets
- [ ] Each pillar has at least 1 specific topic assigned
- [ ] Orchestrator pass-through instructions are present for high-priority pillars
- [ ] Emergence allowance percentage is justified (10-50% based on novelty)
