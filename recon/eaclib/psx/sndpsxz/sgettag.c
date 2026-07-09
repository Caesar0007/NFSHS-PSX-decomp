/* eaclib/psx/sndpsxz/sgettag.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sgettag.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BD50.  iSNDgettag -- pull the next tag from a sound-bank tag stream, advancing the cursor.
 *   Ghidra nfs4-f.exe.c (sgettag) + IDA sig (4-arg; Ghidra showed 2 + in_a2/in_a3).
 *
 *   🔴 4-ARG: (cursor, &id, &val, &ptr).  Skips 0xfc padding; 0xff ends the stream; 0xfd/0xfe are marker
 *   tags (id only); any other id is a data tag whose value (iSNDgetdata) lands in *val and whose stream
 *   pointer lands in *ptr.  A 0xff length byte selects an extended 4-byte length.
 */

extern int iSNDgetdata(unsigned char *p, int n);   /* sgetdata */

extern int iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* @0x8010BD50 */

/* iSNDgettag @0x8010BD50 : returns 1 while a tag was read, 0 at end of stream (id 0xff). */
extern int iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr)
{
    char          *p = (char *)*cursor;
    unsigned char  id;
    int            at;
    unsigned int   len;
    int            r;

    while (*p == -4) {                          /* skip 0xfc padding tags */
        *cursor = (int)(p + 1);
        p = p + 1;
    }
    id = *(unsigned char *)*cursor;
    *outId = (unsigned int)id;
    if (id == 0xff)
        return 0;                               /* end of stream */
    at = *cursor;
    *cursor = at + 1;
    if (*outId == 0xfd || *outId == 0xfe)
        return 1;                               /* marker tag (no data) */

    len = (unsigned int)*(unsigned char *)(at + 1);
    if (len == 0xff) {                          /* extended 4-byte length */
        *cursor = at + 2;
        len = (unsigned int)iSNDgetdata((unsigned char *)(at + 2), 4);
        *cursor = *cursor + 3;
    }
    at = *cursor;
    *cursor = at + 1;
    *outPtr = at + 1;
    if (len < 5) {
        r = iSNDgetdata((unsigned char *)*cursor, (int)len);
        *outVal = r;
    }
    *cursor = *cursor + len;
    return 1;
}
