/* syslib/psx/libapi/PAD.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libapi.lib(PAD.OBJ): ReadInitPadFlag -- return the "pad already initialised" flag the BIOS
 *   pad init sets; InitCARD uses it to decide whether to honour its `val` argument. (ida mislabels
 *   this GsGetWorkBase_4; it is just a one-word global read.)
 *   The oracle reaches the flag with an ABSOLUTE lui/%hi + lw/%lo pair, i.e. PAD.OBJ does NOT own
 *   the symbol -- it is an extern BSS global the BIOS pad init writes.  Keep it a PURE extern here
 *   (a tentative def in this TU would make it small-common -> gp-relative `lw $v0,N($gp)`, 1 instr,
 *   which mismatches the oracle's 2-instr absolute form -- see methodology §3.12 #6).  The owning
 *   zero def lives in a sibling data TU (PAD_data.cpp) so the link still resolves. */

extern int _init_pad_flag;   /* @0x8013C338 : set by the BIOS-level pad init (owned in PAD_data.cpp) */

/* @0x8010C9B0 : ReadInitPadFlag. */
extern int ReadInitPadFlag(void) { return _init_pad_flag; }
