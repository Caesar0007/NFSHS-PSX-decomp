/* eaclib/psx/eacpsxz/textcode.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\textcode.obj ; EACPSXZ.LIB.  1 fn @0x801069AC.  decodeansi -- next ANSI char from a
 *   cursor (advances it).  Ghidra nfs4-f.exe.c + IDA sig (1-arg cursor).
 */
extern "C" int decodeansi(unsigned char **cursor);   /* @0x801069AC */
extern "C" int decodeansi(unsigned char **cursor)
{
    /* The oracle loads the byte with `lbu` straight into $v0 and returns it with NO
     * re-mask -- an `unsigned char c` local re-masks (`andi v0,255`) on the return
     * (lever #9).  Read+advance the pointer, return the lbu value directly as int. */
    unsigned char *p = *cursor;
    int c = *p;
    *cursor = p + 1;
    return c;
}
