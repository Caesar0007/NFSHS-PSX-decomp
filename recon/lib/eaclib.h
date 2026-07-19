/* lib/eaclib.h — EA runtime functions (LINK_OPAQUE) */
#ifndef _EACLIB_H_
#define _EACLIB_H_
#include "../nfs4_types.h"
#include "libfns.h"

/* -- EACPSXZ -- */
   /* fixdmult */
   /* trnspos */
   /* fixddiv */
void FREE_find(void * arg0);   /* memstd */
void FREE_findlargest(void * arg0);   /* memstd */
void FREE_add(void * arg0);   /* memstd */
void FREE_remove(void * arg0);   /* memstd */
void initmemblock(void * arg0);   /* memstd */
void MEM_infosize(int arg0);   /* memstd */
void MEM_tailsize(char * arg0);   /* memstd */
void creatememclass(int arg0);   /* memstd */
   /* memstd */
void getblocksize(void * arg0);   /* memstd */
void getblockname(void * arg0);   /* memstd */
   /* memstd */
   /* memstd */
void filesizeatomic(int arg0);   /* nsync */
   /* nsync */
void loadfileadratomic(int arg0);   /* nsync */
   /* nsync */
   /* nsync */
void loadfileatadratomic(int arg0);   /* nsync */
   /* nsync */
   /* nsync */
void loadbigfileheaderatomic(int arg0);   /* nsync */
   /* nsync */
   /* xform */
   /* atanfunc */
   /* nloadpk */
   /* nloadpk */
void typeofbigfile(void * arg0);   /* locatbig */
void sizeofbigfileheader(void * arg0);   /* locatbig */
   /* locatbig */
   /* locatbig */
void locatebigoffset(void * arg0);   /* locatbig */
   /* locatbig */
   /* locatbig */
   /* blkmov */
   /* systask */
   /* systask */
   /* systask */
   /* random */
   /* random */
   /* timer */
void elapsedticks();   /* timer */
void resettick();   /* timer */
   /* timer */
   /* wildcard */
void synccallback(int arg0);   /* syncfile */
void syncblockio(void * arg0);   /* syncfile */
   /* syncfile */
   /* syncfile */
   /* syncfile */
void FILE_sizesync(char * arg0);   /* syncfile */
   /* syncfile */
   /* syncfile */
   /* crossprd */
   /* fxform */
   /* fxform */
   /* fxform */
void intarcsin(int arg0);   /* asinfunc */
   /* asinfunc */
   /* isincos */
   /* trnsfrm */
   /* addtimer */
   /* addtimer */
void initgp();   /* savegp */
   /* savegp */
   /* savegp */
   /* fixdsqrt */
   /* locatshp */
   /* locatshp */
   /* nfile */
void FILE_initwithmem(int arg0);   /* nfile */
void FILE_overhead(int arg0);   /* nfile */
   /* nfile */
   /* nfile */
void FILE_callbackop(int arg0);   /* nfile */
void FILE_priorityop(int arg0);   /* nfile */
void FILE_cancelop(int arg0);   /* nfile */
void FILE_waitop(int arg0);   /* nfile */
   /* nfile */
void FILE_open(char * arg0);   /* nfile */
void FILE_close(void * arg0);   /* nfile */
   /* nfile */
void FILE_size(char * arg0);   /* nfile */
void iFILE_addbigreadcallback(int arg0);   /* nfile */
void iFILE_addbigopencallback(int arg0);   /* nfile */
void FILE_addbig(char * arg0);   /* nfile */
void iFILE_delbigclosecallback(int arg0);   /* nfile */
void FILE_delbig(char * arg0);   /* nfile */
void FILE_atomic(void * arg0);   /* nfile */
void iFILE_ExecCommand(void * arg0);   /* nfile */
void iFILE_CommandCompleteCallback(int arg0);   /* nfile */
void iFILE_perror();   /* nfile */
void reserveop(char * arg0);   /* nfile */
void freeop(void * arg0);   /* nfile */
void reservehandle(int arg0);   /* nfile */
void freehandle(void * arg0);   /* nfile */
   /* fixdinv */
   /* fixdsin */
   /* fixdsin */
   /* fixdatan */
void addmatrix(int * arg0);   /* matrix */
void submatrix(int * arg0);   /* matrix */
void scalematrix(int * arg0);   /* matrix */
   /* matrix */
   /* primate */
   /* primate */
   /* primate */
   /* movf */
   /* shpsubs */
   /* shpsubs */
void queueadd(void * arg0);   /* nasync */
void queuefetch(void * arg0);   /* nasync */
void newrequestid(void * arg0);   /* nasync */
void locaterequest(void * arg0);   /* nasync */
void cancelrequest(void * arg0);   /* nasync */
void finishrequest(void * arg0);   /* nasync */
void loadfileclosecallback(int arg0);   /* nasync */
void loadfilereadcallback(int arg0);   /* nasync */
void loadfilesizecallback(int arg0);   /* nasync */
void loadfileopencallback(int arg0);   /* nasync */
void loadsegreadcallback(int arg0);   /* nasync */
void asyncsystemtask();   /* nasync */
   /* nasync */
void asyncloadfilecallback(char * arg0);   /* nasync */
   /* nasync */
void asyncloadfileatcallback(char * arg0);   /* nasync */
   /* nasync */
   /* nasync */
void asyncloadsegmentcallback(int arg0);   /* nasync */
   /* nasync */
   /* nasync */
   /* nasync */
   /* nasync */
   /* blkfill */
   /* blkfill */
   /* sinfunc */
   /* sinfunc */
   /* resize */
   /* loadshp */
void addexit(void * arg0);   /* exit */
   /* textset */
   /* getm */
   /* getm */
void putm(void * arg0);   /* textcrnt */
void puti(void * arg0);   /* textcrnt */
   /* isqrt */
   /* fsincos */
   /* joystkn */
void initfileio(void * arg0);   /* fileroot */
   /* fileroot */
void openfile(char * arg0);   /* fileroot */
void closefile(int arg0);   /* fileroot */
void readfile(int arg0);   /* fileroot */
void readfile_systask();   /* fileroot */
void writefile(int arg0);   /* fileroot */
void getfilesize(int arg0);   /* fileroot */
void stopreadfile(int arg0);   /* fileroot */
void MEM_defaultevent(int arg0);   /* meminit */
   /* inittmr */
   /* inittmr */
void restoretimer();   /* inittmr */
void tmrint(int arg0);   /* inittmr */
   /* shpdepth */
void textbsearch(int arg0);   /* textfor */
   /* textfor */
   /* unhuff */
void memcpyl(void * arg0);   /* unhuff */
void memcpyb(void * arg0);   /* unhuff */
void refcpy(void * arg0);   /* unhuff */
   /* unref */
void chase(int arg0);   /* unref */
   /* unbtree */
   /* nullfunc */
   /* crc */
void checkrect(void * arg0);   /* vramfxya */
void vramimage(void * arg0);   /* vramfxya */
   /* vramfxya */
void getshapeclut(void * arg0);   /* shpclut */
   /* shpclut */
void CD_systaskfunc();   /* cdfs */
void CD_timerfunc();   /* cdfs */
void CdReadyHandler(int arg0);   /* cdfs */
void readsectorB();   /* cdfs */
void loaddirinfo(int arg0);   /* cdfs */
void dircompare(void * arg0);   /* cdfs */
void CD_Restore();   /* cdfs */
void CD_Init(int arg0);   /* cdfs */
void CD_Restart(int arg0);   /* cdfs */
void CD_Open(void * arg0);   /* cdfs */
void CD_Close(int arg0);   /* cdfs */
void CD_Read(int arg0);   /* cdfs */
void CD_Stopread();   /* cdfs */
void CD_Getinfo(int arg0);   /* cdfs */
void cluttype(int arg0);   /* cluttype */
void shapetype(int arg0);   /* shptype */
int validatehandle(int handle, int *outObj, int *outHandle);   /* stream @0x800FC2F8; oracle: 3 args (handle, &obj, &handle) -> int (was a bogus 1-arg void import decl) */
void inbetween(void * arg0);   /* stream */
void decbufferusage(void * arg0);   /* stream */
void getfreerequest(void * arg0);   /* stream */
void queuerequest(void * arg0);   /* stream */
// stream.c's slot-lookup helper @0x800FC4E4 is a file-static whose true SYM name is locaterequest
// (nfs4-f-v3.txt) — the SAME real name as nasync.c's unrelated static locaterequest @0x800F0BF4
// (line 124 above); two distinct EA statics sharing the name across TUs. Its C identifier is kept as
// func_800FC4E4 only so verify_asm resolves it to the disambiguated func_800FC4E4.s oracle (the gate
// keys identifier->.s, so both can't be "locaterequest"). Being static, it has no extern entry here.
void freerequest(void * arg0);   /* stream */
void filterchunk(void * arg0);   /* stream */
void parsechunks(void * arg0);   /* stream */
void opencallback(int arg0);   /* stream */
void closecallback(int arg0);   /* stream */
void readcallback(int arg0);   /* stream */
void startnextrequest(void * arg0);   /* stream */
void restartstream(void * arg0);   /* stream */
void STREAM_overhead(int arg0);   /* stream */
void STREAM_create(int arg0);   /* stream */
void STREAM_setfilter(void * arg0);   /* stream */
void STREAM_destroy(void * arg0);   /* stream */
void STREAM_setpriority(void * arg0);   /* stream */
void STREAM_setgreedylevel(void * arg0);   /* stream */
void STREAM_setgreedystate(void * arg0);   /* stream */
void STREAM_queuefile(void * arg0);   /* stream */
void STREAM_queuemem(void * arg0);   /* stream */
void STREAM_cancelrequest(void * arg0);   /* stream */
void STREAM_kill(void * arg0);   /* stream */
void STREAM_get(int arg0);   /* stream */
void STREAM_release(void * arg0);   /* stream */
void STREAM_gettable(void * arg0);   /* stream */
void STREAM_state(void * arg0);   /* stream */
void STREAM_isendofstream(void * arg0);   /* stream */
void STREAM_buffersize(void * arg0);   /* stream */
void STREAM_bufferusage(void * arg0);   /* stream */
void iscurrentthread(int arg0);   /* threads */
void yieldthread();   /* threads */
void allocmutex();   /* callback */
void freemutex(void * arg0);   /* callback */
void make64(void * arg0);   /* math64a */
void divu64(int arg0);   /* math64a */
void stricmp(char * arg0);   /* stricmp */
void transmult(void * arg0);   /* trnsmult */
void fastmovfxya(void * arg0);   /* fastmovf */
void decodeansi(void * arg0);   /* textcode */
void remapshiftjiscode(int arg0);   /* isqrttbl */
void decodeshiftjis(int * arg0);   /* isqrttbl */
void psxdevelopmentsystem();   /* devsys */
/* -- SNDPSXZ -- */
void iSNDremovepatches(int arg0);   /* sbremove */
   /* sbremove */
void cSNDbankremove(int arg0);   /* sbremove */
   /* splysdef */
   /* span */
void iSNDunsafevol(int arg0);   /* svol */
   /* svol */
   /* sstsetpr */
   /* seffect */
   /* seffect */
void iSNDunsafebend(int arg0);   /* sbend */
   /* sbend */
   /* splay */
void cSNDplay(void * arg0);   /* splay */
   /* sover */
   /* sbhdrsze */
   /* sbhdrcpy */
   /* sdmemlu */
   /* sbadd */
   /* sstop */
   /* spitch */
   /* smasterv */
   /* s3dlow */
void SNDstopall();   /* sstopall */
   /* sautovol */
   /* sstgetv */
   /* sststat */
   /* sstrstat */
void strrstr(char * arg0);   /* sstrstat */
void iSNDstreamdestroyall();   /* sst */
void iSNDstreamgetstreamptr(int arg0);   /* sst */
void iSNDstreamremoverequest(int arg0);   /* sst */
void iSNDstreamreleasecallback(void * arg0);   /* sst */
void iSNDstreamnotifycallback(int arg0);   /* sst */
void iSNDstreamparseheader(void * arg0);   /* sst */
void iSNDstreamparsenumchunks(void * arg0);   /* sst */
void iSNDstreamparsedata(void * arg0);   /* sst */
void iSNDstreamparseend(void * arg0);   /* sst */
void iSNDstreamparsechunk(void * arg0);   /* sst */
void iSNDstreamisheld(void * arg0);   /* sst */
void iSNDstreamhotroddatachunks();   /* sst */
void iSNDstreamservice();   /* sst */
void iSNDstreamnumcreated();   /* sst */
void iSNDstreamcreate(void * arg0);   /* sst */
void iSNDstreamqueue(int arg0);   /* sst */
   /* spvoices */
   /* spvoices */
   /* spvoices */
   /* spvoices */
   /* sstsetgl */
   /* sstsetgs */
   /* sstautov */
   /* slimits */
   /* slimits */
void SNDSTRM_overheadtap(int arg0);   /* sstovrhd */
   /* sstovrhd */
   /* sstvol */
void iSNDserver();   /* sserver */
void iSND100hzserver();   /* sserver */
void iSNDenteraudio();   /* sserver */
void iSNDleaveaudio();   /* sserver */
   /* sserver */
   /* sserver */
   /* stimerem */
   /* ssysinit */
   /* ssysinit */
   /* ssysinit */
   /* ssysinit */
void iSNDsystemtaskreal();   /* ssysreal */
   /* ssysreal */
void SNDcdvol(int arg0);   /* scdvol */
void iSNDplatformfree(void * arg0);   /* sdata */
void iSNDsync_func(int arg0);   /* sbirmpat */
void iSNDvalidbank(int arg0);   /* sbvalid */
void iSNDischanreserved(int arg0);   /* salloc */
void iSNDallocchan(int arg0);   /* salloc */
void iSNDfreechan(int arg0);   /* salloc */
void iSNDgetchan(int arg0);   /* salloc */
void iSNDplatform3dpos(int arg0);   /* s3dpos */
void iSNDpatchkey(int arg0);   /* spatkey */
void iSNDcalcvol(int arg0);   /* spatkey */
void iSNDpsxkeyon(int arg0);   /* spatkey */
void iSNDpsxkeyoff(int arg0);   /* spatkey */
void iSNDpsxeffecton(int arg0);   /* spatkey */
void iSNDpsxeffectoff(int arg0);   /* spatkey */
void iSNDpsxeffectvol(int arg0);   /* spatkey */
void iSNDsetvol(int arg0);   /* spatkey */
void iSNDsetslot(int arg0);   /* spatkey */
void iSNDstartvoice(int arg0);   /* spatkey */
void iSNDplatformoutputcaps(void * arg0);   /* slib */
void iSNDplatformoutputset(void * arg0);   /* slib */
void iSNDinit(void * arg0);   /* slib */
void iSNDrestore();   /* slib */
void iSNDserve();   /* slib */
void iSNDstop(int arg0);   /* sdriver */
void iSNDplatformpitch(int arg0);   /* sdriver */
void iSNDplatformfxlevel(int arg0);   /* sdriver */
void iSNDvol(void * arg0);   /* sdriver */
void SNDI_mutexalloc();   /* sdfx */
void SNDI_mutexfree();   /* sdfx */
void SNDI_mutexlock();   /* sdfx */
void SNDI_mutexunlock();   /* sdfx */
void iSNDpsxfxinit(int arg0);   /* sdfx */
void iSNDplatformfxinit(int arg0);   /* sdfx */
void iSNDplatformfxmasterlevel(int arg0);   /* sfxlevel */
void SNDfxlevel(int arg0);   /* sfxlevel */
void iSNDdetunetolinear(int arg0);   /* sclcptch */
void iSNDcalcpitch(int arg0);   /* sclcptch */
void iSNDresetpatch(void * arg0);   /* stagpat */
void iSNDresettimbre(void * arg0);   /* stagpat */
void iSNDresolveheader(void * arg0);   /* stagpat */
void iSNDfindfreekey(int arg0);   /* stagpat */
void iSNDplaytaggedtimbre(int arg0);   /* stagpat */
void iSNDplaytaggedpatch(void * arg0);   /* stagpat */
void iSNDresolvetaggedpatch(void * arg0);   /* stagpat */
void iSNDremovetaggedpatch(void * arg0);   /* stagpat */
void iSNDdownloadbank(void * arg0);   /* sbdload */
void iSNDbankalloc();   /* sballoc */
void SNDgetvol(int arg0);   /* sgetvol */
void iSNDpacketplayoverhead(int arg0);   /* spktplay */
void SNDPKTPLAY_overhead(int arg0);   /* spktplay */
void SNDPKTPLAY_create(void * arg0);   /* spktplay */
void SNDPKTPLAY_start(int arg0);   /* spktplay */
void SNDPKTPLAY_submit(int arg0);   /* spktplay */
void SNDPKTPLAY_submitspace(int arg0);   /* spktplay */
void SNDPKTPLAY_unsafeframesoutstanding(int arg0);   /* spktplay */
void SNDPKTPLAY_framesoutstanding(int arg0);   /* spktplay */
void SNDPKTPLAY_purge(int arg0);   /* spktplay */
void SNDPKTPLAY_stop(int arg0);   /* spktplay */
void SNDPKTPLAY_destroy(int arg0);   /* spktplay */
void iSNDpacketget(int arg0);   /* spktplay */
void iSNDpacketfreeframes(int arg0);   /* spktplay */
void iSNDmulu64(void * arg0);   /* smath64 */
void iSNDdivu64(int arg0);   /* smath64 */
void iSNDstreamgetrequestptr(int arg0);   /* sstgetrp */
void SNDattributessetdef(void * arg0);   /* spat2hdr */
void iSNDpatchtohdr(void * arg0);   /* spat2hdr */
void iSNDpacketgetirq();   /* sdpacket */
void iSNDpacketsetirq();   /* sdpacket */
void iSNDpacketirqcallback();   /* sdpacket */
void iSNDpsxzerospu(void * arg0);   /* sdpacket */
void iSNDpacketpurgeframes(int arg0);   /* sdpacket */
void iSNDfillspuwithpackets(int arg0);   /* sdpacket */
void iSNDpacketserve();   /* sdpacket */
void iSNDplatformpacketoverhead();   /* sdpacket */
void iSNDplatformcalcdatarate(void * arg0);   /* sdpacket */
void iSNDplatformpacketplaycreate(int arg0);   /* sdpacket */
void iSNDplatformpacketplaydestroy(int arg0);   /* sdpacket */
void iSNDplatformpacketplay(char arg0);   /* sdpacket */
void iSNDpsxpacketstop(void * arg0);   /* sdpacket */
void iSNDserveraddclient(void * arg0);   /* ssysserv */
void iSNDserverremoveclient(void * arg0);   /* ssysserv */
void SNDSYS_service();   /* ssysserv */
void iSNDtimeremaining(int arg0);   /* sdtimrem */
void iSNDmemconstrain(int * arg0);   /* smemman */
void iSNDmeminit(void * arg0);   /* smemman */
void iSNDmemrestore();   /* smemman */
void iSNDmalloc(int arg0);   /* smemman */
void iSNDplatformcdpanvol(int arg0);   /* sdcdvol */
void iSNDpsxmemconstrain(int * arg0);   /* sdmemman */
void iSNDpsxmalloc(int arg0);   /* sdmemman */
void iSNDpsxfree(int arg0);   /* sdmemman */
void iSNDdmtransfer();   /* sdma */
void iSNDdmcallback();   /* sdma */
void iSNDdmservice(void * arg0);   /* sdma */
void iSNDdmqueue(void * arg0);   /* sdma */
void iSNDdmqueuesplit(void * arg0);   /* sdma */
void iSNDdmcomplete(int arg0);   /* sdma */
void iSNDabs(int arg0);   /* saetodv */
void iSNDatodlrv(int arg0);   /* saetodv */
void iSNDatolrv(int arg0);   /* saetolrv */
void iSNDplatformresolve(void * arg0);   /* sdresolv */
void iSNDplatformremove(void * arg0);   /* sdresolv */
void iSNDplatformplay(void * arg0);   /* sdplapat */
void randrange(int arg0);   /* srrange */
void iSNDgettag(void * arg0);   /* sgettag */
void iSNDrandom();   /* srandom */
void iSNDpsxenablespuirq();   /* sdspuirq */
void iSNDpsxdisablespuirq();   /* sdspuirq */
void iSNDpvtolrv(int arg0);   /* spvtolrv */
void iSNDlibatodlrv(int arg0);   /* saelib */
void iSNDgetdata(void * arg0);   /* sgetdata */
void iSNDsin(int arg0);   /* ssine */
/* -- SPCHPSXZ -- */
void VoxEvent_GetFilterLengthFlag(void * arg0);   /* spchevnt */
void VoxEvent_GetKeepTillExpiresFlag(void * arg0);   /* spchevnt */
void iSPCH_GetOffset16(void * arg0);   /* spchevnt */
void iSPCH_SearchEventDat(void * arg0);   /* spchevnt */
void iSPCH_FindEvent(int arg0);   /* spchevnt */
void iSPCH_InitEventDat();   /* spchevnt */
void GetFilterLength();   /* spchevnt */
void GetFilterPriority();   /* spchevnt */
void iSPCH_InitEventQueue();   /* spchevnt */
void iSPCH_FindEventSlot(int arg0);   /* spchevnt */
void SPCH_AddEvent(void * arg0);   /* spchevnt */
void iSPCH_ChooseEvent(void * arg0);   /* spchevnt */
void SPCH_ClearEventQueue();   /* spchevnt */
void iSPCH_ClearOldEvents(int arg0);   /* spchevnt */
void SPCH_PlaySpeech(void * arg0);   /* spchevnt */
void SPCH_ChooseSpeech(void * arg0);   /* spchevnt */
void iSPCH_InitBanks();   /* spchbank */
void iSPCH_DisposeBanks();   /* spchbank */
void iSPCH_BankMemAlloc(int arg0);   /* spchbank */
void iSPCH_GetFreeBank();   /* spchbank */
void iSPCH_FindBank(int arg0);   /* spchbank */
void iSPCH_TestSubBankBounds(int arg0);   /* spchbank */
void iSPCH_SetCycleBits(void * arg0);   /* spchbank */
void SPCH_AddBank(void * arg0);   /* spchbank */
void iSPCH_MemAlloc(int arg0);   /* spchinit */
void iSPCH_MemFree(void * arg0);   /* spchinit */
void SPCH_Deinit();   /* spchinit */
void iSPCH_InitInGame();   /* spchinit */
void SPCH_GetSampleDataRate(int arg0);   /* spchinit */
void SPCH_InitBankMem(void * arg0);   /* spchinit */
void SPCH_Init(void * arg0);   /* spchinit */
void iSPCH_EACrandom();   /* spchrand */
   /* spchrand */
void iSPCH_Rand(int arg0);   /* spchrand */
void iSPCH_BindData(void * arg0);   /* spchrand */
void SPCH_ResolveData(void * arg0);   /* spchrslv */
void iSPCH_GetMatchValue(void * arg0);   /* spchdata */
void VoxSentence_GetShortRule(void * arg0);   /* spchdata */
void VoxSentence_GetNumPhrases(byte * arg0);   /* spchdata */
// dup: void VoxEvent_GetFilterLengthFlag(void * arg0);   /* spchdata */
void iSPCH_GetOffset8(void * arg0);   /* spchdata */
// dup: void iSPCH_GetOffset16(void * arg0);   /* spchdata */
void iSPCH_MatchSample(int arg0);   /* spchpick */
void iSPCH_GetPhraseBank(void * arg0);   /* spchpick */
void iSPCH_GetBankBits(void * arg0);   /* spchpick */
void iSPCH_ClearCycleBit(void * arg0);   /* spchpick */
void iSPCH_CheckBankBit(void * arg0);   /* spchpick */
void iSPCH_CheckTemplateSample(void * arg0);   /* spchpick */
void iSPCH_SampleExists(void * arg0);   /* spchpick */
void iSPCH_ChooseSamples(void * arg0);   /* spchpick */
void iSPCH_SampleLength(void * arg0);   /* spchpick */
void iSPCH_ConvertTime(int arg0);   /* spchpick */
void iSPCH_SentenceLength(void * arg0);   /* spchpick */
void iSPCH_OrderSentences(void * arg0);   /* spchpick */
void iSPCH_RepeatEvent(void * arg0);   /* spchpick */
void iSPCH_ShortRuleStatus(void * arg0);   /* spchpick */
void iSPCH_SentenceGetChoices(void * arg0);   /* spchpick */
void iSPCH_RandomizeSentencePicks(void * arg0);   /* spchpick */
void iSPCH_IterateChoice(void * arg0);   /* spchpick */
void iSPCH_ChooseShortSentence(int arg0);   /* spchpick */
void iSPCH_SentenceMakeChoice(void * arg0);   /* spchpick */
void iSPCH_ConstantRuleSet(void * arg0);   /* spchpick */
void iSPCH_MakeSampleRequests(void * arg0);   /* spchpick */
void iSPCH_ClearChosen();   /* spchpick */
void iSPCH_SaveChosenSentence(void * arg0);   /* spchpick */
void iSPCH_OneChosen();   /* spchpick */
void iSPCH_PlayChosen(void * arg0);   /* spchpick */
void iSPCH_ChooseSentence(void * arg0);   /* spchpick */
void SPCH_SetPreLoadTicks(int arg0);   /* spchpick */
// dup: void VoxSentence_GetNumPhrases(void * arg0);   /* spchrule */
// dup: void iSPCH_GetOffset8(void * arg0);   /* spchrule */
// dup: void iSPCH_GetOffset16(void * arg0);   /* spchrule */
void iSPCH_GetRuleDataAddr(void * arg0);   /* spchrule */
void iSPCH_SentenceUsesParm(int arg0);   /* spchrule */
void iSPCH_GetRuleID(int arg0);   /* spchrule */
void iSPCH_RuleSet(void * arg0);   /* spchrule */
void iSPCH_GetRuleSettings(void * arg0);   /* spchrule */
void iSPCH_CheckSentenceRules(int arg0);   /* spchrule */
void iSPCH_InitSample(void * arg0);   /* spchsamp */
void iSPCH_UnPackSample(void * arg0);   /* spchsamp */

#endif
