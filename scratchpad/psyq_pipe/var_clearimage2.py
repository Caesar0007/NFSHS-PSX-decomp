FILE = 'recon/syslib/psx/libgpu/SYS.c'
START = 'extern int ClearImage2(void *rect, unsigned char r, unsigned char g, unsigned char b)\n{'
END = '/* @0x800EDA90 : LoadImage(RECT*, u_long *data) */'
H = ('extern int ClearImage2(void *rect, unsigned char r, unsigned char g, unsigned char b)\n{\n    int color;\n'
     '    _image("ClearImage2", rect);                 /* @0x80056df8 */\n')
T = '    return GEnv_drv->que_push(GEnv_drv->blit_clear, (u_long *)rect, 8, color);\n}\n\n'
VARIANTS = [
    ('g-with-flag-inner', H + '    color = ((b & 0xff) << 16) | (((g & 0xff) << 8) | 0x80000000) | (r & 0xff);\n' + T),
    ('flag-first', H + '    color = 0x80000000 | ((b & 0xff) << 16) | ((g & 0xff) << 8) | (r & 0xff);\n' + T),
    ('flag-last', H + '    color = ((b & 0xff) << 16) | ((g & 0xff) << 8) | (r & 0xff) | 0x80000000;\n' + T),
    ('b-then-g-flag-paren-all', H + '    color = (((b & 0xff) << 16) | (((g & 0xff) << 8) | 0x80000000)) | (r & 0xff);\n' + T),
    ('two-statements', H + '    color = ((b & 0xff) << 16) | ((g & 0xff) << 8) | (r & 0xff);\n    color |= 0x80000000;\n' + T),
]
