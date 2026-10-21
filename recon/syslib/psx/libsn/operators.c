/* syslib/psx/libsn/operators.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   The GCC 2.7.2 / SN C++ runtime allocator hooks (objs _OP_NEW/_OP_VNEW/_OP_DELE/_OP_VDEL).
 *   `operator new`/`new[]` -> reservememadr(0, size, 0); `operator delete`/`delete[]` -> purgememadr.
 *   GCC 2.x lowers new/delete to these __builtin_* entry points. */

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
#ifdef __cplusplus
extern "C" {
#endif
#include "eaclib/psx/eacpsxz/memstd.h"
#ifdef __cplusplus
}
#endif

/* NOTE: the four __builtin_* allocator hooks are canonically defined in
 * game/common/new.cpp (same VAs @0x800A3D5C/D84/DAC/DCC).  Disabled here to
 * avoid multiply-defined-symbol LINK errors. */
#if 0
/* @0x800A3D5C (_OP_NEW)  : operator new */
extern void *__builtin_new(unsigned size)       { return reservememadr(0, size, 0); }
/* @0x800A3D84 (_OP_VNEW) : operator new[] */
extern void *__builtin_vec_new(unsigned size)   { return reservememadr(0, size, 0); }
/* @0x800A3DAC (_OP_DELE) : operator delete */
extern void  __builtin_delete(void *p)          { purgememadr(p); }
/* @0x800A3DCC (_OP_VDEL) : operator delete[] */
extern void  __builtin_vec_delete(void *p)      { purgememadr(p); }
#endif
