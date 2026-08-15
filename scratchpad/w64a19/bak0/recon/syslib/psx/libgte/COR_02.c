/* syslib/psx/libgte/COR_02.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgte.lib(COR_02.OBJ): ccos -- full-circle cosine.  Cosine is even, so the angle is
 *   made non-negative, reduced modulo one revolution (0x1000) with a *signed* `%` (the oracle's
 *   sra/sll/subu round-to-zero sequence -- NOT an andi mask, since gcc cannot prove the negated
 *   value is non-negative), then folded into the first quadrant and sign-corrected. */

extern int csincos(int angle, int *psin, int *pcos);   /* COR_01 */

/* @0x800F3728 : ccos(int a) -> cos (4.12) */
extern int ccos(int a)
{
    int s, c;
    if (a < 0) a = -a;
    a = a % 0x1000;
    if (a >= 0 && a < 0x400)             { int r; csincos(a, &s, &c); r = c;
                                           /* MATCH (W51-A6, 12 -> PASS 49/49): the FIRST
                                            * quadrant arm and the LAST one are byte-identical
                                            * tails ({addiu a1; jal; addiu a2; lw c}), so gcc's
                                            * cross_jump merges arm 1 INTO arm 4 and our body
                                            * comes out 6 insns short.  Retail keeps them
                                            * separate.  NO source spelling reaches it (12
                                            * measured: if/else-if, result funnel, per-arm
                                            * temps, signed compares, fall-through arm 4,
                                            * s-aliasing) -- every one compiles byte-identical
                                            * at 43 insns.  The zero-insn VOID-TAIL FENCE is
                                            * the sanctioned cross-jump DE-MERGER (w47-a1/a4/a5
                                            * fence family); it must sit AFTER the `r = c` load
                                            * so arm 1 keeps its OWN `lw c` (the fence before
                                            * the load leaves the load shared: 48/49, 1 diff),
                                            * and it must be the VOID `"i"(0)` form -- an
                                            * `"r"(c)` fence pins c in a temp and costs the
                                            * oracle's `lw v0` an extra `addu v0,a3,zero`
                                            * (49/49 but 4 diffs). */
                                           __asm__("" : : "i"(0)); return r; }
    if (a >= 0x400 && a < 0x800)   { csincos(0x7ff - a, &s, &c);  return -c; }
    if (a >= 0x800 && a < 0xc00)   { csincos(a - 0x800, &s, &c);  return -c; }
    if (a >= 0xc00 && a < 0x1000)   { csincos(0xfff - a, &s, &c);  return c;  }
    /* MATCH (w59-a10 BRANCH-TARGET AUDIT): the tail used to be an explicit
       `return c;` after the four arms.  That gated PASS (49/49 insns, the gate
       is branch-target lenient) but branched the LAST range test into the 4th
       arm's OWN `lw c` -- ours 10400005 vs retail 10400006 -- i.e. the
       out-of-range path fell into the 4th quadrant's result load instead of
       going straight to the shared epilogue.  The four quadrants are
       exhaustive after `a %= 0x1000` on a non-negative `a`, so the retail
       source simply FALLS OFF THE END (no final return; $v0 is left holding
       the last sltiu result, 0).  FALSIFIED on the way: `return 0;` and
       `int inLast = (...); if (!inLast) return inLast;` -- both make gcc build
       a separate `move v0,zero` block (+2/+3 insns, count mismatch); cse's
       record_jump_equiv does NOT hand the sltiu 0 back to a written return.
       Now 43/49 words byte-identical, the other 6 are %hi/%lo + jal relocs. */
}
