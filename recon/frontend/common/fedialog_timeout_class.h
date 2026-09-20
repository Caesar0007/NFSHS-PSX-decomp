/* frontend/common/fedialog_timeout_class.h -- tDialogMessageStringWithTimeout.
 * An all-inline polymorphic class (2026-09-20, real virtuals): every object that constructs one emits a private copy of
 * its table and the synthesized destructor the table names -- in retail that is FEApp.obj only (table 0x80010098).
 * The former `#pragma interface` carrier and its helper base are gone. */
#ifndef NFS4_FEDIALOG_TIMEOUT_CLASS_H
#define NFS4_FEDIALOG_TIMEOUT_CLASS_H

struct tDialogMessageStringWithTimeout : public tDialogMessageString {
#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
    tDialogMessageStringWithTimeout();   /* inline, feapp.cpp */
#endif
};

#endif
