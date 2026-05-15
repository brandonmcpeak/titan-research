---
type: reference
skill: titan-research
module: multi-phase-protocol
phase: "Within-run, multi-phase orchestration (spans Phases 1-4 of SKILL.md)"
date: 2026-05-13
note: >
  Born from the 2026-05-13 claude-design-skill v3 multi-phase run.
  Covers within-run, cross-phase orchestration. Distinct from sequential-chaining.md
  which covers between-run inheritance.
---

# Multi-Phase Research Protocol (Within-Run)

Defines how a single research run is structured when the brief explicitly
decomposes the work into 2+ dependent phases, where Phase N+1 pillar scopes
depend on Phase N findings. Layers on top of the Phase 0-5 SKILL.md structure;
does not replace it.

## When to Use

Multi-phase fires when the brief is explicitly multi-phase. Indicators:

- Brief frontmatter has `phases: N` where N >= 2
- Pillar allocation table has explicit phase columns (e.g., P1-P6 in ph1; P7-P9 in ph2)
- Some pillar scopes are marked `DEPENDS_ON: Phase N output`
- Brief language says "after Phase 1 results, scope Phase 2 pillars"

If unsure, default to single-phase. Multi-phase carries ~20-40% additional
editorial cost (master synthesis + scope-adjustment passes) over a comparable
single-phase run with the same pillar count. Justify the cost before committing.

## Distinction from Sequential Chaining

| | Multi-Phase (this doc) | Sequential Chaining |
|---|---|---|
| Scope | WITHIN a single run | BETWEEN runs (Run N → Run N+1) |
| Trigger | Brief explicitly multi-phase | Report N's remaining questions or emergent targets |
| Output | Master report + phase reports + pillar files | New brief + new report |
| Artifact dir | Single run-dir (`<topic>_run_<date>/`) | Separate run dirs per run |
| Reference | This file | `sequential-chaining.md` |

A single project can use both: a multi-phase Run 1 (this doc) whose master
report identifies gaps that justify a Run 2 (`sequential-chaining.md`).

## Platform Requirements

Multi-phase orchestration is **Claude-Code-native**. Reasons:

- Requires parallel-subagent dispatch + collection per phase
- Requires mid-run scope adjustment (read Phase N synthesis, rewrite Phase N+1 pillar specs)
- Requires filesystem cohesion across many artifacts (pillar files + phase reports + master)

Claude.ai extended search is single-phase by design. For multi-phase, switch
to Claude Code. If only Claude.ai is available, collapse to a single-phase
brief with priority pruning, accepting reduced cross-phase synthesis quality.

## The Orchestration Loop

For each phase 1..N:

1. **Dispatch parallel subagents per pillar.** Per `agent-allocation.md` Platform-Specific Mapping → Claude Code. Subagent prompts MUST include the subagent output schema (citation discipline + wikilink discipline) from that doc.
2. **Wait for all subagents in the phase to complete.** Do not start synthesis until every pillar has returned.
3. **Synthesize phase-N findings** into `RESEARCH_REPORT_<topic>-ph<N>_v1_<date>.md`.
4. **Apply citation discipline** per `report-standardization.md` Phase 2 → Inline Citation Propagation. Synthesis-level inline cites + consolidated numbered Sources section. NOT a bare "see companion files" wikilink list.
5. **Run the scope-adjustment pass** for phase N+1 (see below) if any.
6. **Surface adjustments + checkpoint with user IF material drift detected** (>20% scope change in any Phase N+1 pillar, or new emergent pillar promoted from reserve).

After the last phase:

7. **Compose the master report** `RESEARCH_REPORT_<topic>_master_v1_<date>.md`.
8. The master adds cross-phase synthesis the phase reports cannot:
   - Cross-phase convergences (pillars in different phases converging on the same insight)
   - Single-narrative arc (Phase 1 sets up; Phase 2 builds; etc.)
   - Consolidated Sources section across all pillars (deduplicated)
   - Decision matrix consolidated across all phases

## Scope Adjustment Between Phases

After Phase N synthesis, before Phase N+1 dispatch, the orchestrator MUST
produce a "Phase N+1 Scope Adjustments" section in the Phase N synthesis
report. Structure:

| Pillar | Original Scope | Phase N Surface | Adjustment |
|---|---|---|---|
| P7 | [original brief scope] | [relevant Phase N finding] | INHERIT / ADJUST / NARROW / EXPAND |

Adjustment values:
- **INHERIT**: scope unchanged from original brief
- **ADJUST**: scope refined based on Phase N finding (clarification, not size change)
- **NARROW**: scope reduced because Phase N already addresses part of original
- **EXPAND**: scope widened because Phase N surfaced new territory

If adjustments are non-trivial (>20% of original scope changed for any
pillar, OR an emergent pillar promoted from reserve), **surface to the user
via AskUserQuestion or prose ask before launching Phase N+1.** User
acknowledgment is the gate.

If adjustments are trivial (all INHERIT or minor ADJUSTs), proceed without
explicit user gate — but still record the adjustment table in the phase
report for traceability.

## Master Report Composition

The master report is the canonical multi-phase, public-shareable artifact.
Phase reports are intermediate authorities. The master cites both (a) original
pillar sources and (b) phase reports as intermediate sources where appropriate.

### Required Structure

1. **Executive BLUF** (2-3 sentences, with confidence score and primary risk)
2. **Decision Matrix** (consolidated across all phases)
3. **Cross-Phase Narrative** (master-only value-add — what the phases cannot say in isolation)
4. **Key Findings** (top 15-20 across all pillars)
5. **Pillar Synthesis** (one section per pillar, with full inline cites)
6. **Blind Spots & Conflicts** (consolidated)
7. **Compounding Heuristics** (consolidated)
8. **Downstream Bridge** (what the master enables for the consumer: builds, decisions, follow-ups)
9. **Path Navigation & Suggested Next Actions** (per Research Success Report template)
10. **Sources & Citations** (consolidated, deduplicated, numbered)
11. **Appendix — Companion File Index** (wikilinks to pillar files + phase reports)

### Length Target

- 2-phase, 6-10 pillars: 6,000-10,000 words
- 3-phase, 10-15 pillars: 10,000-15,000 words

Master length grows sublinearly with pillar count — deduplication compounds.

### Citation Density

- Master report: ≥40 inline cites (per `report-standardization.md` Inline Citation Propagation)
- Each pillar's load-bearing claims propagate at least one cite into the master
- Sources section is the union of phase sources, deduplicated by URL + date

### Standalone-Readability Lens (Verifier Sub-Agent)

After the master report draft is composed (sections 1-11), dispatch a Verifier-style sub-agent to evaluate the draft as a standalone artifact for public consumption. Pattern adopted from Feynman's Verifier agent architecture (see `upstreams.md` Feynman entry). The sub-agent does NOT rewrite; it returns structured findings, and the orchestrator applies surgical edits in-line per `humanizing-patterns.md`.

**Sub-agent prompt (template):**

> Read the attached master report. Evaluate it as a standalone artifact — assume the reader has not seen the prior conversation, the brief, or any pillar files. Detect:
>
> 1. **Orphan anaphora**: references like "this approach", "that pattern", "the example", "as discussed above" whose antecedents are NOT in the artifact itself.
> 2. **Conversational scaffolding**: phrases like "Let's dive in", "I'll walk you through", "going back to your question" that imply an interactive dialogue context.
> 3. **AI-tell vocabulary**: from the blacklist in `humanizing-patterns.md` (furthermore, moreover, pivotal, delve, in conclusion, it's important to note, navigate/journey/landscape as metaphors).
> 4. **AI sentence-rhythm uniformity**: clusters of similar-length sentences (typically 12-18 words) with little variation across paragraphs.
>
> Return a structured list per category with line numbers or context-quotes. Do NOT rewrite. Do NOT comment on content correctness — only on standalone-readability. Cap output at 30 highest-impact findings.

**Output schema (sub-agent returns):**

```yaml
findings:
  orphan_anaphora:
    - line: <approx>
      quote: "<offending phrase>"
      suggested_fix: "<add antecedent | delete reference>"
  conversational_scaffolding:
    - line: <approx>
      quote: "..."
      suggested_fix: "..."
  ai_tell_vocabulary:
    - line: <approx>
      quote: "..."
      substitution: "..."
  rhythm_uniformity:
    - section: "<section name>"
      observation: "<e.g., '7 consecutive ~15-word sentences in section 3'>"
      suggested_fix: "<add short sentence | vary length>"
```

**Orchestrator action after receipt:**

1. Apply surgical edits per `humanizing-patterns.md` Sentence-Shape and Content-Shape Moves. Punch-up only, NOT full rewrite.
2. For orphan anaphora: either add the missing antecedent or delete the orphan reference. Do not leave dangling.
3. Re-read each section after edits. If a section still reads conversational, mark it for a second pass.
4. **Acceptance threshold**: ≤3 orphan anaphora + ≤5 AI-tell-vocabulary instances total across the master report after the pass. If above threshold, run the lens again.

**Why a sub-agent, not orchestrator-internal:**

A fresh-context sub-agent reads the master report without the bias of "I wrote this; it must be fine." This is the Verifier pattern: separate producer from verifier. The sub-agent's lack of conversational context is the point. It catches exactly the scaffolding that the producing orchestrator can no longer see.

**Escalation to publication-grade pass:**

The Standalone-Readability Lens is the always-on lighter discipline. When the master report is destined for public-share (paired research site, published essay, client deliverable, external partner) OR when the brief frontmatter has `publication_grade: true`, escalate to the two-pass V1 → CRITIQUE → V2 cycle in `publication-grade-pass.md`. That heavier discipline produces McKinsey-Quarterly / HBR-grade voice; this lighter lens produces "no obvious tells" voice. Pick the discipline by the destination, not by default.

## Directory Standard

Multi-phase runs use the parent run-dir pattern. See `report-standardization.md`
Phase 1 → Location for the full structure.

Short version:

```
resources/research/reports/<topic-kebab>_run_<date>/
├── README.md                                        # run index
├── RESEARCH_REPORT_<topic>_master_v1_<date>.md      # master synthesis (canonical deliverable, root)
├── ph1/                                             # Phase 1 — phase report nests with its pillar files
│   ├── RESEARCH_REPORT_<topic>-ph1_v1_<date>.md     # Phase 1 synthesis
│   ├── P1_<name>.md
│   └── P2_<name>.md
└── ph2/                                             # Phase 2 — phase report nests with its pillar files
    ├── RESEARCH_REPORT_<topic>-ph2_v1_<date>.md     # Phase 2 synthesis
    ├── P7_<name>.md
    └── P8_<name>.md
```

Phase reports nest under their phase subdir alongside the pillar files they synthesize, not as siblings of master. Master alone sits at root because it is the canonical deliverable; phase reports are intermediate authorities and belong with the pillar files they consolidate. This corrects a prior pattern that placed phase reports as siblings of master, which created visual competition between the canonical artifact and its intermediates.

## Quality Gates (Multi-Phase Specific)

Run these in addition to `report-standardization.md` Quality Gates:

| Gate | Check |
|---|---|
| Phase cohesion | Each phase report stands alone — a reader could act on just ph1 |
| Cross-phase coverage | Master report identifies ≥3 cross-phase convergences OR explicitly states "no cross-phase convergence found" |
| Citation propagation | Inline-cite density in synthesis reports matches pillar files (no synthesis-level citation vacuum) |
| Scope-adjustment record | Every non-final phase report contains a Phase N+1 Scope Adjustments table |
| Master uniqueness | Master report contains content not present in any single phase report (real cross-phase synthesis, not stitching) |
| Standalone-readability | Master report passes the Standalone-Readability Lens sub-agent with ≤3 orphan anaphora + ≤5 AI-tell-vocabulary instances |

## Anti-Patterns

- **Master report = stitched phases.** If the master is just phase reports concatenated, the multi-phase structure was overhead with no payoff. Either rewrite to add cross-phase synthesis, or downgrade to single-phase next time.
- **Skipping the scope-adjustment pass.** Going straight from Phase N synthesis to Phase N+1 dispatch loses the upstream-informs-downstream value that multi-phase exists to capture.
- **Surfacing every adjustment to the user.** Phase 1 → 2 transitions with only minor scope clarifications do not need a checkpoint. Only material drift (>20% scope change, new emergent pillar) requires explicit gating.
- **Synthesis-level citation vacuum.** Pillar files have dense inline cites; the phase + master reports have few or none. See `report-standardization.md` Inline Citation Propagation for the discipline.
- **Flat directory.** Multi-phase artifacts in a flat `reports/` lose run cohesion. Use the run-dir pattern.

## Reference Example

The 2026-05-13 `claude-design-skill_run_2026-05-13/` directory in the research
repo (`resources/research/reports/claude-design-skill_run_2026-05-13/`) is a
worked example matching this protocol. Use it as a structural template when
launching the next multi-phase run.
