/* eaclib/psx/eacpsxz/fxform.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   obj nfs4\eaclib\psx\fxform.obj ; EACPSXZ.LIB.  3 fns @[0x800EABAC .. 0x800EAC74].  Build a fixed-point
 *   rotation matrix about the X/Y/Z axis from an angle (via fixedsincos).  Ghidra nfs4-f.exe.c + IDA sigs.
 *   Matrix `out` = 9 ints (3x3, 1.16 fixed); returns the matrix's [0][0] element (per Ghidra).
 */
extern void fixedsincos(unsigned int angle, int *s, int *c);   /* fsincos.obj */

static int fixedxformx(int *out, int angle);   /* @0x800EABAC */
static int fixedxformy(int *out, int angle);   /* @0x800EAC10 */
static int fixedxformz(int *out, int angle);   /* @0x800EAC74 */

/* fixedxformx : rotation about X.  The cv/sv value aliases keep both fixedsincos
 * outputs live in the retail registers through the matrix stores. */
static int fixedxformx(int *out, int angle)
{
    int s, c;
    int cv, sv;
    fixedsincos((unsigned int)angle, &s, &c);
    cv = c;
    sv = s;
    out[0] = 0x10000; out[1] = 0; out[2] = 0; out[3] = 0; out[6] = 0;
    out[5] = sv; out[4] = cv; out[7] = -sv; out[8] = cv;
    return 0x10000;
}

/* fixedxformy : rotation about Y.  See fixedxformx for the value-alias rationale. */
static int fixedxformy(int *out, int angle)
{
    int s, c;
    int cv, sv;
    fixedsincos((unsigned int)angle, &s, &c);
    cv = c;
    sv = s;
    out[1] = 0; out[3] = 0; out[4] = 0x10000; out[5] = 0; out[7] = 0;
    out[0] = cv; out[2] = -sv; out[6] = sv; out[8] = cv;
    return -sv;
}

/* fixedxformz : rotation about Z.  See fixedxformx for the value-alias rationale. */
static int fixedxformz(int *out, int angle)
{
    int s, c;
    int cv, sv;
    fixedsincos((unsigned int)angle, &s, &c);
    cv = c;
    sv = s;
    out[2] = 0; out[5] = 0; out[6] = 0; out[7] = 0; out[8] = 0x10000;
    out[1] = sv; out[0] = cv; out[3] = -sv; out[4] = cv;
    return 0x10000;
}
