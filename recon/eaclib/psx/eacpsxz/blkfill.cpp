/* eaclib/psx/eacpsxz/blkfill.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\blkfill.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   2 fns: blockclear@0x800F17A0, blockfill@0x800F17A4.  FULL reconstruction (disasm-v3 MIPS); no stubs.
 *
 *   blockfill(dst, n, val) = memset(dst, (unsigned char)val, n).  The binary is a hand-tuned filler:
 *   it broadcasts the low byte of `val` into a 32-bit word, swr's the unaligned head, then runs
 *   unrolled 0x80/0x10/4/1-byte aligned stores and an swl tail -- all pure performance; the observable
 *   result is exactly an n-byte memset.  blockclear(dst, n) FALLS THROUGH into blockfill with val=0
 *   (the asm sets a2=0 then drops straight into blockfill), i.e. blockclear = memset(dst, 0, n).
 */

extern "C" void blockfill(void *dst, int n, unsigned char val)  /* @0x800F17A4 */
{
    unsigned char *d = (unsigned char *)dst;
    while (n-- > 0)
        *d++ = val;
}

extern "C" void blockclear(void *dst, int n)                    /* @0x800F17A0 (falls into blockfill, val=0) */
{
    blockfill(dst, n, 0);
}
