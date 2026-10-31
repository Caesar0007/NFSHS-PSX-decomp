/* game/common/audiocmn.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   audiocmn.obj (GAME\COMMON\AUDIOCMN.CPP): common audio, effects and music state.
 *   48 native-debug-covered functions; unresolved source/SLD items are tracked
 *   in sym-match.md. No whole-module original-source seal is claimed.
 */
#include "audiocmn_types.h"
#include "audiocmn_externs.h"

/* Canonical EA spelling recovered from the symbol-bearing NFS2 audiocmn.c. */
#define MIN(a,b) (((a) > (b)) ? (b) : (a))

/* w64-a19 LINK FIX: called at :576/:722/:2429/:2472/:2500 but only DEFINED at :2518,
 * with no prior prototype -> implicit declaration -> the five calls were emitted
 * UNMANGLED (`AudioCmn_ReverbOff`) and could never resolve to `AudioCmn_ReverbOff__Fv`
 * defined in this same object.  Prototype hoisted, signature unchanged. */
void AudioCmn_ReverbOff(void);

/* ---- audiocmn.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
extern char *AudioCmn_LanguageName[7];
extern int bSirenOn[6], bSirenPitchingUp[6], quickSirenActive[6];
extern int sirenPitchWidth[6], sirenCurrentPitch[6], slowSirenReps[6];
extern int sirenCount[6], reachedSirenMin[6], quickSirenTimeCount[6];
extern AudioCmn_tReTrig AudioCmn_gReTrig[2];
extern SndBnk_t gSndBnk[7];
extern Channels_t gaChannel[71];
extern AudioCmn_tAsyncSfxSlot AudioCmn_gSfxSlot[32];
extern char carbankname[12];
extern int falseLapTrigCur, flaseLapTrigTrack;
extern char currentLap[2];
extern int bestLapTime[2], gtotallaptimes[2], AudioCmn_gPlayerArrested[2];
extern int AudioCmn_gCursorSndHandle, AudioCmn_gLastFade;
extern void *AudioCmn_gLoadTables, *AudioCmn_gCruiseTables;
extern int AudioCmn_gResume, AudioCmn_gStreamRestartTimer;
extern char fMysticWindON[2], fAmbientRangeON[2];
extern int currentWindVal[2], nextWindVal[2];
extern int currentWindPan, nextWindPan, gQuickSirenCount;
extern int AudioCmn_ThunderAmp, AudioCmn_ThunderAzi, AudioCmn_ThunderDel;
int          gBankNumLookupTable[71] = { 0, 2, 0, 2, 0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 3, 3, 3, 3, 5, 2, 2, 2, 2, 0, 1, 2, 2, 2, 2, 0, 0, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0 };   /* @0x8010e4d0 */
int          falseLapTrigNumsForward[10][2] = { 4, 7, 4, 7, 4, 7, -1, -1, 4, 7, 4, 9, 4, 9, -1, -1, -1, -1, 4, 9 };   /* @0x8010e5ec */
int          falseLapTrigNumsBackward[10][2] = { 4, 5, 4, 5, -1, -1, -1, -1, 4, 5, 4, 5, 4, 5, -1, -1, -1, -1, 4, 5 };   /* @0x8010e63c */
char         Xfade[129] = { 0, 3, 7, 10, 13, 16, 19, 22, 24, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 46, 48, 50, 51, 53, 54, 55, 57, 58, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 84, 85, 86, 87, 88, 88, 89, 90, 91, 91, 92, 93, 94, 94, 95, 96, 96, 97, 98, 98, 99, 100, 100, 101, 101, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 109, 110, 110, 111, 111, 112, 112, 113, 113, 114, 114, 115, 115, 116, 116, 117, 117, 118, 118, 119, 119, 119, 120, 120, 121, 121, 122, 122, 122, 123, 123, 124, 124, 125, 125, 125, 126, 127, 127 };   /* @0x8010e68c */
static char  SkidInitMaxFreq[71] = { 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };   /* @0x8010e710 */
char         trackMusicState = 4;   /* @0x8013c628 */
int          audioBackwardsDirection = 0;   /* @0x8013c62c  (bss(zero)) */
int          intensityFalseLapCounter = 0;   /* @0x8013c630  (bss(zero)) */
int          falseLapCounter = 0;   /* @0x8013c634  (bss(zero)) */
int          gMusicStyle = 0;   /* @0x8013c638  (bss(zero)) */
char         countdown = 0;   /* @0x8013c63c  (bss(zero)) */
char         FadingMusic = 0;   /* @0x8013c63d  (bss(zero)) */
char         StartedNewMusic = 0;   /* @0x8013c63e  (bss(zero)) */
int          recordLapTime = 0;   /* @0x8013c640  (bss(zero)) */
int          AudioCmn_kAudioOn = 1;   /* @0x8013c644 */
int          AudioCmn_kAudioStreamingOn = 1;   /* @0x8013c648 */
int          SgameSFXvol = 40;   /* @0x8013c64c */
int          gMasterMusicLevel = 127;   /* @0x8013c650 */
int          gMasterSFXLevel = 127;   /* @0x8013c654 */
int          gMasterEngineLevel = 127;   /* @0x8013c658 */
int          gMasterFENarrationLevel = 127;   /* @0x8013c65c */
int          gMasterAmbientLevel = 127;   /* @0x8013c660 */
int          previousSFXLevel = 127;   /* @0x8013c664 */
int          AudioCmn_musicInteractive = 1;   /* @0x8013c668 */
int          gFEmusicON = 1;   /* @0x8013c66c */
int          NumSFXOn = 0;   /* @0x8013c670  (bss(zero)) */
int          gStereoMode = 1;   /* @0x8013c674 */
char         fReverbOn = 0;   /* @0x8013c678  (bss(zero)) */
char         fReverbLevel = 0;   /* @0x8013c679 */
static int   PlayersRampedGasLevel[2];   /* SYM STAT @0x8013dd80 (.sbss: 8-byte static at -G8) */


/* ---- intra-TU forward declarations ---- */
int AudioCmn_MusicLevel(int level);
int AudioCmn_GetTrackRecordLapTime(void);
void AudioCmn_InitThunder(void);
void AudioCmn_PlayThunder(int intensity,int azimuth);
void AudioCmn_UpdateThunder(void);
void AudioCmn_InitAsyncSfx(void);
void AudioCmn_RemoveAsyncSfx(int slot);
void AudioCmn_DeInitAsyncSfx(void);
int AudioCmn_RemoveOldestAsyncSfx(int bank);
void AudioCmn_LoadAsyncSfx(int bank,int patch,void *pbank,int size);
int AudioCmn_GetAsyncSfx(int bank,int patch,bool checkonly);
void AudioCmn_Init(void);
void AudioCmn_SetLevels(void);
int AudioCmn_GetTimePhrase(int time);
void AudioCmn_CheckState(Car_tObj *car);
void AudioCmn_LoadFESamples(void);
void AudioCmn_LoadGameSamples(void);
void AudioCmn_InitChannelArray(void);
int scaleFrequency(int sndPlayer,int iSFXnum,int tweakedForce);
int ChooseImpactSample(int force,s_type surface1,s_type surface2);
int ChooseLoopedSample(s_type surface1,s_type surface2);
void freeVoiceChannel(int sndPlayer);
int AudioCmn_PlayDoppleredSound(int bhandle,int patchNum,int azimuth,int vol,int bend,int doppler);
int AudioCmn_PlaySound(int bhandle,int patchNum,int azimuth,int vol,int bend);
int AudioCmn_PlaySFX(int sndPlayer,int iSFXnum,int iFreqIn,int iDopplerIn,int iAmpIn,int azimuth);
void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir);
void AudioCmn_TrafficSkidSFX(int sndPlayer,s_type surface1,s_type surface2,int force,int Distsq,int azimuth);
void AudioCmn_PlayerHornOn(int carIndex,int Distsq,int iFreqIn,int azimuth,int doppler);
int AudioCmn_PlayerHornOff(int carIndex);
void AudioCmn_PlayFESFX(int SFXnum);
void AudioCmn_PlayFESFXVol(int SFXnum,int vol);
void AudioCmn_PlayWrongWaySFX(void);
void AudioCmn_PlayPauseSound(int patch);
void quickSirenOn(int sirennum);
void SuperCopSirenOn(int sirennum);
void SirenOn(int sirennum,int supercop);
void SirenOff(int sirennum);
void UpdateSiren(int sirennum,int amp,int dop,int azimuth,int supercop);
void AudioCmn_UnPause(void);
void AudioCmn_InitReverb(void);


/* W60-A9: file-scope helper decls hoisted here from the old audiocmn.obj-tail block
 * so they precede EVERY consumer after the retail-VA reorder of the fn definitions. */

/* ===================================================================================
 *  RECONSTRUCTED 2026-06-12 from nfs4-f.exe (disasm-v3 MIPS) — the audiocmn.obj tail
 *  SKIPPED from the original 42-fn pass. Full reconstructions, NOT stubs.
 *  Helper VAs resolved via disasm-v3 offset markers. 0x801131EC = &GameSetup_gData;
 *  +240/+244 = userSetting.musicLevel/.sfxLevel; gaChannel[71] (Channels_t {Partial,SFXnum}).
 * =================================================================================== */
/* sibling externs not already in audiocmn.cpp scope (defined in audioeng/audio/copspeak/spch) */
void AudioEng_StopServer(void);
void AudioEng_CleanUp(void);
void AudioEng_Pause(void);
void AudioTrk_CleanUp(void);
void Audio_CleanUp(void);
void CopSpeak_Stop(void);
void CopSpeak_Cancel(void);
void CopSpeak_SilenceCop(Car_tObj *car, int playerIndex);
void AudioMus_StopSong(int fadeticks);


/* additional helpers for AudioCmn_Reset (gettick/SNDSTRM_setpriority/SNDmemlargestunused
 * come from lib/libfns.h already included via audiocmn_externs.h) */
void CopSpeak_Server(void);
int  AudioTrk_PreLoad(void);
int  AudioMus_Buffered(void);
int  AudioMus_Threshold(void);
extern int gMusicHandle;


/* ---- AudioCmn_MusicLevel__Fi  [@0x80076420] ---- */
#line 277 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_MusicLevel(int level)
{
  if (0x56 <= level) { return (((level + -0x55) * 7) / 2 + 0x55) * 0x46 >> 7; } return level * 0x46 >> 7;
}

/* ---- AudioCmn_GetTrackRecordLapTime__Fv  [@0x80076480] ---- */
/* 2026-10-29: NFS2's recorded-result source shape restores all4 word/file
 * tags,both block records,header283 and end289 without changing code.
 * nBestTime is supported by matched NFS2 source,not a retained NFS4 name.
 * Its plain result naturally debug-elides;no const disguise is involved.
 * A pointer-source control also matches,so exact NFS4 identifier/object/macro
 * spelling is not uniquely established by these coordinates. No new asm,
 * volatile,qualifier,fake use or statement directive.
 * Receipt:build/nc12/audio_record_source_20261029/final-proof.json. */
#line 282 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_GetTrackRecordLapTime(void)
{



  int nBestTime = GameSetup_gData.userSetting.bestlap;

  return nBestTime;
}

/* ---- AudioCmn_InitThunder__Fv  [@0x80076490] ---- */
#line 302 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_InitThunder(void)
{
  AudioCmn_ThunderAmp = 0;
  AudioCmn_ThunderAzi = 0;
  AudioCmn_ThunderDel = 0;
}

/* ---- AudioCmn_PlayThunder__Fii  [@0x800764a4] ---- */
#line 309 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_PlayThunder(int intensity,int azimuth)
{
  if (AudioCmn_ThunderAmp < intensity) {

    AudioCmn_ThunderAmp = intensity;
    AudioCmn_ThunderAzi = azimuth;
    AudioCmn_ThunderDel = 0x87 - intensity;
  }
}

/* ---- AudioCmn_UpdateThunder__Fv  [@0x800764d0] ---- */
/* 2026-10-27 thunder source recovery: the real countdown statement323
 * precedes its separate negative test325,inside the positive amplitude321
 * guard. Prefix decrement removes the assignment/comma condition without
 * inventing a capture. All43 words,root ownership,word/file tags and end334
 * match. The measured early-return controls keep code but miss end fields;
 * assignment spelling also matches,so literal original syntax is not unique.
 * No new object,binding-record padding,asm/volatile or statement directive.
 * Receipt:build/nc12/audio_thunder_source_20261027/. */
#line 319 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_UpdateThunder(void)
{
  if (AudioCmn_ThunderAmp > 0) {

    --AudioCmn_ThunderDel;

    if (AudioCmn_ThunderDel < 0) {

      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x16,AudioCmn_ThunderAzi,AudioCmn_ThunderAmp,0x40);

      if (0x2e <= AudioCmn_ThunderAmp) {
        AudioCmn_ThunderAmp += 3 - (random() & 0xf);
      } else {
        AudioCmn_ThunderAmp += 2 - (random() & 7);
      }
      AudioCmn_ThunderDel = (random() + 0x14U) & 3;
    } }
}

/* ---- AudioCmn_InitAsyncSfx__Fv  [@0x8007657c] ---- */
/* 2026-10-29: an ordinary bounded for and the actual typed slot view remove
 * inRange and its unneeded const qualifier. All14 words,one supplied i owner,
 * six block records,header454 and end461 now match,including every SLD tag.
 * SOURCE-REVIEW-UNRESOLVED: slot is a behavior-derived name,not a supplied
 * retail identifier;its original declaration/macro spelling is not unique.
 * The real pointer view naturally debug-elides without a qualifier disguise.
 * Ordinary indexed-loop controls shorten the code;this does not uniquely
 * prove the lost pointer identifier or literal source. No new asm,volatile,
 * identity,fake use,scope padding,statement anchor or output rewrite.
 * Receipt:build/nc12/async_init_scope_20261029/final-proof.json. */
#line 453 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_InitAsyncSfx(void)
{
  for (int i = 0; i < 32; i++) {

    AudioCmn_tAsyncSfxSlot *slot = &AudioCmn_gSfxSlot[i];
    slot->patch = -1;
    slot->handle = -1;
    slot->header = (char *)0x0;
  }
}

/* ---- AudioCmn_RemoveAsyncSfx__Fi  [@0x800765b4] ---- */
#line 466 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_RemoveAsyncSfx(int slot)
{
  AudioCmn_tAsyncSfxSlot *s = &AudioCmn_gSfxSlot[slot];

  if (s->patch != -1) {

    if (s->handle != 0xffffffff) {

      SNDbankremove(s->handle);
      s->handle = -1;

      if (s->header != (char *)0x0) {

        purgememadr(s->header);
        s->header = (char *)0x0;
      }
    }



    s->patch = -1;
  }
}

/* ---- AudioCmn_DeInitAsyncSfx__Fv  [@0x8007663c] ---- */
#line 492 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_DeInitAsyncSfx(void)
{
  for (int i = 0; i < 0x20; i++) {
    AudioCmn_RemoveAsyncSfx(i); }
}

/* ---- AudioCmn_RemoveOldestAsyncSfx__Fi  [@0x80076674] ---- */
/* 2026-10-27: two real for-owned i declarations replace the manual
 * declaration blocks/while(1) scaffolding. Both aliases are plain pointers:
 * const is unnecessary for code or native debug elision on this graph.
 * All58 word/file tags,all14 block-line records,complete supplied owners,
 * header/frame/mask and end527 agree. First i remains REG7 at depth2,
 * owner+0..+112;the shadowing i remains REG5 at depth4,+120..+196.
 * Bare for/direct-index controls shorten58 to56 or lose supplied body regions;
 * wrapping extra manual blocks around the for adds unprovided regions.
 * These are bounded source controls,not a floor or original-object proof.
 * SOURCE-REVIEW-UNRESOLVED: the two plain slot pointers still have no supplied
 * name rows. Their ordinary copy elision is NOT a source-object exemption.
 * Actual value-producing selection controls were tested without adding fake
 * work;none preserves code. Recover their original producer/identifiers;
 * do not infer necessity or literal original const qualification from that.
 * No new alias,object,qualifier,asm,volatile,fake use,scope padding,statement
 * anchor,compiler flag or output rewrite is introduced. Literal macro text
 * remains unproved. Receipt:build/nc12/async_oldest_source_20261027/. */
#line 500 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_RemoveOldestAsyncSfx(int bank)
{
  int oldest; int ticks; oldest = -1;
  ticks = simGlobal.gameTicks + -0x10;

  for (int i = 0; i < 0x20; i = i + 1) {
    AudioCmn_tAsyncSfxSlot *slot = &AudioCmn_gSfxSlot[i];


    if ((slot->patch != -1) && (slot->ticks < ticks)) {

      ticks = slot->ticks;
      oldest = i;
    }
  }
  if (oldest == -1)
  {
    for (int i = 0; i < 0x20; i = i + 1) {
      AudioCmn_tAsyncSfxSlot *slot = &AudioCmn_gSfxSlot[i];


      if ((slot->patch != -1) && (slot->bank < bank)) {
        oldest = i;
      } }
  }
  if (-1 < oldest) {
    AudioCmn_RemoveAsyncSfx(oldest); }
  return oldest;
}

/* ---- AudioCmn_LoadAsyncSfx__FiiPvi  [@0x8007675c] ---- */
/* 2026-10-27: a real bounded for replaces the do/while search,with
 * unchanged code and every supplied native owner. Ordinary source phases
 * seal all105 word/file tags,both block-line records,header/frame/end599.
 * No new object,qualifier,scope,asm,volatile,fake use or statement anchor.
 * SOURCE-REVIEW-UNRESOLVED: s has no supplied source-object row. Its debug
 * elision is NOT an original-object exemption. Direct indexed/address forms
 * currently add two instructions;those failures do not prove it necessary.
 * Recover its actual producer/name rather than hiding it behind a new alias.
 * SOURCE-RECOVERY-UNRESOLVED: the constant-false SimpleMem call is a known
 * reconstruction-only rodata holder,NOT recovered original executable work.
 * The shared constructor/header/string producer remains unresolved;no new
 * dummy holder/default/overload is substituted merely to retain the literal.
 * All source/statement/macro identities not provided by retail remain open;
 * this is the full covered SYM/SLD contract,not a whole-source certificate.
 * Receipt:build/nc12/async_load_source_20261027/. */
/* retail audiocmn.obj .rodata opens with the UNREFERENCED "SimpleMem" tag (0x800556c4) ahead of
   * this function's first literal; keeping it makes the later jump table's .align 3 land at
   * retail's 0x8005573c. The constant-false call adds no code. */
/* MATCH P902: native SLD 572 groups success and header allocation. */
#line 533 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_LoadAsyncSfx(int bank,int patch,void *pbank,int size)
{
  if (0) AudioCmn_LoadBank("SimpleMem",0); int slot;
  int check;
  AudioCmn_tAsyncSfxSlot *s;
  for (slot = 0; slot < 32; ++slot) {

    s = &AudioCmn_gSfxSlot[slot];

    if ((patch == s->patch) && (bank == s->bank) && (s->handle == -1)) {

      if (size != 0) {






        while (SNDmemlargestunused((unsigned char **)&check) - 0x1000 < size) {





          if (AudioCmn_RemoveOldestAsyncSfx(bank) == -1) {

            if (bank == 2) {
              puts("out of SPU ram on speech!\n"); }



            s->handle = -1;
            s->patch = -1;
            return; } }



        check = SNDbankadd(&s->handle,pbank);

        if ((check == 7) && ((s->header = (char *)reservememadr("SFXHDR",SNDbankheadersize(s->handle),0x10)) != 0)) {

          SNDbankheadercopy((struct SndBankDataHeaderPrefix *)s->header,s->handle);
          s->patch = patch;
          s->ticks = simGlobal.gameTicks; return; }







        if (bank == 2) {
          puts("SNDbankadd failed on speech!\n"); }


        SNDbankheadersize(s->handle);


        if (check >= 0) {
          SNDbankremove(s->handle); } }
      s->handle = -1;

      s->patch = -1;
      return; }

  }
}

/* ---- AudioCmn_GetAsyncSfx__Fiib  [@0x80076900] ---- */
/* 2026-10-27: two real bounded search loops,early hit return and a
 * check-only switch remove FOUND/DOREQ/FILL dispatch. All93 word/file tags,
 * six block-line records,complete supplied owners,header/frame and end670
 * agree. A real for binding replaces the manual outer search block;its s
 * owner remains+48..+92,outer+0..+104. The second for adds no native region.
 * Default first/positive queue guard is the measured byte-exact switch shape;
 * duplicated REAL successful slot stores naturally merge to the retail tail.
 * Default source650..652 is erased;its break653 supplies the actual jump tag.
 * First for closing637 supplies its increment note;this is not a universal
 * rule for every for loop. Current-source stock/plain dump controls are bound.
 * Three source labels,two formerly emitted native LABEL records,are removed
 * (FILL was already debug-elided). No new object,name,asm,volatile,qualifier,
 * fake use,scope padding or statement #line is introduced. Literal original
 * macro/loop/switch spelling remains unproved,not a whole-source certificate.
 * Receipt:build/nc12/async_get_source_20261027/. */
#line 619 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_GetAsyncSfx(int bank,int patch,bool checkonly)
{
  int slot;
  CopSpeak_tRequest r;

  for (slot = 0; slot < 0x20; slot = slot + 1) {
    AudioCmn_tAsyncSfxSlot *s = &AudioCmn_gSfxSlot[slot];


    if ((patch == s->patch) && (bank == s->bank))
    {




      AudioCmn_gSfxSlot[slot].ticks = simGlobal.gameTicks;
      return AudioCmn_gSfxSlot[slot].handle;
    }
  }

  for (slot = 0; slot < 0x20; slot = slot + 1) {
    if (AudioCmn_gSfxSlot[slot].patch == -1) break;


  } if (checkonly == false) {
    if (slot == 0x20) {
      slot = AudioCmn_RemoveOldestAsyncSfx(bank); } }

  if (!((u_int)slot < 0x20)) { return -1; }

  switch (checkonly) {
  default: AudioCmn_gSfxSlot[slot].bank = bank;
    AudioCmn_gSfxSlot[slot].patch = patch;
    AudioCmn_gSfxSlot[slot].ticks = simGlobal.gameTicks;
    break;
  case 0:
    if (CopSpeak_SfxQueued() <= 5) {

      CopSpeak_InitRequest(&r);
      r.phrase = patch;
      r.sfx = '\x01';
      r.bank = (char)bank;

      if (CopSpeak_Request(&r) != -1) {

        AudioCmn_gSfxSlot[slot].bank = bank;
        AudioCmn_gSfxSlot[slot].patch = patch;
        AudioCmn_gSfxSlot[slot].ticks = simGlobal.gameTicks; } } break; }



  return -1;
}

/* ---- AudioCmn_Init__Fv  [@0x80076a74] ---- */
/* 2026-10-27: actual reverse/store690 precedes track/decode691;the final
 * quick-siren reset738 follows SFX level737 in source,not scheduled execution.
 * Ordinary layout under the existing anchor seals all94 word/file tags,both
 * block records and end738 with unchanged ELF/CPE and complete local owners.
 * SOURCE-REVIEW-UNRESOLVED: the existing volatile test read is not proved an
 * original qualifier. Plain/recorded-index/branch forms were repriced on this
 * basin:the94-word index form matches locals/SLD but reloads GameSetup's field,
 * not the retail gp audio global. No failed candidate or replacement device
 * is adopted;neither those trials nor this seal proves literal original text.
 * Original early-j reuse/macro spelling remains unproved;the direct-store
 * control also changes code. Verbatim previous comments are in before.cpp.
 * Receipt:build/nc12/audiocmn_init_source_20261027/. */
#line 677 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_Init(void)
{
  int j;
  int temptrack;

  if (AudioCmn_kAudioOn != 0) {





    AudioCmn_InitChannelArray();

    j = GameSetup_gData.reverseTrack; audioBackwardsDirection = j;
    temptrack = GameSetup_gData.track; if ((temptrack & 0x10) != 0) { temptrack = (temptrack & 0xf) + 5; }
    if (*(volatile int *)&audioBackwardsDirection == 0) {


      falseLapTrigCur = falseLapTrigNumsForward[temptrack][0];
      flaseLapTrigTrack = falseLapTrigNumsForward[temptrack][1];
    }

    else {

      falseLapTrigCur = falseLapTrigNumsBackward[temptrack][0];
      flaseLapTrigTrack = falseLapTrigNumsBackward[temptrack][1];
    }

    intensityFalseLapCounter = 0;
    falseLapCounter = 0;
  }



    j = 0; do {

      AudioCmn_gReTrig[j].count = 0;
      *(char *)((int)j + (int)fAmbientRangeON) = '\0';
      *(char *)((int)j + (int)fMysticWindON) = '\0';
      currentLap[j] = '\0';
      bestLapTime[j] = 0;
      PlayersRampedGasLevel[j] = 0;
      gtotallaptimes[j] = 0x200;
      AudioCmn_gPlayerArrested[j] = 0;
      j++; } while (j < 2);

  AudioCmn_InitThunder();
  AudioCmn_InitAsyncSfx();
  AudioTrk_StartUp();

  fReverbOn = '\0';
  fReverbLevel = '\0';
  FadingMusic = '\0';
  StartedNewMusic = '\0';
  recordLapTime = AudioCmn_GetTrackRecordLapTime();
  trackMusicState = '\x04';
  AudioCmn_gResume = 0;
  AudioCmn_gStreamRestartTimer = 0;

  AudioCmn_gLastFade = 0x7f;
  GameSetup_gData.userSetting.sfxLevel = gMasterSFXLevel;
  gQuickSirenCount = 0;
}

/* ---- AudioCmn_Reset__Fv  [@0x80076bec] ---- (Ghidra/IDA + SLD cross-checked:

 *  SNDstop arg restored; carInfo[] loop de-garbled; music-buffer wait is the direct
 *  SLD-scoped compound while. MATCH: 66 -> PASS, ours/oracle 214.) */

/* Historical earlier-baseline receipts below are not current source
 * requirements. In particular,the old blanket while-rotation verdict is
 * superseded by the measured2026-10-28 natural-wait result. */
/* Retail owns the channel-loop index in a +0..+0x80 lexical block. */
/* W57-A10 SYM-FIRST REWRITE (126 -> 66).  Three findings from the 8c block:
     (1) `ticks` = REG $s6 holds gettick()+0x280 = the DEADLINE computed ONCE
         (`addiu s6,v0,640` in the preheader), not t0 re-added per iteration;
     (2) the wait loop is UN-ROTATED -- retail keeps both head tests at the loop top
         with a `j` back-edge (`bnez s1` on goodtogo BEFORE the gettick call); the
         `while (!ready && ...)` form lets gcc prove entry and rotate (row 52);
     (3) SYM BLOCK SCOPES: `i` is re-declared per block -- initial channel-loop $s1,
         block line 52 $s0 (the 4-phrase loop), block line 60 $s2 (the numCars loop).
         One shared fn-scope `i` pins all three to the same register.  `goodtogo` is
         $s1 (our `ready`), which only frees up once the inner i's move out. */
/* Retail's music-wait block begins at +0x200; its second `ticks`
     belongs to the nested +0x218 block below. */
/* MATCH: SLD line-126 `ticks` is the +0x100 deadline ($s3); gcc derives the
       +0x40 deadline in $s2. Keeping the compound test directly in the while prevents
       the first wait block's goodtogo web from leaking into this block (27 -> PASS). */
/* Name-free expression regions reproduce retail's empty +2d0..+318
       and +310..+318 scopes without an unused declaration. This verified
       representation is not proof of the literal original macro syntax. */
/* 2026-10-28 partial Reset source recovery: loop-owned declarations replace
 * all three manual i wrappers,with exact supplied names/homes/paths/ranges.
 * Natural !goodtogo/gettick wait and nested weather/patch guards preserve
 * the whole214-word stream. A positive music guard supplies the two real
 * parent/body scopes instead of manual wrappers around an early return.
 * Every provided local tuple and all18 region address/path identities remain
 * exact. Ordinary anchored layout improves206 wrong word tags to16 and
 * block-line fields2/36 to32/36;function end903 is now correct.
 * SOURCE-REVIEW-UNRESOLVED: the existing anonymous final-conditional model
 * still has16 wrong word tags;two enclosing ambient ends are827 vs863 and
 * two fallback ends900 vs901. Structured controls fix the tags but add/lose
 * supplied regions and are not adopted. A private legacy-for-scope note
 * hypothesis is diagnostic only;no production compiler flag is changed.
 * Recover the actual producers,not a dummy statement,assertion,extra object,
 * qualifier or per-statement line override. This is NOT a complete Reset
 * SLD/original-text or whole-project seal. No new name/object,asm/volatile,
 * executable padding or output/reference rewrite is introduced. Receipts:
 * build/nc12/audio_reset_source_20261028/. */
/* 2026-10-31 AUDAI receipt: tags16 are the anonymous ?: statement (one tag at
 * its ';' 151; retail 143/145/146). A plain if/else gives tags 0 but g++2.8 keeps
 * an if/else clause scope only with a declaration or kept sub-block, so the
 * +310..+318 else region is lost (D: 34/36 regions); ({}) arms add regions.
 * An unused local in the else restored all regions but was RULED a banned dummy
 * local (coordinator 2026-10-31) and is not adopted. Measured: plain if/else
 * with `gettick();` = tags0 but 32/36 regions (both lost); retail discards the
 * else gettick() v0 (overwritten by the next jal gettick), so no existing
 * variable receives it. Open: the real producer of the two empty regions. */
#line 747 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_Reset(void)

{


    CopSpeak_SilenceCop((Car_tObj *)0,0);
    CopSpeak_Cancel();
    SPCH_ClearEventQueue();

    AudioCmn_DeInitAsyncSfx();

  for (int i = 0; i < 0x47; i++) {

      if (gaChannel[i].Partial != -1) {

        SNDstop(gaChannel[i].Partial);
        gaChannel[i].Partial = -1;
        gaChannel[i].SFXnum = -1;
      }
  }

  if (fReverbOn != '\0')
    AudioCmn_ReverbOff();



  AudioCmn_Init();






  if (0 < gMasterAmbientLevel)
  {
    int ticks; int goodtogo;
    goodtogo = false;
    ticks = gettick() + 0x280;



    while (!goodtogo && gettick() < ticks) { int check;

      goodtogo = true; CopSpeak_Server();
      systemtask(0);





      if (0x8000 < SNDmemlargestunused((unsigned char **)&check))
      {
        if (GameSetup_gData.raceType == RaceType_HotPursuit)
        { for (int i = 0; i < 4; i++) {
          if (AudioCmn_GetAsyncSfx(2,i + 0x2f,false) == -1)
            goodtogo = false;

        } } if (GameSetup_gData.Weather == 1)
          if (AudioCmn_GetAsyncSfx(1,0,false) == -1)
            goodtogo = false;

        for (int i = 0; ; i++) { if (i >= GameSetup_gData.numCars) break;

          if (GameSetup_gData.carInfo[i].carClass == 2)
          {
            int patch;

            patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType,0);

            if (-1 < patch)
              if (AudioCmn_GetAsyncSfx(1,patch,false) == -1)
                goodtogo = false;

            patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType,1);

            if (-1 < patch)
              if (AudioCmn_GetAsyncSfx(1,patch,false) == -1)
                goodtogo = false;
          }
        } } }



































  }




  AudioTrk_PreLoad();





  if (gMasterMusicLevel != 0)
  {
    AudioMus_Volume(AudioCmn_MusicLevel(gMasterMusicLevel));


    SNDSTRM_setpriority(gMusicHandle,0xff,0xff);

    int ticks;
      ticks = gettick() + 0x100;


      gettick(); AudioMus_Buffered(); AudioMus_Threshold();




      while ((((gettick() < ticks + -0xc0) || (AudioMus_Threshold() < 1)) || (AudioMus_Buffered() < AudioMus_Threshold())) && (gettick() < ticks)) {
        systemtask(0); }

      ({ AudioMus_Buffered() < AudioMus_Threshold() + -100

          ? (void)(GameSetup_gData.userSetting.musicLevel = 0,gMasterMusicLevel = 0,
                   AudioMus_Volume(AudioCmn_MusicLevel(0)))


          : (void)({
              gettick();
            });
      });

      gettick(); AudioMus_Buffered(); AudioMus_Threshold();
  }
}



/* ---- AudioCmn_DeInit__Fv  [@0x80076f44] ---- */

/* BUG FIX (w59-a10 BRANCH-TARGET AUDIT): the two resets used to sit OUTSIDE
     the `Partial != -1` guard.  That gated PASS 54/54 but the guard's branch
     word was 10920003 (ours) vs 10920005 (retail) -- ours re-entered at the
     `sw` pair (insn 28) instead of the loop tail (insn 30), so an ALREADY-idle
     channel still had its SFXnum forced to -1.  Retail keeps both stores inside
     the guard. */
/* 2026-10-27 lifecycle SLD recovery: unchanged executable tokens restore
 * the actual stop/cleanup/level/loop source groups. The two channel resets
 * remain inside the live-channel guard; do not reintroduce the historical
 * skip-target error. All54 words and branch targets match,with i REG17 at
 * depth2,owner+0..136,path[0,0]. Ordinary anchored layout restores all54
 * word/file tags,four block-line records,header911 and end937. Several
 * closing-brace/explicit-return spellings match all fields; literal original
 * exit syntax/comments are not uniquely proved. The adopted implicit form
 * adds no object,scope,asm/volatile,statement directive or output rewrite.
 * Receipt:build/nc12/audio_deinit_source_20261027/. */
#line 909 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_DeInit(void)

{

  AudioEng_StopServer();
  AudioEng_CleanUp();
  CopSpeak_Stop();

  gMasterSFXLevel = GameSetup_gData.userSetting.sfxLevel; /* @0x801132e0 */
  gMasterMusicLevel = GameSetup_gData.userSetting.musicLevel; /* @0x801132dc */
  AudioTrk_CleanUp();
  AudioCmn_DeInitAsyncSfx();

  for (int i = 0; i < 71; i++) {

    if (gaChannel[i].Partial != -1) {

      SNDstop(gaChannel[i].Partial);
      gaChannel[i].Partial = -1;
      gaChannel[i].SFXnum = -1;
    }
  }
  SNDstopall();
  SNDbankremove(-1);
  Audio_CleanUp();

  if (fReverbOn) AudioCmn_ReverbOff();

  AudioCmn_kAudioStreamingOn = gFEmusicON;
}



/* ---- AudioCmn_SetLevels__Fv  [@0x8007701c] ---- */
#line 941 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_SetLevels(void)
{
  if (Replay_ReplayInterface.statsScreen != 0) {

    AudioCmn_gLastFade = 0x20;
    gMasterSFXLevel = (GameSetup_gData.userSetting.sfxLevel * 0x40) / 0x7f; }
}

/* ---- AudioCmn_GetTimePhrase__Fi  [@0x8007706c] ---- */
#line 954 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_GetTimePhrase(int time)
{
  int seconds = time >= 0 ? (time >> 6) : ((time - 1) >> 6);
  static char compareTimes[25] = {
    30,
    12,
    6,
    5,
    4,
    3,
    2,
    1,
    0,
    -1,
    -2,
    -3,
    -4,
    -5,
    -6,
    -7,
    -8,
    -9,
    -10,
    -11,
    -12,
    -15,
    -20,
    -25,
    -30
  };
  int index;


  index = 0; while (1) { if (!(seconds < (signed char)compareTimes[index])) break; index = index + 1; if (!(index < 0x19)) break; }
  return index + 0x35;
}

/* ---- AudioCmn_CheckState__FP8Car_tObj  [@0x800770bc] ----
 * MATCH: the strict source-only TU-wide -G8 lane makes the small arrays use the
 * retail gp-relative address forms.  Restoring the direct bestLapTime and
 * gtotallaptimes expressions then gives PASS 415/415.  The former -G4 residual
 * and its diagnostic TEXT_MOVES recipe are obsolete under the no-postcompile
 * policy. */
/* Historical declaration/scheduling receipts below are superseded only
 * where the later full source-layout/value-role receipt says so. */
/* Native local homes and all 13 scope regions are restored, with 415/415
     instructions unchanged. Original text/full SLD attribution remains open. */
/* The optimized SYM stream retains only the source-visible car number and
     speed locals here; the -G8 small-data forms supply the retail schedule. */
/* Retail owns r/saidplayer/opponents in this guarded depth-3 region,
       including the bookkeeping below. Unchanged/arrested paths skip it. */
/* Retail phrase is local to this depth-9 time-phrase arm. */
/* 2026-10-28 state source recovery: retail arrays19417e/1941a1 are INT[2].
 * Use typed indexing,not pointer-truncating integer address expressions.
 * carspeed now holds only actual velocity/prediction values;read the last
 * lap time directly instead of borrowing that original name for a different
 * later quantity. Every isolated/coupled control preserves the normal ELF.
 * The shared a0 register never proved shared original source ownership.
 * Ordinary signed phrase ranges also replace folded unsigned-subtraction
 * idioms,without inventing a phrase enum or new value object.
 * Genuine state/announcement groups restore all415 word/file tags,26 block
 * records,ten complete supplied parameter/local tuples,header994/frame72
 * and end1196. Kept-condition starts1033/1079 independently require the
 * corresponding keyword lines1032/1078;earlier multiline starts kept every
 * instruction tag but missed those two records,and are not adopted.
 * SOURCE-REVIEW-UNRESOLVED: the pre-existing RaceType_Id5 reconstruction
 * label does not establish the original mode5 macro name/meaning. No new
 * identifier is substituted for it;retain that explicit original-source
 * obligation and literal macro/comment uncertainty. This covered seal is
 * not unique original text or whole-project completion. No new source
 * object,binding padding,asm/volatile,statement directive or output rewrite.
 * Receipt:build/nc12/audio_checkstate_source_20261028/. */
#line 993 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_CheckState(Car_tObj *car)
{
  char carnum;
  int carspeed;




  carnum = (char)car->carIndex;



  if ((GameSetup_gData.raceType == RaceType_HotPursuit || GameSetup_gData.raceType == RaceType_Id5) &&
      ((Cars_gHumanRaceCarList[0]->carFlags & 0x200) != 0 ||
       (Cars_gNumHumanRaceCars == 2 &&
        (Cars_gHumanRaceCarList[1]->carFlags & 0x200) != 0))) return;


  if (GameSetup_gData.numLaps == 1) return;














  carspeed = car->currentSpeed;

  if (GameSetup_gData.reverseTrack != 0)
    carspeed = -carspeed;


  if ((car->stats).lap < GameSetup_gData.numLaps && (car->stats).sliceTotal + fixedmult(carspeed,0x50000) / 0x60000 > ((car->stats).lap + 1) * gNumSlices)
  {
    int opponents;
    if (recordLapTime == 0 || simGlobal.gameTicks - gtotallaptimes[(u_char)carnum] < recordLapTime)
      AudioCmn_GetAsyncSfx(2,1,false);


    if ((car->stats).lap != 0 && simGlobal.gameTicks - gtotallaptimes[(u_char)carnum] < bestLapTime[(u_char)carnum])
      AudioCmn_GetAsyncSfx(2,0,false);


    opponents = Stats_GetNumOpponents();
    if (1 < opponents)
    {
      int position;

      if (opponents >= 3 || (car->stats).checkpointDisplay == 0) {

        position = Stats_GetPosition(car);
        if (position == opponents)
          position = 8;
        position = position + 0x4f; } else {


        position = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference); }

      if (GameSetup_gData.commMode == 1) {

        AudioCmn_GetAsyncSfx(2,(u_char)carnum + 0x33,false);
        position = position + ((u_char)carnum + 1) * 0x23; }

      AudioCmn_GetAsyncSfx(2,position,false);
    }
    if ((car->stats).lap < GameSetup_gData.numLaps + -1) {


      if ((car->stats).lap < GameSetup_gData.numLaps + -2)
        AudioCmn_GetAsyncSfx(2,(car->stats).lap + 5,false);

      else
        AudioCmn_GetAsyncSfx(2,2,false); }
  }




  if (car->lap != (u_int)(u_char)currentLap[(u_char)carnum] && AudioCmn_gPlayerArrested[(u_char)carnum] == 0)
  {
    CopSpeak_tRequest r; bool saidplayer; int opponents;
    CopSpeak_InitRequest(&r);
    saidplayer = false;

    if (GameSetup_gData.commMode == 1)

      if ((car->stats).time[(car->stats).lap + -1] < bestLapTime[car->carIndex]) {

        r.phrase = (u_char)carnum + 0x33;
        CopSpeak_Request(&r);
        saidplayer = true; }


    if (recordLapTime == 0 ||
        (car->stats).time[(car->stats).lap + -1] <
        recordLapTime) {


      r.phrase = 1;
      recordLapTime = bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r); }


    else if (bestLapTime[car->carIndex] > (car->stats).time[(car->stats).lap + -1]) {


      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r); }



    opponents = Stats_GetNumOpponents();

    if (1 < opponents)
    {
      int position; position = Stats_GetPosition(car);

      if (car->lap < GameSetup_gData.numLaps)
      {
        if (opponents >= 3 || (car->stats).checkpointDisplay == 0) {

          if (position == opponents)
            r.phrase = 0x57;
          else
            r.phrase = position + 0x4e;
        } else

        {
          int phrase;



          phrase = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference);


          if (GameSetup_gData.commMode == 1 && !saidplayer &&
              ((phrase >= 0x3b && phrase <= 0x3d) ||
               (phrase >= 0x3f && phrase <= 0x4d))) {

            r.phrase = (u_char)carnum + 0x33;
            CopSpeak_Request(&r);
            saidplayer = true; }

          r.phrase = phrase;
        }

        if (GameSetup_gData.commMode == 1 && !saidplayer)
          r.phrase = r.phrase + ((u_char)carnum + 1) * 0x23;
      }


      else if (GameSetup_gData.commMode == 1 && !saidplayer) {

        if (position == opponents && 2 < position) {
          r.phrase = (u_char)carnum == 0 ? 0x1a : 0x22;
        } else {
          r.phrase = (u_char)carnum == 0 ? position + 0x12 : position + 0x1a;
        }
      } else {

        if (position == opponents && 2 < position)
          r.phrase = 0x12;
        else
          r.phrase = position + 10;
      }

      CopSpeak_Request(&r);
    }

    if ((car->stats).lap < GameSetup_gData.numLaps) {


      if ((car->stats).lap < GameSetup_gData.numLaps + -1)
        r.phrase = (car->stats).lap + 4;

      else
        r.phrase = 2;

      CopSpeak_Request(&r);
    }

    if (currentLap[(u_char)carnum] == '\0') {
      bestLapTime[(u_char)carnum] = simGlobal.gameTicks - gtotallaptimes[(u_char)carnum];
    }





    currentLap[(u_char)carnum] = (char)car->lap;
    gtotallaptimes[(u_char)carnum] = (car->stats).lapTime;
    intensityFalseLapCounter = falseLapCounter = car->lap;
  }


}

/* ---- AudioCmn_LoadFESamples__Fv  [@0x80077738] ---- */
#line 1200 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_LoadFESamples(void)
{
  char filename[100];

  strcpy(filename, Paths_Paths[0x1c]);
  strcat(filename, "fesfx");
  AudioCmn_LoadBank(filename,0);
}

char *AudioCmn_LanguageName[7] = { /* @0x8010e774 */
  "eng", "ger", "frn", "spn", "itl", "eng", "eng"
};

/* ---- AudioCmn_LoadGameSamples__Fv  [@0x8007777c] ---- */
#line 1213 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_LoadGameSamples(void)
{
  char filename[100];



  AudioEng_StartUp(0,GameSetup_gCarNames[GameSetup_gData.carInfo[0].carType]);

  if (GameSetup_gData.commMode == 1) {
    AudioEng_StartUp(1,GameSetup_gCarNames[GameSetup_gData.carInfo[1].carType]);
  }
  AudioEng_StartServer();


  strcpy(filename, Paths_Paths[0x1c]);
  strcat(filename, "Gen");

  char *TrackGenBank[11] = {
    "eng", "brt", "eng", "fre", "eng",
    "brt", "ger", "brt", "eng", "eng",
    "eng"
  };
  strcat(filename, TrackGenBank[GameSetup_gData.track]);
  AudioCmn_LoadBank(filename,3);


  gSndBnk[5].bnkID = -2;
  gSndBnk[2].bnkID = -3;
}

/* ---- AudioCmn_InitChannelArray__Fv  [@0x800778b0] ---- */
#line 1243 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_InitChannelArray(void)
{
  int i;



  for (i = 0; i < 0x47; i++) {

    gaChannel[i].Partial = -1;
    gaChannel[i].SFXnum = -1;
  }
  AudioCmn_gCursorSndHandle = -1;
}

/* ---- scaleFrequency__Fiii  [@0x800778e8] ---- */
/* 2026-10-27 frequency source recovery: ordinary18/19 and20/21 channel
 * equality pairs replace the folded unsigned-subtraction idioms. The two
 * real MIN assignments remain separate at1270/1274;stock tail merging keeps
 * the latter's tag on the shared arithmetic. Cached selection/store/load
 * groups belong1278/1282/1284/1288,with return1290 and root end1291.
 * All51 instructions/branches,complete provided owners,normal ELF/CPE and
 * every word/file tag match. Signed inclusive ranges also pass,so literal
 * original condition spelling is not uniquely proved. No new object,scope,
 * asm/volatile,statement directive or output/reference rewrite is used.
 * Receipt:build/nc12/audio_frequency_source_20261027/. */
#line 1258 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int scaleFrequency(int sndPlayer,int iSFXnum,int tweakedForce)
{
  int scaledFreq;







  if (sndPlayer == 0x12 || sndPlayer == 0x13) {

    scaledFreq = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f); }

  else if (sndPlayer == 0x14 || sndPlayer == 0x15) {

    scaledFreq = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f); }



  else if (gaChannel[sndPlayer].SFXnum != iSFXnum) {



    scaledFreq = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);

    SkidInitMaxFreq[sndPlayer] = (char)scaledFreq; }



  else { scaledFreq = (u_int)(u_char)SkidInitMaxFreq[sndPlayer]; }

  return scaledFreq;
}

/* ---- ChooseImpactSample__Fi6s_typeT1  [@0x800779b4] ---- */
/* BUG FIX (2026-07-11): the previous recon computed the candidate sample and RETURNED it
   directly from ~20 places, entirely skipping the oracle's anti-repeat mechanism (raw disasm
   @0x80077AF8 / @0x80077BE0, global D_8013C6AC = lastImpactSample): before returning, the
   oracle compares the candidate against lastImpactSample and, for a handful of specific
   candidate values, re-rolls via random() to avoid repeating the same impact sound twice in a
   row. lastImpactSample is a function-local static that (per a full-binary grep of every
   disasm dump) is NEVER WRITTEN anywhere in the program -- so at runtime this check always
   reads 0 and the reroll paths are dead (none of the candidate values is ever 0) -- but the
   real compiler still emitted ~80 real instructions for the mechanism, which is why the
   previous recon compiled to only 103 insns against the oracle's 184. Restored the mechanism
   (still using the same never-written `lastImpactSample` static, so behavior is unchanged --
   this is a byte-fidelity fix, not a gameplay fix) by routing every candidate through
   `iSFXnum` and an anti-repeat block per half of the switch instead of an early `return`. */
/* 2026-10-27: actual s_type enumerators supplied by the owning retail
 * ENUM/MOE records replace numeric surface IDs;no identifier is invented.
 * Ordinary layout preserves all executable tokens except those proven-equal
 * constant spellings,and restores all184 word/file tags,both block records,
 * complete provided owners,header/frame/mask and end1423. The static
 * lastImpactSample initializer remains0x63,with unchanged bytes/storage.
 * Keep the explicit force-range upper tests:the simplification controls do
 * not match code. Their logical redundancy does not make them removable
 * from a faithful matching reconstruction. No new object,scope,qualifier,
 * asm,volatile,fake use,compiler flag or statement #line is introduced.
 * Literal original macro/comment/constant spelling remains unproved despite
 * the recovered enum identities. This is not whole-project source recovery.
 * Receipt:build/nc12/impact_sample_source_20261027/. */
/* Retail bytes confirm the nonzero initializer at .sdata+0x84. */
#line 1295 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int ChooseImpactSample(int force,s_type surface1,s_type surface2)
{

  static int lastImpactSample = 0x63;





  int iSFXnum = 0;




  if (surface1 == kBackFire) {
    iSFXnum = 0x13; }
  else if (surface1 == kTires && surface2 == kAsphalt) {
    iSFXnum = 0x1f; }
  else if (surface1 == kCarBody && surface2 == kWoodWall) { iSFXnum = 0x1e; }

  else if (surface1 == kCarBody && surface2 == kGrassWall) { iSFXnum = 0x1d; }

  else if (surface1 == kCarBody && surface2 == kWall) {

    if (force > 0x6e) iSFXnum = 0x21; else
    iSFXnum = (random() & 1) ? 0x25 : 0x20; }

  else if (surface1 == kCarBody && surface2 == kWallSpark) {

    switch ((u_int)random() % 4) { case 1: iSFXnum = 0x22; break; case 0: iSFXnum = 0x23; break;









      case 2: iSFXnum = 0x20; break; case 3: iSFXnum = 0x25; break;





      default: iSFXnum = 0x23; break; } }


  else if (surface1 == kCarBody && surface2 == kSign) { iSFXnum = 0x1d; }





  else if (surface2 == kBlowOut) {
    iSFXnum = 0x12; }

  else if (surface1 == kCarBody && (surface2 == kAsphalt || surface2 == kGravel)) {

    if (force > 0x50) {
      iSFXnum = 0x21; } else {
      if (force <= 0x50 && force > 0x16)
      iSFXnum = 0x22;
      else if (force <= 0x16 && force > 0x10)
      iSFXnum = 0x20;
      else if (force <= 0x10)
      iSFXnum = 0x1d; }

    if (iSFXnum == lastImpactSample && iSFXnum != 0x21) {

      switch (iSFXnum) { case 0x22:

        iSFXnum = (random() & 1) ? 0x1d : 0x20;
        break; case 0x1d:

        iSFXnum = (random() & 1) ? 0x22 : 0x20;
        break; case 0x20:

        iSFXnum = (random() & 1) ? 0x1d : 0x22;
        break; } } } else {






    if (force > 0x5a) {

      iSFXnum = 0x21; } else {

      if (force <= 0x5a && force > 0x46)

      iSFXnum = 0x20;

      else if (force <= 0x46 && force > 0x32)

      iSFXnum = 0x25;

      else if (force <= 0x32 && force > 0x19)

      iSFXnum = 0x22;

      else if (force <= 0x19)

      iSFXnum = 0x1e; }


    if (iSFXnum == lastImpactSample && iSFXnum != 0x21) {

      switch (iSFXnum) { case 0x1e: iSFXnum = 0x22; break; case 0x22:




        iSFXnum = (random() & 1) ? 0x1e : 0x25;
        break; case 0x25:

        iSFXnum = (random() & 1) ? 0x1e : 0x22;
        break; case 0x20:

        iSFXnum = (random() & 1) ? 0x25 : 0x22; break; } } }







  return iSFXnum;
}

/* ---- ChooseLoopedSample__F6s_typeT0  [@0x80077c94] ---- */
/* MATCH (w59-a10 branch-target audit): the old `if (surface2 != 0xc) goto
     LAB_80077cec;` + a SECOND `iVar1 = 0x2c;` outside the surface1==2 block
     gated PASS but branched the `surface1 != 2` entry test into idx20 (the
     re-store) instead of retail's idx21 (.L80077CE8) -- retail 14820013 vs
     ours 14820012.  The plain nested `if (surface2 == 0xc)` arm reproduces
     retail's target: the unconditional `iVar1 = 0x2c` already lives in the
     entry bne's DELAY SLOT (idx2), so no second store outside is needed. */
/* 2026-10-27 loop-sample source recovery: every surface name/value below is
 * supplied by retail's s_type ENTAG188f8f..EOS189150,not an inferred taxonomy.
 * Outer tire test and its asphalt test share1432; subsequent tests and actual
 * sample assignments occupy separate lines. Keep the corrected nested grass
 * arm: the old duplicate default store sent the outer skip to the wrong word.
 * All47 instructions/branches,complete supplied locals and scope addresses
 * survive. Ordinary anchored layout restores all47 word/file tags,root end
 * line1452 at+180,and the distinct function-end/return line1451. Literal
 * original macro/comment spellings remain unproved. No new object,scope,
 * asm/volatile,statement directive or output/reference rewrite is used.
 * Receipt:build/nc12/audio_loop_source_20261027/. */
#line 1427 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int ChooseLoopedSample(s_type surface1,s_type surface2)
{
  int SFXnum;

  SFXnum = 0x2c;
  if (surface1 == kTires) { if (surface2 == kAsphalt) {
    SFXnum = 0x2a; }
    if (surface2 == kWetAsphalt) {
      SFXnum = 0x2d; }
    if (surface2 == kRaceTireOnAsphalt) {
      SFXnum = 0x2e; }
    if (surface2 == kRainTireOnAsphalt) {
      SFXnum = 0x2f; }
    if (surface2 == kSnow) {
      SFXnum = 0x2b; }
    if (surface2 == kGrass) {
      SFXnum = 0x2c; } }
  if (surface1 == kCarBody && (surface2 == kAsphalt || surface2 == kWetAsphalt || surface2 == kGravel || surface2 == kSnow)) {
    SFXnum = 0x28; }
  if (surface1 == kTires && surface2 == kGravel) {
    SFXnum = 0x29; }
  if (surface1 == kCarBody && surface2 == kGrass) {
    SFXnum = 0x2c; }

  return SFXnum;
}

/* ---- AudioCmn_SFX__Fi6s_typeT1iii  [@0x80077d50] ---- */
/* MATCH (2026-08-14): PASS (224 insns), from authoritative 134-diff baseline.
   Retail shape: two block-local default/override clamp bridges keep the computed
   quotient in v1/a0 (impact) and v1/a3 (loop), with the named tempAmp copied to
   s0 in the ChooseImpactSample delay slot.  The negative non-impact arm is a
   literal PlaySFX(0x31,...,0x40,...) tail, not assignments to shared locals.
   The loop uses the out-of-line low-amplitude cleanup and `amplitude +
   (amplitude << 1)` for the retail addend order.  AUDAI 2026-10-04: the four
   read-only asm ref fences are gone; two absorption identities on tweakedForce
   then reproduced the SYM s5/s0/s1/s3/s4 allocation.
   2026-10-19: those identities are now removed too. Restore the real three-way
   impact/zero-force/active-loop branch and keep the active final PlaySFX in
   its actual arm. Structured negative sample arms need no early returns.
   This preserves all 224 words without a fence, qualifier or neutral identity;
   the older reference-budget necessity claim applied to a different source
   checkpoint. Independent fresh-baseline controls already make either/both
   identities inert; their removal does not require the branch rewrite.
   Original literal syntax and complete SLD still require recovery. */

/* SYM rule-8 REWRITE (w54-a11).  Local map from the SYM `8c Function start` block:
   iSFXnumber = REG $17 (s1), amplitude = REG $19 (s3), frequency = REG $20 (s4) at
   function scope; tempAmp = REG $16 (s0) in the block starting 0x80077E18; c (PTR
   Car_tObj) = REG $16 (s0) in the block starting 0x80077FB0.  sndPlayer = s5,
   tweakedForce = s0, Distsq = ARG copied to v1, azimuth = ARG copied to s6.
   Everything else the old recon declared (iVar1..iVar4, pCVar5, uVar6, vol) was
   fabricated.  BUG FIX: the retail entry guard on AudioCmn_kAudioOn (SLD 1485,
   0x80077D58/0x80077D84) was missing entirely. */
/* 2026-10-27: actual selector assignment1506 precedes comparison1509;
 * separate car-type1553 and roll/damage1556 guards,and frequency selector1569,
 * subtraction1571 and lower clamp1572,restore real statement phases without
 * a new variable or expression-region workaround. All224 word/file tags,
 * every24 block-line record,all supplied locals/owners,frame/header/end1577
 * agree,with whole ELF/native CPE unchanged. The merged follow-up SDK call
 * and all original MIN arithmetic remain intact. A real value-region
 * control also has zero tag differences but breaks code and supplied scopes;
 * it is rejected,not accepted from tag count alone. Optimized debug owners
 * are not a literal lexical placement recipe. Original macro/comment text
 * is not uniquely proved. No new object,name,asm,volatile,qualifier,fake use,
 * artificial scope,compiler flag,statement anchor or output rewrite is used.
 * Receipt:build/nc12/audiocmn_sfx_layout_20261027/. */
/* Retail spells the 0x23 follow-up as its OWN PlaySFX call with literal args; gcc
       cross-jumps it into the shared tail `jal` at 0x800780A0, entering one instruction
       late because it stores tempAmp instead of amplitude into 0x10(sp). */
#line 1456 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_SFX(int sndPlayer,s_type surface1,s_type surface2,int tweakedForce,int Distsq,
int azimuth)
{
  int iSFXnumber;
  int amplitude;
  int frequency;























  if (AudioCmn_kAudioOn == 0) { return; }




  if (Distsq < 0x1324) {
    amplitude = ((0x1324 - Distsq) * 0x7f) / 0x1324; } else {

    amplitude = 0; }








  if (sndPlayer < 0)
  {

    tweakedForce = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
    iSFXnumber = ChooseImpactSample(tweakedForce,surface1,surface2);


    if (iSFXnumber == 0x1f)
    {
      int tempAmp; tempAmp = ((amplitude * tweakedForce) / 0x7f) * 2;
      if (0x7f < tempAmp) { tempAmp = 0x7f; }
      AudioCmn_PlaySFX(0x31,0x1f,0x40,0x10000,amplitude,azimuth);
      AudioCmn_PlaySFX(0x31,0x23,0x40,0x10000,tempAmp,azimuth); }

    else if (iSFXnumber == 0x12) {

      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x12,azimuth,0x7f,0x40);
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x16,azimuth,0x7f,0x40);
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x23,azimuth,amplitude,0x40); } else {


      AudioCmn_PlaySFX(0x31,iSFXnumber,0x40,0x10000,amplitude,azimuth); } }




  else if (tweakedForce < 1) {

    freeVoiceChannel(sndPlayer);
    if (1 < sndPlayer - 0x12U) { return; }

    freeVoiceChannel(sndPlayer + 4);
    Cars_gList[sndPlayer - 0x12U]->audioDamageScrape = 0; return; }




  else {
    iSFXnumber = ChooseLoopedSample(surface1,surface2);
    frequency = scaleFrequency(sndPlayer,iSFXnumber,tweakedForce);


    if (sndPlayer - 0x12U < 2)
    {
      tweakedForce = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
      amplitude = amplitude * tweakedForce >> 7;
      if (
      amplitude >= 0x1f)
      {
        Car_tObj *c; c = Cars_gList[sndPlayer - 0x12U];

        if (c->carInfo->carType < 0x1c) {


          if (((c->render).currentRoll > 0 && (0x1e0000 < (c->N).damage[7])) || (((c->render).currentRoll < 0 && (0x1e0000 < (c->N).damage[3])))) {

            AudioCmn_PlaySFX(sndPlayer + 4,0x28,frequency + 10,0x10000, amplitude + (amplitude << 1),azimuth);
            c->audioDamageScrape = amplitude; } } } else {





        freeVoiceChannel(sndPlayer + 4);
        Cars_gList[sndPlayer - 0x12U]->audioDamageScrape = 0; } }


    if (iSFXnumber == 0x2c) {

      frequency = frequency + -0x3c;
      if (frequency < 0) { frequency = 0; } }

    AudioCmn_PlaySFX(sndPlayer,iSFXnumber,frequency,0x10000,amplitude,azimuth);
  }

}

/* ---- freeVoiceChannel__Fi  [@0x800780d0] ---- */
/* 2026-10-27 voice source recovery: retail Channels_t's Partial is INT
 * (188f47),not a pointer. Compare it directly to -1,removing the decompiler's
 * implementation-defined integer-to-pointer sentinel comparison. Preserve
 * the canonical unsigned tag conversion at SNDautovol's real call boundary.
 * Early audio/index exit1584 and actual work1587..1592 preserve root end1593
 * and function end1595. Prefix counter decrement also needs no captured value.
 * All28 words,provided sndPlayer home and complete scope/SLD fields match;
 * the compound/two-guard and assignment controls also match,so literal
 * original syntax is not unique. No new name/object,scope padding,asm/volatile,
 * statement directive or output rewrite. Receipt:
 * build/nc12/audio_thunder_source_20261027/. */
#line 1579 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void freeVoiceChannel(int sndPlayer)
{



  if (AudioCmn_kAudioOn == 0 || sndPlayer == -1) return;


  if (gaChannel[sndPlayer].Partial != -1) { /* @0x80078108: Partial == -1 sentinel (disasm-v3) */

    SNDautovol((unsigned int)gaChannel[sndPlayer].Partial,5,-1);
    gaChannel[sndPlayer].Partial = -1;
    gaChannel[sndPlayer].SFXnum = -1;
    --NumSFXOn;
  }

}

/* ---- AudioCmn_PlayDoppleredSound__Fiiiiii  [@0x80078140] ---- */
/* BUG FIX (2026-07-11): same struct-fields-as-separate-locals bug as AudioCmn_PlayFESFXVol --
   a real `SNDPLAYOPTS playopts;` was already declared but unused; every field write instead
   targeted its own free-standing local (local_30/local_2c/local_29/...), so only local_30's
   address escaped (passed to SNDplaysetdef/SNDplay) and gcc dead-store-eliminated every other
   field write. At runtime this played every dopplered sound with garbage bhandle/pan/vol/bend/
   pitchmult/use3dpos/azimuth (stack garbage) -- a real behavior bug (ours compiled to only
   50 insns vs the oracle's 152: almost the entire field-setup body was eliminated). Fixed by
   writing through the real struct so every field store's address escapes via &playopts. */
/* 2026-10-27: all152 word/file tags,six block-line records,complete
 * supplied parameter/local tuples,header/frame/mask and end1709 now agree.
 * Ordinary source grouping preserves every executable token and its order.
 * Async-bank test1677/opening brace1678/declaration1679 independently restore
 * the supplied outer/inner owners;their byte addresses remain unchanged.
 * Original literal macro/comment/declaration text is not uniquely certified.
 * Existing arithmetic/signed-byte/branch receipts are retained below,outside
 * the anchor. No new name,object,scope,asm,volatile,fake use or statement
 * directive is introduced. Receipt:build/nc12/audiocmn_doppler_sld_20261027/. */
/* SYM rule-8: only fn-scope shandle (REG $2=v0) + AUTO playopts + block-local bank (a0)
     are named; the vol-select multiplier/level values are ANONYMOUS temps -- per-arm INLINE
     playopts.vol stores below, gcc cross-jumps the identical [lw SFX; subu; mult; sra 14]
     tails into the oracle's shared .L78278/.L7827C/.L80280 merge blocks (funnel vars in
     source would PREVENT that merge shape). gSndBnk[2].bnkID is read twice and CSE'd by
     gcc into $v1 (live to the patchNum==3 recheck) -- no named cache var. */
/* MATCH: (vol*0x41)<<1 -- the SHIFT node breaks gcc's multiply-chain linearization,
       which otherwise regroups the 0x82 constant onto the LEVEL operand (oracle shifts s0:
       sll6;addu;sll1) and flips the mult operand order out of the shared .L80078280 tail. */
/* MATCH: same shift-node lever (sll3;subu;sll1 on vol) */
/* MATCH: real if/else (not unconditional store + override) -- oracle stores patnum=1 on
     the ==99 arm then jumps to the shared merge, patnum=patchNum only on the fallthrough. */
/* MATCH: arm order swapped vs the Ghidra-style "==0" first -- oracle's fallthrough (common)
     path is the != 0 azimuth store; the ==0 pan/stereo code is pushed out-of-line. */
/* MATCH: arm order swapped again (same lever as the outer Audio_direct3davail check) --
       oracle's fallthrough is the != 0 azimuth-band compute; ==0 pan=0x40 is out-of-line. */
/* MATCH: oracle shifts this one ARITHMETICALLY (sra) -- no u_int cast (plain signed
           int >> 8), unlike the sibling branch below which does want the unsigned srl. */
/* BUG FIX (round-2): playopts.bhandle is a plain `char` field, UNSIGNED on this build
     (CC1PLPSX reads every char field with lbu) -- comparing the raw field against -1/-4/-3
     is provably false/true for an unsigned promotion and gcc silently DELETES the whole
     GetAsyncSfx block (a real behavior bug: async bank lookup never ran). Oracle reloads
     the byte ONCE via a signed `lb` and reuses it for all three tests. */
/* SYM block line 64: REG $4 = a0 (the call arg) */
/* BUG FIX (round-2): same unsigned-char issue -- "-1 < playopts.bhandle" on the raw
     field folds to always-true (SNDplay called unconditionally, oracle has a real bltz
     guard skipping playback for a failed/invalid handle). Cast to signed.
     MATCH: else-arm -1 (not up-front init) puts li v0,-1 in the bltz delay slot and keeps
     shandle in its SYM home REG $2 (v0) = the call result, no copies. */
#line 1614 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_PlayDoppleredSound(int bhandle,int patchNum,int azimuth,int vol,int bend,int doppler)
{
  int shandle;
  SNDPLAYOPTS playopts;










  SNDplaysetdef(&playopts);
  playopts.bhandle = (char)bhandle;

  if (patchNum == 0x7d) {
    playopts.vol = (u_char)(gMasterSFXLevel * vol >> 7); }

  else if (bhandle == -4) {
    playopts.vol = (u_char)(gMasterFENarrationLevel * 0x81 >> 7); }

  else if (bhandle == gSndBnk[2].bnkID) {
    playopts.vol = (u_char)(gMasterAmbientLevel * (vol * 0x28 - vol) >> 0xe); }

  else if (bhandle == gSndBnk[5].bnkID) {
    playopts.vol = (u_char)(gMasterAmbientLevel * ((vol * 0x41) << 1) >> 0xe); }


  else if ((patchNum == 0x16) || (patchNum == 0x12)) {
    playopts.vol = (u_char)(gMasterSFXLevel * vol >> 7); } else if ((patchNum == 3) &&





  ((bhandle == gSndBnk[0].bnkID) || (bhandle == gSndBnk[2].bnkID))) { playopts.vol = (u_char)(gMasterSFXLevel * (vol * 0x80 - vol) >> 0xe); }


  else if (patchNum == 0) {
    playopts.vol = (u_char)(gMasterEngineLevel * ((vol * 7) << 1) >> 0xe); } else {


    playopts.vol = (u_char)(gMasterSFXLevel * (vol * 0x28 - vol) >> 0xe); }

  if (patchNum == 99) {
    playopts.patnum = 1; } else {

    playopts.patnum = patchNum; }

  playopts.bend = (char)bend;
  playopts.pitchmult = (u_short)(doppler >> 4);
  playopts.use3dpos = Audio_direct3davail != 0;

  if (Audio_direct3davail != 0) {
    playopts.azimuth = (u_short)azimuth; } else {
    if (gStereoMode != 0) {
      if (azimuth - 0x4000U < 0x8000) { playopts.pan = (u_char)((0xbfff - azimuth) >> 8); } else { playopts.pan = (u_char)((u_int)(azimuth + 0x4000) >> 8); } } else {

      playopts.pan = 0x40; } }


  if ((signed char)playopts.bhandle < -1)
  {
    int bank;

    if ((signed char)playopts.bhandle == -4) {
      bank = 2; } else {
      bank = ((signed char)playopts.bhandle == -3); }




    playopts.bhandle = (char)AudioCmn_GetAsyncSfx(bank,patchNum,false);
    playopts.patnum = 0;
  }


  if (-1 < (signed char)playopts.bhandle) {

    shandle = SNDplay(&playopts); } else { shandle = -1; }












  NumSFXOn = NumSFXOn + 1;
  return shandle;
}

/* ---- AudioCmn_PlaySound__Fiiiii  [@0x800783a0] ---- */
#line 1715 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_PlaySound(int bhandle,int patchNum,int azimuth,int vol,int bend)
{








  return AudioCmn_PlayDoppleredSound(bhandle,patchNum,azimuth,vol,bend,0x10000);
}

/* ---- AudioCmn_PlaySFX__Fiiiiii  [@0x800783cc] ---- */
/* 2026-10-27: all316 word/file tags,all supplied locals/homes/owners,
 * every region/frame/header/end and absence of source LABELs now agree.
 * iPartial holds returned handles in REG2,not the former bank Boolean REG4.
 * A real single-use bank-index local restores the supplied if/body regions
 * and is copy-elided from native declarations. Ordinary typed array fields
 * then remove chbase/slot/r and all remaining label dispatch,without devices.
 * Special playback computes the handle1808/decrements count1810 before its
 * stores1812/1813 in source,despite the scheduler's different execution order.
 * SOURCE-REVIEW-UNRESOLVED: bankNum is a symbol-backed NFS2 spelling for
 * actual bank indices,not a supplied NFS4 local identifier. The root lookup
 * and shadowing async selector have genuine work/owners;their original names,
 * erased type spelling/declaration placement and literal macro text are not
 * uniquely recovered. Plain int/long/bool selector controls pass,with no
 * const/volatile disguise. A frequency-parameter reuse control matches code
 * but corrupts its provided home and is explicitly NOT adopted.
 * This is a full covered contract,not proof of literal original source text.
 * Receipt:build/nc12/playsfx_roles_20261027/. */
#line 1730 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_PlaySFX(int sndPlayer,int iSFXnum,int iFreqIn,int iDopplerIn,int iAmpIn,int azimuth)
{
  int iPartial;
  int iFreq;
  int iAmp;
  long PatchBank;
  u_char bankNum;














  iFreq = iFreqIn;

  iFreq = (iFreq < 0) ? 0 : iFreq;
  iFreq = (0x7f < iFreq) ? 0x7f : iFreq;

  iAmp = iAmpIn; if (iAmp < 0) { iAmp = 0; }
  iAmp = (0x7f < iAmp) ? 0x7f : iAmp;












  if (sndPlayer - 0x1cU < 4 || sndPlayer - 0x32U < 4 || sndPlayer == 0x24 || sndPlayer == 0x36 || sndPlayer - 0x37U < 0x10) {

    PatchBank = gSndBnk[5].bnkID;
  } else {

    if (sndPlayer - 10U < 8 || sndPlayer - 0x1aU < 2) {

      PatchBank = gSndBnk[2].bnkID;

    } else {

      switch (iSFXnum) {





      case 8: case 10: case 11:
        PatchBank = gSndBnk[3].bnkID;
        break;
      case 0x7d:
        PatchBank = gSndBnk[5].bnkID;
        break;

      default:
        bankNum = (u_char)gBankNumLookupTable[sndPlayer];
        PatchBank = gSndBnk[bankNum].bnkID;
        break;
      }
    }
  }





  if (sndPlayer == 0x31)
  {
    iPartial = AudioCmn_PlayDoppleredSound(PatchBank,iSFXnum,azimuth,iAmp,iFreq,iDopplerIn);

    NumSFXOn = NumSFXOn - 1;

    gaChannel[0x31].Partial = iPartial;
    gaChannel[0x31].SFXnum = iSFXnum;
  }



  else
  {

    if (gaChannel[sndPlayer].SFXnum == iSFXnum)
    {

      if (SNDover(gaChannel[sndPlayer].Partial) != 0) {

        gaChannel[sndPlayer].Partial = -1;
        gaChannel[sndPlayer].SFXnum = -1;
      }



      int bankNum = (PatchBank == -3);





      if ((PatchBank < -1) && (AudioCmn_GetAsyncSfx(bankNum,iSFXnum,false) == -1)) {

        gaChannel[sndPlayer].Partial = -1;
        gaChannel[sndPlayer].SFXnum = -1; } }




    if (gaChannel[sndPlayer].SFXnum != iSFXnum) {


      if (gaChannel[sndPlayer].Partial != -1) {

        SNDstop(gaChannel[sndPlayer].Partial);
        NumSFXOn = NumSFXOn - 1;
      }

      iPartial = AudioCmn_PlayDoppleredSound(PatchBank,iSFXnum,azimuth,iAmp,iFreq,iDopplerIn);

      if (iPartial != -1) {

        gaChannel[sndPlayer].Partial = iPartial;
        gaChannel[sndPlayer].SFXnum = iSFXnum; }


      else {
        gaChannel[sndPlayer].Partial = iPartial;
        gaChannel[sndPlayer].SFXnum = iPartial; }





    } else if (gaChannel[sndPlayer].Partial != -1) {

      if (iSFXnum == 0x7d) {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterSFXLevel * iAmp >> 7); }
      else if (PatchBank == gSndBnk[2].bnkID) {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterAmbientLevel * (iAmp * 0x28 - iAmp) >> 0xe); }
      else if (PatchBank == gSndBnk[5].bnkID) {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterAmbientLevel * ((iAmp * 0x41) << 1) >> 0xe); }
      else if (iSFXnum == 99) {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterAmbientLevel * (iAmp * 0x28 - iAmp) >> 0xe); }
      else if ((iSFXnum == 3) && ((PatchBank == gSndBnk[0].bnkID) || (PatchBank == gSndBnk[2].bnkID))) {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterSFXLevel * (iAmp * 0x80 - iAmp) >> 0xe); }
      else if (iSFXnum == 0) {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterEngineLevel * ((iAmp * 7) << 1) >> 0xe); }
      else {
        SNDvol(gaChannel[sndPlayer].Partial,gMasterSFXLevel * (iAmp * 0x28 - iAmp) >> 0xe); }

      if (Audio_direct3davail != 0) {
        SND3dpos(gaChannel[sndPlayer].Partial,azimuth,0); }
      else { if (gStereoMode != 0) {
        SNDpan(gaChannel[sndPlayer].Partial,(int)(azimuth - 0x4000U < 0x8000 ? (u_int)(0xbfff - azimuth) : (azimuth + 0x4000U & 0xffff)) >> 8); } }

      SNDpitchbend(gaChannel[sndPlayer].Partial,iFreq);
      SNDpitchmult(gaChannel[sndPlayer].Partial,iDopplerIn >> 4); }

    else {
      gaChannel[sndPlayer].SFXnum = -1; } }




  return gaChannel[sndPlayer].Partial;
}

/* ---- AudioCmn_SoundCar__FP8Car_tObjiiiiiii  [@0x800788bc] ---- */
/* 2026-10-19: the amplitude max select needs no scaledAmplitude source object.
 * Keep amplitude FIRST in the strict greater-than comparison and true arm;
 * GCC's MAX_EXPR operand order preserves the anonymous v1 product/result and
 * amplitude's supplied a2 home. All 530 words match. Reversed operands and
 * the alternate strictness/arm combinations are not interchangeable here.
 * Split branch-local fixeddiv stores and the direct nonnegative road-noise
 * selection also remove attenuation, including its later threshold-value
 * reuse. The two output
 * producers must be tested together: removing just the first capture changes
 * scheduling. distanceScale and the debug-elided rpmRatio remain source-review work;
 * the later dated receipts supersede the old empty-asm and SLD status. This does not
 * certify a literal original macro name or full SLD restoration. */
/* 2026-10-19 follow-up: ordinary iAmpIn/tuntrig assignments reproduce the
 * supplied AUTO homes at sp-52/sp-48 through natural allocator spills. No
 * address-taking store view is needed. Remove both together: changing only
 * tuntrig swaps those homes; the paired change preserves every 530 word and
 * every provided local record. Full source/SLD recovery remains open. */
/* MATCH P903: direct gas-ramp array expressions remove currentGas, previousGas,
   gasDelta and rampedGas, together with their two empty-asm references. Rising
   stores remain branch-local; the falling step is the existing MIN idiom.
   The audio-off early return restores gas's native depth1 owner. Native scalar
   homes, all530 words and every branch remain unchanged; SLD37/319 ->37/261.
   The last empty-asm site is now removed by ordinary fixed-point source.
   At that checkpoint distanceScale/rpmRatio remained unproved; see the later
   speed-stage receipt below for distanceScale removal. */
/* 2026-10-27: freq=freq*doppler/0x10000 replaces the empty asm operand
 * fence at530/530,whole normal ELF/CPE and entire native SYM dump unchanged.
 * Stock flow keeps the signed divide's empty sign branch;late jump2 deletes
 * it after liveness,leaving the real retail MULT/MFLO. Plain product/shift
 * controls fail. Original unused destination/divisor spelling is not unique:
 * an iFreqIn-assignment control also passes. This is a valid device-free
 * source reconstruction,not proof of literal original text or full SLD.
 * Raw static/o32 liveness confirms the product is not read before kill.
 * No new name,qualifier,scope,fake use or output/reference rewrite is added.
 * Receipt:build/nc12/audiocmn_sound_source_20261027/. */
/* 2026-10-27 source-layout follow-up: all530 instruction/file tags,
 * four block-line records,header/frame and end2190 match retail. Separate
 * genuine comm-mode/reverb-level guards restore1983/1985 independently;
 * a single && line cannot represent both. Ordinary implicit void fallthrough
 * preserves the final gas owner ending2185 and function-end note2190.
 * Whole normal ELF/native CPE and every current local/address owner survive.
 * The later speed-stage receipt removes the then-extra distanceScale.
 * SOURCE-REVIEW-UNRESOLVED: debug-elided rpmRatio remains an unproved source
 * capture; native declaration cleanliness does not certify that object.
 * Earlier capture-free failures applied only to the unstaged speed graph.
 * CurCarGasLevel/cobblestoneAmp phase identities are not uniquely established
 * by their shared REG16/root owner; NFS2 uses the opposite semantic phases.
 * No name is swapped on that cross-version evidence alone. Original macro
 * spelling/declaration lines and erased comments remain unproved. The 530
 * word SLD contract is NOT a full source/locals or whole-goal certificate.
 * No new asm,volatile,object,fake use,scope or statement #line is introduced.
 * Receipt:build/nc12/soundcar_gas_20261027/. */
/* 2026-10-27 speed-stage source recovery: compute the real absolute speed
 * in provided CurCarGasLevel,then shift that same value at source1937. The
 * factor-first attenuation product can then divide directly by0x10000 at2036,
 * removing distanceScale without a replacement object,cast,fence or fake use.
 * All530 words,the whole normal ELF/native CPE,every supplied local tuple,
 * four block-line records,all word/file tags and end2190 remain exact.
 * Selected-stock plain/-da outputs agree. Its observed CurCarGasLevel p88
 * is15 refs/136 insns/5 calls,REG16; the unstaged direct-product control is
 *13/135/5,REG17 and fails. The original captured form was14/137/5,REG16.
 * Real absolute/shift stages restore that allocation without artificial refs.
 * This is an observed stock receipt,not an allocsim EXACT-model claim.
 * Both separate/compound shifts can match,so literal original syntax is not
 * unique. The CurCarGasLevel/cobblestoneAmp phase-role uncertainty and
 * rpmRatio source producer remain open; no whole-source completion is claimed.
 * Receipt:build/nc12/soundcar_abs_land_20261027/. */
#line 1906 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_SoundCar(Car_tObj *car,int dst,int iFreqIn,int doppler,int azimuth,int trackazim,int relvel,
int cardir)
{
  int CurCarGasLevel; int freq;
  int roadSurface; int cobbleMod;
  int cobblestoneAmp; char SPSC;
  int PlayerPan; static char cobbleCount = 0;
  int loadAmp; int amplitude;
  int roadNoiseAmp; int wetNoiseAmp;
  int roadNoiseFreq; int wetNoiseFreq;
  int iAmpIn; int tuntrig;
  int cam; int roadNoisePatch;
  int rpmRatio;




  AudioCmn_CheckState(car);



  if (!AudioCmn_kAudioOn) return;


  if (Camera_gInfo[car->carIndex].mode == 0xc) {
    iAmpIn = fixeddiv(0x10000000,dst + 0x10000) / 0x10000; } else {

    iAmpIn = fixeddiv(0x8000000,dst + 0x20000) / 0x10000; }


  roadNoiseAmp = (__builtin_abs((car->linearVel_ch).z) - 0xd8000 >= 0) ? (__builtin_abs((car->linearVel_ch).z) - 0xd8000) >> 0xf : 0;
  CurCarGasLevel = __builtin_abs((car->linearVel_ch).z); CurCarGasLevel = CurCarGasLevel >> 0xf;

  if (0x7f < CurCarGasLevel) { CurCarGasLevel = 0x7f; }
  cobbleMod = CurCarGasLevel / 0x10;
  cobbleMod = 8 - cobbleMod;
  if (cobbleMod < 3) { cobbleMod = 3; }
  roadNoiseFreq = 0x40;


  freq = iFreqIn;
  if (0x96 < freq) { freq = 0x96; }
  if (freq < 0) { freq = 0; }























  roadSurface = (car->N).driveSurfaceType;





  tuntrig = (int)BWorldSm_TunnelFlagSm(&(car->N).simRoadInfo);


  if (tuntrig != 0) {

    if ((GameSetup_gData.commMode != 1)) {

      if (((u_char)fReverbLevel < 100)) {

        fReverbLevel = (char)((100 < (u_char)fReverbLevel + 10) ? 100 : (u_char)fReverbLevel + 10);
        SNDfxmasterlevel(0x0,(u_char)fReverbLevel);
        fReverbOn = '\x01'; } }


    roadNoiseAmp = roadNoiseAmp + 0x14;
    roadNoiseFreq = 0x5e; } else {

    if ((u_char)fReverbLevel < 0x20) {

      fReverbLevel = ' ';
      SNDfxmasterlevel(0x0,0x20);
      fReverbOn = '\x01'; }

    else if (0x20 < (u_char)fReverbLevel) { fReverbLevel = (char)((0x20 > (int)((u_char)fReverbLevel - 5)) ?

      0x20 : (u_char)fReverbLevel - 5);
      SNDfxmasterlevel(0x0,(u_char)fReverbLevel); } }







  if (GameSetup_gData.commMode == 1) {

    SPSC = true; PlayerPan = 0xc002;
    if (car->carIndex != 0) {
      PlayerPan = 0x3ffe; } } else {



    SPSC = false;
    PlayerPan = 0; }







  if (car->blowout != 0) {

    roadSurface = 4;
    CurCarGasLevel = CurCarGasLevel << 1; }


  if (dst < 0x460000) {
    CurCarGasLevel = (((0x13240000 - fixedmult(dst,dst)) / 0x1324) * CurCarGasLevel) / 0x10000; } else {

    CurCarGasLevel = 0; }

  switch(roadSurface) { case 2: case 10: case 0xb: case 0xd:





    roadNoiseAmp += roadNoiseAmp / 4;
    roadNoiseFreq = 0x18;
    break; case 4: case 7: case 0xc:



    cobbleCount = cobbleCount + 1;
    cobbleCount = cobbleCount % cobbleMod;
    if ((cobbleCount == 0) && ((car->N).objAltitude < 0x3333) && (0 < gMasterSFXLevel)) {



      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x1d,SPSC ? PlayerPan : 0, CurCarGasLevel / 2,roadSurface == 7 ? 0x28 : 0x40); } }





  if (gMasterEngineLevel == 0) { return; }




  if (Camera_gInfo[car->carIndex].mode < 0) { cam = 2; roadNoiseAmp = roadNoiseAmp >> 1; } else if (Camera_gInfo[car->carIndex].mode < 2) { cam = 0; }
  else if (Camera_gInfo[car->carIndex].mode < 5) {
    cam = 1;









    roadNoiseAmp = roadNoiseAmp >> cam; } else {


    cam = 2;
    roadNoiseAmp = roadNoiseAmp >> 1; }



  amplitude = iAmpIn;

  if (PlayersRampedGasLevel[car->carIndex] < (u_char)(car->control).gasLevel) {
    if (((u_char)(car->control).gasLevel - PlayersRampedGasLevel[car->carIndex]) / 2 > 0) { PlayersRampedGasLevel[car->carIndex] += ((u_char)(car->control).gasLevel - PlayersRampedGasLevel[car->carIndex]) / 2; } else { PlayersRampedGasLevel[car->carIndex] += 1; }
  } else if ((u_char)(car->control).gasLevel < PlayersRampedGasLevel[car->carIndex]) {
    PlayersRampedGasLevel[car->carIndex] += MIN(((u_char)(car->control).gasLevel - PlayersRampedGasLevel[car->carIndex]) / 8,-1); }

  cobblestoneAmp = PlayersRampedGasLevel[car->carIndex];

  if (0xff < cobblestoneAmp) { cobblestoneAmp = 0xff; }










  loadAmp = 0x7f;

  amplitude = (amplitude > amplitude * (freq + 0x28) / 128) ? amplitude : amplitude * (freq + 0x28) / 128;



  loadAmp = amplitude * loadAmp >> 7;

  roadNoiseAmp = roadNoiseAmp * amplitude >> 7;


  if (tuntrig != 0) {
    wetNoiseAmp = 0; } else {

    wetNoiseAmp = Weather_GetNumParticles(car->carIndex); }

  if (0x7f < wetNoiseAmp) {
    wetNoiseAmp = 0x7f; }


  wetNoiseFreq = 0x48 - (wetNoiseAmp >> 3);

  roadNoiseAmp = MIN(roadNoiseAmp,0x7f);

  if ((relvel != 0) || (Camera_gInfo[car->carIndex].mode == 0xb)) {

    loadAmp = (loadAmp << 0x10) / doppler; }





  freq = freq * doppler / 0x10000;

  roadNoisePatch = 0xe;

  if (cam == 0) { roadNoisePatch = 0; if (GameSetup_gData.commMode == 1) {
      roadNoisePatch = 0xe; } }



  if (roadNoiseAmp != 0) {
    AudioCmn_PlaySFX(car->carIndex == 0 ? 0x18 : 0x19, roadNoisePatch,roadNoiseFreq,doppler,roadNoiseAmp,azimuth); } else {

    freeVoiceChannel(car->carIndex == 0 ? 0x18 : 0x19); }

  if (car->carIndex == 0) {

    if ((GameSetup_gData.Weather == 1) && (wetNoiseAmp != 0)) {
      AudioCmn_PlaySFX(0x1a,0,wetNoiseFreq,doppler,wetNoiseAmp,0); } else {

      freeVoiceChannel(0x1a); } }



  if (((((car->control).gearShiftTimer != '\0') && ((u_char)(car->control).gear > (u_char)(car->control).lastGear)) && ((u_char)(car->control).lastGear != 1)) && (cobblestoneAmp != 0)) {

    loadAmp = (loadAmp + loadAmp * (u_char)(car->control).gearShiftTimer / car->specs->gearShiftDelay) >> 1;

    if ((u_char)(car->control).gearShiftTimer == 5) {
      cobblestoneAmp = cobblestoneAmp - (cobblestoneAmp >> 2); }
    else if ((u_char)(car->control).gearShiftTimer == 4) {
      cobblestoneAmp = cobblestoneAmp >> 1; }
    else if ((u_char)(car->control).gearShiftTimer == 3) {
      cobblestoneAmp = cobblestoneAmp >> 2; }
    else if ((u_char)(car->control).gearShiftTimer < 3) {
      cobblestoneAmp = 0; }

    PlayersRampedGasLevel[car->carIndex] = cobblestoneAmp; }


  {
    int gas; rpmRatio = (car->flywheelRpm << 0x10) / car->specs->redline;
    gas = 0x7f; if (car->revLimit == 0) { gas = cobblestoneAmp >> 1; }

    AudioEng_Set(car->carIndex,(gMasterEngineLevel * 0xe) * loadAmp >> 0xe,rpmRatio,gas,cam, doppler,azimuth,cardir);
  }




}

/* ---- AudioCmn_TrafficSFX__Fiiiiiiii  [@0x80079104] ---- */
/* 2026-10-27: ordinary grouped32-bit crossfade indices remove both
 * reconstruction-only long long casts,without a fade pointer or new object.
 * Let p=dir>>12,q=dir>>10: left p-(q-64),right(q+64)-p. Every intermediate
 * fits signed32 for every signed32 dir;no wider arithmetic is necessary.
 * Only this pair of16 tested real subtraction forms preserves the whole ELF.
 * Ordinary layout and implicit void fallthrough then seal all163 word/file
 * tags,both block-line records,all supplied owners,frame/header and end2239.
 * Keeping the terminal return is byte-exact but leaves the root end one line
 * late. No fake scope/use,new name,qualifier,asm or output rewrite is used.
 * Literal original expression/macro/comment spelling remains unproved.
 * Existing slot/crossfade/fence-removal receipts are preserved below.
 * Receipt:build/nc12/traffic_sfx_source_20261027/. */
/* MATCH P903: native 19311c..1932ab has only iAmpIn, player and
     pitchmult in one scope. Both engine-patch lookups are separate native
     statements (2226/2229), preceding the PlaySFX calls (2227/2230). */
/* BUG FIX (2026-07-11): real crossfade table Xfade[129], not a stale "" placeholder.
       BUG FIX (wave-13): 2nd index IS +0x40 biased -- oracle mutates s2=(dir>>12)-0x40 then
       s1-s2 = (dir>>10)-(dir>>12)+0x40 (the wave-6 note claiming "no +0x40" misread the raw;
       the two calls use the symmetric +-0x40 crossfade pair). */
/* W85-S2: an INERT zero-insn fence was deleted here -- measured PASS
       alone and jointly with the other two, on the WHOLE-TU gate (48/48). */
/* W85-S2: an INERT zero-insn fence was deleted here -- measured PASS
       alone and jointly with the other two, on the WHOLE-TU gate (48/48). */
#line 2192 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir)
{
  int iAmpIn;
  int player;
  int pitchmult;





  player = 0;

  if (GameSetup_gData.commMode == 1) { player = (iChan < 8) ^ 1; }


  if (Camera_gInfo[player].mode == 0xc) {
    iAmpIn = fixeddiv(0x10000000,dst + 0x10000) / 0x10000; } else {

    iAmpIn = fixeddiv(0x8000000,dst + 0x20000) / 0x10000; }

  if ((iAmpIn == 0) && (iChan != -1)) {

    if (gaChannel[iChan].Partial != -1) {
      freeVoiceChannel(iChan); }
    if (gaChannel[iChan + 4].Partial != -1) {
      freeVoiceChannel(iChan + 4); }
    if (gaChannel[iChan + 8].Partial != -1) {
      freeVoiceChannel(iChan + 8); }
    return; } else {


    pitchmult = fixedmult(freq + 0x3333,doppler) * 0x50 >> 10;


    player = CopSpeak_GetEnginePatch(iSFXnum,0);
    AudioCmn_PlaySFX(iChan + 4,player,0x40,pitchmult << 4, iAmpIn * Xfade[(dir >> 0xc) - ((dir >> 10) - 0x40)] >> 7,azimuth);

    player = CopSpeak_GetEnginePatch(iSFXnum,1);
    AudioCmn_PlaySFX(iChan + 8,player,0x40,pitchmult << 4, iAmpIn * Xfade[((dir >> 10) + 0x40) - (dir >> 0xc)] >> 7,azimuth);


    if (0x280000 < relvel) {
      relvel = 0x280000; }
    iAmpIn = iAmpIn * relvel / 0x280000;

    AudioCmn_PlaySFX(iChan,99,freq,doppler,iAmpIn,azimuth);
  }
}

/* ---- AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii  [@0x80079390] ---- */
/* 2026-10-27 skid source recovery: early audio-off exit preserves end2273
 * while the real last work region ends2270. Channel cleanup calls freeVoice
 * at2263 and returns at2264;implicit branch completion incorrectly keeps the
 * jump on2263. Returning the void call directly instead also misattributes
 * its call group. The actual separate cleanup/return form preserves all45
 * words,complete provided parameter copies/locals and root boundaries.
 * No new name,object,scope,asm/volatile,fake use or statement directive.
 * Literal original exit spelling remains unproved. Receipt:
 * build/nc12/audio_frequency_source_20261027/. */
#line 2243 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_TrafficSkidSFX(int sndPlayer,s_type surface1,s_type surface2,int force,int Distsq,int azimuth)
{
  int iAmpIn;







  if (AudioCmn_kAudioOn == 0) return;


    if (Distsq < 0x1324) {
      iAmpIn = ((0x1324 - Distsq) * 0x7f) / 0x1324; } else {

      iAmpIn = 0; }

    if (iAmpIn == 0 && sndPlayer != -1) {
      if (gaChannel[sndPlayer].Partial != -1) {
        freeVoiceChannel(sndPlayer);
        return; }
    } else {



      AudioCmn_SFX(sndPlayer,surface1,surface2,force,Distsq,azimuth);
    }


}

/* ---- AudioCmn_PlayerHornOn__Fiiiii  [@0x80079444] ---- */
/* 2026-10-27: HornOn's actual early audio-off return preserves the
 * real function-end2302 note while root ownership ends2301. All65 word/file
 * tags,both block lines,provided locals/owners and frame/header/end agree.
 * Other genuine exit forms can also pass,so literal original syntax is not
 * unique. No dummy statement,extra scope,void-result cast or new object.
 * Receipt for both horn functions:build/nc12/horn_source_20261027/. */
#line 2274 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_PlayerHornOn(int carIndex,int Distsq,int iFreqIn,int azimuth,int doppler)
{
  int iAmpIn;
  int sfx;
  int player;
  if (AudioCmn_kAudioOn == 0) return;


    if (Distsq < 0x1324) {
      iAmpIn = ((0x1324 - Distsq) * 0x7f) / 0x1324; } else {

      iAmpIn = 0; }



    if (GameSetup_gData.commMode == 1) {

      sfx = 10;
      if (carIndex == 0) { player = 0x29; } else { player = 0x2a; } } else {




      sfx = 3; player = 0x29; }

    if ((gaChannel[player].Partial == 0xffffffff) || (SNDover(gaChannel[player].Partial) == 0)) {
      AudioCmn_PlaySFX(player,sfx,iFreqIn,doppler,iAmpIn,azimuth);
    }
}

/* ---- AudioCmn_PlayerHornOff__Fi  [@0x80079548] ---- */
/* 2026-10-27: car-index-first player selection and the actual single-
 * player car/handle/playback exception guard remove both LAB dispatch labels.
 * Car test2316 precedes handle/SNDover2317;cleanup2320/return2321 remain real
 * statements. All47 word/file tags,provided owners,block lines and frame/end
 * agree. NFS2 corroborates the player-selection design,not NFS4's added
 * exception or int return contract. No other behavior is imported.
 * No new name,object,asm,volatile,fake use,scope padding or statement anchor.
 * Literal original expression/comment spelling remains unproved. */
#line 2304 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
int AudioCmn_PlayerHornOff(int carIndex)
{
  int player;
  if (AudioCmn_kAudioOn == 0) return 0;




  player = 0x29; if (carIndex != 0 && GameSetup_gData.commMode == 1) {
    player = 0x2a; }

  if (GameSetup_gData.commMode != 1) {
    if (Cars_gList[carIndex]->carInfo->carType == 0x14) {
      if ((gaChannel[player].Partial != 0xffffffff) && (SNDover(gaChannel[player].Partial) == 0)) return 1; } }


  freeVoiceChannel(player);
  return 0;
}

/* ---- AudioCmn_PlayFESFX__Fi  [@0x80079604] ---- */
#line 2326 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_PlayFESFX(int SFXnum)
{
  AudioCmn_PlayFESFXVol(SFXnum,0x7f);
}

/* ---- AudioCmn_PlayFESFXVol__Fii  [@0x80079624] ---- */
/* BUG FIX (2026-07-11): the previous recon declared each SNDPLAYOPTS field as its OWN
     separate stack local (local_28/local_24/local_21/local_20/local_1f/local_1d) instead of
     members of ONE struct whose address is taken. Only local_28's address escaped (passed to
     SNDplaysetdef/SNDplay); gcc proved the other locals' addresses never escape and dead-store-
     eliminated every field write except patnum -- so at runtime PlayFESFXVol played every FE
     SFX with garbage bhandle/pan/vol/bend/use3dpos (stack garbage), a real behavior bug, not
     just a byte-match near-miss (oracle sets 6 fields; ours set 1). Fixed by using the real
     struct so all field writes go through the escaped &playopts address. */
/* MATCH: keep the 120 scale as a shift of the 15-product.  This preserves
     retail's multiply tree without introducing a local absent from SYM. */
/* 2026-10-27 FE source-order/SLD recovery: the bank handle is source2350,
 * volume2351,patch2352,bend2354,3D flag2355 and pan2356. Stock scheduling
 * still emits the volume arithmetic first and the bank load after three
 * stores; machine order is not source order. The existing120-product spelling
 * needs no extra value object. All34 instructions,whole normal ELF/CPE,
 * complete supplied local tuples and two zero-length block records survive.
 * Ordinary anchored layout restores all word/file tags and end2365 without
 * statement directives,new objects/scopes/asm/volatile or output rewriting.
 * Original literal macro/comment text remains unproved. Receipt:
 * build/nc12/audio_fe_source_20261027/. */
#line 2331 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_PlayFESFXVol(int SFXnum,int vol)
{
  SNDPLAYOPTS playopts;














  SNDplaysetdef(&playopts);

  playopts.bhandle = (char)gSndBnk[0].bnkID;
  playopts.vol = (char)((gMasterSFXLevel * ((vol * 0xf) << 3)) >> 0xe);
  playopts.patnum = SFXnum;

  playopts.bend = 0x40;
  playopts.use3dpos = 0;
  playopts.pan = 0x40;

  SNDplay(&playopts);






  NumSFXOn = NumSFXOn + 1; }

/* ---- AudioCmn_PlayWrongWaySFX__Fv  [@0x800796ac] ---- */
#line 2369 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_PlayWrongWaySFX(void)
{
  AudioCmn_PlaySound(gSndBnk[3].bnkID,0x10,0,0x7f,0x40);
}

/* ---- AudioCmn_PlayPauseSound__Fi  [@0x800796e4] ---- */
#line 2374 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_PlayPauseSound(int patch)
{
  AudioCmn_gCursorSndHandle = AudioCmn_PlaySound(gSndBnk[3].bnkID,patch,0,0x7f,0x40);
}

/* ---- quickSirenOn__Fi  [@0x8007971c] ---- */
/* SOURCE-REVIEW-UNRESOLVED: patch names the real selected sample value;
 * retail retains no local row for it. Its separate selection/call SLD groups
 * do not uniquely prove the original object or spelling. Direct conditional
 * call arguments change code; that failure alone is not a necessity proof. */
#line 2411 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void quickSirenOn(int sirennum)
{
  int patch = 8; if ((sirennum & 1U) != 0) patch = 6;
  gaChannel[sirennum + 0x2b].Partial = AudioCmn_PlaySound(gSndBnk[3].bnkID,patch,0x40,0,sirenCurrentPitch[sirennum]);
}

/* ---- SuperCopSirenOn__Fi  [@0x80079790] ---- */
#line 2417 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void SuperCopSirenOn(int sirennum)
{
  gaChannel[sirennum + 0x2b].Partial = AudioCmn_PlaySound(gSndBnk[3].bnkID,9,0x40,0,sirenCurrentPitch[sirennum]);
}

/* ---- SirenOn__Fii  [@0x800797f8] ---- */
#line 2422 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void SirenOn(int sirennum,int supercop)
{
  if (bSirenOn[sirennum] == 0) {
    bSirenOn[sirennum] = 1;
    if (supercop != 0) {

      quickSirenActive[sirennum] = 1;
      sirenCount[sirennum] = -1;
      SuperCopSirenOn(sirennum);
    }
    else {

      quickSirenActive[sirennum] = 1;
      sirenCount[sirennum] = gQuickSirenCount;
      quickSirenOn(sirennum);
      gQuickSirenCount = gQuickSirenCount + 1; } } return;

}

/* ---- SirenOff__Fi  [@0x800798a0] ---- */
#line 2441 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void SirenOff(int sirennum)
{
  bSirenOn[sirennum] = 0;
  bSirenPitchingUp[sirennum] = 1;
  quickSirenActive[sirennum] = 0;
  sirenCurrentPitch[sirennum] = 0x20;
  slowSirenReps[sirennum] = 3;
  reachedSirenMin[sirennum] = 0;
  quickSirenTimeCount[sirennum] = 0;
  SNDautovol(gaChannel[sirennum + 0x2b].Partial,5,-1);
}

/* ---- UpdateSiren__Fiiiii  [@0x8007995c] ---- */
/* 2026-10-27: ordinary anchored source layout restores every129 word/file
 * tag,all supplied parameter/local owner tuples,both block-line records and
 * end2485,with every executable token unchanged. The two real volume arms
 * and final pan expression keep their existing arithmetic/branch structure;
 * no anonymous slot pointer is declared or needed. Literal original macro,
 * comment and declaration spellings are not uniquely proved by this seal.
 * No new object,scope,asm,volatile,fake use or statement #line is introduced.
 * Receipt:build/nc12/siren_layout_20261027/. */
#line 2453 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void UpdateSiren(int sirennum,int amp,int dop,int azimuth,int supercop)
{
  int iFreq;

  if (bSirenOn[sirennum] != 0) {


    if (SNDover(gaChannel[sirennum + 0x2b].Partial) != 0) {

      if (supercop != 0) {
        SuperCopSirenOn(sirennum); } else {

        quickSirenOn(sirennum); } }


    quickSirenTimeCount[sirennum] = quickSirenTimeCount[sirennum] + 1;

    iFreq = dop / 0x400;

    iFreq = (iFreq < 0) ? 0 : iFreq;
    iFreq = (0x7f < iFreq) ? 0x7f : iFreq;

    SNDpitchbend(gaChannel[sirennum + 0x2b].Partial,iFreq);

    if (sirenCount[sirennum] == -1) {
      SNDvol(gaChannel[sirennum + 0x2b].Partial,gMasterAmbientLevel * ((amp * 9) * 4 + amp) >> 0xe); } else {

      SNDvol(gaChannel[sirennum + 0x2b].Partial,gMasterAmbientLevel * ((amp * 3) * 0x10 - amp) >> 0xe); }
    if (Audio_direct3davail != 0) {
      SND3dpos(gaChannel[sirennum + 0x2b].Partial,azimuth,0); } else {
      if (gStereoMode != 0) {
        SNDpan(gaChannel[sirennum + 0x2b].Partial, (int)((azimuth - 0x4000U < 0x8000) ? 0xbfff - azimuth : (azimuth + 0x4000U & 0xffff)) >> 8); } } } return;
}
/* ---- AudioCmn_Pause__Fv  [@0x80079b60] ---- */
#line 2510 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_Pause(void)
{

  CopSpeak_SilenceCop((Car_tObj *)0, 0);

  for (int i = 0; i < 71; i++) {
    if (gaChannel[i].Partial != -1)
      SNDvol(gaChannel[i].Partial, 0);
  } AudioMus_Volume(0);
  if (fReverbOn)
    AudioCmn_ReverbOff();

  AudioEng_Pause();

  SNDstopall();

  gMasterSFXLevel   = GameSetup_gData.userSetting.sfxLevel;
  gMasterMusicLevel = GameSetup_gData.userSetting.musicLevel;
}

/* ---- AudioCmn_UnPause__Fv  [@0x80079c18] ---- */
/* Retail performs the music-level calculation directly, without a call
   or the non-SYM inline-helper parameter previously used here. */
#line 2532 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_UnPause(void)
{

  SNDmastervol(0x7f);
  AudioMus_Volume(((gMasterMusicLevel < 0x56 ? gMasterMusicLevel : ((gMasterMusicLevel - 0x55) * 7) / 2 + 0x55) * 0x46) >> 7);

  AudioEng_Resume();

  GameSetup_gData.userSetting.sfxLevel = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;
}

/* ---- AudioCmn_UnPauseAndQuit__Fv  [@0x80079ca4] ---- */
#line 2545 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_UnPauseAndQuit(void)
{
  int i;


  while (SNDover(AudioCmn_gCursorSndHandle) == 0)
    systemtask(0);

  CopSpeak_Stop();
  SNDmastervol(0);
  AudioMus_StopSong(0);
  { int i;
    for (i = 0; i < 71; i++) {

      if (gaChannel[i].Partial != -1) {

        SNDstop(gaChannel[i].Partial);
        gaChannel[i].Partial = -1;
        gaChannel[i].SFXnum  = -1;
      }
    }
  }
  GameSetup_gData.userSetting.sfxLevel   = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;

  if (fReverbOn) AudioCmn_ReverbOff();

  for (i = 0; i < 0x80; i++) SNDmastervol(i);
}

/* ---- AudioCmn_UnPauseAndRestart__Fv  [@0x80079d8c] ---- */
#line 2576 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_UnPauseAndRestart(void)
{
  int i;


  SPCH_ClearEventQueue();

  while (SNDover(AudioCmn_gCursorSndHandle) == 0)
    systemtask(0);

  CopSpeak_Cancel();
  SNDmastervol(0);
  AudioCmn_DeInitAsyncSfx();
  AudioMus_StopSong(0);
  { int i;
    for (i = 0; i < 71; i++) {

      if (gaChannel[i].Partial != -1) {

        SNDstop(gaChannel[i].Partial);
        gaChannel[i].Partial = -1;
        gaChannel[i].SFXnum  = -1;
      }
    }
  }
  for (i = 0; i < 0x80; i++) SNDmastervol(i);
  if (fReverbOn) AudioCmn_ReverbOff();

  GameSetup_gData.userSetting.sfxLevel   = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;

  AudioCmn_Init();
}

/* ---- AudioCmn_InitReverb__Fv  [@0x80079e88] ---- */
#line 2611 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_InitReverb(void)
{

  SNDfxinitbus(0x0,0x7f,10,-1,-1);
  fReverbLevel = '\0';
  SNDfxmasterlevel(0x0,0);
  fReverbOn = '\0';
}

/* ---- AudioCmn_ReverbOff__Fv  [@0x80079ecc] ---- */

#line 2629 "C:/nfs4/GAME/COMMON/AUDIOCMN.CPP"
void AudioCmn_ReverbOff(void)

{

  SNDfxmasterlevel(0,0);
  fReverbLevel = '\0';
  fReverbOn = '\0';

}

/* Definitions following their original function-local .data predecessor. */
int bSirenOn[6] = {0};                                      /* @0x8010e790 */
int bSirenPitchingUp[6] = { 1, 1, 1, 1, 1, 1 };             /* @0x8010e7a8 */
int quickSirenActive[6] = {0};                              /* @0x8010e7c0 */
int sirenPitchWidth[6] = { 32, 40, 28, 42, 28, 42 };        /* @0x8010e7d8 */
int sirenCurrentPitch[6] = { 32, 32, 32, 32, 32, 32 };      /* @0x8010e7f0 */
int slowSirenReps[6] = { 3, 3, 3, 3, 3, 3 };               /* @0x8010e808 */
int sirenCount[6] = {0};                                   /* @0x8010e820 */
int reachedSirenMin[6] = {0};                              /* @0x8010e838 */
int quickSirenTimeCount[6] = {0};                          /* @0x8010e850 */
AudioCmn_tReTrig AudioCmn_gReTrig[2] = {0};                 /* @0x8010e868 */
SndBnk_t gSndBnk[7] = {0};                                 /* @0x8010e8a8 */
Channels_t gaChannel[71] = {0};                             /* @0x8010e8fc */
AudioCmn_tAsyncSfxSlot AudioCmn_gSfxSlot[32] = {0};         /* @0x8010eb34 */
char carbankname[12] = {0};                                /* @0x8010ee34 */

/* Definitions following both function-local .sdata records.  The explicit
 * section attributes preserve their retail small-data ownership; this TU is
 * compiled in its retail -G8 lane. */
int falseLapTrigCur = 0;                                    /* @0x8013c6b4 */
int flaseLapTrigTrack = 0;                                  /* @0x8013c6b8 */
char currentLap[2] = {0, 0};                                /* @0x8013c6bc */
int bestLapTime[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6c0 */
int gtotallaptimes[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6c8 */
int AudioCmn_gPlayerArrested[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6d0 */
int AudioCmn_gCursorSndHandle = 0;                          /* @0x8013c6d8 */
int AudioCmn_gLastFade = 0;                                 /* @0x8013c6dc */
void *AudioCmn_gLoadTables = 0;                             /* @0x8013c6e0 */
void *AudioCmn_gCruiseTables = 0;                           /* @0x8013c6e4 */
int AudioCmn_gResume = 0;                                   /* @0x8013c6e8 */
int AudioCmn_gStreamRestartTimer = 0;                       /* @0x8013c6ec */
char fMysticWindON[2] = {0, 0};                             /* @0x8013c6f0 */
char fAmbientRangeON[2] = {0, 0};                           /* @0x8013c6f4 */
int currentWindVal[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6f8 */
int nextWindVal[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c700 */
int currentWindPan = 0;                                     /* @0x8013c708 */
int nextWindPan = 0;                                        /* @0x8013c70c */
int gQuickSirenCount = 0;                                   /* @0x8013c710 */
int AudioCmn_ThunderAmp = 0;                                /* @0x8013c714 */
int AudioCmn_ThunderAzi = 0;                                /* @0x8013c718 */
int AudioCmn_ThunderDel = 0;                                /* @0x8013c71c */
