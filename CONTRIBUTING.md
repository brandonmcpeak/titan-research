# Contributing

Titan-research is solo-maintained. Brandon McPeak budgets roughly 4 hours per week against this project. Contributions are welcome within that constraint.

## Saying-no policy

These will be closed without merge:
- Feature requests that expand scope beyond multi-phase deep research (this is a focused tool, not a general agent framework)
- "Make it work with X platform" without a working manifest contribution
- API-stability requests (see `STABILITY.md`)
- Backport requests

These are likely to merge:
- Bug fixes with a failing-test reproduction
- Documentation fixes (typos, broken links, unclear copy)
- New preset YAMLs under `presets/` that fit existing schemas
- Net-new examples under `examples/` showing real research runs

## PR checklist

Before opening a PR:
- [ ] Read `STABILITY.md` and confirm your change does not request stability
- [ ] If your change touches `SKILL.md` or any `references/*.md`, run `plugins/titan-research/scripts/acceptance-gates.sh` and confirm pass
- [ ] If your change is a new preset, include a fixture run showing the preset producing a valid output

## Response time

Within 7 days. If you have not heard back in 14 days, ping the issue.
