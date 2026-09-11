#ifndef _NFILE_H_
#define _NFILE_H_

#include "eac_types.h"
#include "../../../lib/nfile.h"

extern int FILE_init(int handlecount, int memsize, int opcount);   /* @0x800EBBF4 */
extern int FILE_initwithmem(int handlecount, int memsize, int opcount, void *membuf);   /* @0x800EBC78 */
extern int FILE_overhead(int handlecount, int memsize, int opcount);   /* @0x800EBD74 */
extern int FILE_opstatus(unsigned int id);   /* @0x800EBDC4 */
extern int FILE_operror(unsigned int id);   /* @0x800EBE1C */
extern void FILE_callbackop(unsigned int id, void (*callback)(unsigned int id, int status, int param));   /* @0x800EBE4C */
extern void FILE_priorityop(unsigned int id, int priority);   /* @0x800EBECC */
extern void FILE_cancelop(unsigned int id);   /* @0x800EC008 */
extern int FILE_waitop(unsigned int id);   /* @0x800EC1BC */
extern int FILE_completeop(unsigned int id);   /* @0x800EC2B0 */
extern unsigned int FILE_open(char *name, unsigned int mode, unsigned int prio, unsigned int udata);   /* @0x800EC36C */
extern unsigned int FILE_close(void *handle, unsigned int prio, unsigned int udata);   /* @0x800EC42C */
extern unsigned int FILE_read(void *handle, unsigned int offset, unsigned int dest, int len, unsigned int a5, unsigned int a6);   /* @0x800EC4EC */
extern unsigned int FILE_size(void *handle, unsigned int a1, unsigned int a2);   /* @0x800EC5D0 */
extern void iFILE_addbigreadcallback(unsigned int id, int status, int *node);   /* @0x800EC660 */
extern void iFILE_addbigopencallback(unsigned int id, int status, int *node);   /* @0x800EC7A0 */
extern unsigned int FILE_addbig(char *name, unsigned int a1, unsigned int datatype, unsigned int param);   /* @0x800EC858 */
extern void iFILE_delbigclosecallback(unsigned int id, int a1, void *cmd);   /* @0x800EC980 */
extern unsigned int FILE_delbig(int delHandle, unsigned int a2, unsigned int a3);   /* @0x800EC9AC */
extern int FILE_atomic(int (*fn)(int, int), int unused, int a3, int a4);   /* @0x800ECB40 */
extern void iFILE_ExecCommand(void *cmd);   /* @0x800ECB98 */
extern int iFILE_CommandCompleteCallback(int result);   /* @0x800ED020 */
extern void iFILE_perror(FileOp *op);   /* @0x800ED0D4 */
extern FileOp *reserveop(void);   /* @0x800ED0DC */
extern void freeop(FileOp *op);   /* @0x800ED1F8 */
extern FileHandle *reservehandle(void);   /* @0x800ED240 */
extern void freehandle(FileHandle *h);   /* @0x800ED2F0 */

#endif
