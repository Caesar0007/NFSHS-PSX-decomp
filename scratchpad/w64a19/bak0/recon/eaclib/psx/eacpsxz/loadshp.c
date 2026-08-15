/* eaclib/psx/eacpsxz/loadshp.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** SEALED 1/1 ***
 *   obj nfs4\eaclib\psx\loadshp.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 359127).
 *   1 fn @0x800F1C3C (188 B).  loadshapeadr -- load a shape (.PSH) file by name, supplying a default
 *   extension when the name has none: copy the name, scan backward for '.' (extension present) stopping at a
 *   path separator (':' '/' '\\'), and if no '.' was found append the global default extension `shapeext`,
 *   then hand off to loadpackadr.  Ghidra nfs4-f.exe.c (loadshapeadr) + disasm-v3 (the strcat's dropped 2nd
 *   arg = `*(int*)&shapeext`; IDA sig (int a1, int a2)).
 *
 *   2026-07-09 C-MODULE SEAL (eaclib C-compiler sweep): eacpsxz.lib modules are C compiled with
 *   CC1PSX, not CC1PLPSX (proven on unhuff.obj 2026-07-08).  The exact same source that FAILed 24
 *   diffs under cc1plus PASSes verbatim under cc1 (verify_asm 47/47) -- the whole residual was
 *   C++-vs-C register-allocation coloring, zero source changes needed.  .c extension = compile_c
 *   routing in build.py/verify_asm.py. */
extern char *strcpy(char *dst, const char *src);   /* syslib C25 */
extern int   strlen(const char *s);                /* syslib C27 */
extern char *strcat(char *dst, const char *src);   /* syslib C21 */
extern int   loadpackadr(char *name, void *arg2);  /* nloadpk @0x800E5D5C */
char *shapeext;   /* @0x8013DD20 default shape-file extension string ptr -- TENTATIVE DEF (SS 3.12 #6):
                   * loadshp OWNS it (only %gp_rel(shapeext) oracle = loadshapeadr.s) -> .comm -> the
                   * oracle's gp-relative `lw a1,0(gp)`; a plain extern emits absolute lui/lw (3 diffs). */

int loadshapeadr(char *filename, void *arg2);      /* @0x800F1C3C */

/* loadshapeadr @0x800F1C3C : load shape `filename` (default-extending it), returns loadpackadr's result. */
int loadshapeadr(char *filename, void *arg2)
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
