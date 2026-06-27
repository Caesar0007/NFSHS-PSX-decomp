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

/* blockclear @0x800F17A0 : 1-insn fall-through into blockfill -- sets a2=0 then drops straight through.
 * Cannot be expressed in C without a call; use file-scope asm to emit just the one insn. */
#if defined(__mips__)
__asm__(
"       .globl blockclear\n"
"blockclear:\n"
"       addiu   $a2, $zero, 0\n"       /* set val=0, then fall through into blockfill */
);
#else
extern "C" void blockclear(void *dst, int n) { blockfill(dst, n, 0); }
#endif

extern "C" void blockfill(void *dst, int n, unsigned char val)  /* @0x800F17A4 */
{
    unsigned char *d = (unsigned char *)dst;
    while (n-- > 0)
        *d++ = val;
}
