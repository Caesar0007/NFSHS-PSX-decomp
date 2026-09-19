"""Insert CHECKPOINT 2026-09-19n into the NFS4 memory hub (after the 2026-09-19m line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-19n' not in s
i = s.index('- CHECKPOINT 2026-09-19m')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-19n: blob-only 3604 B (from 15174), honest 0 diff (297776/297776); nfs4-decomp HEAD = 91832be4 "
    "(UNPUSHED on top of pushed 6871d324; new since m: f09c0594 step 17, 59ecced6 step 18, 91832be4 step 19). "
    "🔑 LAW: the FIRST data object of each Sony library opens its .data with an 8-byte LIBRARY-INFORMATION STAMP "
    "`50 73 <lib id> 25 9B 5x 43 00` (byte-exact in PsyQ 4.3 objects; scratchpad/psyq_pipe/ps_stamps.py lists them). Owned "
    "now as `static unsigned char _lib_stamp[8]` = first data definition (non-const statics are always output by gcc 2.x, "
    "in definition order): libgpu SYS 0x8012364C (id 07), libetc VSYNC 0x80134A80 (06), libmcrd 0x80136CB0 (18, + "
    "`_mc_reserved[2]` closing its 32-byte .data), libpad PADMAIN 0x80137C70 (0C, + `_pad_reserved[3]` closing 128 B), "
    "libmath FERR 0x8013BF10 (0B), libcard INIT 0x8013C328 (03, 16 B). The three 8-byte `sn_lnk_*.text.s` blobs in .TEXT "
    "(0x800E80C4 libc id 01, 0x800F219C libgte 09, 0x8010694C libapi 00) are the SAME stamps, not SN-LNK bytes (user ruling "
    "stands: they stay data). PITFALL: linkers/nfs4_recon.data_8010CCD4.ldfrag is a SEQUENTIAL hand list -- an object "
    "listed there that GROWS shifts everything after it (269 diff words until the now fully-owned residual "
    "data_8010CCD4_r19 line was removed from the recon ldfrag; the .s stays for the splat lane nfs4.ld); objects placed via "
    "data_extra rows only are overlays and do not shift. Step 18 (SDK LIBCD): stcdint.c = C_011.obj, .data is 80 B "
    "(0x80136A98..AE8: 18 register pointers, public `debug_cause` @+72, closing zero) ; C_002/C_005/CDROM/C_009/C_007 each "
    "own 4 private CD register pointers (0x80136AE8/C58/C78/C88/C9C by LINK ORDER). Step 19 (pinned by link order between "
    "those): cdfs.c `pfuncCdReadyCallback` 0x80136C98, scdvol.c `short sndcdvs[2] = {0x40,0x7F}` 0x80136CAC (the old "
    "[6] view ran into LIBMCRD's stamp). RUNTIME: trace_race2.json (150 s race with pad pulses from `race_start`) touched "
    "only currentfilesystem (openfile) and loadfilecallback (loadfileadratomic) among remaining cells -> the other zero "
    "cells are not reached in boot/menu/race. NAMES for the leftovers from C:/Temp/_from_github/dumpsym_src-master/"
    "nfs4f_ranges-v2-fixed.xlsx: 0x80054548/2120 = `_front_ctors_dtors_pad` (front.bss linker pad, not source); "
    "0x8012362C/32 = `vbltmrsub` (8 slots, no static ref); 0x8013DC54..64 = library(4)/disablecd(1)/currentfilesystem/"
    "availablefilesystems = a DATA-ONLY EA object right before vars.obj (users: fileroot initfileio/setdirectory/openfile, "
    "nfile FILE_initwithmem, Platform_SysStartUp; all ABSOLUTE refs; NOT vars.obj = SYM-proven 40 symbols; PC oracle puts "
    "`library`/`videopages` in PC-only initgrf -> no PSX object name yet); 0x8013DD50..5C = textntabstops/texttabstops/"
    "showmissingcharacters; 0x8013DD60..7C = loadfilecallback(nsync)/videopages/videopage/windowpage/gpusetdispenv/"
    "vblsetdispenv/vsdeferred, then _bss_obj; 0x8013DD24 = unreferenced \"%c\" literal in .sdata between loadshp and "
    "joystkn (candidates by link order: exit/textset/getm/textcrnt/isqrt/fsincos); 0x80123820/24 = six unreferenced "
    "words {0x1180,-0xFC0,0xE70,-0xD68,0xC92,-0xBDF} between matrix.c .rodata and libpress TABLE; 0x80137C6C = 0x2000 word "
    "after fatantbl (sdtimrem/C73 in link order). NEXT: decide how to own the data-only EA objects (new TU needs an object "
    "name we cannot yet prove), ~40 read-only tag/pad gaps (unreferenced, runtime cannot reach), mdec.cpp 0x80052b28. "
    "Emulator instance (port 2350) STOPPED at end of this round.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
