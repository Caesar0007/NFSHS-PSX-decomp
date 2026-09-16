#!/usr/bin/env python3
"""alias_cert_edits.py -- the hand part of the dialect rewrite: the three cert TUs include the
dialect-neutral asm/cert/*.s copies (no macro.inc) instead of the splat-style oracle files.
(`X = Y` symbol aliases stay in gas form: the gcc-2.8 lane defers every function body past all
file-scope asm, so a co-located label cannot be placed from source; psylink_lane.sn_text()
turns each alias into a label right after the aliased symbol's own label line.)"""
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
CR = chr(13)
LF = chr(10)


def patch(rel, pairs):
    p = ROOT / rel
    raw = p.read_bytes().decode('utf-8')
    crlf = (CR + LF) in raw
    t = raw.replace(CR + LF, LF)
    for old, new in pairs:
        assert t.count(old) == 1, (rel, old[:60], t.count(old))
        t = t.replace(old, new)
    if crlf:
        t = t.replace(LF, CR + LF)
    p.write_bytes(t.encode('utf-8'))
    print('patched', rel)


patch('recon/syslib/psx/libgpu/FONT.c', [
    ('__asm__(".include \\"macro.inc\\" # maspsx-keep\\n\\t.set reorder # maspsx-keep\\n\\t.set at # maspsx-keep\\n");\n',
     '__asm__("\\t.set reorder # maspsx-keep\\n\\t.set at # maspsx-keep\\n");\n'),
    ('".include \\"asm/nonmatchings/main/FntFlush.s\\" # maspsx-keep\\n"', '".include \\"asm/cert/FntFlush.s\\" # maspsx-keep\\n"'),
])
patch('recon/syslib/psx/libmcrd/LIBMCRD.c', [
    ('__asm__(".include \\"macro.inc\\"\\n\\t.set reorder\\n\\t.set at\\n");\n', '__asm__("\\t.set reorder\\n\\t.set at\\n");\n'),
    ('".include \\"asm/nonmatchings/main/MemCardGetDirentry.s\\"\\n"', '".include \\"asm/cert/MemCardGetDirentry.s\\"\\n"'),
    ('".include \\"asm/nonmatchings/main/MemCardFormat.s\\"\\n"', '".include \\"asm/cert/MemCardFormat.s\\"\\n"'),
])
patch('recon/syslib/psx/libcd/stcdint.c', [
    ('__asm__(".include \\"macro.inc\\"\\n\\t.set reorder\\n\\t.set at\\n");\n', '__asm__("\\t.set reorder\\n\\t.set at\\n");\n'),
    ('".include \\"asm/nonmatchings/main/_st_dma.s\\"\\n"', '".include \\"asm/cert/_st_dma.s\\"\\n"'),
])
