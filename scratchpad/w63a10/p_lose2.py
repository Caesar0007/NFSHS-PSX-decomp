import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'Lose__Q26Speech13MobileSpeaker'

A_ELSE = b"""        else {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(pSVar7);
          }
          else {"""

def inner(decl, idlearg):
    return [(A_ELSE, b"""        else {
""" + decl + b"""          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(""" + idlearg + b""");
          }
          else {"""),
            (b"SPCHNFS_C_D_PERP_LOST(pSVar7,", b"SPCHNFS_C_D_PERP_LOST(voiceArg,")]

LAUNDER = b'          __asm__("" : "=r"(voiceArg) : "0"(voiceArg));\n'
DECL = b'          SPCHNFSType_VOICE *voiceArg = pSVar7;\n'

V = {
 'W4_inner_laundered_ref': inner(DECL + LAUNDER, b'voiceArg'),
 'W5_inner_laundered_idle_pSVar7': inner(DECL + LAUNDER, b'pSVar7'),
 'W6_launder_after_colour': [(A_ELSE, b"""        else {
          SPCHNFSType_VOICE *voiceArg = pSVar7;
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          __asm__("" : "=r"(voiceArg) : "0"(voiceArg));
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(voiceArg);
          }
          else {"""),
   (b"SPCHNFS_C_D_PERP_LOST(pSVar7,", b"SPCHNFS_C_D_PERP_LOST(voiceArg,")],
 'W7_perponly_carrier_laundered': [(b"""          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;""", b"""          else {
            SPCHNFSType_VOICE *voiceArg = pSVar7;
            __asm__("" : "=r"(voiceArg) : "0"(voiceArg));
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;"""),
   (b"SPCHNFS_C_D_PERP_LOST(pSVar7,", b"SPCHNFS_C_D_PERP_LOST(voiceArg,")],
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
