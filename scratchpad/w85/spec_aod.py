FENCE = "  __asm__(\"\" : : \"i\"(0));  /* parm-spill pin: keep s1 save+parm copy in prologue group */\n"
GUARD = "  if (0 < streamData.numOpponents) {\n    i = 0;\n    do {\n"

CASES = [
 ("B0 baseline", []),
 ("B1 fence removed", [(FENCE, "")]),
 ("B2 no fence + i=0 hoisted",
  [(FENCE, ""), (GUARD, "  i = 0;\n  if (0 < streamData.numOpponents) {\n    do {\n")]),
 ("B3 no fence + i=0 hoisted, blank line kept",
  [(FENCE, "\n"), (GUARD, "  i = 0;\n  if (0 < streamData.numOpponents) {\n    do {\n")]),
 ("B4 no fence + while form",
  [(FENCE, ""), (GUARD, "  i = 0;\n  while (i < streamData.numOpponents) {\n    {\n")]),
]
