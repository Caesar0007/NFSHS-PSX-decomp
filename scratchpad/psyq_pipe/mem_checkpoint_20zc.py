"""Insert CHECKPOINT 2026-09-20zc into the NFS4 memory hub (before the 2026-09-20zb line) + MEMORY.md pointers."""
D = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/'
P = D + '00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20zc' not in s
i = s.index('- CHECKPOINT 2026-09-20zb ')
NEW = (
    "- CHECKPOINT 2026-09-20zc (USER FACTS: 'front.bin is overlay, check MAP/SYM for what it contains; bigbuf.obj = space reservation "
    "file (zero filled) for the front.bin overlay in the main binary; address.obj = starting and ending address of bigbuf.obj/front.bin "
    "overlay' -> memory [[project-nfs4-overlay-bigbuf-address]] + [[feedback-sym-module-canonical]]): nfs4-decomp `main` = see git log "
    "(LOCAL, NOT pushed; pushed = 4d4a4179). VERIFIED vs MAP/SYM: `text` group .rdata starts at 0x80010000 and the `front` group is linked "
    "OVER it; bigbuf.obj / address.obj = link modules 0 / 1; address.obj = C:\\NFS4\\FRONTEND\\PSX\\ADDRESS.ASM (SLD 11..16), words "
    "FrontStartAddress @0x80054D90 = _front_obj, FrontEndAddress @0x80054D94 = _front_objend. => bigBuf = 0x80010000..0x80054D90 = "
    "282000 BYTES EXACTLY; the 2120 zero bytes 0x80054548..0x80054D90 I had filed as 'ctor/dtor linker filler' are the unused TAIL of the "
    "reservation. DONE: recon/frontend/psx/bigbuf.c (`const char bigBuf[282000] = {0};`, gen_ld emits `.bigbuf 0x80010000` FIRST so the "
    "overlay sections that share its addresses win, ASSERT size 282000) + recon/frontend/psx/address.c (g_value 0 -> plain .rodata; "
    "rodata_extra.json row 0x80054D90). asm/data/rdata_80054548_r00 lost its head -> rdata_bigbuf_address_legacy.rodata.s (src lane "
    "linkers/nfs4.ld only); gen_ld main-rodata spine may start at 0x80054D98. ONE documented by-design exception each in "
    "tools/overlap_audit.py (.bigbuf skipped), tools/foreign_labels.py (OVERLAID object + the labels it defines) and "
    "tools/honest_measure.py (`wide` owners >= 64 KB asked when the nearest-start owner does not reach a word). RESULTS: honest link "
    "299710/299710 = 0 diff (was 297407: front.bss's file zeros 1668 w + tail 530 w + address 2 w + ~94 overlay inter-object pad words "
    "now covered by bigbuf -- the pad words are a slight over-credit), overlap audit 0, foreign labels 0/0, relink gate GREEN, blob-only "
    "bytes 3226 -> 800 (33 pieces, largest 116 B). PSYLINK lane: placeholders (0x44548 / ONE word) replaced by the real objects -> "
    "518/518 assemble, 0 link errors (the SN linker resolves _front_obj/_front_objend itself), .text base delta -0xa60 -> -0x210 "
    "(= exactly 0x850), still ONE drift point (Stats_TrackEndGame). Retail module names still WITHOUT a TU now: sdasync, unitvect, "
    "textsubs, hypot3d, hypot, libcd C_011 (= stcdint.c rename), 2mbyte.\n"
)
s = s[:i] + NEW + s[i:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
M = D + 'MEMORY.md'
m = open(M, encoding='utf-8', errors='surrogateescape').read()
k = '- 🔴 **NFS4 TRUSTED SYM'
assert m.count(k) == 1 and 'project_nfs4_overlay_bigbuf_address.md' not in m
m = m.replace(k, '- 🔑 [NFS4 overlay model: bigbuf.obj / address.obj](project_nfs4_overlay_bigbuf_address.md) — front.bin overlay is linked OVER bigBuf[282000] (zero reservation, link module 0); address.obj = its start/end words.\n'
              '- 🔴 [NFS4: SYM-named module is canonical](feedback_sym_module_canonical.md) — never delete its TU; find what it really contributes; non-module file names are suspect.\n' + k)
open(M, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(m)
print('ok')
