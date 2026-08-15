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
CALL = b"""            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       reg_a1,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""

def v(body, call=CALL):
    return [(A + CALL, b"          else {\n" + body + call)]

V = {
 'X1_swap_reads': v(b"""            reg_a1 = (pThis->_base_Speaker).fLocation;
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
"""),
 'X2_revintro_first': v(b"""            REVINTRO = pThis;
            iVar4 = (pThis->_base_Speaker).fCar;
            reg_a1 = (pThis->_base_Speaker).fLocation;
"""),
 'X3_block_local_loc': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            int perpLoc = (pThis->_base_Speaker).fLocation;
""", CALL.replace(b"reg_a1,", b"perpLoc,")),
 'X4_inline_loc': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
""", CALL.replace(b"reg_a1,", b"(pThis->_base_Speaker).fLocation,")),
 'X5_inline_car': v(b"""            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
""", CALL.replace(b"iVar4,", b"(pThis->_base_Speaker).fCar,")),
 'X6_loc_last_after_revintro': v(b"""            iVar4 = (pThis->_base_Speaker).fCar;
            reg_a1 = (pThis->_base_Speaker).fLocation;
            REVINTRO = pThis;
"""),
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
