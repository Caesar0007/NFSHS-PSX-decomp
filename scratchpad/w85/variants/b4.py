# cy computed before cx
from _common import PAL_FULL
new = PAL_FULL.replace("""        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);""", """        cy = (int)(clut >> 6);
        cx = (clut & 0x3f) << 4;""")
PAIRS = [(PAL_FULL, new)]
