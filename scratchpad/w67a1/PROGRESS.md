LIBETC: PUBLISHED. reloc-only=12 exports (+11 retail statics localized inside spans, all reloc-only); absent=5 (PAD*/HWCONFIG/GetIntrMask not linked); the 2 'drifted' rows = vendor v1.75 compat thunks not present in retail (see BYTETRUTH.md analysis). _intrhand GROUND TRUTH LIVE in truth/LIBETC/SetIntrMask.txt.
LIBGPU: absent=72 identical=11 reloc-only=22
LIBGPU: PUBLISHED. identical=11 reloc-only=22 (ALL retail-linked fns green; sys.c v1.140 CONFIRMED; 27 SYS statics annotated reloc-only; FntFlush/FntPrint green). absent=72 = not linked.
LIBMCRD: absent=2 reloc-only=38
LIBPAD: absent=18 identical=3 reloc-only=26
LIBMCRD: PUBLISHED. reloc-only=38, absent=2 (MemCardOpen/Close elided by retail revision). ZERO DRIFT.
LIBPAD: PUBLISHED. identical=3 reloc-only=26, absent=18 (gun/mtap + per-fn elisions). ZERO DRIFT.
