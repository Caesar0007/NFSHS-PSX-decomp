# cx/cy via an int copy of clut
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace("""        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);""","""        cx = ((int)clut & 0x3f) << 4;
        cy = (int)clut >> 6;"""))]
