---
type: IMPROVEMENT_BRIEF
status: Active
date: 2026-04-27
author: Claude Code (post-run analysis)
target_skill: titan-research
target_files:
  - SKILL.md (main)
  - references/agent-allocation.md (subagent dispatch)
  - references/emergence-protocol.md (degradation handling)
  - new: references/tooling-tiers.md
  - new: references/subagent-preflight.md
related_artifacts:
  - finance/planning/lessons/LESSON_titan-research-run-tooling-and-protocol-gaps_2026-04-27.md
  - ~/.claude/SETTINGS_PATCH_subagent-web-tool-allowlist_2026-04-27.md
priority: MEDIUM (skill produces usable output but degrades silently)
---

# Improvement Brief: Titan-Research Skill — Subagent Tooling + Protocol Gaps

## Why this brief exists

A 4-pillar Titan run on 2026-04-27 (Austin housing for Brandon) failed at the
subagent web-tool layer. All 4 parallel research agents reported
`WebFetch`/`WebSearch` denied and fell back to training-data-grade output. The
parent-context Claude improvised parent-side fetches to recover, but the skill
itself had no documented degradation path. Output was still usable, but the
skill's reliability story is broken under the current tooling configuration.

The settings-level fix is in a separate artifact
(`~/.claude/SETTINGS_PATCH_subagent-web-tool-allowlist_2026-04-27.md`). This
brief is for skill-level changes that prevent silent degradation regardless of
settings state.

See also the matching lesson at
`finance/planning/lessons/LESSON_titan-research-run-tooling-and-protocol-gaps_2026-04-27.md`
for the full incident narrative.

## Gap 1 — No tooling-tier guidance

### Current state

`SKILL.md` Phase 1 says "web search per assigned topics" with no fallback
playbook. `references/agent-allocation.md` (per the skill's TOC) has a
"Source Strategy" field in the pillar object schema but the example just says
`[strategy]`. No tier ladder documented anywhere.

### What's needed

A new file `references/tooling-tiers.md` documenting the tool tier ladder for
research:

- **Tier 1** — built-in `WebSearch` + `WebFetch` (Claude Code native).
  Fastest, lowest friction. Subject to permission allowlist.
- **Tier 2** — `crawl4ai` skill (anthropic-skills). Available via
  `Skill` tool invocation. Useful for deeper page extraction, JavaScript-rendered
  content, or when WebFetch returns insufficient data.
- **Tier 3** — Firecrawl MCP (when configured). Search + scrape with
  structured data extraction. Currently not in Brandon's MCP config.
- **Tier 4** — `mcp__plugin_context7_context7__query-docs` (Context7) for
  library docs specifically. Not relevant for non-library research.
- **Tier 5** — `mcp__Claude_in_Chrome__*` for authenticated/JS-heavy sites
  the user is already logged into. Most research doesn't need this.

The tier ladder gets referenced from:
- `SKILL.md` Phase 1 "Pillar Allocation" — agents specify primary + fallback
  tier per pillar.
- `references/agent-allocation.md` "Source Strategy" field — populate with
  tier names, not free text.

### Acceptance check

A future Titan run, when launching agents, can read the tier file and ask "if
WebFetch denies, what's my fallback?" and get a concrete answer.

## Gap 2 — No subagent preflight

### Current state

Phase 1 dispatches research subagents in parallel without verifying tool
availability. If 4 agents all fail the same way (as in the housing run),
1-2 minutes per agent are burned with no recovery.

### What's needed

A preflight step before parallel dispatch:

1. **Tool-availability ping** — first subagent run is a 30-second ping that
   tries `WebFetch` on a known-stable URL and reports success/denial.
2. **If denied**: parent context surfaces the issue, decides between
   (a) settings fix before dispatch, (b) tier-2 fallback (crawl4ai),
   (c) parent-only research with reduced parallelism.
3. **If success**: dispatch full parallel pillar set.

A new reference `references/subagent-preflight.md` codifies this flow with a
template ping prompt.

### Acceptance check

When subagent web access is broken, the skill catches it within 30 seconds
and surfaces options, instead of burning ~10 minutes of parallel-agent work.

## Gap 3 — No degradation playbook in `emergence-protocol.md`

### Current state

`references/emergence-protocol.md` (per skill TOC) covers emergence — finding
unexpected things during research. It does not cover the inverse: what to do
when expected tools fail.

### What's needed

Add a "Tool Degradation Protocol" section to `emergence-protocol.md` (or
split into `tool-degradation.md`):

1. **Detection** — agent reports tool denial or repeated 4xx/5xx.
2. **Tier escalation** — try next tier per `tooling-tiers.md`.
3. **Reduced-scope fallback** — if no tier works, pillar reports partial
   findings + explicit gap list, doesn't fabricate.
4. **Surface to user** — parent context asks user to choose: fix tooling
   (settings, MCP install) and rerun, or accept reduced-scope output with
   confidence calibration documented.

### Acceptance check

When the housing run happened, this protocol would have triggered after the
first agent denial; parent would have surfaced options instead of improvising.

## Gap 4 — Phase 0 brief-exists fork is ambiguous

### Current state

Phase 0 protocol in `SKILL.md` reads as "build brief from scratch via
dialogue or ingest." When the user provides a complete brief (as Brandon did
2026-04-27), the protocol's `references/input-dor.md` doesn't fork cleanly.
The Express Mode line says "skip brief" but Brandon's case wasn't express —
the brief was thorough.

I (Claude) interpreted "thorough brief = Phase 0 done, skip to Phase 1." The
skill's actual intent is probably "thorough brief = run validation gates +
generate execution plan, don't re-elicit content." Those are different
behaviors.

### What's needed

Explicit fork in Phase 0:

- **Path C — Brief Provided**: when the user provides a complete brief file
  path:
  1. Validate against scaffolding template (does it cover core question,
     success criteria, scope, constraints, hypothesis, anti-patterns, evidence
     bar?).
  2. If gaps: ask user to fill via 1-3 targeted AskUserQuestion calls.
  3. If complete: generate full Research Execution Plan with pillar object
     schema (priority, weight, depth, topics, source strategy by tier,
     validation, emergence allowance).
  4. Run Phase 0.5 Socratic Stress Test on the provided brief.
  5. Confirm with user before launching.

Update `references/input-dor.md` to add Path C.
Update `SKILL.md` Phase 0 dispatch to name the three paths (A/B/C).

### Acceptance check

A future "I have a brief, run titan against it" prompt produces the validated
execution plan + stress test, not a Phase-1 dispatch.

## Gap 5 — Mandatory Thinking File in Phase 0 is easy to skip

### Current state

`SKILL.md` Phase 0 says "Create Thinking File IMMEDIATELY" but Phase 0
intake-validation comes first conceptually. Under time pressure, the Thinking
File gets implicit-skipped (as it did 2026-04-27).

### What's needed

Either:
- **Hard gate**: SKILL.md says "do not proceed past Phase 0 without writing
  `_THINKING_*.md`" — and Phase 1 dispatch checks for the file.
- **OR redefine**: if Thinking File is genuinely optional under express mode,
  say so and document when it's required.

The current state is the worst of both: required by docs, skipped in practice,
no enforcement.

### Acceptance check

Future runs either produce a Thinking File or explicitly invoke express mode.

## Gap 6 — No Phase 5 Meta-Check enforcement

### Current state

Phase 5 Meta-Check is documented but not gated. Easy to skip when the report
"feels done." I skipped it 2026-04-27.

### What's needed

Make Meta-Check a checklist appended to the report front matter or a final
section that the report cannot be marked Complete without:

```yaml
meta_check:
  answered_question: yes/no/partial + 1-line note
  most_effective_or_obvious: assessment
  failure_mode_analysis: 1-2 lines
  load_bearing_assumption: 1 line
  emergence_restructure_check: yes/no + 1-line note
```

Empty or missing meta_check → report is Draft, not Active.

### Acceptance check

Reports without the meta_check block can't be promoted to Active.

## Out of scope for this brief (defer)

- Re-architecting agent-allocation.md pillar object schema beyond adding
  source-strategy-by-tier
- Sequential chaining improvements
- Multi-report synthesis (`meta-analysis.md`) changes
- Performance/latency tuning of subagent dispatch
- Adding new MCP tools (Firecrawl install, etc.) — settings/config layer

## Recommended sequence

If I (or a future Claude session) ships these fixes, this is the priority
order:

1. **Gap 2 (subagent preflight)** — biggest reliability win, smallest content
   change. Single new reference file + 5-line addition to SKILL.md Phase 1.
2. **Gap 1 (tooling tiers)** — enables Gap 2 to have something to fall back
   to. New reference file.
3. **Gap 3 (degradation playbook)** — connects Gaps 1 + 2 into a recovery
   flow. Section addition to existing reference.
4. **Gap 4 (Phase 0 fork)** — clarity win, prevents future "brief exists, what
   now" ambiguity.
5. **Gap 5 + 6 (enforcement)** — softer; could be deferred if higher-priority
   work is in queue.

Total effort estimate: 2-3 focused hours for Gaps 1-4. Gaps 5-6 are 30-60
minutes more.

## Validation strategy

After fixes ship, dry-run the skill on a tractable test case (a non-housing
research question with known good Tier 1 + Tier 2 paths) and verify:

- Preflight catches simulated tool denial.
- Tier escalation engages crawl4ai when WebFetch denied.
- Phase 0 with a pre-existing brief path produces validated execution plan +
  stress test, not Phase-1 dispatch.
- Final report has populated meta_check block.

If all four pass, mark this brief Complete.
