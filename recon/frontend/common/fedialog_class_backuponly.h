/* frontend/common/fedialog_class_backuponly.h -- tDialogBackUpOnly, as a guarded include piece: FEDialog.obj needs it declared at a fixed place in the dialog class order (see screendisplay_types.h) */
#ifndef NFS4_FRONTEND_COMMON_FEDIALOG_CLASS_BACKUPONLY_H
#define NFS4_FRONTEND_COMMON_FEDIALOG_CLASS_BACKUPONLY_H

struct tDialogBackUpOnly : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tDialogBackUpOnly(int);
};

#endif
