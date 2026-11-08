/* fontblit_typedefs.h -- the EA font-blitter callback typedefs (fontblit/getcode/fontblitbegin/fontblitend/adjustchar),
   one shared definition (identical per-TU copies exist in frontend/game *_types.h; retail aidebug.obj records all five
   right after CarLogic_tObservations). */
#ifndef NFS4_SHARED_FONTBLIT_TYPEDEFS_H
#define NFS4_SHARED_FONTBLIT_TYPEDEFS_H
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
#endif
