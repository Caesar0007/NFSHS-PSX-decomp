/* lib/nfs4_new.h -- placement-new shim for the reconstructed cdtor TUs.
 *
 * The faithful cdtor reconstructions use placement new ( new(ptr) T() ) to
 * re-run constructors over existing storage. The C++ standard provides this via
 * <new>, but PsyQ 4.3 / gcc 2.7.2 has no <new> header. This shim supplies the
 * single placement-new operator under ccpsx, and defers to the real <new> on a
 * modern toolchain (host pre-gate). Drop-in replacement for `#include <new>`.
 *
 * Ordering note: these TUs include this BEFORE nfs4_types.h, so size_t is not yet
 * in scope -> pull PsyQ <sys/types.h> here (idempotent; nfs4_types.h includes it too).
 */
#ifndef _NFS4_NEW_H_
#define _NFS4_NEW_H_

#if defined(__GNUC__) && __GNUC__ < 3
#  include <sys/types.h>                       /* size_t */
inline void *operator new(size_t, void *p) { return p; }
#else
#  include <new>
#endif

#endif /* _NFS4_NEW_H_ */
