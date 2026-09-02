CASES = [
 ("C0 baseline", []),
 ("C1 drop volatile on ticks read",
  [("(short)*(volatile int *)ticks", "(short)ticks[0]")]),
 ("C2 drop volatile, keep deref spelling",
  [("(short)*(volatile int *)ticks", "(short)*(int *)ticks")]),
 ("C3 drop the MEMCARDFRONTENDISINITTED asm-label view",
  [("extern int MEMCARDFRONTENDISINITTED_words[] asm(\"MEMCARDFRONTENDISINITTED\");",
    "extern int MEMCARDFRONTENDISINITTED_words[];")]),
]
