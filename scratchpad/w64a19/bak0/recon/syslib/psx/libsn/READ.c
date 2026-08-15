/* MATCH (w51-a8, 2026-08-09) -- *** cc1_272 LANE CANDIDATE: PCread PASSES BYTE-EXACT ***
 * PCread = 48/48 with PER_TU_FLAGS["recon/syslib/psx/libsn/READ.c"] = {"cc1_272": True}
 * PLUS one NEW build.py mechanism: a 272-lane EPILOGUE UNFILL.  The 2.7.2 lane
 * assembles with GNU as in .set-reorder mode and gas BACKWARD-FILLS the return delay
 * slot with the `addu $sp,$sp,N` frame release; retail leaves that slot empty
 * (`addiu sp,sp,0x30; jr ra; nop`).  Wrapping just this function's epilogue in
 * `.set noreorder` + an explicit nop on the .s before `as` reproduces retail exactly --
 * the 272-lane twin of build.py's PER_FN_EPILOGUE_UNFILL, which only runs in the 2.8
 * lanes and pattern-matches a cc1-emitted `.set noreorder/nomacro; j $31` block that
 * 2.7.2 never writes.  Probe implementation: scratch/w51_a8/patch272.py
 * (env W51_EPI_UNFILL=PCread).
 * Ladder: 2.8 lane 23 diffs @47-vs-48 | plain cc1_272 3 diffs @47-vs-48 | cc1_272 +
 * epilogue-unfill PASS 48/48.  Source unchanged.  The "irreducible callee-saved
 * COLORING ROTATION" recorded below is a 2.8-LANE artifact -- under 2.7.2 the whole
 * s-reg map is already exact.
 */
/* syslib/psx/libsn/READ.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 + m2c-verified structure).
 *   obj READ.obj ; libsn.lib.  PCread @0x80106BE4 (192 B) -- SN devkit host-PC file read: reads `len`
 *   bytes in <=0x8000 chunks via _SN_read, returns total read (or -1 on error; stops short on a
 *   partial read).  `len` is UNSIGNED (chunk test is `sltu len>0x8000`, hoisted out of a do/while);
 *   `buff` is an integer host address (m2c types it s32) advanced byte-wise by each chunk read.
 *
 *   STATUS: structurally byte-faithful (m2c-verified -- correct unsigned `sltu`, `beqz len` guard
 *   polarity, hoisted+recomputed loop condition, do/while).  Residual vs oracle is a gcc-2.7.2
 *   callee-saved COLORING ROTATION (oracle total=s2,buff=s3,fd=s4,(-1)=s5,(0x8000)=s6 ; cc1plus
 *   here buff=s2,total=s3,(-1)=s4,(0x8000)=s5,fd=s6).  Applying that rotation makes the bodies
 *   identical bar cascaded stack-slot offsets + one loop-exit delay-slot insn.  Invariant under
 *   every structural reframe tried (operand order, chunk int/uint, explicit cond, compound `||`
 *   exit, single/split return) -- an irreducible allocation tie-break.  Per HARD RULE: no register
 *   pins; faithful coloring near-miss, NOT a logic/transcription error.
 */
int _SN_read(int chan, int fd, int len, int buff);   /* SNREAD (break 0x105) */

int PCread(int fd, int buff, unsigned len)   /* @0x80106BE4 */
{
    int total = 0;
    if (len != 0) {
        do {
            unsigned chunk = len;
            int n;
            if (len > 0x8000) chunk = 0x8000;
            n = _SN_read(0, fd, (int)chunk, buff);
            total += n;
            if (n == -1) return -1;
            buff += n;
            len  -= n;
            /* MATCH (w48-a7, allocsim/reqdelta receipt): the short-read exit is a DUPLICATE
             * `return total;`, not a `break`.  jump.c cross-jumps the two copies back into ONE
             * shared tail (insn count unchanged) while flow.c still counts both refs -- and the
             * in-loop copy is loop-depth-weighted, so `total`'s REG_N_REFS goes 6 -> 8, crossing a
             * floor_log2 step (pri .545 -> 1.043) and lifting it above `buff` into the oracle's
             * $s2 (buff then takes $s3).  Predicted by tools/reqdelta.py before the edit. */
            if (n < (int)chunk) return total;
        } while (len != 0);
    }
    return total;
}
