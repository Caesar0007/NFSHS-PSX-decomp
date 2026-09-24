/* game/psx/audio.cpp -- RECONSTRUCTED (NFS4 PSX sound driver init + bank load; C++ TU)
 *   6 fns: Audio_InitDriver/DeInitDriver/CleanUp/FECleanUp, AudioCmn_AddBank/LoadBank.
 *   GTE-free. Full SYM-locals applied.
 */
#include "audio_types.h"
#include "audio_externs.h"

/* Retail audio.obj begins its read-only data with this unreferenced class
 * tag, as do the other TUs that included the SimpleMem class header. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
/* both precede the TU's literals in retail .sdata (0x8013d4fc/0x8013d500 before "amus"
 * @0x8013d504), so they are initialized (emitted at definition), not deferred. */
int Audio_direct3davail = 0;
void *Audio_gHeap = 0;
/* retail audio.obj also owns the music stream handle (deferred .sdata @0x8013d51c, after the
 * TU's -G8 literals "amus" "game*" ".bnk") and the backwards-track start trigger table
 * (.data @0x8011e7f0, values from the image). */
int gMusicHandle;
int backwardsTrackStartTrigger[5] = { 4, 4, 7, 6, 4 };

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Audio_InitDriver(int buffersize,int spusize);
void Audio_DeInitDriver(void);
void Audio_CleanUp(void);
void Audio_FECleanUp(void);
int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum);
int AudioCmn_LoadBank(char *filename,int BankNum);


/* ---- Audio_InitDriver__Fii  [AUDIO.CPP:58-78] SLD-VERIFIED ---- */
void Audio_InitDriver(int buffersize,int spusize)

{
  for (int i = 0; i < 7; i++) {

    gSndBnk[i].bnkID = i;
    gSndBnk[i].pdata = 0;
  }
  if ((AudioCmn_kAudioOn != 0) || (AudioCmn_kAudioStreamingOn != 0))
  {
    SNDSYSOPTS opts;   /* retail SYM: declared in this block (one scope below the for-declaration) */
    SNDSYS_getopts(&opts);
    opts.set.maxbanks = 0x30;
    SNDSYS_setopts(&opts);
    SNDSYS_vectortoreal();
    Audio_gHeap = reservememadr("audio heap",0x1000,0);
    SNDSYS_init(Audio_gHeap,0x1000);
    AudioCmn_InitReverb();
  }
  if (0 < buffersize) {
    AudioMus_SysStartUp(buffersize,spusize,"amus");
  }
  Audio_direct3davail = 0; return;

}

/* ---- Audio_DeInitDriver__Fv  [AUDIO.CPP:84-91] SLD-VERIFIED ---- */
void Audio_DeInitDriver(void)

{
  const int audioOff = 0; AudioMus_SysCleanUp();

  if ((AudioCmn_kAudioOn != audioOff) || (AudioCmn_kAudioStreamingOn != audioOff)) {

    SNDSYS_restore();
    void *const heap = Audio_gHeap; purgememadr(heap);

  }
  return;
}

/* ---- Audio_CleanUp__Fv  [AUDIO.CPP:133-144] SLD-VERIFIED ---- */
/* The unreferenced "game*" string belongs to audio.obj's data. A constant
 * false call retains the literal; the compiler removes the call. The native
 * source expression that emitted this otherwise unreferenced tag is unknown. */
void Audio_CleanUp(void)

{
  int i;


  i = 0; do {

    if (gSndBnk[i].pdata != 0) {

      purgememadr(gSndBnk[i].pdata);
      gSndBnk[i].pdata = 0;
    }
    i = i + 1; } while (i < 7); if (0) AudioMus_SysStartUp(0, 0, "game*");
}

/* ---- Audio_FECleanUp__Fv  [AUDIO.CPP:151-158] SLD-VERIFIED ---- */
void Audio_FECleanUp(void)

{

  SNDbankremove(-1);

  if (gSndBnk[0].pdata != 0) {

    purgememadr(gSndBnk[0].pdata);
    gSndBnk[0].pdata = 0; }
}

/* ---- AudioCmn_AddBank__FPciT0i  [AUDIO.CPP:167-213] SYM locals verified; later SLD open ---- */
/* Retail SYM: p is the filename walk ($v1), ptemp the allocated buffer ($s1).
   filename itself advances to the basename after a separator. */
int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum)

{
  int bhandle = -1;
  int check; char *p, *ptemp;
  p = filename;
  ptemp = (char *)0x0;

  while (*p != '\0') {

    if (*p == '\\')
      filename = p + 1;
    p = p + 1;
  }
  check = SNDbankadd(&bhandle,pdata);
  if (check == 7) {
    check = SNDbankheadersize(bhandle);
    ptemp = reservememadr(filename,check,0);
    SNDbankheadercopy(ptemp,bhandle);
    check = SNDbankheadersize(bhandle);
    size = size - check;
  }
  else {
    AudioClc_SndError(check);
  }
  purgememadr(pdata);
  gSndBnk[BankNum].pdata = ptemp;
  gSndBnk[BankNum].bnkID = bhandle;
  return size;
}

/* ---- AudioCmn_LoadBank__FPci  [AUDIO.CPP:217-230] SLD-VERIFIED ----
 * PASS 33/33; SYM names only bankdata(AUTO -0x60) and pdata($s0).
 * The direct filesize() argument is also the independent m2c shape; keeping
 * its return in a named iVar1 produced an extra non-retail debug local. */
int AudioCmn_LoadBank(char *filename,int BankNum)

{
  char bankdata [80];
  char *pdata;

  strcpy(bankdata,filename);
  strcat(bankdata,".bnk");
  pdata = (char *)loadfileadrz(bankdata,(void *)0x10);

  if (pdata == (char *)0x0) {


    return 0;
  }
  return AudioCmn_AddBank(filename,filesize(bankdata),pdata,BankNum);
}

/* end of audio.cpp */
