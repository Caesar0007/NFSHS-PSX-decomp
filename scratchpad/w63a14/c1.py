NL = chr(13) + chr(10)
ENV = {}

F = '  __asm__("" : : "r"(carPixMapCount));' + NL


def rep(new):
    def f(s):
        assert s.count(F) == 1, ('anchor', s.count(F))
        return s.replace(F, new)
    return f


PATCHES = [
    ("ctl", rep(F)),
    ("m_cpmc", rep('  __asm__("" : : "m"(carPixMapCount));' + NL)),
    ("g_cpmc", rep('  __asm__("" : : "g"(carPixMapCount));' + NL)),
    ("m_carType", rep('  __asm__("" : : "m"(carType));' + NL)),
    ("g_carType", rep('  __asm__("" : : "g"(carType));' + NL)),
    ("mm_both", rep('  __asm__("" : : "m"(carPixMapCount), "m"(carType));' + NL)),
    ("m_cpmc_x2", rep('  __asm__("" : : "m"(carPixMapCount));' + NL +
                      '  __asm__("" : : "m"(carPixMapCount));' + NL)),
]
