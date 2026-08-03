import os

OLD = ("    sx = screenPos->vx;\r\n"
       "    sy = screenPos->vy;")

BASE = ("    {\r\n    int vx0 = screenPos->vx;\r\n    int vy0 = screenPos->vy;\r\n"
        "    __asm__ volatile(\"\" : : \"r\"(vx0), \"r\"(vy0));\r\n"
        "    sx = vx0;\r\n    sy = vy0;\r\n    }")

FSP = ("    __asm__ volatile(\"\" : : \"r\"(screenPos));\r\n" + BASE)

SP2 = ("    {\r\n    DVECTOR *sp2 = screenPos;\r\n"
       "    int vx0 = sp2->vx;\r\n    int vy0 = sp2->vy;\r\n"
       "    __asm__ volatile(\"\" : : \"r\"(vx0), \"r\"(vy0));\r\n"
       "    sx = vx0;\r\n    sy = vy0;\r\n    }")

SP3 = ("    {\r\n    DVECTOR *sp2;\r\n"
       "    __asm__ volatile(\"\" : : \"r\"(screenPos));\r\n"
       "    sp2 = screenPos;\r\n"
       "    int vx0 = sp2->vx;\r\n    int vy0 = sp2->vy;\r\n"
       "    __asm__ volatile(\"\" : : \"r\"(vx0), \"r\"(vy0));\r\n"
       "    sx = vx0;\r\n    sy = vy0;\r\n    }")

# fence naming screenPos TOGETHER with the two temps
FSP2 = ("    {\r\n    int vx0 = screenPos->vx;\r\n    int vy0 = screenPos->vy;\r\n"
        "    __asm__ volatile(\"\" : : \"r\"(vx0), \"r\"(vy0), \"r\"(screenPos));\r\n"
        "    sx = vx0;\r\n    sy = vy0;\r\n    }")

# reversed temp order (vy first) -- basin-stale ordering probe
REV = ("    {\r\n    int vy0 = screenPos->vy;\r\n    int vx0 = screenPos->vx;\r\n"
       "    __asm__ volatile(\"\" : : \"r\"(vx0), \"r\"(vy0));\r\n"
       "    sx = vx0;\r\n    sy = vy0;\r\n    }")

V = {'l0': BASE, 'l1': FSP, 'l2': SP2, 'l3': SP3, 'l4': FSP2, 'l5': REV}


def apply(src):
    assert src.count(OLD) == 1
    return src.replace(OLD, V[os.environ['V']])
