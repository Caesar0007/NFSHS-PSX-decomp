OLD = """    {
    register char *dn __asm__("$4") = devname;
    register long  m1 __asm__("$5") = 1;
    __asm__ __volatile__("" : : "i"(0));
    _mc_present |= 1 << (base[3]);
    fd = open(dn, m1);                           /* probe: does it already exist? */
    }"""
SUBS = [(OLD, """    {
    char *dn = devname;
    __asm__ __volatile__("" : : "i"(0));
    _mc_present |= 1 << (base[3]);
    fd = open(dn, 1);                            /* probe: does it already exist? */
    }""")]
FNS = "MemCardCreateFile"
