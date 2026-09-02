/* frontend/common/fememcard.cpp -- RECONSTRUCTED (FE memory-card save/load + dialogs; C++ TU)
 *   18 FREE fns (namespace nfs4::FRONTEND::COMMON::FEMemCard). Init/DeInit_Memcard tails
 *   rebuilt from m2c (Ghidra truncated to do{}while(true)). Dialog base-hierarchies routed.
 */
#define FEAPP_DEFINE_DIALOG_CTORS
#include "fememcard.h"

/* ---- FEMemCard.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes / .bss zero;
   productCode="SLUS-00826" = the retail PSX game ID; textSysMemCardFail_Index = fail-message LUT).
   Only the 4 externed-not-defined gaps (nm-confirmed); TITLE/nomessage/MEMCARD_INITIALIZED are
   already defined elsewhere. ---- */
/* THIS BLOCK IS FEMemCard.obj's WHOLE retail .data RUN, IN RETAIL ORDER -- DO NOT RE-SORT.
   From the SYM's own FEMemCard.obj block (W66-A5 symown.py):
     0x80051a68 CURRENTPLAYER -> a6c productCode[11] -> a78 nomessage ->
     a7c CURRENTLYUSINGMEMCARD -> a80 MEMCARD_INITIALIZED -> a84 textSysMemCardFail_Index[7].
   The four zero cells sit BETWEEN two INITIALISED objects, and a tentative definition can never
   do that (16E: tentative defs emit after every initialised object) -- so retail's source
   initialised them explicitly.  gcc-2.8 has no zero-initialized-in-bss pass, so `= 0` keeps them
   in .data at their definition position, which IS the emission order for initialised objects.
   (The "defined elsewhere / nm-confirmed" note above was STALE: an nm sweep over all 508 recon
   objects this run shows NOTHING defines CURRENTPLAYER / nomessage / MEMCARD_INITIALIZED --
   they were still sitting in the blob.  Migrated here W66-A5.)
   CURRENTPLAYER keeps the unsized-array + [0] access form (fememcard_externs.h): the int-value
   load into an ARG reg then uses the oracle's SEPARATE v0 scratch (lui v0; lw a0,(v0)) rather
   than dest-as-temp (lui a0; lw a0,(a0)); §3.15-CORRECTION. */
int          CURRENTPLAYER[1] = { 0 };   /* @0x80051a68; SYM-CARRIER: CURRENTPLAYER */
char         productCode[11] = { 83, 76, 85, 83, 45, 48, 48, 56, 50, 54, 0 };   /* @0x80051a6c */
bool         nomessage = false;   /* @0x80051a78  SYM BOOL (4 B) */
bool         CURRENTLYUSINGMEMCARD = false;   /* @0x80051a7c  SYM BOOL */
bool         MEMCARD_INITIALIZED = false;     /* @0x80051a80  SYM BOOL */
int          textSysMemCardFail_Index[7] = { 0, 677, 685, 675, 811, 671, 669 };   /* @0x80051a84 */

/* [HEADER WISH -- TU-local TRUE-TYPE redeclarations via asm labels; the shared headers declare
   these with the wrong C type and can't be edited from this worktree.]
   - ticks IS volatile (written by the Clock_MasterInterruptHandler IRQ timer behind the
     compiler's back): the plain `int ticks` decl lets gcc constant-fold the memcard wait loops
     into INFINITE loops (li v0,1; bnez -- real bug) and blocks the oracle's per-iteration
     reload + hoisted %hi base.
   - MEMCARD_INITIALIZED / MEMCARDFRONTENDISINITTED are 4-byte BOOLs (SYM; oracle uses lw/sw
     word ops). */
extern int          MEMCARDFRONTENDISINITTED_word asm("MEMCARDFRONTENDISINITTED");
/* base-class vtables for the inlined WarningDialog ctor chains (declared in feapp_externs.h
   for other TUs; TU-local externs here) */
extern __vtbl_ptr_type tDialogBase_vtable[], tDialogMessageString_vtable[];

inline tDialogBase::tDialogBase()
{
  *(void **)&_vf = (void *)tDialogBase_vtable;
  currentlyOn = 0;
  reservedheight = 0;
  MaxH = 0;
  OffsetY = 0;
  OffsetX = 0;
  height = 0;
  width = 0;
  top = 0;
  left = 0;
  MaxW = 0x120;
  specificPlayer = -1;
  fDefault = 0;
  timeOutTicks = 0;
}

inline tDialogMessageString::tDialogMessageString()
{
  *(void **)&_vf = (void *)tDialogMessageString_vtable;
  Centerit = 0;
  fFullyOpen = 0;
  timeOutTicks = 0;
  fFadeText = 0x80;
}

inline tDialogNoInputMessage::tDialogNoInputMessage()
{
  *(void **)&_vf = (void *)tDialogNoInputMessage_vtable;
}
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

static void ChecksumData(tMemCardData *memCardData)

{
  memCardData->fSize = 0x14ac;
  memCardData->frontEndCRC = crc16(&memCardData->frontEnd,0x450);
  memCardData->carInfoCRC = crc16(&memCardData->carInfo,0xe0);
  memCardData->trackInfoCRC = crc16(&memCardData->trackInfo,0x10);
  memCardData->tournamentCRC = crc16(&memCardData->tournament,0xb0);
  memCardData->recordsCRC = crc16(memCardData->records,0xe9c);
  return;
}



/* ---- VerifySuccessfulRead  [FEMEMCARD.CPP:75-86] ---- */

static bool VerifySuccessfulRead(tMemCardData *memCardData)

{
  bool result;

  /* MATCH: `(cmp) & result` BOOL-accumulation form (SYM: result BOOL) -- the oracle re-masks
     the stored bool in each beq delay slot (andi s0,s0,1 = the fold of `1 & result` on the equal path
     -- BITWISE &, not &&: && normalizes via sltu) then clears on fall-through; a plain
     `if (x != crc) result = false;` chain emits no andi and mis-colors s0/s1. */
  result = memCardData->frontEndCRC == crc16(&memCardData->frontEnd,0x450);
  result = (memCardData->carInfoCRC == crc16(&memCardData->carInfo,0xe0)) & result;
  result = (memCardData->trackInfoCRC == crc16(&memCardData->trackInfo,0x10)) & result;
  result = (memCardData->tournamentCRC == crc16(&memCardData->tournament,0xb0)) & result;
  result = (memCardData->recordsCRC == crc16(memCardData->records,0xe9c)) & result;
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

static int Confirm(int Text,int yesText)

{
  /* Reliable SYM records `MyDialog`, `putbackon`, `ret`, nested setup roles
     `num`/`yes`, the inlined Hide receiver, and the later message-string
     receiver.  These optimized-away identities are retained only where the
     exact oracle allocation requires a separate source value:
     SYM-CODEGEN-CARRIER: dialog
     SYM-CODEGEN-CARRIER: dialogVtable
     SYM-CODEGEN-CARRIER: feApp
     SYM-CODEGEN-CARRIER: noInputDialog
     SYM-CODEGEN-CARRIER: messageDialog
     SYM-CODEGEN-CARRIER: messageText
     SYM-CODEGEN-CARRIER: displayDialog */
  bool putbackon;         /* SYM: REG BOOL $s3 */
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
  tDialogYesNoMem *dialog = &MyDialog;
  /* MATCH: GCC 2.8.1 must create the vtable-address pseudo first, then load FEApp[0]
     before the stack _vf store. Splitting both values reproduces retail's interleaved
     `lui v0; lui s1; lw v1; addiu v0; sw v0` schedule. */
  __vtbl_ptr_type (*dialogVtable)[10] =
      (__vtbl_ptr_type (*)[10])tDialogYesNoMem_vtable;
  tFEApplication *feApp = FEApp[0];
  /* [2026-07-11 RESTORE] the manual _vf poke was WRONGLY dropped in the wave-5 consolidation:
     this hierarchy uses MANUAL _vf dispatch (not real C++ virtuals), so the implicit
     tDialogYesNoMem ctor does NOT set the derived vtable -- gcc's synthesized ctor only calls
     the base tDialogYesNo ctor. The oracle explicitly stores &_vt_15tDialogYesNoMem to _vf(0x60)
     right after the ctor (`sw v0,0x60(s0)`). Restore it. */
  dialog->_vf = dialogVtable;
  putbackon = false;
  /* MATCH: pointer-local for the NoInput dialog (SYM shows an inlined tDialogBase-`this` block
     in $a0 here) -- oracle computes base+720 ONCE (addiu a0,v1,720), tests currentlyOn via
     112(a0), and reuses a0 for Hide; a direct member test loads 832(base) then recomputes. */
  {
    tDialogNoInputMessage *noInputDialog = &feApp->NoInputMemCardDialog;
    if (noInputDialog->currentlyOn != 0) {
      /* SYM-INLINE-THIS: Hide */
      ((tDialogBase *)noInputDialog)->Hide();
      putbackon = true;
    }
  }
  {
    /* Reliable line-9 SYM records these inlined setup roles in the caller's
       original parameter registers ($s2/$s4); they are real uses, not
       declaration-only audit placeholders. */
    int num = Text;
    int yes = yesText;

    dialog->string = TextSys_Word(num);
    dialog->yesnowords[1] = 0x292;
    dialog->yesnowords[0] = yes;
    dialog->fDefault = 0;
    if (frontEnd.language == '\x03') {
      dialog->OffsetX = 0;
      dialog->OffsetY = 10;
    }
  }
  ret = (int)(short)Run((tDialogInteractive *)dialog);
  if (ret == -1) {
    /* MATCH: dlgmsg pointer computed BEFORE the TextSys_Word call and HELD across it in a
       callee-saved reg (SYM: inlined tDialogMessageString-`this` block, $s0; oracle
       lw s0,0(s1) + addiu s0,s0,568 in the jal delay slot); the Display arg is a FRESH
       FEApp re-deref (selective/partial caching -- oracle recomputes it). */
    tDialogMessageString *messageDialog = &FEApp[0]->MemCardDialog;
    char *messageText = TextSys_Word(CURRENTPLAYER[0] + 0x32b);
    /* MATCH: form Display's fresh `this` before storing messageText. Besides matching retail's
       load-before-store schedule, this keeps the FEApp address in $s1 for the wait loop. */
    tDialogBase *displayDialog = (tDialogBase *)&FEApp[0]->MemCardDialog;
    /* SYM-INLINE-THIS: SetString */
    messageDialog->SetString(messageText);
    Display(displayDialog);
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

static int OverwriteConfirm(void)

{
  return Confirm(CURRENTPLAYER[0] + 0x323,0x28f);
}



/* ---- OverwriteAlwaysYes  [FEMEMCARD.CPP:184-185] ---- */

static int OverwriteAlwaysYes(void)

{
  return 1;
}



/* ---- FormatConfirm  [FEMEMCARD.CPP:191-204] ---- */

static int FormatConfirm(void)

{
  return Confirm(CURRENTPLAYER[0] + 0x327,0x290);
}



/* ---- LoadingProc  [FEMEMCARD.CPP:209-213] ---- */

static void LoadingProc(void)

{
  return;
}



/* ---- LoadingRedrawProc  [FEMEMCARD.CPP:217-221] ---- */

static void LoadingRedrawProc(void)

{
  Redraw(FEApp[0]);
  return;
}



/* ---- SavingProc  [FEMEMCARD.CPP:226-230] ---- */

static void SavingProc(void)

{
  Redraw(FEApp[0]);
  return;
}



/* ---- Init_Memcard  [FEMEMCARD.CPP:240-316] ---- */
void Init_Memcard(bool redraw,bool pinkslips)
{
  /* SYM 8c Def-record order: mcrdopts, padrestorestarttick. */
  MCRDOPTS_def mcrdopts;
  int padrestorestarttick;

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
  mcrdopts.ConfirmFormatProc = FormatConfirm;
  mcrdopts.ConfirmOverwriteProc = pinkslips ? OverwriteAlwaysYes : OverwriteConfirm;
  mcrdopts.LoadingDataProc = redraw ? LoadingRedrawProc : LoadingProc;
  mcrdopts.SavingDataProc = SavingProc;
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
  /* Keep the word-shaped codegen carrier TU-local; the shared declaration now
     records the honest C++ bool type. */
  if (MEMCARDFRONTENDISINITTED_word != 0) {
    UpdateMusic(FEApp[0]);
  }
  return;
}

/* ---- Init_MemcardFile  [FEMEMCARD.CPP:357-381] ---- */

void Init_MemcardFile(MCRDFILE_def &memCardFile,short cardnum,bool notitle)

{
  blockclear(&memCardFile,0x2c);
  memCardFile.name = "NFS4";
  /* [branch-polarity fix] oracle's beqz skips the (rare) notitle==true case out-of-line and
     falls straight through the common PlayerNameExist path -- arm order flipped to match
     (catalog wave-3 "if/else ARM ORDER controls beqz/bnez polarity" row). */
  if (notitle) {
    TITLE[0] = '\0';
  }
  else {
    if (PlayerNameExist((uint)(cardnum == 5))) {
      sprintf(TITLE,"%s%s",TextSys_Word(0x278),PlayerName((uint)(cardnum == 5)));
    }
    else {
      sprintf(TITLE,TextSys_Word(0x279));
    }
  }
  memCardFile.title = TITLE;
  memCardFile.size = 0x1500;
  memCardFile.offset = 0;
  memCardFile.flags = 0;
  return;
}



/* ---- SaveGame  [FEMEMCARD.CPP:395-583] ---- */
/* MATCH (2026-08-11, 6 -> PASS, 292/292).  RECEIPT (W57-A5, allocsim + reqdelta):
   A read fence on player immediately before the final shapeFile use extends the right
   live range and reproduces retail's player=s5, returnvalue=s6, shapeFile=s7 rotation
   without adding an instruction.  Explicit message/display locals reproduce retail's
   load-before-store order at the final dialog update.  Restoring the retail header's
   inline dialog constructor chain makes the implicit ctor and following field stores
   share one address pseudo, producing the retail s0 staging across `jal __7tScreen`.

   SYM restoration 2026-08-26: the final nested line-173 `this` scope now uses
   the established inline SetString member.  The recorded `event` local cannot
   double as the card-status value: that extends s0 and is FAIL 18.  A transient
   `status` value exactly reproduces retail v1 and is semantically stronger than
   the old decompiler pointer.  The five marked identities remain measured
   source-only carriers whose private spellings are not uniquely recoverable. */

bool SaveGame(short player)

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
  /* WarningDialog is declared after the loop at the oracle's `jal __7tScreen` position;
     declaration order matches the SYM stack layout.  Its header-inline constructor above
     emits the retail base/vtable/field chain. */
  tDialogNoInputMessage WarningDialog;
  short cardNum;
  MCRDFILE_def memCardFile;
  char *shapeFile;
  char shapeFileName [64];
  bool finished;
  int event;
  bool returnvalue;
  int returnmessage;
  /* SYM-CODEGEN-CARRIER: wd -- CSE of &WarningDialog across the ctor/TextSys calls
     (hold-addr, s0): the
     oracle stores the three non-zero-constant fields through s0 and takes both call args
     from it; zeros/vt stay sp-direct. */
  tDialogNoInputMessage *wd = &WarningDialog;
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
  Init_MemcardFile(memCardFile,cardNum,false);
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
        /* SYM-CODEGEN-CARRIER: status -- retail holds the loaded status in v1;
           reusing recorded local `event` perturbs its earlier switch allocation. */
        int status = MCRD_getcard(player * 4 + 1)->status;
        returnmessage = 0x29d;
        if (status != -3) {
          returnmessage = 0x325;
          if (status == -1) {
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
  /* MATCH (W85-M4, 2026-09-02): pure-C replacement for the removed
     `__asm__("" : : "r"(player))` read fence.  The three tail allocnos are a
     0.3%-wide priority cluster -- player refs=5/live=214 (0.04673),
     returnvalue refs=4/live=171 (0.04678), shapeFile refs=3/live=64 (0.04688)
     -- so gcc-2.8 handed out s5/s6/s7 in the order shapeFile,returnvalue,player
     while retail wants player,returnvalue,shapeFile.  flow.c:1969 adds
     `loop_depth` per reference, so the two degenerate scopes below re-weight
     exactly the references that decide the cluster and emit nothing:
     the outer scope (epilogue block + `return returnvalue`) gives returnvalue
     a 5th ref (10/171 = 0.0585 > shapeFile's 0.0469) and the inner scope gives
     player its 6th and 7th (14/214 = 0.0654, back on top).  Measured ladder:
     no scopes = FAIL 26; inner only = FAIL 12 (player fixed, the
     returnvalue/shapeFile pair still swapped); both = PASS 292/292. */
  do {
  if (nomessage_arr[0] == 0) do {
    Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
    /* SYM-CODEGEN-CARRIER: dlgmsg -- held across TextSys_Word as the nested
       inline receiver in s0. */
    tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
    /* SYM-CODEGEN-CARRIER: message -- preserves the call result while the
       independent Display receiver is formed. */
    char *message = TextSys_Word(returnmessage + player);
    /* SYM-CODEGEN-CARRIER: displayDialog -- forming this before the inline
       store gives retail's load/store order. */
    tDialogBase *displayDialog = (tDialogBase *)&FEApp[0]->MemCardDialog;
    /* SYM-INLINE-THIS: SetString */
    dlgmsg->SetString(message);
    Display(displayDialog);
    while (true) {
      if (((FEApp[0]->MemCardDialog).fFullyOpen ^ 1) == 0) break;
      Redraw(FEApp[0]);
    }
    Redraw(FEApp[0]);
  } while (0);
  screenMemcard->fGetNewIcons = 1;
  Hide((tDialogBase *)&WarningDialog);
  Redraw(FEApp[0]);
  CURRENTLYUSINGMEMCARD_arr[0] = 0;
  /* [phantom-dtor drop] implicit ___7tScreen(&WarningDialog,2) at scope exit */
  return returnvalue;
  } while (0);
}



/* ---- LoadGame  [FEMEMCARD.CPP:591-812] ---- */
/* MATCH (2026-08-11, 26 -> 20 -> 17 -> 6 -> PASS, 374/374): restoring the
   header-inline dialog constructor fixed the ctor target and address lifetime.  The
   retry is a real do/while (IDA), which lets loop-invariant motion hoist the promoted
   player value before the loop.  `nomessage = 0` precedes the zero-valued locals so
   sched1 splits its %hi setup across both dialog predecessors exactly as in retail.
   The final empty scheduling fence keeps the last error-message assignment out of a
   jump delay slot, leaving `finished = true` there instead.

   SYM restoration 2026-08-26: the two nested line-111/188 `this` records are
   now represented by the existing header-inline SetString member rather than
   raw field stores.  Retail computes each receiver before TextSys_Word and a
   separate Display receiver before the inline store.  Direct fluent and
   direct two-statement spellings score FAIL 73 (373/374) and FAIL 69
   (375/374); the four marked source-only carriers preserve retail's exact
   ordering and allocation.  Their original private spellings are not
   recoverable from SYM or the optimized binary. */

short LoadGame(short player,bool PinkSlips,bool WithDialogs)

{
  /* SYM reg map: cardNum=s3(SHORT) finished=s1(BOOL) result=s4 memCardResult=s0 count=fp
     returnmessage=s2; pCI + the fail-dialog `this` are block-scoped s0. player/PinkSlips/
     WithDialogs are ARG class (arg-slot spilled, reloaded per use). */
  tMemCardData memCardData;
  char memorycardbuffer [256];
  short cardNum;
  bool finished;
  int result;
  int memCardResult;
  int count;
  int returnmessage;
  /* SYM-CODEGEN-CARRIER: cardshifted -- retail keeps the promoted card value
     in s5 while SYM exposes only the source `cardNum` short in s3. */
  int cardshifted;                 /* s5 = (player*4|1) << 16; every card arg = >>16 */
  /* memCardFile declared BELOW, after WarningDialog: gcc-2.8 assigns stack slots in decl
     order ascending -- SYM layout is memCardData / buffer / WarningDialog / memCardFile. */

  cardNum = player * 4 | 1;
  /* WarningDialog is declared here (oracle jal __7tScreen after the two global stores);
     the header-inline constructor above emits the three-stage retail init chain. */
  CURRENTPLAYER[0] = player;
  CURRENTLYUSINGMEMCARD_arr[0] = 1;
  tDialogNoInputMessage WarningDialog;
  MCRDFILE_def memCardFile;
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
  nomessage_arr[0] = 0;
  finished = false;
  result = 0;
  count = 0x2c;
  if (WithDialogs != 0) {
    count = 0;
  }
  returnmessage = 0x28d;
  cardshifted = cardNum << 16;
  do {
  count = count + 1;
  MakeWayForMemoryCard();
  Init_MemcardFile(memCardFile,(short)(cardshifted >> 0x10),true);
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
        /* STRICT-CFG MATCH: keep the successful-read exit tied to the same
           late switch tail as the card-status arms.  Without this source
           edge, cross-jump makes the WithDialogs==0 branch target the earlier
           byte-identical tail (normalized PASS, retail branch word wrong). */
        goto finish_card_event;
      }
      else {
        result = 1;
        if (WithDialogs != 0) {
          if (nomessage_arr[0] == 0) {
            Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
            Hide((tDialogBase *)&FEApp[0]->MemCardDialog);
            /* SYM-CODEGEN-CARRIER: dlgmsg -- retail computes and holds the
               inlined receiver across TextSys_Word in s0. */
            tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
            /* SYM-CODEGEN-CARRIER: dialogText -- preserves the call result
               while the independent Display receiver is formed. */
            char *dialogText = TextSys_Word(player + 0x329);
            /* SYM-CODEGEN-CARRIER: dialogBase -- forming this before the
               inline store gives retail's load/store order. */
            tDialogBase *dialogBase = (tDialogBase *)&FEApp[0]->MemCardDialog;
            /* SYM-INLINE-THIS: SetString */
            dlgmsg->SetString(dialogText);
            Display(dialogBase);
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
finish_card_event:
      finished = true;
    }
  }
  while (MCRD_handlecardevents(cardshifted >> 0x10) != 0x16) {
    VSync(0);
  }
  BringThatBeatBack();
  } while ((returnmessage != 0x28d) && (count < 3));
  if (WithDialogs != 0) {
    if (nomessage_arr[0] == 0) {
      Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
      Hide((tDialogBase *)&FEApp[0]->MemCardDialog);
      /* The three measured carriers above repeat at this second expansion. */
      tDialogMessageString *dlgmsg = &FEApp[0]->MemCardDialog;
      char *dialogText = TextSys_Word(returnmessage + player);
      tDialogBase *dialogBase = (tDialogBase *)&FEApp[0]->MemCardDialog;
      /* SYM-INLINE-THIS: SetString */
      dlgmsg->SetString(dialogText);
      Display(dialogBase);
      while (true) {
        if (((FEApp[0]->MemCardDialog).fFullyOpen ^ 1) == 0) break;
        Redraw(FEApp[0]);
      }
      Redraw(FEApp[0]);
    }
  }
  Front_ResetPSXController((int)player,(uint)(byte)frontEnd.controlConfig[player]);
  if (PinkSlips == 0) {
    if (frontEnd.raceType == RaceType_PinkSlips) {
      frontEnd.raceType = RaceType_SingleRace;
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
void SavePinkSlipsCars(tCarManager*, tSaveCarInfo*, short, short) asm("SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss");

PinkSlipsErrorCode
SavePinkSlipsCars(short player,short withoutCarInGarageNumber)

{
  /* SYM reg map: shapeFile=s7 finished=s3(BOOL) finishedsave=s5(BOOL)
     result=s2(ENUM PinkSlipsErrorCode) memCardResult/event=s0 (block-scoped);
     player REGPARM fp; withoutCarInGarageNumber ARG (stack); cardNum AUTO SHORT. */
  tMemCardData memCardData;
  char memorycardbuffer [256];
  char *shapeFile;
  bool finished;
  bool finishedsave;
  PinkSlipsErrorCode result;
  int memCardResult;
  int event;

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
  Init_MemcardFile(memCardFile,cardNum,true);
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
        /* MATCH (2026-08-15, 25 -> PASS): the two operand-free boundaries add
           four live units to the LICM-hoisted inner jump-table base.  This drops
           its global-alloc priority below the sign-extended player and restores
           retail's player=$s4 / table=$s6 handout without emitting bytes.  In
           that basin the retail player*4+1 recomputation no longer triggers the
           old loop.c spill cascade.  The boundary after MCRD_getcard keeps the
           CardFull constant in retail's status-branch delay slot.  Finally, the
           two forward labels reproduce retail's distinct read-failure block and
           the shared outer-case `finished` tail.  Detailed gate: PASS 226/226. */
        while (true) {
          if (finishedsave) break;
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
              /* SYM-CODEGEN-CARRIER: cardInfo -- each switch arm must retain the
                 single MCRD_getcard result across multiple status tests. */
              CARDINFO_def *cardInfo = MCRD_getcard(player * 4 + 1);
              /* KEEP (W85-M4): the LAST device in this TU.  It is an operand-free
                 scheduling/CSE boundary whose ONLY effect is +1 RTL insn inside the
                 outer poll loop, which flips loop.c's marginal LICM verdict on the
                 `&frontEnd + player*4` address chain (`threshold * savings * life`
                 vs `insn_count`, loop.c:1640).  Removing it lets loop.c hoist that
                 chain into the loop preheader AND spill it, costing an extra frame
                 slot (5744 vs retail's 5736) -- FAIL 92 @228/226.  Every source-level
                 replacement measured this wave is in scratchpad/w85/M4_receipt.md;
                 the best (struct-cast index-first address view) reaches FAIL 46 @224
                 but cannot put the `sll` back at the use.  Restored verbatim under the
                 wave's iron rule; the removal IS the regional USA body (see the
                 receipt -- retail's USA build hoists+spills exactly this chain). */
              __asm__("");
              result = PinkSlipsError_CardFull;
              if (cardInfo->status != -3) {
                result = PinkSlipsError_SaveFailed;
                if (cardInfo->status == -1) {
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
        /* MATCH/CFG (w65-a1): retail's read-failure arm sets the code and joins
           the SHARED outer `finished = true` tail (branch word 5: ours +103 vs
           retail +88) -- see the case-3 arm below for the role swap this pairs
           with, and the jump-table proof in scratchpad/w65a1/RECEIPTS.md. */
        result = PinkSlipsError_LoadFailed;
        goto finish_outer_card_case;
      }
      break;
    /* MATCH/CFG (w65-a1): the two "load failed" spellings and the two outer arms
       were ROLE-SWAPPED against retail.  Retail's jump table (jtbl_800117A8,
       asm/data/rdata_80010000_j06.rodata.s) sends cases 3/7/0xa/0xb/0x17 to
       .L800356F4 = the 3-insn `finished = true; result = LoadFailed; break;`
       block, and the read-failure arm above to the 2-insn `result = LoadFailed;
       goto <shared finished tail>` at .L800356B8.  Ours had it exactly the other
       way round, so our .rodata jump table pointed at the wrong block and the
       `beqz` at word 90 routed the other way -- same 226 instructions, different
       CFG.  The case-2/0x10 arm must therefore come FIRST (it owns the shared
       tail) and the 3/7/... arm last.  The old `__asm__("")` at the shared tail
       (a stand-in for "retail's distinct read-failure block") is now redundant
       and was measured exactly neutral, so it is gone. */
    case 2:
    case 0x10:
      {
        CARDINFO_def *cardInfo = MCRD_getcard(player * 4 + 1);
        result = PinkSlipsError_NotFormatted;
        if (cardInfo->status != -2) {
          result = PinkSlipsError_LoadFailed;
          if (cardInfo->status == -1) {
            result = PinkSlipsError_CardNotFound;
          }
        }
      }
finish_outer_card_case:
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
  tDialogYesNo RetryCancelDialog;
  tDialogNoInputMessage WillLoseCarMessage;
  char string [500];
  char string2 [500];
  PinkSlipsErrorCode err;
  int retry;

  /* MATCH W64/P101 PASS (45 -> 0, 219 instructions): rely on the generated
     tDialogNoInputMessage construction chain instead of replaying its stores.
     SYM records no `rc` or `dialog` caller locals: SetChoices reconstructs the
     one-line inline tDialogYesNo receiver at line 1105, and SetString restores
     the later inline tDialogMessageString receiver after sprintf. */
  /* [2026-07-11 consolidation] dropped REDUNDANT tDialogYesNo_ctor(&RetryCancelDialog) +
     tScreen_ctor((tScreen*)&WillLoseCarMessage) manual calls: both are undefined phantom
     externs; the real declared ctors (tDialogYesNo(), tScreen() via the ctor-less tDialog*
     intermediate chain) auto-fire at declaration -- oracle shows exactly one
     jal __12tDialogYesNo + one jal __7tScreen here. RetryCancelDialog/WillLoseCarMessage are
     function-scoped (constructed once, destructed once at the single `return err;` below --
     manual tScreen_dtor calls for them dropped too, oracle's two ___7tScreen calls right
     before the epilogue are exactly the implicit auto-dtors at function scope exit). */
  retry = 0;
  RetryCancelDialog.SetChoices(0x291, 0x292, 1, player);
  do {
    Display((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
    while (true) {
      if (((FEApp[0]->NoInputMemCardDialog).fFullyOpen ^ 1) == 0) break;   /* xori;beqz */
      Redraw(FEApp[0]);
    }
    int count;
    count = 0;
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
      WarningDialog.string =
           TextSys_Word(player + 0x276);
      WarningDialog.OffsetX = 0;
      WarningDialog.OffsetY = 0x32;
      Display((tDialogBase *)&WarningDialog);
      while (true) {
        if ((WarningDialog.fFullyOpen ^ 1) == 0) break;   /* xori;beqz */
        Redraw(FEApp[0]);
      }
      Redraw(FEApp[0]);
      do {
        err = SavePinkSlipsCars(player,withoutCarInGarageNumber);
        if (err != PinkSlipsNoError) {
          timedwait(5);
        }
        count = count + 1;
      } while ((err != PinkSlipsNoError) && (count < 3));
      Hide((tDialogBase *)&WarningDialog);
      Redraw(FEApp[0]);
      if (err != PinkSlipsNoError) {
        Hide((tDialogBase *)&FEApp[0]->NoInputMemCardDialog);
        sprintf(string,TextSys_Word(textSysMemCardFail_Index[err] + player));
        if (WillLoseCar != 0) {
          sprintf(string2,TextSys_Word(WillLoseCar == 2 ? 0x299 : 0x298),
                  PlayerName(player));
          WillLoseCarMessage.SetString(string2);
          WillLoseCarMessage.OffsetX = 0;
          WillLoseCarMessage.OffsetY = -0x3c;
          WillLoseCarMessage.Display();
        }
        retry = ((tDialogInteractive *)RetryCancelDialog.SetString(string))->Run();
        Hide((tDialogBase *)&WillLoseCarMessage);
      }
    }
    if ((err == PinkSlipsNoError) || (retry == 0)) {
      return err;
    }
  } while( true );
}



/* end of fememcard.cpp */

/* w60 link-debt fix: ___19tMemoryCardMenuItem was multiply-defined here AND in
 * femenuoptions.cpp.  SYM ownership proof: `Set SLD to line 425 of file
 * ...FEMENUOPTIONS.H`, `$80020bd8 94 Def class EXT ... _._19tMemoryCardMenuItem`
 * => FEMenuOptions.obj owns it; this copy removed. */
