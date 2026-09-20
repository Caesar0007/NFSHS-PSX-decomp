"""own_by_linkorder2.py -- keep the asm/src lane (linkers/nfs4.ld) intact after own_by_linkorder1.py: the raw cells the five
new source owners replaced live on as `_legacy` oracle pieces (the project's established pattern: linked by nfs4.ld only,
oracle-only for the recon lane through SOURCE_DATA_OWNERS), and every new owner gets a payload gate."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
D = R + 'asm/data/'


def rd(p):
    return open(p, encoding='utf-8').read()


def wr(p, s):
    open(p, 'w', encoding='utf-8', newline='').write(s)
    print('ok', p.replace(R, ''))


def cell(name, va, word):
    off = va - 0x80010000 + 0x800
    be = ''.join('%02X' % ((word >> (8 * i)) & 255) for i in range(4))
    return ('nonmatching %s' % name + NL + NL + 'dlabel %s' % name + NL + '    /* %X %08X %s */ .word 0x%08X' % (off, va, be, word) + NL +
            'enddlabel %s' % name + NL + NL)


def piece(fname, who, lo, hi, cells):
    wr(D + fname, '.include "macro.inc"' + NL + '/* %s initialized-data oracle, 0x%08X..0x%08X (2026-09-20, owner proven by retail link order).' % (who, lo, hi) + NL +
       ' * Raw bytes and labels are retained for src; recon uses the typed owner. */' + NL + NL + '.section .sdata, "wa"' + NL + NL +
       ''.join(cell(n, a, w) for n, a, w in cells))


v = rd(D + 'sdata_vars_legacy.sdata.s')
head = '.section .sdata, "wa"' + NL + NL
assert v.count(head) == 1
v = v.replace('0x8013DC64..0x8013DD04', '0x8013DC54..0x8013DD04')
v = v.replace(head, head + cell('library', 0x8013DC54, 4) + cell('disablecd', 0x8013DC58, 1) + cell('currentfilesystem', 0x8013DC5C, 0) +
              cell('availablefilesystems', 0x8013DC60, 0))
wr(D + 'sdata_vars_legacy.sdata.s', v)
piece('sdata_textfor_legacy.sdata.s', 'textfor.obj', 0x8013DD50, 0x8013DD5C,
      [('textntabstops', 0x8013DD50, 0), ('texttabstops', 0x8013DD54, 0), ('showmissingcharacters', 0x8013DD58, 0)])
piece('sdata_callback_legacy.sdata.s', 'callback.obj', 0x8013DD60, 0x8013DD64, [('loadfilecallback', 0x8013DD60, 0)])
piece('sdata_window_legacy.sdata.s', 'window.obj', 0x8013DD64, 0x8013DD70,
      [('videopages', 0x8013DD64, 0), ('videopage', 0x8013DD68, 0), ('windowpage', 0x8013DD6C, 0)])
piece('sdata_pageflip_legacy.sdata.s', 'pageflip.obj', 0x8013DD70, 0x8013DD7C,
      [('gpusetdispenv', 0x8013DD70, 0), ('vblsetdispenv', 0x8013DD74, 0), ('vsdeferred', 0x8013DD78, 0)])

l = rd(R + 'linkers/nfs4.ld')
a = '        build/asm/data/sdata_8013C54C_r23.sdata.s.o(.sdata);' + NL
b = '        build/asm/data/sdata_8013C54C_r24.sdata.s.o(.sdata);' + NL
assert l.count(a) == 1 and l.count(b) == 1
l = l.replace(a, a + '        build/asm/data/sdata_textfor_legacy.sdata.s.o(.sdata);' + NL)
l = l.replace(b, '        build/asm/data/sdata_callback_legacy.sdata.s.o(.sdata);' + NL + '        build/asm/data/sdata_window_legacy.sdata.s.o(.sdata);' + NL +
              '        build/asm/data/sdata_pageflip_legacy.sdata.s.o(.sdata);' + NL)
wr(R + 'linkers/nfs4.ld', l)

p = R + 'tools/source_data_owners.py'
s = rd(p)
anchor = "    {" + NL + "        'source': 'recon/eaclib/psx/eacpsxz/vars.c', 'section': '.sdata',"
assert s.count(anchor) == 1
rows = ''
for src, va, n, oracle, rec in (
        ('textfor.c', 0x8013DD50, 12, 'sdata_textfor_legacy.sdata.s', 'eacpsxz.lib(textfor.obj), link index 317: textntabstops/texttabstops/showmissingcharacters'),
        ('callback.c', 0x8013DD60, 4, 'sdata_callback_legacy.sdata.s', 'eacpsxz.lib(callback.obj), link index 361: loadfilecallback, the only cell between threads.obj and window.obj'),
        ('window.c', 0x8013DD64, 12, 'sdata_window_legacy.sdata.s', 'eacpsxz.lib(window.obj), link index 404, data-only: videopages/videopage/windowpage'),
        ('pageflip.c', 0x8013DD70, 12, 'sdata_pageflip_legacy.sdata.s', 'eacpsxz.lib(pageflip.obj), link index 491, data-only: gpusetdispenv/vblsetdispenv/vsdeferred')):
    rows += ("    {" + NL + "        'source': 'recon/eaclib/psx/eacpsxz/%s', 'section': '.sdata'," % src + NL +
             "        'address': 0x%08X, 'size': %d," % (va, n) + NL + "        'payload': bytes(%d)," % n + NL +
             "        'oracle_source': 'asm/data/%s'," % oracle + NL +
             "        'placement': 'fragment', 'record': '2026-09-20 link-order proof: %s'," % rec + NL + "    }," + NL)
s = s.replace(anchor, rows + anchor)
s = s.replace("forty native name/address cells019083 onward", "forty-four native name/address cells (library.. head + 019083 onward)")
wr(p, s)
