import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'StatusReply__Q26Speech15DispatchSpeaker'

DECLS = b"""  Speaker *Blocker;
  bool invalid = false;
  int context;
  int from;
  SPCHNFSType_REVINTRO *reverse;
"""
LINES = [b"  Speaker *Blocker;\n", b"  bool invalid = false;\n", b"  int context;\n",
         b"  int from;\n", b"  SPCHNFSType_REVINTRO *reverse;\n"]
USE = (b"    int wing = bank->fMobile[", b"    wing = bank->fMobile[")

V = {}
for i in range(len(LINES) + 1):
    new = b"".join(LINES[:i]) + b"  int wing;\n" + b"".join(LINES[i:])
    V['K%d_declpos%d' % (i, i)] = [(DECLS, new), USE]
fast.run(SRC, FN, FN, V, gval='4', dump=False)
