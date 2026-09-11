/* eaclib/psx/eacpsxz/joystkn.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\joystkn.obj ; EACPSXZ.LIB.  1 fn @0x800F39F8.  initjoy -- one-time pad init.
 *   Ghidra nfs4-f.exe.c + IDA sig.
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "joystkn.h"
#include "vars.h"

int joy_inited;        /* @0x8013DD28: owning-TU tentative def → .comm/.sbss → gp-rel */

// FIXME
extern void padinit(void);   /* pad.obj */

int initjoy(unsigned int numpads)
{
    int v = joy_inited;           /* load once at top; oracle keeps v0 live for return */
    numjoy = numpads;
    if (v == 0) {
        padinit();
        joy_inited = v = 1;
    }
    return v;
}
