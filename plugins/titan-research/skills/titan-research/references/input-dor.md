---
type: reference
status: active
version: 1.0
date: 2026-04-08
tags: [titan-research, intake, brief-building, dor]
usage: Load during Phase 0 when building a research brief
---

# Input DOR: Research Brief Definition of Ready

Active facilitation system for building research briefs. This is NOT a passive checklist.
Claude enters "Brief Building Mode" and guides the user through targeted questioning
to produce a brief that meets all quality gates before research launches.

## Facilitation Principles

- Ask questions, do not dump a blank template at the user
- One question cluster at a time (2-3 related questions max per turn)
- Use the user's answers to generate follow-up questions
- Fill sections ON BEHALF of the user based on their answers
- Flag when answers are too vague to act on
- Never let "I don't know" pass without probing: what WOULD you know if you did?

## DOR Phase 1: Foundation

Establish the structural core. Nothing proceeds without these.

**Questions to ask:**

1. Core Question: "What specific question are you trying to answer?"
   - Must be specific and answerable, not a topic dump
   - Reject: "Research AI" / Accept: "Should we adopt RAG vs fine-tuning for our support bot?"
   - If vague, reframe: "If this research succeeds perfectly, what decision does it unlock?"

2. Success Criteria: "What does a successful answer look like? What will you DO with it?"
   - Must tie to a decision or action
   - Reject: "Understand the landscape" / Accept: "Decide whether to build or buy"
   - Probe: "If I hand you the perfect report, what happens next?"

3. Scope: "What is IN and what is OUT?"
   - Define explicit boundaries (geography, time period, market segment, tech stack)
   - Probe: "What are you explicitly NOT asking about?"
   - Default: if no scope given, propose one and get confirmation

## DOR Phase 2: Gap Filling

With the foundation set, fill structural gaps.

**Questions to ask (skip genuinely non-applicable ones):**

4. Constraints: "What limits should I work within?"
   - Time, budget, capability, regulatory, organizational politics
   - Probe: "Are there solutions that are off the table even if they're best?"

5. First Principles: "What fundamental truths anchor this domain?"
   - Economics, physics, psychology, regulation that constrain the answer space
   - Probe: "What can't change regardless of what we discover?"

6. Unknowns: "What do you know you don't know? What might you be missing entirely?"
   - Known unknowns: questions they have but can't answer
   - Unknown unknowns: ask "What would an expert in this field tell you to worry about?"

7. Hypothesis: "Do you have a working theory? What do you suspect the answer is?"
   - Capture existing beliefs so research can challenge or confirm them
   - No hypothesis is fine; note it as "exploratory mode"

8. Anti-Patterns: "What answers should I avoid? What would a BAD report look like?"
   - Common anti-patterns: too generic, too theoretical, missing key comparisons
   - Probe: "What has frustrated you about previous research on this topic?"

9. Evidence Bar: "How rigorous should the evidence be?"
   - Standard: triangulated from 2-3 source types
   - High: academic or primary data required
   - Paranoid: adversarial stress-testing of every claim

## DOR Phase 3: Confirmation

Present completed brief for approval.

**Steps:**

1. Show a summary of all captured sections in the brief format
2. Highlight any sections left empty and confirm they are genuinely N/A
3. Ask: "Does this accurately capture what you need? Anything to add or change?"
4. On approval, mark brief as Validated and proceed to Phase 0.5 (Socratic Stress Test)

## Quality Gates

All must pass before research launches:

| Gate | Criteria |
|------|----------|
| Core Question | Specific, answerable, not a topic dump |
| Success Criteria | Tied to a concrete decision or action |
| Scope | Bounded with explicit IN/OUT |
| Constraints | Identified (even if "none") |
| Evidence Bar | Set (defaults to Standard if unspecified) |
| User Approval | Explicit "go" from user |

## Express Mode

Triggered by: "skip brief", "express mode", "just research it"

Express flow:
1. Capture core question only (still must be specific and answerable)
2. Auto-set: Standard evidence bar, general report format, broad scope
3. Skip dialogue phases
4. Note in brief: "Express mode; brief not fully validated"
5. Proceed directly to Phase 1

Express mode trades brief quality for speed. Use when the user has a clear,
well-formed question and urgency outweighs precision.

## Ingest Mode (Extract from Existing Inputs)

Triggered when the user provides pre-articulated inputs instead of answering
facilitation questions. Common inputs: voice-to-text transcripts, notes (Mem,
Apple Notes, etc.), existing documents, brain dumps.

**When to use:**
- User says "build the brief from this" and provides raw content
- User pastes a transcript, note, or document and asks for research
- User provides multiple inputs that together describe the research need

**Ingest process:**

1. **Extract and map**: Read all provided inputs. Map content to brief sections:
   - Stated problems/questions → Core Question
   - Desired outcomes → Success Criteria
   - Background information → Context (do not research)
   - Boundaries mentioned → Scope
   - Concerns/worries → Anti-Patterns
   - Theories/suspicions → Hypothesis
   - Specific asks → Specific Questions / Pillar Suggestions

2. **Fill gaps**: Provided inputs rarely cover all brief sections. After extraction:
   - Identify which DOR quality gates still fail
   - Ask ONLY about the missing sections (do not repeat what was provided)
   - Typically 2-3 questions max to close gaps

3. **Validate**: Run the same quality gates as dialogue mode
   - Core Question must be specific and answerable
   - Success Criteria must tie to a decision/action
   - Scope must be bounded

4. **Generate Research Execution Plan**: Same as dialogue mode — pillar
   decomposition is mandatory regardless of intake path

**Key difference from dialogue mode:** Ingest mode is extraction-first,
questions-second. Dialogue mode is questions-first. The output (a validated
brief with execution plan) is identical.

**Failure mode to avoid:** Do not discard user inputs and start fresh with
facilitation questions. The user already articulated their need. Extract first,
then fill gaps. Starting over feels dismissive.

## Edge Cases

**User provides a complete brief upfront:**
- Validate against quality gates
- Fill any gaps with 1-2 targeted questions
- Skip facilitation phases for sections already covered

**User changes scope mid-facilitation:**
- Update the brief, re-validate affected gates
- Do not restart from scratch

**User resists questioning ("just do it"):**
- Offer express mode
- If they decline express mode, capture what you have and note gaps as risks

**User provides voice-to-text with heavy transcription errors:**
- Silently correct obvious typos/homophones during extraction
- If a key section is genuinely unintelligible, quote the passage and ask for
  clarification rather than guessing
