NL = chr(10)
A = '  __asm__("" : : "r"(carCXBits));' + NL + '  unsigned long carCYBits = 0xc0eccccd;' + NL
TAIL = '  __asm__("" : : "r"(carCXBits));' + NL + '  return;' + NL
L = '    __asm__("" : "=r"(carCXBits) : "0"(carCXBits));' + NL

VARIANTS = [
    ("lead_drop", [(A, '  unsigned long carCYBits = 0xc0eccccd;' + NL)]),
    ("lead_abs_this", [(A, '  carCXBits &= (carCXBits | (unsigned long)(int)this);' + NL + '  unsigned long carCYBits = 0xc0eccccd;' + NL)]),
    ("lead_abs_this2", [(A, ('  carCXBits &= (carCXBits | (unsigned long)(int)this);' + NL) * 2 + '  unsigned long carCYBits = 0xc0eccccd;' + NL)]),
    ("tail_drop", [(TAIL, '  return;' + NL)]),
    ("tail_abs", [(TAIL, '  carCXBits &= (carCXBits | (unsigned long)(int)this);' + NL + '  return;' + NL)]),
    ("launder_drop", [(L, "")]),
    ("launder_abs", [(L, '    carCXBits &= (carCXBits | (unsigned long)(int)this);' + NL)]),
]
