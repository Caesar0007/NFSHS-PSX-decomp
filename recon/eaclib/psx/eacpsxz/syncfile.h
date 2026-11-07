#ifndef _SYNCFILE_H_
#define _SYNCFILE_H_

#include "eac_types.h"

/* internals -> syncfile_private.h (library sources only; no retail game object records them) */














/* NOTE: nsync.c calls the 3rd argument of the *sync family `retry`, nasync.c calls it `prio`.
 * Named `prio` here to match the async FILE_open/FILE_close it forwards to; the true meaning
 * is unconfirmed -- it reaches the oracle as plain $a2. */
extern int FILE_opensync(char *name, int mode, int prio, int *outHandle);   /* @0x800EA8A8 */
extern void FILE_readsync(int fd, int offset, void *buf, int len, int cbarg);   /* @0x800EA920 */
extern int FILE_closesync(int handle, int prio);   /* @0x800EA950 */
extern int FILE_sizesync(int handle, int retry);   /* @0x800EA9A4 */
extern int FILE_addbigsync(char *name, int a2, int a3, int *out);   /* @0x800EA9F8 */
extern int FILE_delbigsync(int a0, int a1);   /* @0x800EAA70 */

#endif
