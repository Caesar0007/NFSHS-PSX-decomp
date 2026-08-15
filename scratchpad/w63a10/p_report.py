import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/speech.cpp'
FN = 'Report__Q26Speech15DispatchSpeakerP8Car_tObj'

A = b"""      iVar3 = (*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)(((int)pThis->fPerp + -0x5c) + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      pSVar6 = (pThis->_base_Speaker).fSub;
      __asm__("" : "=r"(pSVar6) : "0"(pSVar6));
      iVar4 = (*(*pSVar6->_vf)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x11].delta)
      ;
      iVar3 = iVar3 + iVar4 * 4;
      sightedTo = *(int *)(iVar3 + 8);"""

def swap(first, second):
    t = A
    t = t.replace(b"      iVar3 = (*(*", b"      " + first + b" = (*(*")
    t = t.replace(b"      iVar4 = (*(*", b"      " + second + b" = (*(*")
    t = t.replace(b"      iVar3 = iVar3 + iVar4 * 4;",
                  b"      " + first + b" = " + first + b" + " + second + b" * 4;")
    t = t.replace(b"sightedTo = *(int *)(iVar3 + 8);",
                  b"sightedTo = *(int *)(" + first + b" + 8);")
    return [(A, t)]

V = {}
for name, f, s in [
    ('R1_a2_a3', b'reg_a2', b'reg_a3'),
    ('R2_a3_a2', b'reg_a3', b'reg_a2'),
    ('R3_iVar4_iVar3', b'iVar4', b'iVar3'),
    ('R4_a2_iVar4', b'reg_a2', b'iVar4'),
    ('R5_iVar3_a3', b'iVar3', b'reg_a3'),
    ('R6_a3_iVar4', b'reg_a3', b'iVar4'),
]:
    V[name] = swap(f, s)

fast.run(SRC, FN, FN, V, gval='4', dump=False)
