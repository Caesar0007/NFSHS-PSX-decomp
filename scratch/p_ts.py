import os

FENCE = '  __asm__ volatile("" : : "r"(i));'
DEPTH = "  spec->depthcuestate = 1;\r\n"
MIRROR = "  (spec->horizonspec).mirror = 1;\r\n"
HORIZ = "  spec->horizonstate = 1;\r\n"

V = {
 'v1': lambda s: s.replace(FENCE, '  __asm__ volatile("" : : "r"(i), "r"(1));'),
 'v2': lambda s: s.replace(FENCE, '  __asm__ volatile("" : : "r"(1));\r\n' + FENCE),
 'v3': lambda s: s.replace(FENCE, FENCE + '\r\n  __asm__ volatile("" : : "r"(1));'),
 'v4': lambda s: s.replace(DEPTH, '').replace(FENCE, DEPTH + FENCE),
 'v5': lambda s: s.replace(MIRROR, '').replace(FENCE, MIRROR + FENCE),
 'v6': lambda s: s.replace(HORIZ, '').replace(FENCE, HORIZ + FENCE),
 # one named const carrier fenced
 'v7': lambda s: s.replace(FENCE, '  { int one = 1;\r\n  __asm__ volatile("" : : "r"(i), "r"(one)); }'),
}


def apply(src):
    assert src.count(FENCE) == 1
    return V[os.environ['V']](src)
