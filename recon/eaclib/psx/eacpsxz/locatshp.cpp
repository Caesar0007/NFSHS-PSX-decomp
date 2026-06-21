/* eaclib/psx/eacpsxz/locatshp.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\locatshp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   2 fns: locateshape@0x800EB110, locateshapez@0x800EB170.  FULL reconstruction (disasm-v3 MIPS).
 *   Both functions are byte-for-byte identical (an EA name/namez API pair); shared helper below.
 *
 *   Look a shape up by its 4-char name in an EA shape file (see shpsubs.cpp for the layout: int count
 *   @+0x08, 8-byte entries from +0x10 = { u32 name, u32 dataoffset }).  The name is passed BY POINTER
 *   (the value at *namekey is the packed tag to find).  The directory is scanned from the LAST entry
 *   down to the first; the highest-index match wins.  Returns base + entry.dataoffset, or 0 if absent.
 */
extern "C" void *locateshape (void *shapefile, int *namekey);   /* @0x800EB110 */
extern "C" void *locateshapez(void *shapefile, int *namekey);   /* @0x800EB170 */

static void *locate_shape(char *sf, int name)
{
    int count = *(int *)(sf + 8);
    int i;
    for (i = count - 1; i >= 0; i--) {                 /* reverse scan: highest index wins */
        if (*(int *)(sf + i * 8 + 0x10) == name)        /* entry[i].name */
            return sf + *(int *)(sf + i * 8 + 0x14);    /* base + entry[i].dataoffset */
    }
    return 0;
}

extern "C" void *locateshape(void *shapefile, int *namekey)   /* @0x800EB110 */
{
    return locate_shape((char *)shapefile, *namekey);
}

extern "C" void *locateshapez(void *shapefile, int *namekey)  /* @0x800EB170 (identical to locateshape) */
{
    return locate_shape((char *)shapefile, *namekey);
}
