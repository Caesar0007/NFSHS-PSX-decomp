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
LC = b'            __asm__("" : "=r"(iVar4) : "0"(iVar4));\n'
LL = b'            __asm__("" : "=r"(reg_a1) : "0"(reg_a1));\n'

def v(body):
    return [(A, b"          else {\n" + body)]

V = {
 'Z1_launder_car': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
""" + LC + b"""            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
"""),
 'Z2_launder_loc': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
""" + LL),
 'Z3_launder_both': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
""" + LC + b"""            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
""" + LL),
 'Z4_launder_loc_then_car': v(b"""            reg_a1 = (pThis->_base_Speaker).fLocation;
""" + LL + b"""            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
"""),
 'Z5_ro_fence_loc_late': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
            __asm__("" : : "r"(reg_a1));
"""),
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
