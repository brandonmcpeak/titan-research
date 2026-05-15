# Use Titan in a Claude.ai project

This recipe documents how to run Titan inside a Claude.ai project for users who do not have Claude Code installed. Titan's methodology, report shape, acceptance gates, and humanizing patterns all apply; the only thing that does not carry over is subagent dispatch (see "Limitations" below).

For the primary Claude Code install, see the [main README](../README.md).

## Files to upload (16 total)

Upload all of the following into your Claude.ai project. They live under `plugins/titan-research/skills/titan-research/` in this repo:

- `SKILL.md`
- `references/agent-allocation.md`
- `references/brief-scaffolding.md`
- `references/definitions-and-concepts.md`
- `references/discussion-documents.md`
- `references/emergence-protocol.md`
- `references/humanizing-patterns.md`
- `references/input-dor.md`
- `references/meta-analysis.md`
- `references/multi-phase-protocol.md`
- `references/publication-grade-pass.md`
- `references/report-standardization.md`
- `references/sequential-chaining.md`
- `references/thinking-file.md`
- `references/upstreams.md`
- `scripts/acceptance-gates.sh`

Claude.ai's project file UI is flat (no folders). Drop everything in at the top level. SKILL.md contains a path-resolution preamble that tells the agent to fall back to basename lookup when `references/foo.md` does not resolve, so the flat-layout case is handled.

## Steps

1. Create a new Claude.ai project.
2. Upload the 16 files above.
3. Open project settings and paste the full contents of `SKILL.md` into the project instructions field. The skill is the system prompt for the project.
4. Start a new chat in the project. Invoke with:

   ```
   /titan-research <your research topic>
   ```

   If the slash command is not recognized, use the natural-language equivalent: "Run a Titan deep research investigation on `<topic>`."

5. Titan will Socratically stress-test the brief, build a thinking file, allocate pillars, and run the loop. For the Claude.ai path, the loop is single-phase by design (see Limitations).

## Limitations (be honest about the tradeoff)

- **No subagent dispatch.** Claude.ai projects cannot spawn parallel subagents. Anywhere SKILL.md or the references mention "dispatch N parallel pillar subagents," you, the operator, run the pillars yourself in sequence within the same chat. The methodology is the same; the parallelism is not.
- **Multi-phase orchestration falls back to single-phase.** The dependent-phase chaining pattern in `multi-phase-protocol.md` assumes Claude Code's filesystem and Agent tool. In Claude.ai, run one phase end-to-end, then start a new chat for the next phase if needed, manually carrying the prior phase's findings forward.
- **`acceptance-gates.sh` requires shell access.** If you do not have a terminal to run the script, work the 5 gates manually against the report. Each gate is documented in `references/publication-grade-pass.md` and `references/report-standardization.md` in plain English.

For multi-phase work at scale, install in Claude Code. The plugin install is two commands and the orchestration is native to the platform.
