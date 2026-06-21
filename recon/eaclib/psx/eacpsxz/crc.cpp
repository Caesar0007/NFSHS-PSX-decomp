/* eaclib/psx/eacpsxz/crc.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\crc.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800F614C.  crc16 -- a table-driven CRC-16 (two 256-byte tables) processing 4 bytes/iteration.
 *   Ghidra nfs4-f.exe.c (crc) + IDA sig.  The tables @DAT_80135c58/DAT_80135d58 are rodata (data-mat #75).
 */
extern "C" unsigned char DAT_80135c58[256];   /* @0x80135C58 : CRC table A [256] */
extern "C" unsigned char DAT_80135d58[256];   /* @0x80135D58 : CRC table B [256] */

extern "C" unsigned int crc16(unsigned char *buf, int len);   /* @0x800F614C */

/* crc16 @0x800F614C : running CRC-16 over `buf[0..len)`; 4-byte unrolled body then a 1-byte tail. */
extern "C" unsigned int crc16(unsigned char *buf, int len)
{
    unsigned int hi = 0xfb;
    unsigned int lo = 0xea;
    while (-1 < len + -4) {
        unsigned char b1, b2;
        hi = (unsigned int)buf[1] ^ (unsigned char)DAT_80135c58[*buf ^ lo] ^ hi;
        b1 = buf[2] ^ DAT_80135c58[hi] ^ DAT_80135d58[*buf ^ lo];
        b2 = buf[3] ^ DAT_80135c58[b1] ^ DAT_80135d58[hi];
        hi = (unsigned int)(unsigned char)DAT_80135d58[b2];
        lo = (unsigned int)(unsigned char)(DAT_80135c58[b2] ^ DAT_80135d58[b1]);
        buf = buf + 4;
        len = len + -4;
    }
    while (len = len + -1, -1 < len) {
        unsigned int idx = *buf ^ lo;
        lo = (unsigned char)DAT_80135c58[idx] ^ hi;
        buf = buf + 1;
        hi = (unsigned int)(unsigned char)DAT_80135d58[idx];
    }
    return lo | hi << 8;
}
