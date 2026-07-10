/* eaclib/psx/eacpsxz/locatshp.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\locatshp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   2 fns: locateshape@0x800EB110, locateshapez@0x800EB170.  FULL reconstruction (disasm-v3 MIPS).
 *   Both functions are byte-for-byte identical (an EA name/namez API pair); shared helper below.
 *
 *   Look a shape up by its 4-char name in an EA shape file (see shpsubs.cpp for the layout: int count
 *   @+0x08, 8-byte entries from +0x10 = { u32 name, u32 dataoffset }).  The name is passed BY POINTER
 *   (the value at *namekey is the packed tag to find).  The directory is scanned from the LAST entry
 *   down to the first; the highest-index match wins.  Returns base + entry.dataoffset, or 0 if absent.
 */
extern void *locateshape (void *shapefile, int *namekey);   /* @0x800EB110 */
extern void *locateshapez(void *shapefile, int *namekey);   /* @0x800EB170 */

/* MATCH: NO shared static helper exists in the binary -- the oracle carries a full
 * inline copy of the scan in EACH fn (24 insns each).  Loop shape: index-down scan
 * `while (i != 0 && entry(i).name != name) i--;` -- gcc strength-reduces the
 * sf+i*8+0x10 access into the walking $a2 giv (init base+count*8, -8/iter) and
 * fills the bne slot with the i-- (the +1 on the match path is its compensation);
 * the tail re-derives entry i by index (sll/addu) and checks entry[0] too. */

extern void *locateshape(void *shapefile, int *namekey)   /* @0x800EB110 */
{
    char *sf  = (char *)shapefile;
    int  name = *namekey;
    int  i    = *(int *)(sf + 8);                       /* directory count */
    char *p;
    if (i == 0)
        return 0;
    p = (char *)(i * 8 + (int)sf);                      /* walker init from PRE-decrement count */
    i = i - 1;                                          /* split load/dec (lever #15b) */
scan:                                                   /* label-goto loop (catalog B): top i-test,
                                                         * bne-back on mismatch w/ i-- in the slot
                                                         * (+1 compensation on the match path) */
    if (i != 0) {
        p = p - 8;                                      /* fills the top beqz slot */
        if (*(int *)(p + 0x10) != name) {
            i = i - 1;
            goto scan;
        }
    }
    if (*(int *)(sf + i * 8 + 0x10) == name)            /* tail re-derives entry i by index */
        return sf + *(int *)(sf + i * 8 + 0x14);        /* base + entry[i].dataoffset */
    return 0;
}

extern void *locateshapez(void *shapefile, int *namekey)  /* @0x800EB170 (identical to locateshape) */
{
    char *sf  = (char *)shapefile;
    int  name = *namekey;
    int  i    = *(int *)(sf + 8);
    char *p;
    if (i == 0)
        return 0;
    p = (char *)(i * 8 + (int)sf);                      /* walker init from PRE-decrement count */
    i = i - 1;                                          /* split load/dec (lever #15b) */
scan:                                                   /* label-goto loop (catalog B): top i-test,
                                                         * bne-back on mismatch w/ i-- in the slot
                                                         * (+1 compensation on the match path) */
    if (i != 0) {
        p = p - 8;                                      /* fills the top beqz slot */
        if (*(int *)(p + 0x10) != name) {
            i = i - 1;
            goto scan;
        }
    }
    if (*(int *)(sf + i * 8 + 0x10) == name)            /* tail re-derives entry i by index */
        return sf + *(int *)(sf + i * 8 + 0x14);        /* base + entry[i].dataoffset */
    return 0;
}
