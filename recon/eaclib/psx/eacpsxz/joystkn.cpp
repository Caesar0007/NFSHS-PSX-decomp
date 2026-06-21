/* eaclib/psx/eacpsxz/joystkn.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\joystkn.obj ; EACPSXZ.LIB.  1 fn @0x800F39F8.  initjoy -- one-time pad init.
 *   Ghidra nfs4-f.exe.c + IDA sig.
 */
extern "C" unsigned int numjoy;     /* requested pad count */
extern "C" int          joy_inited; /* init-once flag */
extern "C" void         padinit(void);   /* pad.obj */

extern "C" int initjoy(unsigned int numpads);   /* @0x800F39F8 */
extern "C" int initjoy(unsigned int numpads)
{
    numjoy = numpads;
    if (joy_inited == 0) {
        padinit();
        joy_inited = 1;
    }
    return joy_inited;
}
