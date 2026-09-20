/* frontend/common/fescreen_virtual_types.h -- the types named by the front-end ROOT virtuals (tScreen, tMenuItem, tMenu):
 * tPlayer, tInputKeyType and (by reference only) tMenuCommand.  Every owner surface needs them to DECLARE the virtuals, even
 * if it never calls them.  A surface that spells `#define tPlayer int` keeps that spelling. */
#ifndef NFS4_FRONTEND_COMMON_FESCREEN_VIRTUAL_TYPES_H
#define NFS4_FRONTEND_COMMON_FESCREEN_VIRTUAL_TYPES_H

#if defined(tPlayer) && !defined(NFS4_FE_INPUT_NO_PLAYER)
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER
#else
#include "fe_input_enums.h"
#endif
struct tMenuCommand;

#endif
