ANCHOR = """    if ((JOY_STAT & 0x200) != 0) {
        JOY_CTRL = JOY_CTRL | 0x10;
        if ((JOY_STAT & 0x200) != 0) {"""

VARIANTS = [
    ("Q0 control (launder landed)", ANCHOR),

    ("Q1 named JOY_STAT reads", """    if ((JOY_STAT & 0x200) != 0) {
        unsigned short c = JOY_CTRL;
        JOY_CTRL = c | 0x10;
        if ((JOY_STAT & 0x200) != 0) {"""),

    ("Q2 drop the != 0 on both tests", """    if (JOY_STAT & 0x200) {
        JOY_CTRL = JOY_CTRL | 0x10;
        if (JOY_STAT & 0x200) {"""),

    ("Q3 named stat temps", """    if ((JOY_STAT & 0x200) != 0) {
        JOY_CTRL = JOY_CTRL | 0x10;
        if ((JOY_STAT & 0x200) != 0) {"""),

    ("Q4 |= form", """    if ((JOY_STAT & 0x200) != 0) {
        JOY_CTRL |= 0x10;
        if ((JOY_STAT & 0x200) != 0) {"""),
]
