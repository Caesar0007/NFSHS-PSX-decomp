/* eaclib/psx/eacpsxz/fxform.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   obj nfs4\eaclib\psx\fxform.obj ; EACPSXZ.LIB.  3 fns @[0x800EABAC .. 0x800EAC74].  Build a fixed-point
 *   rotation matrix about the X/Y/Z axis from an angle (via fixedsincos).  Ghidra nfs4-f.exe.c + IDA sigs.
 *   Matrix `out` = 9 ints (3x3, 1.16 fixed); returns the matrix's [0][0] element (per Ghidra).
 */
extern "C" void fixedsincos(unsigned int angle, int *s, int *c);   /* fsincos.obj */

static int fixedxformx(int *out, int angle);   /* @0x800EABAC */
static int fixedxformy(int *out, int angle);   /* @0x800EAC10 */
static int fixedxformz(int *out, int angle);   /* @0x800EAC74 */

/* fixedxformx : rotation about X. */
static int fixedxformx(int *out, int angle)
{
    int s, c;
    fixedsincos((unsigned int)angle, &s, &c);
    out[0] = 0x10000; out[1] = 0; out[2] = 0; out[3] = 0; out[6] = 0;
    out[5] = s; out[4] = c; out[7] = -s; out[8] = c;
    return 0x10000;
}

/* fixedxformy : rotation about Y. */
static int fixedxformy(int *out, int angle)
{
    int s, c;
    fixedsincos((unsigned int)angle, &s, &c);
    out[1] = 0; out[3] = 0; out[4] = 0x10000; out[5] = 0; out[7] = 0;
    out[0] = c; out[2] = -s; out[6] = s; out[8] = c;
    return -s;
}

/* fixedxformz : rotation about Z. */
static int fixedxformz(int *out, int angle)
{
    int s, c;
    fixedsincos((unsigned int)angle, &s, &c);
    out[2] = 0; out[5] = 0; out[6] = 0; out[7] = 0; out[8] = 0x10000;
    out[1] = s; out[0] = c; out[3] = -s; out[4] = c;
    return 0x10000;
}
