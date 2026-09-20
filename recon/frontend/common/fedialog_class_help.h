/* frontend/common/fedialog_class_help.h -- tDialogHelp, as a guarded include piece: FEDialog.obj needs it declared at a fixed place in the dialog class order (see screendisplay_types.h) */
#ifndef NFS4_FRONTEND_COMMON_FEDIALOG_CLASS_HELP_H
#define NFS4_FRONTEND_COMMON_FEDIALOG_CLASS_HELP_H

struct tDialogHelp : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
#ifdef NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
    void AddItem(short, short);
    inline void CalculateDimensionsVirtual() { CalculateDimensions(); }
#endif
#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
    tDialogHelp();
#endif
};

#endif
