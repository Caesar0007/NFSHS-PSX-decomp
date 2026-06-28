/* nfs4_types.h — reconstructed from NFS4.SYM (whole-binary)
 * 497 structs, 3 unions, 59 enums.
 * Topologically sorted; pointer cycles via forward decls.
 */

#ifndef _NFS4_TYPES_H_
#define _NFS4_TYPES_H_

/* ---- PsyQ 4.3 ccpsx (gcc 2.7): use the REAL PsyQ headers for the standard
 *  libgte/libgpu types + scalar aliases. Our self-contained equivalents are gated
 *  out (NFS4_PSYQ_HEADERS) here but kept for the modern-gcc self-containment pre-gate
 *  (x86 host has no PsyQ SDK). Our layouts are field-identical to PsyQ 4.3 (verified). ---- */
#if defined(__GNUC__) && __GNUC__ < 3
#  include <sys/types.h>
#  include <libgte.h>
#  include <libgpu.h>
#  define NFS4_PSYQ_HEADERS 1
#endif

/* PsyQ scalar aliases */
#ifndef NFS4_PSYQ_HEADERS
typedef unsigned long  u_long;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef unsigned short u_short;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef unsigned char  u_char;
#endif
/* NFS4 boolean: cfront emitted these as 'type NULL' = implicit int. 4-byte storage,
   semantically boolean (f.., is.., got.., b.. flags). 76 struct members use this. */
typedef int BOOL;
#ifndef NFS4_PSYQ_HEADERS
typedef unsigned int size_t;
#endif
/* Ghidra-ism scalar aliases (used in some recovered eaclib param hints) */
typedef unsigned char byte;
typedef unsigned int uint;   /* PsyQ <sys/types.h> guards `uint` behind #ifndef __psx__ => NOT defined on PSX, keep ours */
#ifndef NFS4_PSYQ_HEADERS    /* `ushort` (sysIII) IS defined unconditionally by PsyQ <sys/types.h> => gate ours off under ccpsx */
typedef unsigned short ushort;
#endif
typedef unsigned char uchar;
typedef unsigned char undefined;

/* ---- forward declarations (pointer cycles) ---- */
#ifndef NFS4_PSYQ_HEADERS
typedef struct MATRIX MATRIX;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct VECTOR VECTOR;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct SVECTOR SVECTOR;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct CVECTOR CVECTOR;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DVECTOR DVECTOR;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct RVECTOR RVECTOR;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct CRVECTOR3 CRVECTOR3;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct CRVECTOR4 CRVECTOR4;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct RECT RECT;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_ENV DR_ENV;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DRAWENV DRAWENV;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DISPENV DISPENV;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_MODE DR_MODE;
#endif
typedef struct shapetbl shapetbl;
typedef struct coorddef coorddef;
typedef struct matrixtdef matrixtdef;
typedef struct cdstreamstruct cdstreamstruct;
typedef struct linedef linedef;
typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;
typedef struct PCOORD16 PCOORD16;
typedef struct COORD16 COORD16;
typedef struct CCOORD16 CCOORD16;
typedef struct PAD_PSX PAD_PSX;
typedef struct PAD_NEGCON PAD_NEGCON;
typedef struct PAD_ANALOG PAD_ANALOG;
typedef struct PAD_MOUSE PAD_MOUSE;
typedef struct PAD_COMMON PAD_COMMON;
typedef struct tActiveTime tActiveTime;
typedef struct Draw_tPixMap Draw_tPixMap;
typedef struct DRender_tCalcView DRender_tCalcView;
typedef struct Draw_SVertex Draw_SVertex;
typedef struct Draw_PrimStruct Draw_PrimStruct;
typedef struct Draw_tCacheHeader Draw_tCacheHeader;
typedef struct Draw_CarVertex Draw_CarVertex;
typedef struct Group Group;
typedef struct Trk_ObjectDef Trk_ObjectDef;
typedef struct Trk_CollideBoomInst Trk_CollideBoomInst;
typedef struct Trk_AnimateInst Trk_AnimateInst;
typedef struct Trk_Quad Trk_Quad;
typedef struct Trk_NewStrip Trk_NewStrip;
typedef struct Trk_NewSimQuad Trk_NewSimQuad;
typedef struct Trk_NewSimSlice Trk_NewSimSlice;
typedef struct Trk_SimObject Trk_SimObject;
typedef struct RelCoord16 RelCoord16;
typedef struct tSaveSurface tSaveSurface;
typedef struct BWorldSm_Pos BWorldSm_Pos;
typedef struct BO_tNewtonCollisionInfo BO_tNewtonCollisionInfo;
typedef struct BO_tNewtonObj BO_tNewtonObj;
typedef struct GameSetup_tCarData GameSetup_tCarData;
typedef struct GameSetup_tUserSetting GameSetup_tUserSetting;
typedef struct GameSetup_tPerpData GameSetup_tPerpData;
typedef struct GameSetup_tControllerData GameSetup_tControllerData;
typedef struct Sched_tFunctionSchedule Sched_tFunctionSchedule;
typedef struct Sched_tSchedule Sched_tSchedule;
typedef struct Transformer_zUV Transformer_zUV;
typedef struct Transformer_zFacet Transformer_zFacet;
typedef struct Transformer_zObj Transformer_zObj;
typedef struct Transformer_zOverlay Transformer_zOverlay;
typedef struct AIPerson_t AIPerson_t;
typedef struct AIScript_tReactionDetails AIScript_tReactionDetails;
typedef struct AIScript_t AIScript_t;
typedef struct AISpeechInfo_t AISpeechInfo_t;
typedef struct Car_tStats Car_tStats;
typedef struct Car_tControl Car_tControl;
typedef struct Car_tWheel Car_tWheel;
typedef struct Car_tSpecs Car_tSpecs;
typedef struct Cars_tCollisionInfo Cars_tCollisionInfo;
typedef struct Cars_tAudio Cars_tAudio;
typedef struct Cars_tRenderInfo Cars_tRenderInfo;
typedef struct Car_tObj Car_tObj;
typedef struct AIDataRecord_AccTable_t AIDataRecord_AccTable_t;
typedef struct AIDataRecord_CurveSpeedTable_t AIDataRecord_CurveSpeedTable_t;
typedef struct AIPhysic_BrakeInfo AIPhysic_BrakeInfo;
typedef struct AI_tInfo AI_tInfo;
typedef struct AIPhysic_ModelConfig_t AIPhysic_ModelConfig_t;
typedef struct AIDataRecord_t AIDataRecord_t;
typedef struct AIDataRecord_BestLine_t AIDataRecord_BestLine_t;
typedef struct BW_tContext BW_tContext;
typedef struct AnimScript AnimScript;
typedef struct SceneElem SceneElem;
typedef struct SceneSortedElem SceneSortedElem;
typedef struct AnimDef AnimDef;
typedef struct ObjectAnim ObjectAnim;
typedef struct ObjectFinishedMultiAnim ObjectFinishedMultiAnim;
typedef struct ObjectFinishedSignAnim ObjectFinishedSignAnim;
typedef struct AIDelayCar AIDelayCar;
typedef struct copLevel_t copLevel_t;
typedef struct copGame_t copGame_t;
typedef struct AICop_BasicPerpInfo AICop_BasicPerpInfo;
typedef struct AICop_PerpChaseInfo AICop_PerpChaseInfo;
typedef struct trigger_anyTrigger_t trigger_anyTrigger_t;
typedef struct trigger_simple_t trigger_simple_t;
typedef struct trigger_roadblock_t trigger_roadblock_t;
typedef struct trigger_offroad_t trigger_offroad_t;
typedef struct trigger_trafficAccident_t trigger_trafficAccident_t;
typedef struct trigger_pathPosition_t trigger_pathPosition_t;
typedef struct trigger_trafficPath_t trigger_trafficPath_t;
typedef struct AIState_Base AIState_Base;
typedef struct AIState_None AIState_None;
typedef struct AIState_Normal AIState_Normal;
typedef struct AIState_NonActive AIState_NonActive;
typedef struct AIHigh_Base AIHigh_Base;
typedef struct AIHigh_None AIHigh_None;
typedef struct tCopCarPair tCopCarPair;
typedef struct AIHigh_BasicPerp AIHigh_BasicPerp;
typedef struct AIHigh_Player AIHigh_Player;
typedef struct AIHigh_BTC_Perp AIHigh_BTC_Perp;
typedef struct AIHigh_BTC_HumanCop AIHigh_BTC_HumanCop;
typedef struct blockade_t blockade_t;
typedef struct AIHigh_BasicCop AIHigh_BasicCop;
typedef struct AIHigh_BTC_Cop AIHigh_BTC_Cop;
typedef struct AIHigh_Cop AIHigh_Cop;
typedef struct SPCHNFSType_POSITION SPCHNFSType_POSITION;
typedef struct SPCHNFSType_DISTANCE SPCHNFSType_DISTANCE;
typedef struct SPCHNFSType_COLOUR SPCHNFSType_COLOUR;
typedef struct SPCHNFSType_ACCIDENT SPCHNFSType_ACCIDENT;
typedef struct SPCHNFSType_AMBULANCE SPCHNFSType_AMBULANCE;
typedef struct SPCHNFSType_PURS_UPDT SPCHNFSType_PURS_UPDT;
typedef struct SPCHNFSType_ARREST SPCHNFSType_ARREST;
typedef struct SPCHNFSType_vs_RDBLK_SSTRP SPCHNFSType_vs_RDBLK_SSTRP;
typedef struct SPCHNFSType_PERP_NAME SPCHNFSType_PERP_NAME;
typedef struct SPCHNFSType_CONFIRM SPCHNFSType_CONFIRM;
typedef struct SPCHNFSType_SPIKE_BELT_SIDE SPCHNFSType_SPIKE_BELT_SIDE;
typedef struct SPCHNFSType_REVINTRO SPCHNFSType_REVINTRO;
typedef struct CarBank CarBank;
typedef struct LocationBank LocationBank;
typedef struct CallSignBank CallSignBank;
typedef struct tCarBankPair tCarBankPair;
typedef struct tLocationBankPair tLocationBankPair;
typedef struct tCallSignBankPair tCallSignBankPair;
typedef struct Speaker Speaker;
typedef struct Trk_SFX Trk_SFX;
typedef struct FLARE_PIECE_DEF FLARE_PIECE_DEF;
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_GT4 POLY_GT4;
#endif
typedef struct Draw_SubdivStruct Draw_SubdivStruct;
typedef struct Track_tArtresource Track_tArtresource;
typedef struct Track_tMaterial Track_tMaterial;
typedef struct AIState_Chase AIState_Chase;
typedef struct AIState_GotoSlice AIState_GotoSlice;
typedef struct AIHigh_BTC_Wingman AIHigh_BTC_Wingman;
typedef struct AIHigh_Traffic AIHigh_Traffic;
typedef struct TCB TCB;
typedef struct EXEC EXEC;
typedef struct DIRENTRY DIRENTRY;
typedef struct Skidmark_Segment Skidmark_Segment;
typedef struct Skidmark_Chunk Skidmark_Chunk;
typedef struct AIHigh_BTC_HumanPerp AIHigh_BTC_HumanPerp;
typedef struct AIHigh_BTC_AIPerp AIHigh_BTC_AIPerp;
typedef struct AITrigger_TriggerManager AITrigger_TriggerManager;
typedef struct AIHigh_Human AIHigh_Human;
typedef struct AIHigh_Opponent AIHigh_Opponent;
typedef struct tCopMurderThresholds tCopMurderThresholds;
typedef struct AIState_Idle AIState_Idle;
typedef struct AICop_spikeBelt_t AICop_spikeBelt_t;
typedef struct Udff_tInfo Udff_tInfo;
typedef struct AIPhysic_Config_t AIPhysic_Config_t;
typedef struct kernpair kernpair;
typedef struct AIDataRecord_TrackCurve_t AIDataRecord_TrackCurve_t;
typedef struct AIDataRecord_CarTracking_t AIDataRecord_CarTracking_t;
typedef struct AISpeeds_tLeaderBoard AISpeeds_tLeaderBoard;
typedef struct AISpeeds_Upgrade_t AISpeeds_Upgrade_t;
typedef struct AISpeeds_tSlotInfo AISpeeds_tSlotInfo;
typedef struct speedData_t speedData_t;
typedef struct AIState_Offroad AIState_Offroad;
typedef struct AIState_Purgatory AIState_Purgatory;
typedef struct AIState_RovingTraffic AIState_RovingTraffic;
typedef struct AIState_Donuts AIState_Donuts;
typedef struct AIState_Cruise AIState_Cruise;
typedef struct accelscale_t accelscale_t;
typedef struct copTuning_t copTuning_t;
typedef struct AITune_tTrackInfo AITune_tTrackInfo;
typedef struct AITune_BTC_t AITune_BTC_t;
typedef struct tQuat tQuat;
typedef struct Trk_AnimateBoomInst Trk_AnimateBoomInst;
typedef struct Anim_tFrame Anim_tFrame;
typedef struct SNDSYSCAP SNDSYSCAP;
typedef struct SNDSYSSET SNDSYSSET;
typedef struct SNDSYSVEC SNDSYSVEC;
typedef struct SNDSAMPLEFORMAT SNDSAMPLEFORMAT;
typedef struct AudioClc_tSource AudioClc_tSource;
typedef struct AudioClc_tPlayer AudioClc_tPlayer;
typedef struct AudioClc_tCLCache AudioClc_tCLCache;
typedef struct SNDPLAYOPTS SNDPLAYOPTS;
typedef struct SndBnk_t SndBnk_t;
typedef struct Channels_t Channels_t;
typedef struct AudioMus_tSongEntry AudioMus_tSongEntry;
typedef struct tTexture_ShapeInfo tTexture_ShapeInfo;
typedef struct tMenu tMenu;
typedef struct tListIterator tListIterator;
typedef struct tListIteratorRange tListIteratorRange;
typedef struct tMenuItem tMenuItem;
typedef struct tMenuItemInteractive tMenuItemInteractive;
typedef struct tCarInfo tCarInfo;
typedef struct tOwnedCarInfo tOwnedCarInfo;
typedef struct tCarManager tCarManager;
typedef struct tfrontEnd tfrontEnd;
typedef struct CopSpeak_tRequest CopSpeak_tRequest;
typedef struct AudioCmn_tReTrig AudioCmn_tReTrig;
typedef struct AudioCmn_tAsyncSfxSlot AudioCmn_tAsyncSfxSlot;
typedef struct AudioMus_tCurrentSong AudioMus_tCurrentSong;
typedef struct AudioMus_tSongList AudioMus_tSongList;
typedef struct SNDREQUESTSTATUS SNDREQUESTSTATUS;
typedef struct SNDSTREAMSTATUS SNDSTREAMSTATUS;
typedef struct SNDLIMITS SNDLIMITS;
typedef struct CdlLOC CdlLOC;
typedef struct AudioMus_tMusicGlobals AudioMus_tMusicGlobals;
typedef struct CAudioList CAudioList;
typedef struct AudioEng_tEvent AudioEng_tEvent;
typedef struct AudioEng_tTable AudioEng_tTable;
typedef struct AudioEng_tDef AudioEng_tDef;
typedef struct AudioEng_tChanAttr AudioEng_tChanAttr;
typedef struct AudioEng_tAdjustments AudioEng_tAdjustments;
typedef struct AudioEng_tVoiceAttr AudioEng_tVoiceAttr;
typedef struct AudioEng_tState AudioEng_tState;
typedef struct AudioEng_t AudioEng_t;
typedef struct AudioElem AudioElem;
typedef struct AudioTrk_tAmbientChannel AudioTrk_tAmbientChannel;
typedef struct AudioTrk_tGlobals AudioTrk_tGlobals;
typedef struct DRender_tView DRender_tView;
typedef struct Draw_DCache Draw_DCache;
typedef struct Chunk Chunk;
typedef struct BW_tContextMgr BW_tContextMgr;
typedef struct tBuildEntry tBuildEntry;
typedef struct CHorizonSpec CHorizonSpec;
typedef struct CSkySpec CSkySpec;
typedef struct CNightSpec CNightSpec;
typedef struct CWeatherSpec CWeatherSpec;
typedef struct CFogSpec CFogSpec;
typedef struct CDepthCueSpec CDepthCueSpec;
typedef struct CWorldColor CWorldColor;
typedef struct Trk_NewSlice Trk_NewSlice;
typedef struct tNormalCacheEntry tNormalCacheEntry;
typedef struct camera_info camera_info;
typedef struct camera_flags camera_flags;
typedef struct Camera_tCamSlot Camera_tCamSlot;
typedef struct SimpleMem SimpleMem;
typedef struct SerializedGroup SerializedGroup;
typedef struct Trk_SimpleInst Trk_SimpleInst;
typedef struct Clock_tGameClock Clock_tGameClock;
typedef struct Object_tSimObjList Object_tSimObjList;
typedef struct HudPmx_tShape HudPmx_tShape;
typedef struct HudPmx_tUV HudPmx_tUV;
typedef struct SPCHNFSType_vs_KMH_MPH SPCHNFSType_vs_KMH_MPH;
typedef struct SPCHNFSType_VOICE SPCHNFSType_VOICE;
typedef struct CarBankName CarBankName;
typedef struct Speech Speech;
typedef struct MobileSpeaker MobileSpeaker;
typedef struct DispatchSpeaker DispatchSpeaker;
typedef struct Speech_tCarDescription Speech_tCarDescription;
typedef struct Speech_tLocationDescription Speech_tLocationDescription;
typedef struct Speech_tCallSignDescription Speech_tCallSignDescription;
typedef struct Speech_tMobileVoiceAttr Speech_tMobileVoiceAttr;
typedef struct CopSpeak_tFileIndex CopSpeak_tFileIndex;
typedef struct CopSpeak_tBankHeader CopSpeak_tBankHeader;
typedef struct CopSpeak_tBank CopSpeak_tBank;
typedef struct dashhud_info dashhud_info;
typedef struct FEI_tList FEI_tList;
typedef struct GameSetup_tData GameSetup_tData;
typedef struct Input_tResults Input_tResults;
typedef struct tPMenuCommand tPMenuCommand;
typedef struct tPMenu tPMenu;
typedef struct tPListIterator tPListIterator;
typedef struct tPListIteratorIndexed tPListIteratorIndexed;
typedef struct tPMenuItem tPMenuItem;
typedef struct tPMenuItemNonInteractiveText tPMenuItemNonInteractiveText;
typedef struct tPMenuItemInteractive tPMenuItemInteractive;
typedef struct tPMenuItemLeftRightChoice tPMenuItemLeftRightChoice;
typedef struct tPMenuItemLeftRightSlider tPMenuItemLeftRightSlider;
typedef struct tPMenuItemLeftRightSliderIndexed tPMenuItemLeftRightSliderIndexed;
typedef struct tPMenuItemGoToMenuButton tPMenuItemGoToMenuButton;
typedef struct tPMenuItemCommandButton tPMenuItemCommandButton;
typedef struct tPauseMenuDefs tPauseMenuDefs;
typedef struct tNfsSystemInfo tNfsSystemInfo;
typedef struct tListIteratorIndexed tListIteratorIndexed;
typedef struct tScreen tScreen;
typedef struct tCarLineup tCarLineup;
typedef struct tTrackInformation tTrackInformation;
typedef struct tTrackManager tTrackManager;
typedef struct tTierInfo tTierInfo;
typedef struct tTourneyInfo tTourneyInfo;
typedef struct tTrackInfo tTrackInfo;
typedef struct tTournamentDefinition tTournamentDefinition;
typedef struct tAwardInformation tAwardInformation;
typedef struct tCompetitor tCompetitor;
typedef struct tTournamentManager tTournamentManager;
typedef struct tMissionTierInfo tMissionTierInfo;
typedef struct tMissionInfo tMissionInfo;
typedef struct tStageInfo tStageInfo;
typedef struct tAcademyDefinition tAcademyDefinition;
typedef struct tMissionManager tMissionManager;
typedef struct tActiveLine tActiveLine;
typedef struct tShapeInformation tShapeInformation;
typedef struct tDialogBase tDialogBase;
typedef struct tDialogMessageString tDialogMessageString;
typedef struct tDialogInteractive tDialogInteractive;
typedef struct tDialogYesNo tDialogYesNo;
typedef struct tCredit tCredit;
typedef struct tCreditManager tCreditManager;
typedef struct tRecordBuffer tRecordBuffer;
typedef struct ObjectMultiAnim ObjectMultiAnim;
typedef struct ObjectSignAnim ObjectSignAnim;
typedef struct Object_tIMassObjInfo Object_tIMassObjInfo;
typedef struct Physics_tWheelAccStruct Physics_tWheelAccStruct;
typedef struct Draw_tVertex Draw_tVertex;
typedef struct Draw_CarCache Draw_CarCache;
typedef struct Transformer_zScene Transformer_zScene;
typedef struct R3DCar_tEnvMapInfo R3DCar_tEnvMapInfo;
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_F4 POLY_F4;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_FT4 POLY_FT4;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_STP DR_STP;
#endif
typedef struct tControllerData tControllerData;
typedef struct tReplayInterface tReplayInterface;
typedef struct tReplayCameraModes tReplayCameraModes;
typedef struct tReplayBuffer tReplayBuffer;
typedef struct CSceneList CSceneList;
typedef struct Sim_tSimGlobalVar Sim_tSimGlobalVar;
typedef struct Sim_tSimSystemVar Sim_tSimSystemVar;
typedef struct sim_queue sim_queue;
typedef struct Souffle_tISouffle Souffle_tISouffle;
typedef struct Stats_tPosition Stats_tPosition;
typedef struct Trk_Material Trk_Material;
typedef struct TrackHeader TrackHeader;
typedef struct SaveSurface SaveSurface;
typedef struct tBoundingSphere tBoundingSphere;
typedef struct Track_MipMap Track_MipMap;
typedef struct Track_MultiPalette Track_MultiPalette;
typedef struct Track_tMaterialController Track_tMaterialController;
typedef struct tSkid tSkid;
typedef struct SNDSYSOPTS SNDSYSOPTS;
typedef struct SpuVolume SpuVolume;
typedef struct SpuExtAttr SpuExtAttr;
typedef struct SpuStVoiceAttr SpuStVoiceAttr;
typedef struct CarIO_textureInfo CarIO_textureInfo;
typedef struct Input_tDeviceList Input_tDeviceList;
typedef struct dflip dflip;
typedef struct Draw_tView Draw_tView;
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_FT3 POLY_FT3;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_G3 POLY_G3;
#endif
typedef struct DrawC_tEnvMap DrawC_tEnvMap;
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_GT3 POLY_GT3;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_TWIN DR_TWIN;
#endif
typedef struct Trk_Line Trk_Line;
typedef struct Draw_tGiveShelbyMoreCache Draw_tGiveShelbyMoreCache;
typedef struct Draw_tCtrlSkidmark Draw_tCtrlSkidmark;
typedef struct ChunkObjectInfo ChunkObjectInfo;
typedef struct Force_tGlobal Force_tGlobal;
typedef struct charactertbl charactertbl;
#ifndef NFS4_PSYQ_HEADERS
typedef struct SPRT SPRT;
#endif
typedef struct cluttbl cluttbl;
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_G4 POLY_G4;
#endif
#ifndef NFS4_PSYQ_HEADERS
typedef struct LINE_G2 LINE_G2;
#endif
typedef struct Draw_FlareCache Draw_FlareCache;
typedef struct FLARE_DEF FLARE_DEF;
typedef struct Flare_tInfo Flare_tInfo;
#ifndef NFS4_PSYQ_HEADERS
typedef struct TILE_1 TILE_1;
#endif
typedef struct Draw_HorizonCache Draw_HorizonCache;
typedef struct Draw_SkyCache Draw_SkyCache;
typedef struct tHrz_LightningFork tHrz_LightningFork;
typedef struct tHrz_Lightning tHrz_Lightning;
#ifndef NFS4_PSYQ_HEADERS
typedef struct POLY_F3 POLY_F3;
#endif
typedef struct tSmallCoordXY tSmallCoordXY;
typedef struct tBTCPerpInfo tBTCPerpInfo;
typedef struct tCompRGB tCompRGB;
typedef struct tNightInitCache tNightInitCache;
typedef struct CARD_FILE_HEADER CARD_FILE_HEADER;
typedef struct eacelement eacelement;
typedef struct sfxsouffle sfxsouffle;
typedef struct Sfx_tCache Sfx_tCache;
typedef struct Texture_pal8bit Texture_pal8bit;
typedef struct CSVECTOR CSVECTOR;
typedef struct TP_ZPaletteSystem TP_ZPaletteSystem;
typedef struct FogKey FogKey;
typedef struct CTrackSpecHeader CTrackSpecHeader;
typedef struct CTrackSpec CTrackSpec;
typedef struct Weather_tSys Weather_tSys;
typedef struct Weather_tSplatInfo Weather_tSplatInfo;
#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_AREA DR_AREA;
#endif
typedef struct tMenuCommand tMenuCommand;
typedef struct tListIteratorRangeIndexed tListIteratorRangeIndexed;
typedef struct tMenuItemLeftRightChoice tMenuItemLeftRightChoice;
typedef struct tMenuItemLeftRightSlider tMenuItemLeftRightSlider;
typedef struct tMenuItemGoToMenuButton tMenuItemGoToMenuButton;
typedef struct tDrawShapeExtended tDrawShapeExtended;
typedef struct tDialogHelp tDialogHelp;
typedef struct tDialogMessageStringWithTimeout tDialogMessageStringWithTimeout;
typedef struct tDialogNoInputMessage tDialogNoInputMessage;
typedef struct tFEApplication tFEApplication;
typedef struct tMenuItemGoToMenuNFS4Button tMenuItemGoToMenuNFS4Button;
typedef struct tMenuItemNFS4LeftRightChoice tMenuItemNFS4LeftRightChoice;
typedef struct tBlankMenuItemNFS4LeftRightChoice tBlankMenuItemNFS4LeftRightChoice;
typedef struct tMenuItemOptionsLeftRightChoice tMenuItemOptionsLeftRightChoice;
typedef struct tMenuItemOptionsTwoItemChoice tMenuItemOptionsTwoItemChoice;
typedef struct tMenuNFS4 tMenuNFS4;
typedef struct tMenuNFS4TwoPlayer tMenuNFS4TwoPlayer;
typedef struct tMenuNFS4Bottom tMenuNFS4Bottom;
typedef struct tMenuBlank tMenuBlank;
typedef struct tMenuOptions tMenuOptions;
typedef struct tMenuItemLeftRightFade tMenuItemLeftRightFade;
typedef struct tOptionsMenu tOptionsMenu;
typedef struct tInsideBoxMenu tInsideBoxMenu;
typedef struct tMenuItemSlidingMenu tMenuItemSlidingMenu;
typedef struct tMenuItemSlidingActivated tMenuItemSlidingActivated;
typedef struct tMenuItemDisplayLeftRightChoice tMenuItemDisplayLeftRightChoice;
typedef struct tMenuItemOnOffLeftRightChoice tMenuItemOnOffLeftRightChoice;
typedef struct tMenuItemLeftRightAudioSlider tMenuItemLeftRightAudioSlider;
typedef struct tInsideBoxSongMenu tInsideBoxSongMenu;
typedef struct tMenuItemControllerLeftRightChoice tMenuItemControllerLeftRightChoice;
typedef struct tInsideBoxLeftRightSlider tInsideBoxLeftRightSlider;
typedef struct tInsideBoxTwoWaySlider tInsideBoxTwoWaySlider;
typedef struct tUserNameMenuItem tUserNameMenuItem;
typedef struct tMenuItemGoToMenuButtonFade tMenuItemGoToMenuButtonFade;
typedef struct tMemoryCardMenuItem tMemoryCardMenuItem;
typedef struct tBlankMenuItemGoToMenuNFS4Button tBlankMenuItemGoToMenuNFS4Button;
typedef struct tInsideBoxControllerLeftRightSlider tInsideBoxControllerLeftRightSlider;
typedef struct tSaveCarInfo tSaveCarInfo;
typedef struct tListIteratorCar tListIteratorCar;
typedef struct tListIteratorCarColor tListIteratorCarColor;
typedef struct tSaveTrackInfo tSaveTrackInfo;
typedef struct tListIteratorTrack tListIteratorTrack;
typedef struct tSaveTournament tSaveTournament;
typedef struct tListIteratorTournament tListIteratorTournament;
typedef struct tTVConfig tTVConfig;
typedef struct tVideoTransition tVideoTransition;
typedef struct tVideo tVideo;
typedef struct FE3d_zUV FE3d_zUV;
typedef struct FE3d_zFacet FE3d_zFacet;
typedef struct FE3d_zObj FE3d_zObj;
typedef struct tScreenUserName tScreenUserName;
typedef struct tScreenTournamentStandings tScreenTournamentStandings;
typedef struct tScreenTournamentStandings3item tScreenTournamentStandings3item;
typedef struct LUMPYHEAD LUMPYHEAD;
typedef struct FILEINFO FILEINFO;
typedef struct SPEECHINFO SPEECHINFO;
typedef struct tDialogBackUpOnly tDialogBackUpOnly;
typedef struct tDialogYesNoMem tDialogYesNoMem;
typedef struct tDialogYesNoTri tDialogYesNoTri;
typedef struct CARDINFO_def CARDINFO_def;
typedef struct MCRDFILEHEADER_def MCRDFILEHEADER_def;
typedef struct MCRDFILEINFO_def MCRDFILEINFO_def;
typedef struct helpKeyData helpKeyData;
typedef struct tHelpData tHelpData;
typedef struct tScreenControllerConfig tScreenControllerConfig;
typedef struct tCheat tCheat;
typedef struct tOldMenu tOldMenu;
typedef struct tItemButton tItemButton;
typedef struct tPSXToFEMapping tPSXToFEMapping;
typedef struct tListIteratorDoubleIndexed tListIteratorDoubleIndexed;
typedef struct tListIteratorMultiPlayer tListIteratorMultiPlayer;
typedef struct tScreenMain tScreenMain;
typedef struct MCRDFILE_def MCRDFILE_def;
typedef struct tVideoWall tVideoWall;
typedef struct tOverlay tOverlay;
typedef struct tScreenCarSelect tScreenCarSelect;
typedef struct tScreenCarSelectDuel tScreenCarSelectDuel;
typedef struct tScreenCarSelectTwoPlayer tScreenCarSelectTwoPlayer;
typedef struct tScreenPinkSlipsCarSelect tScreenPinkSlipsCarSelect;
typedef struct tScreenTournSelect tScreenTournSelect;
typedef struct tScreenPinkSlipStandings tScreenPinkSlipStandings;
typedef struct tScreenTrophyRoom tScreenTrophyRoom;
typedef struct tScreenTrophyInfo tScreenTrophyInfo;
typedef struct tScreenDisplay tScreenDisplay;
typedef struct tScreenAudio tScreenAudio;
typedef struct tScreenMemcard tScreenMemcard;
typedef struct tScreenCongrats tScreenCongrats;
typedef struct tScreenTournamentTrophy tScreenTournamentTrophy;
typedef struct tScreenPinkSlipCongrats tScreenPinkSlipCongrats;
typedef struct tScreenBeTheCopCongrats tScreenBeTheCopCongrats;
typedef struct tScreenTournamentCongrats tScreenTournamentCongrats;
typedef struct tScreenTrackRecords tScreenTrackRecords;
typedef struct tScreenTrackSelect tScreenTrackSelect;
typedef struct tScreenTrackInfo tScreenTrackInfo;
typedef struct tScreenPinkSlips tScreenPinkSlips;
typedef struct tAllScreens tAllScreens;
typedef struct tPerpModelList tPerpModelList;
typedef struct tFEStream tFEStream;
typedef struct tCarInLineup tCarInLineup;
typedef struct tGlobalMenuDefs tGlobalMenuDefs;
typedef struct tMemCardData tMemCardData;
typedef struct MCRDOPTS_def MCRDOPTS_def;
typedef struct tVideoWallConfig tVideoWallConfig;
typedef struct tVertex tVertex;
#ifndef NFS4_PSYQ_HEADERS
typedef struct LINE_F2 LINE_F2;
#endif
typedef struct CdlFILE CdlFILE;
typedef struct DECENV DECENV;
typedef struct CDSECTOR CDSECTOR;
#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_OFFSET DR_OFFSET;
#endif
typedef struct fMemCardInfo_def fMemCardInfo_def;
typedef struct MDECSTRUCT MDECSTRUCT;
typedef struct tMdecHandle tMdecHandle;
typedef struct windowtbl windowtbl;
typedef struct STREAMCHUNKHDR STREAMCHUNKHDR;
typedef struct VIDEOSTRUCT VIDEOSTRUCT;
typedef struct ARGB ARGB;
typedef struct scoorddef scoorddef;
typedef struct RPOINT RPOINT;
typedef struct PSXCDFILEINFO_def PSXCDFILEINFO_def;
typedef struct tPadModuleState tPadModuleState;
typedef union tPadVariantData tPadVariantData;
typedef union trigger_t trigger_t;
typedef union tPadStdAnalog_u tPadStdAnalog_u;
/* __vtbl_ptr_type = the GENUINE GCC 2.7.2 vtable-entry type emitted by the original toolchain
   (PsyQ 4.3 / GCC 2.7.2 "old ABI"). The SYM writes it verbatim as a STRUCT tag on all 336 .vf refs;
   it is the compiler's own builtin there, NOT something we invented. GCC 2.7.2's old-ABI layout is the
   8-byte {short delta; short index; void(*pfn)()} (delta/index = the multiple-inheritance this-adjust).
   BINARY-CONFIRMED via _vt.15tScreenCongrats @ 0x80012448 -> pfns = GetShapeInfo / DrawBackground /
   Initialize / Cleanup / ProcessInput / ... ; delta/index = 0 (single inheritance, no thunk).
   We compile under a MODERN g++ whose builtin __vtbl_ptr_type diverged to a 4-byte `int(*)(...)` typedef.
   Since that typedef is already parsed, we cannot re-`struct` the name -> we define the real 8-byte
   entry under a private tag and macro-restore the canonical name to it. So `__vtbl_ptr_type` means
   exactly what GCC 2.7.2 / the SYM mean by it: the 8-byte entry. (pfn is int(*)(...) not void(*)() only
   so Ghidra's `iVarN = (*pfn)(...)` virtual-dispatch bodies type-check; size/layout are unaffected.)
   _vf fields are always POINTERS to arrays of these, so this size never changes any struct's size. */
typedef struct __nfs4_vtbl_ptr_t { short delta; short index; int (*pfn)(...); } __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

/* ============ ENUMS ============ */

typedef enum {   /* 4 bytes */
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;

typedef enum {   /* 4 bytes */
    AISCRIPT_PLAYACTION_COLLISION = 0,
    AISCRIPT_PLAYACTION_OPP_WIZZED_BY = 1,
    AISCRIPT_PLAYACTION_HUMAN_BLOCK_OPP = 2,
    AISCRIPT_PLAYACTION_OPP_BLOCK_HUMAN = 3,
    AISCRIPT_PLAYACTION_OPP_PASS_HUMAN = 4,
    AISCRIPT_PLAYACTION_HUMAN_PASS_OPP = 5,
    AISCRIPT_PLAYACTION_HUMAN_HONK = 6,
    AISCRIPT_PLAYACTION_SENTINAL = 7
} AIScript_tPlayAction;

typedef enum {   /* 4 bytes */
    AISCRIPT_AIREACTION_INIT = 1,
    AISCRIPT_AIREACTION_END = 2,
    AISCRIPT_AIREACTION_SPEED_BURST = 4,
    AISCRIPT_AIREACTION_HONK_HORN = 8,
    AISCRIPT_AIREACTION_HARD_BRAKE = 16,
    AISCRIPT_AIREACTION_SWIPE = 32,
    AISCRIPT_AIREACTION_ATTACK = 64,
    AISCRIPT_AIREACTION_PAUSE = 128,
    AISCRIPT_AIREACTION_REAR_END = 256,
    AISCRIPT_AIREACTION_SWERVE = 512,
    AISCRIPT_AIREACTION_MOVE_AWAY = 1024,
    AISCRIPT_AIREACTION_WIPE_OUT = 2048,
    AISCRIPT_AIREACTION_CRAZY_HORN = 4096,
    AISCRIPT_AIREACTION_TEST1 = 8192,
    AISCRIPT_AIREACTION_TEST2 = 16384,
    AISCRIPT_AIREACTION_TEST3 = 32768,
    AISCRIPT_AIREACTION_TEST4 = 65536
} AIScript_tAIReaction;

typedef enum {   /* 4 bytes */
    SPEECH_MODE_NONE = 0,
    SPEECH_MODE_PURSUIT = 1,
    SPEECH_MODE_PURSUIT_WRONG_SIDE = 2,
    SPEECH_MODE_PURSUIT_BUMP_COP = 3,
    SPEECH_MODE_WARNING = 4,
    SPEECH_MODE_WARNING_WRONG_SIDE = 5,
    SPEECH_MODE_WARNING_BUMP_COP = 6,
    SPEECH_MODE_BUST = 7,
    SPEECH_MODE_APPROACH_ROADBLOCK = 8,
    SPEECH_MODE_ARREST = 9,
    SPEECH_MODE_COP_KILLER = 10,
    SPEECH_MODE_SENTINAL = 11
} speechModeType;

typedef enum {   /* 4 bytes */
    SPEECH_INTENSITY_LOW = 0,
    SPEECH_INTENSITY_MED = 1,
    SPEECH_INTENSITY_HIGH = 2,
    SPEECH_INTENSITY_SENTINAL = 3
} speechIntensityType;

typedef enum {   /* 4 bytes */
    SPEECH_SOURCE_REGULAR_COP = 0,
    SPEECH_SOURCE_SUPER_COP = 1,
    SPEECH_SOURCE_ROADBLOCK = 2,
    SPEECH_SOURCE_SENTINAL = 3
} speechSourceType;

typedef enum {   /* 4 bytes */
    DONUTMODE_NONE = 0,
    DONUTMODE_GOCENTER = 1,
    DONUTMODE_DONUT = 2,
    DONUTMODE_BURNOUT = 3
} donutMode_t;

typedef enum {   /* 4 bytes */
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

typedef enum {   /* 4 bytes */
    COP_REGULAR = 0,
    COP_SUPER = 1
} copType;

typedef enum {   /* 4 bytes */
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
} crimeType;

typedef enum {   /* 4 bytes */
    CRUISE_ATSETSPEED = 0,
    CRUISE_ATFACTOR = 1,
    CRUISE_ATTRAFFICSPEED = 2
} cruiseMode_t;

typedef enum {   /* 4 bytes */
    STATE_NONE = 0,
    STATE_PURGATORY = 1,
    STATE_NORMAL = 2,
    STATE_IDLE = 3,
    STATE_CHASE = 4,
    STATE_OFFROAD = 5,
    STATE_ROVING_TRAFFIC = 6,
    STATE_NONACTIVE = 7,
    STATE_DONUTS = 8,
    STATE_GOTOSLICE = 9,
    STATE_CRUISE = 10
} stateType_t;

typedef enum {   /* 4 bytes */
    COP_GAME_NO = 0,
    COP_GAME_PURSUIT = 1,
    COP_GAME_BTC_1HC = 2,
    COP_GAME_BTC_2HC = 3,
    COP_GAME_BTC_1HC1HP = 4
} AIHigh_CopGameType_t;

typedef enum {   /* 4 bytes */
    ROLE_IDLE = 0,
    ROLE_WINGMAN = 1,
    ROLE_BLOCKADER = 2,
    ROLE_BLOCKADER_SPIKEBELT = 3
} Wingman_Role;

typedef enum {   /* 4 bytes */
    PULLOVER_NONE = 0,
    PULLOVER_WARNING = 1,
    PULLOVER_BUST = 2,
    PULLOVER_EOG = 3
} tPullOverMode;

typedef enum {   /* 4 bytes */
    NO_ATTACK = 0,
    REAR_END = 1,
    SCRIPT_ATTACK = 2,
    PROVOKED_ATTACK = 3
} AIHigh_tAttackMode;

typedef enum {   /* 4 bytes */
    PERPMODE_CRUISE = 0,
    PERPMODE_FAST = 1,
    PERPMODE_MADECONTACT = 2,
    PERPMODE_TEASE = 3,
    PERPMODE_ESCAPE = 4,
    PERPMODE_CHASEON = 5
} tPerpMode;

typedef enum {   /* 4 bytes */
    BLOCKADEMODE_NONE = 0,
    BLOCKADEMODE_SETUP = 1,
    BLOCKADEMODE_WAITING = 2,
    BLOCKADEMODE_CHASE = 3,
    BLOCKADEMODE_SETUP_FOR_OTHER = 4
} blockadeMode_t;

typedef enum {   /* 4 bytes */
    DRIVEAWAY_NONE = 0,
    DRIVEAWAY_RESET = 1,
    DRIVEAWAY_NORESET = 2
} AIHigh_tDriveAwayMode;

typedef enum {   /* 4 bytes */
    FREEZE_NONE = 0,
    FREEZE_NEWPERP_ROVE = 1,
    FREEZE_NEWPERP_DONE = 2,
    FREEZE_ARREST = 3,
    FREEZE_ARRESTDONE = 4
} tFreezeMode;

typedef enum {   /* 4 bytes */
    WINGMAN_NONE = 0,
    WINGMAN_WINGMAN_REQUEST = 1,
    WINGMAN_BLOCKADER_REQUEST = 2,
    WINGMAN_BLOCKADER_SPIKEBELT_REQUEST = 3,
    WINGMAN_WINGMAN_ACTIVE = 4,
    WINGMAN_BLOCKADER_ACTIVE = 5
} tWingmanStatus;

typedef enum {   /* 4 bytes */
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

typedef enum {   /* 4 bytes */
    PLACEMENTSPEED_SLOW = 0,
    PLACEMENTSPEED_FAST = 1
} tPlacementSpeed;

typedef enum {   /* 4 bytes */
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
} AICop_RoadBlockState;

typedef enum {   /* 4 bytes */
    GEAR_REVERSE = 0,
    GEAR_NEUTRAL = 1,
    GEAR_FIRST = 2,
    GEAR_SECOND = 3,
    GEAR_THIRD = 4,
    GEAR_FOURTH = 5,
    GEAR_FIFTH = 6,
    GEAR_SIXTH = 7,
    GEAR_SEVENTH = 8
} Gear_t;

typedef enum {   /* 4 bytes */
    kRampType_Interpolate = 0,
    kRampType_NoInterpolate = 1
} eRampType;

typedef enum {   /* 4 bytes */
    NORECORD_R = 0,
    RACER_SPEED_R = 1,
    TRAFFIC_SPEED_R = 2,
    ACCELERATION_R = 3,
    REMOVED_R = 4,
    BEST_LINE_R = 5,
    TRACK_CURVE_R = 6,
    CURVESPEED_TABLE_R = 7,
    CAR_TRACKING_R = 8
} AIDataRecord_WhichRecord_t;

typedef enum {   /* 4 bytes */
    TRIGGER_NONE = 0,
    TRIGGER_COP_SIMPLE = 1,
    TRIGGER_COP_ROADBLOCK = 2,
    TRIGGER_COP_OFFROAD = 3,
    TRIGGER_TRAFFIC_ACCIDENT = 4,
    TRIGGER_TRAFFIC_PATH = 5,
    TRIGGER_NUM_TRIGGER_TYPES = 6
} triggerType;

typedef enum {   /* 4 bytes */
    kAsphalt = 0,
    kCarBody = 1,
    kTires = 2,
    kGravel = 3,
    kWall = 4,
    kSign = 5,
    kBush = 6,
    kBlowOut = 7,
    kBackFire = 8,
    kHorn = 9,
    kGearShift = 10,
    kSnow = 11,
    kGrass = 12,
    kWoodWall = 13,
    kGrassWall = 14,
    kWallSpark = 15,
    kWetAsphalt = 16,
    kRaceTireOnAsphalt = 17,
    kRainTireOnAsphalt = 18
} s_type;

typedef enum {   /* 4 bytes */
    kMenu_Command_None = 0,
    kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2,
    kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4,
    kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8,
    kMenu_Command_ClearRecords = 9
} tMenuCommandType;

typedef enum {   /* 4 bytes */
    cm_MercedesSLK = 0,
    cm_BMWZ3 = 1,
    cm_HoldenHSVT = 2,
    cm_FordFalcon = 3,
    cm_ChevyCamaro = 4,
    cm_TransAm = 5,
    cm_AstonMartinDB7 = 6,
    cm_JaguarXKR = 7,
    cm_BMWM5 = 8,
    cm_ChevyCorvette = 9,
    cm_Ferrari550 = 10,
    cm_Porsche911 = 11,
    cm_FerrariF50 = 12,
    cm_DiabloSV = 13,
    cm_MercedesCLK = 14,
    cm_McLarenF1 = 15,
    cm_XPerimentalPorsche = 16,
    cm_XPerimentalF50 = 17,
    cm_XPerimentalF1 = 18,
    cm_BonusCar1 = 19,
    cm_BonusCar2 = 20,
    cm_BonusCar3 = 21,
    cm_CapriceCop = 22,
    cm_HoldenHSVTCop = 23,
    cm_BMWM5Cop = 24,
    cm_CorvetteCop = 25,
    cm_PorscheCop = 26,
    cm_DiabloCop = 27,
    cm_Helicopter = 28,
    cm_AudiA4 = 29,
    cm_BMW530i = 30,
    cm_Mercedes500SL = 31,
    cm_VolvoWagon = 32,
    cm_SchoolBus = 33,
    cm_LandCruiser = 34,
    cm_Miata = 35,
    cm_ArmyTruck = 36,
    cm_JeepCommanche = 37,
    cm_OneTonTruck = 38,
    cm_OneTonTruckDirty = 39,
    cm_MercedesVan = 40,
    cm_JeepCherokee = 41,
    cm_Satellite = 42,
    cm_OldChevyPickup = 43,
    cm_FordF150 = 44,
    cm_Barracuda = 45,
    cm_TaxiCab = 46,
    cm_TourBus = 47,
    cm_LoggingTruck = 48,
    cm_TransitBus = 49,
    cm_NumCarModels = 50
} tCarModels;

typedef enum {   /* 4 bytes */
    cnl_Medium = 0,
    cnl_Short = 1,
    cnl_Long = 2
} tCarNameLength;

typedef enum {   /* 4 bytes */
    kPersonalityNemesis = 0,
    kPersonalityBlurrr = 1,
    kPersonalityZippy = 2,
    kPersonalityJetBoy = 3,
    kPersonalityMenace = 4,
    kPersonalityCop1 = 5,
    kPersonalityCop2 = 6,
    kPersonalityCop3 = 7,
    kPersonalityTraffic = 8,
    kPersonalityNUM = 9
} tPersonalities;

typedef enum {   /* 4 bytes */
    kMPause_NoEvent = 0,
    kMPause_Continue = 1,
    kMPause_Restart = 2,
    kMPause_QuitToGameSetup = 3,
    kMPause_QuitToRaceSummary = 4,
    kMPause_ForfeitToRaceSummary = 5,
    kMPause_GoToMenu = 6,
    kMPause_BackupMenu = 7,
    kMPause_CommandConfirmationFlag = 256
} tPMenuCommandType;

typedef enum {   /* 4 bytes */
    kInput_KeyType_NoKey = 0,
    kInput_KeyType_AlreadyProcessed = 1,
    kInput_KeyType_Cross = 2,
    kInput_KeyType_Circle = 4,
    kInput_KeyType_Square = 8,
    kInput_KeyType_Triangle = 16,
    kInput_KeyType_L1 = 32,
    kInput_KeyType_L2 = 64,
    kInput_KeyType_R1 = 128,
    kInput_KeyType_R2 = 256,
    kInput_KeyType_Up = 512,
    kInput_KeyType_Down = 1024,
    kInput_KeyType_Left = 2048,
    kInput_KeyType_Right = 4096,
    kInput_KeyType_Start = 8192,
    kInput_KeyType_Select = 16384
} tInputKeyType;

typedef enum {   /* 4 bytes */
    cct_Roadster = 0,
    cct_PonyCar = 1,
    cct_SaloonCar = 2,
    cct_SportsCar = 3,
    cct_SuperCar = 4,
    cct_GTRCar = 5,
    cct_BonusCar = 6,
    cct_CopCar = 7,
    cct_TrafficCar = 8,
    cct_Helicopter = 9,
    cct_OpenClass = 10,
    cct_NumCarClasses = 11
} tCarClassType;

typedef enum {   /* 4 bytes */
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
} tTrackClassType;

typedef enum {   /* 4 bytes */
    kINVALID = 0,
    kVALID = 1,
    kPREDICTED = 2,
    kRESIM = 3
} VALIDITY;

typedef enum {   /* 4 bytes */
    Weather_kSnow = 0,
    Weather_kRain = 1
} Weather_tState;

typedef enum {   /* 4 bytes */
    kApp_Command_StartRace = 0,
    kApp_Command_ReStartRace = 1,
    kApp_Command_StartReplay = 2
} tAppCommand;

typedef enum {   /* 4 bytes */
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
} tTVState;

typedef enum {   /* 4 bytes */
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
} tScreenMainState;

typedef enum {   /* 4 bytes */
    kPlayerBoth = -1,
    kPlayerOne = 0,
    kPlayerTwo = 1
} tPlayer;

typedef enum {   /* 4 bytes */
    clt_Stock = 1,
    clt_GarageCar = 2,
    clt_Cop = 4,
    clt_Pursuit = 8,
    clt_Traffic = 16,
    clt_PinkSlips = 32,
    clt_Tournament = 64,
    clt_Dealer = 128
} tCarListType;

typedef enum {   /* 4 bytes */
    N_AMERICA = 0,
    JAPAN = 1,
    EUROPE = 2
} PRODUCTLOC;

typedef enum {   /* 4 bytes */
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;

typedef enum {   /* 4 bytes */
    textType_Title = 0,
    textType_FlybyHelp = 1,
    textType_BorderInfo = 2,
    textType_FramedInfo = 3,
    textType_ScreenInfo = 4,
    textType_ScreenInfoHeader = 5,
    textType_Options = 6,
    textType_FramedMoney = 7,
    textType_PopUpText = 8,
    textType_PopUpTitle = 9,
    textType_PostGame = 10,
    textType_TrackRecords = 11,
    textType_UserNameMenu = 12,
    textType_VideoWall = 13,
    textType_NumTypes = 14,
    textType_Default = 14
} tMenuTextType;

typedef enum {   /* 4 bytes */
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
} tMenuTextState;

typedef enum {   /* 4 bytes */
    cheat_Roadster = 0,
    cheat_Pony = 1,
    cheat_Saloon = 2,
    cheat_Sports = 3,
    cheat_SuperCar = 4,
    cheat_GTRCar = 5,
    cheat_BonusCar = 6,
    cheat_CopCar = 7,
    cheat_FiveFingerDiscount = 8,
    cheat_FreeRepairs = 9,
    cheat_NoDamage = 10,
    cheat_AllCars = 11,
    cheat_AllCops = 12,
    cheat_AllTracks = 13,
    cheat_MoreMoney = 14,
    cheat_BonusTrack1 = 15,
    cheat_BonusTrack2 = 16,
    cheat_BonusTrack3 = 17,
    cheat_BonusTrack4 = 18,
    cheat_AllCheats = 19,
    cheat_NFSTeamRecords = 20,
    cheat_MyMomSaysImCool = 21,
    cheat_BonusMoney = 22,
    cheat_LotsaMoney = 23,
    cheat_FullGridTraffic = 24,
    cheat_FinishedTournament = 25,
    cheat_FinishedSpecialEvent = 26,
    cheat_AllNotRaced = 27,
    cheat_AllGold = 28,
    cheat_AllSilver = 29,
    cheat_AllBronze = 30,
    cheat_NumCheats = 31
} tCheatCode;

typedef enum {   /* 4 bytes */
    kScreen_TransitionTypeItem = 0,
    kScreen_TransitionTypeMenu = 1,
    kScreen_TransitionTypeScreen = 2
} tScreen_TransitionType;

typedef enum {   /* 4 bytes */
    kFront_InitialLoad = 0,
    kFront_QuitToGameSetup = 1,
    kFront_QuitToPostGame = 2
} tFront_ProcessingType;

typedef enum {   /* 4 bytes */
    kTrophyGold = 0,
    kTrophySilver = 1,
    kTrophyBronze = 2,
    kTrophyCar = 3,
    kTrophyNone = 4
} tTrophyClass;

typedef enum {   /* 4 bytes */
    kSpinningNone = 0,
    kSpinningGold = 1,
    kSpinningMemCard = 2
} tSmallSpinningThing;

typedef enum {   /* 4 bytes */
    kScreenCongrats_Congrats = 0,
    kScreenCongrats_Eliminated = 1
} tScreenCongratsMessage;

typedef enum {   /* 4 bytes */
    ts_Small = 0,
    ts_Medium = 1,
    ts_Large = 2
} tTrophySize;

typedef enum {   /* 4 bytes */
    PinkSlipsNoError = 0,
    PinkSlipsError_NotOriginalCard = 1,
    PinkSlipsError_LoadFailed = 2,
    PinkSlipsError_SaveFailed = 3,
    PinkSlipsError_CardNotFound = 4,
    PinkSlipsError_NotFormatted = 5,
    PinkSlipsError_CardFull = 6,
    numPinkSlipsErrors = 7
} PinkSlipsErrorCode;

typedef enum {   /* 4 bytes */
    cst_Acceleration = 0,
    cst_Brake = 1,
    cst_Speed = 2,
    cst_Handling = 3,
    cst_Overall = 4
} tCarStatType;

typedef enum {   /* 4 bytes */
    NoCardInserted = 0,
    CardFailed = 1,
    CardFailedNotFound = 2,
    CardFailedUnformatted = 3,
    NotEnoughCars = 4,
    TooManyCars = 5,
    CardLoadedFine = 6,
    WhoCaresWeBeExiting = 7,
    CardCurrentlyLoading = 8
} PinkSlipsCarSelectState;

typedef enum {   /* 4 bytes */
    VIDEOSTATE_IDLE = 0,
    VIDEOSTATE_SPOOLING = 1,
    VIDEOSTATE_READY = 2,
    VIDEOSTATE_PLAYING = 3
} VIDEOSTATE;

/* ============ STRUCTS + UNIONS (topo-sorted, interleaved) ============ */

struct PAD_ANALOG {   /* 6 bytes */
    u_short            state;   /* +0x0 */
    u_char             rightx, righty, leftx, lefty;   /* +0x2 */
};

struct PAD_MOUSE {   /* 6 bytes */
    u_char             unused, state;   /* +0x0 */
    char               horizontalvalue, verticalvalue;   /* +0x2 */
    u_char             unused2[2];   /* +0x4 */
};

struct PAD_NEGCON {   /* 6 bytes */
    u_char             state : 4;   /* +0x0 bit 0 */
    u_char             start : 4;   /* +0x0 bit 4 */
    u_char             buttonAB : 4;   /* +0x1 bit 0 */
    u_char             rightshift : 4;   /* +0x1 bit 4 */
    u_char             twist, buttonI, buttonII, leftshift;   /* +0x2 */
};

struct PAD_PSX {   /* 6 bytes */
    u_short            state;   /* +0x0 */
    u_short            unused[2];   /* +0x2 */
};

union tPadVariantData {   /* 6 bytes */
    PAD_PSX            standard;
    PAD_NEGCON         negcon;
    PAD_MOUSE          mouse;
    PAD_ANALOG         analog;
};

struct trigger_anyTrigger_t {   /* 8 bytes */
    int                type, slice;   /* +0x0 */
};

struct coorddef {   /* 12 bytes */
    int                x, y, z;   /* +0x0 */
};

struct matrixtdef {   /* 36 bytes */
    int                m[9];   /* +0x0 */
};

struct trigger_offroad_t {   /* 72 bytes */
    int                type, slice, dir;   /* +0x0 */
    coorddef           position;   /* +0xC */
    matrixtdef         orientation;   /* +0x18 */
    int                maxSpeed, releaseTime, endSlice;   /* +0x3C */
};

struct trigger_roadblock_t {   /* 20 bytes */
    int                type, slice, dir, numCars, spikeBelt;   /* +0x0 */
};

struct trigger_simple_t {   /* 20 bytes */
    int                type, slice, dir, side, moving;   /* +0x0 */
};

struct trigger_trafficAccident_t {   /* 56 bytes */
    int                type, slice;   /* +0x0 */
    coorddef           position;   /* +0x8 */
    matrixtdef         orientation;   /* +0x14 */
};

struct trigger_trafficPath_t {   /* 64 bytes */
    int                type, slice, dir;   /* +0x0 */
    matrixtdef         orientation;   /* +0xC */
    int                maxSpeed, releaseTime, numPoints;   /* +0x30 */
    trigger_pathPosition_t *path;   /* +0x3C */
};

union trigger_t {   /* 72 bytes */
    trigger_anyTrigger_t any;
    trigger_simple_t   simple;
    trigger_roadblock_t roadblock;
    trigger_offroad_t  offroad;
    trigger_trafficAccident_t trafficAccident;
    trigger_trafficPath_t trafficPath;
};

union tPadStdAnalog_u {   /* 6 bytes */
    PAD_PSX            standard;
    PAD_ANALOG         analog;
};

#ifndef NFS4_PSYQ_HEADERS
struct MATRIX {   /* 32 bytes (PsyQ libgte) */
    short              m[3][3];   /* +0x0 */
    long               t[3];   /* +0x14 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct VECTOR {   /* 16 bytes (PsyQ libgte) */
    long               vx, vy, vz, pad;   /* +0x0 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct SVECTOR {   /* 8 bytes (PsyQ libgte) */
    short              vx, vy, vz, pad;   /* +0x0 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct CVECTOR {   /* 4 bytes (PsyQ libgte) */
    u_char             r, g, b, cd;   /* +0x0 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DVECTOR {   /* 4 bytes (PsyQ libgte) */
    short              vx, vy;   /* +0x0 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct RVECTOR {   /* 24 bytes (PsyQ libgte) */
    SVECTOR            v;   /* +0x0 */
    u_char             uv[2];   /* +0x8 */
    u_short            pad;   /* +0xA */
    CVECTOR            c;   /* +0xC */
    DVECTOR            sxy;   /* +0x10 */
    u_long             sz;   /* +0x14 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct CRVECTOR3 {   /* 88 bytes (PsyQ libgte) */
    RVECTOR            r01, r12, r20;   /* +0x0 */
    RVECTOR            *r0, *r1, *r2;   /* +0x48 */
    u_long             *rtn;   /* +0x54 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct CRVECTOR4 {   /* 140 bytes (PsyQ libgte) */
    RVECTOR            r01, r02, r31, r32, rc;   /* +0x0 */
    RVECTOR            *r0, *r1, *r2, *r3;   /* +0x78 */
    u_long             *rtn;   /* +0x88 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct RECT {   /* 8 bytes (PsyQ libgpu) */
    short              x, y, w, h;   /* +0x0 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DR_ENV {   /* 64 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_long             code[15];   /* +0x4 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DRAWENV {   /* 92 bytes (PsyQ libgpu) */
    RECT               clip;   /* +0x0 */
    short              ofs[2];   /* +0x8 */
    RECT               tw;   /* +0xC */
    u_short            tpage;   /* +0x14 */
    u_char             dtd, dfe, isbg, r0, g0, b0;   /* +0x16 */
    DR_ENV             dr_env;   /* +0x1C */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DISPENV {   /* 20 bytes (PsyQ libgpu) */
    RECT               disp, screen;   /* +0x0 */
    u_char             isinter, isrgb24, pad0, pad1;   /* +0x10 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DR_MODE {   /* 12 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_long             code[2];   /* +0x4 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
typedef struct DR_TPAGE {   /* 8 bytes (PsyQ libgpu draw-tpage prim) */
    u_long             tag;   /* +0x0 */
    u_long             code[1];   /* +0x4 */
} DR_TPAGE;
#endif

struct shapetbl {   /* 20 bytes */
    unsigned int       type : 8;   /* +0x0 bit 0 */
    int                next : 24;   /* +0x1 bit 0 */
    short              width, height, centerx, centery;   /* +0x4 */
    int                shapex : 12;   /* +0xC bit 0 */
    unsigned int       reserved : 1;   /* +0xD bit 4 */
    unsigned int       twiddled : 1;   /* +0xD bit 5 */
    unsigned int       transposed : 1;   /* +0xD bit 6 */
    unsigned int       rotated : 1;   /* +0xD bit 7 */
    int                shapey : 12;   /* +0xE bit 0 */
    unsigned int       mipmaps : 4;   /* +0xF bit 4 */
    char               data;   /* +0x10 */
};

struct cdstreamstruct {   /* 152 bytes */
    long               id;   /* +0x0 */
    char               *start, *end, *write, *header, *get, *release;   /* +0x4 */
    int                handle, state, control, status, abort, datahascrc, crcerrors, crcretries, buffersize;   /* +0x1C */
    long               blocksize;   /* +0x40 */
    int                readsize, chunksize, relocationsize;   /* +0x44 */
    long               fileoffset;   /* +0x50 */
    int                fileend;   /* +0x54 */
    long               filesize;   /* +0x58 */
    int                dataoffset, seekposition, seekoffset, idtype, idmask;   /* +0x5C */
    cdstreamstruct     *nextstream;   /* +0x70 */
    void               *emptyblock, *head, *tail, *block;   /* +0x74 */
    int                timer, blocktime, streamfull, getable, releaseable;   /* +0x84 */
};

struct linedef {   /* 16 bytes */
    int                start, end, colour, thickness;   /* +0x0 */
};

struct SHAPETABLEENTRY {   /* 8 bytes */
    char               id[4];   /* +0x0 */
    long               offset;   /* +0x4 */
};

struct PCOORD16 {   /* 8 bytes */
    short              x, y, z, p;   /* +0x0 */
};

struct COORD16 {   /* 6 bytes */
    short              x, y, z;   /* +0x0 */
};

struct CCOORD16 {   /* 8 bytes */
    short              x, y, z, light;   /* +0x0 */
};

struct PAD_COMMON {   /* 8 bytes */
    u_char             nopad, ID;   /* +0x0 */
    tPadVariantData    data;   /* +0x2 */
};

struct tActiveTime {   /* 2 bytes */
    char               bActive, time;   /* +0x0 */
};

struct Draw_tPixMap {   /* 16 bytes */
    u_char             u0, v0;   /* +0x0 */
    u_short            clut;   /* +0x2 */
    u_char             u1, v1;   /* +0x4 */
    u_short            tpage;   /* +0x6 */
    u_char             u2, v2;   /* +0x8 */
    u_short            pad2;   /* +0xA */
    u_char             u3, v3;   /* +0xC */
    u_short            flag;   /* +0xE */
};

struct DRender_tCalcView {   /* 132 bytes */
    coorddef           translation;   /* +0x0 */
    matrixtdef         mrotation;   /* +0xC */
    coorddef           translationInv;   /* +0x30 */
    matrixtdef         mrotationInv, mrotationInvRaw;   /* +0x3C */
};

struct Draw_SVertex {   /* 16 bytes */
    short              vx, vy, vz;   /* +0x0 */
    u_char             u, v;   /* +0x6 */
    short              dvx, dvy;   /* +0x8 */
    u_char             r, g, b, a;   /* +0xC */
};

struct Draw_PrimStruct {   /* 12 bytes */
    u_long             *LastPrim;   /* +0x0 */
    char               *PrimPtr, *MPrimPtr;   /* +0x4 */
};

struct Draw_tCacheHeader {   /* 20 bytes */
    Draw_PrimStruct    cprim;   /* +0x0 */
    int                mirror;   /* +0xC */
    short              clipW, clipH;   /* +0x10 */
};

struct Draw_CarVertex {   /* 8 bytes */
    COORD16            vt;   /* +0x0 */
    char               u, v;   /* +0x6 */
};

struct Group {   /* 4 bytes */
    int                m_num_elements;   /* +0x0 */
};

struct Trk_ObjectDef {   /* 4 bytes */
    short              id;   /* +0x0 */
    u_char             vertexCount, quadCount;   /* +0x2 */
};

struct Trk_CollideBoomInst {   /* 36 bytes */
    short              size;   /* +0x0 */
    u_char             type, objectIndex, zoffset, flags;   /* +0x2 */
    short              pad;   /* +0x6 */
    int                x, y, z;   /* +0x8 */
    short              qx, qy, qz, qw, sx, sy, sz;   /* +0x14 */
    u_char             simIndex, boomIndex;   /* +0x22 */
};

struct Trk_AnimateInst {   /* 12 bytes */
    short              size;   /* +0x0 */
    u_char             type, objectIndex, zoffset, flags;   /* +0x2 */
    short              pad, count, interval;   /* +0x6 */
};

struct Trk_Quad {   /* 6 bytes */
    short              material;   /* +0x0 */
    u_char             aPoints[4];   /* +0x2 */
};

struct Trk_NewStrip {   /* 4 bytes */
    u_char             topVert, botVert;   /* +0x0 */
    char               quadCount, size;   /* +0x2 */
};

struct Trk_NewSimQuad {   /* 1 bytes */
    u_char             surface;   /* +0x0 */
};

struct Trk_NewSimSlice {   /* 5 bytes */
    u_char             stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;   /* +0x0 */
};

struct Trk_SimObject {   /* 20 bytes */
    int                point[3];   /* +0x0 */
    short              radius, serialNum;   /* +0xC */
    u_char             topCRAP, bottomCRAP, instIndex, type;   /* +0x10 */
};

struct RelCoord16 {   /* 4 bytes */
    short              x, z;   /* +0x0 */
};

struct tSaveSurface {   /* 8 bytes */
    Trk_NewSimQuad     *fSimQuad;   /* +0x0 */
    u_char             fSurface;   /* +0x4 */
};

struct BWorldSm_Pos {   /* 132 bytes */
    short              slice, stripQuadInd, simRotFlag;   /* +0x0 */
    coorddef           quadPts[4];   /* +0x8 */
    CCOORD16           quadPts16[4];   /* +0x38 */
    char               sliceChanged, quadChanged, offEdge, triangleFlag;   /* +0x58 */
    coorddef           normal, forward;   /* +0x5C */
    char               quad;   /* +0x74 */
    u_char             chunk;   /* +0x75 */
    char               lastRezRequested, rez;   /* +0x76 */
    Trk_NewSimQuad     *simQuad;   /* +0x78 */
    Trk_NewStrip       *strip;   /* +0x7C */
    Trk_NewSimSlice    *simSlice;   /* +0x80 */
};

struct BO_tNewtonCollisionInfo {   /* 48 bytes */
    int                collided, impulse;   /* +0x0 */
    BO_tNewtonObj      *otherObj;   /* +0x8 */
    int                sfxType, disableCollisionTimer;   /* +0xC */
    coorddef           collisionPoint;   /* +0x14 */
    int                lastCollision;   /* +0x20 */
    BO_tNewtonObj      *lastOtherObj;   /* +0x24 */
    int                lastImpulse, lastTime;   /* +0x28 */
};

struct BO_tNewtonObj {   /* 576 bytes */
    int                objID;   /* +0x0 */
    u_short            oldSlice, totalSlice;   /* +0x4 */
    BWorldSm_Pos       simRoadInfo;   /* +0x8 */
    int                distToPlayer;   /* +0x8C */
    u_char             simOptz, active, reOrthoCounter;   /* +0x90 */
    int                gravityMult, cumulatedRot, lastUpdated;   /* +0x94 */
    coorddef           position, linearVel;   /* +0xA0 */
    int                mass, massInv, speedXZ, xRelRoadCenter;   /* +0xB8 */
    short              positionXZ, eIndexEnvMap, eIndexShadow;   /* +0xC8 */
    int                wheelRot[2];   /* +0xD0 */
    int                wheelFrontX, wheelFrontZ, wheelBackX, wheelBackZ, wheelWidthF, wheelWidthB;   /* +0xD8 */
    matrixtdef         orientMat;   /* +0xF0 */
    coorddef           angularVel;   /* +0x114 */
    int                moInertia, moInertiaInv;   /* +0x120 */
    coorddef           orientationToGround, dimension;   /* +0x128 */
    int                dimensionRadius;   /* +0x140 */
    matrixtdef         roadMatrix;   /* +0x144 */
    coorddef           roadCenterPoint;   /* +0x168 */
    int                roadGravityModifier, roadYaw;   /* +0x174 */
    u_short            flightTime, deadTimer;   /* +0x17C */
    int                groundElevation, groundVel, objAltitude;   /* +0x180 */
    BO_tNewtonCollisionInfo collision;   /* +0x18C */
    int                groundSurfaceType, driveSurfaceType;   /* +0x1BC */
    matrixtdef         shadowMat;   /* +0x1C4 */
    coorddef           shadowCoord[4];   /* +0x1E8 */
    int                damage[10];   /* +0x218 */
};

struct GameSetup_tCarData {   /* 180 bytes */
    int                carType, carClass, Transmission, Colour, ColourSV, ColourChange, RampSteering, RampGas, RampBrake, BrakeBias, GearRatio, SteeringQuickness, Traction, BrakeAssist, TireType, EngineMods, WeightTransfer, GroundEffects, ABS, Bestline, Personality, StartingPos, carNameIndex;   /* +0x0 */
    char               driver[8];   /* +0x5C */
    int                pad;   /* +0x64 */
    char               license[8];   /* +0x68 */
    int                HudSpeed, HudSpeedMult, HudTach, HudMap, HudOpponentID, HudTime, HudLapnum, HudPosition, HudMirror, HudColour, HudTachColour, SpeechColour, Country;   /* +0x70 */
    int                Camera[4];   /* +0xA4 */
};

struct GameSetup_tUserSetting {   /* 204 bytes */
    int                language, display, bestlap, audioMode, musicLevel, sfxLevel, engineLevel, speechLevel, ambientLevel, interactive, numplaylistsongs;   /* +0x0 */
    int                playlist[40];   /* +0x2C */
};

struct GameSetup_tPerpData {   /* 52 bytes */
    int                CarType, Colour, SpeechColour, HudColour, Personality, TimeLimit, WingmanTime, SpikeBeltTime, BlockadeCopTime, Distance, SpeedFactor, WeightFactor, GlueFactor;   /* +0x0 */
};

struct GameSetup_tControllerData {   /* 88 bytes */
    int                controllerConfig[2], deadSpot[2], steeringRange[2], IImaxRange[2], ImaxRange[2], J1MIN[2], J1MAX[2], J2MIN[2], J2MAX[2], shockMode[2], shockImpact[2];   /* +0x0 */
};

struct Sched_tFunctionSchedule {   /* 16 bytes */
    int                priority;   /* +0x0 */
    void               *function, *var1, *var2;   /* +0x4 */
};

struct Sched_tSchedule {   /* 24 bytes */
    int                maxNumFunctions, numFunctions;   /* +0x0 */
    Sched_tFunctionSchedule func[1];   /* +0x8 */
};

struct Transformer_zUV {   /* 2 bytes */
    u_char             u, v;   /* +0x0 */
};

struct Transformer_zFacet {   /* 12 bytes */
    short              flag;   /* +0x0 */
    u_char             textureIndex, vertexId0, vertexId1, vertexId2;   /* +0x2 */
    Transformer_zUV    uv0, uv1, uv2;   /* +0x6 */
};

struct Transformer_zObj {   /* 28 bytes */
    u_short            numVertex, numFacet;   /* +0x0 */
    coorddef           translation;   /* +0x4 */
    COORD16            *vertex, *Nvertex;   /* +0x10 */
    Transformer_zFacet *facet;   /* +0x18 */
};

struct Transformer_zOverlay {   /* 4 bytes */
    short              offset;   /* +0x0 */
    u_char             u, v;   /* +0x2 */
};

struct AIPerson_t {   /* 84 bytes */
    int                blockMaxDistance, blockMinDistance, oncomingLookAhead;   /* +0x0 */
    int                laneSwerve[4];   /* +0xC */
    int                swerveChangeProb, brakeMultiplier, attackActivationHits, attackTime, fishtailAngle, minimumBetweenWipeoutTicks, randomBetweenWipeoutTicks, gripLossProbPerSecond, gripLossMinFactor, gripLossRecoveryPerTick, bestLineAbility;   /* +0x1C */
    unsigned int       rearBumpProbMask, smackProbMask, copCollisionFirmness;   /* +0x48 */
};

struct AIScript_tReactionDetails {   /* 8 bytes */
    char               reaction[4], halfSeconds[4];   /* +0x0 */
};

struct AIScript_t {   /* 64 bytes */
    int                detectAction, detectHumCarIndex, actionIndex, actionHumCarIndex, reactionIndex, reaction, reactionTicksLeft;   /* +0x0 */
    AIScript_tReactionDetails (*data)[7];   /* +0x1C */
    int                lastReactionIndex[7];   /* +0x20 */
    int                lastActionTime;   /* +0x3C */
};

struct AISpeechInfo_t {   /* 24 bytes */
    int                speechMode, speechIntensity, speechSource, playerCarIndex, copCarIndex, warningNumber;   /* +0x0 */
};

struct Car_tStats {   /* 160 bytes */
    int                extractSlice, sliceTotal, sliceTime, slice, lastSlice, lap, lapTime;   /* +0x0 */
    int                time[4], topSpeed[4];   /* +0x1C */
    int                position, fatalCrashes, finishType, checkpointDifference, checkpointUpdate, checkpointDisplay, numWarnings, numFines, numArrests, carType, carClass, carNameIndex, carFlags, finalDamage, finalNumWarnings, finalNumFines, finalNumArrests, finalFinishType, finalPosition, finalTotalTime;   /* +0x3C */
    int                finalLapTime[4];   /* +0x8C */
    int                finalBestLap;   /* +0x9C */
};

struct Car_tControl {   /* 28 bytes */
    char               desiredGasLevel, desiredBrakeLevel, desiredGear, gasLevel, brakeLevel, lastGear, gear, downShifting, gearShiftTimer, handBrake, horn, lights, lookBehind, abort, event, queuedEvent;   /* +0x0 */
    int                desiredSteering, steering, hanno;   /* +0x10 */
};

struct Car_tWheel {   /* 48 bytes */
    coorddef           currentPos, roadNormal;   /* +0x0 */
    int                actualHeight, wheelAcc, wheelInAir, rebound, impactCompression, roadSurfaceType;   /* +0x18 */
};

struct Car_tSpecs {   /* 464 bytes */
    int                mass, numGears, gearShiftDelay;   /* +0x0 */
    int                velToRpmRatio[8], gearEfficiency[8];   /* +0xC */
    int                torqueCurve[41];   /* +0x4C */
    int                redline, maxSpeed, frontDriveRatio, maxBrakeAcc, frontBrakeRatio, wheelBase, frontGripBias, maxSteeringAcc, steeringRamp, lateralGripMult, frontAeroDownForce, rearAeroDownForce, gasOffFactor, gTransferFactor, slideMultiplier, spinVelCap, dampingPitchRate, dampingRollRate, suspensionStiffness, pitchAngularVelCap, rollAngularVelCap, damageFactor, bodyPitchFactor, bodyRollFactor, tireRange, rideOffset, dragFactor, redlineInv;   /* +0xF0 */
    int                gearVelInv[8], velToRpmRatioInv[8], gearAccCoeff[8];   /* +0x160 */
    int                dragCoeff, alphaToAccRotInertia, accToAlphaRotInertia, lateralGripMultInv;   /* +0x1C0 */
};

struct Cars_tCollisionInfo {   /* 8 bytes */
    int                resetTimer, smoking;   /* +0x0 */
};

struct Cars_tAudio {   /* 24 bytes */
    int                type, channel, surface1, surface2, force, panangle;   /* +0x0 */
};

struct Cars_tRenderInfo {   /* 152 bytes */
    short              colorIndex;   /* +0x0 */
    char               currentCountry, newCountry;   /* +0x2 */
    int                textureStartIndex, bodyPitch, bodyRoll, currentPitch, currentRoll, currentHeight, pitchFactor, rollFactor, world_otz, sub_otz;   /* +0x4 */
    u_long             *sub_ot;   /* +0x2C */
    int                sub_otSize, sub_otOffset;   /* +0x30 */
    void               *sort_carObj;   /* +0x38 */
    short              sort_flag, damageParts;   /* +0x3C */
    int                light;   /* +0x40 */
    char               *palCopy;   /* +0x44 */
    short              palNum;   /* +0x48 */
    short              palCopyNum[20];   /* +0x4A */
    char               medOnly, upgradeFlags;   /* +0x72 */
    short              headLight, brakeLight;   /* +0x74 */
    short              signalLight[2];   /* +0x78 */
    short              currentCarType, newCarType, inside, detail, VRamX, VRamY, textureOffsetU, textureOffsetV;   /* +0x7C */
    u_char             licenseOffsetU[2], licenseOffsetV[2];   /* +0x8C */
    int                rideHeight, upgradeHeight;   /* +0x90 */
};

struct Car_tObj {   /* 2268 bytes */
    BO_tNewtonObj      N;   /* +0x0 */
    char               carName[9], carNameLocalized[9];   /* +0x240 */
    int                carIndex, humanIndex, sortIndex, carFlags, lap, unlap, roadSpan, glue, blowout, pullOver, revLimit;   /* +0x254 */
    Car_tObj           *swapCar;   /* +0x280 */
    int                swapTime;   /* +0x284 */
    GameSetup_tCarData *carInfo;   /* +0x288 */
    Car_tWheel         wheel[4];   /* +0x28C */
    Car_tStats         stats;   /* +0x34C */
    int                crash, wrongway;   /* +0x3EC */
    coorddef           angularAcc, linearAcc, linearAcc_ch, linearVel_ch, angularVel_ch, linearAcc_rh;   /* +0x3F4 */
    Car_tControl       control;   /* +0x43C */
    char               RSGasLevel, RSBrakeLevel;   /* +0x458 */
    int                RSSteering, RSControl;   /* +0x45C */
    Car_tSpecs         *specs;   /* +0x464 */
    int                flywheelRpm, wheelSpin, frontWheelSpin, wheelLock, slide, gTransferFront, gTransferRight, frontSkid, rearSkid, oldSkidState;   /* +0x468 */
    coorddef           oldSkidPoint[4];   /* +0x490 */
    int                oldAudioSkidState;   /* +0x4C0 */
    void               *funcUpdateRoadInfo, *funcReplay, *funcControl, *funcStats, *funcHandlingPhysics, *funcGravityPhysics, *funcQDPhysicsUpdateVel, *funcQDPhysicsUpdateRot, *funcTestMeForCollisions, *funcDoPostCollisionStuff;   /* +0x4C4 */
    int                personalityIndex;   /* +0x4EC */
    AIPerson_t         *personality;   /* +0x4F0 */
    AIScript_t         script;   /* +0x4F4 */
    AISpeechInfo_t     speechInfo;   /* +0x534 */
    int                carInLane, desiredDirection, direction, desiredLatPos, desiredSpeed, originalDesiredSpeed, currentSpeed, speed, laneSlack, AIFlags, roadPosition;   /* +0x54C */
    Car_tObj           *basisCar;   /* +0x578 */
    int                aiShiftDuration, aiShiftTimer, redLine, tailgateTimer, physicsModelTimer, trafficSpeedRandomizingFactor, laneChangeSpeed;   /* +0x57C */
    int                topSpeeds[7], invTopSpeeds[7];   /* +0x598 */
    short              accTable[112];   /* +0x5D0 */
    AIDataRecord_AccTable_t *accelerationRecord;   /* +0x6B0 */
    AIDataRecord_CurveSpeedTable_t *curveSpeedTable;   /* +0x6B4 */
    AIPhysic_BrakeInfo *brakeInfo;   /* +0x6B8 */
    int                speedFactor, barrierThinkHarder, laneIndex, copTopSpeed, copAccMult;   /* +0x6BC */
    coorddef           desiredVector;   /* +0x6D0 */
    int                aCarWRTDesired;   /* +0x6DC */
    coorddef           angularAcc_ch;   /* +0x6E0 */
    int                driveDirectionReverseTime, driveDirection, driveDirectionTimer, aCar, aDesired, aCarWRTRoad, lateralVelocity;   /* +0x6EC */
    coorddef           targetPos;   /* +0x708 */
    int                targetLatPos, rampDesiredLatPos, preferredLateralPosition, preferredLateralPositionPower, timeOffRoad, max_clacc, max_aa, aiGlue, drag, slackProb, accNitrous, speedNitrous, wipeOutStartTick, wipeOutEndTick, btcGlueModifier, donutMode, AIFishtailEndTick, lookAheadSlice, forceNoSimOptz, gripFactor;   /* +0x714 */
    Car_tObj           *fallBehindCar, *nextAIRacer;   /* +0x764 */
    int                caravanFollowBehindDistanceMeters, caravanTimer, AISlot, damageMult, topSpeedUpgradeMult, accUpgradeMult, extraWallCollisionAllowance;   /* +0x76C */
    Cars_tCollisionInfo collision;   /* +0x788 */
    int                audioDamageScrape, audioCount;   /* +0x790 */
    Cars_tAudio        audio[7];   /* +0x798 */
    Cars_tRenderInfo   render;   /* +0x840 */
    int                async_handle;   /* +0x8D8 */
};

struct AIDataRecord_t {   /* 88 bytes */
    int                numElements_, bSize_;   /* +0x0 */
    char               name_[64];   /* +0x8 */
    char               *dataBuffer_, *preAllocatedBuffer_;   /* +0x48 */
    int                recordMethod_;   /* +0x50 */
    __vtbl_ptr_type      (*_vf)[3];   /* +0x54 */
    AIDataRecord_t() {}
    AIDataRecord_t(AIDataRecord_WhichRecord_t which, char *name);
    ~AIDataRecord_t();
    int AddRecordToCollection();
    int RemoveRecordFromCollection();
    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
    void Setup();
    int Load();
    int SaveAndPurge();
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t {   /* 92 bytes */
    int                scale_;   /* +0x58 */
    AIDataRecord_AccTable_t() {}
    AIDataRecord_AccTable_t(char *name, int n, AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_AccTable_t();
    int Get(int i);
    void Setup();
};

struct AIDataRecord_CurveSpeedTable_t {   /* 88 bytes */
    AIDataRecord_t     _base_AIDataRecord_t;   /* +0x0 */
    AIDataRecord_CurveSpeedTable_t() {}
    AIDataRecord_CurveSpeedTable_t(char *name, AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_CurveSpeedTable_t();
    int Get(int i);
    void Upgrade(int i);
};

struct AIPhysic_BrakeInfo {   /* 132 bytes */
    u_char             brakeTable_[128];   /* +0x0 */
    int                deceleration_;   /* +0x80 */
};

struct AI_tInfo {   /* 72 bytes */
    Car_tObj           *blockingCars[3];   /* +0x0 */
    int                blockingCarsDist[3], laneSpeeds[3], laneSpeedsAhead[3], laneWeights[3];   /* +0xC */
    int                desiredLane, desiredLaneSide, deltaYaw;   /* +0x3C */
};

struct AIPhysic_ModelConfig_t {   /* 44 bytes */
    int                dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc, dangle_to_dav, max_dav, dav_to_aa, max_aa, vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;   /* +0x0 */
};

struct AIDataRecord_BestLine_t {   /* 88 bytes */
    AIDataRecord_t     _base_AIDataRecord_t;   /* +0x0 */
    AIDataRecord_BestLine_t() {}
    AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_BestLine_t();
};

struct BW_tContext {   /* 156 bytes */
    int                client;   /* +0x0 */
    BWorldSm_Pos       slicePos;   /* +0x4 */
    int                currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq, lineFarZClipSq;   /* +0x88 */
};

struct AnimScript {   /* 20 bytes */
    int                baseTicks, baseFrame, flags, numParts;   /* +0x0 */
    Trk_AnimateInst    **inst;   /* +0x10 */
    /* methods (anim.obj, GAME\COMMON\anim.cpp) -- non-virtual; layout unchanged */
    AnimScript(int num);
    AnimScript(int num, int numParts);
    AnimScript(Group *instanceGroup, int type, int boomIndex, int numParts);
    void SetAnimAttrib(int flags);
    void GetAnimFrameInfo(int *frame, int *numFrames);
    int GetTimedAnimPosRot(coorddef *pt, matrixtdef *mat);
    int GetTimedAnimPosRot(int index, coorddef *pt, matrixtdef *mat);
    int GetStatus();
};

struct SceneElem {   /* 92 bytes */
    int                type, size, committed, visible;   /* +0x0 */
    coorddef           cp;   /* +0x10 */
    int                height;   /* +0x1C */
    matrixtdef         orient;   /* +0x20 */
    int                subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;   /* +0x44 */
};

struct SceneSortedElem {   /* 8 bytes */
    int                slice_;   /* +0x0 */
    SceneElem          *se;   /* +0x4 */
};

struct AnimDef {   /* 20 bytes */
    int                type, numPieces, objDefIndex, baseAnim, animIndex;   /* +0x0 */
};

struct ObjectAnim {   /* 4 bytes */
    __vtbl_ptr_type      (*_vf)[3];   /* +0x0 */
};

struct ObjectFinishedMultiAnim {   /* 4 bytes */
    ObjectAnim         _base_ObjectAnim;   /* +0x0 */
};

struct ObjectFinishedSignAnim {   /* 48 bytes */
    ObjectAnim         _base_ObjectAnim;   /* +0x0 */
    matrixtdef         finalMatrix;   /* +0x4 */
    Trk_ObjectDef      *objDef;   /* +0x28 */
    Trk_CollideBoomInst *objCollideInstance;   /* +0x2C */
};

struct AIDelayCar {   /* 60 bytes */
    int                delayFactor_;   /* +0x0 */
    Car_tObj           *basisCar_, *targetCar_;   /* +0x4 */
    int                deltaMeters_, slice_;   /* +0xC */
    coorddef           deltaPosition_, position_;   /* +0x14 */
    int                deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;   /* +0x2C */
    AIDelayCar() {}
    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update();
};

struct copLevel_t {   /* 52 bytes */
    int                copChasers[2];   /* +0x0 */
    int                numBlockaders;   /* +0x8 */
    int                copBlockaders[2];   /* +0xC */
    int                spikeBelt;   /* +0x14 */
    int                copAggression[2];   /* +0x18 */
    int                copsPerLap, engagementLapFraction, warningTicks, beatingTicks, numWarningsAdded;   /* +0x20 */
};

struct copGame_t {   /* 8 bytes */
    int                numLevels;   /* +0x0 */
    copLevel_t         *levels;   /* +0x4 */
};

struct AICop_BasicPerpInfo {   /* 12 bytes */
    int                copsAssigned_[2];   /* +0x0 */
    int                crime_;   /* +0x8 */
};

struct AICop_PerpChaseInfo {   /* 36 bytes */
    int                engagementTime_;   /* +0x0 */
    copGame_t          *copGameInfo_;   /* +0x4 */
    int                chaseLevelIndex_, bestChaseLevelIndex_;   /* +0x8 */
    copLevel_t         *chaseLevel_;   /* +0x10 */
    int                totalEngagementPercent_, blockadeDone_, engagementPercentIncreasePerTick_, copFreeTicks_;   /* +0x14 */
};

struct trigger_pathPosition_t {   /* 20 bytes */
    coorddef           position;   /* +0x0 */
    int                targetSpeed, waitTime;   /* +0xC */
};

struct AIState_Base {   /* 8 bytes */
    Car_tObj           *carObj_;   /* +0x0 */
    __vtbl_ptr_type      (*_vf)[4];   /* +0x4 */
    AIState_Base() {}
    AIState_Base(Car_tObj *carObj);
    ~AIState_Base();
    void StateExecute();
    int TestForRelease();
};

struct AIState_None {   /* 8 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    AIState_None() {}
    ~AIState_None();
    void Execute();
};

struct AIState_Normal {   /* 8 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    AIState_Normal() {}
    AIState_Normal(Car_tObj *carObj);
    ~AIState_Normal();
    void Execute();
};

struct AIState_NonActive {   /* 8 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    AIState_NonActive() {}
    ~AIState_NonActive();
    void Execute();
};

struct AIHigh_Base {   /* 24 bytes */
    Car_tObj           *carObj_;   /* +0x0 */
    AIState_Base       *state_;   /* +0x4 */
    int                stateType_, schedulingOff_, lastTrafficTriggerCheckSlice_;   /* +0x8 */
    __vtbl_ptr_type      (*_vf)[3];   /* +0x14 */
    AIHigh_Base() {}
    AIHigh_Base(Car_tObj *carObj);
    ~AIHigh_Base();
    void StateExecute();
};

struct AIHigh_None {   /* 24 bytes */
    AIHigh_Base        _base_AIHigh_Base;   /* +0x0 */
    AIHigh_None() {}
    ~AIHigh_None();
    void HighExecute();
};

struct tCopCarPair {   /* 8 bytes */
    int                copIndex, carIndex;   /* +0x0 */
};

struct AIHigh_BasicPerp {   /* 124 bytes */
    AIHigh_Base        _base_AIHigh_Base;   /* +0x0 */
    int                pullOverMode_;   /* +0x18 */
    tCopCarPair        positionVSCopList_[6];   /* +0x1C */
    int                copVSPositionList_[6];   /* +0x4C */
    int                beatingTicksLeft_, lastPullOverTime_;   /* +0x64 */
    Car_tObj           *lastArrestingCop_;   /* +0x6C */
    AICop_BasicPerpInfo basicPerpInfo_;   /* +0x70 */
    int AddChaser(int a, int b, copType ct);
    void RemoveChaser(int a, int b, copType ct);
    int CheckChaserPosition(int a, int b);
    AIHigh_BasicPerp() {}
    AIHigh_BasicPerp(Car_tObj *carObj);
    void CheckForCrimes();
    int CheckIfCaught();
    void RemoveCloseCops();
    void Clear();
};

struct AIHigh_Player {   /* 176 bytes */
    AIHigh_BasicPerp   _base_AIHigh_BasicPerp;   /* +0x0 */
    int                numWarnings_, numBusts_, newTriggerProb_, lastTriggerCheckSlice_;   /* +0x7C */
    AICop_PerpChaseInfo perpChaseInfo_;   /* +0x8C */
    AIHigh_Player() {}
    AIHigh_Player(Car_tObj *carObj);
    void HandleCops();
    int CheckIfABlockadeCanBeSetup();
    void SetupBlockade();
    void CheckForNewLevel(int level);
    void HandleSpeech();
    void MaintainAvailableCops();
    void CleanupBlockaders(int a);
    void HandlePullOver();
};

struct AIHigh_BTC_Perp {   /* 136 bytes */
    AIHigh_BasicPerp   _base_AIHigh_BasicPerp;   /* +0x0 */
    int                caught_, hudActivated_;   /* +0x7C */
    AIHigh_BTC_HumanCop *originalActivationCop_;   /* +0x84 */
    AIHigh_BTC_Perp() {}
    ~AIHigh_BTC_Perp();
    void ReleaseCops();
    void HandleCops();
    int IsFalseArrest();
    int CheckForControlsPressed();
    void HandlePullOver();
    void NotifyCopsOfArrest();
    void NotifyCopsOfArrestComplete();
    void NotifyCopsOfFalseArrest();
    void NotifyHumanCopsOfArrestHud();
    void ClearForNewStage(AIHigh_BTC_HumanCop *cop);
    AIHigh_BTC_HumanCop *CheckForActivation();
};

struct blockade_t {   /* 52 bytes */
    int                mode;   /* +0x0 */
    AIHigh_Player      *target;   /* +0x4 */
    int                flags, chaseLevel, requestSpikeBeltAtSlice, slice, direction, latPos, rotation, reverse, releaseTime, initialPlayerDistanceMetersInt;   /* +0x8 */
    short              blockadeSpeechFlags;   /* +0x30 */
};

struct AIHigh_BasicCop {   /* 88 bytes */
    AIHigh_Base        _base_AIHigh_Base;   /* +0x0 */
    int                type_, copIndex_;   /* +0x18 */
    blockade_t         blockade_;   /* +0x20 */
    int                driveAway_;   /* +0x54 */
    AIHigh_BasicCop() {}
    AIHigh_BasicCop(Car_tObj *carObj, int idx);
    void CheckSpikeBelt();
    void SetupBlockadeElements(blockade_t *blockade);
    void HandleBlockadeSpeech();
    int ShouldIPerformCutOffBlock(int a, Car_tObj *carObj);
};

struct AIHigh_BTC_Cop {   /* 100 bytes */
    AIHigh_BasicCop    _base_AIHigh_BasicCop;   /* +0x0 */
    AIHigh_BTC_Perp    *perpTarget_;   /* +0x58 */
    int                chaseIndex_, freezeMode_;   /* +0x5C */
    AIHigh_BTC_Cop() {}
    AIHigh_BTC_Cop(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_Cop();
    void AssignToPlayer(AIHigh_BTC_Perp *target);
    int GetCheckChasePosition(coorddef *pos);
    int CheckForNewTarget();
    void StartArrest(AIHigh_BTC_Perp *p);
    void FinishArrest(AIHigh_BTC_Perp *p);
    void FalseArrest(AIHigh_BTC_Perp *p);
    void FreezeAndEndChase();
    void HudOff();
};

struct AIHigh_BTC_HumanCop {   /* 140 bytes */
    AIHigh_BTC_Cop     _base_AIHigh_BTC_Cop;   /* +0x0 */
    int                currentStage_, stageRepeatCount_, stageTimeMultiplier_, timeLeft_, chaseStartTime_, wingmanStatus_, needPerp_, initialDirection_, initialMovement_, requestedDesiredSpeed_;   /* +0x64 */
    AIHigh_BTC_HumanCop() {}
    AIHigh_BTC_HumanCop(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_HumanCop();
    int FindRandomBarrierFreeArea(int startSlice, int safetyZone, int randomDistance);
    void ReleaseAndStartChase(AIHigh_BTC_Perp *p);
    void FreezeAndEndChase();
    void CheckConditionWithCop0();
    void NewStage(int copSlice, int direction, int movement);
    void UpdateAndCheckTimeLeft();
    void UpdateFreezeModeAndPullOverMode();
    void RequestWingman();
    void RequestBlockader(int spikeBeltRequest);
    int CheckForWingmanRequest();
    int CheckForBlockaderRequest(int *spikeBeltRequest);
    void UpdateWingmanRole(Wingman_Role currentRole);
    void ClearTrafficToPurgatory();
    void ResetClearTrafficToPurgatory();
    void SetDesiredSpeed();
    void HighExecute();
    void HudOn(AIHigh_BTC_Perp *p, int a, Car_tObj *carObj);
};

struct AIHigh_Cop {   /* 108 bytes */
    AIHigh_BasicCop    _base_AIHigh_BasicCop;   /* +0x0 */
    AIHigh_Player      *perpTarget_;   /* +0x58 */
    int                forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_, aggressionLevel_;   /* +0x5C */
    AIHigh_Cop() {}
    AIHigh_Cop(Car_tObj *carObj, int idx);
    void SetTuningLevers();
    void HighExecute();
    int CheckForNeedyPlayers();
    void CheckForWipeOut();
    int CheckForNewTarget();
    void AssignToPlayer(AIHigh_Player *p);
    int GetCheckChasePosition(coorddef *pt);
    trigger_t *CheckForNewTriggers();
};

struct SPCHNFSType_POSITION {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_DISTANCE {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_COLOUR {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_ACCIDENT {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_AMBULANCE {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_PURS_UPDT {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_ARREST {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_vs_RDBLK_SSTRP {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_PERP_NAME {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_CONFIRM {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_SPIKE_BELT_SIDE {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_REVINTRO {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct CarBank {   /* 12 bytes */
    int                fFull, fMake, fModel;   /* +0x0 */
};

struct LocationBank {   /* 16 bytes */
    int                fStartSlice, fEndSlice, fBankId;   /* +0x0 */
    char               *fName;   /* +0xC */
};

struct CallSignBank {   /* 68 bytes */
    int                fAllUnits, fDispatch;   /* +0x0 */
    int                fMobile[15];   /* +0x8 */
};

struct tCarBankPair {   /* 216 bytes */
    CarBank            Mobile[9], Dispatch[9];   /* +0x0 */
};

struct tLocationBankPair {   /* 512 bytes */
    LocationBank       Mobile[16], Dispatch[16];   /* +0x0 */
};

struct tCallSignBankPair {   /* 136 bytes */
    CallSignBank       Mobile, Dispatch;   /* +0x0 */
};

struct Speaker {   /* 80 bytes */
    SPCHNFSType_POSITION fPosition;   /* +0x0 */
    SPCHNFSType_DISTANCE fDistance;   /* +0x4 */
    SPCHNFSType_COLOUR fColour;   /* +0x8 */
    SPCHNFSType_ACCIDENT fAccident;   /* +0xC */
    SPCHNFSType_AMBULANCE fAmbulance;   /* +0x10 */
    SPCHNFSType_vs_RDBLK_SSTRP fBlockade;   /* +0x14 */
    SPCHNFSType_REVINTRO fReverse;   /* +0x18 */
    SPCHNFSType_CONFIRM fConfirm;   /* +0x1C */
    SPCHNFSType_PERP_NAME fPerpName;   /* +0x20 */
    SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;   /* +0x24 */
    SPCHNFSType_PURS_UPDT fUpdate;   /* +0x28 */
    SPCHNFSType_ARREST fArrest;   /* +0x2C */
    int                fCar, fLocation, fFrom, fTo, fWing;   /* +0x30 */
    BOOL               fHavePerp;   /* +0x44 */
    Speaker            *fSub;   /* +0x48 */
    __vtbl_ptr_type      (*_vf)[31];   /* +0x4C */
};

struct Trk_SFX {   /* 16 bytes */
    int                point[3];   /* +0x0 */
    short              type, pad;   /* +0xC */
};

struct FLARE_PIECE_DEF {   /* 16 bytes */
    int                distance, size;   /* +0x0 */
    CVECTOR            color;   /* +0x8 */
    char               type;   /* +0xC */
};

#ifndef NFS4_PSYQ_HEADERS
struct POLY_GT4 {   /* 52 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             u0, v0;   /* +0xC */
    u_short            clut;   /* +0xE */
    u_char             r1, g1, b1, p1;   /* +0x10 */
    short              x1, y1;   /* +0x14 */
    u_char             u1, v1;   /* +0x18 */
    u_short            tpage;   /* +0x1A */
    u_char             r2, g2, b2, p2;   /* +0x1C */
    short              x2, y2;   /* +0x20 */
    u_char             u2, v2;   /* +0x24 */
    u_short            pad2;   /* +0x26 */
    u_char             r3, g3, b3, p3;   /* +0x28 */
    short              x3, y3;   /* +0x2C */
    u_char             u3, v3;   /* +0x30 */
    u_short            pad3;   /* +0x32 */
};
#endif

struct Draw_SubdivStruct {   /* 240 bytes */
    Draw_SVertex       v[15];   /* +0x0 */
};

struct Track_tArtresource {   /* 24 bytes */
    int                id;   /* +0x0 */
    char               *shapeFile;   /* +0x4 */
    int                shapeCount;   /* +0x8 */
    Draw_tPixMap       *pPmx;   /* +0xC */
    int                pmxCount, basePmxCount;   /* +0x10 */
};

struct Track_tMaterial {   /* 4 bytes */
    char               flag, mipmap_offset;   /* +0x0 */
    short              pmxIndex;   /* +0x2 */
};

struct AIState_Chase {   /* 148 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    AIDelayCar         delayCar_;   /* +0x8 */
    int                noTurnAroundEndTime_;   /* +0x44 */
    Car_tObj           *targetCar_;   /* +0x48 */
    coorddef           relPosition_;   /* +0x4C */
    int                longTargetRegion_, latTargetRegion_, targetDir_, carDir_, longMetersBetween_, latMetersBetween_, murderMode_, murderEndTime_, inTargetRegion_, nitrousTicks_, nitrousMinForeDistance_, nitrousMinAftDistance_, aggressionLevel_, slowDownEndTime_, barrierTicks32_;   /* +0x58 */
    AIState_Chase() {}
    AIState_Chase(Car_tObj *carObj, Car_tObj *target, coorddef *pt, int a, int b, int c, int d, int e);
    ~AIState_Chase();
    void SetTarget(Car_tObj *target, coorddef *pt);
    void SetMurderMode(int a, int b);
    void SetUp();
    void DoSlowNitrous();
    void DoNitrous(int a);
    void Execute();
    void FarTargeting();
    int CalculateCloseTargettingAheadSlowDownFactor();
    void CloseTargeting();
    void ApproachTargeting(int a);
    void CheckForBarriersAndTargetAroundThem();
    int FindBarrierEndSlice();
};

struct AIState_GotoSlice {   /* 16 bytes */
    AIState_Normal     _base_AIState_Normal;   /* +0x0 */
    int                targetSlice_, stopWhenArrivedAtSlice_;   /* +0x8 */
    AIState_GotoSlice() {}
    AIState_GotoSlice(Car_tObj *carObj, int a, int b);
    ~AIState_GotoSlice();
    void Execute();
    int InTargetSliceRange(int a);
};

struct AIHigh_BTC_Wingman {   /* 124 bytes */
    AIHigh_BTC_Cop     _base_AIHigh_BTC_Cop;   /* +0x0 */
    int                currentRole_, newRole_;   /* +0x64 */
    AIHigh_BTC_HumanCop *newHumanBoss_;   /* +0x6C */
    int                spikeBeltPlaced_, spikeBeltSlice_, spikeBeltInterceptReleaseTime_;   /* +0x70 */
    AIHigh_BTC_Wingman() {}
    AIHigh_BTC_Wingman(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_Wingman();
    void HighExecute();
    int CheckForActivation();
    int UpdateFreezeModeAndPullOverMode();
    void SetupWingman(AIHigh_BTC_HumanCop *humanCop);
    void SetupBlockader(AIHigh_BTC_HumanCop *humanCop, int spikeBeltRequest);
};

struct AIHigh_Traffic {   /* 36 bytes */
    AIHigh_Base        _base_AIHigh_Base;   /* +0x0 */
    int                ignoreCops_, forcePurgatory_;   /* +0x18 */
    SceneElem          *accidentData_;   /* +0x20 */
    AIHigh_Traffic() {}
    AIHigh_Traffic(Car_tObj *carObj);
    Car_tObj *CheckForCops(int *p);
    AIHigh_Cop *CopCheck(int *p);
    void HighExecute();
    trigger_t *CheckForNewTriggers();
};

struct TCB {   /* 192 bytes (PsyQ kernel) */
    long               status, mode;   /* +0x0 */
    u_long             reg[40];   /* +0x8 */
    long               system[6];   /* +0xA8 */
};

struct EXEC {   /* 60 bytes (PsyQ kernel) */
    u_long             pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size, s_addr, s_size, sp, fp, gp, ret, base;   /* +0x0 */
};

struct DIRENTRY {   /* 40 bytes (PsyQ kernel) */
    char               name[20];   /* +0x0 */
    long               attr, size;   /* +0x14 */
    DIRENTRY           *next;   /* +0x1C */
    long               head;   /* +0x20 */
    char               system[4];   /* +0x24 */
};

struct Skidmark_Segment {   /* 28 bytes */
    SVECTOR            svx[2];   /* +0x0 */
    CVECTOR            rgb;   /* +0x10 */
    int                type;   /* +0x14 */
    Skidmark_Segment   *next;   /* +0x18 */
};

struct Skidmark_Chunk {   /* 688 bytes */
    coorddef           cp;   /* +0x0 */
    short              n, slice;   /* +0xC */
    Skidmark_Segment   seg[24];   /* +0x10 */
};

struct AIHigh_BTC_HumanPerp {   /* 136 bytes */
    AIHigh_BTC_Perp    _base_AIHigh_BTC_Perp;   /* +0x0 */
    AIHigh_BTC_HumanPerp() {}
    ~AIHigh_BTC_HumanPerp();
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
};

struct AIHigh_BTC_AIPerp {   /* 172 bytes */
    AIHigh_BTC_Perp    _base_AIHigh_BTC_Perp;   /* +0x0 */
    int                perpMode_, creationTime_, madeContactTime_, timeUntilContact_, escapeDuration_, originalMass_, originalMassInv_;   /* +0x88 */
    Car_tObj           *closestCopCarObj_;   /* +0xA4 */
    int                closestCopCarDistanceMeters_;   /* +0xA8 */
    AIHigh_BTC_AIPerp() {}
    AIHigh_BTC_AIPerp(Car_tObj *carObj);
    ~AIHigh_BTC_AIPerp();
    void AvoidCops();
    void CalculateTimeTillContact();
    void FindClosestCop();
    void HighExecute();
    void NewStage(AIHigh_BTC_HumanCop *cop);
};

struct AITrigger_TriggerManager {   /* 844 bytes */
    int                numTriggers_, invNumTriggers_;   /* +0x0 */
    trigger_t          *triggers_[100];   /* +0x8 */
    int                checkTime_[100];   /* +0x198 */
    int                lastTriggerChecked_[9];   /* +0x328 */
    /* methods (aitriger.obj, GAME\COMMON\AITRIGER.CPP) -- non-virtual; layout unchanged */
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    int CheckForTriggerAtSlice(int car, int slice);
    trigger_t *GetTrigger(int trigger, int *used);
    int CheckForClosestTriggerOfType(int slice, triggerType type, int direction);
    void DescribeTrigger(trigger_t *trigger);
    void Sort();
};

struct AIHigh_Human {   /* 176 bytes */
    AIHigh_Player      _base_AIHigh_Player;   /* +0x0 */
    AIHigh_Human() {}
    AIHigh_Human(Car_tObj *carObj);
    ~AIHigh_Human();
    void HighExecute();
};

struct AIHigh_Opponent {   /* 192 bytes */
    AIHigh_Player      _base_AIHigh_Player;   /* +0x0 */
    int                attackMode_;   /* +0xB0 */
    Car_tObj           *lastHumanHitter_;   /* +0xB4 */
    int                hitCount_, attackTicksLeft_;   /* +0xB8 */
    AIHigh_Opponent() {}
    AIHigh_Opponent(Car_tObj *carObj);
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
};

struct tCopMurderThresholds {   /* 20 bytes */
    int                ticksInChaseRegionForMurder, minLatMetersDistanceForMurder, minLongMetersDistanceForMurder, murderTicks, nitrousTicks;   /* +0x0 */
};

struct AIState_Idle {   /* 16 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    int                roadPosition_, idleInPlaceFlag_;   /* +0x8 */
    AIState_Idle() {}
    ~AIState_Idle();
    void Execute();
    void SetIdlePosition(int pos);
};

struct AICop_spikeBelt_t {   /* 20 bytes */
    int                active_, slice_, leftLatPos_, rightLatPos_, freshenTime_;   /* +0x0 */
};

struct Udff_tInfo {   /* 12 bytes */
    int                type, handle;   /* +0x0 */
    char               *memPtr;   /* +0x8 */
};

struct AIPhysic_Config_t {   /* 108 bytes */
    int                latvelcalc_lookahead, min_lookahead, max_lookahead, look_ahead_factor, skid_value;   /* +0x0 */
    AIPhysic_ModelConfig_t ICModel, OOCModel;   /* +0x14 */
};

struct kernpair {   /* 8 bytes */
    u_short            previouscode, code;   /* +0x0 */
    char               kernvalue;   /* +0x4 */
    char               pad[3];   /* +0x5 */
};

struct AIDataRecord_TrackCurve_t {   /* 88 bytes */
    AIDataRecord_t     _base_AIDataRecord_t;   /* +0x0 */
    AIDataRecord_TrackCurve_t() {}
    AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_TrackCurve_t();
    int Get(int i);
};

struct AIDataRecord_CarTracking_t {   /* 88 bytes */
    AIDataRecord_t     _base_AIDataRecord_t;   /* +0x0 */
    AIDataRecord_CarTracking_t() {}
    ~AIDataRecord_CarTracking_t();
    int Get(int i);
};

struct AISpeeds_tLeaderBoard {   /* 16 bytes */
    Car_tObj           *leadRacer, *leadHumanRacer, *leadAIRacer, *lastAIRacer;   /* +0x0 */
};

struct AISpeeds_Upgrade_t {   /* 16 bytes */
    int                accMult, brakeMult, handlingMult, topSpeedMult;   /* +0x0 */
};

struct AISpeeds_tSlotInfo {   /* 16 bytes */
    int                distanceMaintainTime32, minDistanceMeters, maxDistanceMeters;   /* +0x0 */
    unsigned int       fallBackRandomTime_TickPercent;   /* +0xC */
};

struct speedData_t {   /* 4 bytes */
    u_short            endSlice, speedMPS;   /* +0x0 */
};

struct AIState_Offroad {   /* 104 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    int                startSlice_;   /* +0x8 */
    coorddef           startPosition_;   /* +0xC */
    matrixtdef         startOrientation_;   /* +0x18 */
    coorddef           startHeading_;   /* +0x3C */
    int                targetSlice_;   /* +0x48 */
    coorddef           targetPosition_;   /* +0x4C */
    int                longMetersBetween_, letGo_, maxSpeedMPS_, releaseTime_;   /* +0x58 */
    AIState_Offroad() {}
    AIState_Offroad(Car_tObj *carObj, int a, coorddef *pt, matrixtdef *mat, int b, int c, int d);
    ~AIState_Offroad();
    void UnleashIfInRange(Car_tObj *carObj);
    void Execute();
};

struct AIState_Purgatory {   /* 8 bytes */
    AIState_NonActive  _base_AIState_NonActive;   /* +0x0 */
    AIState_Purgatory() {}
    AIState_Purgatory(Car_tObj *carObj);
    ~AIState_Purgatory();
    int TestForRelease();
    void Execute();
    static void StartUp();
};

struct AIState_RovingTraffic {   /* 24 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    trigger_pathPosition_t *path_;   /* +0x8 */
    int                numPathPoints_, pathIndex_;   /* +0xC */
    long               waitTick_;   /* +0x14 */
    AIState_RovingTraffic() {}
    AIState_RovingTraffic(Car_tObj *carObj, trigger_t *trig);
    ~AIState_RovingTraffic();
    void CheckIfCarIsNearbyAndStop(Car_tObj *carObj, int &status);
    void Execute();
    int TestForRelease();
};

struct AIState_Donuts {   /* 16 bytes */
    AIState_Base       _base_AIState_Base;   /* +0x0 */
    int                donutLookForward_, donutMode_;   /* +0x8 */
    AIState_Donuts() {}
    ~AIState_Donuts();
    void Execute();
};

struct AIState_Cruise {   /* 20 bytes */
    AIState_Normal     _base_AIState_Normal;   /* +0x0 */
    int                cruiseMode_, cruiseSpeed_, cruiseFactor_;   /* +0x8 */
    AIState_Cruise() {}
    AIState_Cruise(Car_tObj *carObj, cruiseMode_t mode, int a);
    ~AIState_Cruise();
    void Execute();
};

struct accelscale_t {   /* 4 bytes */
    int                scale;   /* +0x0 */
};

struct copTuning_t {   /* 16 bytes */
    int                regularCopAccMultiplier, superCopAccMultiplier, regularCopTopSpeedCap, superCopTopSpeedCap;   /* +0x0 */
};

struct AITune_tTrackInfo {   /* 12 bytes */
    int                oneWay, driveSide, roughLapTimeSeconds;   /* +0x0 */
};

struct AITune_BTC_t {   /* 28 bytes */
    int                glueMult, speedMult, weightMult, baseChaseTime, wingmanTime, blockaderTime, spikeBeltTime;   /* +0x0 */
};

struct tQuat {   /* 8 bytes */
    short              x, y, z, w;   /* +0x0 */
};

struct Trk_AnimateBoomInst {   /* 16 bytes */
    short              size;   /* +0x0 */
    u_char             type, objectIndex, zoffset, flags;   /* +0x2 */
    short              pad, count, interval;   /* +0x6 */
    u_char             simIndex, boomIndex;   /* +0xC */
    short              pad2;   /* +0xE */
};

struct Anim_tFrame {   /* 20 bytes */
    long               x, y, z;   /* +0x0 */
    short              qx, qy, qz, qw;   /* +0xC */
};

struct SNDSYSCAP {   /* 12 bytes */
    u_short            outputratemin, outputratemax;   /* +0x0 */
    u_char             outputchannelsmin, outputchannelsmax, inputvoicesmax, input3dvoicesmax, eax, voicemanager;   /* +0x4 */
    char               pad[2];   /* +0xA */
};

struct SNDSYSSET {   /* 44 bytes */
    u_short            maxbanks, outputrate;   /* +0x0 */
    u_char             outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;   /* +0x4 */
    char               pad;   /* +0x9 */
    u_short            emulationsubtype;   /* +0xA */
    u_short            spkrcfg3d[4][4];   /* +0xC */
};

struct SNDSYSVEC {   /* 4 bytes */
    void               *issurfacelocked;   /* +0x0 */
};

struct SNDSAMPLEFORMAT {   /* 4 bytes */
    u_short            samplerate;   /* +0x0 */
    u_char             channels, samplerep;   /* +0x2 */
};

struct AudioClc_tSource {   /* 56 bytes */
    Car_tObj           *car;   /* +0x0 */
    int                distToCamera, dopplerShift, relVelocity, gameTicks, distSq, frequency, channel, horn, hornOn, hornOff, hornCount, pursuit, yelled;   /* +0x4 */
};

struct AudioClc_tPlayer {   /* 80 bytes */
    int                cameraMode, gameTicks, warnings;   /* +0x0 */
    coorddef           lastview;   /* +0xC */
    AudioClc_tSource   source;   /* +0x18 */
};

struct AudioClc_tCLCache {   /* 8 bytes */
    Car_tObj           *ptr;   /* +0x0 */
    int                dst;   /* +0x4 */
};

struct SNDPLAYOPTS {   /* 20 bytes */
    int                patnum;   /* +0x0 */
    char               bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;   /* +0x4 */
    u_short            pitchmult, timemult, azimuth;   /* +0xC */
    short              elevation;   /* +0x12 */
};

struct SndBnk_t {   /* 12 bytes */
    int                bnkID;   /* +0x0 */
    char               *phdr, *pdata;   /* +0x4 */
};

struct Channels_t {   /* 8 bytes */
    int                Partial, SFXnum;   /* +0x0 */
};

struct AudioMus_tSongEntry {   /* 64 bytes */
    char               *filename, *title, *artist, *label, *date, *notes;   /* +0x0 */
    int                length, index;   /* +0x18 */
    char               strbuf[32];   /* +0x20 */
};

struct tTexture_ShapeInfo {   /* 32 bytes */
    shapetbl           *shpptr;   /* +0x0 */
    long               clutID;   /* +0x4 */
    char               depth;   /* +0x8 */
    u_long             type : 8;   /* +0x9 bit 0 */
    long               next : 24;   /* +0xC bit 0 */
    short              width, height, centerx, centery, shapex, shapey;   /* +0x10 */
    u_short            tpage, clut;   /* +0x1C */
};

struct tMenu {   /* 108 bytes */
    unsigned int       fFlags;   /* +0x0 */
    short              fTitle;   /* +0x4 */
    int                fCurrentItem;   /* +0x8 */
    BOOL               fNeverAnyEnabled;   /* +0xC */
    tMenuItem          *fItemList[16];   /* +0x10 */
    tScreen            *fScreen;   /* +0x50 */
    tMenu              *fNextMenu, *fChildMenu, *fOptionsMenu;   /* +0x54 */
    void               *fOnButtonPress;   /* +0x60 */
    short              VertHelp;   /* +0x64 */
    __vtbl_ptr_type      (*_vf)[11];   /* +0x68 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tMenu() {}
    void tMenuConstructor(tMenuItem *firstItem, void *ap);
    tMenu(unsigned int flags, tScreen *screenHandler, tMenu *nextMenu, tMenu *optionsMenu, void (*OnButtonPress)(tMenuCommand&), short title);
    ~tMenu();
    void Initialize();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    short GetNumberEnabledItems();
    void Draw();
    void UpdateTransition();
    void TransitionOff();
    void TransitionOn();
    void *TransitionIsFinished();
    void *IsSubMenu();
    long DebounceKeys();

};

struct tListIterator {   /* 16 bytes */
    short              *fSelectionList;   /* +0x0 */
    char               *fValue;   /* +0x4 */
    char               fMinValue, fMaxValue;   /* +0x8 */
    __vtbl_ptr_type      (*_vf)[6];   /* +0xC */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tListIterator() {}
    tListIterator(short *selection, char *valPtr);
    ~tListIterator();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);

};

struct tListIteratorRange : public tListIterator {   /* 16 bytes */
    tListIteratorRange() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tListIteratorRange(char minValue, char maxValue, char *valPtr);
    ~tListIteratorRange();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tMenuItem {   /* 28 bytes */
    tMenuItem() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    unsigned int       fFlags, fTextDescription;   /* +0x0 */
    short              fSelFade;   /* +0x8 */
    int                fButtonImage, fNumFrames;   /* +0xC */
    tMenu              *fNewMenu;   /* +0x14 */
    __vtbl_ptr_type      (*_vf)[11];   /* +0x18 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tMenuItem(unsigned int textDescription);
    ~tMenuItem();
    long DebounceKeys();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void UpdateTransition(bool selected);
    void *TransitionIsFinished();
    void UpdateSelFade(bool selected);
    int Draw(int x, int y, bool selected);
    int Draw(int x, int y, int w, bool selected);
    void TransitionOn();    /* @0x80025aa8  empty base virtual (overridden by tMenu); surfaced by #75 vtable mat */
    void TransitionOff();   /* @0x80025ab0  empty base virtual (overridden by tMenu); surfaced by #75 vtable mat */

};

struct tMenuItemInteractive {   /* 28 bytes */
    tMenuItemInteractive() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItem          _base_tMenuItem;   /* +0x0 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tMenuItemInteractive(unsigned int textDescription);
    ~tMenuItemInteractive();

};

struct tCarInfo {   /* 204 bytes */
    char               fCarID;   /* +0x0 */
    u_char             fSimNumber, fCarClass, fABSAvailable, fDefaultColor, fCopClass, fDefaultTires, fAvailable;   /* +0x1 */
    char               fShapeName[8], fSmallName[8], fQTVRName[8];   /* +0x8 */
    long               fPrices[4];   /* +0x20 */
    u_char             fStats[4][5];   /* +0x30 */
    u_long             fColorList[16];   /* +0x44 */
    u_char             fSpeechColors[16];   /* +0x84 */
    u_long             fHudColor[2];   /* +0x94 */
    char               fDayTachFile[8], fNightTachFile[8];   /* +0x9C */
    char               fNumLightColors, fNumDarkColors;   /* +0xAC */
    u_char             fCountries;   /* +0xAE */
    char               fColorOrder[16];   /* +0xAF */
    u_char             fPursuitAvailable, fEnginePatch;   /* +0xBF */
    char               fSpeechCarID;   /* +0xC1 */
    u_char             fTractionAvailable, fExoticCar, fUpgrades, fColor, fViewable, fCountry, fCarIndex;   /* +0xC2 */
    u_char             fReserved[3];   /* +0xC9 */
};

struct tOwnedCarInfo {   /* 4 bytes */
    char               fCarID;   /* +0x0 */
    u_char             fUpgrades, fCarColor, fPad;   /* +0x1 */
};

struct tCarManager {   /* 908 bytes */
    u_long             fNumCars;   /* +0x0 */
    tCarInfo           *fCars;   /* +0x4 */
    tOwnedCarInfo      fCarGarage[2][32], fPinkSlipsCars[2][32];   /* +0x8 */
    u_char             fAvailableCars[48], fViewableCars[48];   /* +0x208 */
    u_char             fPinkSlipsAvailableCars[2][48], fPinkSlipsViewableCars[2][48];   /* +0x268 */
    short              fCarTextList[49];   /* +0x328 */
    /* reconstructed member fns (FECheats.obj cross-refs; ABI-neutral) */
    void SetClassAvailable(tCarClassType carClass, bool avail);

    /* FECars methods */
    void Initialize();
    tCarInfo * GetCarFromID(short carID);
    tCarInfo * GetCarFromSimID(short carID);
    long CheapestCarStockPrice();
    long CalcUsedPrice(short garageNumber);
    long PurchaseCar(short carModel,short color,short playerNum);
    long SellCar(short garageNumber,short playerNum);
    long PurchaseUpgrade(short garageNumber,short upgradeFlags,short playerNum);
    void RemoveFromPinkSlipsList(short garageNumber,short playerNum);
    void AddToPinkSlipsList(short carModel,short color,short playerNum);
    void AddUpgradesToPinkSlipsList(short garageNumber,short upgradeFlags,short playerNum);
    void LoadCars(tSaveCarInfo &load,short playerNum);
    void SaveCars(tSaveCarInfo &save);
    void LoadPinkSlipsCars(tSaveCarInfo &load,short playerNum);
    void SavePinkSlipsCars(tSaveCarInfo &save,short playerNum,short withoutCarInGarageNumber);
    void SetCarAvailable(tCarModels carModel,bool avail);
    void SetClassViewable(tCarClassType carClass,bool view_flag);
    void SetCarViewable(tCarModels carModel,bool view);
    void GetStockCar(short carNumber,tCarInfo &carInfo);
    void GetGarageCar(short garageNumber,tCarInfo &carInfo,short playerNum);
    void GetPinkSlipsCar(short garageNumber,tCarInfo &carInfo,short playerNum);
    void LoadDescription();
    void ReleaseDescription();
    short GetNumOwnedCars(short playerNum);
    short GetNumTourneyCars(short playerNum);
    short GetNumPinkSlipsCars(short playerNum);
    short GetClassList(tCarClassType carClass,short numElements,tCarModels *models);
    void InitializeIngameCarList();
    void * IsCarAnAddedModel(tCarModels &model,char &color);
    void AddCarToIngameList(tCarModels &model,char &color);
    int FindSimilarCar(tCarModels &model,char &color,short arg3,tCarModels *arg4);

};

struct tfrontEnd {   /* 1104 bytes */
    short              randomSeed;   /* +0x0 */
    char               currentPlayer, gameMode, raceType, style, skillLevel, catchup, ghostcar, tractionassist, bestline;   /* +0x2 */
    short              pinkSlipsWinner[5];   /* +0xC */
    char               timeOfDay[5], weather[5];   /* +0x16 */
    char               fog, localSpeech, opponentUpgrades;   /* +0x20 */
    char               track[5];   /* +0x23 */
    int                recordlaptime;   /* +0x28 */
    char               laps;   /* +0x2C */
    char               lapind[5], trackdirection[5], trackmirrored[5], traffic[5], situations[5];   /* +0x2D */
    char               pinkSlipsTrackIndex, pinkSlipsNumTracks;   /* +0x46 */
    char               pinkSlipsWins[2];   /* +0x48 */
    long               pinkSlipsCash[2];   /* +0x4C */
    short              cheatFlags, cheatFlagsActive, secretFlags, pinkSlipsForfeit;   /* +0x54 */
    char               playerCar[2], transmission[2];   /* +0x5C */
    char               carColors[2][48], carCountry[2][48];   /* +0x60 */
    char               tournament, specialevent, tier;   /* +0x120 */
    char               garageCar[2], pinkSlipsCar[2];   /* +0x123 */
    char               upgrade, dealerCar, sellerCar, carListType, policeTier, policeMission, congratsCopCar, congratsCopCountry;   /* +0x127 */
    short              settingsActive[2];   /* +0x130 */
    char               steeringSensitivity[2][48], tireType[2][48], suspension[2][48], carDownforce[2][48], engineTuning[2][48];   /* +0x134 */
    char               ABS[2];   /* +0x314 */
    char               damage;   /* +0x316 */
    char               rampSteer[2], rampGas[2], rampBrake[2];   /* +0x317 */
    char               oppCar, oppNumber, measurement;   /* +0x31D */
    char               displaySpeed[2], displayTach[2], displayMap[2], displayOpponentID[2], displayTime[2], displayPosition[2], displayLapNumber[2], displayMirror[2];   /* +0x320 */
    char               cameraType[2][4], cameraSway[2][4];   /* +0x330 */
    char               language, musicVolume, sfxVolume, narrationVolume, engineVolume, ambientVolume, audioMode, song, sensitivity;   /* +0x340 */
    char               steeringRange[2], deadSpot[2], ImaxRange[2], IImaxRange[2], J1MAX[2], J1MIN[2], J2MAX[2], J2MIN[2], shockMode[2], shockImpact[2];   /* +0x349 */
    short              controlType[2];   /* +0x35E */
    char               controlConfig[2];   /* +0x362 */
    char               playerNameList[2][8], allUpperCasedPlayerNameList[2][8], licensePlate[2][8];   /* +0x364 */
    char               headstart, numBTracksActivated, checkPointType;   /* +0x394 */
    char               checkPointDisplay[2], defaultedPlayerName[2];   /* +0x397 */
    BOOL               FEPlayList[40];   /* +0x39C */
    u_long             gPinkSlipsNoCheat[2];   /* +0x43C */
    BOOL               GotAPlayList;   /* +0x444 */
    BOOL               AnalogOn[2];   /* +0x448 */
};

struct CopSpeak_tRequest {   /* 32 bytes */
    Car_tObj           *car;   /* +0x0 */
    int                buffer, offset, size, filehandle, ophandle, phrase;   /* +0x4 */
    char               player, sfx, bank, noise;   /* +0x1C */
};

struct AudioCmn_tReTrig {   /* 32 bytes */
    int                count, pan;   /* +0x0 */
    short              delay, nextd;   /* +0x8 */
    int                patch;   /* +0xC */
    char               bend, amp;   /* +0x10 */
    coorddef           pos;   /* +0x14 */
};

struct AudioCmn_tAsyncSfxSlot {   /* 24 bytes */
    int                bank, patch, handle, ticks, addr;   /* +0x0 */
    char               *header;   /* +0x14 */
};

struct AudioMus_tCurrentSong {   /* 76 bytes */
    int                newsong, index, remaining;   /* +0x0 */
    AudioMus_tSongEntry info;   /* +0xC */
};

struct AudioMus_tSongList {   /* 8 bytes */
    int                numsongs, currentsong;   /* +0x0 */
    AudioMus_tSongEntry song[0];   /* +0x8 */
};

struct SNDREQUESTSTATUS {   /* 16 bytes */
    int                state, currenttime, timetoend, timebuffered;   /* +0x0 */
};

struct SNDSTREAMSTATUS {   /* 12 bytes */
    int                outstandingrequests, currentrequest, timebuffered;   /* +0x0 */
};

struct SNDLIMITS {   /* 20 bytes */
    int                dmabuflen;   /* +0x0 */
    u_char             numdmabufs, numdmamsgs, nummicrotalkinstances, microtalkinstanceabort;   /* +0x4 */
    short              numrspcmds, pad;   /* +0x8 */
    int                audiostreambufsize, packetbufsize;   /* +0xC */
};

struct CdlLOC {   /* 4 bytes (PsyQ libcd) */
    u_char             minute, second, sector, track;   /* +0x0 */
};

struct AudioMus_tMusicGlobals {   /* 344 bytes */
    int                volume, totalsongs, availablesongs, requestsong, firstswitch, switchsong, newswitch, failby, errorcode, fadetime, randomize;   /* +0x0 */
    char               *songname;   /* +0x2C */
    char               title64[64];   /* +0x30 */
    char               *streambuffer;   /* +0x70 */
    int                streamhandle, requesthandle, serveractive, driveractive, greedy, threshold;   /* +0x74 */
    char               *bigfileheader;   /* +0x8C */
    SNDSTREAMSTATUS    streamstatus;   /* +0x90 */
    SNDREQUESTSTATUS   requeststatus;   /* +0x9C */
    char               bigfilename[64];   /* +0xAC */
    char               playlist[32];   /* +0xEC */
    AudioMus_tCurrentSong current;   /* +0x10C */
};

struct CAudioList {   /* 16 bytes */
    int                id_, numElements_, slice_, versionNumber_;   /* +0x0 */
};

struct AudioEng_tEvent {   /* 16 bytes */
    char               use, patnum, pad1, pad2;   /* +0x0 */
    short              delta, max;   /* +0x4 */
    int                attackdelta, decaydelta;   /* +0x8 */
};

struct AudioEng_tTable {   /* 512 bytes */
    char               xlate[512];   /* +0x0 */
};

struct AudioEng_tDef {   /* 360 bytes */
    int                id;   /* +0x0 */
    char               ver, resolved, startevent, controllerpercent;   /* +0x4 */
    short              lowrandomtargetlevel, lowrandomtargetrange;   /* +0x8 */
    int                lowrandomattacktime, lowrandomattackrange;   /* +0xC */
    short              highrandomtargetlevel, highrandomtargetrange;   /* +0x14 */
    int                highrandomattacktime, highrandomattackrange;   /* +0x18 */
    char               patchnum[8];   /* +0x20 */
    AudioEng_tEvent    event[16];   /* +0x28 */
    AudioEng_tTable    *pvoltable[8], *pbendtable[8];   /* +0x128 */
};

struct AudioEng_tChanAttr {   /* 12 bytes */
    short              min, max;   /* +0x0 */
    char               *xlate;   /* +0x4 */
    char               patchnum;   /* +0x8 */
};

struct AudioEng_tAdjustments {   /* 8 bytes */
    u_char             inCarBoost, inCarExhaust, outCarExhaust, fwdEngBoost, rwdExhBoost, outCarBoost, pitchScale, timbreScale;   /* +0x0 */
};

struct AudioEng_tVoiceAttr {   /* 12 bytes */
    char               vol;   /* +0x0 */
    u_short            pitch, azim;   /* +0x2 */
    int                handle;   /* +0x8 */
};

struct AudioEng_tState {   /* 12 bytes */
    u_short            vol, dop, azi, sep, esp;   /* +0x0 */
    u_char             exh, gas;   /* +0xA */
};

struct AudioEng_t {   /* 880 bytes */
    AudioEng_tAdjustments adjust;   /* +0x0 */
    int                tick;   /* +0x8 */
    int                vol[16];   /* +0xC */
    int                azi, sep, dop;   /* +0x4C */
    char               bhandle, pad;   /* +0x58 */
    AudioEng_tState    queue[16];   /* +0x5A */
    char               setpos, plypos;   /* +0x11A */
    AudioEng_tChanAttr chan[16];   /* +0x11C */
    AudioEng_tVoiceAttr left[16], right[16];   /* +0x1DC */
    char               delay[16];   /* +0x35C */
    char               *tables;   /* +0x36C */
};

struct AudioElem {   /* 24 bytes */
    coorddef           cp;   /* +0x0 */
    u_short            nextDelay;   /* +0xC */
    char               patchID, fadeIn;   /* +0xE */
    short              range;   /* +0x10 */
    char               minDelay, randomDelay, type, chan, minRepeat, randomRepeat;   /* +0x12 */
};

struct AudioTrk_tAmbientChannel {   /* 16 bytes */
    AudioElem          *se;   /* +0x0 */
    int                handle, slice;   /* +0x4 */
    short              patch, repeat;   /* +0xC */
};

struct AudioTrk_tGlobals {   /* 256 bytes */
    AudioTrk_tAmbientChannel chan[16];   /* +0x0 */
};

struct DRender_tView {   /* 140 bytes */
    int                id, player;   /* +0x0 */
    DRender_tCalcView  cview;   /* +0x8 */
};

struct Draw_DCache {   /* 220 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
    MATRIX             matB, matNight, matCop, identMat;   /* +0x14 */
    int                otz;   /* +0x94 */
    VECTOR             tVn0, tVn1, tVn2, tVn3;   /* +0x98 */
    short              light, doublelayer;   /* +0xD8 */
};

struct Chunk {   /* 112 bytes */
    RelCoord16         boundPts[4], chunkboundPts[4];   /* +0x0 */
    u_char             quadCounts[6];   /* +0x20 */
    u_char             pad[2];   /* +0x26 */
    Trk_Quad           *renderQuads[4];   /* +0x28 */
    Group              *stripBuf, *lorezstripBuf, *objInstanceBuf, *objSpecialInstanceBuf, *simSliceBuf, *simQuadBuf, *simObjBuf, *sfxBuf, *lineBuf, *objVertexBuf, *objQuadBuf, *objQuadInstanceBuf;   /* +0x38 */
    short              firstSimSliceInd, chunkInd;   /* +0x68 */
    Group              *vertexBuf;   /* +0x6C */
    /* container ctor as a real member (non-virtual -> no layout change; def in
       chunk.cpp). Oracle symbol = method-form InstanceGroup__5Chunk...; flattened
       free-fn would mangle __FP5Chunk... and never match (§3.23b). */
    void InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem);
};

struct BW_tContextMgr {   /* 320 bytes */
    int                initialized, count;   /* +0x0 */
    BW_tContext        contexts[2];   /* +0x8 */
};

struct tBuildEntry {   /* 4 bytes */
    short              chunkInd;   /* +0x0 */
    char               geomRez, enableBits;   /* +0x2 */
};

struct CHorizonSpec {   /* 48 bytes */
    int                mirror, angle, yoffset, height;   /* +0x0 */
    CVECTOR            frontColor[2], backColor[2];   /* +0x10 */
    char               ringPMX[16];   /* +0x20 */
};

struct CSkySpec {   /* 148 bytes */
    int                type, flags;   /* +0x0 */
    CVECTOR            frontcolors[5], backcolors[5];   /* +0x8 */
    CVECTOR            clearcolor;   /* +0x30 */
    int                sunAngleInSky, sunHeightInSky, moonAngleInSky, moonHeightInSky, numStars, starAngleLow, starAngleHigh, starBrightMin, starBrightMax;   /* +0x34 */
    CVECTOR            starBaseColor;   /* +0x58 */
    int                starRandomSeed;   /* +0x5C */
    CVECTOR            sunBeamColor, sunHaloColor;   /* +0x60 */
    int                yoffset;   /* +0x68 */
    char               cloudIndices[5][4];   /* +0x6C */
    int                ringAngles[5];   /* +0x80 */
};

struct CNightSpec {   /* 4 bytes */
    CVECTOR            nightcolor;   /* +0x0 */
};

struct CWeatherSpec {   /* 8 bytes */
    int                type, intensity_limit;   /* +0x0 */
};

struct CFogSpec {   /* 16 bytes */
    int                contrast;   /* +0x0 */
    CVECTOR            color;   /* +0x4 */
    int                start, dist2base;   /* +0x8 */
};

struct CDepthCueSpec {   /* 8 bytes */
    CVECTOR            color;   /* +0x0 */
    int                distance;   /* +0x4 */
};

struct CWorldColor {   /* 16 bytes */
    int                contrast;   /* +0x0 */
    CVECTOR            contrast_color;   /* +0x4 */
    short              worldR, worldG, worldB, type;   /* +0x8 */
};

struct Trk_NewSlice {   /* 32 bytes */
    int                center[3];   /* +0x0 */
    char               normal[3], forward[3], right[3];   /* +0xC */
    u_char             acousticType;   /* +0x15 */
    short              pavedProfile, leftDrive, rightDrive;   /* +0x16 */
    u_char             chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;   /* +0x1C */
};

struct tNormalCacheEntry {   /* 32 bytes */
    short              sliceInd;   /* +0x0 */
    u_char             triangleFlag;   /* +0x2 */
    char               quadInd;   /* +0x3 */
    coorddef           normal, forward;   /* +0x4 */
    u_long             accessTime;   /* +0x1C */
};

struct camera_info {   /* 272 bytes */
    BO_tNewtonObj      *anchor, *target;   /* +0x0 */
    coorddef           position, relpos, audioPos;   /* +0x8 */
    int                TVHeight;   /* +0x2C */
    matrixtdef         rotation;   /* +0x30 */
    int                twist;   /* +0x54 */
    coorddef           wallLeft, wallRight;   /* +0x58 */
    short              mode, camNum;   /* +0x70 */
    char               modechange : 1;   /* +0x74 bit 0 */
    char               pitch : 1;   /* +0x74 bit 1 */
    char               jostling : 1;   /* +0x74 bit 2 */
    char               tracking : 1;   /* +0x74 bit 3 */
    char               checkwalls : 1;   /* +0x74 bit 4 */
    char               noLookBack : 1;   /* +0x74 bit 5 */
    char               checkcollisions : 1;   /* +0x74 bit 6 */
    char               splitscreen : 1;   /* +0x74 bit 7 */
    char               intransition, tumbling;   /* +0x75 */
    char               direction : 1;   /* +0x77 bit 0 */
    char               zooming : 2;   /* +0x77 bit 1 */
    char               inCar : 1;   /* +0x77 bit 3 */
    short              circleCounter, circleAngle;   /* +0x78 */
    char               animNum, animHandle, splineMode;   /* +0x7C */
    int                forceFocus;   /* +0x80 */
    char               focusOnAICar;   /* +0x84 */
    int                POInhibitor;   /* +0x88 */
    BWorldSm_Pos       slicePos;   /* +0x8C */
};

struct camera_flags {   /* 16 bytes */
    coorddef           arm;   /* +0x0 */
    int                pitch : 1;   /* +0xC bit 0 */
    int                jostling : 1;   /* +0xC bit 1 */
    int                tracking : 1;   /* +0xC bit 2 */
    int                checkwalls : 1;   /* +0xC bit 3 */
    int                noLookBack : 1;   /* +0xC bit 4 */
    int                checkcollisions : 1;   /* +0xC bit 5 */
};

struct Camera_tCamSlot {   /* 32 bytes */
    char               mode;   /* +0x0 */
    char               track : 1;   /* +0x1 bit 0 */
    char               zoom : 2;   /* +0x1 bit 1 */
    char               splineMode : 3;   /* +0x1 bit 3 */
    short              fov;   /* +0x2 */
    coorddef           pos;   /* +0x4 */
    int                height, splineOffset;   /* +0x10 */
    COORD16            euler;   /* +0x18 */
    short              slice;   /* +0x1E */
};

struct SimpleMem {   /* 12 bytes */
    void               *heap, *freeMem;   /* +0x0 */
    int                freeMemSize;   /* +0x8 */
    /* allocator methods (non-virtual -> no layout change; defs simplemem.cpp).
       Oracle = method-form __9SimpleMem...; flattened free-fn never matches (§3.23b). */
    void *Alloc(int len, int feign);
    void *FeignAlloc(int len);
    void  ResizeToFit();
};

struct SerializedGroup {   /* 16 bytes */
    int                m_type, m_length, dummy, m_num_elements;   /* +0x0 */
    /* container methods (non-virtual -> no layout change; defs in group.cpp).
       Oracle symbols are method-form `Name__15SerializedGroup...`, so these MUST
       be real members, not flattened free-fns. */
    SerializedGroup *LocateNextGroupType(int type);
    SerializedGroup *LocateGroupType(int type, int index);
    SerializedGroup *LocateGroupNum(int index);
    void            *LocateCreateGroupType(int type, SimpleMem *mem, int index);
    Group           *CreateLiteGroup(SerializedGroup *source, SimpleMem *mem);
    Group           *CreateLiteGroupDataSize(SerializedGroup *source, SimpleMem *mem, int dataSize);
};

struct Trk_SimpleInst {   /* 20 bytes */
    short              size;   /* +0x0 */
    u_char             type, objectIndex, zoffset, flags;   /* +0x2 */
    short              pad;   /* +0x6 */
    int                x, y, z;   /* +0x8 */
};

struct Clock_tGameClock {   /* 12 bytes */
    int                time128Hz, time64Hz, time32Hz;   /* +0x0 */
};

struct Object_tSimObjList {   /* 16 bytes */
    int                numObjects, chunk, numObjects2, chunk2;   /* +0x0 */
};

struct HudPmx_tShape {   /* 20 bytes */
    Draw_tPixMap       pixmap;   /* +0x0 */
    short              width, height;   /* +0x10 */
};

struct HudPmx_tUV {   /* 4 bytes */
    u_char             u0, v0;   /* +0x0 */
    u_short            clut;   /* +0x2 */
};

struct SPCHNFSType_vs_KMH_MPH {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct SPCHNFSType_VOICE {   /* 4 bytes */
    u_long             flags;   /* +0x0 */
};

struct CarBankName {   /* 12 bytes */
    char               *fFull, *fMake, *fModel;   /* +0x0 */
};

struct Speech {   /* 932 bytes */
    tCarBankPair       fCarBank;   /* +0x0 */
    tLocationBankPair  fLocationBank;   /* +0xD8 */
    tCallSignBankPair  fCallSignBank;   /* +0x2D8 */
    int                fLocationCount;   /* +0x360 */
    BOOL               fFileOpen;   /* +0x364 */
    int                fFileHandle;   /* +0x368 */
    long               *fBankOffset;   /* +0x36C */
    int                fBankCount, fBlpClpBank, fStaticBank, fCarCount, fCopCount, fSuperCount, fMultiplePerps;   /* +0x370 */
    Car_tObj           *fSpeakerCar;   /* +0x38C */
    MobileSpeaker      *fMobile[4];   /* +0x390 */
    DispatchSpeaker    *fDispatch;   /* +0x3A0 */
};

struct MobileSpeaker {   /* 104 bytes */
    Speaker            _base_Speaker;   /* +0x0 */
    SPCHNFSType_VOICE  fVoice;   /* +0x50 */
    SPCHNFSType_vs_KMH_MPH fSpeedType;   /* +0x54 */
    int                fSpeed, fUnit;   /* +0x58 */
    Car_tObj           *fCarObj, *fPerp;   /* +0x60 */
};

struct DispatchSpeaker {   /* 100 bytes */
    Speaker            _base_Speaker;   /* +0x0 */
    int                fStatusCount;   /* +0x50 */
    Speaker            *fStatusSub;   /* +0x54 */
    int                fUpdateCount;   /* +0x58 */
    Car_tObj           *fPerp[2];   /* +0x5C */
};

struct Speech_tCarDescription {   /* 16 bytes */
    char               *game, *full, *make, *model;   /* +0x0 */
};

struct Speech_tLocationDescription {   /* 8 bytes */
    char               *name;   /* +0x0 */
    short              start, end;   /* +0x4 */
};

struct Speech_tCallSignDescription {   /* 84 bytes */
    char               *AllUnits;   /* +0x0 */
    char               *Dispatch[5];   /* +0x4 */
    char               *Mobile[15];   /* +0x18 */
};

struct Speech_tMobileVoiceAttr {   /* 8 bytes */
    int                voice, pitch;   /* +0x0 */
};

struct CopSpeak_tFileIndex {   /* 8 bytes */
    long               offset, size;   /* +0x0 */
};

struct CopSpeak_tBankHeader {   /* 8 bytes */
    int                id;   /* +0x0 */
    u_char             ver;   /* +0x4 */
};

struct CopSpeak_tBank {   /* 16 bytes */
    int                FileHandle, FileOpen;   /* +0x0 */
    CopSpeak_tFileIndex *Index;   /* +0x8 */
    int                Count;   /* +0xC */
};

struct dashhud_info {   /* 108 bytes */
    int                splitscreen;   /* +0x0 */
    char               name[9];   /* +0x4 */
    int                conversion, flashtime, flashlap;   /* +0x10 */
    int                showhud[2], showmap[2], wrongway[2];   /* +0x1C */
    int                laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed, position, opponents, record, tutor;   /* +0x34 */
    int                warning[2];   /* +0x64 */
};

struct FEI_tList {   /* 8 bytes */
    int                v;   /* +0x0 */
    int                *p;   /* +0x4 */
};

struct GameSetup_tData {   /* 2600 bytes */
    int                raceType, numLaps, skill, commMode, tournamentMultiplier, cops, trafficDensity, localCar, catchupLogic, replayMode, instantReplay, mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment, song, Weather, Fog, Damage, Time, randSeed, easter;   /* +0x0 */
    GameSetup_tControllerData controllerData;   /* +0x60 */
    int                pinkSlipsForfeit, checkpointType;   /* +0xB8 */
    int                checkpointHUD[2];   /* +0xC0 */
    int                dispatchSpeech, reverseCallSpeech, languageSpeech, SceneNumber, SceneStartLap, SceneEndLap;   /* +0xC8 */
    GameSetup_tUserSetting userSetting;   /* +0xE0 */
    int                numPerps, stageOffset, perpArrests, finalPerpArrests;   /* +0x1AC */
    GameSetup_tPerpData perpInfo[10];   /* +0x1BC */
    int                numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;   /* +0x3C4 */
    GameSetup_tCarData carInfo[9];   /* +0x3D4 */
};

struct Input_tResults {   /* 4 bytes */
    char               steering;   /* +0x0 */
    u_char             gas, brake, flags;   /* +0x1 */
};

struct tPMenuCommand {   /* 8 bytes */
    int                type;   /* +0x0 */
    tPMenu             *nextMenu;   /* +0x4 */
};

struct tPMenu {   /* 84 bytes */
    int                fCurrentItem;   /* +0x0 */
    BOOL               fHighlight;   /* +0x4 */
    tPMenuItem         *fItemList[16];   /* +0x8 */
    tPMenu             *fNextMenu;   /* +0x48 */
    int                fNumItems;   /* +0x4C */
    __vtbl_ptr_type      (*_vf)[5];   /* +0x50 */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenu() {}
    void tPMenuConstructor(tPMenuItem *firstItem, void *ap);
    tPMenu(tPMenuItem *firstItem, ...);
    ~tPMenu();
    void Initialize();
    void *Debounce();
    void CheckForDisabled();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
    void Draw();
    int NumEnabledItems();
    int ItemEnabledNum(int num);
};

struct tPListIterator {   /* 12 bytes */
    short              *fSelectionList;   /* +0x0 */
    int                *fValue;   /* +0x4 */
    __vtbl_ptr_type      (*_vf)[6];   /* +0x8 */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPListIterator() {}
    tPListIterator(short *selection, int *valPtr);
    ~tPListIterator();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);
};

struct tPListIteratorIndexed : public tPListIterator {   /* 16 bytes; §3.23 real inheritance (base @+0x0, non-polymorphic) */
    char               *fIndex;   /* +0xC */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPListIteratorIndexed(short *selection, int *valPtr, char *index);
    ~tPListIteratorIndexed();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);
};

struct tPMenuItem {   /* 12 bytes */
    unsigned int       fFlags, fTextDescription;   /* +0x0 */
    __vtbl_ptr_type      (*_vf)[7];   /* +0x8 */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItem(unsigned int textDescription);
    ~tPMenuItem();
    tPMenu *NextMenu();
    void *Debounce();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
    void *IsEnabled();
    void *IsDisabled();
};

struct tPMenuItemNonInteractiveText : public tPMenuItem {   /* 12 bytes */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemNonInteractiveText(unsigned int textDescription);
    ~tPMenuItemNonInteractiveText();
    void Draw(bool selected);
    void *IsNavigable();
};

struct tPMenuItemInteractive : public tPMenuItem {   /* 12 bytes */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemInteractive(unsigned int textDescription);
    ~tPMenuItemInteractive();
    void Draw(bool selected);
    void *IsNavigable();
};

struct tPMenuItemLeftRightChoice : public tPMenuItemInteractive {   /* 16 bytes */
    tPListIterator     *fData;   /* +0xC */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemLeftRightChoice(unsigned int textDescription, tPListIterator *dataPtr);
    ~tPMenuItemLeftRightChoice();
    int ProcessInput(tInputKeyType &keyval, tPMenuCommand &menu_cmd);
    void Draw(bool selected);
};

struct tPMenuItemLeftRightSlider : public tPMenuItemInteractive {   /* 20 bytes */
    int                *fData;   /* +0xC */
    char               fMaxVal;   /* +0x10 */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemLeftRightSlider(unsigned int textDescription, int *dataPtr, char maxVal);
    ~tPMenuItemLeftRightSlider();
    void *Debounce();
    int ProcessInput(tInputKeyType &keyval, tPMenuCommand &menu_command);
    void Draw(bool selected);
};

struct tPMenuItemLeftRightSliderIndexed : public tPMenuItemLeftRightSlider {   /* 24 bytes */
    char               *fIndex;   /* +0x14 */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemLeftRightSliderIndexed(unsigned int textDescription, int *dataPtr, char maxVal, char *index);
    ~tPMenuItemLeftRightSliderIndexed();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
    void Draw(bool selected);
};

struct tPMenuItemGoToMenuButton : public tPMenuItemInteractive {   /* 20 bytes */
    tPMenu             *fNewMenu;   /* +0xC */
    void               *fOnButtonPress;   /* +0x10 */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemGoToMenuButton(unsigned int textDescription, tPMenu *newMenu, void (*OnButtonPress)(tPMenuCommand&));
    ~tPMenuItemGoToMenuButton();
    tPMenu *NextMenu();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
};

struct tPMenuItemCommandButton : public tPMenuItemInteractive {   /* 16 bytes */
    int                fCommand;   /* +0xC */
    /* reconstructed PauseMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tPMenuItemCommandButton(unsigned int textDescription, tPMenuCommandType command);
    ~tPMenuItemCommandButton();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
};

struct tPauseMenuDefs {   /* 856 bytes */
    tPMenuItemNonInteractiveText itemGamePaused;   /* +0x0 */
    tPMenuItemCommandButton itemContinue, itemRestart;   /* +0xC */
    tPMenuItemGoToMenuButton itemOptions;   /* +0x2C */
    tPMenuItemCommandButton itemQuitRace, itemForfeitRace;   /* +0x40 */
    tPMenu             menuPause;   /* +0x60 */
    tPMenuItemNonInteractiveText itemOptionsTitle;   /* +0xB4 */
    tPMenuItemGoToMenuButton itemAudioSettings, itemControllerSettings;   /* +0xC0 */
    tPMenu             menuOptions;   /* +0xE8 */
    tPMenuItemNonInteractiveText itemAudioSettingsTitle;   /* +0x13C */
    tPListIterator     iteratorAudioMode;   /* +0x148 */
    tPMenuItemLeftRightChoice itemAudioSettingsAudioMode;   /* +0x154 */
    tPMenuItemLeftRightSlider itemAudioSettingsMusicVolume, itemAudioSettingsFXVolume, itemAudioSettingsSpeechVolume, itemAudioSettingsEngineVolume, itemAudioSettingsAmbientVolume;   /* +0x164 */
    tPMenu             menuAudioSettings;   /* +0x1C8 */
    tPListIteratorIndexed iteratorConfig;   /* +0x21C */
    tPMenuItemNonInteractiveText itemControllerSettingsTitle;   /* +0x22C */
    tPMenuItemLeftRightChoice itemControllerConfig;   /* +0x238 */
    tPMenuItemLeftRightSliderIndexed itemControllerShockMode, itemControllerShockImpact;   /* +0x248 */
    tPMenu             menuControllerConfig;   /* +0x278 */
    tPMenuItemNonInteractiveText itemConfirmTitle, itemConfirmAreYouSure;   /* +0x2CC */
    tPMenuItemCommandButton itemConfirmNo, itemConfirmYes;   /* +0x2E4 */
    tPMenu             menuConfirmYesNo;   /* +0x304 */
};

struct tNfsSystemInfo {   /* 4 bytes */
    int                userRam;   /* +0x0 */
};

struct tListIteratorIndexed : public tListIterator {   /* 20 bytes */
    tListIteratorIndexed() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    char               *fIndex;   /* +0x10 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tListIteratorIndexed(short *selection, char *valPtr, char *index);
    ~tListIteratorIndexed();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);

};

struct tShapeInformation {   /* 40 bytes */
    tTexture_ShapeInfo *fShapes;   /* +0x0 */
    char               *fFile, *fDestFile;   /* +0x4 */
    unsigned int       async_handle;   /* +0xC */
    u_short            fNumShapes, fFlags;   /* +0x10 */
    char               fFilename[16];   /* +0x14 */
    BOOL               fLoadCancelled;   /* +0x24 */
};

struct tScreen {   /* 100 bytes */
    tShapeInformation  fPermShapes, fSwapShapes;   /* +0x0 */
    int                fTransitionTicks;   /* +0x50 */
    BOOL               fTransitionOff;   /* +0x54 */
    int                fInternalScreenFadeVal;   /* +0x58 */
    short              fScreenFadeVal;   /* +0x5C */
    __vtbl_ptr_type      (*_vf)[10];   /* +0x60 */
    /* reconstructed member fns (non-virtual decls; manual vtable is _vf -> ABI-neutral) */
    tScreen();
    ~tScreen();
    void DisplayLoadingText();
    void GoNonInterlaced();
    void DrawBackgroundImage(int startShape, int numShapes, tTexture_ShapeInfo *shapes, int flip_axis);
    void AsyncLoadPermanentShapeFile(char *fileName);
    void AsyncLoadSwapShapeFile(char *fileName);
    void *IsShapeFileLoaded(tShapeInformation &shapes);
    void UploadPermanentShapes(int numPermanentShapes);
    void UploadSwapShapes(int numSwapShapes);
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void Draw(bool drawBackground);
    void AsyncLoadShapeFile(char *name, tShapeInformation &data);
    void CancelAsyncLoad(tShapeInformation &data);
    void InitializeShapes(tShapeInformation &data, unsigned int numShapes);
    void FreeShapes(tShapeInformation &data);
    void UploadShapes(tShapeInformation &data, short x, short y, short numShapes, short index);
    void PreLoad();
    int  TransitionOff(tScreen_TransitionType type, tMenu *menu);
    int  TransitionOn(tScreen_TransitionType type, tMenu *menu);
    void UpdateTransition();
    int  TransitionIsFinished();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void DrawForeground();
    void DrawBackground();
};

struct tCarLineup {   /* 20 bytes */
    BOOL               isPlayerCar;   /* +0x0 */
    int                personality;   /* +0x4 */
    char               position;   /* +0x8 */
    int                carModel;   /* +0xC */
    char               carColor, carUpgrades;   /* +0x10 */
};

struct tTrackInformation {   /* 48 bytes */
    char               fTrackID;   /* +0x0 */
    u_char             fSimNumber, fTrackDifficulty, fAvailable, fIsEgg, fLengthKM, fLengthMiles, fNumMoments;   /* +0x1 */
    char               fShapeName[8], fSplineName[8];   /* +0x8 */
    char               fCountry, fDispatch, fReverseCall, fLanguage;   /* +0x18 */
    char               fTrafficCars[6];   /* +0x1C */
    short              fTX, fTY, fSX, fSY;   /* +0x22 */
    u_char             fSpeedoCountry, fPad;   /* +0x2A */
    long               fRotate;   /* +0x2C */
};

struct tTrackManager {   /* 136 bytes */
    u_long             fNumTracks;   /* +0x0 */
    tTrackInformation  *fTracks;   /* +0x4 */
    BOOL               fAvailableTracks[16], fViewableTracks[16];   /* +0x8 */
    /* reconstructed member fns (FECheats.obj cross-refs; ABI-neutral) */
    void SetClassAvailable(tTrackClassType cls, bool avail);

    /* reconstructed member fns -- FETracks.obj (ABI-neutral) */
    void Initialize();
    void LoadTracks(tSaveTrackInfo &load);
    void SaveTracks(tSaveTrackInfo &save);
    void GetTrack(short trackNumber, tTrackInformation &trackInfo);
    void LoadDescription();
    void ReleaseDescription();
    void SetTrackAvailable(short track, bool avail);
    tTrackInformation *GetTrackByID(short track);

};

struct tTierInfo {   /* 12 bytes */
    u_char             fNumTournaments, fDescriptionID, fTournOffset, fPad;   /* +0x0 */
    u_char             fReserved[8];   /* +0x4 */
};

struct tTourneyInfo {   /* 84 bytes */
    char               fTournamentID;   /* +0x0 */
    u_char             fNumTracks, fTrackOffset, fOpponentCarClass, fTraffic, fKnockout, fNumCars, fAwardCar, fAwardCarModel, fAwardCarUpgrades;   /* +0x1 */
    u_short            fActivateFlags, fRequiredFlags;   /* +0xA */
    u_char             fActivatedTrack, fActivatedCarClass, fActivatedCar, fRequiredTournamentID, fRequiredCar, fRequiredUpgrades, fSpecificUpgrades, fRequiredCheatID, fTrophyID, fPad;   /* +0xE */
    long               fPrize[6];   /* +0x18 */
    long               fEntranceFee;   /* +0x30 */
    u_char             fPersonalities[5], fOpponentCar[5], fOpponentUpgrades[5];   /* +0x34 */
    u_char             fActivatedTrackClass, fActivatedCheat, fNumLaps;   /* +0x43 */
    u_char             fReserved[14];   /* +0x46 */
};

struct tTrackInfo {   /* 40 bytes */
    char               fTrackNumber;   /* +0x0 */
    u_char             fDirection, fMirrored, fTimeOfDay, fWeather, fRandom, fSituations, fPad;   /* +0x1 */
    long               fPrize[6];   /* +0x8 */
    u_long             fDifficulty;   /* +0x20 */
    u_char             fReserved[4];   /* +0x24 */
};

struct tTournamentDefinition {   /* 10532 bytes */
    tTierInfo          fTiers[3];   /* +0x0 */
    tTourneyInfo       fTournaments[64];   /* +0x24 */
    tTrackInfo         fTracks[128];   /* +0x1524 */
};

struct tAwardInformation {   /* 68 bytes */
    long               fMoney, fTournMoney;   /* +0x0 */
    u_short            fActivateFlags;   /* +0x8 */
    char               fActivateTrack;   /* +0xA */
    int                fActivateCarClass, fActivateCar, fActivateTrackClass;   /* +0xC */
    long               fActivateCheat;   /* +0x18 */
    BOOL               fAwardCar, fAwardCarGarageFull;   /* +0x1C */
    long               fAwardCarBonusMoney;   /* +0x24 */
    int                fAwardCarModel;   /* +0x28 */
    char               fAwardCarColor, fAwardCarUpgrades;   /* +0x2C */
    BOOL               fCompletedTier;   /* +0x30 */
    short              fCompletedText;   /* +0x34 */
    int                fCompletedCar;   /* +0x38 */
    BOOL               fCompletedGarageFull;   /* +0x3C */
    long               fCompletedBonusMoney;   /* +0x40 */
};

struct tCompetitor {   /* 16 bytes */
    int                fPersonality;   /* +0x0 */
    u_char             fVariation;   /* +0x4 */
    char               fIsPlayerCar;   /* +0x5 */
    BOOL               fEliminated;   /* +0x8 */
    u_short            fPoints;   /* +0xC */
    u_char             fPosition;   /* +0xE */
};

struct tTournamentManager {   /* 644 bytes */
    char               fNumTiers;   /* +0x0 */
    int                fTier, fTournament, fCurrentTrack, fNumRacers;   /* +0x4 */
    long               fMoney;   /* +0x14 */
    tTournamentDefinition *fDefinition;   /* +0x18 */
    short              fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];   /* +0x1C */
    short              fTournamentList[65];   /* +0x34 */
    short              fTrackList[17];   /* +0xB6 */
    char               fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];   /* +0xD8 */
    tCompetitor        fCompetitors[6];   /* +0x118 */
    tCarLineup         fCarLineup[6];   /* +0x178 */
    char               fBestPlacement[64];   /* +0x1F0 */
    char               fPrevBestPlacement;   /* +0x230 */
    u_char             fFinishPoints[6], fRanking[6];   /* +0x231 */
    tAwardInformation  fAwards;   /* +0x240 */
    /* methods (non-virtual decls; storage-neutral) — FETourn.obj. R-ref params rendered as
       ABI-equivalent pointers (Ghidra). */
    void   Initialize();
    void   LoadDescription();
    void   ReleaseDescription();
    void   UpdateTrackList(short tier, short tournament);
    short *GetTrackList(short tier, short tournament);
    void   GetTrackToRace(tTrackInfo &);
    void   StartNewTournament(unsigned char, unsigned char);
    short  IsTournamentFinished();
    void   UpdateTournFinishMoney();
    void   UpdateTrackFinishMoney();
    void   CalcTrackFinishDamageBill(bool, long &, long &);
    void   UpdateTrackFinishPoints();
    short  AdvanceToNextTrack();
    short  GetLastTrackRaced();
    void   SaveTournament(tSaveTournament &);
    void   LoadTournament(tSaveTournament &);
    short  GetNumCompetitors();
    void   UpdateCarLineup();
    long   GetTrackFinishPrize(short);
    long   GetTournamentFinishPrize(short);
    void   GetAwardInformation(tAwardInformation &);
    void   UpdateAwardInformation();
    short  TournPointTotal(short *);
    short  PlayerRanking(short);
    void   CalcTierFinishPrize();
    void   GetTrophyName(tTourneyInfo *, tTrophySize, char *, int);
    void  *ValidCar(tCarInfo &);
};

struct tMissionTierInfo {   /* 4 bytes */
    u_char             fNumMissions, fDescriptionID, fMissionOffset, fPad;   /* +0x0 */
};

struct tMissionInfo {   /* 20 bytes */
    u_char             fDescriptionID, fTrackNumber, fDirection, fMirrored, fTimeOfDay, fWeather, fTraffic, fPad;   /* +0x0 */
    u_short            fStageOffset;   /* +0x8 */
    u_char             fNumStages;   /* +0xA */
    u_char             fReserved[9];   /* +0xB */
};

struct tStageInfo {   /* 44 bytes */
    u_char             fCarModel, fColor, fAIPersonality, fDirection;   /* +0x0 */
    short              fTimeLimit, fWingman, fSpikeBelt, fBlockadeCop;   /* +0x4 */
    u_char             fPlacement, fStyle;   /* +0xC */
    u_short            fDistance;   /* +0xE */
    u_long             fSpeed, fWeight, fGlue;   /* +0x10 */
    u_char             fSpeechColor;   /* +0x1C */
    u_char             fReserved[15];   /* +0x1D */
};

struct tAcademyDefinition {   /* 12576 bytes */
    tMissionTierInfo   fTiers[8];   /* +0x0 */
    tMissionInfo       fMissions[64];   /* +0x20 */
    tStageInfo         fStages[256];   /* +0x520 */
};

struct tMissionManager {   /* 8 bytes */
    char               fNumTiers;   /* +0x0 */
    tAcademyDefinition *fDefinition;   /* +0x4 */
    /* methods (non-virtual decls; storage-neutral) — FEMission.obj */
    void  Initialize();
    void  LoadDescription(bool LoadHotPursuit);
    void  ReleaseDescription();
    short GetMissionStages(short tier, short mission, tStageInfo **pStages);
    void  GetMissionToRace(tMissionInfo **mission);
};

struct tActiveLine {   /* 12 bytes */
    short              startTick, endTick, x1, y1;   /* +0x0 */
    char               type;   /* +0x8 */
    short              data;   /* +0xA */
};

struct tDialogBase {   /* 144 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    short              specificPlayer, left, top, width, height, reservedheight;   /* +0x64 */
    BOOL               currentlyOn;   /* +0x70 */
    long               startTicks, timeOutTicks;   /* +0x74 */
    short              OffsetX, OffsetY, MaxW, MaxH;   /* +0x7C */
    BOOL               fFullyOpen;   /* +0x84 */
    short              fDefault, ReturnValue;   /* +0x88 */
    int                fFadeText;   /* +0x8C */
    /* reconstructed member fns (FECheats.obj cross-refs; ABI-neutral) */
    void Display();

    /* FEDialog methods */
    short ShouldTimeOut();
    int InitializeClass();
    int DrawAllDialogs();
    int HideAllDialogs();
    int GetTopMostDialog();
    void Hide();
    void Draw();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    ~tDialogBase();

};

struct tDialogMessageString {   /* 152 bytes */
    tDialogBase        _base_tDialogBase;   /* +0x0 */
    char               *string;   /* +0x90 */
    BOOL               Centerit;   /* +0x94 */
    /* FEDialog methods */
    void CalculateDimensions();
    void Draw();
    ~tDialogMessageString();

};

struct tDialogInteractive {   /* 160 bytes */
    tDialogMessageString _base_tDialogMessageString;   /* +0x0 */
    BOOL               ReadyToReturnValue, fCurrentlyRunning;   /* +0x98 */
    /* FEDialog methods */
    short Run();

};

struct tDialogYesNo {   /* 168 bytes */
    tDialogInteractive _base_tDialogInteractive;   /* +0x0 */
    int                yesnowords[2];   /* +0xA0 */
    /* FEDialog methods */
    void CalculateDimensions();
    tDialogYesNo();
    void Draw();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    ~tDialogYesNo();

};

struct tCredit {   /* 324 bytes */
    short              titleTextID, subTitleTextID, titleX, titleY, titleJustify, titleWidth, subTitleX, subTitleY, subTitleJustify, subTitleWidth, textX, textY, textJustify, creditType, bgNumber, pad;   /* +0x0 */
    char               text[292];   /* +0x20 */
};

struct tCreditManager {   /* 56 bytes */
    tCredit            *CreditBuffer;   /* +0x0 */
    int                fTVFade, fTextFade, fTextFadeDir;   /* +0x4 */
    BOOL               fCreditsInitialized, fRequestDeInit;   /* +0x10 */
    int                fNumCredits, fShowCreditNum, fCurrCredit;   /* +0x18 */
    BOOL               StartedTransition, StartedLines, StartedTextFade;   /* +0x24 */
    int                fLineTicks, fStartTicks;   /* +0x30 */
    /* methods (non-virtual decls; storage-neutral) — FECredits.obj */
    void Setup();
    int  Init(int arg1);
    void DeInit();
    void RealDeInit();
    void Draw(bool selected);
    void SetupCurrCredit();
    void DrawCurrCredit();
};

struct tRecordBuffer {   /* 20 bytes */
    char               sName[8];   /* +0x0 */
    int                nCar, nTime, nBestLap;   /* +0x8 */
};

struct ObjectMultiAnim {   /* 48 bytes */
    ObjectAnim         _base_ObjectAnim;   /* +0x0 */
    coorddef           impactVel;   /* +0x4 */
    Trk_SimObject      *simObj;   /* +0x10 */
    Trk_CollideBoomInst *objCollideInstance;   /* +0x14 */
    Trk_ObjectDef      *objDef;   /* +0x18 */
    AnimDef            *animParms;   /* +0x1C */
    int                objectAngle, impactAngle;   /* +0x20 */
    AnimScript         *script;   /* +0x28 */
    ObjectFinishedMultiAnim *finishedAnim;   /* +0x2C */
};

struct ObjectSignAnim {   /* 48 bytes */
    ObjectAnim         _base_ObjectAnim;   /* +0x0 */
    coorddef           impactVel;   /* +0x4 */
    Trk_SimObject      *simObj;   /* +0x10 */
    Trk_CollideBoomInst *objCollideInstance;   /* +0x14 */
    Trk_ObjectDef      *objDef;   /* +0x18 */
    AnimDef            *animParms;   /* +0x1C */
    int                objectAngle, impactAngle;   /* +0x20 */
    AnimScript         *script;   /* +0x28 */
    ObjectFinishedSignAnim *finishedAnim;   /* +0x2C */
};

struct Object_tIMassObjInfo {   /* 32 bytes */
    Trk_AnimateInst    *animInst;   /* +0x0 */
    coorddef           dimension, lastPos;   /* +0x4 */
    int                lastTick;   /* +0x1C */
};

struct Physics_tWheelAccStruct {   /* 48 bytes */
    int                acc, roadGrip, steeringAcc, steeringAngle;   /* +0x0 */
    coorddef           velCap, finalAcc;   /* +0x10 */
    int                frontTire, skid;   /* +0x28 */
};

struct Draw_tVertex {   /* 8 bytes */
    PCOORD16           sv;   /* +0x0 */
};

struct Draw_CarCache {   /* 1024 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
    MATRIX             matB;   /* +0x14 */
    int                pad;   /* +0x34 */
    u_long             *sub_ot;   /* +0x38 */
    int                otz, sub_otz, bfct;   /* +0x3C */
    DR_MODE            drawModeOn, drawModeOff;   /* +0x48 */
    Draw_tPixMap       *pmxStart;   /* +0x60 */
    Draw_tPixMap       ePmx0, ePmx1;   /* +0x64 */
    int                eAddZ, sub_otSize;   /* +0x84 */
    long               color, eColor0, eColor1, eColor2;   /* +0x8C */
    VECTOR             tv;   /* +0x9C */
    COORD16            vt0;   /* +0xAC */
    u_char             u0, v0;   /* +0xB2 */
    COORD16            vt1;   /* +0xB4 */
    u_char             u1, v1;   /* +0xBA */
    COORD16            vt2;   /* +0xBC */
    u_char             u2, v2;   /* +0xC2 */
    short              dvx0, dvy0, dvx1, dvy1, dvx2, dvy2;   /* +0xC4 */
    Draw_CarVertex     tV[96];   /* +0xD0 */
    COORD16            vt3;   /* +0x3D0 */
    u_char             u3, v3;   /* +0x3D6 */
    COORD16            vt4;   /* +0x3D8 */
    u_char             u4, v4;   /* +0x3DE */
    COORD16            vt5;   /* +0x3E0 */
    u_char             u5, v5;   /* +0x3E6 */
    COORD16            vt6;   /* +0x3E8 */
    u_char             offsetU0, offsetV0;   /* +0x3EE */
    COORD16            vt7;   /* +0x3F0 */
    u_char             offsetU1, offsetV1;   /* +0x3F6 */
    COORD16            vt8;   /* +0x3F8 */
    u_char             offsetU2, offsetV2;   /* +0x3FE */
};

struct Transformer_zScene {   /* 588 bytes */
    Transformer_zObj   *obj[57];   /* +0x0 */
    Transformer_zOverlay overlay[90];   /* +0xE4 */
};

struct R3DCar_tEnvMapInfo {   /* 16 bytes */
    int                eScaleX, eScaleY, rideHeight, upgradeHeight;   /* +0x0 */
};

#ifndef NFS4_PSYQ_HEADERS
struct POLY_F4 {   /* 24 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0, x1, y1, x2, y2, x3, y3;   /* +0x8 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct POLY_FT4 {   /* 40 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             u0, v0;   /* +0xC */
    u_short            clut;   /* +0xE */
    short              x1, y1;   /* +0x10 */
    u_char             u1, v1;   /* +0x14 */
    u_short            tpage;   /* +0x16 */
    short              x2, y2;   /* +0x18 */
    u_char             u2, v2;   /* +0x1C */
    u_short            pad1;   /* +0x1E */
    short              x3, y3;   /* +0x20 */
    u_char             u3, v3;   /* +0x24 */
    u_short            pad2;   /* +0x26 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DR_STP {   /* 12 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_long             code[2];   /* +0x4 */
};
#endif

struct tControllerData {   /* 128 bytes */
    char               steering[32];   /* +0x0 */
    u_char             gas[32], brake[32], states[32];   /* +0x20 */
};

struct tReplayInterface {   /* 32 bytes */
    int                pause, speed, end, camera, selection, depressed, changeCamera, statsScreen;   /* +0x0 */
};

struct tReplayCameraModes {   /* 16 bytes */
    int                defaultCamera, timeCounter, cameraMode, cutToNextCamera;   /* +0x0 */
};

struct tReplayBuffer {   /* 27180 bytes */
    GameSetup_tData    gameSetup;   /* +0x0 */
    int                size;   /* +0xA28 */
    char               buffer[24576];   /* +0xA2C */
};

struct CSceneList {   /* 16 bytes */
    int                id_, numElements_, slice_, versionNumber_;   /* +0x0 */
};

struct Sim_tSimGlobalVar {   /* 24 bytes */
    int                gameStarted, gameTicks, time32Hz;   /* +0x0 */
    Sched_tSchedule    *schedule64Hz, *schedule32Hz, *schedule32Hz2;   /* +0xC */
};

struct Sim_tSimSystemVar {   /* 28 bytes */
    int                restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim, goalClockTicks, currentClockTicks;   /* +0x0 */
};

struct sim_queue {   /* 524 bytes */
    Input_tResults     Buffer[2][32];   /* +0x0 */
    int                Validity[2][32];   /* +0x100 */
    int                HeadTime;   /* +0x200 */
    int                TailTime[2];   /* +0x204 */
};

struct Souffle_tISouffle {   /* 68 bytes */
    char               type, id, wind, cycle;   /* +0x0 */
    int                aspeed, angle;   /* +0x4 */
    coorddef           source, motion, extramotion;   /* +0xC */
    SVECTOR            trans;   /* +0x30 */
    int                rndpixmap, ground, colour;   /* +0x38 */
};

struct Stats_tPosition {   /* 16 bytes */
    int                car, slice, sliceTime, isHuman;   /* +0x0 */
};

struct Trk_Material {   /* 10 bytes */
    short              shapeIndex;   /* +0x0 */
    u_char             flag, uvFlag, r, g, b;   /* +0x2 */
    char               textureCount;   /* +0x7 */
    u_char             interval;   /* +0x8 */
    char               pad;   /* +0x9 */
};

struct TrackHeader {   /* 32 bytes */
    int                type, version, maxMetaChunkSize, maxGeomCollSize, maxFullSize, maxSplitSize, metaChunkCount, chunkCount;   /* +0x0 */
};

struct SaveSurface {   /* 8 bytes */
    short              fCount, fMaxCount;   /* +0x0 */
    tSaveSurface       *fStack;   /* +0x4 */
    /* methods (non-virtual -> no layout change; defs track.cpp). Oracle = method-form
       __11SaveSurface...; the ctor/dtor stay SaveSurface_ct/___11SaveSurface. (§3.23b) */
    void Save(Trk_NewSimQuad *simQuad);
    void RestoreAll();
};

struct tBoundingSphere {   /* 8 bytes */
    COORD16            cp;   /* +0x0 */
    short              radius;   /* +0x6 */
};

struct Track_MipMap {   /* 12 bytes */
    u_short            code[2];   /* +0x0 */
    int                shapeParentIndex, mipMapIndex;   /* +0x4 */
};

struct Track_MultiPalette {   /* 8 bytes */
    u_char             charcode[2];   /* +0x0 */
    short              palnum, origshapeindex, actualshapeindex;   /* +0x2 */
};

struct Track_tMaterialController {   /* 16 bytes */
    short              type;   /* +0x0 */
    u_char             textureMax;   /* +0x2 */
    char               pad;   /* +0x3 */
    u_char             uv0, uv1, uv2, uv3;   /* +0x4 */
    char               textureCount;   /* +0x8 */
    u_char             interval;   /* +0x9 */
    short              pmxIndex;   /* +0xA */
    Track_tMaterial    *matPtr;   /* +0xC */
};

struct tSkid {   /* 28 bytes */
    coorddef           pt;   /* +0x0 */
    CVECTOR            clr;   /* +0xC */
    int                type;   /* +0x10 */
    Skidmark_Segment   *nseg;   /* +0x14 */
    int                chunk;   /* +0x18 */
};

struct SNDSYSOPTS {   /* 60 bytes */
    SNDSYSCAP          cap;   /* +0x0 */
    SNDSYSSET          set;   /* +0xC */
    SNDSYSVEC          vec;   /* +0x38 */
};

struct SpuVolume {   /* 4 bytes (PsyQ libspu) */
    short              left, right;   /* +0x0 */
};

struct SpuExtAttr {   /* 12 bytes (PsyQ libspu) */
    SpuVolume          volume;   /* +0x0 */
    long               reverb, mix;   /* +0x4 */
};

struct SpuStVoiceAttr {   /* 16 bytes (PsyQ libspu) */
    char               status, pad1, pad2, pad3;   /* +0x0 */
    long               last_size;   /* +0x4 */
    u_long             buf_addr, data_addr;   /* +0x8 */
};

struct CarIO_textureInfo {   /* 12 bytes */
    char               *tex, *pal;   /* +0x0 */
    int                palShare;   /* +0x8 */
};

struct Input_tDeviceList {   /* 12 bytes */
    char               *devicename;   /* +0x0 */
    void               *devicefunc, *startupfunc;   /* +0x4 */
};

struct dflip {   /* 24 bytes */
    DISPENV            disp;   /* +0x0 */
    char               *server;   /* +0x14 */
};

struct Draw_tView {   /* 200 bytes */
    int                otsize, membudget;   /* +0x0 */
    DRAWENV            drawenv[2];   /* +0x8 */
    u_long             *ot[2];   /* +0xC0 */
};

#ifndef NFS4_PSYQ_HEADERS
struct POLY_FT3 {   /* 32 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             u0, v0;   /* +0xC */
    u_short            clut;   /* +0xE */
    short              x1, y1;   /* +0x10 */
    u_char             u1, v1;   /* +0x14 */
    u_short            tpage;   /* +0x16 */
    short              x2, y2;   /* +0x18 */
    u_char             u2, v2;   /* +0x1C */
    u_short            pad1;   /* +0x1E */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct POLY_G3 {   /* 28 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             r1, g1, b1, pad1;   /* +0xC */
    short              x1, y1;   /* +0x10 */
    u_char             r2, g2, b2, pad2;   /* +0x14 */
    short              x2, y2;   /* +0x18 */
};
#endif

struct DrawC_tEnvMap {   /* 6 bytes */
    short              slice, tex, extra;   /* +0x0 */
};

#ifndef NFS4_PSYQ_HEADERS
struct POLY_GT3 {   /* 40 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             u0, v0;   /* +0xC */
    u_short            clut;   /* +0xE */
    u_char             r1, g1, b1, p1;   /* +0x10 */
    short              x1, y1;   /* +0x14 */
    u_char             u1, v1;   /* +0x18 */
    u_short            tpage;   /* +0x1A */
    u_char             r2, g2, b2, p2;   /* +0x1C */
    short              x2, y2;   /* +0x20 */
    u_char             u2, v2;   /* +0x24 */
    u_short            pad2;   /* +0x26 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct DR_TWIN {   /* 12 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_long             code[2];   /* +0x4 */
};
#endif

struct Trk_Line {   /* 4 bytes */
    u_char             firstPoint, slice, type, quadIndex;   /* +0x0 */
};

struct Draw_tGiveShelbyMoreCache {   /* 636 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
    MATRIX             matB, matNight, matCop, identMat;   /* +0x14 */
    int                otz;   /* +0x94 */
    VECTOR             tVn0, tVn1, tVn2, tVn3;   /* +0x98 */
    short              light, doublelayer, startfog, distfog;   /* +0xD8 */
    CCOORD16           *vertices;   /* +0xE0 */
    u_char             chunkInd, rezInd, garb3, quadCount;   /* +0xE4 */
    void               *quads;   /* +0xE8 */
    int                offset;   /* +0xEC */
    Track_tMaterial    *materials;   /* +0xF0 */
    COORD16            trans;   /* +0xF4 */
    Track_tArtresource *artInfo;   /* +0xFC */
    Trk_NewStrip       *stripPtr;   /* +0x100 */
    short              numStrips;   /* +0x104 */
    char               nightFlags, zeroGTETransFlag;   /* +0x106 */
    short              night_ZNear;   /* +0x108 */
    u_char             night_XDistShift, night_ZDistShift, night_DrawLightning, night_LightningType, fogstate, padnight;   /* +0x10A */
    POLY_GT4           GT4Prim;   /* +0x110 */
    u_short            tpage, clut;   /* +0x144 */
    short              offsubdivid;   /* +0x148 */
    u_char             code, magiknum;   /* +0x14A */
    Draw_SVertex       v0, v1, v2, v3;   /* +0x14C */
    Draw_SubdivStruct  div;   /* +0x18C */
};

struct Draw_tCtrlSkidmark {   /* 56 bytes */
    matrixtdef         m;   /* +0x0 */
    coorddef           t;   /* +0x24 */
    int                count;   /* +0x30 */
    Skidmark_Chunk     *smp;   /* +0x34 */
};

struct ChunkObjectInfo {   /* 24 bytes */
    Trk_SimObject      *simObjs;   /* +0x0 */
    Group              *objInstanceBuf;   /* +0x4 */
    int                doFrustumClip, zClipSq, offset;   /* +0x8 */
    short              *visList;   /* +0x14 */
};

struct Force_tGlobal {   /* 8 bytes */
    u_char             active, high, low, jolt, time, fade;   /* +0x0 */
    u_char             actuator[2];   /* +0x6 */
};

struct charactertbl {   /* 11 bytes */
    u_char             index[2];   /* +0x0 */
    u_char             width, height;   /* +0x2 */
    u_char             u[2], v[2];   /* +0x4 */
    char               advance, xoffset, yoffset;   /* +0x8 */
};

#ifndef NFS4_PSYQ_HEADERS
struct SPRT {   /* 20 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             u0, v0;   /* +0xC */
    u_short            clut;   /* +0xE */
    short              w, h;   /* +0x10 */
};
#endif

struct cluttbl {   /* 48 bytes */
    unsigned int       type : 8;   /* +0x0 bit 0 */
    int                next : 24;   /* +0x1 bit 0 */
    short              width, height, centerx, centery, shapex, shapey;   /* +0x4 */
    short              data[16];   /* +0x10 */
};

#ifndef NFS4_PSYQ_HEADERS
struct POLY_G4 {   /* 36 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             r1, g1, b1, pad1;   /* +0xC */
    short              x1, y1;   /* +0x10 */
    u_char             r2, g2, b2, pad2;   /* +0x14 */
    short              x2, y2;   /* +0x18 */
    u_char             r3, g3, b3, pad3;   /* +0x1C */
    short              x3, y3;   /* +0x20 */
};
#endif

#ifndef NFS4_PSYQ_HEADERS
struct LINE_G2 {   /* 20 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
    u_char             r1, g1, b1, p1;   /* +0xC */
    short              x1, y1;   /* +0x10 */
};
#endif

struct Draw_FlareCache {   /* 20 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
};

struct FLARE_DEF {   /* 128 bytes */
    DVECTOR            pos[2], oldpos[2];   /* +0x0 */
    u_short            screenData[2][5][5];   /* +0x10 */
    int                size;   /* +0x74 */
    FLARE_PIECE_DEF    *piece;   /* +0x78 */
    char               isDrawn[2];   /* +0x7C */
};

struct Flare_tInfo {   /* 16 bytes */
    u_long             chalo, cbeam;   /* +0x0 */
    int                scale, flags;   /* +0x8 */
};

#ifndef NFS4_PSYQ_HEADERS
struct TILE_1 {   /* 12 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0;   /* +0x8 */
};
#endif

struct Draw_HorizonCache {   /* 364 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
    DVECTOR            scptTop[17], scptMidBot[17], scptPmxLeft[17], scptPmxRight[17];   /* +0x14 */
    int                vertexTop[18];   /* +0x124 */
};

struct Draw_SkyCache {   /* 700 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
    DVECTOR            pSkyMesh[85];   /* +0x14 */
    int                pSkyZ[85];   /* +0x168 */
};

struct tHrz_LightningFork {   /* 6 bytes */
    DVECTOR            pos;   /* +0x0 */
    char               pmxIndex;   /* +0x4 */
};

struct tHrz_Lightning {   /* 104 bytes */
    tHrz_LightningFork forks[16];   /* +0x0 */
    int                brightness;   /* +0x60 */
    char               numForks;   /* +0x64 */
};

#ifndef NFS4_PSYQ_HEADERS
struct POLY_F3 {   /* 20 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0, x1, y1, x2, y2;   /* +0x8 */
};
#endif

struct tSmallCoordXY {   /* 4 bytes */
    short              x, y;   /* +0x0 */
};

struct tBTCPerpInfo {   /* 16 bytes */
    char               name[8];   /* +0x0 */
    int                time;   /* +0x8 */
    BOOL               caught;   /* +0xC */
};

struct tCompRGB {   /* 3 bytes */
    char               r, g, b;   /* +0x0 */
};

struct tNightInitCache {   /* 771 bytes */
    tCompRGB           table[257];   /* +0x0 */
};

struct CARD_FILE_HEADER {   /* 512 bytes */
    char               magic[2];   /* +0x0 */
    char               type, numslots;   /* +0x2 */
    char               documentname[64];   /* +0x4 */
    char               pad[28];   /* +0x44 */
    char               clut[32];   /* +0x60 */
    char               icon[3][128];   /* +0x80 */
};

struct eacelement {   /* 4 bytes */
    eacelement         *link;   /* +0x0 */
};

struct sfxsouffle {   /* 48 bytes */
    Draw_tPixMap       pmx;   /* +0x0 */
    SVECTOR            v0, v1, v2, v3;   /* +0x10 */
};

struct Sfx_tCache {   /* 24 bytes */
    Draw_tCacheHeader  head;   /* +0x0 */
    int                otz;   /* +0x14 */
};

struct Texture_pal8bit {   /* 520 bytes */
    int                x, y;   /* +0x0 */
    short              pal[256];   /* +0x8 */
};

struct CSVECTOR {   /* 12 bytes */
    int                r, g, b;   /* +0x0 */
};

struct TP_ZPaletteSystem {   /* 4 bytes */
    int                numdepthclut;   /* +0x0 */
};

struct FogKey {   /* 12 bytes */
    short              distance, slice;   /* +0x0 */
    FogKey             *next, *prev;   /* +0x4 */
};

struct CTrackSpecHeader {   /* 8 bytes */
    int                version, num_spec;   /* +0x0 */
};

struct CTrackSpec {   /* 264 bytes */
    short              fogstate, weatherstate, horizonstate, skystate, nightstate, depthcuestate, worldcolorstate, pad0;   /* +0x0 */
    CFogSpec           fogspec;   /* +0x10 */
    CWeatherSpec       weatherspec;   /* +0x20 */
    CHorizonSpec       horizonspec;   /* +0x28 */
    CSkySpec           skyspec;   /* +0x58 */
    CNightSpec         nightspec;   /* +0xEC */
    CDepthCueSpec      depthcuespec;   /* +0xF0 */
    CWorldColor        worldcolorspec;   /* +0xF8 */
};

struct Weather_tSys {   /* 36 bytes */
    int                num[2];   /* +0x0 */
    SVECTOR            velocity;   /* +0x8 */
    long               hdist;   /* +0x10 */
    short              znear, zfar, length, bottom, top, height, width;   /* +0x14 */
};

struct Weather_tSplatInfo {   /* 8 bytes */
    DVECTOR            pos;   /* +0x0 */
    int                startTick;   /* +0x4 */
};

#ifndef NFS4_PSYQ_HEADERS
struct DR_AREA {   /* 12 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_long             code[2];   /* +0x4 */
};
#endif

struct tMenuCommand {   /* 8 bytes */
    int                type;   /* +0x0 */
    tMenu              *nextMenu;   /* +0x4 */
};

struct tListIteratorRangeIndexed : public tListIteratorRange {   /* 20 bytes */
    tListIteratorRangeIndexed() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    char               *fIndex;   /* +0x10 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tListIteratorRangeIndexed(char minValue, char maxValue, char *valPtr, char *index);
    ~tListIteratorRangeIndexed();
    int Value(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tMenuItemLeftRightChoice {   /* 32 bytes */
    tMenuItemLeftRightChoice() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemInteractive _base_tMenuItemInteractive;   /* +0x0 */
    tListIterator      *fData;   /* +0x1C */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tMenuItemLeftRightChoice(unsigned int textDescription, tListIterator *dataPtr);
    ~tMenuItemLeftRightChoice();
    int ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void Draw(bool selected);

};

struct tMenuItemLeftRightSlider {   /* 40 bytes */
    tMenuItemLeftRightSlider() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemInteractive _base_tMenuItemInteractive;   /* +0x0 */
    tListIterator      *fData;   /* +0x1C */
    short              fX, fY, fWidth, fHeight;   /* +0x20 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tMenuItemLeftRightSlider(unsigned int textDescription, tListIterator *dataPtr);
    ~tMenuItemLeftRightSlider();
    long DebounceKeys();
    int ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void Draw(bool selected);
    void SetDimensions(short x, short y, short width, short height);

};

struct tMenuItemGoToMenuButton {   /* 32 bytes */
    tMenuItemGoToMenuButton() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemInteractive _base_tMenuItemInteractive;   /* +0x0 */
    void               *fOnButtonPress;   /* +0x1C */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    tMenuItemGoToMenuButton(unsigned int textDescription, tMenu *newMenu, void (*OnButtonPress)(tMenuCommand&));
    ~tMenuItemGoToMenuButton();
    int ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);

};

struct tDrawShapeExtended {   /* 24 bytes */
    short              flip_axis;   /* +0x0 */
    int                tint[4];   /* +0x4 */
    tTexture_ShapeInfo *custom_shapes;   /* +0x14 */
};

struct tDialogHelp {   /* 212 bytes */
    tDialogBase        _base_tDialogBase;   /* +0x0 */
    short              variant;   /* +0x90 */
    char               *text[7];   /* +0x94 */
    int                cont[7];   /* +0xB0 */
    short              numItems, helpcontrollers, lefttext;   /* +0xCC */
    /* FEDialog methods */
    void AddItem(short textID,short controllerID);
    void CalculateDimensions();
    void Draw();
    ~tDialogHelp();

};

struct tDialogMessageStringWithTimeout {   /* 152 bytes */
    tDialogMessageString _base_tDialogMessageString;   /* +0x0 */
    ~tDialogMessageStringWithTimeout();   /* @0x80015760 -- vtable slot 4 (M10) */
};

struct tDialogNoInputMessage {   /* 152 bytes */
    tDialogMessageString _base_tDialogMessageString;   /* +0x0 */
    /* FEDialog methods */
    void ProcessInput(tPlayer atPlayer,tInputKeyType &keyval, tMenuCommand &command);
    ~tDialogNoInputMessage();

};

struct tFEApplication {   /* 896 bytes */
    unsigned int       fCurrentMusic;   /* +0x0 */
    tMenu              *fCurrentMenu[2];   /* +0x4 */
    tScreen            *fCurrentScreen[2];   /* +0xC */
    tMenu              *fTransitionToMenu[2];   /* +0x14 */
    tScreen            *fTransitionToScreen[2];   /* +0x1C */
    tMenu              *fParentMenu[2];   /* +0x24 */
    tDialogMessageString messagePopup;   /* +0x2C */
    tMenu              *backList[2][16];   /* +0xC4 */
    int                backDepth[2], fLastKeyPressed[2];   /* +0x144 */
    short              fYOffset;   /* +0x154 */
    tDialogHelp        helpPopup;   /* +0x158 */
    char               fPlayer, fInputPlayer;   /* +0x22C */
    BOOL               waitingForOtherPlayer[2];   /* +0x230 */
    tDialogMessageStringWithTimeout MemCardDialog;   /* +0x238 */
    tDialogNoInputMessage NoInputMemCardDialog;   /* +0x2D0 */
    BOOL               gotName[2], needName[2];   /* +0x368 */
    int                speechToPlay[2];   /* +0x378 */
    void Redraw();   /* FEDialog */
    /* FEApp methods */
    tFEApplication();
    ~tFEApplication();
    void PerformMenuInitialization();
    void PerformMenuDestruction();
    void DrawHelpIcons();
    void UpdateMusic();
    void SetMenu(short i,tMenu *menu);
    void SetScreen(short i,tScreen *screen);
    void DisplayHelp(short variant);
    void RunDemoVideo();
    tAppCommand MainLoop(tMenu *newMenu);
    tAppCommand RunPostGame();
    tAppCommand RunFrontEnd();

};

struct tMenuItemGoToMenuNFS4Button {   /* 44 bytes */
    tMenuItemGoToMenuNFS4Button() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemGoToMenuButton _base_tMenuItemGoToMenuButton;   /* +0x0 */
    int                fOrdinalPos;   /* +0x20 */
    short              fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;   /* +0x24 */
    /* FEMenuExtended methods */
    tMenuItemGoToMenuNFS4Button(unsigned int textDescription,tMenu *newMenu, void (*OnButtonPress)(tMenuCommand&),int firstFrame,int numFrames);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int x,int y,bool selected);
    void TransitionOn();
    void TransitionOff();
    void * TransitionIsFinished();
    void UpdateTransition(bool selected);
    void Draw(bool selected);

};

struct tMenuItemNFS4LeftRightChoice {   /* 40 bytes */
    tMenuItemNFS4LeftRightChoice() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemLeftRightChoice _base_tMenuItemLeftRightChoice;   /* +0x0 */
    short              fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;   /* +0x20 */
    /* FEMenuExtended methods */
    tMenuItemNFS4LeftRightChoice(unsigned int textDescription,tListIterator *dataPtr, int firstFrame,int numFrames);
    ~tMenuItemNFS4LeftRightChoice();
    void Draw(int x,int y,bool selected);
    void TransitionOn();
    void TransitionOff();
    void * TransitionIsFinished();
    void UpdateTransition(bool selected);

};

struct tBlankMenuItemNFS4LeftRightChoice {   /* 40 bytes */
    tMenuItemNFS4LeftRightChoice _base_tMenuItemNFS4LeftRightChoice;   /* +0x0 */
    void *TransitionIsFinished();
    void Draw(int, int, char);
    ~tBlankMenuItemNFS4LeftRightChoice();
};

struct tMenuItemOptionsLeftRightChoice {   /* 32 bytes */
    tMenuItemLeftRightChoice _base_tMenuItemLeftRightChoice;   /* +0x0 */
    /* FEMenuExtended methods */
    void Draw(int x,int y,bool selected);
    ~tMenuItemOptionsLeftRightChoice();

};

struct tMenuItemOptionsTwoItemChoice {   /* 36 bytes */
    tMenuItemLeftRightChoice _base_tMenuItemLeftRightChoice;   /* +0x0 */
    short              fOnOffFade;   /* +0x20 */
    /* FEMenuExtended methods */
    void TransitionOn();
    void Draw(int x,int y,bool selected);
    ~tMenuItemOptionsTwoItemChoice();

};

struct tMenuNFS4 {   /* 124 bytes */
    tMenuNFS4() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenu              _base_tMenu;   /* +0x0 */
    BOOL               fInItemTransition, fInMenuTransition;   /* +0x6C */
    short              fTransitionVal;   /* +0x74 */
    char               fTransitionDirection, fLastItem, fNumItems;   /* +0x76 */
    /* FEMenuExtended methods */
    tMenuNFS4(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...);
    tMenuNFS4(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu,tMenu *optionsMenu, void (*OnButtonPress)(tMenuCommand&),short title);
    ~tMenuNFS4();
    void Initialize();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition();
    void DrawItem(int item);
    void Draw();

};

struct tMenuNFS4TwoPlayer {   /* 124 bytes */
    tMenuNFS4TwoPlayer() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuNFS4          _base_tMenuNFS4;   /* +0x0 */
    /* FEMenuExtended methods */
    tMenuNFS4TwoPlayer(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...);
    ~tMenuNFS4TwoPlayer();
    void DrawItem(int item);

};

struct tMenuNFS4Bottom {   /* 124 bytes */
    tMenuNFS4Bottom() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuNFS4          _base_tMenuNFS4;   /* +0x0 */
    /* FEMenuExtended methods */
    tMenuNFS4Bottom(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...);
    ~tMenuNFS4Bottom();
    void Draw();

};

struct tMenuBlank {   /* 124 bytes */
    tMenuBlank() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuNFS4          _base_tMenuNFS4;   /* +0x0 */
    /* FEMenuExtended methods */
    tMenuBlank(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu,tMenu *optionsMenu ,void (*OnButtonPress)(tMenuCommand&),short title);
    ~tMenuBlank();
    void Draw();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    void Initialize();
    long DebounceKeys();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition();

};

struct tMenuOptions {   /* 132 bytes */
    tMenuOptions() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuNFS4          _base_tMenuNFS4;   /* +0x0 */
    u_long             fMenuEnterTicks;   /* +0x7C */
    short              fPlayer;   /* +0x80 */
    /* FEMenuExtended methods */
    tMenuOptions(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,short player, tMenuItem *firstItem,...);
    ~tMenuOptions();
    void Draw();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    void * IsSubMenu();

};

struct tMenuItemLeftRightFade {   /* 44 bytes */
    tMenuItemLeftRightFade() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemLeftRightChoice _base_tMenuItemLeftRightChoice;   /* +0x0 */
    short              fFadeVal, fFadeDir;   /* +0x20 */
    BOOL               fInTransition;   /* +0x24 */
    int                flareextra;   /* +0x28 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tMenuItemLeftRightFade(unsigned int, tListIterator *);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);
    void MyLeftRightDraw(int, int);

};

struct tOptionsMenu {   /* 128 bytes */
    tOptionsMenu() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenu              _base_tMenu;   /* +0x0 */
    BOOL               fInMenuTransition;   /* +0x6C */
    char               fTransitionDirection;   /* +0x70 */
    short              fPrevItem;   /* +0x72 */
    int                fScreenFade, fFirstFrame, fNumFrames;   /* +0x74 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tOptionsMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, int, int, tMenuItem *, ...);
    ~tOptionsMenu();
    long DebounceKeys();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition();
    void Draw();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tInsideBoxMenu {   /* 116 bytes */
    tMenu              _base_tMenu;   /* +0x0 */
    short              fPrevItem, fMoving, fMovingDir;   /* +0x6C */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tInsideBoxMenu() {}
    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxMenu();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int Draw(short, short, short, short, short);

};

struct tMenuItemSlidingMenu {   /* 68 bytes */
    tMenuItemSlidingMenu() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItem          _base_tMenuItem;   /* +0x0 */
    tInsideBoxMenu     *currMenu, *nextMenu;   /* +0x1C */
    short              fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;   /* +0x24 */
    BOOL               fInTransition, fTransitioningOut, fClosing;   /* +0x30 */
    short              fDiffX, fDiffY;   /* +0x3C */
    BOOL               fFillback;   /* +0x40 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tMenuItemSlidingMenu(unsigned int, short, short, short, short, bool);
    ~tMenuItemSlidingMenu();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);
    long DebounceKeys();
    void Draw(bool);
    void UpdatefOpenHeight(bool);
    void Draw(int, int, bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void SetMenu(bool, tInsideBoxMenu *);

};

struct tMenuItemSlidingActivated {   /* 72 bytes */
    tMenuItemSlidingMenu _base_tMenuItemSlidingMenu;   /* +0x0 */
    BOOL               fActive;   /* +0x44 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    int UpdatefOpenHeight(bool);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tMenuItemDisplayLeftRightChoice {   /* 44 bytes */
    tMenuItemLeftRightFade _base_tMenuItemLeftRightFade;   /* +0x0 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    int Draw(int, int, bool);

};

struct tMenuItemOnOffLeftRightChoice {   /* 48 bytes */
    tMenuItemLeftRightFade _base_tMenuItemLeftRightFade;   /* +0x0 */
    short              fOnFade;   /* +0x2C */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    void TransitionOn();
    int Draw(int, int, bool);

};

struct tMenuItemLeftRightAudioSlider {   /* 56 bytes */
    tMenuItemLeftRightAudioSlider() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemLeftRightSlider _base_tMenuItemLeftRightSlider;   /* +0x0 */
    short              fFadeVal, fFadeDir;   /* +0x28 */
    BOOL               fInTransition;   /* +0x2C */
    short              fAudioArt;   /* +0x30 */
    int                flareextra;   /* +0x34 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tMenuItemLeftRightAudioSlider(unsigned int, tListIterator *, int);
    ~tMenuItemLeftRightAudioSlider();
    int Draw(int, int, bool);
    int Percentage();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);

};

struct tInsideBoxSongMenu {   /* 136 bytes */
    tInsideBoxSongMenu() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tInsideBoxMenu     _base_tInsideBoxMenu;   /* +0x0 */
    short              fOnOffFade[5], fSelFade[5];   /* +0x74 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tInsideBoxSongMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxSongMenu();
    void Draw(short, short, short, short, short);
    void DrawOneSong(short, short, short, short, short, short);
    long DebounceKeys();
    int ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tMenuItemControllerLeftRightChoice {   /* 44 bytes */
    tMenuItemLeftRightFade _base_tMenuItemLeftRightFade;   /* +0x0 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    int Draw(int, int, bool);

};

struct tInsideBoxLeftRightSlider {   /* 40 bytes */
    tInsideBoxLeftRightSlider() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemLeftRightSlider _base_tMenuItemLeftRightSlider;   /* +0x0 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tInsideBoxLeftRightSlider(unsigned int, tListIterator *);
    ~tInsideBoxLeftRightSlider();
    int Draw(int, int, int, bool);

};

struct tInsideBoxTwoWaySlider {   /* 48 bytes */
    tInsideBoxTwoWaySlider() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItemLeftRightSlider _base_tMenuItemLeftRightSlider;   /* +0x0 */
    short              fType;   /* +0x28 */
    BOOL               fActive;   /* +0x2C */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tInsideBoxTwoWaySlider(unsigned int, tListIterator *, int);
    ~tInsideBoxTwoWaySlider();
    int ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int Draw(int, int, int, bool);
    void Calibrate();

};

struct tUserNameMenuItem {   /* 140 bytes */
    tUserNameMenuItem() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tMenuItem          _base_tMenuItem;   /* +0x0 */
    char               *fData;   /* +0x1C */
    short              fMaxStringLength, fCurrentColumn, fCurrentRow;   /* +0x20 */
    char               fRowList[10][9];   /* +0x26 */
    short              fPlayer, fFadeVal, fFadeDir;   /* +0x80 */
    BOOL               fInTransition;   /* +0x88 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    tUserNameMenuItem(unsigned int);
    int ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int Draw(bool);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);

};

struct tMenuItemGoToMenuButtonFade {   /* 44 bytes */
    tMenuItemGoToMenuButton _base_tMenuItemGoToMenuButton;   /* +0x0 */
    short              fFadeVal, fFadeDir;   /* +0x20 */
    BOOL               fInTransition;   /* +0x24 */
    short              fEnableVal;   /* +0x28 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);

};

struct tMemoryCardMenuItem {   /* 44 bytes */
    tMenuItemGoToMenuButtonFade _base_tMenuItemGoToMenuButtonFade;   /* +0x0 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    int Draw(bool);

};

struct tBlankMenuItemGoToMenuNFS4Button {   /* 44 bytes */
    tMenuItemGoToMenuNFS4Button _base_tMenuItemGoToMenuNFS4Button;   /* +0x0 */
    void *TransitionIsFinished();
    void Draw(int, int, char);
    void Draw(int);
    ~tBlankMenuItemGoToMenuNFS4Button();
};

struct tInsideBoxControllerLeftRightSlider {   /* 40 bytes */
    tInsideBoxLeftRightSlider _base_tInsideBoxLeftRightSlider;   /* +0x0 */

    /* reconstructed member fns -- FeMenuOptions.obj (ABI-neutral) */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tSaveCarInfo {   /* 224 bytes */
    tOwnedCarInfo      fSaveInfo[32];   /* +0x0 */
    u_char             fSaveAvailable[48], fSaveViewable[48];   /* +0x80 */
};

struct tListIteratorCar : public tListIterator {   /* 28 bytes */
    tListIteratorCar() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    int                fCarListFilter;   /* +0x10 */
    tCarManager        *fCarManager;   /* +0x14 */
    int                fNameLength;   /* +0x18 */
    /* FECars methods */
    tListIteratorCar(char *valPtr,tCarManager *carManager);
    ~tListIteratorCar();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer atIndex);
    void AdjustPosition(tPlayer atIndex,short direction);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    void * ValidCar(tPlayer atIndex,char carNumber);

};

struct tListIteratorCarColor : public tListIterator {   /* 32 bytes */
    tListIteratorCarColor() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    char               *fPlayer, *fPlayerCar;   /* +0x10 */
    int                fIndexSize;   /* +0x18 */
    tCarManager        *fCarManager;   /* +0x1C */
    /* FECars methods */
    tListIteratorCarColor(char *value,char *player,char *playerCar,int indexSize, tCarManager *carManager);
    ~tListIteratorCarColor();
    char Value(tPlayer arg1);
    int TextValue(tPlayer arg1);
    int Increment(tPlayer arg1);
    int Decrement(tPlayer arg1);

};

struct tSaveTrackInfo {   /* 16 bytes */
    u_char             fTrackActivated[16];   /* +0x0 */
};

struct tListIteratorTrack : public tListIteratorIndexed {   /* 24 bytes */
    tListIteratorTrack() {}   /* default ctor: embedded+body-init by tGlobalMenuDefs (FEMenuDefs) */
    tTrackManager      *fTrackManager;   /* +0x14 */
    /* reconstructed member fns -- FETracks.obj (ABI-neutral) */
    tListIteratorTrack(char *valPtr, char *index, tTrackManager *trackManager);
    ~tListIteratorTrack();
    short TextValue(tPlayer atIndex);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    void *ValidTrack(char track);

};

struct tSaveTournament {   /* 176 bytes */
    long               fSaveMoney;   /* +0x0 */
    u_char             fSaveTier, fSaveTournament, fSaveTrack, fSaveNumRacers;   /* +0x4 */
    tCompetitor        fSaveCompetitors[6];   /* +0x8 */
    u_char             fSaveBestPlacement[64];   /* +0x68 */
    short              fSaveTierFinishPrize[4];   /* +0xA8 */
};

struct tListIteratorTournament : public tListIterator {   /* 20 bytes */
    tTournamentManager *fTournamentManager;   /* +0x10 */
    /* methods (non-virtual decls) — FETourn.obj */
    tListIteratorTournament() {}
    tListIteratorTournament(char *valPtr, tTournamentManager *tournManager);
    ~tListIteratorTournament();
    int   Value(tPlayer);
    int   TextValue(tPlayer);
    void  Increment(tPlayer);
    void  Decrement(tPlayer);
    void *ValidTournament(char);
};

struct tTVConfig {   /* 48 bytes */
    int                state;   /* +0x0 */
    short              transition;   /* +0x4 */
    u_short            destBrightness, flags;   /* +0x6 */
    short              fxWide, fxThin;   /* +0xA */
    int                tint;   /* +0x10 */
    short              x, y, w, h;   /* +0x14 */
    u_char             u, v, uw, vh, shapeType;   /* +0x1C */
    u_short            clut, tpage, shapex, shapey, clutID, flip_axis;   /* +0x22 */
};

struct tVideoTransition {   /* 24 bytes */
    int                state;   /* +0x0 */
    u_short            flags;   /* +0x4 */
    u_char             u, v, uw, vh;   /* +0x6 */
    u_short            clut, tpage;   /* +0xA */
    unsigned int       tint;   /* +0x10 */
    short              bright;   /* +0x14 */
};

struct tVideo {   /* 8 bytes */
    char               x, y, width, height, tileWidth, tileHeight, deltaX, deltaY;   /* +0x0 */
};

struct FE3d_zUV {   /* 2 bytes */
    u_char             u, v;   /* +0x0 */
};

struct FE3d_zFacet {   /* 44 bytes */
    u_short            vertexId0, vertexId1, vertexId2, uvId0, uvId1, uvId2;   /* +0x0 */
    SVECTOR            normal[3];   /* +0xC */
    CVECTOR            color;   /* +0x24 */
    u_char             flag, pad1, pad2, pad3;   /* +0x28 */
};

struct FE3d_zObj {   /* 32 bytes */
    int                numVertex, numUV, numFacet;   /* +0x0 */
    u_char             textureId, textureWidth, textureHeight, pad1;   /* +0xC */
    COORD16            *vertex;   /* +0x10 */
    FE3d_zUV           *uv;   /* +0x14 */
    COORD16            *Nvertex;   /* +0x18 */
    FE3d_zFacet        *facet;   /* +0x1C */
};

struct tScreenUserName {   /* 204 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    tOptionsMenu       *callingMenu;   /* +0x64 */
    short              fTextFade;   /* +0x68 */
    BOOL               fInTransition;   /* +0x6C */
    char               fRowList[10][9];   /* +0x70 */
    /* reconstructed member fns (non-virtual decls; ABI-neutral) */
    void Initialize();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawVerticalLine(short x, short y, short gridpos);
    void DrawHorizontalLine(short x, short y, short gridpos);
    void DrawBackground();
    ~tScreenUserName();
};

struct tScreenTournamentStandings {   /* 148 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    long               moneyFinal, moneyAwarded, moneyDamage, moneyBonus;   /* +0x64 */
    int                starttick;   /* +0x74 */
    BOOL               gotmoney, gotbonus, gotbilled, fDrawMoney, fCountedDown, fStartCountdownNOW;   /* +0x78 */
    int                fCountSpeed;   /* +0x90 */
    /* --- reconstructed member fns (ScreenPost.obj; non-virtual, ABI-neutral) --- */
    tScreenTournamentStandings();
    void Initialize();
    void Cleanup();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);  /* returns menu-cmd value */
    void DrawBackground();
    ~tScreenTournamentStandings();
};

struct tScreenTournamentStandings3item {   /* 148 bytes */
    tScreenTournamentStandings _base_tScreenTournamentStandings;   /* +0x0 */
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    ~tScreenTournamentStandings3item();
};

struct LUMPYHEAD {   /* 16 bytes */
    u_long             type, len, num, hlen;   /* +0x0 */
};

struct FILEINFO {   /* 12 bytes */
    unsigned int       offset, length;   /* +0x0 */
    char               name[1];   /* +0x8 */
};

struct SPEECHINFO {   /* 36 bytes */
    char               name[4];   /* +0x0 */
    int                multiplay, nHandle, nSoundHandle;   /* +0x4 */
    char               areLoading, soundIsPlaying, playNextOne;   /* +0x10 */
    char               *pBankHeader, *sSpeechData, *lastSpeechData;   /* +0x14 */
    int                vivHandle;   /* +0x20 */
};

struct tDialogBackUpOnly {   /* 152 bytes */
    tDialogMessageString _base_tDialogMessageString;   /* +0x0 */
    /* FEDialog methods */
    int ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval, tMenuCommand &command);
    ~tDialogBackUpOnly();

};

struct tDialogYesNoMem {   /* 168 bytes */
    tDialogYesNo       _base_tDialogYesNo;   /* +0x0 */
    /* FEDialog methods */
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command );
    ~tDialogYesNoMem();

};

struct tDialogYesNoTri {   /* 168 bytes */
    tDialogYesNo       _base_tDialogYesNo;   /* +0x0 */
    /* FEDialog methods */
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command );
    ~tDialogYesNoTri();

};

struct CARDINFO_def {   /* 616 bytes */
    int                status, lasterror, numfiles, freeblocks;   /* +0x0 */
    DIRENTRY           dir[15];   /* +0x10 */
};

struct MCRDFILEHEADER_def {   /* 512 bytes */
    u_char             magicnumber[2];   /* +0x0 */
    u_char             type, nslots;   /* +0x2 */
    u_short            title[32];   /* +0x4 */
    u_char             unused[28];   /* +0x44 */
    u_char             iconclut[32];   /* +0x60 */
    u_char             icon1[128], icon2[128], icon3[128];   /* +0x80 */
};

struct MCRDFILEINFO_def {   /* 572 bytes */
    int                cardnum;   /* +0x0 */
    char               name[24];   /* +0x4 */
    char               *title;   /* +0x1C */
    int                size, offset;   /* +0x20 */
    unsigned int       flags;   /* +0x28 */
    MCRDFILEHEADER_def header;   /* +0x2C */
    void               *pData;   /* +0x22C */
    shapetbl           *icon[3];   /* +0x230 */
};

struct helpKeyData {   /* 4 bytes */
    short              text, button;   /* +0x0 */
};

struct tHelpData {   /* 18 bytes */
    char               autoGenerate;   /* +0x0 */
    helpKeyData        items[4];   /* +0x2 */
};

struct tScreenControllerConfig {   /* 380 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    Force_tGlobal      fShaker;   /* +0x64 */
    char               fPrevConfig, fTextConfig, fTextController, fPrevController;   /* +0x6C */
    short              fFade[2], fFadeController[2];   /* +0x70 */
    int                fStartTick;   /* +0x78 */
    short              fGotTick, fAnim, fAnimFrame, fAnimStart, fAnimStop, fAnimStep, fAnimController, fSwap, fAnimFade, fAnimFadeStart, fAnimFadeStop, fAnimFadeFrame, fAnimFadeController, CurrentlyLoadedArt, negconChoice;   /* +0x7C */
    BOOL               fTransitionedIn, fTransitioningIn, fTransitioningOut;   /* +0x9C */
    short              fArrowFade, fArrowFadeDir, fTextTypeOn;   /* +0xA8 */
    BOOL               fFadeTextOut;   /* +0xB0 */
    short              mult;   /* +0xB4 */
    tDialogYesNo       negconPopUp;   /* +0xB8 */
    int                fTimeOutStartTick;   /* +0x160 */
    BOOL               SuperFastFadeOut, fPlayedInSound;   /* +0x164 */
    short              fShakingItem;   /* +0x16C */
    BOOL               fResetShakeTimeOut;   /* +0x170 */
    char               fCurrentController;   /* +0x174 */
    int                player;   /* +0x178 */
    /* --- reconstructed member fns (ScreenController.obj; non-virtual, ABI-neutral) --- */
    void  ClearActuators();
    void  SetActuators(int max);
    void  TurnOffShakers();
    void  ShakeIt();
    short AnimKeyPoints(bool forward, bool pt);
    void  CheckConfigs();
    void  SwapInController();
    void  SetCurrentController(bool firsttime);
    int   CalcAnimFrame(int frame);
    void  ActualDrawController(int frame, int fadelevelmain, int fadeleveltop, int shakex, int shakey);
    void  DrawController();
    void  HorzVertLine(short *ArrowLoc, bool type);
    void  DrawArrow(short *ArrowLoc);
    void  DrawBackground();
    void  DrawForeground();
    void  GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void  Initialize();
    void  Cleanup();
    int   GetHelpText();
    tScreenControllerConfig();
    ~tScreenControllerConfig();
};

struct tCheat {   /* 12 bytes */
    u_char             name[8];   /* +0x0 */
    int                cheat;   /* +0x8 */
};

struct tOldMenu {   /* 80 bytes */
    char               *artFileName, *backgrName;   /* +0x0 */
    short              driver, current, flags, helpvariant;   /* +0x8 */
    tItemButton        *item[16];   /* +0x10 */
};

struct tItemButton {   /* 20 bytes */
    short              type, text;   /* +0x0 */
    tOldMenu           *nextMenu;   /* +0x4 */
    char               *value;   /* +0x8 */
    short              *selection;   /* +0xC */
    char               defaultvalue;   /* +0x10 */
    u_char             flags, cases;   /* +0x11 */
};

struct tPSXToFEMapping {   /* 8 bytes */
    int                PSXKey, FEKey;   /* +0x0 */
};

struct tListIteratorDoubleIndexed : public tListIterator {   /* 28 bytes */
    char               *fIndex1;   /* +0x10 */
    int                index1multiplier;   /* +0x14 */
    char               *fIndex2;   /* +0x18 */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    ~tListIteratorDoubleIndexed();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);

};

struct tListIteratorMultiPlayer : public tListIterator {   /* 16 bytes */
    /* reconstructed FEMenu member fns (non-virtual decls; manual _vf vtable -> ABI-neutral) */
    ~tListIteratorMultiPlayer();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tScreenMain {   /* 1464 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    int                hVideo, fFrame;   /* +0x64 */
    u_long             fStartTicks, fAnimTicks;   /* +0x6C */
    short              fAnimLocation;   /* +0x74 */
    int                fState;   /* +0x78 */
    tTVConfig          tvConfigs[16];   /* +0x7C */
    int                tvStates[16];   /* +0x37C */
    tVideoTransition   tvTransitions[16];   /* +0x3BC */
    BOOL               fTVsInitialized;   /* +0x53C */
    char               fTransitionDirection;   /* +0x540 */
    BOOL               fAnimationUploaded;   /* +0x544 */
    short              fPreviousAnim, fWarningFade, fPreviousMovie, fCurrentMovie;   /* +0x548 */
    BOOL               bVideoAborted;   /* +0x550 */
    u_long             fMovieTicks;   /* +0x554 */
    tShapeInformation  fVideoShapes[2];   /* +0x558 */
    int                fCurrentSlot;   /* +0x5A8 */
    int                fCurrentBG[2];   /* +0x5AC */
    int                fNumTVsInTransition;   /* +0x5B4 */
    /* methods (non-virtual decls; storage-neutral) — ScreenMain.obj */
    void SwapBackground(int num);
    int  DoneLoadingBackground();
    void SetState(tScreenMainState state);
    void InitDynamicImages();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void DrawDropShadow();
    void DrawVideoLines();
    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void PreLoad();
    void Initialize();
    void Cleanup();
    ~tScreenMain();
};

struct MCRDFILE_def {   /* 44 bytes */
    char               *name, *title;   /* +0x0 */
    int                size, offset;   /* +0x8 */
    unsigned int       flags;   /* +0x10 */
    void               *pData;   /* +0x14 */
    shapetbl           *icon[3];   /* +0x18 */
    u_char             *numicons, *numblocks;   /* +0x24 */
};

struct tVideoWall {   /* 56 bytes */
    tTVConfig          *fTVs;   /* +0x0 */
    short              fFirstTVShape, fNumTVs;   /* +0x4 */
    tTexture_ShapeInfo *fTVShapes;   /* +0x8 */
    short              *tvOrder;   /* +0xC */
    u_long             fTVTicks;   /* +0x10 */
    short              fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY, fAvailableTextID, fAvailable, fAvailableBright, fValid, fAvailableX, fAvailableY;   /* +0x14 */
    tTexture_ShapeInfo *fIconShapes;   /* +0x28 */
    short              fIcon, fIconFrames, fIconX, fIconY;   /* +0x2C */
    BOOL               fUpdated;   /* +0x34 */
    /* methods (non-virtual decls; storage-neutral) — FEVideoWall.obj */
    void Initialize(tTVConfig *tvs, tTexture_ShapeInfo *shapes, short firstTV, short numTVs, short *tvOrdering, short flip_axis);
    void UpdateImages();
    void SetAvailableText(short textID, short x, short y);
    void SetAvailableIcon(short icon, short numFrames, short x, short y, tTexture_ShapeInfo *iconImages);
    void SetOffset(short x, short y);
    void SetAvailable(short avail);
    void SetValid(short valid);
    void UpdateTransition();
    void Draw();
    void TurnOff();
    void TurnOffInstant();
    void TurnOn();
};

struct tOverlay {   /* 24 bytes */
    RECT               location[2];   /* +0x0 */
    short              transition, delta, direction, ID;   /* +0x10 */
};

struct tScreenCarSelect {   /* 928 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    tOverlay           fOverlays[7];   /* +0x64 */
    tOverlay           *fCurrentOverlays[4];   /* +0x10C */
    short              fState, fPreviousCar, fPreviousCarID, fPreviousCountry;   /* +0x11C */
    tTVConfig          tvConfigs[10];   /* +0x124 */
    tVideoWall         fVideoWall[2];   /* +0x304 */
    short              fBrightness[2], fDestBrightness[2];   /* +0x374 */
    long               fFadeTicks[2];   /* +0x37C */
    BOOL               fTVsInitialized, fInShowroom;   /* +0x384 */
    u_long             fShowroomTicks, fSpeechTicks;   /* +0x38C */
    BOOL               fSpeechPlayed;   /* +0x394 */
    int                fSplineInterval;   /* +0x398 */
    u_long             fCameraRotation;   /* +0x39C */
    /* --- reconstructed member fns (ScreenCarSelect.obj; non-virtual, ABI-neutral) --- */
    tScreenCarSelect();
    ~tScreenCarSelect();
    void Cleanup();
    void DrawOverlay(tOverlay *overlay);
    void SetState(int state);
    void CalcSplinePosition(int a, int b, int c, int d, u_long e, int &x, int &y, int &z, int &w, int &v);
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void UpdateVideoWall(tCarInfo &car);
    void AllocateAsyncBuffer();
    void FreeAsyncBuffer();
    void InitializeVideoWall();
    void Initialize();
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);  /* returns menu-cmd value */
    void DrawVideoWall(short s);
    int GetCar(tCarInfo &car);
    void SetBrightness(short a, short b);
    void UpdateBrightness(short s);
    void DrawBackground();
    void DrawSliders(tCarInfo &car, short a, short b);
    void DrawForeground();
};

struct tScreenCarSelectDuel {   /* 976 bytes */
    tScreenCarSelect   _base_tScreenCarSelect;   /* +0x0 */
    short              fPreviousOpponent;   /* +0x3A0 */
    BOOL               fOpponentTVsInitialized;   /* +0x3A4 */
    tShapeInformation  fOpponentShapes;   /* +0x3A8 */
    /* --- reconstructed member fns (Duel) --- */
    ~tScreenCarSelectDuel();
    void PreLoad();
    void AllocateAsyncBuffer();
    void FreeAsyncBuffer();
    void InitializeVideoWall();
    void Initialize();
    void Cleanup();
    void DrawVideoWall(short s);
    void DrawOpponentVideoWall(short s);
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void UpdateVideoWall(tCarInfo &car);
    void UpdateOpponentVideoWall(tCarInfo &car);
    void DrawBackground();
    void DrawForeground();
};

struct tScreenCarSelectTwoPlayer {   /* 1080 bytes */
    tScreenCarSelect   _base_tScreenCarSelect;   /* +0x0 */
    tDialogBackUpOnly  CarDialog;   /* +0x3A0 */
    /* --- reconstructed member fns (TwoPlayer) --- */
    ~tScreenCarSelectTwoPlayer();
    int GetCar(tCarInfo &car);
    void DrawVideoWall(short s);
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void UpdateVideoWall(tCarInfo &car);
    void TurnOffVideoWall();
    void DrawBackground();
    void DrawForeground();
    void SetDialog();
    void AllocateAsyncBuffer();
    void InitializeVideoWall();
    void Initialize();
    void Cleanup();
};

struct tScreenPinkSlipsCarSelect {   /* 1100 bytes */
    tScreenCarSelectTwoPlayer _base_tScreenCarSelectTwoPlayer;   /* +0x0 */
    int                waitfordialog;   /* +0x438 */
    CARDINFO_def       *pCI;   /* +0x43C */
    int                fStartCheckTick;   /* +0x440 */
    BOOL               fCardFailed, fExitingScreen;   /* +0x444 */
    /* --- reconstructed member fns (PinkSlips) --- */
    ~tScreenPinkSlipsCarSelect();
    int GetCar(tCarInfo &car);
    void DrawBackground();
    void DoMemCardStuff();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void SetDialog();
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);  /* returns menu-cmd value */
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
};

struct tScreenTournSelect {   /* 712 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    int                hVideo, fFrame;   /* +0x64 */
    tTVConfig          tvConfigs[8];   /* +0x6C */
    tTVConfig          trophyTV[4];   /* +0x1EC */
    short              fPreviousMovie, fCurrentMovie;   /* +0x2AC */
    u_long             fStartTicks, fTVTicks;   /* +0x2B0 */
    short              fTransitionDirection;   /* +0x2B8 */
    char               fPreviousTrophy;   /* +0x2BA */
    BOOL               fTVsInitialized;   /* +0x2BC */
    int                PreCalculatedTournamentY, fPrevi;   /* +0x2C0 */
    /* --- reconstructed member fns (ScreenTournSelect.obj; non-virtual, ABI-neutral) --- */
    tScreenTournSelect();
    ~tScreenTournSelect();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void UpdateVideoWall(tTourneyInfo *tourn);
    void DrawVideoWall();
    void DrawBackground();
    void DrawForeground();
};

struct tScreenPinkSlipStandings {   /* 148 bytes */
    tScreenTournamentStandings3item _base_tScreenTournamentStandings3item;   /* +0x0 */
    void DrawBackground();
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);  /* returns menu-cmd value */
    ~tScreenPinkSlipStandings();
};

struct tScreenTrophyRoom {   /* 344 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    tShapeInformation  fTrophyShapes;   /* +0x64 */
    short              fNumTrophies;   /* +0x8C */
    int                startTicks;   /* +0x90 */
    short              fShapeCount;   /* +0x94 */
    BOOL               fLoadingTrophy;   /* +0x98 */
    char               fPreviousTrophy, fDoUpdate;   /* +0x9C */
    BOOL               fClearScreen;   /* +0xA0 */
    char               fBrightness;   /* +0xA4 */
    u_long             fStartTicks;   /* +0xA8 */
    short              fTextInfo[16];   /* +0xAC */
    char               thisisuseless;   /* +0xCC */
    int                tier;   /* +0xD0 */
    short              fRealCurrentTourn[2];   /* +0xD4 */
    short              fTrophyList[64];   /* +0xD8 */
    /* --- reconstructed member fns (ScreenTrophyRoom.obj; non-virtual, ABI-neutral) --- */
    tScreenTrophyRoom();
    ~tScreenTrophyRoom();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    void PreLoad();
    void Initialize();
    void Cleanup();
    void DrawBackground();
    void LoadTrophy();
};

struct tScreenTrophyInfo {   /* 104 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    int                BannerCol;   /* +0x64 */
    /* --- reconstructed member fns (ScreenTrophyInfo.obj; non-virtual, ABI-neutral) --- */
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawBackground();
    ~tScreenTrophyInfo();
};

struct tScreenDisplay {   /* 100 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    /* --- reconstructed member fns (ScreenDisplay.obj; non-virtual, ABI-neutral) --- */
    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    ~tScreenDisplay();
};

struct tScreenAudio {   /* 124 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    short              fShapeCount;   /* +0x64 */
    char               prevAudioMode;   /* +0x66 */
    short              audioTest;   /* +0x68 */
    int                audioTestHandle;   /* +0x6C */
    short              fPrevSelectedSong;   /* +0x70 */
    char               fCurrentAudioMode;   /* +0x72 */
    short              fSelectedSong;   /* +0x74 */
    AudioMus_tSongList *songlist;   /* +0x78 */
    /* --- reconstructed member fns (ScreenAudio.obj; non-virtual, ABI-neutral) --- */
    void PlaySound();
    void DrawForeground();
    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    tScreenAudio();
    void Initialize();
    void Cleanup();
    ~tScreenAudio();
};

struct tScreenMemcard {   /* 1444 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    int                theNFS4icon, card;   /* +0x64 */
    CARDINFO_def       *pCI;   /* +0x6C */
    char               fMemTitle[15][32];   /* +0x70 */
    char               goticon[15];   /* +0x250 */
    u_char             numicon[15], numblock[15];   /* +0x25F */
    MCRDFILE_def       fMemFile[15];   /* +0x280 */
    u_short            fMemIconClutId[15];   /* +0x514 */
    short              fFadeIcon[15];   /* +0x532 */
    BOOL               fReadyToGetNewIcons, fInitedMemCard;   /* +0x550 */
    char               fMemCardMessage[40];   /* +0x558 */
    int                fMemCardMessageTextSys, message;   /* +0x580 */
    short              memcardanimframe, count, cursorPosition;   /* +0x588 */
    int                checkingstart;   /* +0x590 */
    BOOL               fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons;   /* +0x594 */
    int                fScreenFadeReadyTick;   /* +0x598 */
    short              player;   /* +0x59C */
    BOOL               fGetNewIcons;   /* +0x5A0 */
    /* --- reconstructed member fns (ScreenMemcard.obj; non-virtual, ABI-neutral) --- */
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawIcon(shapetbl *icon, int x, int y, int destwidth, int destheight, short fFade);
    void LoadIcon(int filenum);
    void DrawVerticalLine(short x, short y, short gridpos, short dir);
    void DrawHorizontalLine(short x, short y, short gridpos, short dir);
    void PlaceIcons(int i, int fadeval);
    void DrawMemCardStuff(short fadeval);
    void SetEnablings();
    void DrawBackground();
    void DrawForeground();
    tScreenMemcard();
    void ReleaseIcons();
    void Initialize();
    void Cleanup();
    ~tScreenMemcard();
};

struct tScreenCongrats {   /* 388 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    int                congratsMessage, trophy, smallSpinningThing, fNumSpinShapes, fNumSmallSpinShapes, fCarPlayer;   /* +0x64 */
    long               TotalCash, CashAwarded;   /* +0x7C */
    int                framenum, starttick;   /* +0x84 */
    BOOL               InExtraSpin;   /* +0x8C */
    int                InExtraSpinTick;   /* +0x90 */
    tCarInfo           fCarInfo;   /* +0x94 */
    BOOL               fGotCar;   /* +0x160 */
    int                fEnterTick;   /* +0x164 */
    BOOL               fCountedDown, fStartCountdownNOW;   /* +0x168 */
    int                fCountSpeed, fSpeechToPlay;   /* +0x170 */
    short              fCarX, fCarY;   /* +0x178 */
    float              fCarCX, fCarCY;   /* +0x17C */
    /* reconstructed member fns (non-virtual decls; ABI-neutral) */
    void Cleanup();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    int GetCar(tCarInfo &car);
    void DrawBackground();
    void DrawForeground();
    void CalculatePrizes();
    void Initialize();
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    ~tScreenCongrats();
};

struct tScreenTournamentTrophy {   /* 392 bytes */
    tScreenCongrats    _base_tScreenCongrats;   /* +0x0 */
    short              fShapeCount;   /* +0x184 */
    char               fDoUpdate;   /* +0x186 */
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    int GetCar(tCarInfo &car);
    void DrawCongratsMessage();
    void CalculatePrizes();
    ~tScreenTournamentTrophy();
};

struct tScreenPinkSlipCongrats {   /* 392 bytes */
    tScreenCongrats    _base_tScreenCongrats;   /* +0x0 */
    short              fWinner;   /* +0x184 */
    void DrawCongratsMessage();
    int GetCar(tCarInfo &car);
    void CalculatePrizes();
    void Initialize();
    void Cleanup();
    ~tScreenPinkSlipCongrats();
};

struct tScreenBeTheCopCongrats {   /* 388 bytes */
    tScreenCongrats    _base_tScreenCongrats;   /* +0x0 */
    int GetCar(tCarInfo &car);
    void CalculatePrizes();
    void DrawCongratsMessage();
    ~tScreenBeTheCopCongrats();
};

struct tScreenTournamentCongrats {   /* 388 bytes */
    tScreenCongrats    _base_tScreenCongrats;   /* +0x0 */
    int GetCar(tCarInfo &car);
    void CalculatePrizes();
    void DrawCongratsMessage();
    ~tScreenTournamentCongrats();
};

struct tScreenTrackRecords {   /* 116 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    tRecordBuffer      *TrackRecords;   /* +0x64 */
    int                flare_intensity, flareextra;   /* +0x68 */
    BOOL               fReadNewData;   /* +0x70 */
    /* --- reconstructed member fns (ScreenTrackRecords.obj; non-virtual, ABI-neutral) --- */
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void DrawOneRecord(int index, bool newrecord, int y);
    void DrawRecords(short maxitem);
    void DrawBackground();
    ~tScreenTrackRecords();
};

struct tScreenTrackSelect {   /* 672 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    int                hVideo, fFrame;   /* +0x64 */
    short              fPreviousTrack, fMovieTrack, fBrightness, fDestBrightness, fStartBrightness;   /* +0x6C */
    u_long             fStartTicks;   /* +0x78 */
    BOOL               fTicksSet;   /* +0x7C */
    tTVConfig          tvConfigs[10];   /* +0x80 */
    tVideoWall         fVideoWall;   /* +0x260 */
    BOOL               fTVsInitialized;   /* +0x298 */
    u_long             fVideoTicks;   /* +0x29C */
    /* --- reconstructed member fns (ScreenTracks.obj; non-virtual, ABI-neutral) --- */
    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void SetBrightness(short bright);
    void UpdateBrightness(tTrackInformation &trackInfo);
    void UpdateVideoWall(tTrackInformation &trackInfo);
    void DrawVideoWall();
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);  /* returns menu-cmd value */
    ~tScreenTrackSelect();
};

struct tScreenTrackInfo {   /* 676 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    tTrackInfo         fTrack;   /* +0x64 */
    tTVConfig          tvConfigs[10];   /* +0x8C */
    tVideoWall         fVideoWall;   /* +0x26C */
    /* --- reconstructed member fns (ScreenTrackInfo.obj; non-virtual, ABI-neutral) --- */
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawBackground();
    void Initialize();
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    ~tScreenTrackInfo();
};

struct tScreenPinkSlips {   /* 712 bytes */
    tScreen            _base_tScreen;   /* +0x0 */
    tMenu              *fMenu;   /* +0x64 */
    int                hVideo, fFrame;   /* +0x68 */
    short              fPreviousTrack, fBrightness, fDestBrightness, fStartBrightness;   /* +0x70 */
    u_long             fStartTicks, fTVTicks;   /* +0x78 */
    char               fTransitionDirection;   /* +0x80 */
    tTVConfig          fTrackTVs[8];   /* +0x84 */
    tTVConfig          fImageTVs[4];   /* +0x204 */
    BOOL               fTVsInitialized;   /* +0x2C4 */
    /* methods (non-virtual decls; storage-neutral) — ScreenPinkSlips.obj */
    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void UpdateVideoWall(tTrackInformation &trackInfo);
    void DrawVideoWall();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    ~tScreenPinkSlips();
};

struct tAllScreens {   /* 15320 bytes */
    tScreenMain        screenMain;   /* +0x0 */
    tScreenCarSelect   screenCarSelect;   /* +0x5B8 */
    tScreenCarSelectDuel screenCarSelectDuel;   /* +0x958 */
    tScreenCarSelectTwoPlayer screenCarSelectTwoPlayer, screenCarSelectPlayerTwo;   /* +0xD28 */
    tScreenPinkSlipsCarSelect screenPinkSlipsCarSelectTwoPlayer, screenPinkSlipsCarSelectPlayerTwo;   /* +0x1598 */
    tScreenTrackRecords screenTrackRecords;   /* +0x1E30 */
    tScreenTrackInfo   screenTrackInfo;   /* +0x1EA4 */
    tScreenTrackSelect screenTrackSelect;   /* +0x2148 */
    tScreenTournSelect screenTournSelect;   /* +0x23E8 */
    tScreenTournamentStandings screenTournamentStandings;   /* +0x26B0 */
    tScreenTournamentTrophy screenTournamentTrophy;   /* +0x2744 */
    tScreenTrophyRoom  screenTrophyRoom;   /* +0x28CC */
    tScreenTrophyInfo  screenTrophyInfo;   /* +0x2A24 */
    tScreenControllerConfig screenControllerConfig;   /* +0x2A8C */
    tScreenDisplay     screenDisplay;   /* +0x2C08 */
    tScreenAudio       screenAudio;   /* +0x2C6C */
    tScreenMemcard     screenMemcard;   /* +0x2CE8 */
    tScreenUserName    screenUserName;   /* +0x328C */
    tScreenPinkSlipCongrats screenPinkSlipCongrats;   /* +0x3358 */
    tScreenPinkSlipStandings screenPinkSlipStandings;   /* +0x34E0 */
    tScreenTournamentStandings3item screenTournamentStandings3item;   /* +0x3574 */
    tScreenPinkSlips   screenPinkSlips;   /* +0x3608 */
    tScreenBeTheCopCongrats screenBeTheCopCongrats;   /* +0x38D0 */
    tScreenTournamentCongrats screenTournamentCongrats;   /* +0x3A54 */
    tAllScreens();
    ~tAllScreens();
};

struct tPerpModelList {   /* 8 bytes */
    int                carModel;   /* +0x0 */
    char               carColor;   /* +0x4 */
};

struct tFEStream {   /* 744 bytes */
    short              totalCars, totalModels, currentCar, numPlayers;   /* +0x0 */
    tCarInfo           playerCars[2];   /* +0x8 */
    short              numOpponents;   /* +0x1A0 */
    tCarLineup         carLineup[6];   /* +0x1A4 */
    short              numCops, numSuperCops;   /* +0x21C */
    int                copCars[6];   /* +0x220 */
    short              copCountry[6];   /* +0x238 */
    short              numTraffic;   /* +0x244 */
    short              trafficCars[6];   /* +0x246 */
    short              numPerpObjects, numPerps;   /* +0x252 */
    tMissionInfo       *pMission;   /* +0x258 */
    tStageInfo         *pStages;   /* +0x25C */
    tPerpModelList     perps[6];   /* +0x260 */
    tTrackInformation  trackInfo;   /* +0x290 */
    tTrackInfo         track;   /* +0x2C0 */
};

struct tCarInLineup {   /* 4 bytes */
    char               isPlayerCar, isAlive, AIPersonality, LineupPosition;   /* +0x0 */
};

struct tGlobalMenuDefs {   /* 15128 bytes */
    tMenuItemGoToMenuNFS4Button itemMainOnePlayerRace, itemMainTwoPlayerRace, itemMainTrophyRoom, itemMainOptions;   /* +0x0 */
    tMenuNFS4          menuMain;   /* +0xB0 */
    tMenuItemGoToMenuNFS4Button itemTournTrophyRoom, itemSETrophyRoom;   /* +0x12C */
    tMenuNFS4          menuTrophyRoomSelect;   /* +0x184 */
    tMenuBlank         menuTrophyInfo;   /* +0x200 */
    tMenuItemGoToMenuNFS4Button itemSkillBeginner, itemSkillIntermediate, itemSkillExpert;   /* +0x27C */
    tMenuNFS4          menuSkillLevel;   /* +0x300 */
    tMenuItemGoToMenuNFS4Button itemOnePlayerTestDrive, itemOnePlayerSingleRace, itemOnePlayerPursuit, itemOnePlayerTournament, itemOnePlayerSpecialEvents;   /* +0x37C */
    tMenuNFS4          menuOnePlayer;   /* +0x458 */
    tMenuItemGoToMenuNFS4Button itemSingleRaceSolo, itemSingleRaceDuel, itemSingleRaceFullGrid;   /* +0x4D4 */
    tMenuNFS4          menuSingleRace;   /* +0x558 */
    tMenuItemGoToMenuNFS4Button itemHotPursuitSolo, itemHotPursuitDuel;   /* +0x5D4 */
    tMenuNFS4          menuHotPursuit;   /* +0x62C */
    tListIteratorTournament iteratorTournament;   /* +0x6A8 */
    tMenuItemGoToMenuNFS4Button itemTournamentContinue;   /* +0x6BC */
    tMenuItemNFS4LeftRightChoice itemTournamentSelect;   /* +0x6E8 */
    tMenuNFS4          menuTournament;   /* +0x710 */
    tListIteratorTournament iteratorSpecialEvent;   /* +0x78C */
    tMenuItemGoToMenuNFS4Button itemSpecialEventContinue;   /* +0x7A0 */
    tMenuItemNFS4LeftRightChoice itemSpecialEventSelect;   /* +0x7CC */
    tMenuNFS4          menuSpecialEvent;   /* +0x7F4 */
    tMenuItemGoToMenuNFS4Button itemTwoPlayerTestDrive, itemTwoPlayerDuel, itemTwoPlayerHotPursuit, itemTwoPlayerPinkSlips;   /* +0x870 */
    tMenuNFS4          menuTwoPlayer;   /* +0x920 */
    tMenuItemGoToMenuNFS4Button itemBestOfOne, itemBestOfThree, itemBestOfFive;   /* +0x99C */
    tMenuNFS4          menuPinkSlipSelect;   /* +0xA20 */
    tMenuItemGoToMenuNFS4Button itemPinkSlipsContinue;   /* +0xA9C */
    tMenuItemNFS4LeftRightChoice itemTrack1, itemTrack2, itemTrack3, itemTrack4, itemTrack5;   /* +0xAC8 */
    tMenuNFS4          menuPinkSlipsBestOfThree, menuPinkSlipsBestOfFive;   /* +0xB90 */
    tListIteratorTrack iteratorTrack;   /* +0xC88 */
    tMenuItemGoToMenuNFS4Button itemTrackContinue;   /* +0xCA0 */
    tMenuItemNFS4LeftRightChoice itemTrack;   /* +0xCCC */
    tMenuItemGoToMenuNFS4Button itemTrackRecords;   /* +0xCF4 */
    tMenuNFS4          menuSingleTrackSelect, menuTestDriveTrackSelect;   /* +0xD20 */
    tListIteratorIndexed iteratorLaps, iteratorTrackDirection, iteratorTrackMirrored, iteratorTimeOfDay, iteratorWeather, iteratorTraffic;   /* +0xE18 */
    tListIterator      iteratorLocalSpeech;   /* +0xE90 */
    tMenuItemOptionsLeftRightChoice itemLaps, itemTrackDirection;   /* +0xEA0 */
    tMenuItemOptionsTwoItemChoice itemTrackMirrored, itemTimeOfDay, itemWeather, itemTraffic, itemLocalSpeech;   /* +0xEE0 */
    tMenuOptions       menuTrackOptions;   /* +0xF94 */
    tBlankMenuItemGoToMenuNFS4Button menuTrackRecordsItem;   /* +0x1018 */
    tOptionsMenu       menuTrackRecords;   /* +0x1044 */
    tMenuItemGoToMenuNFS4Button itemTrackInfoContinue;   /* +0x10C4 */
    tMenuNFS4          menuTrackInfo;   /* +0x10F0 */
    tListIteratorCar   iteratorCar1;   /* +0x116C */
    tListIteratorCarColor iteratorColor;   /* +0x1188 */
    tMenuItemGoToMenuNFS4Button itemCarSelectRace;   /* +0x11A8 */
    tMenuItemNFS4LeftRightChoice itemCar, itemColor;   /* +0x11D4 */
    tMenuItemGoToMenuNFS4Button itemShowcase;   /* +0x1224 */
    tMenuNFS4          menuSingleCarSelect;   /* +0x1250 */
    tListIteratorCar   iteratorGarageCar;   /* +0x12CC */
    tMenuItemNFS4LeftRightChoice itemGarageCar;   /* +0x12E8 */
    tMenuItemGoToMenuNFS4Button itemCarDealer, itemUpgradeCar;   /* +0x1310 */
    tMenuNFS4          menuCarGarage, menuPostCarGarage;   /* +0x1368 */
    tListIteratorCar   iteratorOpponentCar;   /* +0x1460 */
    tMenuItemGoToMenuNFS4Button itemDuelRace;   /* +0x147C */
    tMenuItemNFS4LeftRightChoice itemCar2, itemColor2;   /* +0x14A8 */
    tMenuItemGoToMenuNFS4Button itemGoToDuelBuyCar;   /* +0x14F8 */
    tMenuItemNFS4LeftRightChoice itemOpponentCar;   /* +0x1524 */
    tMenuNFS4          menuDuelCarSelect, menuHPDuelCarSelect;   /* +0x154C */
    tMenuItemGoToMenuNFS4Button itemPlayerOneRace;   /* +0x1644 */
    tMenuItemNFS4LeftRightChoice itemCarP1, itemColorP1;   /* +0x1670 */
    tMenuNFS4TwoPlayer menuPlayerOneCarSelect;   /* +0x16C0 */
    tMenuItemGoToMenuNFS4Button itemPlayerTwoRace;   /* +0x173C */
    tMenuItemNFS4LeftRightChoice itemCarP2, itemColorP2;   /* +0x1768 */
    tMenuNFS4TwoPlayer menuPlayerTwoCarSelect;   /* +0x17B8 */
    tMenuItemGoToMenuNFS4Button itemPlayerOneGarageRace;   /* +0x1834 */
    tMenuItemNFS4LeftRightChoice itemGarageCarP1;   /* +0x1860 */
    tMenuNFS4TwoPlayer menuPlayerOneGarage;   /* +0x1888 */
    tMenuItemGoToMenuNFS4Button itemPlayerTwoGarageRace;   /* +0x1904 */
    tMenuItemNFS4LeftRightChoice itemGarageCarP2;   /* +0x1930 */
    tMenuNFS4TwoPlayer menuPlayerTwoGarage;   /* +0x1958 */
    tListIteratorCar   iteratorPinkSlipsCar;   /* +0x19D4 */
    tMenuItemGoToMenuNFS4Button itemPlayerOnePinkSlipRace;   /* +0x19F0 */
    tMenuItemNFS4LeftRightChoice itemPinkSlipCarP1;   /* +0x1A1C */
    tMenuNFS4TwoPlayer menuPlayerOnePinkSlipCarSelect;   /* +0x1A44 */
    tMenuItemGoToMenuNFS4Button itemPlayerTwoPinkSlipRace;   /* +0x1AC0 */
    tMenuItemNFS4LeftRightChoice itemPinkSlipCarP2;   /* +0x1AEC */
    tMenuNFS4TwoPlayer menuPlayerTwoPinkSlipCarSelect;   /* +0x1B14 */
    tMenuItemGoToMenuNFS4Button itemGoToBuyCar, itemGoToSellCar;   /* +0x1B90 */
    tMenuNFS4          menuGoToCarDealer;   /* +0x1BE8 */
    tListIteratorCar   iteratorDealerCar;   /* +0x1C64 */
    tListIteratorCarColor iteratorDealerColor;   /* +0x1C80 */
    tMenuItemNFS4LeftRightChoice itemDealerCar, itemDealerColor;   /* +0x1CA0 */
    tMenuItemGoToMenuNFS4Button itemBuyCar, itemDealerShowroom;   /* +0x1CF0 */
    tMenuNFS4          menuCarDealer;   /* +0x1D48 */
    tListIteratorCar   iteratorSellerCar;   /* +0x1DC4 */
    tMenuItemNFS4LeftRightChoice itemSellerCar;   /* +0x1DE0 */
    tMenuItemGoToMenuNFS4Button itemSellCar;   /* +0x1E08 */
    tMenuNFS4          menuCarSeller;   /* +0x1E34 */
    tMenuItemGoToMenuNFS4Button itemPurchaseUpgrade1, itemPurchaseUpgrade2, itemPurchaseUpgrade3;   /* +0x1EB0 */
    tMenuNFS4          menuCarUpgrades;   /* +0x1F34 */
    tListIteratorIndexed iteratorTransmission, iteratorABS;   /* +0x1FB0 */
    tListIterator      iteratorDamage, iteratorOpponentUpgrades;   /* +0x1FD8 */
    tMenuItemOptionsLeftRightChoice itemTransmission, itemABS, itemDamage, itemTransmission2, itemABS2, itemDamage2, itemOpponentUpgrades;   /* +0x1FF8 */
    tMenuOptions       menuCarOptions, menuCarOptionsPlayerOne, menuCarOptionsPlayerTwo, menuPinkSlipCarOptionsPlayerOne, menuPinkSlipCarOptionsPlayerTwo;   /* +0x20D8 */
    tMenuBlank         menuShowroom;   /* +0x236C */
    tMenuItemGoToMenuNFS4Button itemOptionsAudio, itemOptionsDisplay, itemOptionsControllers, itemOptionsMemoryCard, itemOptionsUsername, itemOptionsCredits;   /* +0x23E8 */
    tMenuNFS4          menuOptions;   /* +0x24F0 */
    tListIteratorRange iteratorMusicVolume, iteratorSoundEffectsVolume, iteratorEngineVolume, iteratorSpeechVolume, iteratorAmbientVolume;   /* +0x256C */
    tListIterator      iteratorAudioMode;   /* +0x25BC */
    tMenuItemLeftRightAudioSlider itemMusicVolume, itemSoundEffectsVolume, itemEngineVolume, itemSpeechVolume, itemAmbientVolume;   /* +0x25CC */
    tMenuItemDisplayLeftRightChoice itemAudioMode;   /* +0x26E4 */
    tMenuItemSlidingActivated itemSlidingPlayList;   /* +0x2710 */
    tInsideBoxSongMenu menuPlayListMenu;   /* +0x2758 */
    tOptionsMenu       menuAudio;   /* +0x27E0 */
    tListIteratorIndexed iteratorDisplaySpeedometer, iteratorDisplayMap, iteratorDisplayOpponentID, iteratorDisplayTime, iteratorDisplayPosition, iteratorDisplayLapNumber;   /* +0x2860 */
    tListIterator      iteratorDisplaySplitTime;   /* +0x28D8 */
    tListIteratorIndexed iteratorDisplaySplitDisplay;   /* +0x28E8 */
    tMenuItemDisplayLeftRightChoice itemDisplaySpeedometer, itemDisplayMap, itemDisplayOpponentID;   /* +0x28FC */
    tMenuItemOnOffLeftRightChoice itemDisplayTime, itemDisplayPosition, itemDisplayLapNumber;   /* +0x2980 */
    tMenuItemDisplayLeftRightChoice itemDisplaySplitTime, itemDisplaySplitDisplay;   /* +0x2A10 */
    tOptionsMenu       menuDisplayOptions;   /* +0x2A68 */
    tListIteratorIndexed iteratorControllerConfigSelected;   /* +0x2AE8 */
    tMenuItemControllerLeftRightChoice itemControllerConfigSelected;   /* +0x2AFC */
    tMenuItemSlidingMenu itemControllerSettings;   /* +0x2B28 */
    tOptionsMenu       menuControllerConfig;   /* +0x2B6C */
    tListIteratorRangeIndexed iteratorControllerShockMode;   /* +0x2BEC */
    tInsideBoxControllerLeftRightSlider itemControllerShockMode;   /* +0x2C00 */
    tListIteratorRangeIndexed iteratorControllerShockImpact;   /* +0x2C28 */
    tInsideBoxControllerLeftRightSlider itemControllerShockImpact;   /* +0x2C3C */
    tListIteratorRangeIndexed iteratorControllerSteeringRange1;   /* +0x2C64 */
    tInsideBoxTwoWaySlider itemControllerSteeringRange1;   /* +0x2C78 */
    tListIteratorRangeIndexed iteratorControllerDeadSpot1;   /* +0x2CA8 */
    tInsideBoxTwoWaySlider itemControllerDeadSpot1;   /* +0x2CBC */
    tListIteratorRangeIndexed iteratorControllerSteeringRange2;   /* +0x2CEC */
    tInsideBoxTwoWaySlider itemControllerSteeringRange2;   /* +0x2D00 */
    tListIteratorRangeIndexed iteratorControllerDeadSpot2;   /* +0x2D30 */
    tInsideBoxTwoWaySlider itemControllerDeadSpot2;   /* +0x2D44 */
    tListIteratorRangeIndexed iteratorControllerJoyRange;   /* +0x2D74 */
    tInsideBoxTwoWaySlider itemControllerJoyRange;   /* +0x2D88 */
    tListIteratorRangeIndexed iteratorControllerCenterPoint;   /* +0x2DB8 */
    tInsideBoxTwoWaySlider itemControllerCenterPoint;   /* +0x2DCC */
    tListIteratorRangeIndexed iteratorControllerIMax;   /* +0x2DFC */
    tInsideBoxTwoWaySlider itemControllerIMax;   /* +0x2E10 */
    tListIteratorRangeIndexed iteratorControllerIIMax;   /* +0x2E40 */
    tInsideBoxTwoWaySlider itemControllerIIMax;   /* +0x2E54 */
    tInsideBoxMenu     menuControllerDualShock, menuControllerAnalog, menuControllerDualShockAnalog, menuControllerNegcon;   /* +0x2E84 */
    tMemoryCardMenuItem itemSaveGame, itemLoadGame;   /* +0x3054 */
    tOptionsMenu       menuMemory;   /* +0x30AC */
    tUserNameMenuItem  menuItemUserName, menuItemUserName1, menuItemUserName2;   /* +0x312C */
    tOptionsMenu       menuUserName;   /* +0x32D0 */
    tListIterator      iteratorChangeTrophy;   /* +0x3350 */
    tBlankMenuItemNFS4LeftRightChoice itemChangeTrophy;   /* +0x3360 */
    tMenuNFS4Bottom    menuTrophyRoom;   /* +0x3388 */
    tMenuItemGoToMenuNFS4Button itemPinkSlipStandingsForward, itemPinkSlipStandingsExit;   /* +0x3404 */
    tMenuNFS4          menuPinkSlipStandings;   /* +0x345C */
    tMenuItemGoToMenuNFS4Button itemTournStandingsForward, itemTournStandingsExit;   /* +0x34D8 */
    tMenuNFS4          menuTournamentStandings;   /* +0x3530 */
    tMenuItemGoToMenuNFS4Button itemTournamentFinishedHome;   /* +0x35AC */
    tMenuNFS4          menuTournamentFinished;   /* +0x35D8 */
    tMenuBlank         menuTournamentTrophy;   /* +0x3654 */
    tOptionsMenu       menuPostGamePlayer1Name, menuPostGamePlayer2Name;   /* +0x36D0 */
    tBlankMenuItemGoToMenuNFS4Button itemPostGameTrackRecordsContinue;   /* +0x37D0 */
    tOptionsMenu       menuPostGameTrackRecords;   /* +0x37FC */
    tMenuBlank         menuPinkSlipCongrats, menuBeTheCopCongrats, menuTierCompleteCongrats, menuCredits;   /* +0x387C */
    tMemoryCardMenuItem itemMemContinue;   /* +0x3A6C */
    tOptionsMenu       menuPostGameSave;   /* +0x3A98 */
    /* ctor/dtor (non-virtual decls) — FEMenuDefs.obj */
    tGlobalMenuDefs();
    ~tGlobalMenuDefs();
};

struct tMemCardData {   /* 5292 bytes */
    u_long             fSize, bonus;   /* +0x0 */
    tfrontEnd          frontEnd;   /* +0x8 */
    tSaveCarInfo       carInfo;   /* +0x458 */
    tSaveTrackInfo     trackInfo;   /* +0x538 */
    tSaveTournament    tournament;   /* +0x548 */
    tRecordBuffer      records[187];   /* +0x5F8 */
    u_long             pinkSlipsNoCheat, frontEndCRC, carInfoCRC, trackInfoCRC, tournamentCRC, recordsCRC;   /* +0x1494 */
};

struct MCRDOPTS_def {   /* 36 bytes */
    PRODUCTLOC         productLocation;   /* +0x0  (SYM ENUM PRODUCTLOC) */
    char               *productCode;   /* +0x4 */
    int                bMoveIconsToVram;   /* +0x8 */
    RECT               VramIconArea;   /* +0xC */
    void               *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;   /* +0x14 */
};

struct tVideoWallConfig {   /* 20 bytes */
    short              numVideos, flags;   /* +0x0 */
    tVideo             *videos[4];   /* +0x4 */
};

struct tVertex {   /* 4 bytes */
    short              x, y;   /* +0x0 */
};

#ifndef NFS4_PSYQ_HEADERS
struct LINE_F2 {   /* 16 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_char             r0, g0, b0, code;   /* +0x4 */
    short              x0, y0, x1, y1;   /* +0x8 */
};
#endif

struct CdlFILE {   /* 24 bytes (PsyQ libcd) */
    CdlLOC             pos;   /* +0x0 */
    u_long             size;   /* +0x4 */
    char               name[16];   /* +0x8 */
};

struct DECENV {   /* 48 bytes */
    u_long             *vlcbuf[2];   /* +0x0 */
    int                vlcid;   /* +0x8 */
    u_short            *imgbuf;   /* +0xC */
    RECT               rect[2];   /* +0x10 */
    int                rectid;   /* +0x20 */
    RECT               slice;   /* +0x24 */
    int                isdone;   /* +0x2C */
};

struct CDSECTOR {   /* 28 bytes */
    u_short            id, type, secCount, nSectors;   /* +0x0 */
    u_long             frameCount, frameSize;   /* +0x8 */
    u_short            width, height;   /* +0x10 */
    u_long             headm, headv;   /* +0x14 */
};

#ifndef NFS4_PSYQ_HEADERS
struct DR_OFFSET {   /* 12 bytes (PsyQ libgpu) */
    u_long             tag;   /* +0x0 */
    u_long             code[2];   /* +0x4 */
};
#endif

struct fMemCardInfo_def {   /* 6108 bytes */
    PRODUCTLOC         productLocation;   /* +0x0  (SYM ENUM PRODUCTLOC) */
    char               productCode[16];   /* +0x4 */
    int                bMoveIconsToVram;   /* +0x14 */
    RECT               VramIconArea;   /* +0x18 */
    void               *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;   /* +0x20 */
    MANAGERTASK        task;   /* +0x30  (SYM ENUM MANAGERTASK) */
    int                bReady, fMultitap;   /* +0x34 */
    long               channel;   /* +0x3C */
    int                existencecheckticks[8];   /* +0x40 */
    MCRDFILEHEADER_def header;   /* +0x60 */
    MCRDFILEINFO_def   fileinfo;   /* +0x260 */
    CARDINFO_def       card[8];   /* +0x49C */
};

struct MDECSTRUCT {   /* 44 bytes */
    int                id, width, height, bpp;   /* +0x0 */
    RECT               framerect, striprect;   /* +0x10 */
    int                striprectsize;   /* +0x20 */
    u_long             *stripbuf, *vlcbuf;   /* +0x24 */
};

struct tMdecHandle {   /* 8 bytes */
    int                numhandles, hDecode;   /* +0x0 */
};

struct windowtbl {   /* 156 bytes */
    long               id;   /* +0x0 */
    int                x, y, width, height;   /* +0x4 */
    u_char             bpp, type, ram, unused;   /* +0x14 */
    int                minx, miny, maxx, maxy;   /* +0x18 */
    shapetbl           *shape;   /* +0x28 */
    DISPENV            dispenv;   /* +0x2C */
    DRAWENV            drawenv;   /* +0x40 */
};

struct STREAMCHUNKHDR {   /* 8 bytes */
    long               type, size;   /* +0x0 */
};

struct VIDEOSTRUCT {   /* 64 bytes */
    int                id, bufferwidth, bufferheight;   /* +0x0 */
    char               *streambuffer;   /* +0xC */
    int                mdechandle;   /* +0x10 */
    windowtbl          *frame;   /* +0x14 */
    long               videotap;   /* +0x18 */
    VIDEOSTATE         state;   /* +0x1C  (SYM: MOS ENUM tag VIDEOSTATE; renderer collapsed ENUM->int, corrected) */
    long               streamrequestid;   /* +0x20 */
    int                reftime, displaytime, displaytimefrac, displaytimeincr, framewidth, frameheight, droppedframes;   /* +0x24 */
};

struct ARGB {   /* 4 bytes */
    u_char             b, g, r, a;   /* +0x0 */
};

struct scoorddef {   /* 8 bytes */
    int                x, y;   /* +0x0 */
};

struct RPOINT {   /* 36 bytes */
    scoorddef          uv;   /* +0x0 */
    coorddef           xyz;   /* +0x8 */
    scoorddef          xy;   /* +0x14 */
    int                light;   /* +0x1C */
    ARGB               fog;   /* +0x20 */
};

struct PSXCDFILEINFO_def {   /* 20 bytes */
    u_char             name[12];   /* +0x0 */
    int                sector, length;   /* +0xC */
};

struct tPadModuleState {   /* 84 bytes */
    int                initialized;   /* +0x0 */
    PAD_COMMON         buf[8];   /* +0x4 */
    tActiveTime        state[8];   /* +0x44 */
};

/* ============ TYPEDEFS (aliases / fn-pointers / scalars / arrays) ============ */

typedef shapetbl SHAPE;
typedef coorddef LIBCOORD;
typedef matrixtdef MATRIX3DT;
typedef cdstreamstruct CDSTREAM;
typedef linedef LINE;
typedef COORD16 Transformer_zVertex;
typedef void *va_list;
typedef unsigned int u_int;
#ifndef NFS4_PSYQ_HEADERS
typedef void *physadr;
#endif
typedef long daddr_t;
typedef char *caddr_t;
typedef long *qaddr_t;
typedef u_long ino_t;
typedef long swblk_t;
typedef long time_t;
typedef short dev_t;
typedef long off_t;
typedef u_short uid_t;
typedef u_short gid_t;
typedef u_char nfs4_wchar_t;
typedef void (*VOIDFN)();
typedef int FILEOP;
typedef void FILE_CALLBACK();
typedef int FILE_ATOM();
typedef void THREADPROC();
typedef void THREAD2PROC();
typedef int SYSTEMTASK();
typedef int THREAD;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef int boolean;
typedef int fixed88;
typedef int fixed824;
typedef int fixed248;
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short *tPA32[32];
typedef void (*Sched_tFunctionPt)();
typedef Udff_tInfo *Udff_tHandle;
typedef int AIPerson_tGlueTable[21];
typedef AIScript_tReactionDetails AIScript_tScriptData[7];
typedef short Car_tAccTable[112];
typedef int CarLogic_tObservations[1][3];
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();
typedef char * (*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef long (*ReparmFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef tQuat Quatern_quat;
typedef tMenuItem *tItemList[16];
typedef tRecordBuffer tSaveRecords[187];
typedef void (*CdlCB)();
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];
typedef camera_info Camera_tInfo;
typedef camera_flags Camera_tFlags;
typedef dashhud_info DashHUD_tInfo;
typedef tPMenuItem *tPItemList[16];
typedef sim_queue SIM_QUEUE;
typedef void (*SpuIRQCallbackProc)();
typedef void (*SpuTransferCallbackProc)();
typedef void (*SpuStCallbackProc)();
typedef charactertbl FONTFILECHAR;
typedef eacelement EACELEMENT;
typedef unsigned int qfunc();
typedef TP_ZPaletteSystem TP_tZPaletteSystem;
typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;
typedef CARDINFO_def CARDINFO;
typedef MCRDFILEHEADER_def MCRDFILEHEADER;
typedef MCRDFILEINFO_def MCRDFILEINFO;
typedef short tArrowLocation[6];
typedef short tTextLocation[5];
typedef int (*menuDrivers_t)();
typedef MCRDFILE_def MCRDFILE;
typedef MCRDOPTS_def MCRDOPTS;
typedef void (*MemCB)();
typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;
typedef int FEVECTOR[4];
typedef int FEMATRIX[4][4];
typedef char tMemIcon[15][3][192];
typedef u_short DECDCTTAB[34816];
typedef void (*CallbackFunc)();
typedef fMemCardInfo_def fMemCardInfo;
typedef windowtbl WINDOW;
typedef scoorddef SCOORD;
typedef u_char *MEMBLOCK;
typedef PSXCDFILEINFO_def PSXCDFILEINFO;

#endif /* _NFS4_TYPES_H_ */
