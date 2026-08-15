import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/audioclc.cpp'
FN = 'AudioClc_GetClosestCars__Fiii'

A = b"""        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;"""

XOFF = b'*(int *)((char *)&AudioClc_gRenderView.translation.y - 4)'
XCAST = b'*(int *)((int)&AudioClc_gRenderView.translation.y - 4)'

V = {
 'H1_xfirst_offform': [(A, b"""        x = (*car)->N.position.x - """ + XOFF + b""";
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;""")],
 'H2_xfirst_intcast': [(A, b"""        x = (*car)->N.position.x - """ + XCAST + b""";
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;""")],
 'H3_xmid': [(A, b"""        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        x = (*car)->N.position.x - """ + XOFF + b""";
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;""")],
 'H4_allviaz': [(A, b"""        x = (*car)->N.position.x - *(int *)((char *)&AudioClc_gRenderView.translation.z - 8);
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;""")],
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
