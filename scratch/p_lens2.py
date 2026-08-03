import os, itertools

OLD_SX = ("    sx = screenPos->vx;\r\n"
          "    sy = screenPos->vy;")
BASE = ("    {\r\n    int vx0 = screenPos->vx;\r\n    int vy0 = screenPos->vy;\r\n"
        "    __asm__ volatile(\"\" : : \"r\"(vx0), \"r\"(vy0));\r\n"
        "    sx = vx0;\r\n    sy = vy0;\r\n    }")

G = ["      pt[2].vx = pt[0].vx = (short)(sx + -2);",
     "      pt[1].vy = pt[0].vy = (short)(sy + -2);",
     "      pt[3].vx = pt[1].vx = (short)(sx + 3);",
     "      pt[3].vy = pt[2].vy = (short)(sy + 3);"]
OLD_G = "\r\n".join(G)

PERMS = list(itertools.permutations(range(4)))


def apply(src):
    v = int(os.environ['V'])
    assert src.count(OLD_SX) == 1 and src.count(OLD_G) == 1
    s = src.replace(OLD_SX, BASE)
    p = PERMS[v]
    return s.replace(OLD_G, "\r\n".join(G[k] for k in p))
