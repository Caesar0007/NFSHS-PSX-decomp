/* frontend/common/fememcard.cpp -- RECONSTRUCTED (FE memory-card save/load + dialogs; C++ TU)
 *   18 FREE fns (namespace nfs4::FRONTEND::COMMON::FEMemCard). Init/DeInit_Memcard tails
 *   rebuilt from m2c (Ghidra truncated to do{}while(true)). Dialog base-hierarchies routed.
 */
#include "fememcard.h"

/* ---- FEMemCard.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes / .bss zero;
   productCode="SLUS-00826" = the retail PSX game ID; textSysMemCardFail_Index = fail-message LUT).
   Only the 4 externed-not-defined gaps (nm-confirmed); TITLE/nomessage/MEMCARD_INITIALIZED are
   already defined elsewhere. ---- */
/* CURRENTPLAYER is declared (unsized-array form) in fememcard_externs.h; defined in another obj.
   Unsized-array + [0] access makes the int-value load into an ARG reg use the oracle's SEPARATE v0
   scratch (lui v0; lw a0,(v0)) rather than dest-as-temp (lui a0; lw a0,(a0)); §3.15-CORRECTION. */
char         productCode[11] = { 83, 76, 85, 83, 45, 48, 48, 56, 50, 54, 0 };   /* @0x80051a6c */
/* CURRENTLYUSINGMEMCARD @0x80051a7c (bss(zero)) -- REAL TYPE IS A 4-BYTE BOOL: every oracle
   access in the whole front overlay is a WORD op (7 lw / 6 sw, zero byte ops), and the next
   symbol sits at +4 (0x80051a80). The shared fememcard_externs.h declares it `char` (HEADER
   WISH) -- define through an asm-label int alias; section(".bss") keeps it out of .sbss
   (oracle addresses it absolutely, not gp-rel). */
int          CURRENTLYUSINGMEMCARD_word asm("CURRENTLYUSINGMEMCARD") __attribute__((section(".bss")));
int          textSysMemCardFail_Index[7] = { 0, 677, 685, 675, 811, 671, 669 };   /* @0x80051a84 */

/* [HEADER WISH -- TU-local TRUE-TYPE redeclarations via asm labels; the shared headers declare
   these with the wrong C type and can't be edited from this worktree.]
   - ticks IS volatile (written by the Clock_MasterInterruptHandler IRQ timer behind the
     compiler's back): the plain `int ticks` decl lets gcc constant-fold the memcard wait loops
     into INFINITE loops (li v0,1; bnez -- real bug) and blocks the oracle's per-iteration
     reload + hoisted %hi base.
   - MEMCARD_INITIALIZED / MEMCARDFRONTENDISINITTED are 4-byte BOOLs (SYM; oracle uses lw/sw
     word ops), declared `char` in fememcard_externs.h. */
extern volatile int ticks_vol            asm("ticks");
extern int          MEMCARD_INITIALIZED_word asm("MEMCARD_INITIALIZED");
extern int          MEMCARDFRONTENDISINITTED_word asm("MEMCARDFRONTENDISINITTED");
/* base-class vtables for the inlined WarningDialog ctor chains (declared in feapp_externs.h
   for other TUs; TU-local externs here) */
extern __vtbl_ptr_type tDialogBase_vtable[], tDialogMessageString_vtable[];
/* [HEADER WISH] Stats_gTrackRecords is an ARRAY (oracle materializes its ADDRESS, addiu --
   never loads a pointer value); fememcard_externs.h declares `int *` -- asm-label redecl. */
extern int Stats_gTrackRecords_arr[] asm("Stats_gTrackRecords");
/* unsized-array views of the TU's word BOOL globals (3.12 #5): array element access makes the
   %hi an RTL pseudo -- separate scratch + CSE-able across read+write (the oracle's shared
   lui base + split stores; scalar form emits macro lw/sw -> self-temp + $at). */
extern volatile int ticks_arr[] asm("ticks");
extern int nomessage_arr[] asm("nomessage");
extern int MEMCARD_INITIALIZED_arr[] asm("MEMCARD_INITIALIZED");
extern int CURRENTLYUSINGMEMCARD_arr[] asm("CURRENTLYUSINGMEMCARD");
extern int MEMCARDFRONTENDISINITTED_arr[] asm("MEMCARDFRONTENDISINITTED");


/* ---- ChecksumData  [FEMEMCARD.CPP:63-70] ---- */

void ChecksumData(tMemCardData *memCardData)

{
  u_long uVar1;
  
  memCardData->fSize = 0x14ac;
  uVar1 = crc16(&memCardData->frontEnd,0x450);
  memCardData->frontEndCRC = uVar1;
  uVar1 = crc16(&memCardData->carInfo,0xe0);
  memCardData->carInfoCRC = uVar1;
  uVar1 = crc16(&memCardData->trackInfo,0x10);
  memCardData->trackInfoCRC = uVar1;
  uVar1 = crc16(&memCardData->tournament,0xb0);
  memCardData->tournamentCRC = uVar1;
  uVar1 = crc16(memCardData->records,0xe9c);
  memCardData->recordsCRC = uVar1;
  return;
}



/* ---- VerifySuccessfulRead  [FEMEMCARD.CPP:75-86] ---- */

bool VerifySuccessfulRead(tMemCardData *memCardData)

{
  bool result;
  u_long uVar1;

  /* MATCH: `(cmp) & result` BOOL-accumulation form (SYM: result BOOL) -- the oracle re-masks
     the stored bool in each beq delay slot (andi s0,s0,1 = the fold of `1 & result` on the equal path
     -- BITWISE &, not &&: && normalizes via sltu) then clears on fall-through; a plain
     `if (x != crc) result = false;` chain emits no andi and mis-colors s0/s1. */
  uVar1 = crc16(&memCardData->frontEnd,0x450);
  result = memCardData->frontEndCRC == uVar1;
  uVar1 = crc16(&memCardData->carInfo,0xe0);
  result = (memCardData->carInfoCRC == uVar1) & result;
  uVar1 = crc16(&memCardData->trackInfo,0x10);
  result = (memCardData->trackInfoCRC == uVar1) & result;
  uVar1 = crc16(&memCardData->tournament,0xb0);
  result = (memCardData->tournamentCRC == uVar1) & result;
  uVar1 = crc16(memCardData->records,0xe9c);
  result = (memCardData->recordsCRC == uVar1) & result;
  result = (memCardData->fSize == 0x14ac) & result;
  return result;
}



/* ---- MakeWayForMemoryCard  [FEMEMCARD.CPP:90-100] ---- */

void MakeWayForMemoryCard(void)

{
  deltimer(Clock_MasterInterruptHandler);
  return;
}



/* ---- BringThatBeatBack  [FEMEMCARD.CPP:108-110] ---- */

void BringThatBeatBack(void)

{
  addtimer(Clock_MasterInterruptHandler);
  return;
}



/* ---- Confirm  [FEMEMCARD.CPP:124-168] ---- */

int Confirm(int Text,int yesText)

{
  bool putbackon;         /* SYM: REG BOOL $s3 */
  short sVar4;
  int num, yes;
  char *pcVar5;
  int ret;                /* SYM: REG INT $s2 (reuses Text's reg) */

  BringThatBeatBack();
  /* [2026-07-11 consolidation] dropped REDUNDANT tDialogYesNo_ctor((tDialogYesNo*)&MyDialog)
     manual call + manual _vf poke: tDialogYesNoMem derives from tDialogYesNo (real declared
     ctor), so the implicit ctor already emits jal __12tDialogYesNo + the tDialogYesNoMem
     vtable store (oracle Confirm__Fii shows exactly ONE ctor jal). tDialogYesNo_ctor is an
     undefined phantom extern (same class as the femenudefs.cpp sweep). */
  /* [block-scope fix] MyDialog's decl moved AFTER BringThatBeatBack(): oracle's jal
     BringThatBeatBack precedes the jal __12tDialogYesNo ctor -- the object's ctor fires at
     its point of declaration (C++), so the real source declares it here, not at fn-top. */
  tDialogYesNoMem MyDialog;
  tDialogYesNoMem *dlg = &MyDialog;
  /* [2026-07-11 RESTORE] the manual _vf poke was WRONGLY dropped in the wave-5 consolidation:
     this hierarchy uses MANUAL _vf dispatch (not real C++ virtuals), so the implicit
     tDialogYesNoMem ctor does NOT set the derived vtable -- gcc's synthesized ctor only calls
     the base tDialogYesNo ctor. The oracle explicitly stores &_vt_15tDialogYesNoMem to _vf(0x60)
     right after the ctor (`sw v0,0x60(s0)`). Restore it. */
  dlg->_vf = (__vtbl_ptr_type (*)[10])tDialogYesNoMem_vtable;
  putbackon = false;
  /* MATCH: pointer-local for the NoInput dialog (SYM shows an inlined tDialogBase-`this` block
     in $a0 here) -- oracle computes base+720 ONCE (addiu a0,v1,720), tests currentlyOn via
     112(a0), reuses a0 for Hide; a direct member test loads 832(base) then recomputes.
     (Hoisting this decl above the _vf store recolors the head -- tried, 21->38, reverted.) */
  {
    tDialogNoInputMessage *noInput = &FEApp[0]->NoInputMemCardDialog;
    if (noInput->currentlyOn != 0) {
      Hide((tDialogBase *)noInput);
      putbackon = true;
    }
  }
  dlg->string =
       TextSys_Word(Text);
  dlg->yesnowords[1] = 0x292;
  dlg->yesnowords[0] = yesText;
  dlg->fDefault = 0;
  if (frontEnd.language == '\x03') {
    dlg->OffsetX = 0;
    dlg->OffsetY = 10;
  }
  sVar4 = Run((tDialogInteractive *)dlg);
  ret = (int)sVar4;
  if (ret == -1) {
    /* MATCH: dlgmsg pointer computed BEFORE the TextSys_Word call and HELD across it in a
       callee-saved reg (SYM: inlined tDialogMessageString-`this` block, $s0; oracle
       lw s0,0(s1) + addiu s0,s0,568 in the jal delay slot); the Display arg is a FRESH
       FEApp re-deref (selective/partial caching -- oracle recomputes it). */
    tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
    pcVar5 = TextSys_Word(CURRENTPLAYER[0] + 0x32b);
    dlgmsg->string = pcVar5;
    Display((tDialogBase *)&FEApp[0]->MemCardDialog);
    /* MATCH: exit-in-the-middle wait loop (top-test + j back); the ==1 exit is written `^ 1`
       so it emits the oracle's xori;beqz -- an `== 1` compare makes gcc hoist li 1 into a
       call-surviving saved reg (loop-invariant) and beq against it. */
    while (true) {
      if (((FEApp[0]->MemCardDialog).fFullyOpen ^ 1) == 0) break;
      Redraw(FEApp[0]);
    }
    Redraw(FEApp[0]);
    nomessage_arr[0] = 1;   /* per-arm inline store; gcc cross-jumps it into the ret==0 arm's tail */
  }
  else if (ret == 0) {
    /* MATCH arm order: oracle bnez s2 jumps the putbackon arm OUT-OF-LINE; nomessage=1 is the
       fall-through (li v0,1; sw in the j delay slot). */
    nomessage_arr[0] = 1;
  }
  else if (putbackon) {
    Display((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
    while (true) {
      if (((FEApp[0]->NoInputMemCardDialog).fFullyOpen ^ 1) == 0) break;   /* xori;beqz, see above */
      Redraw(FEApp[0]);
    }
  }
  Redraw(FEApp[0]);
  MakeWayForMemoryCard();
  /* [phantom-dtor drop] MyDialog is function-scoped (single return path below); implicit dtor
     auto-fires here, matching oracle's ___7tScreen call right before the epilogue. */
  return ret;
}



/* ---- OverwriteConfirm  [FEMEMCARD.CPP:171-180] ---- */

int OverwriteConfirm(void)

{
  int iVar1;
  
  iVar1 = Confirm(CURRENTPLAYER[0] + 0x323,0x28f);
  return iVar1;
}



/* ---- OverwriteAlwaysYes  [FEMEMCARD.CPP:184-185] ---- */

int OverwriteAlwaysYes(void)

{
  return 1;
}



/* ---- FormatConfirm  [FEMEMCARD.CPP:191-204] ---- */

int FormatConfirm(void)

{
  int iVar1;
  
  iVar1 = Confirm(CURRENTPLAYER[0] + 0x327,0x290);
  return iVar1;
}



/* ---- LoadingProc  [FEMEMCARD.CPP:209-213] ---- */

void LoadingProc(void)

{
  return;
}



/* ---- LoadingRedrawProc  [FEMEMCARD.CPP:217-221] ---- */

void LoadingRedrawProc(void)

{
  Redraw(FEApp[0]);
  return;
}



/* ---- SavingProc  [FEMEMCARD.CPP:226-230] ---- */

void SavingProc(void)

{
  Redraw(FEApp[0]);
  return;
}



/* ---- Init_Memcard  [FEMEMCARD.CPP:240-316] ---- */
void Init_Memcard(bool redraw,bool pinkslips)
{
  int padrestorestarttick;
  MCRDOPTS_def mcrdopts;

  /* unsized-array true-type views (see the asm-label block at file top) */
  if (MEMCARD_INITIALIZED_arr[0] != 0) {
    return;
  }
  MEMCARD_INITIALIZED_arr[0] = 1;
  if (MEMCARDFRONTENDISINITTED_arr[0] != 0) {
    AudioMus_StopSong(0);
    timedwait(5);
  }
  PAD_restore();
  padrestorestarttick = ticks_arr[0];
  do { } while (ticks_arr[0] - padrestorestarttick < 0x3c);
  deltimer(Clock_MasterInterruptHandler);
  timedwait(0x14);
  MCRD_init(0);
  MCRD_getopts(&mcrdopts);
  mcrdopts.productLocation = (PRODUCTLOC)0;
  mcrdopts.productCode = productCode;
  mcrdopts.bMoveIconsToVram = 0;
  mcrdopts.VramIconArea.x = 0x200;
  mcrdopts.VramIconArea.y = 0x100;
  mcrdopts.VramIconArea.w = 0x20;
  mcrdopts.VramIconArea.h = 0x60;
  mcrdopts.ConfirmFormatProc = (void *)FormatConfirm;
  mcrdopts.ConfirmOverwriteProc = (void *)(pinkslips ? OverwriteAlwaysYes : OverwriteConfirm);
  mcrdopts.LoadingDataProc = (void *)(redraw ? LoadingRedrawProc : LoadingProc);
  mcrdopts.SavingDataProc = (void *)SavingProc;
  /* residual 4: gcc schedules the &mcrdopts addiu early vs oracle's jal-slot placement --
     scheduling tie (pointer-temp form tried, no change) */
  MCRD_setopts(&mcrdopts);
  addtimer(Clock_MasterInterruptHandler);
  timedwait(0x14);
  padinit();
  timedwait(0x14);
  return;
}

/* ---- DeInit_Memcard  [FEMEMCARD.CPP:321-351] ---- */
void DeInit_Memcard(void)
{
  int padrestorestarttick;

  /* true-type TU-local redecls (see the asm-label block at file top) */
  if (MEMCARD_INITIALIZED_arr[0] == 0) {
    return;
  }
  MEMCARD_INITIALIZED_arr[0] = 0;
  deltimer(Clock_MasterInterruptHandler);
  MCRD_restore();
  addtimer(Clock_MasterInterruptHandler);
  PAD_restore();
  padrestorestarttick = ticks_arr[0];
  do { } while (ticks_arr[0] - padrestorestarttick < 0xc0);
  padinit();
  /* [header wish] see Init_Memcard -- MEMCARDFRONTENDISINITTED is a 4-byte value, cast locally. */
  if (*(int *)&MEMCARDFRONTENDISINITTED != 0) {
    UpdateMusic(FEApp[0]);
  }
  return;
}

/* ---- Init_MemcardFile__FR12MCRDFILE_defsb  [FEMEMCARD.CPP:357-381] ---- */

extern "C" void Init_MemcardFile__FR12MCRDFILE_defsb(MCRDFILE_def *memCardFile,short cardnum,bool notitle)

{
  void *pvVar1;
  char *pcVar2;
  char *pcVar3;
  
  blockclear(memCardFile,0x2c);
  memCardFile->name = "NFS4";
  /* [branch-polarity fix] oracle's beqz skips the (rare) notitle==true case out-of-line and
     falls straight through the common PlayerNameExist path -- arm order flipped to match
     (catalog wave-3 "if/else ARM ORDER controls beqz/bnez polarity" row). */
  if (notitle) {
    TITLE[0] = '\0';
  }
  else {
    pvVar1 = PlayerNameExist((uint)(cardnum == 5));
    if (pvVar1 != (void *)0x0) {
      pcVar2 = TextSys_Word(0x278);
      pcVar3 = PlayerName((uint)(cardnum == 5));
      sprintf(TITLE,"%s%s",pcVar2,pcVar3);
    }
    else {
      pcVar2 = TextSys_Word(0x279);
      sprintf(TITLE,pcVar2);
    }
  }
  memCardFile->title = TITLE;
  memCardFile->size = 0x1500;
  memCardFile->offset = 0;
  memCardFile->flags = 0;
  return;
}



/* ---- SaveGame  [FEMEMCARD.CPP:395-583] ---- */

void * SaveGame(short player)

{
  /* SYM reg map: finished=s3(BOOL) event=s0 returnvalue=s6(BOOL) returnmessage=s2
     shapeFile=s7(char*); cardNum = AUTO SHORT (stack, sp+0x16C8); i = block-scoped a2;
     player REGPARM s5. */
  tMemCardData memCardData;
  char memorycardbuffer [256];

  CURRENTPLAYER[0] = player;
  CURRENTLYUSINGMEMCARD_arr[0] = 1;
  {
    int i;
    /* MATCH: index-form AnalogOn[i] (strength-reduces to the oracle's +4 walker);
       (i != 0) * 4 keeps the sltu index-select. Set-then-conditional-reset pair. */
    for (i = 0; i < 2; i++) {
      frontEnd.AnalogOn[i] = 1;
      if (gPadinfo.buf[(uint)(i != 0) * 4].ID != 's') {
        frontEnd.AnalogOn[i] = 0;
      }
    }
  }
  /* [block-scope fix] WarningDialog declared AFTER the loop (oracle jal __7tScreen position);
     decl order WarningDialog/cardNum/memCardFile/shapeFileName = SYM stack layout. Manual _vf
     init chain in oracle store order (see LoadGame). */
  tDialogNoInputMessage WarningDialog;
  short cardNum;
  MCRDFILE_def memCardFile;
  char *shapeFile;
  char shapeFileName [64];
  bool finished;
  int event;
  bool returnvalue;
  int returnmessage;
  /* MATCH: wd = CSE of &WarningDialog across the ctor/TextSys calls (hold-addr, s0): the
     oracle stores the three non-zero-constant fields through s0 and takes both call args
     from it; zeros/vt stay sp-direct. */
  tDialogNoInputMessage *wd = &WarningDialog;
  WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogBase_vtable;
  WarningDialog.currentlyOn = 0;
  WarningDialog.reservedheight = 0;
  WarningDialog.MaxH = 0;
  WarningDialog.OffsetY = 0;
  WarningDialog.OffsetX = 0;
  WarningDialog.height = 0;
  WarningDialog.width = 0;
  WarningDialog.top = 0;
  WarningDialog.left = 0;
  wd->MaxW = 0x120;
  wd->specificPlayer = -1;
  WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogMessageString_vtable;
  WarningDialog.fDefault = 0;
  WarningDialog.timeOutTicks = 0;
  WarningDialog.Centerit = 0;
  WarningDialog.fFullyOpen = 0;
  /* MATCH: adjacent identical double store survives via volatile (catalog F(c)) */
  *(volatile long *)&WarningDialog.timeOutTicks = 0;
  wd->fFadeText = 0x80;
  WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
  WarningDialog.string = TextSys_Word(player + 0x276);
  WarningDialog.OffsetX = 0;
  WarningDialog.OffsetY = 0x32;
  Display((tDialogBase *)wd);
  while (true) {
    if ((WarningDialog.fFullyOpen ^ 1) == 0) break;   /* xori;beqz -- see Confirm */
    Redraw(FEApp[0]);
  }
  finished = false;
  returnvalue = finished;   /* oracle: addu s6,s3,zero -- the false is a COPY of finished */
  returnmessage = 0x28b;
  Redraw(FEApp[0]);
  cardNum = player * 4 + 1;
  nomessage_arr[0] = 0;
  MakeWayForMemoryCard();
  Init_MemcardFile__FR12MCRDFILE_defsb(&memCardFile,cardNum,false);
  memCardFile.pData = (u_char *)&memCardData;
  while (MCRD_handlecardevents(cardNum) == 0x15) {
    VSync(0);
  }
  blockmove(&frontEnd,&memCardData.frontEnd,0x450);
  SaveTournament(&tournamentManager,&memCardData.tournament);
  SaveTracks(&trackManager,&memCardData.trackInfo);
  SaveCars(&carManager,&memCardData.carInfo);
  blockmove(Stats_gTrackRecords_arr,memCardData.records,0xe9c);
  memCardData.pinkSlipsNoCheat = rand();
  FECheat_SaveBonus(&memCardData.bonus);
  sprintf(shapeFileName,"%szMem.psh",Paths_Paths[0x20]);
  shapeFile = (char *)loadshapeadr(shapeFileName,(void *)0x0);
  memCardFile.flags = 0x200;
  memCardFile.icon[0] = shapepointer(shapeFile,0);
  memCardFile.icon[1] = (shapetbl *)0x0;
  memCardFile.icon[2] = (shapetbl *)0x0;
  ChecksumData(&memCardData);
  /* switch-loop: real switch, case bodies in oracle VA order (0x16 / 0xc / getcard arm);
     default = re-poll. */
  while (true) {
    if (finished) break;
    event = MCRD_handlecardevents(cardNum);
    systemtask(0);
    VSync(0);
    switch(event) {
    case 0x16:
      if (gMemCardInfo.bReady != 0) {
        MCRD_savefile(cardNum,&memCardFile);
      }
      break;
    case 0xc:
      returnmessage = 0x28b;
      finished = true;
      returnvalue = finished;   /* oracle: addu s6,s3,zero */
      break;
    case 2:
    case 3:
    case 7:
    case 10:
    case 0xb:
    case 0xd:
    case 0x17:
      {
        CARDINFO_def *pCVar4 = MCRD_getcard(player * 4 + 1);
        returnmessage = 0x29d;
        if (pCVar4->status != -3) {
          returnmessage = 0x325;
          if (pCVar4->status == -1) {
            returnmessage = 0x32b;
          }
        }
      }
      finished = true;
      break;
    }
  }
  while (MCRD_handlecardevents(cardNum) != 0x16) {
    VSync(0);
  }
  purgememadr(shapeFile);
  BringThatBeatBack();
  if (nomessage_arr[0] == 0) {
    Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
    /* dlgmsg held across the TextSys call (inlined-this block, s0) */
    tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
    dlgmsg->string = TextSys_Word(returnmessage + player);
    Display((tDialogBase *)&FEApp[0]->MemCardDialog);
    while (true) {
      if (((FEApp[0]->MemCardDialog).fFullyOpen ^ 1) == 0) break;
      Redraw(FEApp[0]);
    }
    Redraw(FEApp[0]);
  }
  screenMemcard->fGetNewIcons = 1;
  Hide((tDialogBase *)&WarningDialog);
  Redraw(FEApp[0]);
  CURRENTLYUSINGMEMCARD_arr[0] = 0;
  /* [phantom-dtor drop] implicit ___7tScreen(&WarningDialog,2) at scope exit */
  return (void *)returnvalue;
}



/* ---- LoadGame__FsbT1  [FEMEMCARD.CPP:591-812] ---- */

extern "C" short LoadGame__FsbT1(short player,bool PinkSlips,bool WithDialogs)

{
  /* SYM reg map: cardNum=s3(SHORT) finished=s1(BOOL) result=s4 memCardResult=s0 count=fp
     returnmessage=s2; pCI + the fail-dialog `this` are block-scoped s0. player/PinkSlips/
     WithDialogs are ARG class (arg-slot spilled, reloaded per use). */
  short cardNum;
  bool finished;
  int result;
  int memCardResult;
  int count;
  int returnmessage;
  int cardshifted;                 /* s5 = (player*4|1) << 16; every card arg = >>16 */
  tMemCardData memCardData;
  char memorycardbuffer [256];
  /* memCardFile declared BELOW, after WarningDialog: gcc-2.8 assigns stack slots in decl
     order ascending -- SYM layout is memCardData / buffer / WarningDialog / memCardFile. */

  cardNum = player * 4 | 1;
  /* [block-scope fix] WarningDialog declared here (oracle jal __7tScreen after the
     CURRENTPLAYER/CURRENTLYUSINGMEMCARD stores); init sequence below = the INLINED
     tDialogBase -> tDialogMessageString -> tDialogNoInputMessage ctor chain, field order
     exactly as the oracle stores it (three successive _vf stores). */
  CURRENTPLAYER[0] = player;
  CURRENTLYUSINGMEMCARD_arr[0] = 1;
  tDialogNoInputMessage WarningDialog;
  MCRDFILE_def memCardFile;
  /* manual _vf init chain (EA manual-vtable doctrine), field order per oracle.
     (NEGATIVE: routing ALL inits through a `wd` base pointer regresses 252->260 -- the
     oracle's s0-based subset (MaxW/specificPlayer/fFadeText) is gcc's own partial CSE of
     the ctor-call arg address, not a source pointer.) */
  WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogBase_vtable;
  WarningDialog.currentlyOn = 0;
  WarningDialog.reservedheight = 0;
  WarningDialog.MaxH = 0;
  WarningDialog.OffsetY = 0;
  WarningDialog.OffsetX = 0;
  WarningDialog.height = 0;
  WarningDialog.width = 0;
  WarningDialog.top = 0;
  WarningDialog.left = 0;
  WarningDialog.MaxW = 0x120;
  WarningDialog.specificPlayer = -1;
  /* inline tDialogMessageString ctor */
  WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogMessageString_vtable;
  WarningDialog.fDefault = 0;
  WarningDialog.timeOutTicks = 0;
  WarningDialog.Centerit = 0;
  WarningDialog.fFullyOpen = 0;
  /* MATCH: adjacent identical double store survives via volatile (catalog F(c); fedialog
     tDialogYesNo ctor precedent) */
  *(volatile long *)&WarningDialog.timeOutTicks = 0;
  WarningDialog.fFadeText = 0x80;
  /* inline tDialogNoInputMessage ctor */
  WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
  if ((WithDialogs != 0) || (PinkSlips != 0)) {
    WarningDialog.string = TextSys_Word(player + 0x276);
    if (PinkSlips == 0) {
      WarningDialog.OffsetX = 0;
      WarningDialog.OffsetY = 0x32;
    }
    Display((tDialogBase *)&WarningDialog);
    while (true) {
      if ((WarningDialog.fFullyOpen ^ 1) == 0) break;   /* xori;beqz -- see Confirm */
      Redraw(FEApp[0]);
    }
    Redraw(FEApp[0]);
  }
  finished = false;
  result = 0;
  count = 0x2c;
  nomessage_arr[0] = 0;
  if (WithDialogs != 0) {
    count = 0;
  }
  returnmessage = 0x28d;
  cardshifted = cardNum << 16;
LoadGame_memcardInit:
  count = count + 1;
  MakeWayForMemoryCard();
  Init_MemcardFile__FR12MCRDFILE_defsb(&memCardFile,(short)(cardshifted >> 0x10),true);
  while (MCRD_handlecardevents(cardshifted >> 0x10) == 0x15) {
    VSync(0);
  }
  memCardFile.pData = (u_char *)&memCardData;
  memCardFile.flags = 0;
  /* switch-loop: real `switch` (gcc emits its own jump table); case bodies in oracle VA
     order -- 0x16 (loadfile), 0xf (verify), getcard arm last; default = re-poll. */
  while (true) {
    if (finished) break;
    memCardResult = MCRD_handlecardevents(cardshifted >> 0x10);
    systemtask(0);
    VSync(0);
    switch(memCardResult) {
    case 0x16:
      MCRD_loadfile(cardshifted >> 0x10,&memCardFile,0);
      break;
    case 0xf:
      if (VerifySuccessfulRead(&memCardData)) {
        result = 0;
        if (PinkSlips == 0) {
          if (player == 0) {
            blockmove(&memCardData.frontEnd,&frontEnd,0x450);
            LoadTournament(&tournamentManager,&memCardData.tournament);
            LoadTracks(&trackManager,&memCardData.trackInfo);
            blockmove(memCardData.records,Stats_gTrackRecords_arr,0xe9c);
            FECheat_LoadBonus(&memCardData.bonus);
          }
          else {
            sprintf(frontEnd.playerNameList[player],memCardData.frontEnd.playerNameList[0]);   /* CORRECTNESS: [player]*8 stride (was [player*4] = *32 OOB) */
          }
          LoadCars(&carManager,&memCardData.carInfo,player);
        }
        else {
          frontEnd.gPinkSlipsNoCheat[player] = memCardData.pinkSlipsNoCheat;
          LoadPinkSlipsCars(&carManager,&memCardData.carInfo,player);
          sprintf(frontEnd.playerNameList[player],memCardData.frontEnd.playerNameList[0]);   /* CORRECTNESS: [player]*8 stride (was [player*4] = *32 OOB) */
          frontEnd.pinkSlipsCash[player] = memCardData.tournament.fSaveMoney;
        }
        returnmessage = 0x28d;
        SetPads();
        finished = true;
      }
      else {
        result = 1;
        if (WithDialogs != 0) {
          if (nomessage_arr[0] == 0) {
            Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
            Hide((tDialogBase *)&FEApp[0]->MemCardDialog);
            /* dlgmsg held across the TextSys call (inlined-this block, s0) */
            tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
            dlgmsg->string = TextSys_Word(player + 0x329);
            Display((tDialogBase *)&FEApp[0]->MemCardDialog);
          }
        }
        finished = true;
      }
      break;
    case 2:
    case 3:
    case 7:
    case 10:
    case 0xb:
    case 0x10:
    case 0x17:
      {
        CARDINFO_def *pCI = MCRD_getcard(player * 4 + 1);
        Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
        if (pCI->status == -2) {
          returnmessage = 0x29f;
          result = 2;
        }
        else {
          result = 1;
          if (pCI->status == -1) {
            result = 3;
            returnmessage = 0x32b;
          }
          else {
            returnmessage = 0x329;
          }
        }
      }
      finished = true;
      break;
    }
  }
  while (MCRD_handlecardevents(cardshifted >> 0x10) != 0x16) {
    VSync(0);
  }
  BringThatBeatBack();
  if ((returnmessage != 0x28d) && (count < 3)) goto LoadGame_memcardInit;
  if (WithDialogs != 0) {
    if (nomessage_arr[0] == 0) {
      Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
      Hide((tDialogBase *)&FEApp[0]->MemCardDialog);
      /* dlgmsg held across the TextSys call (inlined-this block, s0) */
      tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
      dlgmsg->string = TextSys_Word(returnmessage + player);
      Display((tDialogBase *)&FEApp[0]->MemCardDialog);
      while (true) {
        if (((FEApp[0]->MemCardDialog).fFullyOpen ^ 1) == 0) break;
        Redraw(FEApp[0]);
      }
      Redraw(FEApp[0]);
    }
  }
  Front_ResetPSXController((int)player,(uint)(byte)frontEnd.controlConfig[player]);
  if (PinkSlips == 0) {
    if (frontEnd.raceType == '\x06') {
      frontEnd.raceType = '\0';
    }
    gMasterSFXLevel = (int)(byte)frontEnd.sfxVolume;
  }
  if ((WithDialogs != 0) || (PinkSlips != 0)) {
    Hide((tDialogBase *)&WarningDialog);
  }
  if (WithDialogs != 0) {
    Redraw(FEApp[0]);
  }
  CURRENTLYUSINGMEMCARD_arr[0] = 0;
  /* [phantom-dtor drop] WarningDialog is function-scoped (single return path); implicit
     dtor auto-fires here, matching oracle's ___7tScreen(&WarningDialog,2) before the epilogue. */
  return result;
}



/* ---- SavePinkSlipsCars  [FEMEMCARD.CPP:818-1069] ---- */

/* TU-local 4-arg decl: the shared header's 3-arg SavePinkSlipsCars(tCarManager*,...) DROPS the
   real 4th arg (oracle jal ...R12tSaveCarInfoss loads a3 = withoutCarInGarageNumber). */
void SavePinkSlipsCars(tCarManager*, tSaveCarInfo*, short, short);

PinkSlipsErrorCode
SavePinkSlipsCars(short player,short withoutCarInGarageNumber)

{
  /* SYM reg map: shapeFile=s7 finished=s3(BOOL) finishedsave=s5(BOOL)
     result=s2(ENUM PinkSlipsErrorCode) memCardResult/event=s0 (block-scoped);
     player REGPARM fp; withoutCarInGarageNumber ARG (stack); cardNum AUTO SHORT. */
  bool finished;
  bool finishedsave;
  PinkSlipsErrorCode result;
  int memCardResult;
  char *shapeFile;
  tMemCardData memCardData;
  char memorycardbuffer [256];

  MakeWayForMemoryCard();
  CURRENTPLAYER[0] = player;
  char shapeFileName [64];
  short cardNum;
  MCRDFILE_def memCardFile;
  cardNum = player * 4 + 1;
  finished = false;
  finishedsave = false;              /* oracle: s5/s2 = copies of s3's 0 */
  result = PinkSlipsNoError;
  CURRENTLYUSINGMEMCARD_arr[0] = 1;
  nomessage_arr[0] = 0;
  sprintf(shapeFileName,"%szMem.psh",Paths_Paths[0x20]);
  shapeFile = (char *)loadshapeadr(shapeFileName,(void *)0x0);
  Init_MemcardFile__FR12MCRDFILE_defsb(&memCardFile,cardNum,true);
  while (MCRD_handlecardevents(cardNum) == 0x15) {
    VSync(0);
  }
  memCardFile.pData = (u_char *)&memCardData;
  memCardFile.flags = 0;
  /* outer switch-loop: real switch (jtbl_800117A8), case bodies in oracle VA order --
     0x16 loadfile / 0xf verify+save / 2,0x10 getcard / 3,7,a,b,0x17 fail; default re-poll.
     (NEGATIVE: goto-loop form recolors the head, 102->146 -- the oracle's per-arm recompute
     of player*4 is a sext-pseudo split, not missing loop notes.) */
  while (true) {
    if (finished) break;
    memCardResult = MCRD_handlecardevents(cardNum);
    systemtask(0);
    VSync(0);
    switch(memCardResult) {
    case 0x16:
      MCRD_loadfile(cardNum,&memCardFile,0);
      break;
    case 0xf:
      /* MATCH arm order: success path INLINE (beqz jumps the fail block out-of-line to the
         arm end); nocheat-mismatch = 2-insn inline wedge (beq skips it into the save body). */
      if (VerifySuccessfulRead(&memCardData)) {
        if (frontEnd.gPinkSlipsNoCheat[player] != memCardData.pinkSlipsNoCheat) {
          /* anti-cheat token mismatch: not the original card */
          finished = true;
          result = (PinkSlipsErrorCode)finished;   /* oracle: addu s2,s3,zero -- =1 NotOriginalCard as a COPY of finished */
          break;
        }
        SavePinkSlipsCars(&carManager,&memCardData.carInfo,player,withoutCarInGarageNumber);
        while (MCRD_handlecardevents(cardNum) == 0x15) {
          VSync(0);
        }
        memCardFile.flags = 0x200;
        memCardFile.icon[0] = shapepointer(shapeFile,0);
        memCardFile.icon[1] = (shapetbl *)0x0;
        memCardFile.icon[2] = (shapetbl *)0x0;
        ChecksumData(&memCardData);
        /* inner save switch-loop (jtbl_80011800, base LICM-hoisted to s6); VA order
           0x16 savefile / 0xc done / getcard-fail. */
        while (true) {
          if (finishedsave) break;
          int event = MCRD_handlecardevents(cardNum);
          systemtask(0);
          VSync(0);
          switch(event) {
          case 0x16:
            if (gMemCardInfo.bReady != 0) {
              MCRD_savefile(cardNum,&memCardFile);
            }
            break;
          case 0xc:
            finishedsave = true;
            result = PinkSlipsNoError;
            break;
          case 2:
          case 3:
          case 7:
          case 10:
          case 0xb:
          case 0xd:
          case 0x17:
            Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
            {
              CARDINFO_def *pCVar7 = MCRD_getcard(player * 4 + 1);
              result = PinkSlipsError_CardFull;
              if (pCVar7->status != -3) {
                result = PinkSlipsError_SaveFailed;
                if (pCVar7->status == -1) {
                  result = PinkSlipsError_CardNotFound;
                }
              }
            }
            finishedsave = true;
            break;
          }
        }
        finished = true;
      }
      else {
        result = PinkSlipsError_LoadFailed;
        finished = true;
      }
      break;
    case 2:
    case 0x10:
      {
        CARDINFO_def *pCVar7 = MCRD_getcard(player * 4 + 1);
        result = PinkSlipsError_NotFormatted;
        if (pCVar7->status != -2) {
          result = PinkSlipsError_LoadFailed;
          if (pCVar7->status == -1) {
            result = PinkSlipsError_CardNotFound;
          }
        }
      }
      finished = true;
      break;
    case 3:
    case 7:
    case 10:
    case 0xb:
    case 0x17:
      finished = true;
      result = PinkSlipsError_LoadFailed;
      break;
    }
  }
  while (MCRD_handlecardevents(cardNum) != 0x16) {
    VSync(0);
  }
  purgememadr(shapeFile);
  BringThatBeatBack();
  CURRENTLYUSINGMEMCARD_arr[0] = 0;
  return result;
}



/* ---- SavePinkSlipsCarsWithErrorDialogs  [FEMEMCARD.CPP:1090] ---- */
PinkSlipsErrorCode
SavePinkSlipsCarsWithErrorDialogs(short player,short WillLoseCar,short withoutCarInGarageNumber)

{
  short sVar1;
  PinkSlipsErrorCode PVar2;
  char *pcVar3;
  char *pcVar4;
  tDialogYesNo *dlgmsg;
  int count;
  int iVar5;
  PinkSlipsErrorCode err;
  int yes;
  int player_00;
  int retry;
  char *shapeFile;
  tDialogYesNo RetryCancelDialog;
  tDialogNoInputMessage WillLoseCarMessage;
  char string [500];
  char string2 [500];

  /* [2026-07-11 consolidation] dropped REDUNDANT tDialogYesNo_ctor(&RetryCancelDialog) +
     tScreen_ctor((tScreen*)&WillLoseCarMessage) manual calls: both are undefined phantom
     externs; the real declared ctors (tDialogYesNo(), tScreen() via the ctor-less tDialog*
     intermediate chain) auto-fire at declaration -- oracle shows exactly one
     jal __12tDialogYesNo + one jal __7tScreen here. RetryCancelDialog/WillLoseCarMessage are
     function-scoped (constructed once, destructed once at the single `return PVar2;` below --
     manual tScreen_dtor calls for them dropped too, oracle's two ___7tScreen calls right
     before the epilogue are exactly the implicit auto-dtors at function scope exit). */
  sVar1 = 0;
  player_00 = (int)player;
  /* manual _vf init chain in oracle store order (see LoadGame/SaveGame) */
  WillLoseCarMessage._vf = (__vtbl_ptr_type (*)[10])tDialogBase_vtable;
  WillLoseCarMessage.currentlyOn = 0;
  WillLoseCarMessage.reservedheight = 0;
  WillLoseCarMessage.MaxH = 0;
  WillLoseCarMessage.OffsetY = 0;
  WillLoseCarMessage.OffsetX = 0;
  WillLoseCarMessage.height = 0;
  WillLoseCarMessage.width = 0;
  WillLoseCarMessage.top = 0;
  WillLoseCarMessage.left = 0;
  WillLoseCarMessage.MaxW = 0x120;
  WillLoseCarMessage.specificPlayer = -1;
  WillLoseCarMessage._vf = (__vtbl_ptr_type (*)[10])tDialogMessageString_vtable;
  WillLoseCarMessage.fDefault = 0;
  WillLoseCarMessage.timeOutTicks = 0;
  WillLoseCarMessage.Centerit = 0;
  WillLoseCarMessage.fFullyOpen = 0;
  /* MATCH: adjacent identical double store survives via volatile (catalog F(c)) */
  *(volatile long *)&WillLoseCarMessage.timeOutTicks = 0;
  WillLoseCarMessage.fFadeText = 0x80;
  WillLoseCarMessage._vf =
       (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
  /* MATCH: RetryCancel stores through a base pointer (oracle addiu v1,sp,16 + offset stores) */
  {
    tDialogYesNo *rc = &RetryCancelDialog;
    rc->yesnowords[0] = 0x291;
    rc->yesnowords[1] = 0x292;
    rc->fDefault = 1;
    rc->specificPlayer = player;
  }
  do {
    Display((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
    while (true) {
      if (((FEApp[0]->NoInputMemCardDialog).fFullyOpen ^ 1) == 0) break;   /* xori;beqz */
      Redraw(FEApp[0]);
    }
    iVar5 = 0;
    Redraw(FEApp[0]);
    /* [block-scope fix] WarningDialog constructed/destructed FRESH every retry iteration --
       oracle's jal __7tScreen sits at the loop top (per-iteration ctor) and the matching
       ___7tScreen dtor fires exactly once, right after the error-dialog block below, BEFORE
       the loop-back/return decision -- i.e. WarningDialog is scoped to a nested block that
       ends there, not to the whole do-loop body. Declaring it fn-scope (old code) or letting
       an unscoped do-loop-body local live past that point does not reproduce the single,
       fixed dtor call site. */
    {
      tDialogNoInputMessage WarningDialog;
      WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogBase_vtable;
      WarningDialog.currentlyOn = 0;
      WarningDialog.reservedheight = 0;
      WarningDialog.MaxH = 0;
      WarningDialog.OffsetY = 0;
      WarningDialog.OffsetX = 0;
      WarningDialog.height = 0;
      WarningDialog.width = 0;
      WarningDialog.top = 0;
      WarningDialog.left = 0;
      WarningDialog.MaxW = 0x120;
      WarningDialog.specificPlayer = -1;
      WarningDialog._vf = (__vtbl_ptr_type (*)[10])tDialogMessageString_vtable;
      WarningDialog.fDefault = 0;
      WarningDialog.timeOutTicks = 0;
      WarningDialog.Centerit = 0;
      WarningDialog.fFullyOpen = 0;
      /* MATCH: adjacent identical double store survives via volatile (catalog F(c)) */
      *(volatile long *)&WarningDialog.timeOutTicks = 0;
      WarningDialog.fFadeText = 0x80;
      WarningDialog._vf =
           (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
      WarningDialog.string =
           TextSys_Word(player_00 + 0x276);
      WarningDialog.OffsetX = 0;
      WarningDialog.OffsetY = 0x32;
      Display((tDialogBase *)&WarningDialog);
      while (true) {
        if ((WarningDialog.fFullyOpen ^ 1) == 0) break;   /* xori;beqz */
        Redraw(FEApp[0]);
      }
      Redraw(FEApp[0]);
      do {
        PVar2 = SavePinkSlipsCars(player,withoutCarInGarageNumber);
        iVar5 = iVar5 + 1;
        if (PVar2 == PinkSlipsNoError) break;
        timedwait(5);
      } while (iVar5 < 3);
      Hide((tDialogBase *)&WarningDialog);
      Redraw(FEApp[0]);
      if (PVar2 != PinkSlipsNoError) {
        Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
        pcVar3 = TextSys_Word(textSysMemCardFail_Index[PVar2] + player_00);
        sprintf(string,pcVar3);
        if (WillLoseCar != 0) {
          iVar5 = 0x298;
          if (WillLoseCar == 2) {
            iVar5 = 0x299;
          }
          pcVar3 = TextSys_Word(iVar5);
          pcVar4 = PlayerName(player_00);
          sprintf(string2,pcVar3,pcVar4);
          WillLoseCarMessage.OffsetX = 0;
          WillLoseCarMessage.OffsetY = -0x3c;
          WillLoseCarMessage.string = string2;
          Display((tDialogBase *)&WillLoseCarMessage);
        }
        RetryCancelDialog.string = string;
        sVar1 = Run((tDialogInteractive *)&RetryCancelDialog);
        Hide((tDialogBase *)&WillLoseCarMessage);
      }
    }
    if ((PVar2 == PinkSlipsNoError) || (sVar1 == 0)) {
      return PVar2;
    }
  } while( true );
}



/* end of fememcard.cpp */

extern "C" {
void ___23tMenuItemGoToMenuButton(void *);
void ___19tMemoryCardMenuItem(void *thisp) { ___23tMenuItemGoToMenuButton(thisp); }
}
