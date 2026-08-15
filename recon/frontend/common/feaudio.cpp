/* frontend/common/feaudio.cpp -- RECONSTRUCTED (NFS4 front-end audio / commentary; C++ TU)
 *   10 free Feaudio_* fns (commentary VIV streaming, speech levels, language select).
 */
#include "feaudio.h"

/* ---- Feaudio.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes / .bss zero) ---- */
/* gStopCommentaryNow leads the run at 0x800514c8, BEFORE the two initialised
   objects -- a tentative definition can never do that (16E), so retail's source
   initialised it explicitly.  gcc-2.8 has no zero-initialized-in-bss pass, so
   `= 0` keeps it in .data at the head of the definition order. */
int          gStopCommentaryNow = 0;   /* @0x800514c8 */
signed char  gCurrentVIV = -1;   /* @0x800514cc */
char *allLanguages[6] = {"zEngl","zGerm","zFren","zSpan","zItal","zSwed"};   /* @0x800514d0 .rodata prefixes */
SPEECHINFO   ginfo;   /* @0x800514e8  (bss(zero)) */
/* speechfileHeader declared (unsized-array form) in feaudio_externs.h; accessed [0] so the value-load
   into an arg reg is non-gp + separate v0 scratch (matches oracle lui v0; lw a0,(v0)); §3.15-CORRECTION.
   MIGRATED here W66-A5 (SYM Feaudio.obj block owns 0x8005150c). */
LUMPYHEAD   *speechfileHeader[1];   /* @0x8005150c */
char         currentSpeechViv[40];   /* @0x80051510  (bss(zero)) */
int          commentaryActualLevel;   /* @0x80051538  (bss(zero)) */


/* ---- FEAudio_StartLoadPatch  [FEAUDIO.CPP:43-64] SLD-VERIFIED ---- */

int FEAudio_StartLoadPatch(SPEECHINFO *info)

{
  int iVar1;
  char *pcVar2;
  int offset;
  int length;
  
  asyncidle();
  FeAudio_LocateBigfile(speechfileHeader[0],info->name,&offset,&length);
  if (offset == 0) {
    return 0;
  }
  if (length == 0) {
    return 0;
  }
  if (info->sSpeechData != (char *)0x0) {
    purgememadr(info->sSpeechData);
    info->sSpeechData = (char *)0x0;
  }
  pcVar2 = FeAudio_StartBigfileRead("",offset,length,&info->vivHandle);
  info->sSpeechData = pcVar2;
  iVar1 = 1;
  info->areLoading = '\x01';
  info->playNextOne = '\0';
  return iVar1;
}



/* ---- Feaudio_StartPatch  [FEAUDIO.CPP:68-121] SLD-VERIFIED ---- */

void Feaudio_StartPatch(SPEECHINFO *info)

{
  int iVar1;
  char *pcVar2;
  SNDPLAYOPTS playopts;
  
  if (info->sSpeechData != (char *)0x0) {
    iVar1 = SNDbankadd(&info->nHandle,info->sSpeechData);
    if (iVar1 == 7) {
      iVar1 = SNDbankheadersize(info->nHandle);
      pcVar2 = reservememadr((char *)(bigBuf + 0x104),iVar1,0x10);
      info->pBankHeader = pcVar2;
      SNDbankheadercopy(pcVar2,info->nHandle);
      if (info->sSpeechData != (char *)0x0) {
        purgememadr(info->sSpeechData);
        info->sSpeechData = (char *)0x0;
      }
    }
    else {
      pcVar2 = info->sSpeechData;
      info->sSpeechData = (char *)0x0;
      info->lastSpeechData = pcVar2;
    }
    SNDplaysetdef(&playopts);
    playopts.bhandle = (char)info->nHandle;
    playopts.patnum = 0;
    playopts.vol = (char)commentaryActualLevel;
    iVar1 = SNDplay(&playopts);
    info->nSoundHandle = iVar1;
    info->soundIsPlaying = '\x01';
    if (info->multiplay != 0) {
      if ((u_char)info->name[2] < 0x7a) {
        gCurrentVIV = gCurrentVIV + '\x01';
        info->name[2] = info->name[2] + '\x01';
        FEAudio_StartLoadPatch(info);
      }
      else {
        info->areLoading = '\0';
        info->playNextOne = '\0';
      }
    }
  }
  return;
}



/* ---- FeAudio_systemtask  [FEAUDIO.CPP:124-204] SLD-VERIFIED ---- */

void FeAudio_systemtask(int x)

{
  int ti1;
  int rd_status;
  u_int snd_over;
  int tu3;
  int i;
  int iVar1;
  u_int tu1;
  
  systemtask(x);
  if ((ginfo.areLoading != '\0') &&
     (rd_status = getasyncreadstatus(ginfo.vivHandle), rd_status != 0)) {
    ginfo.areLoading = '\0';
    ginfo.playNextOne = '\x01';
  }
  if ((ginfo.soundIsPlaying != '\0') &&
     (snd_over = SNDover(ginfo.nSoundHandle), snd_over != 0)) {
    SNDautovol((void *)ginfo.nSoundHandle,0,-1);
    SNDbankremove(ginfo.nHandle);
    if (ginfo.lastSpeechData != (char *)0x0) {
      purgememadr(ginfo.lastSpeechData);
      ginfo.lastSpeechData = (char *)0x0;
    }
    if (ginfo.pBankHeader != (char *)0x0) {
      purgememadr(ginfo.pBankHeader);
      ginfo.pBankHeader = (char *)0x0;
    }
    if (ginfo.areLoading != '\0') {
      while (i = getasyncreadstatus(ginfo.vivHandle), i == 0) {
        systemtask(0);
      }
      ginfo.areLoading = '\0';
      ginfo.playNextOne = '\x01';
    }
    ginfo.soundIsPlaying = '\0';
    ginfo.nHandle = 0;
    if (((*(u_int*)((char*)&ginfo + 16)) & 0xff00ff) == 0) {
      gStopCommentaryNow = 1;
    }
  }
  if (gStopCommentaryNow != 0) {
    gCurrentVIV = -1;
    if (ginfo.areLoading != '\0') {
      while (iVar1 = getasyncreadstatus(ginfo.vivHandle), iVar1 == 0) {
        systemtask(0);
      }
    }
    if (ginfo.soundIsPlaying != '\0') {
      SNDautovol((void *)ginfo.nSoundHandle,0,-1);
      SNDbankremove(ginfo.nHandle);
    }
    AudioMus_Volume(gMasterMusicLevel * 0x46 >> 7);
    if (ginfo.sSpeechData != (char *)0x0) {
      purgememadr(ginfo.sSpeechData);
      ginfo.sSpeechData = (char *)0x0;
    }
    if (ginfo.lastSpeechData != (char *)0x0) {
      purgememadr(ginfo.lastSpeechData);
      ginfo.lastSpeechData = (char *)0x0;
    }
    if (ginfo.pBankHeader != (char *)0x0) {
      purgememadr(ginfo.pBankHeader);
      ginfo.pBankHeader = (char *)0x0;
    }
    ginfo.soundIsPlaying = '\0';
    ginfo.playNextOne = '\0';
    gStopCommentaryNow = 0;
    ginfo.areLoading = '\0';
  }
  if ((ginfo.playNextOne != '\0') && ((*(u_short*)((char*)&ginfo + 16)) == 0)) {
    Feaudio_StartPatch(&ginfo);
    ginfo.playNextOne = '\0';
  }
  return;
}



/* ---- FeAudio_AsyncPlayCommentary  [FEAUDIO.CPP:210-231] SLD-VERIFIED ---- */

short FeAudio_AsyncPlayCommentary(char *name)

{
  int ok;
  
  commentaryActualLevel = gMasterFENarrationLevel * 0x6e >> 7;
  if (0x5a < commentaryActualLevel) {
    commentaryActualLevel = 0x5a;
  }
  strncpy(ginfo.name,name,4);
  ginfo.nHandle = 0;
  ginfo.nSoundHandle = 0;
  ginfo.multiplay = (int)(*name != 'c');
  ginfo.areLoading = '\0';
  ginfo.soundIsPlaying = '\0';
  ginfo.playNextOne = '\0';
  ginfo.pBankHeader = (char *)0x0;
  ginfo.sSpeechData = (char *)0x0;
  ginfo.lastSpeechData = (char *)0x0;
  ginfo.vivHandle = 0;
  gCurrentVIV = -1;
  ok = FEAudio_StartLoadPatch(&ginfo);
  if (ok != 0) {
    AudioMus_Volume(gMasterMusicLevel * 0x23 >> 7);
  }
  return 1;
}



/* ---- FeAudio_AsyncPlaySpeech  [FEAUDIO.CPP:235-247] SLD-VERIFIED ---- */

short FeAudio_AsyncPlaySpeech(int type,int index)

{
  char vivname [5];
  
  if (type == 2) {
    sprintf(vivname,(char *)(bigBuf + 0x110),99,index);
  }
  else if (type == 0) {
    sprintf(vivname,(char *)(bigBuf + 0x118),0x61,index + 0x61);
  }
  else {
    sprintf(vivname,(char *)(bigBuf + 0x118),type + 0x61,index + 0x30);
  }
  return FeAudio_AsyncPlayCommentary(vivname);
}



/* ---- FeAudio_StartBigfileRead  [FEAUDIO.CPP:253-269] SLD-VERIFIED ---- */

char * FeAudio_StartBigfileRead(char *fname,int offset,int length,int *vivHandle)

{
  char *streamBuffer;
  int iVar1;

  if (length == 0) {
    return (char *)0x0;
  }
  streamBuffer = reservememadr((char *)(bigBuf + 0x120),length,0);
  if (streamBuffer == (char *)0x0) {
    return (char *)0x0;
  }
  setasyncfile(fname);
  iVar1 = asyncloadsegment((char *)offset,streamBuffer,length);
  *vivHandle = iVar1;
  return streamBuffer;
}



/* ---- FeAudio_LocateBigfile  [FEAUDIO.CPP:274-302] SLD-VERIFIED ---- */

void FeAudio_LocateBigfile(LUMPYHEAD *bigfileHeader,char *name,int *offset,int *length)

{
  char *tempChar;
  FILEINFO *info;
  u_int i;
  
  *offset = 0;
  *length = 0;
  if (bigfileHeader != (LUMPYHEAD *)0x0) {
    info = (FILEINFO *)(bigfileHeader + 1);
    i = 1;
    if (bigfileHeader->num != 0) {
      do {
        if (strcmp(name,info->name) == 0) {
          *offset = info->offset << 0x18 | (info->offset & 0xff00) << 8 |
                    (info->offset & 0xff0000) >> 8 | (info->offset & 0xff000000) >> 0x18;
          *length = info->length << 0x18 | (info->length & 0xff00) << 8 |
                    (info->length & 0xff0000) >> 8 | (info->length & 0xff000000) >> 0x18;
          return;
        }
        tempChar = info->name;
        if (*tempChar != '\0') {
          do {
            tempChar = tempChar + 1;
          } while (*tempChar != '\0');
        }
        info = (FILEINFO *)(tempChar + 1);
      } while (i++ < bigfileHeader->num);
    }
  }
  return;
}



/* ---- FeAudio_InitViv  [FEAUDIO.CPP:305-347] SLD-VERIFIED ---- */

LUMPYHEAD * FeAudio_InitViv(char *fname)

{
  int vivHandle;
  LUMPYHEAD lumpHead;
  LUMPYHEAD *bigfileHeader;
  char *lumpyName;
  
  setasyncfile(fname);
  vivHandle = asyncloadsegment((char *)0x0,&lumpHead,0x10);
  do {
    systemtask(0);
  } while (getasyncreadstatus(vivHandle) == 0);
  /* MATCH (W66): 0x80010130 contains the real source literal "lumpyhead".
     Naming it before a zero-byte statement boundary lets reorg place its %hi
     in the retail loop-exit delay slot.  The pointer
     is optimized away: no extra SYM local, frame byte, or instruction remains.
     Falsified basins: plain literal 27, no boundary 54, bigBuf base+late offset
     23, explicit header temporaries 25-51, macro-block/inline-helper forms 22-54. */
  lumpyName = "lumpyhead";
  __asm__("" : : "i"(0));
  {
    u_int swappedType = lumpHead.type;
    u_int swappedResult;
    u_int headerLength;
    u_int headerNum;

    swappedResult = swappedType << 0x18 | (swappedType & 0xff00) << 8 |
                    (swappedType & 0xff0000) >> 8;
    swappedType >>= 0x18;
    swappedResult |= swappedType;
    swappedType = swappedResult;

    /* MATCH: fence the computed value before publishing it.  This preserves
       the swap while allowing the hlen/num loads to fill retail's slots.
       Splitting the three high-byte terms from the destructive final shift
       gives the source word retail's a3 handout (12 -> 7 diffs, 110/109).
       The remaining residual is one copy back into the long-lived carrier;
       removing it returns the input to a1 and loses the allocation gain.

       W60-A10 -- THE COUNT-EXACT BASIN, PROBED AND UNWOUND (kept as a receipt).
       Swapping this identity fence for a READ-ONLY fence on the result word
       (`__asm__("" : : "r"(swappedResult));`) deletes the copy and lands the
       body STRUCTURALLY EXACT: 109/109 insns, `sw v1,16(sp)` direct (no
       carrier), and BOTH later loads (`lw a1,28(sp)` hlen, `lw a3,24(sp)` num)
       in retail's slots.  The whole residual collapses to ONE pseudo's home:
       the first swap's SOURCE word gets $a1, retail gives it $a3 (6 renamed
       insns + the load's position inside the `lui a0 / addiu a0` string-address
       pair) => authoritative 12 diffs vs this shape's 7, so it is NOT landed.
       FALSIFIED follow-ups on that basin (all still 12, none reached $a3):
       decl-order x4 (hlen/num first, result first, num first, split decl-init);
       hoisting both header loads into the decl inits (36); a read-only
       fence on the SOURCE word, 1 and 2 operands (27, +1 insn); void-fence removal / re-siting
       (17) and a read-only fence on lumpyName (12); dropping the carrier copy
       and storing swappedResult straight (12); writing the first swap as ONE
       inline expression like its two siblings (12); fence-before-copy (34).
       => the last dial is a local-alloc QTY handout (the AGENT_GUIDE Sec.4.6 /
       06E gap), not a source shape.  Re-attack with the qtytrace lane.

       W60-A10 ROUND 2 -- INSTRUMENT LANE: MECHANISM READ, NOT GUESSED.
       The lab cc1plus (gcc-2.8.1) does NOT reproduce this fn (8/10 of the TU
       byte-identical, InitViv d94), so its trace is not a receipt here; the
       evidence below is from the REAL CC1PLPSX run with `-dl -dg`
       (scratchpad/w60a10lab, harness fast.py):

         THIS shape (identity fence, 7 diffs / 110 insns)
           ;; 3 regs to allocate: 86 81 82
           p86 refs=9 live=16 "dies in 2 places"  -> GLOBAL -> $a3
           ;; 86 conflicts: 86 2 3 4 5 6 8 29   (v0,v1,a0,a1,a2,t0 -- NOT a3)
         V4 shape (read-only fence, 12 diffs / 109 insns)
           ;; 2 regs to allocate: 81 82        (p86 is gone from the global set)
           p86 refs=7 live=11 in block 2       -> LOCAL qty -> $a1

       THE COPY AND THE $a3 HOME ARE ONE EVENT.  The identity fence merges the
       source word and the swapped result into a SINGLE pseudo with two live
       ranges, so it "dies in 2 places"; local-alloc.c's combine_regs refuses a
       qty that "is not local to this block OR DIES MORE THAN ONCE", the pseudo
       falls through to global.c, and global.c's CONFLICT-driven assignment is
       the only path that reaches $a3.  Drop the fence and the same value is a
       block-local qty, so find_free_reg's numeric 0..75 scan hands it the first
       free caller-saved reg -- $a1 -- and can never reach $a3 while $a1 is free
       over its window.  So a fence dial buys retail's REGISTER (+1 copy insn)
       or retail's COUNT (wrong register), never both.  This is exactly the
       parasite-eve-2 diagnostic (DECOMPILATION_LEARNINGS.md, "`register asm`
       pins"): "dropping a pin gives the right instruction form with the wrong
       register, keeping it gives the right register with the wrong form --
       the conflict is upstream" -- now with the gcc-source mechanism attached.

       THE DIAL DOES EXIST AND IS PROVEN: extending the source word's live range
       past the two header loads flips it to $a3 at 109 insns (f2.py "late OR":
       p87 refs=5 live=19 -> $a3, hlen -> $a1 = retail's exact handout).  But
       every spelling that reaches it also MOVES a statement, which reorders the
       swap chain -> 34/36/40 diffs.  What is missing is a way to lengthen a
       live range WITHOUT relocating a use (a fence adds a ref AND a barrier).
       ROUND-2 FALSIFICATIONS (all measured, base 7): one shared carrier for the
       type+num source words (the "retail reuses $a3 for both" reading) 30/38/30
       -- the merged pseudo goes GLOBAL but lands in $t0, so that reading is
       WRONG; late-OR variants 34/36/36/40; a separate source name `w` with a
       read-only fence after the loads 40, before the loads 26, after the store
       40, two operands 40, and without the result fence 36.

       W61-A16 ROUND 3 -- THE HANDOUT IS NOW PROVED UNREACHABLE FROM LOCAL-ALLOC
       (gcc-2.8.1 local-alloc.c read, real-CC1PLPSX -dl/-dg picture per variant
       via tools/fast.py; harness scratchpad/w61a16/viv.py).
       MECHANISM, exactly: MIPS defines no REG_ALLOC_ORDER, so find_free_reg
       (local-alloc.c:2176) scans hard regs 0..31 ASCENDING and takes the first
       one free over [birth,death), where `used` is the union of regs_live_at[]
       across that window.  In the V4 shape the source word is the FIRST qty
       allocated (QTY_CMP_PRI 2*7/11 beats every other qty in the block), so
       only pre-existing liveness can push it up the scan -- and over its window
       only $a0 (the lumpyName string, hard-live for the reservememadr arg) is
       taken, so it lands $a1 and can never reach $a3.  For $a3 the scan needs
       $a1 AND $a2 busy over the SAME window, but retail's $a1 is the hlen
       pseudo (born 28, i.e. AFTER the source word dies at 27) and its $a2 is
       the hard third-arg zero (born 30) -- both provably disjoint from the
       window, since retail reuses $a3 itself for the num source at 29.
       => retail's source word was NOT allocated by the numeric scan; it was a
       GLOBAL allocno, which is exactly what the identity fence buys us (and
       why it, uniquely, reaches $a3) at the price of the one carrier copy.
       NEW FALSIFICATIONS (all measured here, all reverted):
       - identity fence MID-CHAIN on the source word itself, pre-shift and
         post-shift, +/- the result fence (the "2 deaths for free" idea): 26 in
         all four spellings.  A matching "+r" in/out does NOT split the live
         range -- flow.c emits no death for a reg used and re-set by one insn --
         so the pseudo stays LOCAL, gains 2 refs (7 -> 9, priority 2.25) and
         drops to $v1 instead.  Refs move the home; they cannot move it UP.
       - birth-end lengthening (hoist the type read above the void fence, and
         above the lumpyName statement): live 11 -> 14, home unchanged $a1,
         110 insns, 15 diffs.  Only the DEATH end is a dial, confirming R2.
       - statement ORDER of the two header loads and the type store is fully
         normalised by sched1/sched2: num-load-first, store-before-loads and
         store-between-loads are BYTE-IDENTICAL to V4 (12 diffs, identical
         allocno picture).  Do not re-sweep this axis.
       - hlen loaded in its decl-init (so $a1 is busy over the window): 36,
         source word -> $v1; num loaded in its decl-init: 38, source word still
         $a1 and num -> $a3 with live 26.
       - shared type+num carrier re-measured with the picture attached (the R2
         "30/38/30" row, now explained): the merged pseudo IS global and DOES
         die in 2 places, but the 0xff0000 MASK (refs 4, live 56-64) is the
         LAST local allocated and, with no local left holding $a3 over its
         range, takes $a3 itself -- so the carrier falls to $t0/$t1.  Variants:
         bare 38, +result read-only fence 30, +named byteMask 38, +byteMask
         +result fence 30, +mask fence 30, +identity fence on the result 30.
         The mask and the carrier are therefore ONE contested register.
       => CERTIFICATE: every source-visible dial on this handout is priced.
       What is missing is unchanged from R2 -- a device that gives the source
       word a SECOND live range (or a 2nd death) whose value needs no copy insn
       and does not displace the mask.  W61-A20's zero-ref live-range
       lengthener is the exact instrument this fn is waiting for.

       W62-A15 -- THE ONE BOUNDED PROBE THE CERTIFICATE ALLOWS: the 13B
       zero-insn COPY devices (optimize_reg_copy_1 COPY-TAIL /
       optimize_reg_copy_2 COPY-BACK) and the fence-POSITION dial.  All four
       measured here against base 7 @110, all reverted:
         COPY-BACK  `u_int typeOut = swappedType; lumpHead.type = typeOut;`
                    with the identity fence DROPPED         34 @109
         fence-LATE (identity fence moved below both header loads)  54 @109
         fence-LATE + copy-back                                     54 @109
         COPY-TAIL  (copy + read-only fence on the still-live source
                     AFTER the store)                               54 @109
       COPY-BACK does exactly what regmove promises -- the copy is DELETED and
       the count goes exact 109/109 -- and the handout collapses anyway, which
       is the 13B GOVERNING LIMIT stated from the other side: `the copy IS the
       mechanism`.  Here the carrier copy is not an artefact to be removed, it
       is the only thing making the source word die twice, and every device
       that deletes it returns the word to a LOCAL qty and to $a1.
       => CERTIFICATE RE-CONFIRMED with the copy-device class now priced.  The
       missing instrument is unchanged and is NOT a copy: a way to give the
       pseudo a second live range with no copy insn.
       Harness: scratchpad/w62a15/viv.py.

       W64-A16 -- THE MISSING INSTRUMENT EXISTS, AND THE CERTIFICATE IS UPGRADED.
       local-alloc.c:471-477 (gcc-2.8.1) admits a pseudo to LOCAL allocation iff
           REG_BASIC_BLOCK (i) >= 0   AND   REG_N_DEATHS (i) == 1
       Four waves only ever attacked the SECOND conjunct (identity fence => two
       deaths => GLOBAL => $a3, at the price of one carrier copy).  The FIRST
       conjunct is a completely independent, ZERO-INSN route to the same GLOBAL
       set: give the value a reference from a SECOND basic block (05D promotion).
       InitViv has a structurally identical byte-swap block after the
       `if (bigfileHeader == 0) return 0;` and the second async wait, so ONE
       shared source-word variable spans two blocks for free.  MEASURED (real
       CC1PLPSX -dl/-dg via scratchpad/w64a16/dmp.py, all reverted):
         shared source word + fence      32 diffs, 109 insns
         shared source word, NO fence    40 diffs, 109 insns
         shared with block-2 num         34 / 42 (fence / no fence), 109
         shared with block-2 hlen        42 / 50, 109
         no fence, not shared (control)  34,      109
       EVERY sharing variant is COUNT-EXACT 109/109 -- the carrier copy is gone,
       which is exactly the device the R2/R3/W62 certificates asked for and could
       not name.  The dump says why it still misses: the merged pseudo p84 is
       reported as a real global (`;; 3 regs to allocate: 84 81 82`, 15-17 refs,
       "dies in 2 places", no "in block N" tag) but its conflict set now reads
           ;; 84 conflicts: 82 84 2 3 4 5 6 7 8 29
       i.e. it picks up $a3(7) AND $t0(8) from the second region, so find_reg's
       ascending scan hands it $t1($9).  In the 7-diff base the same pseudo's
       conflicts are `2 3 4 5 6 8 29` -- a3 absent -- which is the whole reason
       the fence shape reaches $a3.
       => CERTIFICATE, corrected: the missing device is NOT "a second live range
       without a copy insn" (that is the 2-block reference, and it is free); it
       is "a second live range whose SECOND region does not add $a3 to the
       conflict set".  Any second reference sited where $a3 is dead would land
       both the count AND the register; none of InitViv's three candidate
       block-2 words qualifies.  Harness: scratchpad/w64a16/viv.py, viv2.py.

       W67-A8 -- THE REQUESTED DEVICE EXISTS: the un-tried 4th block-2 word.
       Sharing the source word with block-2's byteMask (swappedType = 0xff0000
       plus the three mask uses) on the V4 read-only-result shape is
       COUNT-EXACT 8 @109/109 and lands the source word in $a3 (both sides
       lw a3,16(sp)): the mask's block-2 range adds a1/a2 but NOT a3 to the
       merged conflict set, so find_reg's ascending scan reaches $a3 with the
       carrier copy GONE -- the exact certificate ask.  The residual MOVES to
       a new mechanism-named blocker: retail's last mask use is the
       dying-register triple `and a3,a1,a3 / srl a3,a3,8 / or a0,a0,a3`, ours
       keeps a fresh $v1 -- and combine_regs cannot tie the and's fresh dest
       to the now-GLOBAL shared pseudo (local-alloc.c:1866 refuses
       reg_qty < 0 sources), while the in-place RMW spelling that would force
       the dest (swappedType = swappedType & headerNum; then >> 8) rotates
       the whole handout to 46 @109.  Plus one load-position pair (retail
       floats the type lw between the lui/addiu la halves; ours is
       fence-blocked below the addiu).  BASIN TRADE: 8 @109/109 (count-exact,
       and/srl/or renames) vs this shape's 7 @110/109 (carrier copy) -- HELD
       at 7 per the gate bar; the byteMask share is the banked count-exact
       basin if the last-use tie is ever reached.  Also measured from the VJ
       basin, all reverted: hoist type read above the void fence 13 @110;
       read above lumpyName 13 @110; fence-first order 9 @110; num RMW
       in-place 46 @109 / both 49 @110.  Second-range carriers at the
       reservememadr/asyncload sites (hlen shares) are COPY-PROPAGATED AWAY
       (single foldable use): all 12 @109 == the V4 control; a fence-anchored
       def there 66 @109; the full-addend carrier 26 @109; no-fence share
       34 @109.  Harness: scratchpad/w67a8/viv_v{1,2,3,4}.json + probe.py. */
    __asm__("" : "+r"(swappedType));
    headerLength = lumpHead.hlen;
    headerNum = lumpHead.num;
    lumpHead.type = swappedType;
    lumpHead.hlen = headerLength << 0x18 | (headerLength & 0xff00) << 8 |
                    (headerLength & 0xff0000) >> 8 | headerLength >> 0x18;
    lumpHead.num = headerNum << 0x18 | (headerNum & 0xff00) << 8 |
                   (headerNum & 0xff0000) >> 8 | headerNum >> 0x18;
  }
  bigfileHeader = reservememadr(lumpyName,lumpHead.hlen + 0x20,0);
  if (bigfileHeader == (LUMPYHEAD *)0x0) {
    return (LUMPYHEAD *)0x0;
  }
  vivHandle = asyncloadsegment((char *)0x0,bigfileHeader,lumpHead.hlen + 0x20);
  do {
    systemtask(0);
  } while (getasyncreadstatus(vivHandle) == 0);
  {
    u_int byteMask = 0xff0000;
    u_int headerType = bigfileHeader->type;
    __asm__("" : : "r"(headerType), "r"(byteMask));
    LUMPYHEAD *header = bigfileHeader;
    u_int headerLength = header->hlen;
    u_int headerNum = header->num;

    header->type = headerType << 0x18 | (headerType & 0xff00) << 8 |
                   (headerType & byteMask) >> 8 | headerType >> 0x18;
    header->hlen = headerLength << 0x18 | (headerLength & 0xff00) << 8 |
                   (headerLength & byteMask) >> 8 | headerLength >> 0x18;
    header->num = headerNum << 0x18 | (headerNum & 0xff00) << 8 |
                  (headerNum & byteMask) >> 8 | headerNum >> 0x18;
  }
  return bigfileHeader;
}



/* ---- FeAudio_InitCommentary  [FEAUDIO.CPP:360-377] SLD-VERIFIED ---- */

void FeAudio_InitCommentary(int language,int arg1)

{
  u_int speechName;
  /* These are distinct existing rodata symbols in the retail link, not two
     fields of bigBuf. Keeping their identities prevents a false shared %hi. */
  extern u_int D_8001016C[];
  extern char D_80010170[];

  speechName = D_8001016C[0];
  ginfo.nHandle = 0;
  ginfo.multiplay = 1;
  ginfo.nSoundHandle = 0;
  ginfo.areLoading = '\0';
  ginfo.soundIsPlaying = '\0';
  ginfo.playNextOne = '\0';
  ginfo.pBankHeader = (char *)0x0;
  ginfo.sSpeechData = (char *)0x0;
  ginfo.lastSpeechData = (char *)0x0;
  ginfo.vivHandle = 0;
  *(u_int *)ginfo.name = speechName;
  /* The volatile value read keeps the language pointer load at the call site,
     matching retail while leaving the Paths_Paths %hi free to schedule early. */
  sprintf(currentSpeechViv,D_80010170,Paths_Paths[0x26],
          *(char * volatile *)&allLanguages[language]);  /* H11: dest was "" (oracle 0x800160EC $a0=$s0=&currentSpeechViv @0x80051510) */
  speechfileHeader[0] = FeAudio_InitViv(currentSpeechViv);  /* H11: arg was "" (oracle 0x8001615C $a0=$s0) */
  return;
}



/* ---- FeAudio_DeInitCommentary  [FEAUDIO.CPP:385-386] SLD-VERIFIED ---- */

void FeAudio_DeInitCommentary(void)

{
  if (speechfileHeader[0] != (LUMPYHEAD *)0x0) {
    purgememadr(speechfileHeader[0]);
    speechfileHeader[0] = (LUMPYHEAD *)0x0;
  }
  return;
}



/* end of feaudio.cpp */
