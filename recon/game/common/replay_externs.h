#include "../../lib/libfns.h"
/* replay_externs.h -- extern decls for game/psx/replay.cpp
 *   (NFS4 PSX replay record/playback: per-frame controller capture + RLE-style compress into a
 *    ring buffer, decompress on playback, camera-file load and replay-camera selection). */
#ifndef REPLAY_EXTERNS_H
#define REPLAY_EXTERNS_H

/* ---- replay state globals ---- */
extern tReplayBuffer      Replay_ReplayBuffer;       /* 0x8011716c (27180B; .buffer[24576] @0xA2C) */
extern tReplayInterface   Replay_ReplayInterface;    /* 0x8011702c */
extern tReplayCameraModes Replay_ReplayCamera[2];    /* 0x8011704c */
extern tControllerData    controlData[];             /* 0x8011706c (256B) */
extern int                Replay_ReplayCounter[2];   /* 0x8013d400 */
extern int                Replay_ReplayMode;         /* 0x8013d3f4 */
extern int                Replay_ReplayStorePtr;     /* 0x8013d3f8 */
extern int                Replay_ReplayGetPtr;       /* 0x8013d3fc */
extern int                Replay_Size;               /* 0x8013d3ec */
extern int                ReplayCameraList[];        /* 0x80117008 (int[9]) */
extern int                numValidCams;              /* 0x8013d3f0 */
extern char               compressed_data[33];       /* 0x8011db98 */
extern char               uncompressed_data[32];     /* 0x8011dbbc */

/* ---- camera + slices ---- */
extern Camera_tCamSlot    gReplayCameraSlots[];      /* 0x8011dbdc (1024B) */
extern camera_info        Camera_gInfo[];            /* 0x8010f2ac (544B) */
extern int                gNumSlices;                /* 0x8013c7c8 */

/* ---- sim / cars / input / setup ---- */
extern Sim_tSimGlobalVar  simGlobal;                 /* 0x8011e0ac */
extern Sim_tSimSystemVar  simVar;                    /* 0x8011e0c4 */
extern Car_tObj          *Cars_gHumanRaceCarList[2];
extern int                Cars_gNumHumanRaceCars;
extern Input_tResults     Input_gSim;                /* per-frame fetched controller state */
extern int                StatsTimer[2];
extern GameSetup_tData    GameSetup_gData;
extern char              *Paths_Paths[];             /* 0x80116468 */

/* ---- functions ---- */
extern void  Input_Fetch(int car);
extern int   Input_Interface(unsigned long button, int player);
extern void  Camera_Update(void);
extern void  Camera_SetMode(int player, int mode);
extern void  Camera_ReplayUpdate(int player, Camera_tCamSlot *slot);
extern void  AudioCmn_PlayPauseSound(int which);

#endif
