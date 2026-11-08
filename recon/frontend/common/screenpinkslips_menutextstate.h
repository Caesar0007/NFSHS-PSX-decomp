/* screenpinkslips_menutextstate.h -- ScreenPinkSlips tMenuTextState (moved verbatim from screentournselect_types.h);
   retail: right after tfrontEnd, before tActiveLine (screenpinkslips_before_activeline.h). */
#ifndef NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_MENUTEXTSTATE_H
#define NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_MENUTEXTSTATE_H
enum tMenuTextState {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
};
#endif
