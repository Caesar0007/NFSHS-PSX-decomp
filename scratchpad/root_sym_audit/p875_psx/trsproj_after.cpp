#include "C:/Temp/nfs4-decomp/recon/game/psx/trsproj.h"
void (*p875_probe_0)(int val) = &TrsProj_SetTransPrecision;
void (*p875_probe_1)(void) = &TrsProj_ResetTransPrecision;
void (*p875_probe_2)(int cx,int cy,int w,int h) = &TrsProj_SetProjection;
void (*p875_probe_3)(int cx,int cy,int w,int h) = &TrsProj_SetMenuProjection;
void (*p875_probe_4)(DRender_tView * Vi) = &TrsProj_SetViewTrsProjEnviro;
void (*p875_probe_5)(matrixtdef * m,coorddef * t) = &TrsProj_SetPsxMatrix;
void (*p875_probe_6)(coorddef * t) = &TrsProj_SetPsxTrans;
void (*p875_probe_7)(void) = &TrsProj_SetPsxTransZero;
void (*p875_probe_8)(coorddef * s,coorddef * d) = &TrsProj_TransPt;
void (*p875_probe_9)(RelCoord16 * s,coorddef * d,int n) = &TrsProj_TransPtN16;
void (*p875_probe_10)(matrixtdef * m,coorddef * t,int n,coorddef * s,Draw_tVertex * v) = &TrsProj_TransformProjectVertex;
