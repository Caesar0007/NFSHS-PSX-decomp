/* eaclib/psx/eacpsxz/cluttype.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\cluttype.obj ; EACPSXZ.LIB.  1 fn @0x800FC250.  cluttype -- map a shape-id to its
 *   CLUT type code.  Ghidra nfs4-f.exe.c (cluttype) + IDA sig.
 */
extern "C" int cluttype(int shapeId);   /* @0x800FC250 */
extern "C" int cluttype(int shapeId)
{
    int t = 0;
    switch (shapeId) {
    case 0xf: case 0x10: t = 0x23; break;
    case 0x12: case 0x18: case 0x20: t = 0; break;
    }
    return t;
}
