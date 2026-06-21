/* syslib/psx/libapi/PAD_data.cpp -- owning definition for the PAD.OBJ extern.
 *   _init_pad_flag @0x8013C338 is a BSS global the BIOS-level pad init writes; PAD.OBJ
 *   (ReadInitPadFlag) only READS it, addressing it absolutely (lui/%hi + lw/%lo), so the
 *   symbol must live in a DIFFERENT TU than PAD.cpp (a tentative def in PAD.cpp would make
 *   it small-common -> gp-relative and break the byte-match -- methodology §3.12 #6).
 *   Kept in its own data TU so the link resolves while PAD.cpp stays a pure extern. */

extern "C" { int _init_pad_flag; }   /* @0x8013C338 : zero-init BSS, set at runtime by BIOS pad init */
