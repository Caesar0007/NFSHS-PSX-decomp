NL = chr(13) + chr(10)
ENV = {}

FENCE = '  __asm__("" : : "r"(carPixMapCount));' + NL
IF = ("  if ((reload & 0x10U) == 0) {" + NL +
      "    carPixMapCount = CarIO_carPixMapCount;" + NL +
      "    (carObj->render).textureStartIndex = CarIO_carPixMapCount;" + NL +
      "  }" + NL +
      "  else {" + NL +
      "    carPixMapCount = (carObj->render).textureStartIndex;" + NL +
      "  }" + NL)

F4 = '    __asm__("" : : "r"(carPixMapCount));' + NL


def build(then_f, else_f, keep_join):
    def f(s):
        assert s.count(FENCE) == 1 and s.count(IF) == 1
        newif = IF
        if then_f:
            newif = newif.replace("    (carObj->render).textureStartIndex = CarIO_carPixMapCount;" + NL,
                                  "    (carObj->render).textureStartIndex = CarIO_carPixMapCount;" + NL + F4)
        if else_f:
            newif = newif.replace("    carPixMapCount = (carObj->render).textureStartIndex;" + NL,
                                  "    carPixMapCount = (carObj->render).textureStartIndex;" + NL + F4)
        s = s.replace(IF, newif)
        if not keep_join:
            s = s.replace(FENCE, '')
        return s
    return f


PATCHES = [
    ("ctl", build(False, False, True)),
    ("both_arms_nojoin", build(True, True, False)),
    ("then_only_nojoin", build(True, False, False)),
    ("else_only_nojoin", build(False, True, False)),
    ("both_arms_plusjoin", build(True, True, True)),
    ("then_only_plusjoin", build(True, False, True)),
]
