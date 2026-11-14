/* frontend/common/screendisplay_carblock_iters.h -- the car/track list iterators of screendisplay_carblock.h.  Emitted
 * in place by the carblock (default), or -- under NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS -- through the owner hooks
 * NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER / NFS4_FE_TRACK_HOOK_AFTER_MANAGER (retail: right after tCarManager / tTrackManager).
 * Chainable: NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN / NFS4_SCREENDISPLAY_ITERS_TRACK_CHAIN name a further owner header. */
#if (defined(NFS4_FE_CORE_CARS_IN_HOOK) || defined(NFS4_SCREENDISPLAY_ITERS_CARS)) && !defined(NFS4_FRONTEND_COMMON_SCREENDISPLAY_ITERS_CARS_H)
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_ITERS_CARS_H
struct tListIteratorCar : public tListIterator {
    int fCarListFilter;
    tCarManager *fCarManager;
    tCarNameLength fNameLength;
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
    tListIteratorCar(char *, tCarManager *);
    ~tListIteratorCar();
    char Value(tPlayer);
    void AdjustPosition(tPlayer, short);
    bool ValidCar(tPlayer, char);
#ifdef NFS4_FRONTEND_COMMON_FECARS_ITERS_H   /* FECars.obj (key object) emits a standalone copy; the retail link removed it */
    inline void SetFilter(int filter) LINK_STRIPPED;
#else   /* retail in-class body (called from matched code) */
    inline void SetFilter(int filter) { fCarListFilter = filter; }
#endif
};
#ifdef NFS4_FRONTEND_COMMON_FECARS_ITERS_H
inline void tListIteratorCar::SetFilter(int filter) { fCarListFilter = filter; }
#endif

struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;
    tListIteratorCarColor(char *, char *, char *, int, tCarManager *);
    ~tListIteratorCarColor();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};
#ifdef NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN
#include NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN
#endif
#endif
#if (defined(NFS4_FE_TRACK_IN_HOOK) || defined(NFS4_SCREENDISPLAY_ITERS_TRACK)) && !defined(NFS4_FRONTEND_COMMON_SCREENDISPLAY_ITERS_TRACK_H)
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_ITERS_TRACK_H
struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;
    tListIteratorTrack(char *, char *, tTrackManager *);
    ~tListIteratorTrack();
    short TextValue(tPlayer); void Increment(tPlayer); void Decrement(tPlayer);
    bool ValidTrack(char);
};
#endif
