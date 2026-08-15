import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/audioclc.cpp'
FN = 'AudioClc_GetClosestCars__Fiii'

PRE = b"""  i = 0;
  car = Cars_gList;
  while (i < Cars_gNumCars) {"""
XYZ = b"""        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;"""
VP3 = b"""        x = (*car)->N.position.x - vp[0];
        y = (*car)->N.position.y - vp[1];
        z = (*car)->N.position.z - vp[2];"""
VP_YZ = b"""        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        y = (*car)->N.position.y - vp[1];
        z = (*car)->N.position.z - vp[2];"""

DECL = b"  const int *vp = (const int *)&AudioClc_gRenderView.translation;\n"
LAUND = b'  __asm__("" : "=r"(vp) : "0"(vp));\n'

V = {
 'I1_vp_preloop_plain': [(PRE, DECL + PRE), (XYZ, VP3)],
 'I2_vp_preloop_laundered': [(PRE, DECL + LAUND + PRE), (XYZ, VP3)],
 'I3_vp_preloop_laundered_yz': [(PRE, DECL + LAUND + PRE), (XYZ, VP_YZ)],
 'I4_vp_preloop_plain_yz': [(PRE, DECL + PRE), (XYZ, VP_YZ)],
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
