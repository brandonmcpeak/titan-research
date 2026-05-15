# Titan Research Engine

> A multi-phase deep research protocol for Claude Code.
> For operators who need decision-ready intelligence, not topic surveys.
> Spawns subagents per pillar, adjusts scope between phases, ships a publication-grade master with verified citations.

**0.x permanent. No LTS, no backports, no API stability.** See [`STABILITY.md`](STABILITY.md).

## Quickstart

Two install paths. Choose by where you work.

### Install in Claude Code (primary)

Requires Claude Code (free CLI). Works with any paid Claude plan that includes Claude Code access. Run from a terminal in any directory:

```
/plugin marketplace add brandonmcpeak/titan-research
/plugin install titan-research@brandonmcpeak
```

Then invoke from any Claude Code session:

```
/titan-research <your research topic>
```

Titan will Socratically stress-test the brief, build a thinking file, allocate pillars, and run the multi-phase loop. First run takes 30 to 90 minutes depending on phase count and source density.

### Use in a Claude.ai project (secondary)

If you do not have Claude Code, Titan also runs as a Claude.ai project. You will upload 16 files and set SKILL.md as the project instructions. The multi-phase orchestration falls back to single-phase (you run the parallel work yourself), but the methodology, report shape, acceptance gates, and humanizing patterns all apply.

[Read the Claude.ai recipe →](docs/use-in-claude-ai.md)

## How it works

Three sub-protocols compose Titan. Each is documented as a standalone reference in [`plugins/titan-research/skills/titan-research/references/`](plugins/titan-research/skills/titan-research/references/); the orchestrator (`SKILL.md`) sequences them.

**Multi-Phase Orchestration.** A Titan run is structured as N dependent phases. Each phase decomposes the work into pillars; pillar subagents run in parallel; outputs are synthesized between phases. Phase N+1 pillar scopes are rewritten from Phase N findings, not pre-frozen. Phase 0 (Intake Gatekeeper) and Phase 0.5 (Socratic Stress Test) act as quality gates: the work does not start until the brief survives premise validation.

**Publication-Grade Pass.** After the master draft is composed, Titan runs a two-pass cycle (V1 → CRITIQUE → V2). V1 is the dense, citation-saturated draft. CRITIQUE is a structured editorial pass that flags voice, density, and citation issues. V2 is the rewrite at consultant-briefing voice, with verified citations and a 90-minute-read shape. Reserved for genuinely public-shareable masters.

**Standalone-Readability Lens.** After every phase, an always-on Verifier-style sub-agent asks: would a stranger reading just this phase output understand what to do with it? If not, the synthesis is sharpened before the next phase runs. The Verifier sub-agent pattern is inspired by [`companion-inc/feynman`](https://github.com/companion-inc/feynman); Titan generalizes it across multi-phase outputs as a continuous readability gate rather than a final-step check. Full attribution in [`upstreams.md`](plugins/titan-research/skills/titan-research/references/upstreams.md).

## First example

The methodology is documented end-to-end in [`SKILL.md`](plugins/titan-research/skills/titan-research/SKILL.md) plus the 14 reference files in [`references/`](plugins/titan-research/skills/titan-research/references/). Published Titan reports will appear at [research.brandonmcpeak.com](https://research.brandonmcpeak.com).

## Scope

Titan is for operators making business decisions. It is NOT a general literature-survey tool, NOT a code generator, NOT a chatbot. If you need "what does the literature say," use [`companion-inc/feynman`](https://github.com/companion-inc/feynman). If you need "what should we do," try Titan.

## Customization

Three preset seams are documented at v0.1 as schema-only scaffolds:

- Source quality scoring
- Output schema
- Phase definitions

The loader that consumes these seams ships in a later version. Today, customization happens by forking the references in [`plugins/titan-research/skills/titan-research/references/`](plugins/titan-research/skills/titan-research/references/) and editing them directly.

## Philosophy

The methodology is the product. The skill is proof.

## Contributing

Solo-maintained with a deliberate small surface. See [`CONTRIBUTING.md`](CONTRIBUTING.md) for scope, saying-no policy, and how feature requests are evaluated.

## Paired publishing (optional)

If you maintain a paired static research site, see [`docs/paired-site-companion.md`](docs/paired-site-companion.md) for an integration recipe.

## License

MIT. See [`LICENSE`](LICENSE).

---

*Built by [Brandon McPeak](https://brandonmcpeak.com).*
