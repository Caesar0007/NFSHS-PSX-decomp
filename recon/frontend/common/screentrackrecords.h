/* frontend/common/screentrackrecords.h -- retail SCREENTRACKRECORDS.H: the one definition of tScreenTrackRecords.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FRONTEND_COMMON_SCREENTRACKRECORDS_H_
#define _FRONTEND_COMMON_SCREENTRACKRECORDS_H_

struct tScreenTrackRecords : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    tRecordBuffer *TrackRecords;
    int flare_intensity, flareextra;
    bool fReadNewData;
    tScreenTrackRecords();
    void DrawOneRecord(int, bool, int);
    void DrawRecords(short);
};

#endif
