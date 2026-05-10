# Publish Prep (Optional Phase)

Load when a research artifact transitions from internal/private to publicly
shareable via a paired research site. Goal: catch personalization, context-window
assumptions, and clarity gaps that are correct/normal in an internal artifact
but read poorly to a fresh reader who never saw the brief or the chat context
that produced the report.

This is **separate from Phase 4 (output formatting)**. Phase 4 ensures the
report follows the Titan schema. Publish-prep ensures the report is fit for an
external reader.

## When this phase runs

- Manual trigger only. Invoke when flipping a report's `publish` frontmatter
  from `off` or `private` → `public`.
- Private direct-link sharing (e.g., a `listed: false` page sent to one
  recipient who has the surrounding context) typically does NOT need this
  phase. The recipient already shares the context window.
- Public listing (`listed: true`) always warrants the pass.

## Four lenses, run in parallel

Dispatch four sub-agents concurrently. Each operates in isolated context (no
shared state) and returns structured findings. The orchestrating agent
synthesizes into a single publish-prep report.

| Lens | Looking for | Examples (depersonalized) |
|---|---|---|
| **L1 personalization scrub** | PII, names, person-specific framing, internal artifact references, vault-path leaks | "Brandon's plan", "Ken's domain", "Report B handles…", `people/<x>/research/...` paths, "for our client" |
| **L2 context-assumption** | Statements that assume the reader knows the brief, chat context, or surrounding work | "This is the tooling we'll use" without saying who 'we' is; "as discussed earlier"; references to the brief without quoting it |
| **L3 continuity / fresh-eyes** | Dangling references, undefined-yet-used terms, transitions that need a bridge sentence for a cold reader | Section header changes that jolt; concepts introduced in passing then used as if fully defined; abrupt meta-section transitions |
| **L4 light readability** | Clarity-only suggestions where meaning is high-confidence preserved | Passive→active where actor is clear, removing ambiguous pronouns, splitting overlong sentences. **Skip** if the edit would alter meaning even slightly. |

### Lens prompts (template — adapt per artifact)

Each sub-agent is dispatched with a self-contained prompt. The prompt names the
lens, the file path, the severity rubric, and the output format.

**Severity rubric (used by all lenses):**

- **HIGH** — would visibly mislead, confuse, or expose a fresh reader. Must fix
  before public publish.
- **MEDIUM** — degrades public-read quality but does not expose private content
  or block comprehension. Should fix.
- **LOW** — small clarity wins, suggestion-only. Skip if cycle time matters.

**Output format (each lens returns):**

```yaml
findings:
  - id: L1-001
    severity: HIGH
    location:
      section: "§3 Key Findings #3"
      line: 45
    issue: "Names two specific individuals as the audience the tooling is screening."
    excerpt: "This is the tooling Ken Harris and Brandon will be screened by"
    suggested_edit:
      before: "This is the tooling Ken Harris and Brandon will be screened by"
      after: "This is the tooling now common in 2025–2026 hiring stacks"
  - id: L1-002
    ...
```

## Synthesis output: publish-prep working artifact

Filename: `PUBLISH_PREP_<slug>_<date>.md`. Located in the same directory as the
source artifact. Contains:

1. **Findings table** — # | severity | lens | location | issue | suggested edit
2. **Judgment-call forks** — items the human must decide (e.g., "keep meta-section
   vs. cut vs. wrap with `<!-- public:hide -->`")
3. **Apply guidance** — categorization of findings:
   - "Auto-apply candidate" (LOW-personalization, generalization-only, no meaning change)
   - "Surface-for-call" (HIGH/MEDIUM, requires explicit human decision)
4. **Diff preview** — proposed before/after for each apply-candidate finding

After human review and application, the prep doc is archived (or deleted —
working artifact, not deliverable).

## Source policy

**Edits land in source. NO public/internal version forking.**

Rationale: generalizations are mostly content quality improvements. "Public-fit"
is a quality property, not a watering-down. The source becomes more durable and
more reusable, not more sanitized.

### Exception: `<!-- public:hide -->` markers

For sections genuinely valuable internally AND inappropriate publicly (e.g., a
"Suggested next actions" subsection with the user's specific personal
applications), use HTML comment markers in source:

```markdown
<!-- public:hide -->
### Suggested next actions (prioritized by leverage)

1. For [specific person] — apply §X to [specific scenario]
2. ...
<!-- /public:hide -->
```

The site builder strips these regions before render. Source keeps full content
for internal reference. Use **sparingly**; default to generalizing rather than
hiding. Hiding is for content that has no honest generalization.

**Marker rules (enforced by build.mjs):**

- Markers must be balanced (every `<!-- public:hide -->` paired with a
  `<!-- /public:hide -->`).
- Unbalanced markers cause the build to fail-closed (refuse to render).
- Nested markers are not supported in v1.

## Versioning

No version bump for publish-prep edits unless meaning materially changes.
Generalizing "Brandon's resume" → "the candidate's resume" is a content fix,
not a new version. Substantively cutting an entire section warrants a note in
the file's status field but not necessarily a version increment. The frontmatter
`publish_status` and `publish_url` track deployed state; that's separate from
content version.

## Forward-looking notes (skill-extraction roadmap)

When titan-research is extracted to a standalone, publishable repository
(target: self-contained, not dependent on the local AI-operations system repo),
this phase remains optional. Users who do not run a paired research site
simply do not invoke it.

For users who do want to publish, the publish-prep capability should pair with:

- **A research-site scaffold** (build.mjs + manifest.json + template, with
  `<!-- public:hide -->` strip + `wrapTables` + index generator). The current
  reference implementation lives in
  `~/everything/resources/research/site/`. When extracted, this becomes a
  template the user can copy into a new repo + Vercel project.
- **The four-lens sub-agent specs** as user-configurable. A user with no PII
  concerns might skip L1; a user with multi-author work might expand L1 to
  include co-author names; a user publishing for a regulated industry might
  add a fifth lens (e.g., legal/compliance scrub).
- **The `<!-- public:hide -->` marker convention** as the standard build-time
  transform for internal-only content.
- **A `publish-properties` schema** parallel to the rule at
  `~/.claude/rules/publish-properties.md` — frontmatter fields (`publish`,
  `publish_status`, `publish_url`) that mirror manifest reality.

### Open questions for the standalone-repo state

- Should publish-prep be inside titan-research or in a separate
  `research-site` capability that titan-research optionally invokes? Leaning
  toward "inside titan-research" for v1; split out only if non-research
  artifacts (essays, briefs, post-mortems) need the same lenses.
- How does the four-lens spec generalize beyond research reports to other
  publishable artifact types? L1–L3 are likely portable; L4 is artifact-shape-
  dependent.
- How does this interact with sequential chaining? When Report N triggers
  Brief N+1, both are internal until publishing intent. Publish-prep on the
  whole chain at once may surface continuity issues across reports better
  than per-report passes.

## See also

- `~/.claude/rules/publish-properties.md` — frontmatter publish-field schema
  and reconciliation rules between source and manifest
- `~/everything/resources/research/site/build.mjs` — `<!-- public:hide -->`
  strip implementation; `wrapTables` precedent for build-time transforms
- `~/everything/resources/research/site/components.md` — markdown convention
  registry for the research site (cross-link callouts, etc.)
- Phase 4 of this skill (`references/report-standardization.md`) — the
  Research Success Report / Path Navigation section pattern is canonical
  Titan output. Publish-prep typically wraps this section with
  `<!-- public:hide -->` markers when it contains user-specific suggested
  next actions, while keeping the depersonalized "did the research answer
  the brief?" coverage table public.
