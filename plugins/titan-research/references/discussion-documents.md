---
type: reference
skill: titan-research
module: discussion-documents
phase: post-research
date: 2026-04-08
---

# Discussion Documents

Protocol for creating structured analysis files after a research report is delivered.

## When to Create

**Trigger**: the user asks a follow-up question about a delivered research report,
and the response would exceed 500 words.

**Decision rule**:
- Response < 500 words: keep in chat, no file needed
- Response >= 500 words: create a discussion document

**Quick heuristic for estimating length**: if the answer requires analysis across
3+ dimensions, references multiple sources, or involves comparison/evaluation,
it will likely exceed 500 words. Create the file.

## File Naming

```
DISCUSSION_[topic-kebab-case]_q[N]_v1_YYYY-MM-DD.md
```

- `topic`: matches the parent report's topic slug
- `qN`: sequential question number (q1, q2, q3...)
- `v1`: version, incremented if the discussion is revised
- Date: creation date

Example: `DISCUSSION_llm-pricing-models_q2_v1_2026-04-08.md`

## File Structure

### YAML Front Matter

```yaml
---
type: DISCUSSION
status: Active
parent_report: RESEARCH_REPORT_topic_v1_YYYY-MM-DD.md
question_number: N
question: "The user's original question"
date: YYYY-MM-DD
version: 1.0
tags: [inherited from parent report]
source: titan-research
---
```

### Body Sections

```markdown
# Discussion: [Topic] - Q[N]

## BLUF
[1-2 sentence synthesis of the new insight, updated with each discussion round]

## Original Question
[User's question, verbatim or lightly cleaned]

## Analysis
[Full response to the question with citations back to the parent report
and any new sources discovered during analysis]

## Impact on Original Findings
[How this discussion changes, reinforces, or challenges the parent report's
conclusions. If no impact, state explicitly.]

## Updated Recommendations
[Only if the analysis materially changes the parent report's recommendations.
Otherwise omit this section.]
```

## Linking

- Discussion documents link back to the parent report via `parent_report` in
  front matter
- The parent report does NOT get modified to link forward to discussions
- If a discussion surfaces findings significant enough to warrant a report
  update, that is a separate version bump on the report itself

## Accumulation

Multiple discussions on the same report share the same topic slug and increment
the question number. The BLUF in each discussion should synthesize that
question's specific insight, not attempt to re-summarize the entire report.

## Filing Location

Same directory as the parent report: `resources/research/reports/`
