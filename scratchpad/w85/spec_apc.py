FENCE = r"""  __asm__ __volatile__("" : : "i"(0));   /* MATCH: pins the a0->a3 cursor parm copy at the
        top of the prologue (retail insn #1); without it sched2 sinks the copy to just
        before the numPlayers guard and reorg then steals it into the blez delay slot,
        displacing retail's `addu s1,zero,zero`. */
"""

DECL = r"""  tCarInfo *carInfo;
  tCarLineup *carLineup;
  short i;
"""

CASES = [
 ("A0 baseline", []),
 ("A1 fence removed", [(FENCE, "")]),
 ("A2 no fence + cursor local first",
  [(FENCE, ""), (DECL, DECL + "  int *cursor;\n"),
   ("  if (0 < streamData.numPlayers) {", "  cursor = stream;\n  if (0 < streamData.numPlayers) {")]),
 ("A3 no fence + register on stream param",
  [(FENCE, ""),
   ("static int *Front_AppendPlayerCarData(int *stream,tFEStream &streamData)",
    "static int *Front_AppendPlayerCarData(register int *stream,tFEStream &streamData)")]),
 ("A4 no fence + decl order i first",
  [(FENCE, ""), (DECL, "  short i;\n  tCarInfo *carInfo;\n  tCarLineup *carLineup;\n")]),
 ("A5 no fence + numPlayers via local",
  [(FENCE, ""), (DECL, DECL + "  short n;\n"),
   ("  if (0 < streamData.numPlayers) {", "  n = streamData.numPlayers;\n  if (0 < n) {")]),
 ("A6 no fence + guard as while",
  [(FENCE, ""),
   ("  if (0 < streamData.numPlayers) {\n    i = 0;\n    do {",
    "  i = 0;\n  if (0 < streamData.numPlayers) {\n    do {")]),
]
