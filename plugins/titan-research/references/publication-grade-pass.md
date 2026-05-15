---
type: reference
skill: titan-research
module: publication-grade-pass
phase: "Phase 4 / post-Phase-4 (after master draft composed, before publish)"
date: 2026-05-13
note: >
  Two-pass discipline for elevating a master report from V1 (AI-input-flavored)
  to V2 (publication-grade, 90-min consultant briefing voice). Heavier than
  the Standalone-Readability Lens in multi-phase-protocol.md; reserved for
  genuinely public-shareable masters.
---

# Publication-Grade Pass: V1 → CRITIQUE → V2

Two-pass discipline for elevating a master report from V1 (AI-input-flavored, dense citation, optimized for downstream agent consumption) to V2 (publication-grade, McKinsey Quarterly / HBR voice, ready for public sharing).

This is heavier than the Standalone-Readability Lens (see `multi-phase-protocol.md` Standalone-Readability Lens). The lens returns surgical findings; this pass produces a full V2 rewrite. Reserve for genuinely public-shareable masters.

## When to Load

Load this reference when:

- Brief frontmatter has `publication_grade: true` (explicit flag)
- Brief invokes "public-shareable" framing in scope or success criteria
- Master report is destined for the paired research site, published essay, client deliverable, or external partner
- User explicitly invokes the pass via `/titan publication` or similar

Skip when:

- Master is internal-only, decision-input for build, or AI-consumable artifact (SKILL_SPEC, planning doc downstream)
- A single-phase report serving as intermediate working document
- The Standalone-Readability Lens has run and the destination is internal sharing only

## The Two-Pass Cycle

```
1. Write master V1                            (per multi-phase-protocol.md)
2. Run Standalone-Readability Lens            (per multi-phase-protocol.md)
3. Dispatch self-critique sub-agent           (this doc, step 4)
4. Compose CRITIQUE_master-v1_<date>.md       (structured findings, this doc step 5)
5. Rewrite master as V2 against the critique  (full rewrite, this doc step 6)
6. Run grep verification checklist            (this doc step 7)
7. Retain V1 as intermediate working version  (do not delete; archive distinction)
```

## Self-Critique Sub-Agent Prompt

> Read the attached master report V1. Evaluate it against publication-grade standards (target voice: 90-minute consultant briefing, McKinsey Quarterly / Harvard Business Review long-form, Nielsen Norman Group reports).
>
> Produce a structured critique covering eight categories:
>
> 1. **Em-dash usage** (count + sample contexts; banned per `report-standardization.md` Output Style)
> 2. **Section-symbol shorthand in body prose** (count of `§N` outside headers; banned)
> 3. **AI-tell vocabulary** per `humanizing-patterns.md` Vocabulary Blacklist plus the publication-grade additions: comprehensive, robust, leverage (verb sense), delve, tapestry, realm
> 4. **Filler phrases**: "throughout this report", "as we have seen", "it's important to note", "furthermore", "moreover", "worth noting"
> 5. **Citation density violations** (paragraphs with more than 3 inline cites; per `report-standardization.md` Phase 2 Inline Citation Propagation rule 5)
> 6. **Bracketed-multi citation form** (e.g., `[3, 32, 93]`; should be single-bracket space-separated `[3] [32] [93]` per `report-standardization.md` Phase 2 Citation Format Mapping)
> 7. **Voice issues** (paragraphs that read like a LinkedIn post, corporate brochure, research-paper, or LLM output rather than consultant briefing)
> 8. **Structural issues** (tables/lists used for content that should be prose; dense claim-stacking; BLUF that buries the lede; restated cross-section references)
>
> Do NOT rewrite. Output a `CRITIQUE_master-vN_<date>.md` file with one numbered finding per issue. Each finding carries: location (line or section), severity (HIGH / MEDIUM / LOW), evidence quote, recommended fix in one sentence.

## CRITIQUE File Template

```yaml
---
type: CRITIQUE
status: Active
topic: <topic>
critique_of: RESEARCH_REPORT_<topic>_master_v1_<date>.md
date: <date>
version: 1.0
findings_total: <N>
findings_high: <N>
findings_medium: <N>
findings_low: <N>
---
```

Followed by numbered findings F1..FN, grouped by the eight categories above. Each finding:

```markdown
### F<N> — <category>: <one-line summary>
- **Location**: <section/line>
- **Severity**: HIGH | MEDIUM | LOW
- **Evidence**: > <quote>
- **Recommended fix**: <one sentence>
```

## V2 Rewrite Discipline

V2 is a FULL rewrite of body prose against the critique, NOT a surgical edit pass.

**Preserve verbatim:**
- All key findings and claims
- All numbered Sources & Citations entries
- Hypothesis verdicts (CONFIRMED / VALIDATED / COMPLICATED / NOT-SUPPORTED)
- Decision matrix rows (column descriptions may be tightened)
- Tabular content where the table is genuinely structural (hypothesis scorecards, source lists, glossaries, pillar synthesis indices)

**Rewrite:**
- **BLUF**: lead with the single most important finding; cap at 2-3 sentences
- **Cross-phase narrative**: explain WHY at consultant-briefing depth
- **Pillar synthesis prose**: trim citation density to ≤3 per paragraph; restate dense claim-stacks as readable arguments
- **Blind spots / falsification register**: keep tabular structure; restate the prose
- **Banned vocabulary**: remove all instances per the blacklist
- **Em-dashes**: replace with comma / period / colon / parenthesis / restructure
- **§N body refs**: replace with longhand ("the Hypothesis Scorecard")
- **Citation form**: convert all to single-bracket numeric `[N]` with space-separated multi-cite `[3] [32] [93]` at end-of-sentence

**Length target:** 7-9k words (down ~15-25% from V1, which typically lands at 9-12k for a 2-phase / 6-10-pillar master).

## Acceptance Gates (Grep Checklist)

Run after V2 composition. ALL must pass before V2 is marked publication-ready.

```bash
F='<path-to-V2-master>'

# 1. Em-dash check
test "$(grep -c '—' "$F")" -eq 0 && echo PASS-em-dash || echo FAIL-em-dash

# 2. §N section-symbol check
test "$(grep -c '§' "$F")" -eq 0 && echo PASS-section-symbol || echo FAIL-section-symbol

# 3. Banned vocabulary
test "$(grep -ciE '\b(comprehensive|robust|leverage|delve|tapestry|realm)\b' "$F")" -eq 0 \
  && echo PASS-banned-vocab || echo FAIL-banned-vocab

# 4. Banned filler
test "$(grep -ciE '(throughout this report|as we have seen|important to note|furthermore|moreover|worth noting)' "$F")" -eq 0 \
  && echo PASS-banned-filler || echo FAIL-banned-filler

# 5. Bracketed-multi-cite check (body prose only; YAML frontmatter excluded)
# Lists like `phases_covered: [1, 2]` in frontmatter are false positives.
BODY=$(awk '/^---$/{n++; next} n>=2' "$F")
test "$(printf '%s' "$BODY" | grep -cE '\[[0-9]+, [0-9]+')" -eq 0 \
  && echo PASS-cite-form || echo FAIL-cite-form

# 6. Citation density (manual audit)
# No automated grep. Orchestrator audits paragraph-level density.
# Target: ≤3 inline cites per paragraph. Total master inline-cite count: 30-60.
```

If any gate fails, the V2 is not yet publication-ready. Apply targeted fixes against the failing category and re-run the gates. Do not mark complete until all five automated gates and the manual density audit pass.

## Voice Target

90-minute consultant briefing voice. Reference exemplars: McKinsey Quarterly, Harvard Business Review long-form, Nielsen Norman Group reports.

Body prose explains WHY, not what. Tables and lists are reserved for genuinely structural content. Read-aloud test: if a paragraph sounds like a LinkedIn post or corporate brochure, redraft.

## Publication-Grade Vocabulary Blacklist (Additions)

Extends `humanizing-patterns.md` Vocabulary Blacklist with publication-specific additions:

| Phrase | Why | Substitution |
|---|---|---|
| comprehensive | LLM-spike adjective; rarely earns the claim | "complete", "full", or delete |
| robust | LLM-spike; vague | "reliable", "stable", or specific behavior |
| leverage (verb) | LLM-spike; jargon | "use", "apply", "build on" |
| tapestry, realm | Worn metaphors | Concrete noun for what's actually meant |
| journey-as-metaphor | Worn metaphor | "process", "sequence", specific phase |
| navigate-as-metaphor | Worn metaphor | "work through", "address", "handle" |

**Banned filler (extends `humanizing-patterns.md`):**

- throughout this report
- as we have seen
- it's important to note / it's worth noting
- furthermore, moreover

These extend (not replace) the `humanizing-patterns.md` list, which still applies to all synthesis-level output.

## Anti-Patterns

- **Skipping the CRITIQUE step.** Going from V1 directly to "V2 with edits" loses the structured-finding audit trail. The CRITIQUE file is the artifact that proves which issues were caught and which were missed.
- **Surgical-only V2.** If V2 is just V1 with em-dashes replaced, the voice issue (the deepest of the directives) was missed. V2 is a FULL prose rewrite at the BLUF, cross-phase, and pillar-synthesis level. Tables and source lists may be retained verbatim.
- **Auto-running on every master.** This pass is heavy. Reserve for genuinely public-shareable masters. The Standalone-Readability Lens handles the always-on case.
- **Deleting V1.** Retain V1 as intermediate working version. The critique trail starts at V1; future runs and future skill iterations may need to reference what was elevated.

## Reference Implementation

The 2026-05-13 claude-design-skill run is the worked example:

- V1 master: `resources/research/reports/claude-design-skill_run_2026-05-13/RESEARCH_REPORT_claude-design-skill_master_v1_2026-05-13.md`
- CRITIQUE: `resources/research/reports/claude-design-skill_run_2026-05-13/CRITIQUE_master-v1_2026-05-13.md` (29 findings; F25-F29 capture the publication-grade gap)
- V2 master: `resources/research/reports/claude-design-skill_run_2026-05-13/RESEARCH_REPORT_claude-design-skill_master_v2_2026-05-13.md`

Walk these three files in sequence to internalize the V1 → CRITIQUE → V2 progression. The V2 master is the discipline's reference implementation; the acceptance gates above were calibrated to pass on it.
