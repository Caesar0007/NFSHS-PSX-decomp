OLD = '    MemCardMakeDevname((_mc_present |= 1 << base->chan, chan), devname);'
SUBS = [(OLD, '    {\n    long  nv = _mc_present | (1 << base->chan);\n    char *dn = devname;\n    __asm__("" : "=r"(dn) : "0"(dn));\n    __asm__ __volatile__("" : : "i"(0));\n    _mc_present = nv;\n    MemCardMakeDevname(chan, dn);\n    }')]
FNS = "MemCardFormat"
