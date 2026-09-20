/* frontend/common/fedialog_class_noinput.h -- tDialogNoInputMessage, as a guarded include piece: FEDialog.obj needs it declared at a fixed place in the dialog class order (see screendisplay_types.h) */
#ifndef NFS4_FRONTEND_COMMON_FEDIALOG_CLASS_NOINPUT_H
#define NFS4_FRONTEND_COMMON_FEDIALOG_CLASS_NOINPUT_H

struct tDialogNoInputMessage : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#ifdef NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
#endif
#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
    tDialogNoInputMessage();
#endif
};

#endif
