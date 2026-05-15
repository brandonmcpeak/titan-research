---
type: reference
status: active
version: 1.0
date: 2026-04-08
tags: [titan-research, report, standardization, output]
usage: Load during Phase 4 when building the research report
---

# Report Standardization: Build Protocol

Defines how research output is structured, cited, navigated, and finalized.
This is a FORMATTING operation, not an editorial one. Never remove content
during report standardization.

## Phase 1: File Setup

### Naming

```
RESEARCH_REPORT_topic-kebab-case_v1_YYYY-MM-DD.md
```

### Location

Save reports to: `resources/research/reports/`

For multi-phase runs (when `multi-phase-protocol.md` applies), use the parent run-dir pattern:

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

Phase reports nest under their phase subdir alongside the pillar files they synthesize. Master alone sits at root because it is the canonical deliverable.

For single-phase runs, keep the flat `reports/` structure above.

### YAML Front Matter

```yaml
---
type: RESEARCH_REPORT
status: Active
topic: topic-kebab-case
topic_area: [spirituality | business | technology | operations | career | finance | health]
destination: null
date: YYYY-MM-DD
version: 1.0
associated_brief: BRIEF_topic_v1_YYYY-MM-DD.md
tags: [tag1, tag2]
source: titan-research
---
```

- `associated_brief`: filename (not path) of the brief that launched this research
- `destination`: wiki-link stub path if report will be referenced from a vault note
- `status`: Active (current), Superseded (newer version exists), Archived

## Phase 2: Citation Architecture

### Citation Format Mapping (Pillar → Synthesis)

Pillar-level (subagent) outputs use named cites: `[Source Title]`. Synthesis-level (orchestrator) outputs convert to numbered cites: `[1][2][3]`. The Phase 4 synthesis pass MUST perform this conversion as part of building the Sources & Citations section.

Rationale: named cites survive subagent independence and edit-time renumbering (a subagent doesn't need to coordinate numbering with peers); numbered cites give publication discipline and at-a-glance density readability at the synthesis layer.

**Single-bracket form at synthesis level.** Numbered citations use single-bracket form `[N]`, one source per bracket. When multiple sources support an end-of-sentence claim, separate with spaces: `[3] [32] [93]`, NOT `[3, 32, 93]`. The Phase 4 conversion pass MUST emit this form. Verification: `grep -cE '\[[0-9]+, [0-9]+'` returns 0 in body prose.

### In-Text Citations

Use numbered references throughout the report:

```markdown
RAG architectures show 40-60% improvement in factual accuracy [1], though
fine-tuning outperforms on domain-specific tasks [2][3].
```

Rules:
- Sequential numbering, first appearance determines number
- Group related citations: [2][3], not [2, 3]
- Every factual claim requires at least one citation
- Distinguish primary sources from secondary interpretations

### Sources & Citations Section

Place at the end of the report:

```markdown
## Sources & Citations

[1] "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"
    Lewis et al., 2020 (https://arxiv.org/abs/2005.11401)

[2] Source Title
    Author/Org, Date (URL)

[3] Source Title
    Author/Org, Date (URL)
```

Source quality indicators (append where relevant):
- `[Primary]`: original data, 10-K, API docs, official documentation
- `[Peer-Reviewed]`: academic papers, journal articles
- `[Industry]`: reports from recognized firms (McKinsey, Gartner, etc.)
- `[Practitioner]`: blog posts, conference talks, forum discussions

### Inline Citation Propagation (Multi-Phase / Synthesis-Level)

When the report is a synthesis over upstream pillar files (multi-phase orchestrator output, meta-analysis, or chained-run inheritance):

1. The synthesis report MUST carry inline citations at the same density as the pillars. Each load-bearing claim traceable to a pillar finding must repeat the pillar's `[Source Title]` (or numbered) cite at the synthesis level.
2. The synthesis report's `Sources & Citations` section MUST be a consolidated numbered list with URLs + dates, deduplicated across propagated cites. NOT a bare "see companion files" wikilink list.
3. The companion-file wikilink list belongs in a separate "Further detail" or "Appendix" section, NOT under Sources.
4. Citation density target: synthesis reports should carry ≥15 inline cites; master reports across multiple phases should carry ≥40.
5. **Citation density ceiling (per paragraph):** synthesis output carries a maximum of 3 inline cites per paragraph. When a paragraph has more traceable claims than 3, group attributions at end-of-sentence or end-of-paragraph and drop the lower-relevance cites; readers can find them in the Sources section. Total inline-cite count target for a master synthesis: 30-60. The numbered Sources section's breadth holds at 100+ entries; only the body-prose visual density decreases.

## Phase 3: Research Success Report & Path Navigation

This section goes near the end of the report, before Sources & Citations.
It connects the research output back to the original brief and forward to next steps.

### Structure

```markdown
## Research Success Report & Path Navigation

### BLUF Assessment
[2-3 sentences. Did this research answer the core question from the brief?
What confidence level? What is the single most important finding?]

### Questions Answered
- [Core question]: [Answer summary with confidence]
- [Sub-question 1]: [Answer summary]
- [Sub-question 2]: [Answer summary]

### Remaining Questions
- [Questions the research could not fully answer]
- [Questions that emerged during research]

### Emergent Research Targets
- [New topics/questions discovered during research that warrant their own investigation]
- [Unexpected findings that open new lines of inquiry]

### Suggested Next Actions
1. [Highest leverage action] (confidence: X%)
2. [Second action]
3. [Third action]
```

### Action Quality Standard

Good actions are specific and executable:

```
GOOD: "Run a 2-week A/B test comparing RAG vs fine-tuning on 500 support tickets,
       measuring resolution accuracy and response latency"

BAD:  "Consider implementing RAG and evaluating its effectiveness"
```

Actions must include: what to do, how to measure, and what constitutes success or failure.

## Output Style (Synthesis-Level Discipline)

Synthesis-level output (the Phase 4 master report when public-shareable framing is invoked) carries discipline that pillar-level and intermediate-phase reports inherit but do not require. These rules apply when:

- Multi-phase master report (auto-applies; multi-phase masters are public-share by design)
- Single-phase report with `publication_grade: true` in brief frontmatter (explicit)
- User explicitly invokes via `/titan publication` or similar (explicit)

For the full publication-grade two-pass discipline (CRITIQUE then V2 rewrite), see `publication-grade-pass.md`. This section is the always-on style baseline; that file is the heavier two-pass cycle.

### Punctuation Discipline

Em dashes (U+2014, `—`) are banned in orchestrator-written prose: BLUF, cross-phase narrative, decision matrix prose, pillar synthesis, blind spots, falsification register, method notes, heuristics, glossary. Replace with comma, period, colon, parenthesis, semicolon, or sentence restructure. Pillar subagents inherit this rule.

Hyphens (`-`) and minus signs are unaffected. Only the em-dash character is banned.

Verification at Phase 4: `grep -c "—"` against the master file returns 0.

### Internal Section References

Body prose references to other sections of the same report use longhand: "the Hypothesis Scorecard", "the Decisions table", "the Cross-Phase Insights section". Section-symbol shorthand (`§N`) is reserved for headers (markdown numeric convention) and never appears in body prose.

Verification at Phase 4: `grep -c "§"` against the master file returns 0 in body. Allowed inside fenced code blocks when quoting an external source.

### Voice Target

Target: 90-minute consultant briefing voice. Reference exemplars: McKinsey Quarterly, Harvard Business Review long-form, Nielsen Norman Group reports.

Body prose explains WHY, not what. Tables and lists are reserved for genuinely structural content (hypothesis scorecards, decision matrices with column structure, source lists, glossaries, pillar synthesis indices).

Read-aloud test: if a paragraph sounds like a LinkedIn post or corporate brochure, redraft.

Banned vocabulary and filler phrases live in `humanizing-patterns.md` Vocabulary Blacklist. Publication-grade additions: comprehensive, robust, leverage (verb sense), tapestry, realm, throughout this report, as we have seen.

Verification at Phase 4: grep for the publication-grade vocabulary list against the master file returns 0.

### Scope Note

These rules apply to synthesis-level output: the master report when public-shareable framing is invoked. AI-consumable intermediate artifacts (Phase 1 / Phase 2 synthesis reports, pillar companions, SKILL_SPEC builds, planning docs) MAY be denser and more table-heavy; they are exempt from this section.

## Phase 4: Brief Status Update

After the report is finalized:

1. Update the associated brief's YAML front matter:
   - `research_completed: true`
   - `research_report: RESEARCH_REPORT_topic_v1_YYYY-MM-DD.md`
2. Rename brief file status from `TITAN-READY` to `RESEARCH-COMPLETE`
3. If the brief cannot be found, note the association in the report front matter only

## Quality Gates Before Finalization

Run these checks before marking the report complete:

| Gate | Check |
|------|-------|
| Core question answered | BLUF assessment directly addresses the brief's core question |
| Citations complete | Every factual claim has at least one citation |
| Sources listed | All in-text citation numbers have entries in Sources & Citations |
| No orphan citations | No Sources & Citations entries that are never referenced in text |
| Confidence calibrated | Confidence levels stated, not implied |
| Actions executable | Suggested actions are specific, measurable, time-bounded |
| Emergence captured | Emergent findings included, not suppressed |
| Front matter complete | All YAML fields populated |
| No em-dashes (synthesis) | `grep -c "—"` against the master file returns 0 (when public-shareable framing invoked; see Output Style) |
| Longhand section refs | `grep -c "§"` against the master file returns 0 in body prose |
| No banned vocab | grep for comprehensive, robust, leverage (verb), delve, tapestry, realm returns 0 |
| Citation density ceiling | No paragraph exceeds 3 inline cites; total master inline-cite count 30-60 |
| Single-bracket cite form | `grep -cE '\[[0-9]+, [0-9]+'` returns 0 in body prose (no bracketed-multi cites); exclude YAML frontmatter (e.g., `phases_covered: [1, 2]` is a false positive). See `publication-grade-pass.md` Acceptance Gates for the awk-based body-only check. |

## Content Preservation Rule

Report standardization is a FORMATTING operation:
- Restructure for clarity: YES
- Add navigation sections: YES
- Improve citation formatting: YES
- Remove, edit, or soften research findings: NEVER
- Change conclusions to be more palatable: NEVER
- Remove sections because they seem redundant: NEVER

If content seems wrong, flag it in the Research Success Report section.
Do not silently edit it out.
