"""bigbuf_address2.py -- the head of asm/data/rdata_80054548_r00 (bigbuf.obj's 2120-byte tail + address.obj's two words,
0x80054548..0x80054D98) is source-owned now: it moves to an oracle-only `_legacy` piece (src lane, linkers/nfs4.ld) and the
recon lane's main-rodata spine starts at the first remaining piece."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(p):
    return open(R + p, encoding='utf-8').read()


def wr(p, s):
    open(R + p, 'w', encoding='utf-8', newline='').write(s)


def sub1(s, a, b):
    assert s.count(a) == 1, a[:70]
    return s.replace(a, b)


p = 'asm/data/rdata_80054548_r00.rodata.s'
s = rd(p)
k = 'enddlabel FrontEndAddress' + NL
i = s.index(k) + len(k)
h = s.index('nonmatching _front_dtors_orgend')
head, rest = s[h:i], s[i:]
pre = s[:h]
assert '80054548' in head and '80054D94' in head and '80054D98' in rest
wr('asm/data/rdata_bigbuf_address_legacy.rodata.s',
   '.include "macro.inc"' + NL +
   '/* 2026-09-20: src/expected raw oracle of 0x80054548..0x80054D98 -- the unused 2120-byte TAIL of bigbuf.obj\'s 282000-byte' + NL +
   ' * overlay reservation (recon/frontend/psx/bigbuf.c) and address.obj\'s two words (recon/frontend/psx/address.c).  Linked by' + NL +
   ' * linkers/nfs4.ld only; the recon lane owns these bytes in source. */' + NL +
   '.section .rodata, "a"' + NL + NL + head)
wr(p, pre + '/* 2026-09-20: the head 0x80054548..0x80054D98 (bigbuf.obj tail + address.obj) lives in rdata_bigbuf_address_legacy.rodata.s */' + NL + rest)

s = rd('linkers/nfs4.ld')
k = '        build/asm/data/rdata_80054548_r00.rodata.s.o(.rodata);' + NL
s = sub1(s, k, '        build/asm/data/rdata_bigbuf_address_legacy.rodata.s.o(.rodata); /* 2026-09-20: bigbuf.obj tail + address.obj, source-owned in the recon lane */' + NL + k)
wr('linkers/nfs4.ld', s)

s = rd('tools/gen_ld.py')
s = sub1(s, '        assert main_ro[0][0] == MAIN_RODATA_START, \\' + NL + '            f"first main-rodata piece is at {main_ro[0][0]:#x}, not the blob base"' + NL,
         '        # 2026-09-20: 0x80054548..0x80054D98 is bigbuf.obj\'s tail + address.obj, owned by recon/frontend/psx/{bigbuf,address}.c' + NL +
         '        assert main_ro[0][0] in (MAIN_RODATA_START, 0x80054D98), \\' + NL +
         '            f"first main-rodata piece is at {main_ro[0][0]:#x}, not the blob base"' + NL)
s = sub1(s, '    A(f"    .rodata_main {MAIN_RODATA_START:#x} : SUBALIGN(4)")' + NL, '    main_ro_base = main_ro[0][0]' + NL + '    A(f"    .rodata_main {main_ro_base:#x} : SUBALIGN(4)")' + NL)
s = sub1(s, '        A(f"        . = {va - MAIN_RODATA_START:#x};")' + NL, '        A(f"        . = {va - main_ro_base:#x};")' + NL)
wr('tools/gen_ld.py', s)
print('ok')
