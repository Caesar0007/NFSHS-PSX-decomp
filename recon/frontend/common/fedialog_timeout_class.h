/* tDialogMessageStringWithTimeout -- split out of screenmemcard_types.h so the g++ interface/implementation
 * pragmas can scope to exactly this class.
 *
 * Retail (SYM/SLD): the destructor is header-defined (FEDIALOG.H:215), INLINED into ~tFEApplication (which
 * calls ~tScreen directly, 0x800131ec) and still emitted once, out of line, as the LAST function of FEApp.obj
 * (0x80015760); only the class vtable (FEApp.obj .rdata 0x800100b8) references that copy.
 *
 * INTERIM CARRIER until the frontend hierarchy is real C++ virtuals (then FEApp.obj's own local vtable makes
 * cc1plus emit the copy by itself): `#pragma interface` here + `#pragma implementation` in feapp.cpp make the
 * implementation TU output the one out-of-line copy of the inline destructor in its end-of-object batch while
 * the body is still expanded at its uses (probes build/psyq/probe/pi.i, pj.i).  The pragma would also force
 * a copy of the class's inline CONSTRUCTOR, which retail does not have, so the two constructor stores live in
 * a helper base declared BEFORE the pragma (not an interface class -> no copy) and the class itself keeps a
 * compiler-synthesized constructor.  The helper adds no members; layout and code are unchanged.
 * Only FEApp's method surface sees the constructor/destructor at all. */
#ifndef NFS4_FEDIALOG_TIMEOUT_CLASS_H
#define NFS4_FEDIALOG_TIMEOUT_CLASS_H

#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
/* SYM-CODEGEN-CARRIER: tDialogMessageStringWithTimeoutInit (not a retail class) */
struct tDialogMessageStringWithTimeoutInit : public tDialogMessageString {
    tDialogMessageStringWithTimeoutInit();
};

#pragma interface "fedialog_timeout_class.h"   /* named: gcc 2.8 takes the basename after the last '/', and cpp emits backslash paths here */

struct tDialogMessageStringWithTimeout : public tDialogMessageStringWithTimeoutInit {
    ~tDialogMessageStringWithTimeout() {}
};
#else
struct tDialogMessageStringWithTimeout : public tDialogMessageString {};
#endif

#endif
