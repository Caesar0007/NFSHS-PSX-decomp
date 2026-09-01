/* eaclib/psx/eacpsxz/isincos.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\isincos.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800EADBC (284 B): intsincos -- integer angle -> (sin,cos) in 16.16.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT a stub/thunk. C-linkage XDEF.
 *
 *   Angle is in "brads": a full circle = 1024, so quadrant = (angle>>8)&3, position = angle&0xFF
 *   (0..255 within the quadrant).  A single 257-entry quarter-sine table (sintbl[i] =
 *   sin(i*90deg/256) in 16.16, 0..0x10000) is folded across the four quadrants to yield sin/cos:
 *     q0: sin= T[p]      cos= T[256-p]
 *     q1: sin= T[256-p]  cos=-T[p]
 *     q2: sin=-T[p]      cos=-T[256-p]
 *     q3: sin=-T[256-p]  cos= T[p]
 *   sintbl @0x80137464 is SHARED (also read by intsin/sinfunc.c) -> declared extern here; the
 *   bytes are owned by the SYM-proven data-only sintbl.obj member.  This TU previously carried
 *   a SECOND, differently-named copy of the same 1028 bytes (`gSinTable`) -- a duplicate datum
 *   with no oracle symbol; removed w32-a5.
 *
 *   Gate 2026-07-26 (w32-a5): PASS 71/71.  The "switch-expander shape floor" verdict below was
 *   WRONG -- the divergence was not the compare tree at all (that already matched) but the ARM
 *   bodies: our build hoisted each arm's SECOND table load ABOVE the `*psin = ...` store (filling
 *   the load-delay), while the oracle emits store-then-load-then-nop strictly in source order.
 *   ROOT CAUSE: the table was declared `const`.  gcc-2.8 marks a `const` object's memory
 *   RTX_UNCHANGING_P, which lets the scheduler move a load of it across an aliasing-unknown store
 *   through `int *psin`.  Retail could NOT do that -> the original declared the table WITHOUT
 *   const.  Dropping `const` (`extern int sintbl[257];`) restores the sequential arm shape and the
 *   whole function falls out byte-exact: 73 diffs -> PASS in one edit.  (Not a hack: the oracle's
 *   three `lw; nop; sw` triples are the proof of the missing const.)
 *
 *   w33-a5: the "re-test sinfunc.c" follow-up is CLOSED as NOT-APPLICABLE.  SYM SLD proves
 *   sinfunc's obj is hand-written assembly (`C:\LIB\PSX\SINFUNC.ASM` @0x800F18E4 line 12), so it
 *   has no C codegen for `const` to perturb -- an A/B there is byte-identical both ways (intcos
 *   PASS 1 / intsin PASS 26 either way), and its `const` was kept.  Conversely THIS obj has no
 *   SLD records at all, which in eaclib is exactly the C-compiled signature (only the 15 .ASM
 *   objs kept line info) -- so the const-table lever belongs here and only here.
 */

extern int sintbl[257];   /* @0x80137464 : quarter-sine, 16.16.  NON-const ON PURPOSE -- see above:
                           * `const` lets gcc's scheduler hoist these loads across the *psin store
                           * and breaks the match.  Bytes live in sintbl.c/sintbl.obj. */

/* intsincos @0x800EADBC : write sin -> *psin, cos -> *pcos for a brads angle. */
extern void intsincos(int angle, int *psin, int *pcos)
{
    int quad = (angle >> 8) & 3;
    int p = angle & 0xFF;

    switch (quad) {
    case 0:
        *psin =  sintbl[p];
        *pcos =  sintbl[256 - p];
        break;
    case 1:
        *psin =  sintbl[256 - p];
        *pcos = -sintbl[p];
        break;
    case 2:
        *psin = -sintbl[p];
        *pcos = -sintbl[256 - p];
        break;
    case 3:
        *psin = -sintbl[256 - p];
        *pcos =  sintbl[p];
        break;
    default:
        return;
    }
}
