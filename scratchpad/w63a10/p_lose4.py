import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'Lose__Q26Speech13MobileSpeaker'

A = b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
"""
F = b'            __asm__("" : : "i"(0));\n'
RO = b'            __asm__("" : : "r"(iVar4));\n'

def v(body):
    return [(A, b"          else {\n" + body)]

V = {
 'Y1_barrier_between_reads': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
""" + F + b"""            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
"""),
 'Y2_barrier_after_revintro': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
""" + F + b"""            reg_a1 = (pThis->_base_Speaker).fLocation;
"""),
 'Y3_barrier_a3_first': v(b"""            REVINTRO = pThis;
            iVar4 = (pThis->_base_Speaker).fCar;
""" + F + b"""            reg_a1 = (pThis->_base_Speaker).fLocation;
"""),
 'Y4_ro_fence_on_car': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
""" + RO + b"""            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
"""),
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
