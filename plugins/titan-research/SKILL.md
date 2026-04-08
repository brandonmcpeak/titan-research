---
name: titan-research
description: >
  Deep research protocol for comprehensive, multi-phase investigations. Use when:
  user invokes /titan, "deep research", "deep dive", "systematic research",
  "research protocol", "TITAN mode", "comprehensive research", "investigate this
  thoroughly", "I need a thorough analysis", "research this topic deeply".
  Enforces structured intake, multi-source synthesis, and rigorous output formatting.
  Produces decision-ready intelligence, not reference documents.
user-invocable: true
argument-hint: "[research topic or question]"
---

# TITAN Research Protocol v2.0

Intelligence amplification system. Transforms research from "Ask > Search > Summarize"
into recursive, cumulative knowledge building. Optimizes for Return on Attention:
maximum insight density, minimum noise.

**Behavioral constraints (always active):**
- TONE: Objective, high-bandwidth. "McKinsey Partner" meets "Chief Engineer."
- NO FLUFF: Every sentence must reduce uncertainty.
- NO LAZINESS: Do not suggest "further research" unless the web is literally empty.
- CITATION: [Source Name] for every claim.

## Platform Dispatch

Detect execution environment and adapt:

**Claude Code** (Agent tool available):
- Use subagent orchestration for parallel research
- Spawn research agents per pillar (up to 6 parallel agents)
- Each agent: web search per assigned topics, structured findings
- Orchestrator: synthesize agent outputs into final report
- Save all artifacts to filesystem with naming convention
- Reports go to `resources/research/reports/`
- Briefs go to `resources/research/briefs/`

**Claude.ai** (extended search available):
- Use extended search tool for deep pillar research
- Sequential pillar execution within single context
- Each pillar: 100+ links via extended search
- Produce artifact with naming convention
- Store as project file or conversation artifact

## Phase 0: Intake Gatekeeper (Mandatory)

Before researching, validate the request.

**Reject if:**
- Too vague ("research AI" without scope)
- Better answered with a quick search
- No clear decision or action the research will inform

**If rejected:** Ask for 3 targeted Constraint Questions to narrow scope.

**If accepted:**
1. Create Thinking File IMMEDIATELY (see `references/thinking-file.md`)
   - `_THINKING_topic_v1_YYYY-MM-DD.md` in `resources/research/briefs/`
   - Log first impressions, initial hypotheses, blind spots
   - This is WRITE-ONLY; never loaded back into context
2. Enter Brief Building Mode

### Brief Building Mode

Load `references/input-dor.md` for the full facilitation protocol. Two intake paths:

**Path A — Dialogue** (default): Interactive facilitation through targeted questions.
**Path B — Ingest** (when user provides raw inputs): Extract from transcripts, notes,
or documents first, then ask only about gaps. See "Ingest Mode" in input-dor.md.

Core flow (both paths):

1. **Create brief file**: `BRIEF_topic_DRAFT_v1_YYYY-MM-DD.md`
   (See `references/brief-scaffolding.md` for template and protocol)
2. **Build brief content**: Via dialogue (Path A) or extraction + gap-fill (Path B)
   - Core question (specific, answerable)
   - Success criteria (what decision/action this informs)
   - Scope (IN/OUT boundaries)
   - Constraints (time, budget, capability)
   - Hypothesis (if any)
   - Anti-patterns (what to avoid)
   - Evidence bar (Standard / High / Paranoid)
3. **Validate**: Run quality gates on completed brief
4. **Generate Research Execution Plan**: Mandatory. Decompose the brief into
   explicit research pillars with structured allocation. This bridges the brief
   to execution. See `references/agent-allocation.md` for pillar object schema.
   ```
   ## Research Execution Plan

   ### Pillar Allocation

   | Pillar | Name | Priority | Weight | Depth | Topics | Source Strategy | Validation |
   |--------|------|----------|--------|-------|--------|-----------------|------------|
   | P1 | [name] | high | 30% | deep | [topics] | [strategy] | high |
   | P2 | [name] | high | 25% | balanced | [topics] | [strategy] | standard |
   | ...

   ### Emergence Allowance
   [X]% reserved (based on topic novelty: well-understood=10%, moderate=25%, novel=50%)

   ### Execution Notes
   - Platform recommendation (Claude Code subagents vs Claude.ai extended search)
   - Sequencing if running sequentially (priority order)
   - Batching guidance (max 5-6 pillars before timeout risk on Claude.ai)
   - Key dependencies between pillars
   ```
5. **Confirm**: Present full brief + execution plan, get user approval to launch

**Express mode**: If user says "skip brief" or "express mode", capture core question
only. Still generate a minimal 3-pillar execution plan before launching.

## Phase 0.5: Socratic Stress Test

Before launching research, challenge the brief:

- Are we solving the right problem?
- What assumption, if wrong, would invalidate this entire inquiry?
- What domains/perspectives are we not considering?
- Is the scope too broad to produce actionable results?

This is a brief quality check, NOT a completeness guarantee. Emergence will surface
what we couldn't anticipate. See `references/emergence-protocol.md`.

## Phase 1: Landscape Scan (The Architect)

Before searching, map the territory:

1. **Deconstruct**: Break request into First Principles (economics, psychology, physics)
2. **MECE Tree**: Create research outline that is Mutually Exclusive, Collectively Exhaustive
3. **Gap Analysis**: Identify Known Unknowns and Unknown Unknowns
4. **Pillar Allocation**: Map research pillars to agents/search streams
   (See `references/agent-allocation.md` for structured allocation protocol)

Key players, frameworks, schools of thought. 3-5 primary tension points.
Flag areas where conventional wisdom may be wrong.

## Phase 2: Deep Investigation (The Miner)

Execute research with Adversarial Filtering:

- **Triangulation**: A fact is only true if confirmed by 3 distinct source types
  (e.g., Academic Paper + Industry Report + User Forum)
- **Divergence Hunting**: Specifically search for critiques, failures, competitors
- **Provenance**: Prioritize primary data (10-K, API Docs, GitHub Issues) over
  secondary interpretations (Blogs, News)
- **Emergence awareness**: Flag discoveries that don't fit the brief structure.
  These may be the most important findings. See `references/emergence-protocol.md`.

Track confidence levels on each finding.

## Phase 3: Synthesis (The Critic)

Run a silent Red Team simulation before finalizing:

- **Attack**: "If this report is wrong, why?"
- **Refine**: Patch weak points. Flag structural data gaps as Critical Blind Spots.
- **Pattern detection**: Identify convergent signals across sources
- **Contradiction resolution**: Explain why contradictions exist, not just that they do

Distinguish "known" from "likely" from "speculative".

## Phase 4: Output (Chain of Density)

Structure all research output using the standard report schema.
See `references/report-standardization.md` for full protocol.

### Report Structure

```
# [Topic]: Strategic Deep Dive

## 1. Executive BLUF (2 sentences max)
The Alpha: single most high-leverage insight.
Confidence Score: (0-100%) & Primary Risk Factor.

## 2. Decision Matrix
| Option | Evidence Strength | Risk | Effort vs Impact | The "Catch" |

## 3. Key Findings (Executive Summary)
Bullet points. No fluff. What matters.

## 4. [Content Sections - adapted to topic]
Full analysis with numbered citations [1][2][3].

## 5. Blind Spots & Conflicts
Consensus vs Reality. The "Undiscussables."

## 6. Compounding Heuristics
1-3 "Golden Rules" from this research domain.

## 7. Research Success Report & Path Navigation
- BLUF assessment vs original brief
- Remaining questions & hypotheses
- Emergent research targets (new discoveries)
- Suggested next actions (prioritized by leverage)

## Sources & Citations
[1] Source Title (URL)
[2] Source Title (URL)
```

### Report Filing

**File naming**: `RESEARCH_REPORT_topic-kebab-case_v1_YYYY-MM-DD.md`

**Location**: `resources/research/reports/` (canonical home)

**YAML front matter** (required):
```yaml
---
type: RESEARCH_REPORT
status: Active
topic: topic-kebab-case
topic_area: [spirituality | business | technology | operations | career | finance | health]
destination: [path to wiki-link stub]
date: YYYY-MM-DD
version: 1.0
associated_brief: BRIEF_topic_v1_YYYY-MM-DD.md
tags: [tag1, tag2]
source: titan-research
---
```

**Post-report**: Update associated brief status to Research-Complete.
See `references/report-standardization.md` Phase 4.

## Phase 5: Meta-Check

Before delivering:
- Did I actually answer the question asked?
- Am I presenting the most effective answer or the most obvious one?
- Where would this analysis fail?
- What assumption, if wrong, would invalidate the conclusion?
- Did emergence surface anything that should restructure the report?

## Post-Research: Sequential Chaining

When a report identifies remaining questions or emergent targets, and the user
wants to continue researching:

1. Load `references/sequential-chaining.md`
2. Harvest gaps/targets from Report N's Research Success Report
3. Auto-generate Brief N+1 with inherited context and narrowed scope
4. Execute Run N+1 with standard Titan phases

Chain depth > 3 requires explicit user confirmation (diminishing returns likely).

## Module Reference

Load these on-demand when the corresponding phase activates:

| Module | Load When | Reference File |
|--------|-----------|----------------|
| Thinking File | Phase 0 (FIRST action, before brief) | `references/thinking-file.md` |
| Input DOR | Phase 0 (brief building) | `references/input-dor.md` |
| Brief Scaffolding | Phase 0 (file creation) | `references/brief-scaffolding.md` |
| Agent Allocation | Phase 0 (pillar decomposition) + Phase 1 | `references/agent-allocation.md` |
| Emergence Protocol | Phase 0.5, 2, 4 (discovery) | `references/emergence-protocol.md` |
| Report Standardization | Phase 4 (output formatting) | `references/report-standardization.md` |
| Sequential Chaining | Post-research (multi-pass) | `references/sequential-chaining.md` |
| Meta-Analysis | Post-research (multi-report synthesis) | `references/meta-analysis.md` |
| Discussion Documents | Post-report (extended Q&A) | `references/discussion-documents.md` |
| Definitions & Concepts | Any phase (terminology) | `references/definitions-and-concepts.md` |

## Usage Notes

- This protocol is for genuine deep dives, not quick questions
- Output should be "ready for implementation", not "here's what I found"
- Every research run compounds previous knowledge
- Use `assets/research-brief-template.md` for blank brief skeleton
- Use `assets/report-output-template.md` for blank report skeleton
