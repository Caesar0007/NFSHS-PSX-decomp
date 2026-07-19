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
    /* MATCH: result-FUNNEL var (s0, init 0 in the prologue) set per branch, ONE return --
     * early returns emit a different tail; the else-getm's a0 rides the first bne's slot. */
    int type = 0;
    if (getm(buf, 2) == 0xC0FB)
        type = 1;
    else if (getm(buf, 4) == 0x42494746u)   /* "BIGF" */
        type = 2;
    return type;
}

/* ===================================================================== *
 *  sizeofbigfileheader @0x800E5F84 : total file size from the header.    *
 * ===================================================================== */
extern "C" int sizeofbigfileheader(void *buf)
{
    /* MATCH: result funnel + SWITCH dispatch (two forward beq's to out-of-line case
     * blocks, default j to the shared return; else-if inlines the bodies instead).
     * r=0 fills the typeofbigfile jal slot. */
    int r = 0;
    switch (typeofbigfile(buf)) {
    case 1:  r = (int)getm((char *)buf + 2, 2) + 4;  break;
    case 2:  r = (int)getm((char *)buf + 0xC, 4);    break;
    }
    return r;
}

/* ===================================================================== *
 *  bigcount @0x800E6258 : number of entries in the directory.           *
 * ===================================================================== */
extern "C" int bigcount(void *buf)
{
    /* MATCH: same funnel + switch-dispatch shape as sizeofbigfileheader. */
    int r = 0;
    switch (typeofbigfile(buf)) {
    case 1:  r = (int)getm((char *)buf + 4, 2);  break;
    case 2:  r = (int)getm((char *)buf + 8, 4);  break;
    }
    return r;
}

/* ===================================================================== *
 *  locatebigentryz @0x800E5FFC : find a directory entry by `name`, or by *
 *  `index` when name==NULL.  On a hit, store the entry's data offset and *
 *  size through `offset`/`size` (when non-NULL) and return a pointer to  *
 *  the entry's name; on a miss zero them and return NULL.                *
 * ===================================================================== */
extern "C" char *locatebigentryz(void *buf, char *name, int index, int *offset, int *size)
{
    /* MATCH: the oracle does NOT parameterize width/hdr/nameoff into a single loop -- it
     * emits TWO literal, fully-duplicated scan loops (one per type), dispatched by a
     * beq/beq cascade on typeofbigfile()'s result, both funneling into ONE shared "found"
     * exit (v0=ename) and ONE shared "not found" tail (null offset/size, return 0). A
     * parameterized single loop compiles ~18 insns SHORTER (93 vs 111) -- structural, not
     * a coloring residual. */
    /* MATCH: counter=0 is materialized EARLY, before either setup call (prologue-adjacent),
     * not after -- oracle order is s1=counter=0 then the sizeofbigfileheader/typeofbigfile
     * calls. */
    int   counter = 0;
    char *end  = (char *)buf + sizeofbigfileheader(buf);   /* delay slot before typeofbigfile */
    int   type = typeofbigfile(buf);

    /* MATCH: dispatch is a real `switch` (li 1/beq, li 2/beq, j default) -- same shape as
     * the sibling sizeofbigfileheader/bigcount switch dispatch in this file -- NOT an
     * if/else-if chain (which condenses to a single bne/fallthrough). */
    switch (type) {
    case 1: {
        char *p = (char *)buf + 6;
        if (p < end) {
            do {
                /* MATCH: `ename` (p+6) is NOT cached -- it's re-derived fresh at EACH use
                 * site (stricmp arg, strlen arg, the return) exactly as the oracle's
                 * `addiu _,s0,6` appears three separate times; caching it costs an extra
                 * saved register (8 s-regs vs oracle's 7). Also: direct branch cascade
                 * (bnez name / beq counter,index / stricmp), not a materialized ternary. */
                if (name == 0) {
                    if (counter != index)
                        goto next1;
                } else {
                    if (stricmp(p + 6, name) != 0)
                        goto next1;
                }
                if (offset) *offset = (int)getm(p, 3);
                if (size)   *size   = (int)getm(p + 3, 3);
                return p + 6;
            next1:
                { int len = (int)strlen(p + 6); p = p + len + 7; }  /* next entry */
                counter++;                                  /* loop-back delay slot */
            } while (p < end);
        }
        break;
    }
    case 2: {
        char *p = (char *)buf + 0x10;
        if (p < end) {
            do {
                if (name == 0) {
                    if (counter != index)
                        goto next2;
                } else {
                    if (stricmp(p + 8, name) != 0)
                        goto next2;
                }
                if (offset) *offset = (int)getm(p, 4);
                if (size)   *size   = (int)getm(p + 4, 4);
                return p + 8;
            next2:
                { int len = (int)strlen(p + 8); p = p + len + 9; }  /* next entry */
                counter++;                                  /* loop-back delay slot */
            } while (p < end);
        }
        break;
    }
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
    /* MATCH: result-funnel var (s0=0 in the jal slot), conditional assign, one return. */
    char *r = 0;
    int off = locatebigoffset(buf, name);
    if (off != 0)
        r = (char *)buf + off;
    return r;
}
