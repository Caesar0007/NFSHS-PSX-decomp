/* frontend/psx/address.c -- RECONSTRUCTED.  obj address.obj = C:\NFS4\FRONTEND\PSX\ADDRESS.ASM (SYM SLD lines 11..16),
 *   the SECOND module of the retail link: the start and end address of the front.bin overlay, i.e. of the `front`
 *   group the linker lays over bigbuf.obj.  Two .rdata words @0x80054D90 right behind bigBuf[282000]; the values are the
 *   linker's group symbols (SYM linker records _front_obj = 0x80010000, _front_objend = 0x80054548). */
extern char _front_obj[], _front_objend[];

char * const FrontStartAddress = _front_obj;      /* @0x80054D90 */
char * const FrontEndAddress   = _front_objend;   /* @0x80054D94 */
