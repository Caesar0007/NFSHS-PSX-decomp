BASE = '    CdIntToPos(16, locp);                           /* position of sector 16 (ISO PVD) */\r\n'
WATCH = ['CdGetDiskType']
VARIANTS = [('A current', '    CdIntToPos(16, locp);                           /* position of sector 16 (ISO PVD) */\r\n'), ('B named sec', '    { int sec = 16; CdIntToPos(sec, locp); }\r\n'), ('C fenced sec', '    { int sec = 16; __asm__("" : "=r"(sec) : "0"(sec)); CdIntToPos(sec, locp); }\r\n'), ('D volatile sec', '    { volatile int sec = 16; CdIntToPos(sec, locp); }\r\n')]
