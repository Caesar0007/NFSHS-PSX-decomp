/* syslib/psx/libapi/PAD.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libapi.lib(PAD.OBJ): ReadInitPadFlag -- return the "pad already initialised" flag the BIOS
 *   pad init sets; InitCARD uses it to decide whether to honour its `val` argument. (ida mislabels
 *   this GsGetWorkBase_4; it is just a one-word global read.)
 *   The oracle reaches the flag with an ABSOLUTE lui/%hi + lw/%lo pair, i.e. PAD.OBJ does NOT own
 *   the symbol -- it is an extern BSS global the BIOS pad init writes.  Keep it a PURE extern here
 *   (a tentative def in this TU would make it small-common -> gp-relative `lw $v0,N($gp)`, 1 instr,
 *   which mismatches the oracle's 2-instr absolute form -- see methodology §3.12 #6).  The owning
 *   zero def lives in a sibling data TU (PAD_data.cpp) so the link still resolves. */

/* W66-A3 (link): PAD_data.c's `int _init_pad_flag;` never actually resolved this
 * reference -- at 4 bytes the tentative def routes to a LOCAL .sbss/.bss symbol
 * (nm `b`, the w65-a6 §6.1 falsification), so the real link kept the reference
 * undefined AND the private copy sat at a VA retail does not have.  The word IS
 * in the image: the splat blob emits it as `D_8013C338`
 * (data_8010CCD4_r21.data.s, first word of a 4-word run).  Alias onto it; the
 * declaration stays a pure extern so the absolute lui/%hi + lw/%lo form is
 * unchanged. */
/* 2026-09-19: the pad object OWNS its data (retail .data 0x8013C338, 16 bytes) -- the SDK object reaches the flag
 * section-relative, which is a file-scope definition.  Sony library object => -G0, so the access stays absolute. */
int _init_pad_flag = 0;                                       /* @0x8013C338 : set by the BIOS pad init */
int _pad_spare = 0;                                           /* @0x8013C33C */
unsigned char *_pad_joy_data = (unsigned char *)0x1F801040;   /* @0x8013C340 */
unsigned long *_pad_i_stat = (unsigned long *)0x1F801070;     /* @0x8013C344 */

#include "../../../link_stripped.h"
/* PAD.obj is the clearest witness of retail's link-time stripping: its 16 data bytes are all in the image, but of its
 * 768 text bytes only ReadInitPadFlag (16 B) survives -- SetInitPadFlag, PAD_init, InitPAD, StartPAD, StopPAD (+ its static
 * helper) were unreferenced.  Written so far: SetInitPadFlag, StartPAD.  TODO (LINK-STRIPPED, not yet written): PAD_init
 * @28+144, InitPAD @172+144, StopPAD @364+56 and the static helper @420+348. */
extern void SetInitPadFlag(int flag) LINK_STRIPPED;
extern int  StartPAD(void) LINK_STRIPPED;
extern void StartPAD2(void);
extern void ChangeClearPAD(int val);
extern void EnablePAD(void);

/* PAD.obj +0 (LINK-STRIPPED) : SetInitPadFlag */
extern void SetInitPadFlag(int flag) { _init_pad_flag = flag; }

/* @0x8010C9B0 : ReadInitPadFlag. */
extern int ReadInitPadFlag(void) { return _init_pad_flag; }

/* PAD.obj +316 (LINK-STRIPPED) : StartPAD */
extern int StartPAD(void)
{
    StartPAD2();
    ChangeClearPAD(0);
    EnablePAD();
    return 1;
}
