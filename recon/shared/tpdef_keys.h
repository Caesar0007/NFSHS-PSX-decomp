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
/* fedialog.h INFERRED-body opt-outs: owners whose own dialog member set already gives retail's TPDEF count (FRONTORD3 set 15) */
#if defined(NFS4_TU_FEAPP) || defined(NFS4_TU_FEMEMCARD) || defined(NFS4_TU_FRONT) || defined(_FE_SCREENS_SCREENCARSELECT_H_)
#define NFS4_FEDIALOG_NO_INFERRED_BASE
#endif
#if defined(NFS4_TU_FEAPP) || defined(NFS4_TU_FECHEATS) || defined(NFS4_TU_FEMEMCARD) || defined(NFS4_TU_FEMENUDEFS) || defined(NFS4_TU_FRONT) || defined(_FE_SCREENS_SCREENCARSELECT_H_) || (defined(_FE_SCREENS_SCREENCONTROLLER_H_) && !defined(_FE_SCREENS_FEMENUOPTIONS_H_))
#define NFS4_FEDIALOG_NO_INFERRED_MS
#endif
#ifdef NFS4_TU_FEAPP
#define NFS4_FEDIALOG_NO_INFERRED_HELP
#endif
#ifdef NFS4_TU_FECHEATS
#define NFS4_FEDIALOG_NO_INFERRED_WT
#endif
#if defined(NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H)   /* tScreen: plain struct + 2 in-class inline bodies = retail 3 TPDEFs (FEScreen too, FESCR); PSXFront/ScreenPost keep the typedef form (FRONTORD set 27b/16) */
#define NFS4_TD_tScreen typedef
#define NFS4_TDN_tScreen tScreen
#else
#define NFS4_TD_tScreen
#define NFS4_TDN_tScreen
#endif
#ifdef NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H   /* FEScreen (key TU): 6 INFERRED inline tScreen members (fescreen.cpp bodies; LINK_STRIPPED copies) */
#define NFS4_FESCREEN_INFERRED_DECLS     inline int TransitionTicks() LINK_STRIPPED; inline bool IsTransitionOff() LINK_STRIPPED;     inline short ScreenFadeVal() LINK_STRIPPED; inline void SetScreenFadeVal(short fadeVal) LINK_STRIPPED;     inline int InternalScreenFadeVal() LINK_STRIPPED; inline void SetInternalScreenFadeVal(int fadeVal) LINK_STRIPPED;
#else
#define NFS4_FESCREEN_INFERRED_DECLS
#endif
#ifdef NFS4_TU_FEMENU   /* FEMenu (tMenu/tMenuItem key TU): the retail inline-member sets (same spellings as NFS4_FE_CORE_TMENU_ALL_INLINES in fe_core_types.h/fe_core_tmenu.h), declared LINK_STRIPPED and defined right after each class (incl. the existing IsEnabled/NewMenu, moved from femenu_externs.h) -> TPDEF runs at the classes as retail; standalone copies in .text.strip.  tMenuItem: 10 of the 13 (retail class run 16 = typedef pair + IsEnabled/NewMenu + the in-class virtual TransitionOff/On bodies at FEMENU.H:274/275 (fe_core_types.h, NFS4_TU_FEMENU) + 10) (FESCR2) */
#define NFS4_FEMENU_TMENUITEM_STRIPPED_DECLS inline unsigned int GetFlags() LINK_STRIPPED; inline void SetFlags(unsigned int flags) LINK_STRIPPED; inline void SetTextDescription(unsigned int text) LINK_STRIPPED; inline void Disable() LINK_STRIPPED; inline void Enable() LINK_STRIPPED; inline unsigned int LeftRightFlag() LINK_STRIPPED; inline unsigned int TextDescription() LINK_STRIPPED; inline short SelFade() LINK_STRIPPED; inline void SetSelFade(short v) LINK_STRIPPED; inline int NumFrames() LINK_STRIPPED;
#define NFS4_FEMENU_TMENUITEM_STRIPPED_DEFS inline bool tMenuItem::IsEnabled() { return ((fFlags ^ 1) & 1) != 0; } inline tMenu *tMenuItem::NewMenu() { return fNewMenu; } inline unsigned int tMenuItem::GetFlags() { return fFlags; } inline void tMenuItem::SetFlags(unsigned int flags) { fFlags = flags; } inline void tMenuItem::SetTextDescription(unsigned int text) { fTextDescription = text; } inline void tMenuItem::Disable() { fFlags |= 1; } inline void tMenuItem::Enable() { fFlags &= ~1; } inline unsigned int tMenuItem::LeftRightFlag() { return fFlags & 0x400; } inline unsigned int tMenuItem::TextDescription() { return fTextDescription; } inline short tMenuItem::SelFade() { return fSelFade; } inline void tMenuItem::SetSelFade(short v) { fSelFade = v; } inline int tMenuItem::NumFrames() { return fNumFrames; }
#define NFS4_FEMENU_TMENU_STRIPPED_DECLS inline short CurrentItem() LINK_STRIPPED; inline void SetChildMenu(tMenu *child) LINK_STRIPPED; inline void SetVerticalHelp(short help) LINK_STRIPPED; inline bool HasFlag(unsigned int flag) LINK_STRIPPED; inline tMenuItem *Item(int n) LINK_STRIPPED; inline bool CanContinue() LINK_STRIPPED; inline bool HasOptionsMenu() LINK_STRIPPED; inline unsigned int ExitsWithBack() LINK_STRIPPED; inline tScreen *GetScreen() LINK_STRIPPED; inline unsigned int GetMusic() LINK_STRIPPED; inline tMenuItem *CurrentMenuItem() LINK_STRIPPED; inline short TitleText() LINK_STRIPPED; inline bool NeverAnyEnabled() LINK_STRIPPED;
#define NFS4_FEMENU_TMENU_STRIPPED_DEFS inline short tMenu::CurrentItem() { return fCurrentItem; } inline void tMenu::SetChildMenu(tMenu *child) { fChildMenu = child; } inline void tMenu::SetVerticalHelp(short help) { VertHelp = help; } inline bool tMenu::HasFlag(unsigned int flag) { return (fFlags & flag) != 0; } inline tMenuItem *tMenu::Item(int n) { return fItemList[n]; } inline bool tMenu::CanContinue() { return fNextMenu != (tMenu *)0x0 || (fFlags & 0x400) != 0 || fOnButtonPress != 0x0; } inline bool tMenu::HasOptionsMenu() { return fOptionsMenu != (tMenu *)0x0; } inline unsigned int tMenu::ExitsWithBack() { return fFlags & 0x100; } inline tScreen *tMenu::GetScreen() { return fScreen; } inline unsigned int tMenu::GetMusic() { return fFlags & 0xf000; } inline tMenuItem *tMenu::CurrentMenuItem() { return fItemList[fCurrentItem]; } inline short tMenu::TitleText() { return fTitle; } inline bool tMenu::NeverAnyEnabled() { return fNeverAnyEnabled; }
#else
#define NFS4_FEMENU_TMENUITEM_STRIPPED_DECLS
#define NFS4_FEMENU_TMENUITEM_STRIPPED_DEFS
#define NFS4_FEMENU_TMENU_STRIPPED_DECLS
#define NFS4_FEMENU_TMENU_STRIPPED_DEFS
#endif
#define NFS4_FEAPP_INF3 inline short YOffset() { return fYOffset; } inline int InputPlayer() { return fInputPlayer; } inline unsigned int CurrentMusic() { return fCurrentMusic; }   /* INFERRED bodies: retail TPDEF tFEApplication x9 at the class in every non-owner object (ours 3 without them); builtin-only, never called (FESCR2) */
#define NFS4_FEAPP_INF6 NFS4_FEAPP_INF3 inline void SetYOffset(short y) { fYOffset = y; } inline void SetInputPlayer(char p) { fInputPlayer = p; } inline void SetCurrentMusic(unsigned int m) { fCurrentMusic = m; }
#define NFS4_FEAPP_INF5 NFS4_FEAPP_INF3 inline void SetYOffset(short y) { fYOffset = y; } inline void SetInputPlayer(char p) { fInputPlayer = p; }
#define NFS4_FEAPP_INF4 NFS4_FEAPP_INF3 inline void SetYOffset(short y) { fYOffset = y; }   /* FEApp: class run 5 -> retail 9 (tFEApplication has no virtuals: no standalone copies; FESCR2) */
#if defined(_FE_SCREENS_SCREENCARSELECT_H_)   /* ScreenCarSelect: fedialog_types.h copy + its GetPlayer surface already give 6 */
#define NFS4_FEAPP_INF_FEDIALOG NFS4_FEAPP_INF3
#else
#define NFS4_FEAPP_INF_FEDIALOG NFS4_FEAPP_INF6
#endif
#ifdef NFS4_TU_FEMENUEXTENDED   /* FEMenuExtended: retail full tMenu/tMenuItem inline-member sets (fe_core_types.h/fe_core_tmenu.h); its own headers carry #line anchors, so the key lives here (FESCR2) */
#define NFS4_FE_CORE_TMENU_ALL_INLINES
#endif
#if defined(NFS4_TU_FEMENUEXTENDED) || defined(NFS4_FE_CORE_MENUITEM_ISENABLED)   /* their NFS4_FE_CORE_MENUITEM_ISENABLED surface already has ButtonImage(): the inferred duplicate would be one tMenuItem body too many (FESCR2) */
#define NFS4_FE_INFERRED_BUTTONIMAGEINDEX
#else
#define NFS4_FE_INFERRED_BUTTONIMAGEINDEX inline int ButtonImageIndex() { return fButtonImage; }
#endif
#endif
