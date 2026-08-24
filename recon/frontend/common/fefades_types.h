/* Owner-specific type surface for fefades.obj, reconstructed from the retail
 * SYM graph.  Keeping this TU off the monolithic nfs4_types.h prevents hundreds
 * of unrelated completed tags and typedefs from leaking into its debug graph. */
#ifndef NFS4_FRONTEND_COMMON_FEFADES_TYPES_H
#define NFS4_FRONTEND_COMMON_FEFADES_TYPES_H

#include "../../game/common/draw_leaf_types.h"

/* The retail owner uses byte only as a source spelling and emits no typedef
 * record for it, so retain the spelling as a macro in this visibility surface. */
#define byte unsigned char

struct tTexture_ShapeInfo {
    shapetbl *shpptr;
    long clutID;
    char depth;
    u_long type : 8;
    long next : 24;
    signed short width, height;
    short centerx, centery, shapex, shapey;
    u_short tpage, clut;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

enum tMenuTextType {
    textType_Title = 0,
    textType_FlybyHelp = 1,
    textType_BorderInfo = 2,
    textType_FramedInfo = 3,
    textType_ScreenInfo = 4,
    textType_ScreenInfoHeader = 5,
    textType_Options = 6,
    textType_FramedMoney = 7,
    textType_PopUpText = 8,
    textType_PopUpTitle = 9,
    textType_PostGame = 10,
    textType_TrackRecords = 11,
    textType_UserNameMenu = 12,
    textType_VideoWall = 13,
    textType_NumTypes = 14,
    textType_Default = 14
};

#endif
