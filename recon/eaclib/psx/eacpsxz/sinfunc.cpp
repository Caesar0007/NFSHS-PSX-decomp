/* eaclib/psx/eacpsxz/sinfunc.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\sinfunc.obj (EACPSXZ.LIB).  2 fns @0x800F18E4/0x800F18E8:
 *   fastintcos (alias intcos) + fastintsin (alias intsin).  FULL reconstruction (disasm-v3 MIPS).
 *
 *   Quadrant-folded quarter-sine lookup (full circle = 0x400, 0x100 = 90 deg).  quad=(a>>8)&3,
 *   pos=a&0xFF, on the shared 257-entry table gSinTable[i]=sin(i*90deg/256) (16.16):
 *     q0: T[pos]   q1: T[256-pos]   q2: -T[pos]   q3: -T[256-pos].
 *   fastintcos is the 4-byte entry that just does a += 0x100 (90 deg) and falls into fastintsin.
 *   gSinTable @0x80137464 is SHARED (also isincos) -> extern; the data pass owns its definition.
 */
extern "C" const int gSinTable[257];   /* @0x80137464 quarter sine, 16.16 */

extern "C" int fastintsin(int a)   /* @0x800F18E8 (alias intsin) */
{
    int pos = a & 0xFF;
    switch ((a >> 8) & 3) {
    case 0:  return  gSinTable[pos];
    case 1:  return  gSinTable[256 - pos];
    case 2:  return -gSinTable[pos];
    default: return -gSinTable[256 - pos];
    }
}

extern "C" int fastintcos(int a)   /* @0x800F18E4 (alias intcos); a += 90deg, fall into sin */
{
    return fastintsin(a + 0x100);
}

extern "C" int intsin(int a) __attribute__((alias("fastintsin")));
extern "C" int intcos(int a) __attribute__((alias("fastintcos")));
