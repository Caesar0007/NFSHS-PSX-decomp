/* frontend/psx/vsprintf.h -- vsprintf.obj's type environment: its retail SYM block holds exactly one record,
 * TPDEF va_list (type PTR UCHAR, as in cache.obj; the game TUs record PTR VOID). */
#ifndef _FRONTEND_PSX_VSPRINTF_H_
#define _FRONTEND_PSX_VSPRINTF_H_
typedef char *va_list;   /* retail: PTR UCHAR (cache.obj/vsprintf.obj header variant) */
#endif
