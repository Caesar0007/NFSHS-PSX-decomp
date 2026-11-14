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
   P871: CURRENTPLAYER is native SYM EXT INT (5e4a59), not an array.  Keep
   its explicit zero initializer and four-byte position in this data run. */
int          CURRENTPLAYER = 0;   /* @0x80051a68; native SYM EXT INT */
char         productCode[11] = { 83, 76, 85, 83, 45, 48, 48, 56, 50, 54, 0 };   /* @0x80051a6c */
bool         nomessage = false;   /* @0x80051a78  SYM BOOL (4 B) */
bool         CURRENTLYUSINGMEMCARD = false;   /* @0x80051a7c  SYM BOOL */
bool         MEMCARD_INITIALIZED = false;     /* @0x80051a80  SYM BOOL */
int          textSysMemCardFail_Index[7] = { 0, 677, 685, 675, 811, 671, 669 };   /* @0x80051a84 */

/* P884: state flags use native scalar BOOLs; ticks uses the genuine scalar
   declaration with its existing polling qualification. Without that volatile
   qualification both waits collapse (Init80/87, DeInit34/40). Native SDB
   does not uniquely recover the original CV keyword or macro spelling. */
/* base-class vtables for the inlined WarningDialog ctor chains (declared in feapp_externs.h
   for other TUs; TU-local externs here) */

/* tDialogBase() / tDialogMessageString(): defined inline in fedialog.h for every includer (2026-11-14) */
























/* P884: Stats_gTrackRecords uses the native tRecordBuffer[187] declaration. */


/* ---- ChecksumData  [FEMEMCARD.CPP:63-70] ---- */

#line 60 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static void ChecksumData(tMemCardData *memCardData)


{
  memCardData->fSize = 0x14ac;

  memCardData->frontEndCRC = crc16((unsigned char *)&memCardData->frontEnd,0x450);
  memCardData->carInfoCRC = crc16((unsigned char *)&memCardData->carInfo,0xe0);
  memCardData->trackInfoCRC = crc16((unsigned char *)&memCardData->trackInfo,0x10);
  memCardData->tournamentCRC = crc16((unsigned char *)&memCardData->tournament,0xb0);
  memCardData->recordsCRC = crc16((unsigned char *)memCardData->records,0xe9c);
}



/* ---- VerifySuccessfulRead  [FEMEMCARD.CPP:75-86] ---- */

/* MATCH: `(cmp) & result` BOOL-accumulation form (SYM: result BOOL) -- the oracle re-masks
   the stored bool in each beq delay slot (andi s0,s0,1 = the fold of `1 & result` on the equal path
   -- BITWISE &, not &&: && normalizes via sltu) then clears on fall-through; a plain
   `if (x != crc) result = false;` chain emits no andi and mis-colors s0/s1. */
#line 72 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static bool VerifySuccessfulRead(tMemCardData *memCardData)


{

  bool result;
  result = memCardData->frontEndCRC == crc16((unsigned char *)&memCardData->frontEnd,0x450);
  result = (memCardData->carInfoCRC == crc16((unsigned char *)&memCardData->carInfo,0xe0)) & result;
  result = (memCardData->trackInfoCRC == crc16((unsigned char *)&memCardData->trackInfo,0x10)) & result;
  result = (memCardData->tournamentCRC == crc16((unsigned char *)&memCardData->tournament,0xb0)) & result;
  result = (memCardData->recordsCRC == crc16((unsigned char *)memCardData->records,0xe9c)) & result;

  result = (memCardData->fSize == 0x14ac) & result;

  return result;
}



/* ---- MakeWayForMemoryCard  [FEMEMCARD.CPP:90-100] ---- */

#line 87 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
void MakeWayForMemoryCard(void)


{









  deltimer(Clock_MasterInterruptHandler);
}



/* ---- BringThatBeatBack  [FEMEMCARD.CPP:108-110] ---- */

#line 105 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
void BringThatBeatBack(void)


{

  addtimer(Clock_MasterInterruptHandler);
}



/* ---- Confirm  [FEMEMCARD.CPP:124-168] ---- */

    /* MATCH arm order: oracle bnez s2 jumps the putbackon arm OUT-OF-LINE; nomessage=1 is the
       fall-through (li v0,1; sw in the j delay slot). */
    /* MATCH: exit-in-the-middle wait loop (top-test + j back); the ==1 exit is written `^ 1`
       so it emits the oracle's xori;beqz -- an `== 1` compare makes gcc hoist li 1 into a
       call-surviving saved reg (loop-invariant) and beq against it. */
    /* SYM-INLINE-THIS: SetString */
    /* P885: direct scalar receiver access retains the retail FEApp reload
       before the SetString store and the address held across the wait loop. */
    /* MATCH: dlgmsg pointer computed BEFORE the TextSys_Word call and HELD across it in a
       callee-saved reg (SYM: inlined tDialogMessageString-`this` block, $s0; oracle
       lw s0,0(s1) + addiu s0,s0,568 in the jal delay slot); the Display arg is a FRESH
       FEApp re-deref (selective/partial caching -- oracle recomputes it). */
    /* Reliable line-9 SYM records these inlined setup roles in the caller's
       original parameter registers ($s2/$s4); they are real uses, not
       declaration-only audit placeholders. */
  /* Existing IsVisible supplies the recorded tDialogBase this in $a0;
     its genuine IF owner replaces the obsolete caller pointer-declaration block.
     Direct Hide reuses that receiver; no noInputDialog caller alias is needed. */
  /* (2026-09-20) tDialogYesNoMem is a real polymorphic class: its implicit ctor stores the derived table after the
     tDialogYesNo ctor returns -- the store the old manual `_vf` poke imitated. */
  /* [2026-07-11 RESTORE] the manual _vf poke was WRONGLY dropped in the wave-5 consolidation:
     this hierarchy uses MANUAL _vf dispatch (not real C++ virtuals), so the implicit
     tDialogYesNoMem ctor does NOT set the derived vtable -- gcc's synthesized ctor only calls
     the base tDialogYesNo ctor. The oracle explicitly stores &_vt_15tDialogYesNoMem to _vf(0x60)
     right after the ctor (`sw v0,0x60(s0)`). Restore it. */
  /* P885: native Confirm records no separate feApp local. Direct scalar
     receiver access preserves the retail load before the stack _vf store;
     the remaining vtable carrier keeps its interleaved address schedule. */
  /* [block-scope fix] MyDialog's decl moved AFTER BringThatBeatBack(): oracle's jal
     BringThatBeatBack precedes the jal __12tDialogYesNo ctor -- the object's ctor fires at
     its point of declaration (C++), so the real source declares it here, not at fn-top. */
  /* [2026-07-11 consolidation] dropped REDUNDANT tDialogYesNo_ctor((tDialogYesNo*)&MyDialog)
     manual call + manual _vf poke: tDialogYesNoMem derives from tDialogYesNo (real declared
     ctor), so the implicit ctor already emits jal __12tDialogYesNo + the tDialogYesNoMem
     vtable store (oracle Confirm__Fii shows exactly ONE ctor jal). tDialogYesNo_ctor is an
     undefined phantom extern (same class as the femenudefs.cpp sweep). */
  /* Reliable SYM records `MyDialog`, `putbackon`, `ret`, nested setup roles
     `num`/`yes`, the inlined Hide receiver, and the later message-string
     receiver. Existing IsVisible now recovers the supplied base receiver;
     2026-11-14 (BYTE+SYM+SLD exact: 109/109, tags 0, blocks 68/68): the setup is the inline members themselves --
     MyDialog.SetString(Text) (retail parameter record `num`), MyDialog.SetChoices(yesText, 0x292, 0) (`yes`),
     MyDialog.SetPosition(0, 10) in the language block, FEApp->MemCardDialog.SetString(CURRENTPLAYER + 0x32b)
     (`this` $16).  frontEnd.language is read directly (FrontEnd() added a pair retail lacks).  The dialog /
     dialogVtable / messageDialog / messageText carriers are removed. */
#line 121 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static int Confirm(int Text,int yesText)


{
  BringThatBeatBack();

  tDialogYesNoMem MyDialog; bool putbackon; int ret; putbackon = false;

    if (FEApp->NoInputMemCardDialog.IsVisible()) {
      /* SYM-INLINE-THIS: Hide */
      FEApp->NoInputMemCardDialog.Hide();
      putbackon = true; } MyDialog.SetString(Text); MyDialog.SetChoices(yesText, 0x292, 0);




    if (frontEnd.language == '\x03')
    { MyDialog.SetPosition(0, 10);
    } ret = MyDialog.Run();

  if (ret == -1)
  { FEApp->MemCardDialog.SetString(CURRENTPLAYER + 0x32b);

    ((tDialogBase *)&FEApp->MemCardDialog)->Display();
    while (!FEApp->MemCardDialog.IsFullyOpen()) {
      FEApp->Redraw();
    } FEApp->Redraw();

    nomessage = 1;   /* per-arm inline store; gcc cross-jumps it into the ret==0 arm's tail */
  }
  else if (ret == 0) {

    nomessage = 1;
  }
  else if (putbackon)
  {
    ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Display();
    while (!FEApp->NoInputMemCardDialog.IsFullyOpen()) {
      FEApp->Redraw();
    }
  } FEApp->Redraw();


  MakeWayForMemoryCard();
  /* [phantom-dtor drop] MyDialog is function-scoped (single return path below); implicit dtor
     auto-fires here, matching oracle's ___7tScreen call right before the epilogue. */
  return ret;
}



/* ---- OverwriteConfirm  [FEMEMCARD.CPP:171-180] ---- */

#line 168 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static int OverwriteConfirm(void)


{



  return Confirm(CURRENTPLAYER + 0x323,0x28f);




  return 0; /* DEVICE (exact-only): retail SLD tags the epilogue on this line, 5 lines after the return; a code-less dead statement carries the line note */
}



/* ---- OverwriteAlwaysYes  [FEMEMCARD.CPP:184-185] ---- */

#line 181 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static int OverwriteAlwaysYes(void)


{
  return 1;
}



/* ---- FormatConfirm  [FEMEMCARD.CPP:191-204] ---- */

#line 188 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static int FormatConfirm(void)


{





  return Confirm(CURRENTPLAYER + 0x327,0x290);






  return 0; /* DEVICE (exact-only): retail SLD tags the epilogue on this line, 7 lines after the return; a code-less dead statement carries the line note */
}



/* ---- LoadingProc  [FEMEMCARD.CPP:209-213] ---- */

#line 206 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static void LoadingProc(void)


{



}



/* ---- LoadingRedrawProc  [FEMEMCARD.CPP:217-221] ---- */

#line 214 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static void LoadingRedrawProc(void)


{



  FEApp->Redraw();
}



/* ---- SavingProc  [FEMEMCARD.CPP:226-230] ---- */

#line 223 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
static void SavingProc(void)


{



  FEApp->Redraw();
}



/* ---- Init_Memcard  [FEMEMCARD.CPP:240-316] ---- */
  /* SYM 8c Def-record order: mcrdopts, padrestorestarttick. */

#line 239 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
void Init_Memcard(bool redraw,bool pinkslips)
{
  MCRDOPTS_def mcrdopts; int padrestorestarttick; if (MEMCARD_INITIALIZED != 0) {
    return; } MEMCARD_INITIALIZED = 1;



  if (MEMCARDFRONTENDISINITTED != 0) {

    AudioMus_StopSong(0);
    timedwait(5);
  }



  PAD_restore();
  padrestorestarttick = FE_Ticks();


  while (FE_Ticks() - padrestorestarttick < 0x3c) {
  }
  deltimer(Clock_MasterInterruptHandler);

  timedwait(0x14);




  MCRD_init(0);





  MCRD_getopts(&mcrdopts);






  mcrdopts.productLocation = (PRODUCTLOC)0;

  mcrdopts.productCode = productCode;
  mcrdopts.bMoveIconsToVram = 0;




  mcrdopts.VramIconArea.x = 0x200; mcrdopts.VramIconArea.y = 0x100; mcrdopts.VramIconArea.w = 0x20; mcrdopts.VramIconArea.h = 0x60;



  mcrdopts.ConfirmFormatProc = FormatConfirm;
  mcrdopts.ConfirmOverwriteProc = pinkslips ? OverwriteAlwaysYes : OverwriteConfirm;


  mcrdopts.LoadingDataProc = redraw ? LoadingRedrawProc : LoadingProc;

  mcrdopts.SavingDataProc = SavingProc;



  MCRD_setopts(&mcrdopts);




  addtimer(Clock_MasterInterruptHandler);
  timedwait(0x14);

  padinit();
  timedwait(0x14);




}

/* ---- DeInit_Memcard  [FEMEMCARD.CPP:321-351] ---- */

#line 320 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
void DeInit_Memcard(void)
{
  int padrestorestarttick;

  if (MEMCARD_INITIALIZED == 0) return;
  MEMCARD_INITIALIZED = 0;





  deltimer(Clock_MasterInterruptHandler);

  MCRD_restore();

  addtimer(Clock_MasterInterruptHandler);

  PAD_restore();
  padrestorestarttick = FE_Ticks();

  while (FE_Ticks() - padrestorestarttick < 0xc0) {
  } padinit();

  if (MEMCARDFRONTENDISINITTED != 0) {

    FEApp->UpdateMusic();
  }




}

/* ---- Init_MemcardFile  [FEMEMCARD.CPP:357-381] ---- */

  /* [branch-polarity fix] oracle's beqz skips the (rare) notitle==true case out-of-line and
     falls straight through the common PlayerNameExist path -- arm order flipped to match
     (catalog wave-3 "if/else ARM ORDER controls beqz/bnez polarity" row). */
#line 354 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
void Init_MemcardFile(MCRDFILE_def &memCardFile,short cardnum,bool notitle)


{
  blockclear(&memCardFile,0x2c);


  memCardFile.name = "NFS4";

  if (notitle) {

    TITLE[0] = '\0';
  }
  else {




    if (PlayerNameExist((uint)(cardnum == 5))) {
      sprintf(TITLE,"%s%s",TextSys_Word(0x278),PlayerName((uint)(cardnum == 5)));
    }
    else { sprintf(TITLE,TextSys_Word(0x279));
    }
  }
  memCardFile.title = TITLE;
  memCardFile.size = 0x1500;
  memCardFile.offset = 0;
  memCardFile.flags = 0; return;
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

  /* [phantom-dtor drop] implicit ___7tScreen(&WarningDialog,2) at scope exit */
    /* 2026-11-14: the message dialog is FEApp->MemCardDialog.SetString(returnmessage + player) (the int overload,
       retail `this` $16 pair) + .Display(); WarningDialog uses SetString(int) + SetPosition(0, 0x32); the card
       status test is the MemCard_IsReady() inline; `card` is a function-scope local; the body from line 418 to
       purgememadr is one plain scope (retail BLOCK 24..162).  dlgmsg / message / displayDialog are removed.
       OPEN: with the natural tail (no do/while(0) scopes) the SYM block tree is IDENTICAL to retail (72/72) but the
       s5/s6/s7 cluster below flips (FAIL 26); a loop region over retail's lines 162..178 replaces the inner scope
       only (FAIL 12).  The two degenerate scopes therefore stay until the natural re-weighting is found. */
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
  /* Actual WarningDialog supplies the ctor/TextSys/Display address chain;
     no separate wd source object is needed in this verified form. The
     three non-zero-constant fields and both call args still use s0;
     zeros/vtables remain sp-direct. Original literal spelling is unproved. */
  /* WarningDialog is declared after the loop at the oracle's `jal __7tScreen` position;
     declaration order matches the SYM stack layout.  Its header-inline constructor above
     emits the retail base/vtable/field chain. */
    /* MATCH: index-form AnalogOn[i] (strength-reduces to the oracle's +4 walker);
       (i != 0) * 4 keeps the sltu index-select. Set-then-conditional-reset pair. */
#line 392 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
bool SaveGame(short player)


{
  /* SYM reg map: finished=s3(BOOL) event=s0 returnvalue=s6(BOOL) returnmessage=s2
     shapeFile=s7(char*); cardNum = AUTO SHORT (stack, sp+0x16C8); i = block-scoped a2;
     player REGPARM s5. */
  tMemCardData memCardData;
  char memorycardbuffer [256];
  CURRENTPLAYER = player;
  CURRENTLYUSINGMEMCARD = 1;
  {
    int i;
    for (i = 0; i < 2; i++) {

      frontEnd.AnalogOn[i] = 1;
      if (gPadinfo.buf[(uint)(i != 0) * 4].ID != 's') {
        frontEnd.AnalogOn[i] = 0;
      } }
  }
  tDialogNoInputMessage WarningDialog;
  short cardNum; MCRDFILE_def memCardFile; char *shapeFile; char shapeFileName [64]; bool finished; int event; bool returnvalue; int returnmessage; CARDINFO_def *card; WarningDialog.SetString(player + 0x276);

  WarningDialog.SetPosition(0, 0x32); WarningDialog.Display();
  while (!WarningDialog.IsFullyOpen()) {   /* xori;beqz -- see Confirm */
    FEApp->Redraw();
  } finished = false; FEApp->Redraw(); {

  cardNum = player * 4 + 1;

  nomessage = 0;






  returnvalue = finished;   /* oracle: addu s6,s3,zero -- the false is a COPY of finished */


  returnmessage = 0x28b;


  MakeWayForMemoryCard();


  Init_MemcardFile(memCardFile,cardNum,false);
  memCardFile.pData = (u_char *)&memCardData;

  while (MCRD_handlecardevents(cardNum) == 0x15) {




    VSync(0);
  }

  blockmove(&frontEnd,&memCardData.frontEnd,0x450);
  tournamentManager.SaveTournament(memCardData.tournament);
  trackManager.SaveTracks(memCardData.trackInfo);
  carManager.SaveCars(memCardData.carInfo);
  blockmove(Stats_gTrackRecords,memCardData.records,0xe9c);
  memCardData.pinkSlipsNoCheat = rand();
  FECheat_SaveBonus(memCardData.bonus);


  sprintf(shapeFileName,"%szMem.psh",Paths_Paths[0x20]);
  shapeFile = (char *)loadshapeadr(shapeFileName,(void *)0x0);

  memCardFile.flags = 0x200;
  memCardFile.icon[0] = shapepointer(shapeFile,0);
  memCardFile.icon[1] = (shapetbl *)0x0;
  memCardFile.icon[2] = (shapetbl *)0x0;




  ChecksumData(&memCardData);
  /* switch-loop: real switch, case bodies in oracle VA order (0x16 / 0xc / getcard arm);
     default = re-poll. */


  while (true) { if (finished) break;

    event = MCRD_handlecardevents(cardNum);
    systemtask(0);
    VSync(0);

    switch(event)
    {
    case 0x16:
      if (MemCard_IsReady() != 0) {




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
      
        /* retail SaveGame preamble carries a CARDINFO_def TPDEF: the card pointer is a real local (function scope:
           retail has no block here); its single use as a load base is combined away (no SYM record). */


        card = MCRD_getcard(player * 4 + 1);
        returnmessage = 0x29d;
        if (card->status != -3) {
          returnmessage = 0x325;


          if (card->status == -1) {

            returnmessage = 0x32b;
          }
        }
      
      






      finished = true;
      break;




    default:
      break;
    }
  }

  while (MCRD_handlecardevents(cardNum) != 0x16) {




    VSync(0);
  }

  purgememadr(shapeFile); }




  BringThatBeatBack();
  do {


  if (nomessage == 0) do {

    ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
    FEApp->MemCardDialog.SetString(returnmessage + player);
    FEApp->MemCardDialog.Display();
    while (!FEApp->MemCardDialog.IsFullyOpen()) {
      FEApp->Redraw();
    } FEApp->Redraw();
  } while (0);


  screenMemcard->fGetNewIcons = 1;

  ((tDialogBase *)&WarningDialog)->Hide();
  FEApp->Redraw();

  CURRENTLYUSINGMEMCARD = 0;
  return returnvalue;
  } while (0); }



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
/* SYM reg map: cardNum=s3(SHORT) finished=s1(BOOL) result=s4 memCardResult=s0 count=fp
   returnmessage=s2; pCI + the fail-dialog `this` are block-scoped s0. player/PinkSlips/
   WithDialogs are ARG class (arg-slot spilled, reloaded per use).  WarningDialog is
   declared after the two global stores (oracle jal __7tScreen follows them); memCardFile
   after it (stack layout memCardData / buffer / WarningDialog / memCardFile).  The
   switch-loop is a real `switch` with case bodies in oracle VA order -- 0x16 (loadfile),
   0xf (verify), getcard arm last; default = re-poll.  Statements sit on their retail SLD
   lines (FRONT4); residual: the inline WarningDialog ctor is tagged with the preceding
   statement's line, retail line 0 (29 words). */

  /* 2026-11-15 (BYTE+SYM+SLD exact: 374/374, tags 0, blocks 41/41): the dialogs use the inline members
     (WarningDialog.SetPosition(0, 0x32) in the !PinkSlips block, FEApp->MemCardDialog.SetString(int) + Display());
     pCI is declared in the switch body (retail records it at that depth), the two dialog guards are single
     `WithDialogs && nomessage == 0` conditions (one test line, scope + block), every arm ends in `break;` (each
     break leaves an empty block: retail has one per arm).  The dlgmsg / dialogText / dialogBase carriers are gone. */
#line 588 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
short LoadGame(short player,bool PinkSlips,bool WithDialogs)


{
  tMemCardData memCardData;
  char memorycardbuffer [256];
  short cardNum;
   /* Pass the actual short cardNum; call conversions supply its signed value. */

  CURRENTPLAYER = player;

  CURRENTLYUSINGMEMCARD = 1;
  cardNum = player * 4 | 1;
  tDialogNoInputMessage WarningDialog; MCRDFILE_def memCardFile; bool finished; int result; int memCardResult; int count; int returnmessage;



  if ((WithDialogs != 0) || (PinkSlips != 0))
  { WarningDialog.SetString(player + 0x276);


    if (PinkSlips == 0)
    { WarningDialog.SetPosition(0, 0x32);
    }
    ((tDialogBase *)&WarningDialog)->Display();
    while (!WarningDialog.IsFullyOpen()) {   /* xori;beqz -- see Confirm */
      FEApp->Redraw();
    } FEApp->Redraw();
  }
  nomessage = 0;

  finished = false;
  result = 0;


  count = 0x2c; if (WithDialogs != 0) count = 0;
  returnmessage = 0x28d;

  do
  {
  count = count + 1; MakeWayForMemoryCard();


  Init_MemcardFile(memCardFile,(short)(cardNum),true);
  while (MCRD_handlecardevents(cardNum) == 0x15) {




    VSync(0);
  }

  memCardFile.pData = (u_char *)&memCardData;
  memCardFile.flags = 0;

  while (true) { if (finished) break;

    memCardResult = MCRD_handlecardevents(cardNum);
    systemtask(0);
    VSync(0);



    switch(memCardResult)
    { CARDINFO_def *pCI;
    case 0x16:



      MCRD_loadfile(cardNum,&memCardFile,0);
      break;
    case 0xf:

      if (VerifySuccessfulRead(&memCardData)) {
        result = 0;





        if (PinkSlips == 0) {

          if (player == 0) {

            blockmove(&memCardData.frontEnd,&frontEnd,0x450);
            tournamentManager.LoadTournament(memCardData.tournament);
            trackManager.LoadTracks(memCardData.trackInfo);
            blockmove(memCardData.records,Stats_gTrackRecords,0xe9c);

            FECheat_LoadBonus(memCardData.bonus);
          }
          else {
            sprintf(frontEnd.playerNameList[player],memCardData.frontEnd.playerNameList[0]);   /* CORRECTNESS: [player]*8 stride (was [player*4] = *32 OOB) */
          }
          carManager.LoadCars(memCardData.carInfo,player);
        }
        else {


          frontEnd.gPinkSlipsNoCheat[player] = memCardData.pinkSlipsNoCheat;
          carManager.LoadPinkSlipsCars(memCardData.carInfo,player);
          sprintf(frontEnd.playerNameList[player],memCardData.frontEnd.playerNameList[0]);   /* CORRECTNESS: [player]*8 stride (was [player*4] = *32 OOB) */
          frontEnd.pinkSlipsCash[player] = memCardData.tournament.fSaveMoney;
        }
        returnmessage = 0x28d;

        SetPads();
      }
      else
      {
        result = 1;
        if ((WithDialogs != 0) && (nomessage == 0))
          {
            ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
            ((tDialogBase *)&FEApp->MemCardDialog)->Hide(); FEApp->MemCardDialog.SetString(player + 0x329);

            FEApp->MemCardDialog.Display();
          }
        



      } finished = true;
      break;
    case 2:
    case 3:
    case 7:
    case 10:
    case 0xb:
    case 0x10:
    case 0x17:
      



        pCI = MCRD_getcard(player * 4 + 1);


        ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
        if (pCI->status == -2) {




          returnmessage = 0x29f;
          result = 2;
        }
        else { result = 1; if (pCI->status == -1) {

            result = 3;



            returnmessage = 0x32b;
          }
          else {





            returnmessage = 0x329;
          }
        }
      
      finished = true;
      break;
    }
  }

  while (MCRD_handlecardevents(cardNum) != 0x16) {




    VSync(0);
  }






  BringThatBeatBack();

  } while ((returnmessage != 0x28d) && (count < 3));


  if ((WithDialogs != 0) && (nomessage == 0))
    {
      ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
      ((tDialogBase *)&FEApp->MemCardDialog)->Hide();
      FEApp->MemCardDialog.SetString(returnmessage + player);
      FEApp->MemCardDialog.Display();
      while (!FEApp->MemCardDialog.IsFullyOpen()) {
        FEApp->Redraw();
      } FEApp->Redraw();
    }
  



  Front_ResetPSXController((int)player,(uint)(byte)frontEnd.controlConfig[player]);

  if (PinkSlips == 0) {


    if (frontEnd.raceType == RaceType_PinkSlips) {
      frontEnd.raceType = RaceType_SingleRace;
    } gMasterSFXLevel = (int)(byte)frontEnd.sfxVolume;
  }


  if ((WithDialogs != 0) || (PinkSlips != 0)) {


    ((tDialogBase *)&WarningDialog)->Hide();
  }
  if (WithDialogs != 0) {

    FEApp->Redraw();
  }
  CURRENTLYUSINGMEMCARD = 0;

  return result; }



/* ---- SavePinkSlipsCars  [FEMEMCARD.CPP:818-1069] ---- */

/* The 4-arg member tCarManager::SavePinkSlipsCars(tSaveCarInfo &, short, short) is declared on
   this owner's tCarManager surface (fe_core_types.h; oracle jal ...R12tSaveCarInfoss, a3 =
   withoutCarInGarageNumber). */

PinkSlipsErrorCode
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
              /* SYM-CODEGEN-CARRIER: cardInfo -- each switch arm must retain the
                 single MCRD_getcard result across multiple status tests. */
        /* MATCH (2026-08-15, 25 -> PASS): the two operand-free boundaries add
           four live units to the LICM-hoisted inner jump-table base.  This drops
           its global-alloc priority below the sign-extended player and restores
           retail's player=$s4 / table=$s6 handout without emitting bytes.  In
           that basin the retail player*4+1 recomputation no longer triggers the
           old loop.c spill cascade.  The boundary after MCRD_getcard keeps the
           CardFull constant in retail's status-branch delay slot.  Finally, the
           two forward labels reproduce retail's distinct read-failure block and
           the shared outer-case `finished` tail.  Detailed gate: PASS 226/226. */
      /* MATCH arm order: success path INLINE (beqz jumps the fail block out-of-line to the
         arm end); nocheat-mismatch = 2-insn inline wedge (beq skips it into the save body). */
  /* outer switch-loop: real switch (jtbl_800117A8), case bodies in oracle VA order --
     0x16 loadfile / 0xf verify+save / 2,0x10 getcard / 3,7,a,b,0x17 fail; default re-poll.
     (NEGATIVE: goto-loop form recolors the head, 102->146 -- the oracle's per-arm recompute
     of player*4 is a sext-pseudo split, not missing loop notes.) */
  /* SYM reg map: shapeFile=s7 finished=s3(BOOL) finishedsave=s5(BOOL)
     result=s2(ENUM PinkSlipsErrorCode) memCardResult/event=s0 (block-scoped);
     player REGPARM fp; withoutCarInGarageNumber ARG (stack); cardNum AUTO SHORT. */
#line 815 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
SavePinkSlipsCars(short player,short withoutCarInGarageNumber)


{
  tMemCardData memCardData;
  char memorycardbuffer [256]; char *shapeFile; char shapeFileName [64]; short cardNum; MCRDFILE_def memCardFile; bool finished; bool finishedsave; PinkSlipsErrorCode result; int memCardResult; int event; MakeWayForMemoryCard();






  CURRENTPLAYER = player;

  CURRENTLYUSINGMEMCARD = 1;




  cardNum = player * 4 + 1;
  nomessage = 0;

  finished = false;
  finishedsave = false;              /* oracle: s5/s2 = copies of s3's 0 */
  result = PinkSlipsNoError;




  sprintf(shapeFileName,"%szMem.psh",Paths_Paths[0x20]);
  shapeFile = (char *)loadshapeadr(shapeFileName,(void *)0x0);



  Init_MemcardFile(memCardFile,cardNum,true);
  while (MCRD_handlecardevents(cardNum) == 0x15) {




    VSync(0);
  }

  memCardFile.pData = (u_char *)&memCardData;
  memCardFile.flags = 0;

  while (true) { if (finished) break;

    memCardResult = MCRD_handlecardevents(cardNum);
    systemtask(0);
    VSync(0);
    switch(memCardResult)
    {
    case 0x16:



      MCRD_loadfile(cardNum,&memCardFile,0);
      break;
    case 0xf:

      if (VerifySuccessfulRead(&memCardData))
      {





        if (frontEnd.gPinkSlipsNoCheat[player] != memCardData.pinkSlipsNoCheat) {
          /* anti-cheat token mismatch: not the original card */
          finished = true;
          result = (PinkSlipsErrorCode)finished;   /* oracle: addu s2,s3,zero -- =1 NotOriginalCard as a COPY of finished */




          break;
        }









        carManager.SavePinkSlipsCars(memCardData.carInfo,player,withoutCarInGarageNumber);





        while (MCRD_handlecardevents(cardNum) == 0x15) {




          VSync(0);
        }


        memCardFile.flags = 0x200;
        memCardFile.icon[0] = shapepointer(shapeFile,0);
        memCardFile.icon[1] = (shapetbl *)0x0;
        memCardFile.icon[2] = (shapetbl *)0x0;




        ChecksumData(&memCardData);




        while (true) { if (finishedsave) break;

          event = MCRD_handlecardevents(cardNum);
          systemtask(0);
          VSync(0);

          switch(event)
          {
          case 0x16:
            if (MemCard_IsReady() != 0) {




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




            {
              ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();


              CARDINFO_def *cardInfo = MCRD_getcard(player * 4 + 1);
              __asm__(""); result = PinkSlipsError_CardFull; if (cardInfo->status != -3) {
                result = PinkSlipsError_SaveFailed;


                if (cardInfo->status == -1) {

                  result = PinkSlipsError_CardNotFound;
                }
              }

              (void)result; /* DEVICE (exact-only): code-less statement = retail surviving line-167 note (arm block }168); the finishedsave store (170) is moved into the break delay slot */ }


            finishedsave = true;






            break;
          }
        }

      }
      else {
        /* MATCH/CFG (w65-a1): retail's read-failure arm sets the code and joins
           the SHARED outer `finished = true` tail (branch word 5: ours +103 vs
           retail +88) -- see the case-3 arm below for the role swap this pairs
           with, and the jump-table proof in scratchpad/w65a1/RECEIPTS.md. */


        result = PinkSlipsError_LoadFailed;

      }
      finished = true; break;


    case 2:
    case 0x10:
      {

        CARDINFO_def *cardInfo = MCRD_getcard(player * 4 + 1);
        result = PinkSlipsError_NotFormatted; if (cardInfo->status != -2) {
          result = PinkSlipsError_LoadFailed;


          if (cardInfo->status == -1) {

            result = PinkSlipsError_CardNotFound;
          }
        }


      finished = true;

      break; }
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

  CURRENTLYUSINGMEMCARD = 0;
  return result;
}



/* ---- SavePinkSlipsCarsWithErrorDialogs  [FEMEMCARD.CPP:1090] ---- */
PinkSlipsErrorCode
    /* [block-scope fix] WarningDialog constructed/destructed FRESH every retry iteration --
       oracle's jal __7tScreen sits at the loop top (per-iteration ctor) and the matching
       ___7tScreen dtor fires exactly once, right after the error-dialog block below, BEFORE
       the loop-back/return decision -- i.e. WarningDialog is scoped to a nested block that
       ends there, not to the whole do-loop body. Declaring it fn-scope (old code) or letting
       an unscoped do-loop-body local live past that point does not reproduce the single,
       fixed dtor call site. */
  /* [2026-07-11 consolidation] dropped REDUNDANT tDialogYesNo_ctor(&RetryCancelDialog) +
     tScreen_ctor((tScreen*)&WillLoseCarMessage) manual calls: both are undefined phantom
     externs; the real declared ctors (tDialogYesNo(), tScreen() via the ctor-less tDialog*
     intermediate chain) auto-fire at declaration -- oracle shows exactly one
     jal __12tDialogYesNo + one jal __7tScreen here. RetryCancelDialog/WillLoseCarMessage are
     function-scoped (constructed once, destructed once at the single `return err;` below --
     manual tScreen_dtor calls for them dropped too, oracle's two ___7tScreen calls right
     before the epilogue are exactly the implicit auto-dtors at function scope exit). */
  /* MATCH W64/P101 PASS (45 -> 0, 219 instructions): rely on the generated
     tDialogNoInputMessage construction chain instead of replaying its stores.
     SYM records no `rc` or `dialog` caller locals: SetChoices reconstructs the
     one-line inline tDialogYesNo receiver at line 1105, and SetString restores
     the later inline tDialogMessageString receiver after sprintf. */
  /* 2026-11-14 (bytes 219/219, tags 0, block tree 47/47 as retail): WarningDialog is a do-body local next to
     `count` (retail records both in one block; the loop is `do { ... } while (err && retry)` + one `return err`),
     its word lookup sits on the declaration line (retail tags the TextSys_Word call there; the temporary is
     combined away), and the setup is SetString / SetPosition(int, int) as separate statements -- the chained form
     and short parameters both flip the s3/s4 loop invariants.  RetryCancelDialog = SetChoices(yes, no, default) +
     SetSpecificPlayer(player) (retail: one `this` pair + one record-less pair).  Supersedes the nested-block note
     above.  OPEN (SLD only): retail numbers the synthesized destructor blocks 1 (line notes inside compiler-
     generated members survive when the note file is the main input file); ours shows the caller line. */
#line 1087 "C:/nfs4/FRONTEND/COMMON/FEMEMCARD.CPP"
SavePinkSlipsCarsWithErrorDialogs(short player,short WillLoseCar,short withoutCarInGarageNumber)


{



  tDialogYesNo RetryCancelDialog;
  tDialogNoInputMessage WillLoseCarMessage;
  char string [500];
  char string2 [500];
  PinkSlipsErrorCode err;
  int retry;




  retry = 0;
  RetryCancelDialog.SetChoices(0x291, 0x292, 1); RetryCancelDialog.SetSpecificPlayer(player); do
  {

    ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Display();
    while (!FEApp->NoInputMemCardDialog.IsFullyOpen()) {   /* xori;beqz */
      FEApp->Redraw();
    } int count; count = 0; FEApp->Redraw(); tDialogNoInputMessage WarningDialog; char *warningText = TextSys_Word(player + 0x276);






      WarningDialog.SetString(warningText); WarningDialog.SetPosition(0, 0x32); WarningDialog.Display();
      while (!WarningDialog.IsFullyOpen()) {   /* xori;beqz */
        FEApp->Redraw();
      } FEApp->Redraw();
      do {


        err = SavePinkSlipsCars(player,withoutCarInGarageNumber);



        if (err != PinkSlipsNoError) {
          timedwait(5);
        }
        count = count + 1;
      } while ((err != PinkSlipsNoError) && (count < 3));

      ((tDialogBase *)&WarningDialog)->Hide();
      FEApp->Redraw();


      if (err != PinkSlipsNoError)
      {
        ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();

        sprintf(string,TextSys_Word(textSysMemCardFail_Index[err] + player));

        if (WillLoseCar != 0)
        { sprintf(string2,TextSys_Word(WillLoseCar == 2 ? 0x299 : 0x298),
                  PlayerName(player)); WillLoseCarMessage.SetString(string2); WillLoseCarMessage.SetPosition(0, -0x3c);


          WillLoseCarMessage.Display();
        }



        RetryCancelDialog.SetString(string); retry = RetryCancelDialog.Run();

        ((tDialogBase *)&WillLoseCarMessage)->Hide();
      }


  } while ((err != PinkSlipsNoError) && (retry != 0));
  return err;
}



/* end of fememcard.cpp */

/* w60 link-debt fix: ___19tMemoryCardMenuItem was multiply-defined here AND in
 * femenuoptions.cpp.  SYM ownership proof: `Set SLD to line 425 of file
 * ...FEMENUOPTIONS.H`, `$80020bd8 94 Def class EXT ... _._19tMemoryCardMenuItem`
 * => FEMenuOptions.obj owns it; this copy removed. */
