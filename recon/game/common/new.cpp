/* game/common/new.cpp -- RECONSTRUCTED (GCC 2.x operator new/delete runtime wrappers; C++ TU,
 *   4 fns -> eaclib EACPSXZ reservememadr / purgememadr). */
#include "game_common_min_types.h"

extern "C" {
void *reservememadr(char *name, int size, int memory_class);
int purgememadr(void *ptr);
}

/* new.obj-owned allocator state (SYM EXT PTR CHAR @0x8013d26c). */
char *New_cplusplus_heap;


/* ---- __builtin_new  [NEW.CPP:16-27] SLD-VERIFIED ---- */
void *__builtin_new(unsigned int size)

{
  return reservememadr((char *)0x0,(int)size,0);
}

/* ---- __builtin_vec_new  [NEW.CPP:31-42] SLD-VERIFIED ---- */
void *__builtin_vec_new(unsigned int size)

{
  return reservememadr((char *)0x0,(int)size,0);
}

/* ---- __builtin_delete  [NEW.CPP:46-47] SLD-VERIFIED ---- */
void __builtin_delete(void *deleteMe)

{
  purgememadr(deleteMe);
  return;
}

/* ---- __builtin_vec_delete  [NEW.CPP:51-52] SLD-VERIFIED ---- */
void __builtin_vec_delete(void *deleteMe)

{
  purgememadr(deleteMe);
  return;
}

/* end of new.cpp */
