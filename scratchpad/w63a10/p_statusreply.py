import sys, os
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'StatusReply__Q26Speech15DispatchSpeaker'

BASE = b"""    int wing = bank->fMobile[(*(*Blocker->_vf)[0x11].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)];
    int location = (pThis->_base_Speaker).fLocation;"""

V = {
 'A_decl_split': (BASE, b"""    int wing;
    wing = bank->fMobile[(*(*Blocker->_vf)[0x11].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)];
    int location = (pThis->_base_Speaker).fLocation;"""),
 'B_named_index': (BASE, b"""    int wingIdx = (*(*Blocker->_vf)[0x11].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta);
    int wing = bank->fMobile[wingIdx];
    int location = (pThis->_base_Speaker).fLocation;"""),
 'C_decl_split_named_index': (BASE, b"""    int wing;
    int wingIdx = (*(*Blocker->_vf)[0x11].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta);
    wing = bank->fMobile[wingIdx];
    int location = (pThis->_base_Speaker).fLocation;"""),
}

fast.run(SRC, FN, FN, V, gval='4', dump=False)
