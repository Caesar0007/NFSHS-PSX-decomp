/* eaclib/psx/eacpsxz/shpdepth.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\shpdepth.obj ; EACPSXZ.LIB.  1 fn @0x800F43E4.  shapedepth -- bit depth from a
 *   shape's type byte (&0x77).  Ghidra nfs4-f.exe.c (shpdepth) + IDA sig.
 */
extern "C" int shapedepth(unsigned char *shape);   /* @0x800F43E4 */
extern "C" int shapedepth(unsigned char *shape)
{
    unsigned char t = *shape & 0x77;
    if (t == 0x41) return 8;
    if (t == 0x40) return 4;
    if (t == 0x42 || t == 0x23) return 0x10;
    if (t != 0x44) {
        if (t == 0x43) return 0x18;
        if (t == 0x72) return 8;
    }
    return 1;
}
