import itertools, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_cw import TU, FUNC, EXTRA_FUNCS, A, B, b, FIP

CNT = "    cnt = tbl + 0x40;\n"
F2 = '    __asm__("" : : "r"(tbl), "r"(tbl));\n'
BASE_EDITS = [(B, b(pre=FIP)), (CNT, F2 + CNT)]

AL = """    ALARM.deadline = VSync(-1) + 0x3c0;
    cmdNames = CD_comstr;
    ALARM.counter = 0;
    ALARM.name = "CD_cw";
"""
D = "    ALARM.deadline = VSync(-1) + 0x3c0;\n"
C = "    cmdNames = CD_comstr;\n"
N = '    ALARM.name = "CD_cw";\n'
Z = "    ALARM.counter = 0;\n"

VARIANTS = {"base18": BASE_EDITS}
for perm in itertools.permutations([("d", D), ("c", C), ("z", Z), ("n", N)]):
    if perm[0][0] != "d":
        continue                     # the VSync call must stay first (real dataflow order)
    key = "".join(p[0] for p in perm)
    VARIANTS["AL_" + key] = BASE_EDITS + [(AL, "".join(p[1] for p in perm))]
