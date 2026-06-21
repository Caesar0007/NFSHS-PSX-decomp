/* minimal <stddef.h> for the decomp -nostdinc build. size_t matches nfs4_types.h
   (unsigned int on R3000). C++ permits an identical typedef redefinition, so this
   coexists with nfs4_types.h's size_t. */
#ifndef _DECOMP_STDDEF_H_
#define _DECOMP_STDDEF_H_
typedef unsigned int size_t;
#ifndef NULL
#define NULL 0
#endif
#endif
