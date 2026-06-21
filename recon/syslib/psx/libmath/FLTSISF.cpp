/* syslib/psx/libmath/FLTSISF.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\FLTSISF.obj ; libmath.lib (PsyQ/GCC 2.7.2 soft-float).  1 fn __floatsisf @0x800F6224
 *   (180 B) -- REAL code (in EXE): convert a signed int to an IEEE-754 single (returned as its 32-bit pattern).
 *   Ghidra nfs4-f.exe.c, transcribed verbatim.  Round-to-nearest via the +0x40 bias.  Verified vs original
 *   MIPS via Unicorn oracle.  (The neighbouring SetLineF4 @0x800F62D8 is a DIFFERENT obj, not part of FLTSISF.)
 */
extern "C" int __floatsisf(int arg1)   /* @0x800F6224 */
{
    unsigned int sign = 0;
    int          exp  = 0x9d;
    unsigned int mant;
    if (arg1 == 0)
        return 0;
    if (arg1 < 0) { sign = 0x80000000; arg1 = -arg1; }
    for (; arg1 < 0x1000000;  arg1 = arg1 << 4) exp = exp - 4;
    for (; arg1 < 0x40000000; arg1 = arg1 << 1) exp = exp - 1;
    mant = arg1 + 0x40;
    if ((int)mant < 0) { exp = exp + 1; mant = mant >> 8; }
    else               {                mant = mant >> 7; }
    return (int)(sign | exp << 0x17 | (mant & 0xff7fffff));
}
