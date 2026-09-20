"""strip_fntopen.py -- libgpu FONT.obj +224 (696 B): FntOpen, link-stripped.  Base = the PSYZ font.c source.
Also restores FONT.obj's real storage: the font image is 640 words and the next .data word is the sprite/text cursor
`i_str` (it was folded into `_fnt_image[641]`); .bss = str[0x400] + sprt[0x400] (0x4400 B) + tpage + clut."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libgpu/FONT.c'
s = open(p, encoding='utf-8').read()
a = 'u_long _fnt_image[641] __asm__("D_80135FE0") = {'
assert s.count(a) == 1
s = s.replace(a, 'u_long _fnt_image[640] __asm__("D_80135FE0") = {')
tail = '    0x00000000,' + NL + '};' + NL + 'char *D_801369E4'
assert s.count(tail) == 1
s = s.replace(tail, '};' + NL + 'int _fnt_i_str = 0;   /* @0x801369E0 : FONT.obj .data +0xB88 -- next free sprite / text slot (FntOpen); was the image\'s "641st word" */' + NL +
              'char *D_801369E4')
old = ('extern u_short _fnt_tpage;   /* FONT.obj .bss +0x4400 */' + NL + 'extern u_short _fnt_clut;    /* FONT.obj .bss +0x4402 */' + NL)
assert s.count(old) == 1
s = s.replace(old, '/* FONT.obj .bss (0x4404 B; retail keeps it, unlabelled): text + sprite pools, then the font tpage / clut ids */' + NL +
              'static char    _fnt_str[0x400];' + NL + 'static SPRT_8  _fnt_sprt[0x400];' + NL + 'static u_short _fnt_tpage;   /* +0x4400 */' + NL +
              'static u_short _fnt_clut;    /* +0x4402 */' + NL +
              'extern int  FntOpen(int x, int y, int w, int h, int isbg, int n) LINK_STRIPPED;' + NL +
              'extern void SetDrawMode(void *p, int dfe, int dtd, int tpage, void *tw);' + NL + 'extern void SetTile(void *p);' + NL +
              'extern void SetSprt8(void *p);' + NL + 'extern void SetSemiTrans(void *p, int abe);' + NL)
s = s.replace(' * starts at FntFlush.  FntLoad / FntOpen use FONT.obj\'s .bss: 0x4400 bytes of sprite + text buffers, then the two shorts' + NL +
              ' * below at +0x4400 / +0x4402.  That .bss is not modelled yet, so they are declared, not defined. */',
              ' * starts at FntFlush. */')
s = s.replace('SetDumpFnt @0, FntLoad @64, FntOpen @224 (696 B, NOT yet written)', 'SetDumpFnt @0, FntLoad @64, FntOpen @224')
m = '/* FntFlush -- CERTIFICATE (runtime-proven equivalent; vendor-cc1-only C match,'
assert s.count(m) == 1
T = '_fnt[_fnt_count]'
fn = ('/* FONT.obj +224 (LINK-STRIPPED) : FntOpen -- open a print stream (after the PSYZ libgpu font.c) */' + NL +
      'extern int FntOpen(int x, int y, int w, int h, int isbg, int n)' + NL + '{' + NL + '    int i;' + NL + '    struct { short x, y, w, h; } rect;' + NL +
      '    SPRT_8 *sprites;' + NL + NL + '    if (_fnt_count >= 8) {' + NL + '        return -1;' + NL + '    }' + NL +
      '    if (_fnt_count == 0) {' + NL + '        _fnt_i_str = 0;' + NL + '    }' + NL + '    %s.unwrap = w == 0;' % T + NL +
      '    if (_fnt_i_str + n > 0x400) {' + NL + '        n = 0x400 - _fnt_i_str;' + NL + '    }' + NL +
      '    rect.x = 0;' + NL + '    rect.y = 0;' + NL + '    rect.w = 256;' + NL + '    rect.h = 256;' + NL +
      '    SetDrawMode(&%s.draw_mode, 0, 0, _fnt_tpage, &rect);' % T + NL + '    if (isbg) {' + NL + '        SetTile(&%s.tile);' % T + NL +
      '        %s.tile.r0 = 0;' % T + NL + '        %s.tile.g0 = 0;' % T + NL + '        %s.tile.b0 = 0;' % T + NL +
      '        SetSemiTrans(&%s.tile, isbg == 2);' % T + NL + '    }' + NL +
      '    %s.tile.x0 = x;' % T + NL + '    %s.tile.y0 = y;' % T + NL + '    %s.tile.w = w;' % T + NL + '    %s.tile.h = h;' % T + NL +
      '    %s.capacity = n;' % T + NL + '    %s.written = 0;' % T + NL + '    %s.buffer = &_fnt_str[_fnt_i_str];' % T + NL +
      '    %s.sprites = &_fnt_sprt[_fnt_i_str];' % T + NL + '    %s.buffer[0] = 0;' % T + NL + '    sprites = %s.sprites;' % T + NL +
      '    for (i = 0; i < n; i++, sprites++) {' + NL + '        SetSprt8(sprites);' + NL + '        sprites->clut = _fnt_clut;' + NL + '    }' + NL +
      '    _fnt_i_str += n;' + NL + '    return _fnt_count++;' + NL + '}' + NL + NL)
s = s.replace(m, fn + m)
open(p, 'w', encoding='utf-8', newline='').write(s)
jf = json.load(open(R + 'linkers/link_stripped.json'))
jf['functions'].append({'object': 'build/recon/syslib/psx/libgpu/FONT.c.o', 'function': 'FntOpen', 'sdk': 'LIBGPU/FntOpen',
                        'evidence': 'PsyQ 4.3 libgpu FONT.obj @224+696; the retail object text starts at FntFlush (head stripped)'})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(jf, indent=1) + NL)
print('ok')
