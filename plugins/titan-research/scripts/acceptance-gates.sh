#!/usr/bin/env bash
# acceptance-gates.sh — Phase 7 acceptance gates for publication-grade Titan research masters
#
# Runs the 5 hard gates from publication-grade-pass.md against a target markdown file.
# Exit 0 if all gates pass; exit 1 if any gate fails (with a per-gate report).
#
# Usage:
#   acceptance-gates.sh <path/to/RESEARCH_REPORT_*_v2_*.md>
#
# Reference: ~/.claude/skills/titan-research/references/publication-grade-pass.md
# First instance: agentic-harness-architecture_run_2026-05-15 (multi-source synthesis)
# First multi-phase instance: claude-design-skill_run_2026-05-13

set -u

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path/to/V2_master.md>" >&2
  exit 2
fi

F="$1"

if [ ! -f "$F" ]; then
  echo "FATAL: File not found: $F" >&2
  exit 2
fi

echo "=== Phase 7 Acceptance Gates ==="
echo "File: $F"
echo ""

all_pass=true

# Gate 1: Em-dash (U+2014) — must be 0 file-wide
EM=$(grep -c '—' "$F")
if [ "$EM" -eq 0 ]; then
  echo "PASS  Gate 1 — em-dash (count=$EM)"
else
  echo "FAIL  Gate 1 — em-dash (count=$EM); replace with comma, period, colon, parenthesis, or restructure"
  all_pass=false
fi

# Gate 2: Section-symbol shorthand in body — must be 0
SS=$(grep -c '§' "$F")
if [ "$SS" -eq 0 ]; then
  echo "PASS  Gate 2 — section-symbol (count=$SS)"
else
  echo "FAIL  Gate 2 — section-symbol (count=$SS); replace §N in body prose with longhand 'Section N'"
  all_pass=false
fi

# Gate 3: Banned vocabulary — must be 0
BV=$(grep -ciE '\b(comprehensive|robust|leverage|delve|tapestry|realm)\b' "$F")
if [ "$BV" -eq 0 ]; then
  echo "PASS  Gate 3 — banned vocab (count=$BV)"
else
  echo "FAIL  Gate 3 — banned vocab (count=$BV); replace per humanizing-patterns.md substitutions"
  echo "      Matches:"
  grep -inE '\b(comprehensive|robust|leverage|delve|tapestry|realm)\b' "$F" | head -10 | sed 's/^/        /'
  all_pass=false
fi

# Gate 4: Banned filler phrases — must be 0
BF=$(grep -ciE '(throughout this report|as we have seen|important to note|furthermore|moreover|worth noting)' "$F")
if [ "$BF" -eq 0 ]; then
  echo "PASS  Gate 4 — banned filler (count=$BF)"
else
  echo "FAIL  Gate 4 — banned filler (count=$BF); delete the filler, keep the substantive clause"
  echo "      Matches:"
  grep -inE '(throughout this report|as we have seen|important to note|furthermore|moreover|worth noting)' "$F" | head -10 | sed 's/^/        /'
  all_pass=false
fi

# Gate 5: Bracketed-multi citation in body prose (YAML frontmatter excluded) — must be 0
# YAML frontmatter is between the first two --- lines; everything after the second --- is body
BMC=$(awk '/^---$/{n++; next} n>=2' "$F" | grep -cE '\[[0-9]+, [0-9]+')
if [ "$BMC" -eq 0 ]; then
  echo "PASS  Gate 5 — bracketed-multi cite form (count=$BMC)"
else
  echo "FAIL  Gate 5 — bracketed-multi cite form (count=$BMC); convert [3, 32, 93] to single-bracket space-separated [3] [32] [93]"
  echo "      Matches:"
  awk '/^---$/{n++; next} n>=2{print NR": "$0}' "$F" | grep -nE '\[[0-9]+, [0-9]+' | head -10 | sed 's/^/        /'
  all_pass=false
fi

echo ""

# Soft metrics (not gates, but reported for visibility)
WC=$(wc -w < "$F" | tr -d ' ')
BODY_CITES=$(awk '/^## Sources & Citations/{exit} {print}' "$F" | grep -oE '\[[0-9]+\]' | wc -l | tr -d ' ')
echo "Soft metrics (informational):"
echo "  Word count:        $WC  (publication-grade target: 7-9K)"
echo "  Body inline cites: $BODY_CITES  (target: 30-60; ceiling soft, per-paragraph ≤3 is the hard rule)"
echo ""

if $all_pass; then
  echo "=== ALL HARD GATES PASS — V2 is publication-ready ==="
  exit 0
else
  echo "=== GATES FAILED — V2 is not yet publication-ready ==="
  echo "Apply targeted fixes and re-run."
  exit 1
fi
