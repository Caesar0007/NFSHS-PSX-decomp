/* syslib/psx/libsn/READ.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3; IDA over-simplified the loop).
 *   obj READ.obj ; libsn.lib.  PCread @0x80106BE4 (192 B) -- SN devkit host-PC file read: reads `len` bytes
 *   in <=0x8000 chunks via _SN_read, returns total read (or -1 on error; stops short on partial read).
 */
extern "C" int _SN_read(int chan, int fd, int len, int buff);   /* SNREAD (break 0x105) */

extern "C" int PCread(int fd, char *buff, int len)   /* @0x80106BE4 */
{
    int total = 0;
    if (len == 0) return 0;
    do {
        int chunk = len;
        if (0x8000 < len) chunk = 0x8000;
        int n = _SN_read(0, fd, chunk, (int)buff);
        total += n;
        if (n == -1) return -1;
        buff += n;
        len  -= n;
        if (n < chunk) return total;
    } while (len != 0);
    return total;
}
