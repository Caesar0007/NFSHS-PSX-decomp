"""bigbuf_address.py -- the first two modules of the retail link get their TUs (USER, 2026-09-20: bigbuf.obj = zero-filled
space reservation for the front.bin overlay in the main binary; address.obj = the overlay's start / end addresses).

MAP: the `text` group's .rdata starts at 0x80010000 (NOT at 0x80054548) and the `front` group is `over(text)` at the same
origin.  Link order: bigbuf.obj [0], address.obj [1].  address.obj = C:/NFS4/FRONTEND/PSX/ADDRESS.ASM (SLD lines 11..16),
its two words are at 0x80054D90 -- so bigbuf.obj's .rdata is 0x80010000..0x80054D90 = 0x44D90 = 282000 bytes EXACTLY (a
round decimal), not the 0x44548 the overlay happens to use.  The 2120 zero bytes 0x80054548..0x80054D90 that were carried
as `linker filler` are the unused tail of that reservation."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(p):
    return open(R + p, encoding='utf-8').read()


def wr(p, s):
    open(R + p, 'w', encoding='utf-8', newline='').write(s)


def sub1(s, a, b):
    assert s.count(a) == 1, a[:70]
    return s.replace(a, b)


wr('recon/frontend/psx/bigbuf.c',
   '/* frontend/psx/bigbuf.c -- RECONSTRUCTED.  obj bigbuf.obj: the FIRST module of the retail link (SYM FILE record 0).' + NL +
   ' *   A zero-filled SPACE RESERVATION in the main binary for the front.bin overlay: the `text` group\'s .rdata starts at' + NL +
   ' *   0x80010000 with this block, and the `front` group (front.rdata / front.text / front.data / front.bss, 0x44548 bytes)' + NL +
   ' *   is linked `over(text)` at the same origin -- at run time nfs3.cpp loads front.bin AT bigBuf, and in the retail EXE the' + NL +
   ' *   overlay image already lies over the first 0x44548 bytes.  Size: address.obj, the next module, starts at 0x80054D90,' + NL +
   ' *   so the block is 0x44D90 = 282000 bytes exactly; the 2120 bytes past the overlay\'s end are the unused tail and are' + NL +
   ' *   zero in the image.  No function, no debug record: the original is an assembler file like its neighbour ADDRESS.ASM.' + NL +
   ' *   The other TUs see it as `extern char bigBuf[]` (a scratch / load buffer once the front end is gone). */' + NL +
   'const char bigBuf[282000] = { 0 };   /* @0x80010000 (.rdata) */' + NL)
wr('recon/frontend/psx/address.c',
   '/* frontend/psx/address.c -- RECONSTRUCTED.  obj address.obj = C:\\NFS4\\FRONTEND\\PSX\\ADDRESS.ASM (SYM SLD lines 11..16),' + NL +
   ' *   the SECOND module of the retail link: the start and end address of the front.bin overlay, i.e. of the `front`' + NL +
   ' *   group the linker lays over bigbuf.obj.  Two .rdata words @0x80054D90 right behind bigBuf[282000]; the values are the' + NL +
   ' *   linker\'s group symbols (SYM linker records _front_obj = 0x80010000, _front_objend = 0x80054548). */' + NL +
   'extern char _front_obj[], _front_objend[];' + NL + NL +
   'char * const FrontStartAddress = _front_obj;      /* @0x80054D90 */' + NL +
   'char * const FrontEndAddress   = _front_objend;   /* @0x80054D94 */' + NL)

p = 'linkers/nfs4_recon.rodata_extra.json'
rows = json.load(open(R + p))
assert not any('frontend/psx/address' in r['obj'] for r in rows)
rows.append({'obj': 'build/recon/frontend/psx/address.c.o', 'section': '.rodata', 'base': 0x80054D90, 'end': 0x80054D98, 'size': 8,
             'ok': True, 'unresolved': 0, 'words': 2, 'q': 0})
wr(p, json.dumps(rows, indent=1) + NL)

s = rd('tools/gen_ld.py')
s = sub1(s, '    A(f"    .rodata_front {OVERLAY_START:#x} : SUBALIGN(4)")' + NL,
         '    # bigbuf.obj: the zero-filled reservation the front overlay is linked OVER (retail: group `front over(text)`).  It is' + NL +
         '    # emitted FIRST so every overlay section, which shares its addresses by design, comes after it (honest_measure and' + NL +
         '    # objcopy let the later section win, exactly like the retail EXE); its 2120-byte tail past the overlay is image content.' + NL +
         '    if (ROOT / "build/recon/frontend/psx/bigbuf.c.o").is_file():' + NL +
         '        A(f"    .bigbuf {OVERLAY_START:#x} : SUBALIGN(4) {{ build/recon/frontend/psx/bigbuf.c.o(.rodata); }}")' + NL +
         '        A("    ASSERT(SIZEOF(.bigbuf) == 282000, \\"bigbuf.obj reservation size\\")")' + NL +
         '        A("")' + NL +
         '    A(f"    .rodata_front {OVERLAY_START:#x} : SUBALIGN(4)")' + NL)
wr('tools/gen_ld.py', s)

s = rd('tools/overlap_audit.py')
s = sub1(s, 'ev = sorted(secs, key=lambda s: s[1])' + NL,
         '# .bigbuf = bigbuf.obj, the zero-filled reservation the front overlay is linked OVER (retail: group `front over(text)`).' + NL +
         '# Every overlay byte overlaps it BY DESIGN and the overlay wins, in retail and here; its bytes nothing overlaps (the' + NL +
         '# 2120-byte tail) are compared by honest_measure like any other section.' + NL +
         "secs = [s for s in secs if s[0] != '.bigbuf']" + NL + 'ev = sorted(secs, key=lambda s: s[1])' + NL)
wr('tools/overlap_audit.py', s)

s = rd('tools/foreign_labels.py')
a = s.index("# bigBuf @0x80010000 is bigbuf.obj's view")
b = s.index("ALLOW = {'bigBuf'}") + len("ALLOW = {'bigBuf'}")
s = s[:a] + ("# bigbuf.obj is the reservation the whole front overlay is linked OVER (retail: group `front over(text)`), so every overlay" + NL +
             "# label lies inside it by design; it is checked for its own label only." + NL + "OVERLAID = ('frontend/psx/bigbuf.c.o',)" + NL + 'ALLOW = set()') + s[b:]
s = sub1(s, "    mine = sorted(syms(o).get(sec, []))" + NL, "    if o.endswith(OVERLAID):" + NL + "        inside = [L for L in inside if L == a]" + NL + "    mine = sorted(syms(o).get(sec, []))" + NL)
wr('tools/foreign_labels.py', s)
print('ok')
