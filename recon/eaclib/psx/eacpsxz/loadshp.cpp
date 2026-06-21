/* eaclib/psx/eacpsxz/loadshp.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\loadshp.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 359127).
 *   1 fn @0x800F1C3C (188 B).  loadshapeadr -- load a shape (.PSH) file by name, supplying a default
 *   extension when the name has none: copy the name, scan backward for '.' (extension present) stopping at a
 *   path separator (':' '/' '\\'), and if no '.' was found append the global default extension `shapeext`,
 *   then hand off to loadpackadr.  Ghidra nfs4-f.exe.c (loadshapeadr) + disasm-v3 (the strcat's dropped 2nd
 *   arg = `*(int*)&shapeext`; IDA sig (int a1, int a2)) + IDA sig.  Plain C -> extern "C".
 */
extern "C" char *strcpy(char *dst, const char *src);   /* syslib C25 */
extern "C" int   strlen(const char *s);                /* syslib C27 */
extern "C" char *strcat(char *dst, const char *src);   /* syslib C21 */
extern "C" int   loadpackadr(char *name, void *arg2);  /* nloadpk @0x800E5D5C */
extern "C" char *shapeext;                             /* default shape-file extension string ptr */

extern "C" int loadshapeadr(char *filename, void *arg2);   /* @0x800F1C3C */

/* loadshapeadr @0x800F1C3C : load shape `filename` (default-extending it), returns loadpackadr's result. */
extern "C" int loadshapeadr(char *filename, void *arg2)
{
    char  buf[128];
    char *p;
    int   len;

    strcpy(buf, filename);
    len = strlen(buf);
    for (p = buf + len - 1; buf < p; p = p - 1) {
        char c = *p;
        if (c == '.')
            goto done;                              /* already has an extension */
        if ((c == ':') || (c == '/') || (c == '\\'))
            break;                                  /* hit a path separator first */
    }
    if (*p != '.')
        strcat(buf, shapeext);                      /* append the default extension */
done:
    return loadpackadr(buf, arg2);
}
