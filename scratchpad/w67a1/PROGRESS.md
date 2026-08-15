LIBETC: PUBLISHED. reloc-only=12 exports (+11 retail statics localized inside spans, all reloc-only); absent=5 (PAD*/HWCONFIG/GetIntrMask not linked); the 2 'drifted' rows = vendor v1.75 compat thunks not present in retail (see BYTETRUTH.md analysis). _intrhand GROUND TRUTH LIVE in truth/LIBETC/SetIntrMask.txt.
LIBGPU: absent=72 identical=11 reloc-only=22
LIBGPU: PUBLISHED. identical=11 reloc-only=22 (ALL retail-linked fns green; sys.c v1.140 CONFIRMED; 27 SYS statics annotated reloc-only; FntFlush/FntPrint green). absent=72 = not linked.
LIBMCRD: absent=2 reloc-only=38
LIBPAD: absent=18 identical=3 reloc-only=26
LIBMCRD: PUBLISHED. reloc-only=38, absent=2 (MemCardOpen/Close elided by retail revision). ZERO DRIFT.
LIBPAD: PUBLISHED. identical=3 reloc-only=26, absent=18 (gun/mtap + per-fn elisions). ZERO DRIFT.
LIBMATH: absent=43 identical=1 reloc-only=19
LIBC: absent=30 identical=20 reloc-only=5
LIBCD: absent=18 drifted=2 identical=2 reloc-only=44
LIBAPI: absent=64 identical=30 reloc-only=5
LIBMATH: PUBLISHED. 20/20 retail-linked green — retail libmath == psyq43 LIBMATH.LIB verbatim (04X drop IDENTIFIED).
LIBC: PUBLISHED. sprintf reloc-only; memcmp/memmove/qsort/bsearch green; 20 thunks identical.
LIBCD: PUBLISHED. CD_sync/CD_ready/CD_cw + whole BIOS/SYS/TOC/ISO9660 green; CDREAD member = GENUINE revision drift (2 fns); CD_init found unnamed @0x80108140 (reloc-only).
LIBAPI: PUBLISHED. 30 identical + COUNTER/FIRST/ReadInitPadFlag reloc-only.
ALL 8 TARGET LIBS DONE: 238/242 retail-anchored fns byte-match (only CDREAD skews).
