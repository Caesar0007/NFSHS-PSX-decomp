/* syslib/psx/libmath/FERR.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\FERR.obj ; libmath.lib.  1 fn _err_math @0x80106A54 (100 B) + the errno state
 *   math_errno @0x8013BF18 (and math_err_point).  Sets the soft-float errno; for EDOM(0x21)/ERANGE(0x22)
 *   also raises a root-counter event via DeliverEvent.  Ghidra nfs4-f.exe.c, verbatim (the `this`==errnum
 *   __thiscall artifact restored to the real first arg).
 */
extern "C" void DeliverEvent(unsigned int event, int spec);   /* libapi A07.obj (BIOS B0:0x07) */

extern "C" int math_errno = 0;        /* @0x8013BF18 */
extern "C" int math_err_point = 0;

extern "C" int _err_math(int errnum, int code)   /* @0x80106A54 */
{
    int ev2;
    if (errnum == 0x21) {
        ev2 = 0x301;
    } else {
        if (errnum != 0x22) {
            math_errno = errnum;
            math_err_point = code;
            return 0;
        }
        ev2 = 0x302;
    }
    math_errno = errnum;
    math_err_point = code;
    DeliverEvent(0xf4000002, ev2);
    return 0;
}
