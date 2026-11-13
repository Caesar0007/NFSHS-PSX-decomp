/* shared/tpdef_keys.h -- typedef-form keys.  Retail spelled these classes C-style (`typedef struct X {...} X;`), which
 * records TPDEF X twice; owners whose retail object records it once keep the plain form.  NFS4_TD_<X> / NFS4_TDN_<X>
 * wrap the definitions (line-neutral).  Owner identity = first-header guards / NFS4_TU_* markers. */
#ifndef NFS4_SHARED_TPDEF_KEYS_H
#define NFS4_SHARED_TPDEF_KEYS_H
#if !defined(NFS4_FE_NO_MENUITEM_INLINES)   /* (ScreenAudio/ScreenTrackInfo: their own class copies in screentrackinfo_types.h carry the same blocks, FESCR2) FESCR: retail FEMENUOPTIONS.H/FEMENUEXTENDED.H menu-item family = full declarations + in-class bodies in every includer; FeMenuOptions.obj (their key TU) opts out */
#define NFS4_FE_MENUITEM_INLINES
#endif
#if 1   /* plain everywhere: the inferred tTournamentManager bodies apply in every frontend TU now (trophy TUs incl., INV-B I5) */   /* plain: the tTournamentManager inferred bodies (CurrentTierInfo/CompetitorAt) supply the 2nd record; trophy owners (bodies excluded) keep the typedef pair */
#define NFS4_TD_tCompetitor
#define NFS4_TDN_tCompetitor
#else
#define NFS4_TD_tCompetitor typedef
#define NFS4_TDN_tCompetitor tCompetitor
#endif
#if 1   /* plain everywhere: the inferred tTournamentManager bodies apply in every frontend TU now (trophy TUs incl., INV-B I5) */   /* plain: the tTournamentManager inferred bodies (CurrentTierInfo/CompetitorAt) supply the 2nd record; trophy owners (bodies excluded) keep the typedef pair */
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
#if defined(NFS4_TU_FEAPP) || defined(NFS4_TU_FEMENUDEFS) || defined(NFS4_TU_FEMENUEXTENDED) || defined(NFS4_TU_FRONT) || defined(_FE_SCREENS_SCREENCARSELECT_H_) || defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H) || defined(NFS4_FE_MENUITEM_INLINES)   /* FE_MENUITEM_INLINES: the in-class Draw(bool) body supplies the 2nd record (FESCR) */
#define NFS4_TD_tMenuItemGoToMenuNFS4Button
#define NFS4_TDN_tMenuItemGoToMenuNFS4Button
#else
#define NFS4_TD_tMenuItemGoToMenuNFS4Button typedef
#define NFS4_TDN_tMenuItemGoToMenuNFS4Button tMenuItemGoToMenuNFS4Button
#endif
#if defined(NFS4_TU_FEMENUDEFS) || defined(_FE_SCREENS_FEMENUOPTIONS_H_) || defined(NFS4_TU_FRONT) || defined(NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H) || defined(NFS4_FE_MENUITEM_INLINES)   /* FE_MENUITEM_INLINES: a derived ctor body supplies the 2nd record (FESCR) */
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
#elif defined(NFS4_TSCREENCONGRATS_OWNER)   /* ScreenCongrats: inferred tCarManager bodies excluded -> keeps the typedef pair */
#define NFS4_TD_tOwnedCarInfo typedef
#define NFS4_TDN_tOwnedCarInfo tOwnedCarInfo
#else   /* plain everywhere since the inferred tCarManager bodies (CarCount/CarIndex) supply the 2nd record */
#define NFS4_TD_tOwnedCarInfo
#define NFS4_TDN_tOwnedCarInfo
#endif
#if defined(NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H)   /* PSXFront/ScreenPost: no tScreen in-class bodies -> typedef form gives retail's 2 TPDEFs */
#define NFS4_TD_tShapeInformation typedef
#define NFS4_TDN_tShapeInformation tShapeInformation
#else
#define NFS4_TD_tShapeInformation   /* plain everywhere: retail's 2nd TPDEF comes from tScreen's in-class inline bodies (fescreen.h, FRONTORD set 27b) */
#define NFS4_TDN_tShapeInformation
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
#if defined(NFS4_TU_FEAPP) || defined(_FE_SCREENS_SCREENCONGRATS_H_) || (defined(_FE_SCREENS_FEMENUOPTIONS_H_) && !defined(_FE_SCREENS_SCREENCONTROLLER_H_)) || defined(NFS4_FRONTEND_COMMON_FEDIALOG_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H)   /* tMenu definition after the menu items only (their tMenu forward copy is already retail-placed) */
#ifndef NFS4_FE_CORE_TMENU_AFTER_ITEMS
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton */
#endif
#endif
#if defined(NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H)   /* tScreen: plain struct + 2 in-class inline bodies = retail 3 TPDEFs (FEScreen too, FESCR); PSXFront/ScreenPost keep the typedef form (FRONTORD set 27b/16) */
#define NFS4_TD_tScreen typedef
#define NFS4_TDN_tScreen tScreen
#else
#define NFS4_TD_tScreen
#define NFS4_TDN_tScreen
#endif
#ifdef NFS4_TU_FEMENU   /* FEMenu (tMenu/tMenuItem key TU): the retail inline-member sets (same spellings as NFS4_FE_CORE_TMENU_ALL_INLINES in fe_core_types.h/fe_core_tmenu.h), declared LINK_STRIPPED and defined right after each class (incl. the existing IsEnabled/NewMenu, moved from femenu_externs.h) -> TPDEF runs at the classes as retail; standalone copies in .text.strip.  tMenuItem: 10 of the 13 (retail class run 16 = typedef pair + IsEnabled/NewMenu + the in-class virtual TransitionOff/On bodies at FEMENU.H:274/275 (fe_core_types.h, NFS4_TU_FEMENU) + 10) (FESCR2) */
#define NFS4_FEMENU_TMENU_STRIPPED_DECLS inline short CurrentItem() LINK_STRIPPED; inline void SetChildMenu(tMenu *child) LINK_STRIPPED; inline void SetVerticalHelp(short help) LINK_STRIPPED; inline bool HasFlag(unsigned int flag) LINK_STRIPPED; inline tMenuItem *Item(int n) LINK_STRIPPED; inline bool CanContinue() LINK_STRIPPED; inline bool HasOptionsMenu() LINK_STRIPPED; inline unsigned int ExitsWithBack() LINK_STRIPPED; inline tScreen *GetScreen() LINK_STRIPPED; inline unsigned int GetMusic() LINK_STRIPPED; inline tMenuItem *CurrentMenuItem() LINK_STRIPPED;
#define NFS4_FEMENU_TMENU_STRIPPED_DEFS inline short tMenu::CurrentItem() { return fCurrentItem; } inline void tMenu::SetChildMenu(tMenu *child) { fChildMenu = child; } inline void tMenu::SetVerticalHelp(short help) { VertHelp = help; } inline bool tMenu::HasFlag(unsigned int flag) { return (fFlags & flag) != 0; } inline tMenuItem *tMenu::Item(int n) { return fItemList[n]; } inline bool tMenu::CanContinue() { return fNextMenu != (tMenu *)0x0 || (fFlags & 0x400) != 0 || fOnButtonPress != 0x0; } inline bool tMenu::HasOptionsMenu() { return fOptionsMenu != (tMenu *)0x0; } inline unsigned int tMenu::ExitsWithBack() { return fFlags & 0x100; } inline tScreen *tMenu::GetScreen() { return fScreen; } inline unsigned int tMenu::GetMusic() { return fFlags & 0xf000; } inline tMenuItem *tMenu::CurrentMenuItem() { return fItemList[fCurrentItem]; }
#else
#define NFS4_FEMENU_TMENU_STRIPPED_DECLS
#define NFS4_FEMENU_TMENU_STRIPPED_DEFS
#endif
#ifdef NFS4_TU_FEMENUEXTENDED   /* FEMenuExtended: retail full tMenu/tMenuItem inline-member sets (fe_core_types.h/fe_core_tmenu.h); its own headers carry #line anchors, so the key lives here (FESCR2) */
#define NFS4_FE_CORE_TMENU_ALL_INLINES
#endif
#endif
