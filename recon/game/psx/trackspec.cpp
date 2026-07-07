/* game/psx/trackspec.cpp -- RECONSTRUCTED (NFS4 PSX track-spec load; C++ TU)
 *   5 fns: TrackSpec_SetDefault (fill a CTrackSpec with defaults), SetUp (push night/weather
 *   to GameSetup), static read (byte-copy from a buffer cursor), Read (load TrXX.bin + parse),
 *   Load (weather/night -> spec index -> Read).
 */
#include "../../nfs4_types.h"
#include "trackspec_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int TrackSpec_gCurrentSpec;
int TrackSpec_gMaxSpec;
int TrackSpec_gPrevSpec;


/* ---- TrackSpec_SetDefault__FP10CTrackSpec  [TRACKSPEC.CPP:44-113] SLD-VERIFIED ---- */
void TrackSpec_SetDefault(CTrackSpec *spec)

{
  bool bVar1;
  short sVar2;
  int iVar3;
  int j;
  CTrackSpec *local_a0__1;
  CTrackSpec *pCVar5;
  int i;
  int iVar7;
  
  i = 0;
  spec->fogstate = 0;
  sVar2 = (short)GameSetup_gData.Weather;
  spec->horizonstate = 1;
  spec->skystate = 1;
  spec->weatherstate = sVar2;
  sVar2 = (short)GameSetup_gData.Time;
  (spec->fogspec).contrast = 0x10000;
  spec->depthcuestate = 1;
  (spec->fogspec).start = 200;
  (spec->fogspec).dist2base = 8;
  (spec->weatherspec).intensity_limit = 2;
  (spec->horizonspec).mirror = 1;
  (spec->horizonspec).yoffset = -0x1080;
  (spec->fogspec).color.r = 0x80;
  (spec->fogspec).color.g = 0x80;
  (spec->fogspec).color.b = 0x80;
  (spec->weatherspec).type = 0;
  (spec->horizonspec).angle = 0;
  (spec->horizonspec).height = 0x4b00;
  (spec->horizonspec).frontColor[0].r = 0x80;
  (spec->horizonspec).frontColor[0].g = 0x80;
  (spec->horizonspec).frontColor[0].b = 0x80;
  (spec->horizonspec).frontColor[1].r = 0x80;
  (spec->horizonspec).frontColor[1].g = 0x80;
  (spec->horizonspec).frontColor[1].b = 0x80;
  (spec->horizonspec).backColor[0].r = 0x80;
  (spec->horizonspec).backColor[0].g = 0x80;
  (spec->horizonspec).backColor[0].b = 0x80;
  (spec->horizonspec).backColor[1].r = 0x80;
  (spec->horizonspec).backColor[1].g = 0x80;
  (spec->horizonspec).backColor[1].b = 0x80;
  spec->nightstate = sVar2;
  bVar1 = true;
  do {
    if (bVar1) {
      (spec->horizonspec).ringPMX[i] = (char)i;
    }
    else {
      (spec->horizonspec).ringPMX[i] = '\x17' - (char)i;
    }
    i = i + 1;
    bVar1 = i < 8;
  } while (i < 0x10);
  i = 0;
  iVar7 = 0;
  (spec->skyspec).type = 0;
  (spec->skyspec).flags = 4;
  pCVar5 = spec;
  do {
    j = 0;
    (pCVar5->skyspec).frontcolors[0].r = '2';
    (pCVar5->skyspec).frontcolors[0].g = '2';
    (pCVar5->skyspec).frontcolors[0].b = 'F';
    (pCVar5->skyspec).backcolors[0].r = '2';
    (pCVar5->skyspec).backcolors[0].g = '2';
    (pCVar5->skyspec).backcolors[0].b = 'F';
    iVar3 = iVar7;
    do {
      (spec->skyspec).cloudIndices[0][iVar3] = '\0';
      j = j + 1;
      iVar3 = j + iVar7;
    } while (j < 4);
    (pCVar5->skyspec).ringAngles[0] = i << 0xc;
    pCVar5 = (CTrackSpec *)&pCVar5->horizonstate;
    i = i + 1;
    iVar7 = iVar7 + 4;
  } while (i < 5);
  (spec->skyspec).sunAngleInSky = -0x1848;
  (spec->skyspec).sunHeightInSky = 0xee;
  (spec->skyspec).moonHeightInSky = 0xee;
  (spec->skyspec).numStars = 0x3c;
  (spec->skyspec).starAngleLow = 4000;
  (spec->skyspec).starAngleHigh = 10000;
  (spec->skyspec).starBrightMin = 0x40;
  (spec->skyspec).starBrightMax = 200;
  (spec->skyspec).starBaseColor.r = 0xff;
  (spec->skyspec).starBaseColor.g = 0xff;
  (spec->skyspec).starBaseColor.b = 0xff;
  (spec->skyspec).starRandomSeed = 0x3039;
  (spec->skyspec).sunBeamColor.r = '!';
  (spec->skyspec).sunBeamColor.g = '!';
  (spec->skyspec).sunHaloColor.r = '\x19';
  (spec->skyspec).clearcolor.g = '\x10';
  (spec->skyspec).sunBeamColor.b = '\x10';
  (spec->nightspec).nightcolor.g = '\x10';
  (spec->nightspec).nightcolor.b = '\x10';
  (spec->skyspec).sunHaloColor.g = '\n';
  (spec->depthcuespec).distance = 0x44;
  (spec->skyspec).clearcolor.r = '\b';
  (spec->skyspec).clearcolor.b = '\b';
  (spec->skyspec).moonAngleInSky = 0;
  (spec->skyspec).sunHaloColor.b = '\0';
  (spec->skyspec).yoffset = 0;
  (spec->nightspec).nightcolor.r = '\b';
  (spec->depthcuespec).color.r = 0x80;
  (spec->depthcuespec).color.g = 0x80;
  (spec->depthcuespec).color.b = 0x80;
  (spec->worldcolorspec).worldR = 0;
  (spec->worldcolorspec).worldG = 0;
  (spec->worldcolorspec).worldB = 0;
  (spec->worldcolorspec).type = 0;
  (spec->worldcolorspec).contrast = 0x4ccc;
  (spec->worldcolorspec).contrast_color.r = 0x80;
  (spec->worldcolorspec).contrast_color.g = 0x80;
  (spec->worldcolorspec).contrast_color.b = 0x80;
  return;
}

/* ---- TrackSpec_SetUp__Fv  [TRACKSPEC.CPP:119-121] SLD-VERIFIED ---- */
void TrackSpec_SetUp(void)

{
  GameSetup_gData.Time = (int)TrackSpec_gSpec.nightstate;
  GameSetup_gData.Weather = (int)TrackSpec_gSpec.weatherstate;
  return;
}

/* ---- read__FPPcPvi  [TRACKSPEC.CPP:127-139] SLD-VERIFIED ---- */
void read(char **handle,void *buf,int bytes)

{
  char *source;
  int new_var;
  int i;
  char c;

  source = *handle;
  i = 0;
  new_var = 0;
  if (new_var < bytes) {
    do {
      c = *source;
      source = source + 1;
      i = i + 1;
      *(char *)buf = c;
      buf = (char *)buf + 1;
    } while (i < bytes);
  }
  *handle = source;
  return;
}

/* ---- TrackSpec_Read__Fi  [TRACKSPEC.CPP:145-200] SLD-VERIFIED ---- */
void TrackSpec_Read(int spec_num)

{
  char *startpos;
  char str [64];
  CTrackSpecHeader header;
  char *currentpos;
  
  sprintf(str,"%sTr%02d.bin",Paths_Paths[6],GameSetup_gData.track);
  startpos = (char *)loadfileadr(str,0);
  if (startpos != (char *)0x0) {
    TrackSpec_gPrevSpec = spec_num;
    TrackSpec_gCurrentSpec = spec_num;
    currentpos = startpos;
    read(&currentpos,&header,8);
    if (spec_num < header.num_spec) {
      TrackSpec_gMaxSpec = header.num_spec + 1;
      currentpos = currentpos + spec_num * 0x108;
      read(&currentpos,&TrackSpec_gSpec,0x108);
      TrackSpec_SetUp();
    }
    else {
      TrackSpec_SetDefault(&TrackSpec_gSpec);
    }
    purgememadr(startpos);
  }
  return;
}

/* ---- TrackSpec_Load__Fii  [TRACKSPEC.CPP:205-207] SLD-VERIFIED ---- */
void TrackSpec_Load(int weather,int night)

{
  int spec [4];
  
  spec[0] = 0x00000000U /* @0x80056ad4 */;
  spec[1] = 0x00000001U /* @0x80056ad8 */;
  spec[2] = 0x00000002U /* @0x80056adc */;
  spec[3] = 0x00000003U /* @0x80056ae0 */;
  TrackSpec_Read(spec[weather * 2 + night]);
  return;
}

/* end of trackspec.cpp */
