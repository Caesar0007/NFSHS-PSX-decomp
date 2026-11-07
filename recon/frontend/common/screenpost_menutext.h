/* screenpost_menutext.h -- ScreenPost.obj's tMenuTextState / tMenuTextType (moved verbatim from screentournselect_types.h).
 * Retail order: after the standings classes + kernpair + tDrawShapeExtended (screentournselect_types.h 2nd pass). */
#ifndef NFS4_FRONTEND_COMMON_SCREENPOST_MENUTEXT_H
#define NFS4_FRONTEND_COMMON_SCREENPOST_MENUTEXT_H
typedef enum tMenuTextType {
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
} tMenuTextType;
typedef enum tMenuTextState {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
} tMenuTextState;
#endif
