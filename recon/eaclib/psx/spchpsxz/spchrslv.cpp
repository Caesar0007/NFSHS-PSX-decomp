/* eaclib/psx/spchpsxz/spchrslv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\spchrslv.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800EBBD4.  SPCH_ResolveData -- the public "register a speech data blob" entry point; a thin pass
 *   through to spchrand's iSPCH_BindData.  Called by nfs2eacinit (game init).  Ghidra nfs4-f.exe.c + IDA.
 *
 *   Ghidra-isms resolved: `__thiscall this` is the real arg (a u16* data pointer); Ghidra's void return
 *   dropped the tail value -- IDA `int __fastcall sub_800EBBD4(unsigned __int16 *a1)` and the disasm show
 *   iSPCH_BindData's v0 is passed straight back, so the return is int.
 */

extern "C" int iSPCH_BindData(unsigned short *dat);   /* spchrand */

extern "C" int SPCH_ResolveData(unsigned short *dat); /* @0x800EBBD4 */

/* SPCH_ResolveData @0x800EBBD4 : bind `dat` into the speech event-data table; returns iSPCH_BindData's result
 *   (1 if accepted into a free gEventDats slot, 0 if rejected/full). */
extern "C" int SPCH_ResolveData(unsigned short *dat)
{
    return iSPCH_BindData(dat);
}
