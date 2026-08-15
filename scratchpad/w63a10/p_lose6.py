import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'Lose__Q26Speech13MobileSpeaker'

A = b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       reg_a1,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""

def v(txt):
    return [(A, txt)]

V = {
 'Q1_no_revintro': v(b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            reg_a1 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       reg_a1,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""),
 'Q2_revintro_as_arg4': v(b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)REVINTRO,
                       reg_a1,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""),
 'Q3_iVar3_for_loc': v(b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            iVar3 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       iVar3,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""),
 'Q4_uVar8_for_loc': v(b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            uVar8 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       uVar8,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""),
 'Q5_car_via_reg_a1': v(b"""          else {
            reg_a1 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            iVar4 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,(SPCHNFSType_COLOUR *)pCVar5,reg_a1,(SPCHNFSType_POSITION *)pThis,
                       iVar4,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);"""),
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
