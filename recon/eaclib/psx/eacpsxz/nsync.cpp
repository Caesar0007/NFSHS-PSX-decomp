/* eaclib/psx/eacpsxz/nsync.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\nsync.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   10 fns @ [0x800E5608, 0x800E5AC4) -- EA "nsync" SYNCHRONOUS file-load layer.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT stubs/thunks.
 *   No SYM debug info (LIB built without -g) -> names/types reasoned from the MIPS + IDA arg-counts.
 *
 *   STRUCTURE: each public loader (filesize / loadfileadr[z] / loadfileatadr[z] / loadbigfileheader)
 *   is a thin wrapper that packs its arguments into a LoadArgs scratch and dispatches the matching
 *   `*atomic` worker through FILE_atomic(fn, asyncidle(), 100, &args) -- a retry/abort harness.
 *   The `*atomic` workers do the real work over the FILE_*sync primitives + the memstd allocator.
 *   The "z" variants differ only in passing abortval=0 (vs the global `abortflag`).
 */

/* the scratch record passed by-pointer through FILE_atomic to each *atomic worker */
typedef struct LoadArgs {
    char *name;      /* +0x00  source filename                                   */
    int   dest;      /* +0x04  fixed destination (loadfileat* family)            */
    int   memclass;  /* +0x08  allocator class id (loadfile* / bigfile family)   */
    int   abortval;  /* +0x0C  abort flag snapshot (0 for the "z" variants)      */
} LoadArgs;

/* ---- FILE_*sync primitives + retry harness (libfile / sibling objs) ---- */
extern "C" int  FILE_opensync (char *name, int mode, int retry, int *handle);  /* @0x800EA8A8 */
extern "C" int  FILE_sizesync (int handle, int retry);                         /* @0x800EA9A4 */
extern "C" int  FILE_readsync (int handle, int offset, void *dest, int size, int retry); /* @0x800EA920 */
extern "C" int  FILE_closesync(int handle, int retry);                         /* @0x800EA950 */
extern "C" int  FILE_atomic   (void *fn, int idle, int retries, void *args);   /* @0x800ECB40 */
extern "C" int  asyncidle     (void);                                          /* @0x800F6114 */

/* ---- memstd allocator (eaclib/psx/eacpsxz/memstd.cpp) ---- */
extern "C" void *reservememadr(char *name, int size, int classid);            /* @0x800E533C */
extern "C" int   purgememadr  (void *p);                                       /* @0x800E5540 */

/* ---- big-file header helpers (next obj) ---- */
extern "C" int   typeofbigfile      (void *buf);     /* @0x800E5F1C */
extern "C" int   sizeofbigfileheader(void *buf);     /* @0x800E5F84 */
extern "C" void  blockmove          (void *src, void *dst, int n);  /* @0x800E62DC */

/* ---- data globals (defined in the data-materialization pass) ---- */
extern "C" int abortflag;                                  /* @0x8013DCD4 */
extern "C" int (*loadfilecallback)(void *dest, char *name, int memclass);  /* @0x8013DD60 */

/* forward decls of the intra-obj *atomic XDEFs (C-linkage) */
extern "C" int   filesizeatomic        (int retry, LoadArgs *a);
extern "C" void *loadfileadratomic      (int retry, LoadArgs *a);
extern "C" int   loadfileatadratomic    (int retry, LoadArgs *a);
extern "C" void *loadbigfileheaderatomic(int retry, LoadArgs *a);

/* ===================================================================== *
 *  filesizeatomic @0x800E5608 : open `a->name`, query its size, close.   *
 *  Returns the byte size, or 0 if the open failed.                       *
 * ===================================================================== */
extern "C" int filesizeatomic(int retry, LoadArgs *a)   /* @0x800E5608 */
{
    int handle;
    if (FILE_opensync(a->name, 1, retry, &handle) == 0)
        return 0;
    int size = FILE_sizesync(handle, retry - 1);
    FILE_closesync(handle, retry - 1);
    return size;
}

/* ===================================================================== *
 *  filesize @0x800E566C : public wrapper -> retry-driven filesizeatomic. *
 * ===================================================================== */
extern "C" int filesize(char *name)   /* @0x800E566C */
{
    LoadArgs a;
    a.name = name;
    a.abortval = abortflag;
    int idle = asyncidle();
    return FILE_atomic((void *)filesizeatomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileadratomic @0x800E56B0 : open, size, allocate from class       *
 *  `a->memclass`, read the whole file in, close, then run the optional   *
 *  loadfilecallback hook.  Returns the buffer (NULL on any failure).     *
 * ===================================================================== */
extern "C" void *loadfileadratomic(int retry, LoadArgs *a)   /* @0x800E56B0 */
{
    int handle;
    if (FILE_opensync(a->name, 1, retry, &handle) == 0)
        return 0;                                       /* open failed */

    int size = FILE_sizesync(handle, retry - 1);
    void *buf = reservememadr(a->name, size, a->memclass);
    if (buf == 0) {
        FILE_closesync(handle, retry - 1);
        return 0;                                       /* out of memory */
    }

    FILE_readsync(handle, 0, buf, size, retry - 1);
    FILE_closesync(handle, retry - 1);

    if (loadfilecallback != 0) {                        /* post-load hook */
        void *r = (void *)loadfilecallback(buf, a->name, a->memclass);
        if (r == 0)
            purgememadr(buf);                           /* hook failed -> free */
        buf = r;
    }
    return buf;
}

/* ===================================================================== *
 *  loadfileadrz  @0x800E57A8 : wrapper, abort disabled (abortval = 0).   *
 * ===================================================================== */
extern "C" int loadfileadrz(char *name, int memclass)   /* @0x800E57A8 */
{
    LoadArgs a;
    a.name = name;
    a.memclass = memclass;
    a.abortval = 0;
    int idle = asyncidle();
    return FILE_atomic((void *)loadfileadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileadr   @0x800E57E8 : wrapper, abort via global abortflag.      *
 * ===================================================================== */
extern "C" int loadfileadr(char *name, int memclass)   /* @0x800E57E8 */
{
    LoadArgs a;
    a.name = name;
    a.memclass = memclass;
    a.abortval = abortflag;
    int idle = asyncidle();
    return FILE_atomic((void *)loadfileadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileatadratomic @0x800E5830 : open, read the whole file to the    *
 *  caller-supplied fixed address `a->dest`, close.  Returns dest (0 on   *
 *  open failure).                                                        *
 * ===================================================================== */
extern "C" int loadfileatadratomic(int retry, LoadArgs *a)   /* @0x800E5830 */
{
    int handle;
    if (FILE_opensync(a->name, 1, retry, &handle) == 0)
        return 0;
    FILE_readsync(handle, 0, (void *)a->dest, 0x7FFFFFFF, retry - 1);
    FILE_closesync(handle, retry - 1);
    return a->dest;
}

/* ===================================================================== *
 *  loadfileatadrz @0x800E58B0 : wrapper, abort disabled.                 *
 * ===================================================================== */
extern "C" int loadfileatadrz(char *name, int dest)   /* @0x800E58B0 */
{
    LoadArgs a;
    a.name = name;
    a.dest = dest;
    a.abortval = 0;
    int idle = asyncidle();
    return FILE_atomic((void *)loadfileatadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileatadr @0x800E58F0 : wrapper, abort via global abortflag.      *
 * ===================================================================== */
extern "C" int loadfileatadr(char *name, int dest)   /* @0x800E58F0 */
{
    LoadArgs a;
    a.name = name;
    a.dest = dest;
    a.abortval = abortflag;
    int idle = asyncidle();
    return FILE_atomic((void *)loadfileatadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadbigfileheaderatomic @0x800E5938 : read a "big file" header.       *
 *  Reads the first 0xA90 bytes, validates via typeofbigfile, and if the  *
 *  true header (sizeofbigfileheader) is larger, reallocates and reads    *
 *  the remainder.  Returns the header buffer (NULL on failure).          *
 * ===================================================================== */
extern "C" void *loadbigfileheaderatomic(int retry, LoadArgs *a)   /* @0x800E5938 */
{
    int handle;
    if (FILE_opensync(a->name, 1, retry, &handle) == 0)
        return 0;

    void *buf = reservememadr(a->name, 0xA90, a->memclass);
    if (buf == 0) {
        FILE_closesync(handle, retry - 1);
        return 0;
    }

    FILE_readsync(handle, 0, buf, 0xA90, retry - 1);

    if (typeofbigfile(buf) == 0) {                      /* not a big file */
        purgememadr(buf);
        FILE_closesync(handle, retry - 1);
        return 0;
    }

    int fullsize = sizeofbigfileheader(buf);
    if (fullsize >= 0xA91) {                            /* header exceeds first read */
        void *full = reservememadr(a->name, fullsize, a->memclass);
        if (full == 0) {
            purgememadr(buf);
            FILE_closesync(handle, retry - 1);
            return 0;
        }
        blockmove(buf, full, 0xA90);                    /* keep the bytes already read */
        purgememadr(buf);
        buf = full;
        FILE_readsync(handle, 0xA90, (char *)buf + 0xA90, fullsize - 0xA90, retry - 1);
    }

    FILE_closesync(handle, retry - 1);
    return buf;
}

/* ===================================================================== *
 *  loadbigfileheader @0x800E5A7C : wrapper, abort via global abortflag.  *
 * ===================================================================== */
extern "C" int loadbigfileheader(char *name, int memclass)   /* @0x800E5A7C */
{
    LoadArgs a;
    a.name = name;
    a.memclass = memclass;
    a.abortval = abortflag;
    int idle = asyncidle();
    return FILE_atomic((void *)loadbigfileheaderatomic, idle, 0x64, &a);
}
