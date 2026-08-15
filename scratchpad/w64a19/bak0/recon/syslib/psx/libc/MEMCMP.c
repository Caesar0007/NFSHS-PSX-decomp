/* MATCH (w51-a8, 2026-08-09) -- *** cc1_272 LANE CANDIDATE: THIS TU PASSES BYTE-EXACT ***
 * memcmp = 19/19 when built through build.py's 04M gcc-2.7.2 lane, i.e. with
 *     PER_TU_FLAGS["recon/syslib/psx/libc/MEMCMP.c"] = {"cc1_272": True}
 * (PsyQ 4.0 CC1PSX + direct GNU as in reorder mode, -G0).  Under the 2.8 lane the
 * SAME source is a 6-diff near-miss at 17-vs-19 insns.  Source unchanged; lane only.
 * -G is inert here (G0/G4/G8 identical).  Measured with scratch/w51_a8/vf.py, an
 * out-of-band PER_TU_FLAGS injector (this agent was not permitted to edit build.py).
 */
/* syslib/psx/libc/MEMCMP.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\MEMCMP.obj ; libc.lib.  1 fn memcmp @0x80103734 (76 B) -- REAL code (in EXE).
 *   Faithful to disasm-v3 (byte-compare loop; the PsyQ memcmp reads >=1 byte even for n==0).
 *   No reference C body exists (psyz/psy-q/sotn all leave memcmp as INCLUDE_ASM).
 *
 *   VERIFY: 22 -> 6 diffs (13 -> 17 insns, oracle 19).  The oracle's exact CFG (decrement-block
 *   physically FIRST, entered via an unconditional `j` past it on the first pass; `beq`-taken path
 *   folds `a++` into the branch delay slot; the mismatch/untaken path then UNDOES that increment
 *   (`addiu a0,a0,-1`) and RE-LOADS both bytes from memory instead of reusing the already-loaded
 *   compare registers) is reproduced with a literal `goto`-CFG transcription + `*a++` post-increment
 *   in the compare (naturally produces the speculative-increment-then-undo) + a `volatile` cast on
 *   the final re-read (defeats gcc's CSE of the two lbu's already sitting in v1/v0 from the compare --
 *   the oracle's gcc-2.8 didn't CSE across this block boundary either, hence its redundant reload).
 *   RESIDUAL 6-diff FLOOR: our `return 0` epilogue folds straight to `jr ra` (delay-slot `move v0,zero`)
 *   and the mismatch tail folds its final `lbu;nop;subu` into `lbu;jr ra[delay:subu]` -- ONE insn
 *   shorter than the oracle, which keeps a separate `nop` and routes BOTH exits through one shared
 *   `jr ra;nop` epilogue via an explicit `j`. Same un-merged/cross-jumped-tail class already accepted
 *   as a floor on MEMMOVE (see below) -- gcc's cross-jump tail-merge pass is a codegen-density
 *   decision our weaker-optimizing build didn't make the same way; not reachable by restructuring the
 *   C (tried: single shared `return result;` via goto-done -- no change).
 */
extern int memcmp(void *s1, void *s2, int n)   /* @0x80103734 */
{
    unsigned char *a = (unsigned char *)s1;
    unsigned char *b = (unsigned char *)s2;
    goto compare;
decr:
    if (--n <= 0)
        return 0;
    b = b + 1;
compare:
    if (*a++ == *b)
        goto decr;
    a = a - 1;
    return (int)*(volatile unsigned char *)a - (int)*(volatile unsigned char *)b;
}
