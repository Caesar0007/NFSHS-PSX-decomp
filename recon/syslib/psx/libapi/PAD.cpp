/* syslib/psx/libapi/PAD.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libapi.lib(PAD.OBJ): ReadInitPadFlag -- return the "pad already initialised" flag the BIOS
 *   pad init sets; InitCARD uses it to decide whether to honour its `val` argument. (ida mislabels
 *   this GsGetWorkBase_4; it is just a one-word global read.) */

extern "C" int _init_pad_flag;   /* @0x8013C338 : set by the BIOS-level pad init */

/* @0x8010C9B0 : ReadInitPadFlag. */
extern "C" int ReadInitPadFlag(void) { return _init_pad_flag; }

/* owning-TU def (extern-declared, never defined; link-harness) */
extern "C" { int _init_pad_flag; }
