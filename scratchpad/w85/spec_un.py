BLK = """    columnx = this->fCurrentColumn * 0x1c;
    row = this->fCurrentRow;
    __asm__("" : : "r"(row));
    xx = columnx + 0x102;
    __asm__("" : "=r"(columnx) : "0"(columnx));
    yy = *menuStartY + row * 0xf;
"""

CASES = [
 ("U0 baseline", []),
 ("U1 no row fence", [(BLK, BLK.replace('    __asm__("" : : "r"(row));\n', ''))]),
 ("U2 no devices", [(BLK, """    columnx = this->fCurrentColumn * 0x1c;
    row = this->fCurrentRow;
    xx = columnx + 0x102;
    yy = *menuStartY + row * 0xf;
""")]),
 ("U3 no devices, xx last", [(BLK, """    columnx = this->fCurrentColumn * 0x1c;
    row = this->fCurrentRow;
    yy = *menuStartY + row * 0xf;
    xx = columnx + 0x102;
""")]),
 ("U4 no row fence, xx last", [(BLK, """    columnx = this->fCurrentColumn * 0x1c;
    row = this->fCurrentRow;
    yy = *menuStartY + row * 0xf;
    xx = columnx + 0x102;
    __asm__("" : "=r"(columnx) : "0"(columnx));
""")]),
 ("U5 no row fence, row loaded first", [(BLK, """    row = this->fCurrentRow;
    columnx = this->fCurrentColumn * 0x1c;
    xx = columnx + 0x102;
    __asm__("" : "=r"(columnx) : "0"(columnx));
    yy = *menuStartY + row * 0xf;
""")]),
 ("U6 no row fence, dial on row", [(BLK, """    columnx = this->fCurrentColumn * 0x1c;
    do { row = this->fCurrentRow; } while (0);
    xx = columnx + 0x102;
    __asm__("" : "=r"(columnx) : "0"(columnx));
    yy = *menuStartY + row * 0xf;
""")]),
 ("U7 no row fence, xx via in-place", [(BLK, """    columnx = this->fCurrentColumn * 0x1c;
    row = this->fCurrentRow;
    xx = 0x102;
    xx += columnx;
    __asm__("" : "=r"(columnx) : "0"(columnx));
    yy = *menuStartY + row * 0xf;
""")]),
 ("U8 no row fence, yy before xx, columnx fence kept", [(BLK, """    row = this->fCurrentRow;
    columnx = this->fCurrentColumn * 0x1c;
    yy = *menuStartY + row * 0xf;
    xx = columnx + 0x102;
    __asm__("" : "=r"(columnx) : "0"(columnx));
""")]),
]
