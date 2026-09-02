NL = chr(10)
S1 = ('        if (uVar8 != 8) {' + NL +
      '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)
S1X = ('        if ((uVar8 ^ 8) != 0) {' + NL +
       '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)
S2 = ('        if (uVar8 != 8) {' + NL +
      '          branchVoice = pSVar10;' + NL)
S2X = ('        if ((uVar8 ^ 8) != 0) {' + NL +
       '          branchVoice = pSVar10;' + NL)
C1 = ('          branchVoice = pSVar10;' + NL +
      '          __asm__("" : "+r"(branchVoice) : : "$2");' + NL +
      '          colourArg = (Car_tObj *)&(this->_base_Speaker).fColour;' + NL +
      '          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fCar;' + NL +
      '          pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fDistance;' + NL)
C1N = ('          branchVoice = pSVar10;' + NL +
       '          colourArg = (Car_tObj *)&(this->_base_Speaker).fColour;' + NL +
       '          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fCar;' + NL +
       '          pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fDistance;' + NL)

VARIANTS = [
    ("site1_xor_keepclobber", [(S1, S1X)]),
    ("site1_xor_noclobber", [(S1, S1X), (C1, C1N)]),
    ("site1_noclobber", [(C1, C1N)]),
    ("both_xor_keep", [(S1, S1X), (S2, S2X)]),
]
