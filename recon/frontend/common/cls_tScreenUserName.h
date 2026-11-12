/* frontend/common/cls_tScreenUserName.h -- class tScreenUserName, one definition for every includer (header-truth 4v; the owner's text from screenusername_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENUSERNAME_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENUSERNAME_H
struct tScreenUserName : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground(); void Initialize();
    tOptionsMenu *callingMenu; short fTextFade; bool fInTransition; char fRowList[10][9];
    void DrawVerticalLine(short, short, short); void DrawHorizontalLine(short, short, short);
#ifndef NFS4_KEY_OBJECT_SCREENUSERNAME
    inline void SetCallingMenu(tOptionsMenu *m) { callingMenu = m; }   /* called from feapp.cpp / femenudefs.cpp (retail inline pair) */
#endif
#line 97 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.H"
};
#line 16 "recon/frontend/common/cls_tScreenUserName.h"
#endif
