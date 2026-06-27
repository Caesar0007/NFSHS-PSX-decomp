/* eaclib/psx/eacpsxz/joystkn.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\joystkn.obj ; EACPSXZ.LIB.  1 fn @0x800F39F8.  initjoy -- one-time pad init.
 *   Ghidra nfs4-f.exe.c + IDA sig.
 */
extern "C" unsigned int numjoy;      /* NOT gp-rel: oracle uses lui/sw absolute addressing */
extern "C" { int joy_inited; }       /* owning-TU tentative def → .comm/.sbss → gp-rel */
extern "C" void         padinit(void);   /* pad.obj */

extern "C" int initjoy(unsigned int numpads);   /* @0x800F39F8 */
extern "C" int initjoy(unsigned int numpads)
{
    int v = joy_inited;           /* load once at top; oracle keeps v0 live for return */
    numjoy = numpads;
    if (v == 0) {
        padinit();
        joy_inited = v = 1;
    }
    return v;
}
