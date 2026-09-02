TH = '  __asm__("" : "+r" (this_00));\n  popUp = this_00;\n'
T = 'tDialogMessageString *'
CI = '(int)&carInfo'

VARIANTS = [
    ("drop", [(TH, '  popUp = this_00;\n')]),
    ("popUp_abs_ci", [(TH, '  popUp = (%s)((int)this_00 & ((int)this_00 | %s));\n' % (T, CI))]),
    ("popUp_absOR_ci", [(TH, '  popUp = (%s)((int)this_00 | ((int)this_00 & %s));\n' % (T, CI))]),
    ("this_abs_then_copy", [(TH, '  this_00 = (%s)((int)this_00 & ((int)this_00 | %s));\n  popUp = this_00;\n' % (T, CI))]),
    ("popUp_abs_selfmix", [(TH, '  popUp = (%s)((int)this_00 & ((int)this_00 | (int)&carManager));\n' % T)]),
    ("popUp_deadreassign", [(TH, '  popUp = this_00;\n  this_00 = (%s)((int)this_00 | 0);\n' % T)]),
]
