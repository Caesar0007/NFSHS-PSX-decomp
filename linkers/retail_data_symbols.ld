/*
 * Retail data/BSS aliases recovered from NFS4.MAP and nfs4-f-v3.txt.
 *
 * The corresponding bytes/storage are already owned by the raw data/BSS
 * sections in nfs4.ld.  These PROVIDE declarations restore the linker-visible
 * names needed by code relocations without allocating duplicate storage.  A
 * future reconstructed vars/data TU may define any name normally; PROVIDE
 * deliberately yields to that real definition.
 */
/* FRONTEND/PSX/ADDRESS.ASM overlay boundaries.  NFS4.MAP and the compact
 * SYM records agree on the exact start/end/size values; address.obj stores
 * relocations to these linker-owned symbols rather than allocating them. */
PROVIDE(_front_obj = 0x80010000);
PROVIDE(_front_objend = 0x80054548);
PROVIDE(_front_org = 0x80010000);
PROVIDE(_front_orgend = 0x80054548);
PROVIDE(_front_size = 0x00044548);

PROVIDE(gPadinfo = 0x8013E89C);
PROVIDE(Padglobal = 0x8013E8F0);
PROVIDE(memclass = 0x8013E900);
PROVIDE(D_8013EAD8 = 0x8013EAD8);
PROVIDE(sndss = 0x8013EA80);
PROVIDE(_que = 0x8013EC00);
PROVIDE(readcmd = 0x80140400);
PROVIDE(currentdirectory = 0x80140414);
PROVIDE(StFunc1 = 0x80144874);
PROVIDE(StFunc2 = 0x80144878);
PROVIDE(StEmu_Addr = 0x80146C7C);
PROVIDE(StCdIntrFlag = 0x80146C80);
PROVIDE(CChannel = 0x80146C84);
PROVIDE(StCHANNEL = 0x80146C88);
PROVIDE(Stframe_no = 0x80146C8C);
PROVIDE(StRgb24 = 0x80146C90);
PROVIDE(StEndFrame = 0x80146C94);
PROVIDE(StSTART_FLAG = 0x80146C98);
PROVIDE(StEmu_Idx = 0x80146C9C);
PROVIDE(Stsector_offset = 0x80146CA0);
PROVIDE(StFinalSector = 0x80146CA4);
PROVIDE(StRingBase = 0x80146CA8);
PROVIDE(StRingAddr = 0x80146CAC);
PROVIDE(StRingIdx1 = 0x80146CB0);
PROVIDE(StRingIdx2 = 0x80146CB4);
PROVIDE(StRingIdx3 = 0x80146CB8);
PROVIDE(StRingSize = 0x80146CBC);
PROVIDE(StStartFrame = 0x80146CC0);
PROVIDE(mutexbuf = 0x801477E0);
PROVIDE(sndgs = 0x80147860);
PROVIDE(D_80147871 = 0x80147871);
PROVIDE(D_80147898 = 0x80147898);
PROVIDE(sndchanreserved = 0x80147914);
PROVIDE(sndpd = 0x80147918);
PROVIDE(D_801479F0 = 0x801479F0);
PROVIDE(D_80147E34 = 0x80147E34);
PROVIDE(gPreLoadTicks = 0x80148044);
PROVIDE(gEventDats = 0x80148048);
PROVIDE(gVoxInGame = 0x80148058);
PROVIDE(gVoxEvents = 0x80148060);
PROVIDE(gGameNum = 0x80148428);
PROVIDE(gFilterSetting = 0x8014842C);
PROVIDE(gLastSubTick = 0x80148430);
PROVIDE(gDataRate = 0x80148434);
PROVIDE(gLastTick = 0x80148438);
PROVIDE(gSentenceChoice = 0x8014843C);
PROVIDE(ispch_gPickSamples = 0x8014847C);
PROVIDE(ispch_gChoice = 0x801484E4);
PROVIDE(sndpps = 0x80148574);
PROVIDE(sndpp = 0x80148578);
PROVIDE(currentwindow = 0x801486E4);
PROVIDE(sndmm = 0x80148780);
PROVIDE(D_8014899C = 0x8014899C);
PROVIDE(D_801489A4 = 0x801489A4);
PROVIDE(D_801489AC = 0x801489AC);
PROVIDE(D_801489B4 = 0x801489B4);
PROVIDE(D_801489B8 = 0x801489B8);
PROVIDE(D_801489BC = 0x801489BC);
PROVIDE(StMode = 0x801489CC);
PROVIDE(_waitTime = 0x80148AAC);
PROVIDE(_startTime = 0x80148AB0);
PROVIDE(D_80148AC4 = 0x80148AC4);
PROVIDE(D_80148AD4 = 0x80148AD4);
