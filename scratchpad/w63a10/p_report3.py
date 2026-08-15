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
      iVar3 = iVar3 + iVar4 * 4;"""

HEAD = b"""      iVar3 = (*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)(((int)pThis->fPerp + -0x5c) + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      pSVar6 = (pThis->_base_Speaker).fSub;
      __asm__("" : "=r"(pSVar6) : "0"(pSVar6));
"""
VF = b"      __vtbl_ptr_type (*subVf)[31] = pSVar6->_vf;\n"
TAIL_VF = b"""      iVar4 = (*subVf)[0x11].pfn((int)&(pSVar6->fPosition).flags + (int)(*subVf)[0x11].delta);
      iVar3 = iVar3 + iVar4 * 4;"""
TAIL_PLAIN = b"""      iVar4 = (*(*pSVar6->_vf)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x11].delta)
      ;
      iVar3 = iVar3 + iVar4 * 4;"""

def fence(op, n=1):
    return (b'      __asm__("" : : "r"(%s));\n' % op) * n

V = {}
for op in (b'iVar3', b'pSVar6', b'pThis'):
    V['F_vf_after_%s' % op.decode()] = [(A, HEAD + VF + fence(op) + TAIL_VF)]
    V['F_novf_%s' % op.decode()] = [(A, HEAD + fence(op) + TAIL_PLAIN)]
V['F_vf_iVar3_x2'] = [(A, HEAD + VF + fence(b'iVar3', 2) + TAIL_VF)]
V['F_vf_iVar3_x3'] = [(A, HEAD + VF + fence(b'iVar3', 3) + TAIL_VF)]
V['F_vf_pair'] = [(A, HEAD + VF + b'      __asm__("" : : "r"(iVar3), "r"(pSVar6));\n' + TAIL_VF)]
fast.run(SRC, FN, FN, V, gval='4', dump=False)
