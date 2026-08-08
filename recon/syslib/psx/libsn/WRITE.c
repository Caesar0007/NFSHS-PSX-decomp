/* MATCH (w51-a8, 2026-08-09) -- *** cc1_272 LANE CANDIDATE: PCwrite PASSES BYTE-EXACT ***
 * PCwrite = 48/48 with PER_TU_FLAGS["recon/syslib/psx/libsn/WRITE.c"] = {"cc1_272": True}
 * PLUS one NEW build.py mechanism: a 272-lane EPILOGUE UNFILL.  The 2.7.2 lane
 * assembles with GNU as in .set-reorder mode and gas BACKWARD-FILLS the return delay
 * slot with the `addu $sp,$sp,N` frame release; retail leaves that slot empty
 * (`addiu sp,sp,0x30; jr ra; nop`).  Wrapping just this function's epilogue in
 * `.set noreorder` + an explicit nop on the .s before `as` reproduces retail exactly --
 * the 272-lane twin of build.py's PER_FN_EPILOGUE_UNFILL, which only runs in the 2.8
 * lanes and pattern-matches a cc1-emitted `.set noreorder/nomacro; j $31` block that
 * 2.7.2 never writes.  Probe implementation: scratch/w51_a8/patch272.py
 * (env W51_EPI_UNFILL=PCwrite).
 * Ladder: 2.8 lane 23 diffs @47-vs-48 | plain cc1_272 3 diffs @47-vs-48 | cc1_272 +
 * epilogue-unfill PASS 48/48.  Source unchanged.  The "irreducible callee-saved
 * COLORING ROTATION" recorded below is a 2.8-LANE artifact -- under 2.7.2 the whole
 * s-reg map is already exact.
 */
/* syslib/psx/libsn/WRITE.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 + m2c-verified structure).
 *   obj WRITE.obj ; libsn.lib.  PCwrite @0x80106D50 (188 B) -- SN devkit host-PC file write: writes
 *   `len` bytes in <=0x8000 chunks via _SN_write, returns total written (or -1 on error; stops short
 *   on a partial write).  Identical shape to PCread: `len` is UNSIGNED (chunk test `sltu len>0x8000`
 *   hoisted out of a do/while); `buff` is an integer host address advanced byte-wise per chunk.
 *
 *   STATUS: same as PCread -- structurally byte-faithful (m2c-verified), residual is the identical
 *   gcc-2.7.2 callee-saved COLORING ROTATION (irreducible allocation tie-break, invariant under
 *   every structural reframe).  Per HARD RULE: no register pins; faithful coloring near-miss.
 */
int _SN_write(int chan, int fd, int len, int buff);   /* SNWRITE (break 0x106) */

int PCwrite(int fd, int buff, unsigned len)   /* @0x80106D50 */
{
    int total = 0;
    if (len != 0) {
        do {
            unsigned chunk = len;
            int n;
            if (len > 0x8000) chunk = 0x8000;
            n = _SN_write(0, fd, (int)chunk, buff);
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
