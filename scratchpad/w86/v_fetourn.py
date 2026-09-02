F = '      __asm__("" : : "m"(this->fCompetitors[i]));\n'
VARIANTS = [
    ("drop", [(F, "")]),
    ("abs_i_stats", [(F, '      i &= (i | (int)stats);\n')]),
    ("abs_i_k", [(F, '      i &= (i | k);\n')]),
    ("abs_i_k3", [(F, '      i &= (i | k);\n' * 3)]),
    ("comp_abs", [(F, '      {\n        tCompetitor *comp = &this->fCompetitors[i];\n        comp = (tCompetitor *)((int)comp & ((int)comp | k));\n        comp->fPosition = comp->fPosition;\n      }\n')]),
]
