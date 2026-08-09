/* syslib/psx/libgte/COR_03.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgte.lib(COR_03.OBJ): csin -- full-circle sine.
 *
 *   Sine is ODD, so unlike the sibling ccos (COR_02, cosine = even, one shared body) the sign
 *   of the argument survives to the result and the quadrant ladder is written out TWICE: the
 *   a<0 half negates the quadrant result on the way out, the a>=0 half returns it as-is.  The
 *   retail code duplicates it verbatim (two full copies in the oracle @800F3808 and @800F38A0),
 *   which is also why only the a<0 copy carries the signed-`%` round-to-zero correction:
 *   in the a>=0 copy gcc can see from the dominating `bgez` that the value is non-negative and
 *   drops the `+0xFFF` fixup (oracle 3 insns vs 6).
 *
 *   MATCH receipts (W52-A9, 85 diffs -> PASS 78/78):
 *     1. `a % 0x1000`, NOT `a & 0xfff` -- the oracle's sra/sll/subu is a SIGNED modulo
 *        (ccos already carries this note).  With `&` the body came out 19 insns short.
 *     2. `a = -a;` must be its OWN statement before the `%` (27 -> 14 diffs).  Fused as
 *        `a = (-a) % 0x1000;` gcc negates into a FRESH register and copies the result back
 *        (`negu a1,v1 ... subu v1,a1,v0`); split, it mutates `a` in place like retail
 *        (`negu v1,v1 ... subu v1,v1,v0`).
 *     3. the result variable `r` is BLOCK-SCOPED per half, not one function-scope local
 *        (14 -> 4 diffs).  One shared `r` = one pseudo = one register in both halves (a1);
 *        retail colours the a<0 half's result `$a2` and the a>=0 half's `$a1`, i.e. two
 *        independent pseudos.  Colouring the a<0 half `$a2` is also what frees `$a1` to be
 *        pre-loaded with `&sin` in the third guard's branch delay slot (retail
 *        `bnez v0,.L800F3884 [addiu a1,sp,0x10]` where the shared-`r` build emitted `nop`) --
 *        one decision, two symptoms.  (catalog SA "SYM BLOCK SCOPES ARE LOAD-BEARING")
 *     4. residual 4 diffs = the w48 EPILOGUE-SWAP class ($ra is the last callee-saved reg
 *        restored, so reorg steals the sp-adjust into the return slot).  Closed by the
 *        PER_FN_EPILOGUE_UNFILL entry for this TU -- exactly like the sibling COR_02/ccos.
 *
 *   `r` is deliberately left uninitialised on the "no quadrant matched" fall-through: the
 *   oracle does the same (`.L800F3898`/`.L800F391C` read a dead $a2/$a1), and the case is
 *   unreachable because `a % 0x1000` is always in [0,0xfff] after the negate. */

extern int csincos(int angle, int *psin, int *pcos);   /* COR_01 */

/* @0x800F37F8 : csin(int a) -> sin (4.12) */
extern int csin(int a)
{
    int s, c;

    if (a < 0) {
        int r;
        a = -a;
        a = a % 0x1000;
        if ((unsigned)a < 0x400)                { csincos(a, &s, &c);          r = s;  }
        else if ((unsigned)(a - 0x400) < 0x400) { csincos(0x7ff - a, &s, &c);  r = s;  }
        else if ((unsigned)(a - 0x800) < 0x400) { csincos(a - 0x800, &s, &c);  r = -s; }
        else if ((unsigned)(a - 0xc00) < 0x400) { csincos(0xfff - a, &s, &c);  r = -s; }
        return -r;
    }
    {
        int r;
        a = a % 0x1000;
        if ((unsigned)a < 0x400)                { csincos(a, &s, &c);          r = s;  }
        else if ((unsigned)(a - 0x400) < 0x400) { csincos(0x7ff - a, &s, &c);  r = s;  }
        else if ((unsigned)(a - 0x800) < 0x400) { csincos(a - 0x800, &s, &c);  r = -s; }
        else if ((unsigned)(a - 0xc00) < 0x400) { csincos(0xfff - a, &s, &c);  r = -s; }
        return r;
    }
}
