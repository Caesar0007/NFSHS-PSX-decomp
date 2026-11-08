#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton (screendisplay_menuitems.h) */
/* frontend/screens/screenusername.h - reconstructed decls for ScreenUserName.obj (C++ TU) */
#ifndef _FE_SCREENS_SCREENUSERNAME_H_
#define _FE_SCREENS_SCREENUSERNAME_H_
#include "screenusername_types.h"
#include "screenusername_externs.h"

/* Member functions are declared on the owner-specific tScreenUserName type. */
extern short            menu_kUserNameRows;   /* row count */
extern short            MENUUSERNAME_STARTY;  /* vertical-centre offset */
extern tScreenUserName *screenUserName;       /* the screen instance */
extern char             UserPermFileName[20]; /* shape file name */

#endif
