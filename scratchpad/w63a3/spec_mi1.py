SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['MoveImage']

GUARD = """    short *r = (short *)rect;
    u_long *p;
    _image("MoveImage", rect);                   /* @0x80056e1c */
    if (r[2] == 0 || r[3] == 0)
        return -1;
"""

DST = """    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */
"""

SPEC = [
    ("M1 psyz guard phrasing !r[2] || !r[3]", [(GUARD, """    short *r = (short *)rect;
    u_long *p;
    _image("MoveImage", rect);                   /* @0x80056e1c */
    if (!r[2] || !r[3])
        return -1;
""")]),
    ("M2 RECT-typed guard reads", [(GUARD, """    RECT *rc = (RECT *)rect;
    u_long *p;
    _image("MoveImage", rect);                   /* @0x80056e1c */
    if (!rc->w || !rc->h)
        return -1;
""")]),
    ("M3 psyz dst word (u_short)x", [(DST, """    p[1] = (u_long)((y << 16) | (u_short)x);     /* dst xy */
""")]),
    ("M4 RR dst word, y first as u_long", [(DST, """    p[1] = ((u_long)y << 16) | ((u_long)x & 0xffff);  /* dst xy */
""")]),
]
