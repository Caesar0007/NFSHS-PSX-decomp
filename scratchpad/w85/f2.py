OLD = '    MemCardMakeDevname((_mc_present |= 1 << base->chan, chan), devname);'
SUBS = [(OLD, '    {\n    char *dn = devname;\n    __asm__("" : "=r"(dn) : "0"(dn));\n    __asm__ __volatile__("" : : "i"(0));\n    { long c = base->chan; _mc_present |= 1 << c; __asm__("" : : "r"(c)); }\n    MemCardMakeDevname(chan, dn);\n    }')]
FNS = "MemCardFormat"
