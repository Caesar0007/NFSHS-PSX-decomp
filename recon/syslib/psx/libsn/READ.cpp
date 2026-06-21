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
extern "C" int _SN_read(int chan, int fd, int len, int buff);   /* SNREAD (break 0x105) */

extern "C" int PCread(int fd, int buff, unsigned len)   /* @0x80106BE4 */
{
    int total = 0;
    if (len != 0) {
        do {
            unsigned chunk = len;
            if (len > 0x8000) chunk = 0x8000;
            int n = _SN_read(0, fd, (int)chunk, buff);
            total += n;
            if (n == -1) return -1;
            buff += n;
            len  -= n;
            if (n < (int)chunk) break;
        } while (len != 0);
    }
    return total;
}
