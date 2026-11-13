/* tUserNameMenuItem::SetPostGameNameData - retail records this inline body in FEMenuDefs.obj and FEApp.obj only,
   so it is defined here and included by exactly those two (header-truth rule 3). */
#ifndef NFS4_FRONTEND_COMMON_USERNAMEITEM_POSTGAME_INLINE_H
#define NFS4_FRONTEND_COMMON_USERNAMEITEM_POSTGAME_INLINE_H
inline void tUserNameMenuItem::SetPostGameNameData(short player, char *data) { fPlayer = player; fData = data; fMaxStringLength = 7; fCurrentRow = 0; fCurrentColumn = 0; }
#endif
