/* audioclc_types_d1 -- moved verbatim out of audioclc_types.h so that header holds only its include list. */
#ifndef NFS4_AUDIOCLC_TYPES_D1_H
#define NFS4_AUDIOCLC_TYPES_D1_H
typedef struct {
    Car_tObj *car;
    int distToCamera, dopplerShift, relVelocity, gameTicks, distSq;
    int frequency, channel, horn, hornOn, hornOff, hornCount, pursuit, yelled;
} AudioClc_tSource;

typedef struct {
    int cameraMode, gameTicks, warnings;
    coorddef lastview;
    AudioClc_tSource source;
} AudioClc_tPlayer;

struct AudioClc_tCLCache { Car_tObj *ptr; int dst; };
#endif
