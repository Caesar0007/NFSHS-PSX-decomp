/* front_processing_type.h -- Front.obj's tFront_ProcessingType (retail: right after tfrontEnd, before tActiveLine;
 * screendisplay_types.h NFS4_SCREENDISPLAY_HOOK_BEFORE_ACTIVELINE).  Moved verbatim from front_types.h. */
#ifndef NFS4_FRONTEND_COMMON_FRONT_PROCESSING_TYPE_H
#define NFS4_FRONTEND_COMMON_FRONT_PROCESSING_TYPE_H
enum tFront_ProcessingType {
    kFront_InitialLoad = 0,
    kFront_QuitToGameSetup = 1,
    kFront_QuitToPostGame = 2
};
#endif
