---
type: reference
skill: titan-research
module: humanizing-patterns
phase: "Phase 4 (Output) — final punch-up before publishing standalone artifacts"
date: 2026-05-13
note: >
  Detect-and-strip patterns for AI-generated long-form prose intended for
  standalone publication. NOT a full rewrite system. Surgical only.
---

# Humanizing Patterns (Punch-Up, Not Rewrite)

A small, durable pattern set for the final editorial pass on AI-generated
research artifacts intended for standalone publication. The intent is
**surgical punch-up** — detect specific tells, apply specific moves, stop.
NOT a full voice-rewrite. Heavy rewriting belongs in `publish-prep.md` or
a separate editorial step.

## When to Use

Load this reference when:
- A research report is about to be shared publicly (research site, social, email)
- The master report of a multi-phase run is composed (per `multi-phase-protocol.md` Standalone-Readability Lens — this file backs that lens)
- A long-form artifact reads "AI-y" on first read and you want a quick, low-risk pass

Skip this reference when:
- The artifact is internal-only and content correctness is the bar
- The artifact is short (≤300 words) — these patterns assume long-form text where the tells accumulate
- A heavy rewrite is needed anyway (skip the punch-up, do the rewrite)

## Vocabulary Blacklist (Detect-and-Strip)

These phrases are high-frequency AI tells that rarely earn their place in standalone prose. Detect them and substitute or delete:

| Phrase | Why it's a tell | Substitution |
|---|---|---|
| furthermore, moreover, additionally, in addition | Connective filler that almost never reduces uncertainty | Delete; let the sentence stand |
| pivotal, delve, leverage (as verb), facilitate | LLM-frequency-spike words | "Key", "examine", "use", "enable" |
| in conclusion, to conclude, in summary | Restates what was just said | Delete; trust the reader |
| it's important to note, it's worth noting, notably | Pre-announces importance that the next clause should demonstrate | Delete the preamble; keep the clause |
| navigate, journey, landscape (as metaphors) | Worn metaphors | Concrete noun for what's actually meant |
| Let's dive in, Let me explain, Let me walk you through | Dialogue scaffolding | Delete; just start the explanation |
| comprehensive | LLM-spike adjective; rarely earns the claim | "complete", "full", or delete |
| robust | LLM-spike; vague | "reliable", "stable", or specific behavior |
| tapestry, realm | Worn metaphors | Concrete noun for what's actually meant |
| throughout this report, as we have seen | Self-referential filler that betrays AI-summary framing | Delete; the reader can navigate the report |

The list grows with each run; add tells you notice repeatedly.

**Publication-grade additions:** the bottom four rows (`comprehensive`, `robust`, `tapestry`/`realm`, `throughout this report`/`as we have seen`) were surfaced by the 2026-05-13 V2 self-critique pass on the claude-design-skill master report. They are extensions to the always-on baseline, applied at synthesis-level (the master report when public-shareable framing is invoked). See `publication-grade-pass.md` for the full discipline.

## Sentence-Shape Moves

These are the patterns to apply, not detect. One or two per major section is enough:

- **Vary sentence length 4-25 words.** AI defaults to ~15-word sentences in clusters. Mix short (4-8 words) with longer (18-25 words).
- **Include ≥1 one-word or one-clause sentence per long section.** Punctuation shock breaks AI-rhythm. ("This matters." "Hard stop." "Here's why.")
- **Active voice default.** Passive only when the subject is genuinely unimportant or unknown.
- **Start ≥1 paragraph per major section with a single word or short hook.** Breaks the all-paragraphs-start-with-a-noun-phrase AI rhythm.
- **Use contractions where register allows** (don't, I've, we're, it's). Match house style; avoid forced contractions in formal sections.

## Content-Shape Moves

- **One concrete anecdote, example, or worked case per major claim.** Stories are the most reliable antidote to AI abstraction.
- **First-person where it preserves voice.** Avoid in objective reports unless the system itself is the speaker.
- **Metaphors anchor abstract claims to physical objects or motions.** "The pipeline backs up" beats "the workflow encounters throughput limitations."

## Orphan-Anaphora Detection (Scaffolding Artifacts)

Specific to standalone-readability: detect references whose antecedents don't appear in the artifact:

- "as discussed above" / "as I mentioned" / "the previous section" — with no such section/discussion in the artifact
- "this approach" / "that pattern" / "the example" — with no clear antecedent (the antecedent existed in the dialogue, not the text)
- "going back to your question" / "to your point" / "let me clarify" — conversational continuations from the dialogue
- "Let's dive in" / "I'll walk you through" / "Let me explain" — implicit dialogue framing

For each detected orphan: either (a) add the missing antecedent explicitly, or (b) delete the orphan reference. Do not leave dangling.

## Anti-Patterns (Don't Overcorrect)

- **Don't strip all connectives.** Some "however" and "but" are load-bearing. Strip the filler ones (furthermore, moreover), keep the contrast ones.
- **Don't substitute uniformly.** "Use" is not always the right replacement for "leverage." Read the sentence; pick context-appropriate language.
- **Don't add anecdotes that didn't happen.** A fake worked example is worse than an abstract claim.
- **Don't shorten every sentence.** Variety is the point. Uniformly-short prose reads choppy.
- **Don't apply to in-conversation messages.** This is for standalone published artifacts. Conversational messages can keep their conversational tells.

## Worked Example (Before / After)

Before:
> Furthermore, it's important to note that RAG architectures demonstrate significant improvement in factual grounding, particularly when leveraged in domain-specific contexts. As discussed above, the journey toward production-ready retrieval involves navigating several pivotal trade-offs.

After:
> RAG architectures improve factual grounding, especially in domain-specific contexts. Production-ready retrieval involves real trade-offs — index freshness, retrieval latency, chunk size — each with a real cost.

Three of four tells stripped (furthermore, it's important to note, leveraged, journey, navigating, pivotal). Sentence length varied (8 / 19 words). Concrete trade-offs replacing abstract framing. "As discussed above" deleted (orphan).

## Reference Use

This file is loaded by `multi-phase-protocol.md` Standalone-Readability Lens. The lens dispatches a sub-agent prompted with this file's detect patterns; the orchestrator applies the surgical moves in-line. Can also be loaded directly during `publish-prep.md` lens passes.
