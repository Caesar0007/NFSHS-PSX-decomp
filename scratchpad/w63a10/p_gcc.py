import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/audioclc.cpp'
FN = 'AudioClc_GetClosestCars__Fiii'

A = b"""        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;"""

V = {
 'G1_yxz': [(A, b"""        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;""")],
 'G2_xzy': [(A, b"""        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;""")],
 'G3_intview_local': [(A, b"""        const int *vp = (const int *)&AudioClc_gRenderView.translation;
        x = (*car)->N.position.x - vp[0];
        y = (*car)->N.position.y - vp[1];
        z = (*car)->N.position.z - vp[2];""")],
 'G4_intview_laundered': [(A, b"""        const int *vp = (const int *)&AudioClc_gRenderView.translation;
        __asm__("" : "=r"(vp) : "0"(vp));
        x = (*car)->N.position.x - vp[0];
        y = (*car)->N.position.y - vp[1];
        z = (*car)->N.position.z - vp[2];""")],
 'G5_x_last_via_offset': [(A, b"""        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;
        x = (*car)->N.position.x - *(int *)((char *)&AudioClc_gRenderView.translation.y - 4);""")],
 'G6_x_via_yminus1': [(A, b"""        x = (*car)->N.position.x - (&AudioClc_gRenderView.translation.y)[-1];
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;""")],
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)
