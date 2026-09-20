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
unsigned char *_pad_joy_data = (unsigned char *)0x1F801040;   /* @0x8013C33C  (SDK .data +4: the handler clears JOY_CTRL through it) */
unsigned long *_pad_i_stat = (unsigned long *)0x1F801070;     /* @0x8013C340  (SDK .data +8) */
int _pad_spare = 0;                                           /* @0x8013C344  (2026-09-20: was declared second -- a 9-byte mismatch an overlapping blob
                                                                 section hid from honest_measure; found by tools/overlap_audit.py) */

#include "../../../link_stripped.h"
/* PAD.obj is the clearest witness of retail's link-time stripping: its 16 data bytes are all in the image, but of its
 * 768 text bytes only ReadInitPadFlag (16 B) survives -- SetInitPadFlag, PAD_init, InitPAD, StartPAD, StopPAD (+ its static
 * helper) were unreferenced.  All of them are written below in SDK order. */
extern void SetInitPadFlag(int flag) LINK_STRIPPED;
extern int  PAD_init(unsigned long a, unsigned long *b, unsigned long c, unsigned long d) LINK_STRIPPED;
extern int  InitPAD(char *b1, long l1, char *b2, long l2) LINK_STRIPPED;
extern void StopPAD(void) LINK_STRIPPED;
static int  _pad_install_intr(void) LINK_STRIPPED;
static int  _pad_remove_intr(void) LINK_STRIPPED;
static int  _pad_intr_ack(void) LINK_STRIPPED;
static int  _pad_intr_verify(void) LINK_STRIPPED;
extern void _remove_ChgclrPAD(void);
extern void _patch_pad(void);
extern void EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern void DisablePAD(void);
extern void StopPAD2(void);
extern int  PAD_init2(unsigned long a, unsigned long *b, unsigned long c, unsigned long d);
extern int  InitPAD2(char *b1, long l1, char *b2, long l2);
extern int  SysEnqIntRP(int prio, void *node);
extern int  SysDeqIntRP(int prio, void *node);

/* PAD.obj .bss (16 B): the interrupt chain node {next, handler, verifier, pad} */
static long _pad_node[4];   /* [0] next, [1] handler, [2] verifier, [3] pad -- the SDK fills it as an array (one base for [1],[2]) */

extern int  StartPAD(void) LINK_STRIPPED;
extern void StartPAD2(void);
extern void ChangeClearPAD(int val);
extern void EnablePAD(void);

/* PAD.obj +0 (LINK-STRIPPED) : SetInitPadFlag */
extern void SetInitPadFlag(int flag) { _init_pad_flag = flag; }

/* @0x8010C9B0 : ReadInitPadFlag. */
extern int ReadInitPadFlag(void) { return _init_pad_flag; }

/* PAD.obj +28 (LINK-STRIPPED) : PAD_init */
extern int PAD_init(unsigned long a, unsigned long *b, unsigned long c, unsigned long d)
{
    _remove_ChgclrPAD();
    EnterCriticalSection();
    _patch_pad();
    ExitCriticalSection();
    ChangeClearPAD(0);
    _pad_install_intr();
    PAD_init2(a, b, c, d);
    _init_pad_flag = 1;
    return 1;
}

/* PAD.obj +172 (LINK-STRIPPED) : InitPAD */
extern int InitPAD(char *b1, long l1, char *b2, long l2)
{
    _remove_ChgclrPAD();
    EnterCriticalSection();
    _patch_pad();
    ExitCriticalSection();
    ChangeClearPAD(0);
    _pad_install_intr();
    InitPAD2(b1, l1, b2, l2);
    _init_pad_flag = 1;
    return 1;
}

/* PAD.obj +316 (LINK-STRIPPED) : StartPAD */
extern int StartPAD(void)
{
    StartPAD2();
    ChangeClearPAD(0);
    EnablePAD();
    return 1;
}

/* PAD.obj +364 (LINK-STRIPPED) : StopPAD */
extern void StopPAD(void)
{
    DisablePAD();
    StopPAD2();
    _pad_remove_intr();
    _init_pad_flag = 0;
}

/* PAD.obj +420 (LINK-STRIPPED, static) : hook the pad interrupt handler into the BIOS chain */
static int _pad_install_intr(void)
{
    long *p;

    EnterCriticalSection();
    p = &_pad_node[1];
    p[0] = (long)_pad_intr_ack;
    p[1] = (long)_pad_intr_verify;
    _pad_node[0] = 0;
    _pad_node[3] = 0;
    SysDeqIntRP(1, _pad_node);
    SysEnqIntRP(1, _pad_node);
    ExitCriticalSection();
    return 1;
}

/* PAD.obj +540 (LINK-STRIPPED, static) */
static int _pad_remove_intr(void)
{
    EnterCriticalSection();
    SysDeqIntRP(1, _pad_node);
    ExitCriticalSection();
    return 1;
}

/* PAD.obj +596 (LINK-STRIPPED, static) : acknowledge -- clear JOY_CTRL, then a short volatile countdown */
static int _pad_intr_ack(void)
{
    volatile int i[3];

    *(unsigned short *)(_pad_joy_data + 10) = 0;
    i[0] = 10;
    while (--i[0] != -1)
        ;
    return 0;
}

/* PAD.obj +700 (LINK-STRIPPED, static) : is this our interrupt?  (I_MASK bit 0 and I_STAT bit 0) */
static int _pad_intr_verify(void)
{
    if ((_pad_i_stat[1] & 1) == 0)
        return 0;
    if (_pad_i_stat[0] & 1)
        return 1;
    return 0;
}
/* end of PAD.c */
