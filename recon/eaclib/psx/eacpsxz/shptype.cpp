/* eaclib/psx/eacpsxz/shptype.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\shptype.obj ; EACPSXZ.LIB.  1 fn @0x800FC294.  shapetype -- map a shape-id to its
 *   pixel/format type code.  Ghidra nfs4-f.exe.c (shptype) + IDA sig.
 */
extern "C" int shapetype(int shapeId);   /* @0x800FC294 */
extern "C" int shapetype(int shapeId)
{
    int t = 0;
    switch (shapeId) {
    case 1:  t = 0x44; break;
    case 4:  t = 0x40; break;
    case 8:  t = 0x41; break;
    case 0xf: case 0x10: t = 0x42; break;
    case 0x18: t = 0x43; break;
    case 0x20: t = 0; break;
    }
    return t;
}
