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

CALL0 = b"""      int bankRes = (*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)(((int)pThis->fPerp + -0x5c) + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      pSVar6 = (pThis->_base_Speaker).fSub;
      __asm__("" : "=r"(pSVar6) : "0"(pSVar6));
"""
LAUND = b'      __asm__("" : "=r"(iVar3) : "0"(iVar3));\n'
CALL1_VF = b"""      iVar4 = (*subVf)[0x11].pfn((int)&(pSVar6->fPosition).flags + (int)(*subVf)[0x11].delta);
      iVar3 = iVar3 + iVar4 * 4;"""
CALL1_PLAIN = b"""      iVar4 = (*(*pSVar6->_vf)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x11].delta)
      ;
      iVar3 = iVar3 + iVar4 * 4;"""
VFDECL = b"      __vtbl_ptr_type (*subVf)[31] = pSVar6->_vf;\n"

V = {
 'P1_vf_local_split_laundered': [(A, CALL0 + VFDECL + b"      iVar3 = bankRes;\n" + LAUND + CALL1_VF)],
 'P2_vf_local_split_plain':     [(A, CALL0 + VFDECL + b"      iVar3 = bankRes;\n" + CALL1_VF)],
 'P3_split_laundered_novf':     [(A, CALL0 + b"      iVar3 = bankRes;\n" + LAUND + CALL1_PLAIN)],
 'P4_split_plain_novf':         [(A, CALL0 + b"      iVar3 = bankRes;\n" + CALL1_PLAIN)],
 'P5_vf_local_only':            [(A, CALL0.replace(b"int bankRes =", b"iVar3 =") + VFDECL + CALL1_VF)],
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
