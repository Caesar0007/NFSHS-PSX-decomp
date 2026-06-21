/* eaclib/psx/eacpsxz/nloadpk.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\nloadpk.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   2 fns @ [0x800E5C64, 0x800E5D7C): loadpackadrz, loadpackadr -- load a (possibly REFPACK-style
 *   "packed") file and transparently decompress it.  FULL reconstruction (disasm-v3 MIPS); no thunks.
 *
 *   loadpackadrz: load the file via loadfileadr; if it is not packed (unpacksize==0) return it as-is.
 *   Otherwise relocate the compressed bytes to a scratch block allocated from the OPPOSITE end of the
 *   class heap (memclass ^ 0x10 flips reservememadr's HIGH-end flag -> avoids fragmentation while the
 *   decompressed output grows from the near end), free the original, allocate the output, unpack into
 *   it, then free the scratch.  loadpackadr is a thin forwarder to loadpackadrz.  C-linkage XDEFs.
 */

/* ---- helpers from sibling reconstructed objs ---- */
extern "C" int   loadfileadr  (char *name, int memclass);   /* nsync   @0x800E57E8 */
extern "C" int   unpacksize   (void *buf);                  /* unpack  -- 0 if not packed */
extern "C" int   unpackz      (void *src, void *dst);       /* unpack  -- nonzero = success */
extern "C" int   getblocksize (void *p);                    /* memstd  @0x800E52D4 */
extern "C" void *reservememadr(char *name, int size, int classid); /* memstd @0x800E533C */
extern "C" int   purgememadr  (void *p);                    /* memstd  @0x800E5540 */
extern "C" void  blockmove    (void *src, void *dst, int n);/* eacpsxz @0x800E62DC */

/* ===================================================================== *
 *  loadpackadrz @0x800E5C64 : load + transparently unpack `name`.        *
 * ===================================================================== */
extern "C" void *loadpackadrz(char *name, int memclass)   /* @0x800E5C64 */
{
    char *buf = (char *)loadfileadr(name, memclass);
    if (buf == 0)
        return 0;                                  /* load failed */

    int usize = unpacksize(buf);
    if (usize == 0)
        return buf;                                /* not packed -> return as loaded */

    /* relocate the compressed bytes to a scratch block at the opposite heap end */
    void *scratch = reservememadr(name, getblocksize(buf), memclass ^ 0x10);
    blockmove(buf, scratch, getblocksize(buf));
    purgememadr(buf);

    /* allocate the decompressed output and unpack into it */
    void *out = reservememadr(name, usize, memclass);
    if (out != 0) {
        if (unpackz(scratch, out) == 0) {          /* unpack failed */
            purgememadr(out);
            out = 0;
        }
    }
    purgememadr(scratch);
    return out;
}

/* ===================================================================== *
 *  loadpackadr @0x800E5D5C : forwarder to loadpackadrz.                  *
 * ===================================================================== */
extern "C" void *loadpackadr(char *name, int memclass)   /* @0x800E5D5C */
{
    return loadpackadrz(name, memclass);
}
