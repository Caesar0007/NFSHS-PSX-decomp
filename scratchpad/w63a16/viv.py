import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', '..', 'tools'))
import fast

SRC = "recon/frontend/common/feaudio.cpp"
FN = "FeAudio_InitViv__FPc"

EXPR = b"""    swappedResult = swappedType << 0x18 | (swappedType & 0xff00) << 8 |
                    (swappedType & 0xff0000) >> 8;
    swappedType >>= 0x18;
"""
IDF = b'    __asm__("" : "+r"(swappedType));\n'
RO  = b'    __asm__("" : : "r"(swappedResult));\n'

def fen(op, n):
    return b''.join(b'    __asm__("" : : "r"(' + op + b'));\n' for _ in range(n))

def expr_with(op, n):
    return (b"""    swappedResult = swappedType << 0x18 | (swappedType & 0xff00) << 8 |
                    (swappedType & 0xff0000) >> 8;
""" + fen(op, n) + b"""    swappedType >>= 0x18;
""")

V = {}
# BASIN A = current landed shape (identity fence), + foreign fences
for op in (b'lumpyName', b'vivHandle', b'fname'):
    for n in (1, 2, 3, 5):
        V["A_%s_x%d" % (op.decode(), n)] = [(EXPR, expr_with(op, n))]
# BASIN B = V4 read-only-fence-on-result basin (count-exact 109), + foreign fences
for op in (b'lumpyName', b'vivHandle'):
    for n in (0, 1, 2, 3, 5, 8):
        V["B_%s_x%d" % (op.decode(), n)] = [(EXPR, expr_with(op, n)), (IDF, RO)]

fast.run(SRC, FN, FN, V, dump=False)
