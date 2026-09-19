"""Follow-up to own_crc_font.py: crc.c's handwritten block must switch back to .text now that a data
definition precedes it; FONT.obj is a Sony library object built -G0 (its 4-byte counters sit inline in .data
at 0x80135FD8/DC, between the streams and the image -- at the lane default -G4 they went to .sdata)."""
R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/eaclib/psx/eacpsxz/crc.c', [
    ('__asm__(\n    "\\t.set noat\\n"\n    "\\t.set\\tnoreorder\\n"',
     '__asm__(\n    "\\t.text\\n"   /* the table definition above leaves the assembler in .data */\n'
     '    "\\t.set noat\\n"\n    "\\t.set\\tnoreorder\\n"'),
])
edit('tools/build.py', [
    ('    "recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True,   # FntPrint\n',
     '    "recon/syslib/psx/libgpu/FONT.c":       {"g_value": "0",   # 2026-09-19: _fnt_count/_fnt_active are retail .data (0x80135FD8/DC), not .sdata\n'
     '                                             "jtbl_at_fusion": True,   # FntPrint\n'),
])
