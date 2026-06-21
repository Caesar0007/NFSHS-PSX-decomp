/* eaclib/psx/eacpsxz/locatbig.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\locatbig.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   7 fns @ [0x800E5F1C, 0x800E62CC): typeofbigfile, sizeofbigfileheader, locatebigentryz,
 *   locatebigentry, locatebigoffset, locatebig, bigcount -- EA "BIG" archive directory locator.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs/thunks. C-linkage XDEFs.
 *
 *   Two on-disc formats (typeofbigfile):
 *     type 1 (magic getm==0xC0FB):  hdr 6 B {magic2, size2@+2, count2@+4}; entry = {off3, size3,
 *            name\0}; field width 3, name at entry+6.   total size = getm(buf+2,2)+4.
 *     type 2 (magic "BIGF"=0x42494746): hdr 16 B {"BIGF", ?@+4, count4@+8, size4@+0xC}; entry =
 *            {off4, size4, name\0}; field width 4, name at entry+8.   total size = getm(buf+0xC,4).
 *   All multi-byte fields are read big-endian via getm.  Entry names compared case-insensitively
 *   (stricmp).  CRITICAL delay slot: in locatebigentryz `end = buf + sizeofbigfileheader(buf)` is the
 *   delay slot of the typeofbigfile call (so it captures the size return BEFORE typeofbigfile
 *   overwrites $v0); likewise the per-entry counter++ is the loop-back branch delay slot.
 */

extern "C" unsigned getm   (void *ptr, int nbytes);          /* @0x800F3024 big-endian reader   */
extern "C" int      stricmp(const char *a, const char *b);   /* @0x800FE520 0 == match           */
extern "C" unsigned strlen (const char *s);                  /* eacpsxz @0x800E9F74              */

/* intra-obj forward decls (C-linkage) */
extern "C" int   typeofbigfile      (void *buf);
extern "C" int   sizeofbigfileheader(void *buf);
extern "C" char *locatebigentryz    (void *buf, char *name, int index, int *offset, int *size);
extern "C" char *locatebigentry     (void *buf, char *name, int index, int *offset, int *size);
extern "C" int   locatebigoffset    (void *buf, char *name);

/* write-only sink for the discarded "size" out-param of locatebigoffset (@0x8013DE64, obj-local) */
static int gLocatebigSizeSink;

/* ===================================================================== *
 *  typeofbigfile @0x800E5F1C : 1 (0xC0FB), 2 ("BIGF"), or 0 (not a BIG). *
 * ===================================================================== */
extern "C" int typeofbigfile(void *buf)
{
    if (getm(buf, 2) == 0xC0FB)
        return 1;
    if (getm(buf, 4) == 0x42494746u)        /* "BIGF" */
        return 2;
    return 0;
}

/* ===================================================================== *
 *  sizeofbigfileheader @0x800E5F84 : total file size from the header.    *
 * ===================================================================== */
extern "C" int sizeofbigfileheader(void *buf)
{
    switch (typeofbigfile(buf)) {
    case 1:  return (int)getm((char *)buf + 2, 2) + 4;
    case 2:  return (int)getm((char *)buf + 0xC, 4);
    default: return 0;
    }
}

/* ===================================================================== *
 *  bigcount @0x800E6258 : number of entries in the directory.           *
 * ===================================================================== */
extern "C" int bigcount(void *buf)
{
    switch (typeofbigfile(buf)) {
    case 1:  return (int)getm((char *)buf + 4, 2);
    case 2:  return (int)getm((char *)buf + 8, 4);
    default: return 0;
    }
}

/* ===================================================================== *
 *  locatebigentryz @0x800E5FFC : find a directory entry by `name`, or by *
 *  `index` when name==NULL.  On a hit, store the entry's data offset and *
 *  size through `offset`/`size` (when non-NULL) and return a pointer to  *
 *  the entry's name; on a miss zero them and return NULL.                *
 * ===================================================================== */
extern "C" char *locatebigentryz(void *buf, char *name, int index, int *offset, int *size)
{
    char *end  = (char *)buf + sizeofbigfileheader(buf);   /* delay slot before typeofbigfile */
    int   type = typeofbigfile(buf);

    int width, hdr;
    if (type == 1)      { width = 3; hdr = 6;    }
    else if (type == 2) { width = 4; hdr = 0x10; }
    else                { width = 0; hdr = 0;    }   /* falls through to not-found */

    char *p = (char *)buf + hdr;
    int   counter = 0;
    int   nameoff = width * 2;                          /* {off, size} then name */

    while (type != 0 && p < end) {
        char *ename = p + nameoff;
        int   matched = (name == 0) ? (counter == index)
                                    : (stricmp(ename, name) == 0);
        if (matched) {
            if (offset) *offset = (int)getm(p, width);
            if (size)   *size   = (int)getm(p + width, width);
            return ename;
        }
        p = ename + (int)strlen(ename) + 1;             /* next entry */
        counter++;                                      /* loop-back delay slot */
    }

    if (offset) *offset = 0;
    if (size)   *size   = 0;
    return 0;
}

/* ===================================================================== *
 *  locatebigentry @0x800E61B8 : forwarder to locatebigentryz.           *
 * ===================================================================== */
extern "C" char *locatebigentry(void *buf, char *name, int index, int *offset, int *size)
{
    return locatebigentryz(buf, name, index, offset, size);
}

/* ===================================================================== *
 *  locatebigoffset @0x800E61DC : data offset of `name`, or 0.            *
 * ===================================================================== */
extern "C" int locatebigoffset(void *buf, char *name)
{
    int offset = 0;
    if (name != 0)
        locatebigentry(buf, name, 0, &offset, &gLocatebigSizeSink);
    return offset;
}

/* ===================================================================== *
 *  locatebig @0x800E6218 : pointer to the entry's data, or NULL.        *
 * ===================================================================== */
extern "C" char *locatebig(void *buf, char *name)
{
    int off = locatebigoffset(buf, name);
    return off ? (char *)buf + off : 0;
}
