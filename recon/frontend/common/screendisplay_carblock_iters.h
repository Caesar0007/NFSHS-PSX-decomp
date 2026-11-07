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
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    short TextValue(tPlayer);
    void Increment(tPlayer)
        __asm__("Increment__16tListIteratorCar7tPlayer");
    void Decrement(tPlayer)
        __asm__("Decrement__16tListIteratorCar7tPlayer");
#endif
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorCar(char *, tCarManager *);
    ~tListIteratorCar();
    char Value(tPlayer);
    void AdjustPosition(tPlayer, short);
    bool ValidCar(tPlayer, char);
    inline void SetFilter(int filter) { fCarListFilter = filter; }
#endif
};

struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorCarColor(char *, char *, char *, int, tCarManager *);
    ~tListIteratorCarColor();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
};
#ifdef NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN
#include NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN
#endif
#endif
#if (defined(NFS4_FE_TRACK_IN_HOOK) || defined(NFS4_SCREENDISPLAY_ITERS_TRACK)) && !defined(NFS4_FRONTEND_COMMON_SCREENDISPLAY_ITERS_TRACK_H)
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_ITERS_TRACK_H
struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorTrack(char *, char *, tTrackManager *);
    ~tListIteratorTrack();
#endif
    short TextValue(tPlayer); void Increment(tPlayer); void Decrement(tPlayer);
#ifdef NFS4_FEMENUDEFS_SURFACE
    bool ValidTrack(char);
#endif
};
#ifdef NFS4_SCREENDISPLAY_ITERS_TRACK_CHAIN
#include NFS4_SCREENDISPLAY_ITERS_TRACK_CHAIN
#endif
#endif
