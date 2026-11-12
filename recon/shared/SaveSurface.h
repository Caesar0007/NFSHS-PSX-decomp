/* SaveSurface -- TRACK.H, one definition for every includer (header-truth 4w). Members are defined in track.cpp. */
#ifndef NFS4_SHARED_SAVESURFACE_H
#define NFS4_SHARED_SAVESURFACE_H
struct SaveSurface {
    short fCount, fMaxCount;
    tSaveSurface *fStack;
    SaveSurface(int numEntries);
    ~SaveSurface();
    void Save(Trk_NewSimQuad *simQuad);
    void RestoreAll();
};
#endif
