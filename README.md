# Titan-Research

> Titan: A multi-phase deep research protocol for Claude Code.
> For operators who need decision-ready intelligence, not topic surveys.
> Spawns subagents per pillar, adjusts scope between phases, ships a publication-grade master with verified citations.

**0.x permanent. No LTS, no backports, no API stability.** See [`STABILITY.md`](STABILITY.md).

## Quickstart

```
/plugin marketplace add brandonmcpeak/titan-research
/plugin install titan-research@brandonmcpeak
```

Then invoke from any Claude Code session:

```
/titan-research <topic>
```

## How it works

Titan spawns N parallel "pillar" subagents per phase, synthesizes their outputs, then adjusts pillar scope before the next phase runs. A two-pass publication-grade cycle (V1 → CRITIQUE → V2) produces a master report at consultant-briefing voice with verified citations.

The Verifier sub-agent pattern is inspired by [`companion-inc/feynman`](https://github.com/companion-inc/feynman); Titan generalizes it across multi-phase outputs as the always-on Standalone-Readability Lens. See [`plugins/titan-research/references/upstreams.md`](plugins/titan-research/references/upstreams.md) for the full attribution.

## First example

A single-phase report run, end-to-end, fits in one session. A worked example is in [`examples/`](examples/) (expanded with a real run in v2026.06).

## Scope

Titan is for operators making business decisions. It is NOT a general literature-survey tool, NOT a code generator, NOT a chatbot. If you need "what does the literature say," use [`companion-inc/feynman`](https://github.com/companion-inc/feynman). If you need "what should we do," try Titan.

## Customization

Three preset seams (documented at v0.1; loader implementation lands in v0.2):
- **Source quality scoring** — `presets/source-quality-*.yaml`
- **Output schema** — `presets/output-schema-*.yaml`
- **Phase definitions** — `presets/phases-*.yaml`

See `docs/presets.md` for schema and override mechanics.

## Philosophy

The methodology is the product. The skill is proof.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). Solo-maintained; ~4 hours/week budget; saying-no policy applies.

## Paired publishing (optional)

If you maintain a paired static research site, see [`docs/paired-site-companion.md`](docs/paired-site-companion.md) for an integration recipe.

## License

MIT. See [`LICENSE`](LICENSE).

---

*Built by [Brandon McPeak](https://brandonmcpeak.com).*
