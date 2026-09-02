BASE = """            x = 0xe2 - anchorShape->width;
            VSync(0);
            i = 0;"""

VARIANTS = [
    ('b vsync-then-i0 (cur)', BASE),
    ('g shared-zero-temp', """            vsyncWait = 0;
            i = vsyncWait;
            x = 0xe2 - anchorShape->width;
            VSync(vsyncWait);"""),
    ('h shared-zero-temp late-i', """            vsyncWait = 0;
            x = 0xe2 - anchorShape->width;
            VSync(vsyncWait);
            i = vsyncWait;"""),
    ('i i-from-zero-temp only', """            vsyncWait = 0;
            i = vsyncWait;
            x = 0xe2 - anchorShape->width;
            VSync(0);"""),
]
