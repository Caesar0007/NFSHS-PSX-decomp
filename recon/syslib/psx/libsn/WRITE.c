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
            if (n < (int)chunk) break;
        } while (len != 0);
    }
    return total;
}
