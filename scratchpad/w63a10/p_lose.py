import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'Lose__Q26Speech13MobileSpeaker'

# anchors (LF form; fast.run translates to the file's endings)
A_UVAR = b"""        uVar6 = (pThis->_base_Speaker).fBlockade.flags;
        if (uVar6 == 1) {"""
A_ELSE = b"""        else {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(pSVar7);
          }
          else {"""

# 1) a chain-local voice carrier used by all four blockade-chain calls
V1_pairs = [
 (A_UVAR, b"""        SPCHNFSType_VOICE *voiceArg = pSVar7;
        uVar6 = (pThis->_base_Speaker).fBlockade.flags;
        if (uVar6 == 1) {"""),
 (b"SPCHNFS_C_D_SPBLT_FAILED(pSVar7,", b"SPCHNFS_C_D_SPBLT_FAILED(voiceArg,"),
 (b"SPCHNFS_C_D_RDBLK_FAILED(pSVar7,", b"SPCHNFS_C_D_RDBLK_FAILED(voiceArg,"),
 (b"SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(pSVar7);", b"SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(voiceArg);"),
 (b"SPCHNFS_C_D_PERP_LOST(pSVar7,", b"SPCHNFS_C_D_PERP_LOST(voiceArg,"),
]

# 2) same but only for the inner (IDLE / PERP_LOST) pair
V2_pairs = [
 (A_ELSE, b"""        else {
          SPCHNFSType_VOICE *voiceArg = pSVar7;
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(voiceArg);
          }
          else {"""),
 (b"SPCHNFS_C_D_PERP_LOST(pSVar7,", b"SPCHNFS_C_D_PERP_LOST(voiceArg,"),
]

# 3) laundered chain-local carrier
V3_pairs = list(V1_pairs)
V3_pairs[0] = (A_UVAR, b"""        SPCHNFSType_VOICE *voiceArg = pSVar7;
        __asm__("" : "=r"(voiceArg) : "0"(voiceArg));
        uVar6 = (pThis->_base_Speaker).fBlockade.flags;
        if (uVar6 == 1) {""")

# 4) inner-pair carrier, laundered
V4_pairs = list(V2_pairs)
V4_pairs[0] = (A_ELSE, b"""        else {
          SPCHNFSType_VOICE *voiceArg = pSVar7;
          __asm__("" : "=r"(voiceArg) : "0"(voiceArg));
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(voiceArg);
          }
          else {""")

V = {'V1_chain_carrier': V1_pairs,
     'V2_inner_carrier': V2_pairs,
     'V3_chain_laundered': V3_pairs,
     'V4_inner_laundered': V4_pairs}

fast.run(SRC, FN, FN, V, gval='4', dump=False)
