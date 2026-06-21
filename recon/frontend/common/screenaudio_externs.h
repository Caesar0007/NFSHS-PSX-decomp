/* frontend/screens/screenaudio_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENAUDIO_EXTERNS_H_
#define _FE_SCREENS_SCREENAUDIO_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern tfrontEnd   frontEnd;
extern int  ticks;
extern tGlobalMenuDefs *menuDefs;
/* (gFE_bgIndex/gFE_bgFadeVal are NOT globals: SYM STAT = DrawBackground-local statics
   lastpercentage/perfade @0x800528e0/e4 -- Ghidra mis-named them. Defined in the .cpp.) */
extern int  gMasterSFXLevel, gMasterMusicLevel, gMasterEngineLevel, gMasterAmbientLevel;
extern int  gMasterFENarrationLevel, gStereoMode, Audio_direct3davail;
extern SndBnk_t gSndBnk[7];
extern SPEECHINFO ginfo;
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
int  textpixels(char *str);
void SetMenu(tMenuItemSlidingMenu *thisobj, short i, void *menu);   /* sliding-menu method; menu is tMenu-derived */
void *TransitionIsFinished(tOptionsMenu *thisobj);   /* method on the options menu */
int CalcFadeVal(int col1, int amount);            /* 2-arg overload */
int CalcFadeVal(int col1, int col2, int f1, int f2);  /* 4-arg overload */

/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */
short FeAudio_AsyncPlaySpeech(int type, int index);
void FETextRender_MenuTextPositionedJustify(short index, short x, short y, short justify, tMenuTextState state, tMenuTextType type);
char * TextSys_Word(int wordnum);
void FeAudio_systemtask(int x);
int TextSys_WordY(int wordnum);
int Percentage(tMenuItemLeftRightAudioSlider * thisobj);
int AudioMus_PlaySong(char * pattern);
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);
int AudioCmn_PlaySound(int bhandle, int patchNum, int azimuth, int vol, int bend);
void AudioMus_Volume(int volume);
void AudioMus_StopSong(int fadeticks);
void PSXDrawSquare(int col, int x, int y, int w, int h);
AudioMus_tSongList * AudioMus_GetSongList(char * pattern, int memtype);
int TextSys_WordX(int wordnum);
int CalcFadeVal(int col1, int col2, int amount);
void FETextRender_FullTextRGB(char * sMenuText, short x, short y, int col, char size, short justify);

#endif