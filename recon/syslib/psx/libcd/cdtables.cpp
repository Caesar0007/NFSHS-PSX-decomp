/* syslib/psx/libcd/cdtables.cpp -- RECONSTRUCTED from nfs4-f.exe (.data materialised from the EXE).
 *   The two per-command CD-driver tables, indexed by CD command number (CdlNop..CdlReadS, 0x00-0x1F).
 *   Declared `extern const int[]` by drv.cpp (CD_cw) and cdcont.cpp (CdControl*); defined once here.
 *     _cd_result_flag @0x8013C08C : 1 if the command produces a "ready" result packet.
 *     _cd_param_count @0x8013C18C : number of parameter bytes the command takes.
 *   Notable: CdlSetloc(0x02)=3 params, CdlSetmode(0x0E)=1, CdlGetTD(0x14)=1; the result-producing
 *   commands are CdlPlay/Forward/Backward/ReadN(0x03-0x06), 0x15/0x16, and CdlReadS(0x1B). */

extern "C" {

/* `extern` is REQUIRED: in C++ a file-scope `const` has INTERNAL linkage even
 * inside extern "C" {} (which only sets C naming), so without it the symbol is
 * never exported and drv.cpp/cdcont.cpp's `extern const int[]` stays unresolved. */
extern const int _cd_result_flag[32] = {   /* @0x8013C08C */
    0, 0, 0, 1, 1, 1, 1, 0,         /* 0x00-0x07 */
    0, 0, 0, 0, 0, 0, 0, 0,         /* 0x08-0x0F */
    0, 0, 0, 0, 0, 1, 1, 0,         /* 0x10-0x17 */
    0, 0, 0, 1, 0, 0, 0, 0          /* 0x18-0x1F */
};

extern const int _cd_param_count[32] = {   /* @0x8013C18C */
    0, 0, 3, 0, 0, 0, 0, 0,         /* 0x00-0x07 : CdlSetloc(0x02)=3 */
    0, 0, 0, 0, 0, 2, 1, 0,         /* 0x08-0x0F : 0x0D=2, CdlSetmode(0x0E)=1 */
    0, 0, 1, 0, 1, 0, 0, 0,         /* 0x10-0x17 : 0x12=1, CdlGetTD(0x14)=1 */
    0, 0, 0, 0, 0, 0, 0, 0          /* 0x18-0x1F */
};

}
