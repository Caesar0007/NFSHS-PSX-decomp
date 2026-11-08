/* shared/tpdef_keys.h -- typedef-form keys.  Retail spelled these classes C-style (`typedef struct X {...} X;`), which
 * records TPDEF X twice; owners whose retail object records it once keep the plain form.  NFS4_TD_<X> / NFS4_TDN_<X>
 * wrap the definitions (line-neutral).  Owner identity = first-header guards / NFS4_TU_* markers. */
#ifndef NFS4_SHARED_TPDEF_KEYS_H
#define NFS4_SHARED_TPDEF_KEYS_H
#if defined(NFS4_TU_FETOURN)
#define NFS4_TD_tCompetitor
#define NFS4_TDN_tCompetitor
#else
#define NFS4_TD_tCompetitor typedef
#define NFS4_TDN_tCompetitor tCompetitor
#endif
#if defined(NFS4_TU_FETOURN)
#define NFS4_TD_tTierInfo
#define NFS4_TDN_tTierInfo
#else
#define NFS4_TD_tTierInfo typedef
#define NFS4_TDN_tTierInfo tTierInfo
#endif
#if defined(NFS4_TU_FECREDITS) || defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H) || defined(NFS4_GAME_COMMON_NFS3_TYPES_H)
#define NFS4_TD_tCredit
#define NFS4_TDN_tCredit
#else
#define NFS4_TD_tCredit typedef
#define NFS4_TDN_tCredit tCredit
#endif
#if defined(NFS4_TU_FEMENUEXTENDED) || defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H)
#define NFS4_TD_tMenuBlank
#define NFS4_TDN_tMenuBlank
#else
#define NFS4_TD_tMenuBlank typedef
#define NFS4_TDN_tMenuBlank tMenuBlank
#endif
#if defined(NFS4_TU_FEAPP) || defined(NFS4_TU_FEMENUDEFS) || defined(NFS4_TU_FEMENUEXTENDED) || defined(NFS4_TU_FRONT) || defined(_FE_SCREENS_SCREENCARSELECT_H_) || defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H)
#define NFS4_TD_tMenuItemGoToMenuNFS4Button
#define NFS4_TDN_tMenuItemGoToMenuNFS4Button
#else
#define NFS4_TD_tMenuItemGoToMenuNFS4Button typedef
#define NFS4_TDN_tMenuItemGoToMenuNFS4Button tMenuItemGoToMenuNFS4Button
#endif
#if defined(NFS4_TU_FEMENUDEFS) || defined(_FE_SCREENS_FEMENUOPTIONS_H_) || defined(NFS4_TU_FRONT) || defined(NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H)
#define NFS4_TD_tMenuItemLeftRightFade
#define NFS4_TDN_tMenuItemLeftRightFade
#else
#define NFS4_TD_tMenuItemLeftRightFade typedef
#define NFS4_TDN_tMenuItemLeftRightFade tMenuItemLeftRightFade
#endif
#define NFS4_TD_tMenuNFS4TwoPlayer typedef
#define NFS4_TDN_tMenuNFS4TwoPlayer tMenuNFS4TwoPlayer
#if defined(NFS4_TU_FEAPP) || defined(NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H)
#define NFS4_TD_tOptionsMenu
#define NFS4_TDN_tOptionsMenu
#else
#define NFS4_TD_tOptionsMenu typedef
#define NFS4_TDN_tOptionsMenu tOptionsMenu
#endif
#if defined(NFS4_TU_FECARS) || defined(NFS4_TU_FEMEMCARD) || defined(NFS4_TU_FEMENUDEFS) || defined(NFS4_TU_FETOURN) || defined(NFS4_TU_FRONT) || defined(_FE_SCREENS_SCREENCARSELECT_H_) || defined(NFS4_GAME_COMMON_NFS3_TYPES_H)
#define NFS4_TD_tOwnedCarInfo
#define NFS4_TDN_tOwnedCarInfo
#else
#define NFS4_TD_tOwnedCarInfo typedef
#define NFS4_TDN_tOwnedCarInfo tOwnedCarInfo
#endif
#if (defined(NFS4_TU_FEAPP) || defined(NFS4_TU_FEMENU) || defined(NFS4_TU_FEMENUDEFS) || defined(NFS4_TU_FEMENUEXTENDED) || defined(_FE_SCREENS_FEMENUOPTIONS_H_) || defined(NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H) || defined(NFS4_TU_FRONT) || defined(_FE_SCREENS_SCREENCARSELECT_H_) || defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H)) && !(defined(NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT) && defined(NFS4_TU_FEMENUDEFS))   /* SCREEN_AFTER_TOURNAMENT in FEMenuDefs: typedef form -- the late definition gets no field-walk re-emission, retail has 2 TPDEFs */
#define NFS4_TD_tShapeInformation
#define NFS4_TDN_tShapeInformation
#else
#define NFS4_TD_tShapeInformation typedef
#define NFS4_TDN_tShapeInformation tShapeInformation
#endif
#if defined(NFS4_TU_FEAPP) || defined(NFS4_TU_FEMENUDEFS) || defined(NFS4_TU_FRONT)
#define NFS4_TD_tUserNameMenuItem
#define NFS4_TDN_tUserNameMenuItem
#else
#define NFS4_TD_tUserNameMenuItem typedef
#define NFS4_TDN_tUserNameMenuItem tUserNameMenuItem
#endif
#if defined(NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTRACKRECORDS_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H) || defined(NFS4_TU_FRONT) || defined(NFS4_TU_FEMENUDEFS) || (defined(_FE_SCREENS_SCREENCONTROLLER_H_) && !defined(_FE_SCREENS_FEMENUOPTIONS_H_))   /* screen owners (their first header): tMenu forward/definition order (FRONTORD3) */
#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton (screendisplay_menuitems.h; ScreenAudio: screentrackinfo_types.h) */
#endif
#if defined(_FE_SCREENS_SCREENCONTROLLER_H_) && !defined(_FE_SCREENS_FEMENUOPTIONS_H_)   /* ScreenController: MATRIX core at fe_core, tTexture_ShapeInfo/kernpair only after the draw leaf */
#define NFS4_FE_CORE_FELINES_AT_LEAF
#define NFS4_FE_CORE_AT_LEAF_HDR "../../game/common/draw_leaf_types.h"
#endif
#endif
