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
extern int _init_pad_flag __asm__("D_8013C338");   /* @0x8013C338 : set by the BIOS pad init */

/* @0x8010C9B0 : ReadInitPadFlag. */
extern int ReadInitPadFlag(void) { return _init_pad_flag; }
