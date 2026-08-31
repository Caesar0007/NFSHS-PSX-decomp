/* lib/syslib.h — PsyQ SDK functions (LINK_OPAQUE) */
#ifndef _SYSLIB_H_
#define _SYSLIB_H_
#include "../nfs4_types.h"
#include "libfns.h"
typedef struct DR_MOVE{void*_o;}DR_MOVE;
typedef struct LINE_F4{void*_o;}LINE_F4;
typedef int jmp_buf[48];
typedef void (*DslCB)(u_char, u_char *); /* PsyQ 4.3 <libds.h> */

/* -- crt0 -- */
   /* 2mbyte */
void stup2();   /* 2mbyte */
void stup1();   /* 2mbyte */
void stup0();   /* 2mbyte */
/* -- libapi -- */
   /* A39 */
extern long SetRCnt(unsigned long, unsigned short, long);   /* COUNTER */
   /* COUNTER */
extern long StartRCnt(unsigned long);   /* COUNTER */
   /* C68 */
extern void InitHeap (unsigned long *, unsigned long);   /* C57 */
void GPU_cw();   /* C73 */
extern void ChangeClearPAD( long );   /* A91 */
void ChangeClearRCnt();   /* L10 */
void HookEntryInt();   /* A25 */
extern void _96_remove(void);   /* C114 */
extern void ExitCriticalSection(void);   /* A37 */
extern void ReturnFromException(void);   /* A23 */
extern int EnterCriticalSection(void);   /* A36 */
void ResetEntryInt();   /* A24 */
extern long EnableEvent(long);   /* A12 */
extern long OpenEvent(unsigned long,long,long,long (*func)());   /* A08 */
extern long DisableEvent(long);   /* A13 */
extern long open(char *, unsigned long);   /* A50 */
extern long close(long);   /* A54 */
extern long lseek(long, long, long);   /* A51 */
extern long read(long, void *, long);   /* A52 */
extern long write(long, void *, long);   /* A53 */
extern struct DIRENTRY * firstfile(char *, struct DIRENTRY *);   /* FIRST */
void _first_patch();   /* FIRST */
extern struct DIRENTRY * nextfile(struct DIRENTRY *);   /* A67 */
extern long erase(char *);   /* A69 */
extern long format(char *);   /* A65 */
void SysDeqIntRP();   /* L03 */
void SysEnqIntRP();   /* L02 */
extern void DeliverEvent(unsigned long, unsigned long);   /* A07 */
extern void _bu_init(void);   /* C112 */
extern long CloseEvent(long);   /* A09 */
extern long TestEvent(long);   /* A11 */
void firstfile2();   /* A66 */
void Eac_hypot();   /* PAD */
/* -- libc -- */
   /* C43 */
   /* SPRINTF */
   /* C25 */
   /* C23 */
   /* QSORT */
void _swap();   /* QSORT */
   /* C36 */
   /* C21 */
   /* A63 */
   /* C27 */
   /* C42 */
   /* C47 */
   /* C16 */
   /* C24 */
   /* C26 */
   /* C30 */
extern void *memchr (unsigned char *, unsigned char, int);   /* C46 */
extern void *memmove(unsigned char *, unsigned char *, int);   /* MEMMOVE */
extern int printf(char *fmt, ...);   /* C63 */
extern char *strrchr(char *, char);   /* C31 */
extern char tolower(char);   /* C38 */
extern int memcmp (/* unsigned char *, unsigned char *, int */);   /* MEMCMP */
extern int setjmp(jmp_buf);   /* C19 */
extern char toupper(char);   /* C37 */
extern void *bsearch(unsigned char *, unsigned char *, size_t, size_t, int (*)());   /* BSEARCH */
extern void *bzero(unsigned char *, int);   /* C40 */
/* -- libcard -- */
extern long _card_info(long chan);   /* C171 */
extern long _card_clear(long chan);   /* CARD */
extern long _card_load(long chan);   /* C172 */
extern void _new_card(void);   /* A80 */
extern long _card_write(long chan, long block, unsigned char *buf);   /* A78 */
extern void InitCARD(long val);   /* INIT */
extern long StartCARD(void);   /* INIT */
extern long StopCARD(void);   /* INIT */
void InitCARD2();   /* A74 */
void _card_patch_text_state();   /* PATCH */
void _card_patch_text_handler();   /* PATCH */
void _card_patch_jmp();   /* PATCH */
void _call_card_patch_state();   /* PATCH */
void _patch_card();   /* PATCH */
void _patch_card2();   /* PATCH */
void _copy_memcard_patch();   /* PATCH */
void StartCARD2();   /* A75 */
void StopCARD2();   /* A76 */
void _ExitCard();   /* END */
/* -- libcd -- */
   /* TYPE */
int CdGetDiskType(void);   /* TYPE; PsyQ 4.3 <libcd.h> */
void StCdInterrupt(void);   /* C_011; PsyQ 4.3 <libcd.h> */
void _memcpy_w();   /* C_011 */
void _StSetDMA();   /* C_011 */
void StClearRing(void);   /* C_002; PsyQ 4.3 <libcd.h> */
void StUnSetRing(void);   /* C_003; PsyQ 4.3 <libcd.h> */
int CdRead2(long mode);   /* CDREAD2; PsyQ 4.3 <libcd.h> */
void _cdread2_ready_cb();   /* CDREAD2 */
void StSetStream();   /* C_005 */
CdlFILE *CdSearchFile(CdlFILE *fp, char *name);   /* ISO9660; PsyQ 4.3 <libcd.h> */
void _iso_fnmatch_12();   /* ISO9660 */
void CD_newmedia();   /* ISO9660 */
void _iso_find_pte();   /* ISO9660 */
void CD_cachefile();   /* ISO9660 */
void iso_cd_read_sectors_sync();   /* ISO9660 */
void StSetRing(u_long *ring_addr, u_long ring_size);   /* CDROM; PsyQ 4.3 <libcd.h> */
u_long StGetNext(u_long **addr, u_long **header);   /* C_009; PsyQ 4.3 <libcd.h> */
u_long StFreeRing(u_long *base);   /* C_007; PsyQ 4.3 <libcd.h> */
void init_ring_status();   /* C_008 */
void data_ready_callback();   /* C_004 */
void StSetMask(u_long mask, u_long start, u_long end);   /* C_010; PsyQ 4.3 <libcd.h> */
void CdReadDoneCb();   /* C_010 */
void CdReadReadyCb();   /* C_010 */
void CdReadDataCb();   /* C_010 */
void CdReadCore();   /* C_010 */
int CdRead(int sectors, u_long *buf, int mode);   /* CDREAD; PsyQ 4.3 <libcd.h> */
int CdReadSync(int mode, u_char *result);   /* CDREAD; PsyQ 4.3 <libcd.h> */
int CdInit(void);   /* EVENT; PsyQ 4.3 <libcd.h> */
void CdInitOnce();   /* EVENT */
void CdCbsync();   /* EVENT */
void CdCbready();   /* EVENT */
void CdCbread();   /* EVENT */
int CdGetToc(CdlLOC *loc);   /* TOC; PsyQ 4.3 <libcd.h> */
void CdGetToc2();   /* TOC */
/* -- libds -- */
DslCB DsReadyCallback(DslCB func);   /* DSCB; PsyQ 4.3 <libds.h> */
void DsDataCallback();   /* DSCB */
/* -- libetc -- */
   /* VMODE */
long GetVideoMode(void);   /* VMODE; PsyQ 4.3 <libetc.h> */
   /* VSYNC */
void _VSync_wait();   /* VSYNC */
   /* INTR */
void InterruptCallback();   /* INTR */
void DMACallback();   /* INTR */
   /* INTR */
void VSyncCallbacks();   /* INTR */
int CheckCallback(void);   /* INTR; PsyQ 4.3 <libetc.h> */
void SetIntrMask();   /* INTR */
void _initIntr();   /* INTR */
void _intrhand();   /* INTR */
void _set_intr_callback();   /* INTR */
int StopCallback(void);   /* INTR; PsyQ 4.3 <libetc.h> */
int RestartCallback(void);   /* INTR; PsyQ 4.3 <libetc.h> */
void _bzero_w();   /* INTR */
void startIntrVSync();   /* INTR_VB */
void trapIntrVSync();   /* INTR_VB */
// dup: void VSyncCallback();   /* INTR_VB */
// dup: void _bzero_w();   /* INTR_VB */
void startIntrDMA();   /* INTR_DMA */
void _dma_isr();   /* INTR_DMA */
// dup: void DMACallback();   /* INTR_DMA */
// dup: void _bzero_w();   /* INTR_DMA */
/* -- libgpu -- */
void Eac_vars();   /* SYS */
   /* SYS */
   /* SYS */
void _image();   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
   /* SYS */
void _set_drawenv();   /* SYS */
void _set_draw_mode();   /* SYS */
void _set_clip_tl();   /* SYS */
void _set_clip_br();   /* SYS */
void _set_draw_offset();   /* SYS */
void _get_tw();   /* SYS */
void _get_status();   /* SYS */
void _clearOTagR_dma();   /* SYS */
void _BlitClear();   /* SYS */
void _dws();   /* SYS */
void _drs();   /* SYS */
void _send_gp1();   /* SYS */
void _get_gp1();   /* SYS */
void _send_gp0();   /* SYS */
void _gpu_dma_chain();   /* SYS */
void _get_gpuinfo();   /* SYS */
void _que_ref();   /* SYS */
void _gpu_que_push();   /* SYS */
void _gpu_que_drain();   /* SYS */
void _reset();   /* SYS */
void _sync();   /* SYS */
void _gpu_arm_timeout();   /* SYS */
void _gpu_check_timeout();   /* SYS */
void _gpu_init_videomode();   /* SYS */
extern int DrawOTag2(u_long *p);   /* SYS */
void _install_drain_cb();   /* SYS */
void _memset();   /* SYS */
   /* P00 */
   /* EXT */
   /* EXT */
   /* P10 */
   /* P19 */
   /* P12 */
   /* P16 */
   /* P18 */
   /* P17 */
   /* P01 */
   /* P11 */
// dup: extern void SetPolyF3(POLY_F3 *p) ;   /* P11 */
extern u_long *FntFlush(int id);   /* FONT */
extern int FntPrint();   /* FONT */
int CdStatus(void);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdMode(void);   /* SYS; PsyQ 4.3 <libcd.h> */
CdlLOC *CdLastPos(void);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdReset(int mode);   /* SYS; PsyQ 4.3 <libcd.h> */
void CdFlush(void);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdSetDebug(int level);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdSync(int mode, u_char *result);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdReady(int mode, u_char *result);   /* SYS; PsyQ 4.3 <libcd.h> */
CdlCB CdSyncCallback(CdlCB func);   /* SYS; PsyQ 4.3 <libcd.h> */
CdlCB CdReadyCallback(CdlCB func);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdControl(u_char com, u_char *param, u_char *result);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdControlF(u_char com, u_char *param);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdControlB(u_char com, u_char *param, u_char *result);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdGetSector(void *madr, int size);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdGetSector2(void *madr, int size);   /* SYS; PsyQ 4.3 <libcd.h> */
void CdDataCallback();   /* SYS */
int CdDataSync(int mode);   /* SYS; PsyQ 4.3 <libcd.h> */
CdlLOC *CdIntToPos(int i, CdlLOC *p);   /* SYS; PsyQ 4.3 <libcd.h> */
int CdPosToInt(CdlLOC *p);   /* SYS; PsyQ 4.3 <libcd.h> */
void Libgpu_p20();   /* P09 */
extern void AddPrim(void *ot, void *p) ;   /* P06 */
extern void SetDrawMove(DR_MOVE *p, RECT *rect, int x, int y) ;   /* P34 */
/* -- libgte -- */
   /* REG13 */
   /* MSC02 */
   /* MSC02 */
extern long VectorNormalSS(SVECTOR *v0, SVECTOR *v1);   /* MSC02 */
void _VectorNormalS_tail();   /* MSC02 */
void _VectorNormalSS_kernel();   /* MSC02 */
   /* MSC00 */
   /* FGO_01 */
   /* REG11 */
   /* FOG_01 */
   /* FGO_06 */
   /* COR_02 */
   /* COR_03 */
void _patch_gte();   /* PATCHGTE */
void _gte_patch_text();   /* PATCHGTE */
void SetDQA();   /* REG03 */
void SetDQB();   /* REG03 */
void csincos();   /* COR_01 */
/* -- libmath -- */
   /* FLTSIDF */
   /* LTDF2 */
void __gtdf2();   /* GTDF2 */
   /* MULSF3 */
   /* FIXSFSI */
   /* EXTSFDF2 */
   /* TRUDFSF2 */
   /* ADDDF3 */
   /* DIVDF3 */
void _comp_mant();   /* DIVDF3 */
   /* FLTSISF */
extern void SetLineF4(LINE_F4 *p) ;   /* FLTSISF */
void __muldf3();   /* MULDF3 */
void _mul_mant_d();   /* MULDF3 */
   /* DIVSF3 */
void __fixdfsi();   /* FIXDFSI */
void _dbl_shift_us();   /* DBSHIFTU */
void _err_math();   /* FERR */
void _dbl_shift();   /* DBSHIFT */
void _mainasu();   /* MAINASU */
void _add_mant_d();   /* ADDMANT */
/* -- libmcrd -- */
void MemCardInit(long val);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardEnd(void);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardStart(void);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardStop(void);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
long MemCardExist(long chan);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardExist_cb();   /* LIBMCRD */
long MemCardAccept(long chan);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardCmd_cb();   /* LIBMCRD */
long MemCardReadData(unsigned long *adrs, long ofs, long bytes);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardReadData_cb();   /* LIBMCRD */
long MemCardWriteData(unsigned long *adrs, long ofs, long bytes);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardWriteData_cb();   /* LIBMCRD */
long MemCardReadFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardReadFile_cb();   /* LIBMCRD */
long MemCardWriteFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardWriteFile_cb();   /* LIBMCRD */
void MemCardGetDirentry();   /* LIBMCRD */
MemCB MemCardCallback(MemCB func);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
long MemCardSync(long mode, long *cmds, long *rslt);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
long MemCardCreateFile(long chan, char *file, long blocks);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
long MemCardDeleteFile(long chan, char *file);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardFormat();   /* LIBMCRD */
long MemCardUnformat(long chan);   /* LIBMCRD; PsyQ 4.3 <libmcrd.h> */
void MemCardEventToRslt();   /* LIBMCRD */
void MemCardStart_cb();   /* LIBMCRD */
void MemCardMakeDevname();   /* LIBMCRD */
void CD_get_intr();   /* BIOS */
void CD_sync();   /* BIOS */
void CD_ready();   /* BIOS */
void CD_cw();   /* BIOS */
void CD_flush();   /* BIOS */
void CD_initvol();   /* BIOS */
void CD_initintr();   /* BIOS */
int CD_init(void);   /* libcd BIOS.obj */
void CD_datasync();   /* BIOS */
void CD_getsector();   /* BIOS */
void CD_getsector2();   /* BIOS */
void CD_set_test_parmnum();   /* BIOS */
void CD_intr_dispatch();   /* BIOS */
void funcEvSpIOE();   /* BIOS */
void funcEvSpError();   /* BIOS */
void funcEvSpTimeout();   /* BIOS */
void funcEvSpNewcard();   /* BIOS */
void funcEvSpIOEx();   /* BIOS */
void funcEvSpErrorx();   /* BIOS */
void funcEvSpTimeoutx();   /* BIOS */
void funcEvSpNewcardx();   /* BIOS */
void _card_open();   /* BIOS */
void _card_start();   /* BIOS */
void _card_close();   /* BIOS */
void _card_stop();   /* BIOS */
void _clr_card_event();   /* BIOS */
void _get_card_event();   /* BIOS */
void _get_card_event_x();   /* BIOS */
void _chk_card_event();   /* BIOS */
void _chk_card_event_x();   /* BIOS */
void UserFuncInit();   /* USERFUNC */
void UserFuncOpen();   /* USERFUNC */
void UserFuncExecute();   /* USERFUNC */
void UserFuncComplete();   /* USERFUNC */
/* -- libpad -- */
void PadStartCom(void);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
void PadStopCom(void);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
int PadGetState(int port);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
int PadInfoMode(int port, int term, int offs);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
int PadInfoAct(int port, int actno, int term);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
int PadSetActAlign(int port, unsigned char *data);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
int PadSetMainMode(int port, int offs, int lock);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
void PadSetAct(int port, unsigned char *data, int len);   /* PADENTRY; PsyQ 4.3 <libpad.h> */
void PadInitDirect(unsigned char *pad1, unsigned char *pad2);   /* PADPORTD; PsyQ 4.3 <libpad.h> */
void PadResetState();   /* PADPORTD */
void PadFailAll();   /* PADPORTD */
void PadShift();   /* PADPORTD */
void PadGetByte();   /* PADPORTD */
void PadFilter();   /* PADPORTD */
void PadPortToSlot();   /* PADPORTD */
void PadGetPort();   /* PADPORTD */
void _padSetVsyncParam();   /* PADMAIN */
void _padVbCallback1();   /* PADMAIN */
void _padVbCallback0();   /* PADMAIN */
void _padStartCom();   /* PADMAIN */
void _padStopCom();   /* PADMAIN */
void _padInitSioMode();   /* PADMAIN */
void _padSioMain();   /* PADMAIN */
void _padSioRW();   /* PADMAIN */
void _padSioRW2();   /* PADMAIN */
void _padClrIntSio0();   /* PADMAIN */
void _padWaitRXready();   /* PADMAIN */
void _padSetAct();   /* PADCMD */
void _padSendAtLoadInfo();   /* PADCMD */
void _padRecvAtLoadInfo();   /* PADCMD */
void _padGetActSize();   /* PADCMD */
void _padLoadActInfo();   /* PADCMD */
void _padLoadActInfo_snd();   /* PADCMD */
void _padLoadActInfo_rcv();   /* PADCMD */
void _padSetActAlign();   /* PADCMD */
void _padSetActAlign_snd();   /* PADCMD */
void _padSetActAlign_rcv();   /* PADCMD */
void _padSetMainMode();   /* PADCMD */
void _padSetMainMode_snd();   /* PADCMD */
int  _padSetMainMode_rcv();   /* PADCMD -- returns 1 if already in the requested mode, else 0 (w48-a3) */
void _padCmdParaMode();   /* PADCMD */
void _padCmdGetStatus();   /* PADCMD */
void _padCmdSetMap();   /* PADCMD */
void _padCmdGetDescR0();   /* PADCMD */
void _padCmdGetDescR1();   /* PADCMD */
void _padCmd4B();   /* PADCMD */
void _padInitDirSeq();   /* PADSEQD */
void _dirSendAuto();   /* PADSEQD */
void _dirRecvAuto();   /* PADSEQD */
void _dirFailAuto();   /* PADSEQD */
void _dirCheck();   /* PADSEQD */
void setRC2wait();   /* WAITRC2 */
void chkRC2wait();   /* WAITRC2 */
void _padIntInit();   /* PADIF */
void _padIntQuery();   /* PADIF */
void _padIntRecvId();   /* PADIF */
void _padIntRecvHdr();   /* PADIF */
void _padIntRecvData();   /* PADIF */
/* -- libpress -- */
void Libp_table();   /* TABLE */
extern int DecDCTvlcSize(int size);   /* VLC */
extern int DecDCTvlc(u_long *bs, u_long *buf);   /* VLC */
extern void DecDCTReset(int mode);   /* LIBPRESS */
extern void DecDCTin(u_long *buf, int mode);   /* LIBPRESS */
extern void DecDCTout(u_long *buf, int size);   /* LIBPRESS */
extern int DecDCTinSync( int mode) ;   /* LIBPRESS */
extern int DecDCToutCallback(void (*func)());   /* LIBPRESS */
void MDEC_rest();   /* LIBPRESS */
void _MDEC_in_dma();   /* LIBPRESS */
void _MDEC_out_dma();   /* LIBPRESS */
void MDEC_in_sync();   /* LIBPRESS */
void MDEC_out_sync();   /* LIBPRESS */
void _MDEC_get_reg1();   /* LIBPRESS */
void MDEC_status();   /* LIBPRESS */
/* -- libsn -- */
void __pure_virtual();   /* PUREV */
int PCread(int fd, char *buff, int len);   /* READ; PsyQ 4.3 <libsn.h> */
int PCopen(char *name, int flags, int perms);   /* OPEN; PsyQ 4.3 <libsn.h> */
int PCinit(void);   /* FSINIT; PsyQ 4.3 <libsn.h> */
int PCcreat(char *name, int perms);   /* CREAT; PsyQ 4.3 <libsn.h> */
int PClseek(int fd, int offset, int mode);   /* LSEEK; PsyQ 4.3 <libsn.h> */
int PCclose(int fd);   /* CLOSE; PsyQ 4.3 <libsn.h> */
int PCwrite(int fd, char *buff, int len);   /* WRITE; PsyQ 4.3 <libsn.h> */
void _SN_read();   /* SNREAD */
void _SN_write();   /* SNWRITE */

#endif
