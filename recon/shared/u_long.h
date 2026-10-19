/* u_long -- the SDK's unsigned-long shorthand, shared by the platform type core
   (nfs4_types.h) and the eaclib library headers (eaclib/psx/eacpsxz/eac_types.h).
   It has its own file because cc1 rejects a repeated typedef in C, so exactly one
   definition may exist per translation unit. */
#ifndef NFS4_SHARED_U_LONG_H
#define NFS4_SHARED_U_LONG_H

typedef unsigned long u_long;

#endif
