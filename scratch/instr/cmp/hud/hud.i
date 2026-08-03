# 0 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
# 80 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
# 1 "C:/Temp/nfs4-wt46-a10/recon/nfs4_types.h" 1
# 22 "C:/Temp/nfs4-wt46-a10/recon/nfs4_types.h"
typedef unsigned long u_long;


typedef unsigned short u_short;


typedef unsigned char u_char;



typedef int BOOL;

typedef unsigned int size_t;


typedef unsigned char byte;
typedef unsigned int uint;

typedef unsigned short ushort;

typedef unsigned char uchar;
typedef unsigned char undefined;
# 70 "C:/Temp/nfs4-wt46-a10/recon/nfs4_types.h"
typedef struct MATRIX MATRIX;


typedef struct VECTOR VECTOR;


typedef struct SVECTOR SVECTOR;


typedef struct CVECTOR CVECTOR;


typedef struct DVECTOR DVECTOR;


typedef struct RVECTOR RVECTOR;


typedef struct CRVECTOR3 CRVECTOR3;


typedef struct CRVECTOR4 CRVECTOR4;


typedef struct RECT RECT;


typedef struct DR_ENV DR_ENV;


typedef struct DRAWENV DRAWENV;


typedef struct DISPENV DISPENV;


typedef struct DR_MODE DR_MODE;

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

typedef struct POLY_GT4 POLY_GT4;

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

typedef struct POLY_F4 POLY_F4;


typedef struct POLY_FT4 POLY_FT4;


typedef struct DR_STP DR_STP;

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

typedef struct POLY_FT3 POLY_FT3;


typedef struct POLY_G3 POLY_G3;

typedef struct DrawC_tEnvMap DrawC_tEnvMap;

typedef struct POLY_GT3 POLY_GT3;


typedef struct DR_TWIN DR_TWIN;

typedef struct Trk_Line Trk_Line;
typedef struct Draw_tGiveShelbyMoreCache Draw_tGiveShelbyMoreCache;
typedef struct Draw_tCtrlSkidmark Draw_tCtrlSkidmark;
typedef struct ChunkObjectInfo ChunkObjectInfo;
typedef struct Force_tGlobal Force_tGlobal;
typedef struct charactertbl charactertbl;

typedef struct SPRT SPRT;

typedef struct cluttbl cluttbl;

typedef struct POLY_G4 POLY_G4;


typedef struct LINE_G2 LINE_G2;

typedef struct Draw_FlareCache Draw_FlareCache;
typedef struct FLARE_DEF FLARE_DEF;
typedef struct Flare_tInfo Flare_tInfo;

typedef struct TILE_1 TILE_1;

typedef struct Draw_HorizonCache Draw_HorizonCache;
typedef struct Draw_SkyCache Draw_SkyCache;
typedef struct tHrz_LightningFork tHrz_LightningFork;
typedef struct tHrz_Lightning tHrz_Lightning;

typedef struct POLY_F3 POLY_F3;

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

typedef struct DR_AREA DR_AREA;

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

typedef struct LINE_F2 LINE_F2;

typedef struct CdlFILE CdlFILE;
typedef struct DECENV DECENV;
typedef struct CDSECTOR CDSECTOR;

typedef struct DR_OFFSET DR_OFFSET;

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
# 639 "C:/Temp/nfs4-wt46-a10/recon/nfs4_types.h"
typedef struct __nfs4_vtbl_ptr_t { short delta; short index; int (*pfn)(...); } __nfs4_vtbl_ptr_t;




typedef enum {
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;

typedef enum {
    AISCRIPT_PLAYACTION_COLLISION = 0,
    AISCRIPT_PLAYACTION_OPP_WIZZED_BY = 1,
    AISCRIPT_PLAYACTION_HUMAN_BLOCK_OPP = 2,
    AISCRIPT_PLAYACTION_OPP_BLOCK_HUMAN = 3,
    AISCRIPT_PLAYACTION_OPP_PASS_HUMAN = 4,
    AISCRIPT_PLAYACTION_HUMAN_PASS_OPP = 5,
    AISCRIPT_PLAYACTION_HUMAN_HONK = 6,
    AISCRIPT_PLAYACTION_SENTINAL = 7
} AIScript_tPlayAction;

typedef enum {
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

typedef enum {
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

typedef enum {
    SPEECH_INTENSITY_LOW = 0,
    SPEECH_INTENSITY_MED = 1,
    SPEECH_INTENSITY_HIGH = 2,
    SPEECH_INTENSITY_SENTINAL = 3
} speechIntensityType;

typedef enum {
    SPEECH_SOURCE_REGULAR_COP = 0,
    SPEECH_SOURCE_SUPER_COP = 1,
    SPEECH_SOURCE_ROADBLOCK = 2,
    SPEECH_SOURCE_SENTINAL = 3
} speechSourceType;

typedef enum {
    DONUTMODE_NONE = 0,
    DONUTMODE_GOCENTER = 1,
    DONUTMODE_DONUT = 2,
    DONUTMODE_BURNOUT = 3
} donutMode_t;

typedef enum {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

typedef enum {
    COP_REGULAR = 0,
    COP_SUPER = 1
} copType;

typedef enum {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
} crimeType;

typedef enum {
    CRUISE_ATSETSPEED = 0,
    CRUISE_ATFACTOR = 1,
    CRUISE_ATTRAFFICSPEED = 2
} cruiseMode_t;

typedef enum {
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

typedef enum {
    COP_GAME_NO = 0,
    COP_GAME_PURSUIT = 1,
    COP_GAME_BTC_1HC = 2,
    COP_GAME_BTC_2HC = 3,
    COP_GAME_BTC_1HC1HP = 4
} AIHigh_CopGameType_t;

typedef enum {
    ROLE_IDLE = 0,
    ROLE_WINGMAN = 1,
    ROLE_BLOCKADER = 2,
    ROLE_BLOCKADER_SPIKEBELT = 3
} Wingman_Role;

typedef enum {
    PULLOVER_NONE = 0,
    PULLOVER_WARNING = 1,
    PULLOVER_BUST = 2,
    PULLOVER_EOG = 3
} tPullOverMode;

typedef enum {
    NO_ATTACK = 0,
    REAR_END = 1,
    SCRIPT_ATTACK = 2,
    PROVOKED_ATTACK = 3
} AIHigh_tAttackMode;

typedef enum {
    PERPMODE_CRUISE = 0,
    PERPMODE_FAST = 1,
    PERPMODE_MADECONTACT = 2,
    PERPMODE_TEASE = 3,
    PERPMODE_ESCAPE = 4,
    PERPMODE_CHASEON = 5
} tPerpMode;

typedef enum {
    BLOCKADEMODE_NONE = 0,
    BLOCKADEMODE_SETUP = 1,
    BLOCKADEMODE_WAITING = 2,
    BLOCKADEMODE_CHASE = 3,
    BLOCKADEMODE_SETUP_FOR_OTHER = 4
} blockadeMode_t;

typedef enum {
    DRIVEAWAY_NONE = 0,
    DRIVEAWAY_RESET = 1,
    DRIVEAWAY_NORESET = 2
} AIHigh_tDriveAwayMode;

typedef enum {
    FREEZE_NONE = 0,
    FREEZE_NEWPERP_ROVE = 1,
    FREEZE_NEWPERP_DONE = 2,
    FREEZE_ARREST = 3,
    FREEZE_ARRESTDONE = 4
} tFreezeMode;

typedef enum {
    WINGMAN_NONE = 0,
    WINGMAN_WINGMAN_REQUEST = 1,
    WINGMAN_BLOCKADER_REQUEST = 2,
    WINGMAN_BLOCKADER_SPIKEBELT_REQUEST = 3,
    WINGMAN_WINGMAN_ACTIVE = 4,
    WINGMAN_BLOCKADER_ACTIVE = 5
} tWingmanStatus;

typedef enum {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

typedef enum {
    PLACEMENTSPEED_SLOW = 0,
    PLACEMENTSPEED_FAST = 1
} tPlacementSpeed;

typedef enum {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
} AICop_RoadBlockState;

typedef enum {
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

typedef enum {
    kRampType_Interpolate = 0,
    kRampType_NoInterpolate = 1
} eRampType;

typedef enum {
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

typedef enum {
    TRIGGER_NONE = 0,
    TRIGGER_COP_SIMPLE = 1,
    TRIGGER_COP_ROADBLOCK = 2,
    TRIGGER_COP_OFFROAD = 3,
    TRIGGER_TRAFFIC_ACCIDENT = 4,
    TRIGGER_TRAFFIC_PATH = 5,
    TRIGGER_NUM_TRIGGER_TYPES = 6
} triggerType;

typedef enum {
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

typedef enum {
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

typedef enum {
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

typedef enum {
    cnl_Medium = 0,
    cnl_Short = 1,
    cnl_Long = 2
} tCarNameLength;

typedef enum {
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

typedef enum {
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

typedef enum {
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

typedef enum {
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

typedef enum {
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
} tTrackClassType;

typedef enum {
    kINVALID = 0,
    kVALID = 1,
    kPREDICTED = 2,
    kRESIM = 3
} VALIDITY;

typedef enum {
    Weather_kSnow = 0,
    Weather_kRain = 1
} Weather_tState;

typedef enum {
    kApp_Command_StartRace = 0,
    kApp_Command_ReStartRace = 1,
    kApp_Command_StartReplay = 2
} tAppCommand;

typedef enum {
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
} tTVState;

typedef enum {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
} tScreenMainState;

typedef enum {
    kPlayerBoth = -1,
    kPlayerOne = 0,
    kPlayerTwo = 1
} tPlayer;

typedef enum {
    clt_Stock = 1,
    clt_GarageCar = 2,
    clt_Cop = 4,
    clt_Pursuit = 8,
    clt_Traffic = 16,
    clt_PinkSlips = 32,
    clt_Tournament = 64,
    clt_Dealer = 128
} tCarListType;

typedef enum {
    N_AMERICA = 0,
    JAPAN = 1,
    EUROPE = 2
} PRODUCTLOC;

typedef enum {
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;

typedef enum {
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

typedef enum {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
} tMenuTextState;

typedef enum {
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

typedef enum {
    kScreen_TransitionTypeItem = 0,
    kScreen_TransitionTypeMenu = 1,
    kScreen_TransitionTypeScreen = 2
} tScreen_TransitionType;

typedef enum {
    kFront_InitialLoad = 0,
    kFront_QuitToGameSetup = 1,
    kFront_QuitToPostGame = 2
} tFront_ProcessingType;

typedef enum {
    kTrophyGold = 0,
    kTrophySilver = 1,
    kTrophyBronze = 2,
    kTrophyCar = 3,
    kTrophyNone = 4
} tTrophyClass;

typedef enum {
    kSpinningNone = 0,
    kSpinningGold = 1,
    kSpinningMemCard = 2
} tSmallSpinningThing;

typedef enum {
    kScreenCongrats_Congrats = 0,
    kScreenCongrats_Eliminated = 1
} tScreenCongratsMessage;

typedef enum {
    ts_Small = 0,
    ts_Medium = 1,
    ts_Large = 2
} tTrophySize;

typedef enum {
    PinkSlipsNoError = 0,
    PinkSlipsError_NotOriginalCard = 1,
    PinkSlipsError_LoadFailed = 2,
    PinkSlipsError_SaveFailed = 3,
    PinkSlipsError_CardNotFound = 4,
    PinkSlipsError_NotFormatted = 5,
    PinkSlipsError_CardFull = 6,
    numPinkSlipsErrors = 7
} PinkSlipsErrorCode;

typedef enum {
    cst_Acceleration = 0,
    cst_Brake = 1,
    cst_Speed = 2,
    cst_Handling = 3,
    cst_Overall = 4
} tCarStatType;

typedef enum {
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

typedef enum {
    VIDEOSTATE_IDLE = 0,
    VIDEOSTATE_SPOOLING = 1,
    VIDEOSTATE_READY = 2,
    VIDEOSTATE_PLAYING = 3
} VIDEOSTATE;



struct PAD_ANALOG {
    u_short state;
    u_char rightx, righty, leftx, lefty;
};

struct PAD_MOUSE {
    u_char unused, state;
    char horizontalvalue, verticalvalue;
    u_char unused2[2];
};

struct PAD_NEGCON {
    u_char state : 4;
    u_char start : 4;
    u_char buttonAB : 4;
    u_char rightshift : 4;
    u_char twist, buttonI, buttonII, leftshift;
};

struct PAD_PSX {
    u_short state;
    u_short unused[2];
};

union tPadVariantData {
    PAD_PSX standard;
    PAD_NEGCON negcon;
    PAD_MOUSE mouse;
    PAD_ANALOG analog;
};

struct trigger_anyTrigger_t {
    int type, slice;
};

struct coorddef {
    int x, y, z;
};

struct matrixtdef {
    int m[9];
};

struct trigger_offroad_t {
    int type, slice, dir;
    coorddef position;
    matrixtdef orientation;
    int maxSpeed, releaseTime, endSlice;
};

struct trigger_roadblock_t {
    int type, slice, dir, numCars, spikeBelt;
};

struct trigger_simple_t {
    int type, slice, dir, side, moving;
};

struct trigger_trafficAccident_t {
    int type, slice;
    coorddef position;
    matrixtdef orientation;
};

struct trigger_trafficPath_t {
    int type, slice, dir;
    matrixtdef orientation;
    int maxSpeed, releaseTime, numPoints;
    trigger_pathPosition_t *path;
};

union trigger_t {
    trigger_anyTrigger_t any;
    trigger_simple_t simple;
    trigger_roadblock_t roadblock;
    trigger_offroad_t offroad;
    trigger_trafficAccident_t trafficAccident;
    trigger_trafficPath_t trafficPath;
};

union tPadStdAnalog_u {
    PAD_PSX standard;
    PAD_ANALOG analog;
};


struct MATRIX {
    short m[3][3];
    long t[3];
};



struct VECTOR {
    long vx, vy, vz, pad;
};



struct SVECTOR {
    short vx, vy, vz, pad;
};



struct CVECTOR {
    u_char r, g, b, cd;
};



struct DVECTOR {
    short vx, vy;
};



struct RVECTOR {
    SVECTOR v;
    u_char uv[2];
    u_short pad;
    CVECTOR c;
    DVECTOR sxy;
    u_long sz;
};



struct CRVECTOR3 {
    RVECTOR r01, r12, r20;
    RVECTOR *r0, *r1, *r2;
    u_long *rtn;
};



struct CRVECTOR4 {
    RVECTOR r01, r02, r31, r32, rc;
    RVECTOR *r0, *r1, *r2, *r3;
    u_long *rtn;
};



struct RECT {
    short x, y, w, h;
};



struct DR_ENV {
    u_long tag;
    u_long code[15];
};



struct DRAWENV {
    RECT clip;
    short ofs[2];
    RECT tw;
    u_short tpage;
    u_char dtd, dfe, isbg, r0, g0, b0;
    DR_ENV dr_env;
};



struct DISPENV {
    RECT disp, screen;
    u_char isinter, isrgb24, pad0, pad1;
};



struct DR_MODE {
    u_long tag;
    u_long code[2];
};



typedef struct DR_TPAGE {
    u_long tag;
    u_long code[1];
} DR_TPAGE;


struct shapetbl {
    unsigned int type : 8;
    int next : 24;
    short width, height, centerx, centery;
    int shapex : 12;
    unsigned int reserved : 1;
    unsigned int twiddled : 1;
    unsigned int transposed : 1;
    unsigned int rotated : 1;
    int shapey : 12;
    unsigned int mipmaps : 4;
    char data;
};

struct cdstreamstruct {
    long id;
    char *start, *end, *write, *header, *get, *release;
    int handle, state, control, status, abort, datahascrc, crcerrors, crcretries, buffersize;
    long blocksize;
    int readsize, chunksize, relocationsize;
    long fileoffset;
    int fileend;
    long filesize;
    int dataoffset, seekposition, seekoffset, idtype, idmask;
    cdstreamstruct *nextstream;
    void *emptyblock, *head, *tail, *block;
    int timer, blocktime, streamfull, getable, releaseable;
};

struct linedef {
    int start, end, colour, thickness;
};

struct SHAPETABLEENTRY {
    char id[4];
    long offset;
};

struct PCOORD16 {
    short x, y, z, p;
};

struct COORD16 {
    short x, y, z;
};

struct CCOORD16 {
    short x, y, z, light;
};

struct PAD_COMMON {
    u_char nopad, ID;
    tPadVariantData data;
};

struct tActiveTime {
    char bActive, time;
};

struct Draw_tPixMap {
    u_char u0, v0;
    u_short clut;
    u_char u1, v1;
    u_short tpage;
    u_char u2, v2;
    u_short pad2;
    u_char u3, v3;
    u_short flag;
};

struct DRender_tCalcView {
    coorddef translation;
    matrixtdef mrotation;
    coorddef translationInv;
    matrixtdef mrotationInv, mrotationInvRaw;
};

struct Draw_SVertex {
    short vx, vy, vz;
    u_char u, v;
    short dvx, dvy;
    u_char r, g, b, a;
};

struct Draw_PrimStruct {
    u_long *LastPrim;
    char *PrimPtr, *MPrimPtr;
};

struct Draw_tCacheHeader {
    Draw_PrimStruct cprim;
    int mirror;
    short clipW, clipH;
};

struct Draw_CarVertex {
    COORD16 vt;
    char u, v;
};

struct Group {
    int m_num_elements;

    inline void *GetData(void)
    {
        return this + 1;
    }

    inline int GetNumElements(void)
    {
        return m_num_elements;
    }
};

struct Trk_ObjectDef {
    short id;
    u_char vertexCount, quadCount;
};

struct Trk_CollideBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
    short qx, qy, qz, qw, sx, sy, sz;
    u_char simIndex, boomIndex;
};

struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};

struct Trk_Quad {
    short material;
    u_char aPoints[4];
};

struct Trk_NewStrip {
    u_char topVert, botVert;
    char quadCount, size;
};

struct Trk_NewSimQuad {
    u_char surface;
};

struct Trk_NewSimSlice {
    u_char stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;
};

struct Trk_SimObject {
    int point[3];
    short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};

struct RelCoord16 {
    short x, z;
};

struct tSaveSurface {
    Trk_NewSimQuad *fSimQuad;
    u_char fSurface;
};

struct BWorldSm_Pos {
    short slice, stripQuadInd, simRotFlag;
    coorddef quadPts[4];
    CCOORD16 quadPts16[4];
    char sliceChanged, quadChanged, offEdge, triangleFlag;
    coorddef normal, forward;
    char quad;
    u_char chunk;
    char lastRezRequested, rez;
    Trk_NewSimQuad *simQuad;
    Trk_NewStrip *strip;
    Trk_NewSimSlice *simSlice;
};

struct BO_tNewtonCollisionInfo {
    int collided, impulse;
    BO_tNewtonObj *otherObj;
    int sfxType, disableCollisionTimer;
    coorddef collisionPoint;
    int lastCollision;
    BO_tNewtonObj *lastOtherObj;
    int lastImpulse, lastTime;
};

struct BO_tNewtonObj {
    int objID;
    u_short oldSlice, totalSlice;
    BWorldSm_Pos simRoadInfo;
    int distToPlayer;
    u_char simOptz, active, reOrthoCounter;
    int gravityMult, cumulatedRot, lastUpdated;
    coorddef position, linearVel;
    int mass, massInv, speedXZ, xRelRoadCenter;
    short positionXZ, eIndexEnvMap, eIndexShadow;
    int wheelRot[2];
    int wheelFrontX, wheelFrontZ, wheelBackX, wheelBackZ, wheelWidthF, wheelWidthB;
    matrixtdef orientMat;
    coorddef angularVel;
    int moInertia, moInertiaInv;
    coorddef orientationToGround, dimension;
    int dimensionRadius;
    matrixtdef roadMatrix;
    coorddef roadCenterPoint;
    int roadGravityModifier, roadYaw;
    u_short flightTime, deadTimer;
    int groundElevation, groundVel, objAltitude;
    BO_tNewtonCollisionInfo collision;
    int groundSurfaceType, driveSurfaceType;
    matrixtdef shadowMat;
    coorddef shadowCoord[4];
    int damage[10];
};

struct GameSetup_tCarData {
    int carType, carClass, Transmission, Colour, ColourSV, ColourChange, RampSteering, RampGas, RampBrake, BrakeBias, GearRatio, SteeringQuickness, Traction, BrakeAssist, TireType, EngineMods, WeightTransfer, GroundEffects, ABS, Bestline, Personality, StartingPos, carNameIndex;
    char driver[8];
    int pad;
    char license[8];
    int HudSpeed, HudSpeedMult, HudTach, HudMap, HudOpponentID, HudTime, HudLapnum, HudPosition, HudMirror, HudColour, HudTachColour, SpeechColour, Country;
    int Camera[4];
};

struct GameSetup_tUserSetting {
    int language, display, bestlap, audioMode, musicLevel, sfxLevel, engineLevel, speechLevel, ambientLevel, interactive, numplaylistsongs;
    int playlist[40];
};

struct GameSetup_tPerpData {
    int CarType, Colour, SpeechColour, HudColour, Personality, TimeLimit, WingmanTime, SpikeBeltTime, BlockadeCopTime, Distance, SpeedFactor, WeightFactor, GlueFactor;
};

struct GameSetup_tControllerData {
    int controllerConfig[2], deadSpot[2], steeringRange[2], IImaxRange[2], ImaxRange[2], J1MIN[2], J1MAX[2], J2MIN[2], J2MAX[2], shockMode[2], shockImpact[2];
};

struct Sched_tFunctionSchedule {
    int priority;
    void *function, *var1, *var2;
};

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Transformer_zUV {
    u_char u, v;
};

struct Transformer_zFacet {
    short flag;
    u_char textureIndex, vertexId0, vertexId1, vertexId2;
    Transformer_zUV uv0, uv1, uv2;
};

struct Transformer_zObj {
    u_short numVertex, numFacet;
    coorddef translation;
    COORD16 *vertex, *Nvertex;
    Transformer_zFacet *facet;
};

struct Transformer_zOverlay {
    short offset;
    u_char u, v;
};

struct AIPerson_t {
    int blockMaxDistance, blockMinDistance, oncomingLookAhead;
    int laneSwerve[4];
    int swerveChangeProb, brakeMultiplier, attackActivationHits, attackTime, fishtailAngle, minimumBetweenWipeoutTicks, randomBetweenWipeoutTicks, gripLossProbPerSecond, gripLossMinFactor, gripLossRecoveryPerTick, bestLineAbility;
    unsigned int rearBumpProbMask, smackProbMask, copCollisionFirmness;
};

struct AIScript_tReactionDetails {
    char reaction[4], halfSeconds[4];
};

struct AIScript_t {
    int detectAction, detectHumCarIndex, actionIndex, actionHumCarIndex, reactionIndex, reaction, reactionTicksLeft;
    AIScript_tReactionDetails (*data)[7];
    int lastReactionIndex[7];
    int lastActionTime;
};

struct AISpeechInfo_t {
    int speechMode, speechIntensity, speechSource, playerCarIndex, copCarIndex, warningNumber;
};

struct Car_tStats {
    int extractSlice, sliceTotal, sliceTime, slice, lastSlice, lap, lapTime;
    int time[4], topSpeed[4];
    int position, fatalCrashes, finishType, checkpointDifference, checkpointUpdate, checkpointDisplay, numWarnings, numFines, numArrests, carType, carClass, carNameIndex, carFlags, finalDamage, finalNumWarnings, finalNumFines, finalNumArrests, finalFinishType, finalPosition, finalTotalTime;
    int finalLapTime[4];
    int finalBestLap;
};

struct Car_tControl {
    char desiredGasLevel, desiredBrakeLevel, desiredGear, gasLevel, brakeLevel, lastGear, gear, downShifting, gearShiftTimer, handBrake, horn, lights, lookBehind, abort, event, queuedEvent;
    int desiredSteering, steering, hanno;
};

struct Car_tWheel {
    coorddef currentPos, roadNormal;
    int actualHeight, wheelAcc, wheelInAir, rebound, impactCompression, roadSurfaceType;
};

struct Car_tSpecs {
    int mass, numGears, gearShiftDelay;
    int velToRpmRatio[8], gearEfficiency[8];
    int torqueCurve[41];
    int redline, maxSpeed, frontDriveRatio, maxBrakeAcc, frontBrakeRatio, wheelBase, frontGripBias, maxSteeringAcc, steeringRamp, lateralGripMult, frontAeroDownForce, rearAeroDownForce, gasOffFactor, gTransferFactor, slideMultiplier, spinVelCap, dampingPitchRate, dampingRollRate, suspensionStiffness, pitchAngularVelCap, rollAngularVelCap, damageFactor, bodyPitchFactor, bodyRollFactor, tireRange, rideOffset, dragFactor, redlineInv;
    int gearVelInv[8], velToRpmRatioInv[8], gearAccCoeff[8];
    int dragCoeff, alphaToAccRotInertia, accToAlphaRotInertia, lateralGripMultInv;
};

struct Cars_tCollisionInfo {
    int resetTimer, smoking;
};

struct Cars_tAudio {
    int type, channel, surface1, surface2, force, panangle;
};

struct Cars_tRenderInfo {
    short colorIndex;
    char currentCountry, newCountry;
    int textureStartIndex, bodyPitch, bodyRoll, currentPitch, currentRoll, currentHeight, pitchFactor, rollFactor, world_otz, sub_otz;
    u_long *sub_ot;
    int sub_otSize, sub_otOffset;
    void *sort_carObj;
    short sort_flag, damageParts;
    int light;
    char *palCopy;
    short palNum;
    short palCopyNum[20];
    char medOnly, upgradeFlags;
    short headLight, brakeLight;
    short signalLight[2];
    short currentCarType, newCarType, inside, detail, VRamX, VRamY, textureOffsetU, textureOffsetV;
    u_char licenseOffsetU[2], licenseOffsetV[2];
    int rideHeight, upgradeHeight;
};

struct Car_tObj {
    BO_tNewtonObj N;
    char carName[9], carNameLocalized[9];
    int carIndex, humanIndex, sortIndex, carFlags, lap, unlap, roadSpan, glue, blowout, pullOver, revLimit;
    Car_tObj *swapCar;
    int swapTime;
    GameSetup_tCarData *carInfo;
    Car_tWheel wheel[4];
    Car_tStats stats;
    int crash, wrongway;
    coorddef angularAcc, linearAcc, linearAcc_ch, linearVel_ch, angularVel_ch, linearAcc_rh;
    Car_tControl control;
    char RSGasLevel, RSBrakeLevel;
    int RSSteering, RSControl;
    Car_tSpecs *specs;
    int flywheelRpm, wheelSpin, frontWheelSpin, wheelLock, slide, gTransferFront, gTransferRight, frontSkid, rearSkid, oldSkidState;
    coorddef oldSkidPoint[4];
    int oldAudioSkidState;
    void *funcUpdateRoadInfo, *funcReplay, *funcControl, *funcStats, *funcHandlingPhysics, *funcGravityPhysics, *funcQDPhysicsUpdateVel, *funcQDPhysicsUpdateRot, *funcTestMeForCollisions, *funcDoPostCollisionStuff;
    int personalityIndex;
    AIPerson_t *personality;
    AIScript_t script;
    AISpeechInfo_t speechInfo;
    int carInLane, desiredDirection, direction, desiredLatPos, desiredSpeed, originalDesiredSpeed, currentSpeed, speed, laneSlack, AIFlags, roadPosition;
    Car_tObj *basisCar;
    int aiShiftDuration, aiShiftTimer, redLine, tailgateTimer, physicsModelTimer, trafficSpeedRandomizingFactor, laneChangeSpeed;
    int topSpeeds[7], invTopSpeeds[7];
    short accTable[112];
    AIDataRecord_AccTable_t *accelerationRecord;
    AIDataRecord_CurveSpeedTable_t *curveSpeedTable;
    AIPhysic_BrakeInfo *brakeInfo;
    int speedFactor, barrierThinkHarder, laneIndex, copTopSpeed, copAccMult;
    coorddef desiredVector;
    int aCarWRTDesired;
    coorddef angularAcc_ch;
    int driveDirectionReverseTime, driveDirection, driveDirectionTimer, aCar, aDesired, aCarWRTRoad, lateralVelocity;
    coorddef targetPos;
    int targetLatPos, rampDesiredLatPos, preferredLateralPosition, preferredLateralPositionPower, timeOffRoad, max_clacc, max_aa, aiGlue, drag, slackProb, accNitrous, speedNitrous, wipeOutStartTick, wipeOutEndTick, btcGlueModifier, donutMode, AIFishtailEndTick, lookAheadSlice, forceNoSimOptz, gripFactor;
    Car_tObj *fallBehindCar, *nextAIRacer;
    int caravanFollowBehindDistanceMeters, caravanTimer, AISlot, damageMult, topSpeedUpgradeMult, accUpgradeMult, extraWallCollisionAllowance;
    Cars_tCollisionInfo collision;
    int audioDamageScrape, audioCount;
    Cars_tAudio audio[7];
    Cars_tRenderInfo render;
    int async_handle;
};

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    int recordMethod_;
    __nfs4_vtbl_ptr_t (*_vf)[3];
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

struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    AIDataRecord_AccTable_t() {}
    AIDataRecord_AccTable_t(char *name, int n, AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_AccTable_t();
    int Get(int i);
    void Setup();
};

struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {


    AIDataRecord_CurveSpeedTable_t() {}
    AIDataRecord_CurveSpeedTable_t(char *name, AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_CurveSpeedTable_t();
    int Get(int i);
    void Upgrade(int i);
};

struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
};

struct AI_tInfo {
    Car_tObj *blockingCars[3];
    int blockingCarsDist[3], laneSpeeds[3], laneSpeedsAhead[3], laneWeights[3];
    int desiredLane, desiredLaneSide, deltaYaw;
};

struct AIPhysic_ModelConfig_t {
    int dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc, dangle_to_dav, max_dav, dav_to_aa, max_aa, vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;
};

struct AIDataRecord_BestLine_t : public AIDataRecord_t {

    AIDataRecord_BestLine_t() {}
    AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_BestLine_t();
};

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq, lineFarZClipSq;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;

    AnimScript(int num);
    AnimScript(int num, int numParts);
    AnimScript(Group *instanceGroup, int type, int boomIndex, int numParts);
    void SetAnimAttrib(int flags);
    void GetAnimFrameInfo(int *frame, int *numFrames);
    int GetTimedAnimPosRot(coorddef *pt, matrixtdef *mat);
    int GetTimedAnimPosRot(int index, coorddef *pt, matrixtdef *mat);
    int GetStatus();
};

struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};

struct SceneSortedElem {
    int slice_;
    SceneElem *se;
};

struct AnimDef {
    int type, numPieces, objDefIndex, baseAnim, animIndex;
};

struct ObjectAnim {
    __nfs4_vtbl_ptr_t (*_vf)[3];
};

struct ObjectFinishedMultiAnim {
    ObjectAnim _base_ObjectAnim;
};

struct ObjectFinishedSignAnim {
    ObjectAnim _base_ObjectAnim;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};

struct AIDelayCar {
    int delayFactor_;
    Car_tObj *basisCar_, *targetCar_;
    int deltaMeters_, slice_;
    coorddef deltaPosition_, position_;
    int deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;
    AIDelayCar() {}
    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update();
};

struct copLevel_t {
    int copChasers[2];
    int numBlockaders;
    int copBlockaders[2];
    int spikeBelt;
    int copAggression[2];
    int copsPerLap, engagementLapFraction, warningTicks, beatingTicks, numWarningsAdded;
};

struct copGame_t {
    int numLevels;
    copLevel_t *levels;
};

struct AICop_BasicPerpInfo {
    int copsAssigned_[2];
    int crime_;
};

struct AICop_PerpChaseInfo {
    int engagementTime_;
    copGame_t *copGameInfo_;
    int chaseLevelIndex_, bestChaseLevelIndex_;
    copLevel_t *chaseLevel_;
    int totalEngagementPercent_, blockadeDone_, engagementPercentIncreasePerTick_, copFreeTicks_;
};

struct trigger_pathPosition_t {
    coorddef position;
    int targetSpeed, waitTime;
};

struct AIState_Base {
    Car_tObj *carObj_;
    __nfs4_vtbl_ptr_t (*_vf)[4];
    AIState_Base() {}
    AIState_Base(Car_tObj *carObj);
    ~AIState_Base();
    void StateExecute();
    int TestForRelease();
};

struct AIState_None : public AIState_Base {
    AIState_None() {}

    void Execute();
};

struct AIState_Normal : public AIState_Base {
    AIState_Normal() {}
    AIState_Normal(Car_tObj *carObj);





    void Execute();
};

extern __nfs4_vtbl_ptr_t AIState_NonActive_vtable[];
struct AIState_NonActive : public AIState_Base {
    AIState_NonActive() {}


    AIState_NonActive(Car_tObj *carObj) : AIState_Base(carObj) {
        _vf = (__nfs4_vtbl_ptr_t (*)[4])((char *)AIState_NonActive_vtable + 8);
    }

    void Execute();
};

struct AIHigh_Base {
    Car_tObj *carObj_;
    AIState_Base *state_;
    int stateType_, schedulingOff_, lastTrafficTriggerCheckSlice_;
    __nfs4_vtbl_ptr_t (*_vf)[3];
    AIHigh_Base() {}
    AIHigh_Base(Car_tObj *carObj);
    ~AIHigh_Base();
    Car_tObj *GetCarObj() { return carObj_; }
    void StateExecute();


    void SetState(AIState_Base *newState, stateType_t newStateType) {
        AIState_Base *oldState = state_;
        if (oldState != (AIState_Base *)0x0) {
            (*(*oldState->_vf)[2].pfn)
                ((int)&oldState->carObj_ + (*oldState->_vf)[2].delta, 3);
        }
        state_ = newState;
        stateType_ = newStateType;
    }
};

struct AIHigh_None : public AIHigh_Base {
    AIHigh_None() {}
    ~AIHigh_None();
    void HighExecute();
};

struct tCopCarPair {
    int copIndex, carIndex;
};

struct AIHigh_BasicPerp : public AIHigh_Base {
    int pullOverMode_;
    tCopCarPair positionVSCopList_[6];
    int copVSPositionList_[6];
    int beatingTicksLeft_, lastPullOverTime_;
    Car_tObj *lastArrestingCop_;
    AICop_BasicPerpInfo basicPerpInfo_;
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

struct AIHigh_Player : public AIHigh_BasicPerp {
    int numWarnings_, numBusts_, newTriggerProb_, lastTriggerCheckSlice_;
    AICop_PerpChaseInfo perpChaseInfo_;
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

struct AIHigh_BTC_Perp : public AIHigh_BasicPerp {
    int caught_, hudActivated_;
    AIHigh_BTC_HumanCop *originalActivationCop_;
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

struct blockade_t {
    int mode;
    AIHigh_Player *target;
    int flags, chaseLevel, requestSpikeBeltAtSlice, slice, direction, latPos, rotation, reverse, releaseTime, initialPlayerDistanceMetersInt;
    short blockadeSpeechFlags;
};

struct AIHigh_BasicCop : public AIHigh_Base {
    int type_, copIndex_;
    blockade_t blockade_;
    int driveAway_;
    AIHigh_BasicCop() {}
    AIHigh_BasicCop(Car_tObj *carObj, int idx);
    void CheckSpikeBelt();
    void SetupBlockadeElements(blockade_t *blockade);
    void HandleBlockadeSpeech();
    int ShouldIPerformCutOffBlock(int a, Car_tObj *carObj);
};

struct AIHigh_BTC_Cop : public AIHigh_BasicCop {
    AIHigh_BTC_Perp *perpTarget_;
    int chaseIndex_, freezeMode_;
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

struct AIHigh_BTC_HumanCop : public AIHigh_BTC_Cop {
    int currentStage_, stageRepeatCount_, stageTimeMultiplier_, timeLeft_, chaseStartTime_, wingmanStatus_, needPerp_, initialDirection_, initialMovement_, requestedDesiredSpeed_;
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

struct AIHigh_Cop : public AIHigh_BasicCop {
    AIHigh_Player *perpTarget_;
    int forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_, aggressionLevel_;
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

struct SPCHNFSType_POSITION {
    u_long flags;
};

struct SPCHNFSType_DISTANCE {
    u_long flags;
};

struct SPCHNFSType_COLOUR {
    u_long flags;
};

struct SPCHNFSType_ACCIDENT {
    u_long flags;
};

struct SPCHNFSType_AMBULANCE {
    u_long flags;
};

struct SPCHNFSType_PURS_UPDT {
    u_long flags;
};

struct SPCHNFSType_ARREST {
    u_long flags;
};

struct SPCHNFSType_vs_RDBLK_SSTRP {
    u_long flags;
};

struct SPCHNFSType_PERP_NAME {
    u_long flags;
};

struct SPCHNFSType_CONFIRM {
    u_long flags;
};

struct SPCHNFSType_SPIKE_BELT_SIDE {
    u_long flags;
};

struct SPCHNFSType_REVINTRO {
    u_long flags;
};

struct CarBank {
    int fFull, fMake, fModel;
};

struct LocationBank {
    int fStartSlice, fEndSlice, fBankId;
    char *fName;
};

struct CallSignBank {
    int fAllUnits, fDispatch;
    int fMobile[15];
};

struct tCarBankPair {
    CarBank Mobile[9], Dispatch[9];
};

struct tLocationBankPair {
    LocationBank Mobile[16], Dispatch[16];
};

struct tCallSignBankPair {
    CallSignBank Mobile, Dispatch;
};

struct Speaker {
    SPCHNFSType_POSITION fPosition;
    SPCHNFSType_DISTANCE fDistance;
    SPCHNFSType_COLOUR fColour;
    SPCHNFSType_ACCIDENT fAccident;
    SPCHNFSType_AMBULANCE fAmbulance;
    SPCHNFSType_vs_RDBLK_SSTRP fBlockade;
    SPCHNFSType_REVINTRO fReverse;
    SPCHNFSType_CONFIRM fConfirm;
    SPCHNFSType_PERP_NAME fPerpName;
    SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;
    SPCHNFSType_PURS_UPDT fUpdate;
    SPCHNFSType_ARREST fArrest;
    int fCar, fLocation, fFrom, fTo, fWing;
    BOOL fHavePerp;
    Speaker *fSub;
    __nfs4_vtbl_ptr_t (*_vf)[31];
};

struct Trk_SFX {
    int point[3];
    short type, pad;
};

struct FLARE_PIECE_DEF {
    int distance, size;
    CVECTOR color;
    char type;
};


struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    u_char r1, g1, b1, p1;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    u_char r2, g2, b2, p2;
    short x2, y2;
    u_char u2, v2;
    u_short pad2;
    u_char r3, g3, b3, p3;
    short x3, y3;
    u_char u3, v3;
    u_short pad3;
};


struct Draw_SubdivStruct {
    Draw_SVertex v[15];
};

struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};

struct Track_tMaterial {
    char flag, mipmap_offset;
    short pmxIndex;
};

struct AIState_Chase : public AIState_Base {
    AIDelayCar delayCar_;
    int noTurnAroundEndTime_;
    Car_tObj *targetCar_;
    coorddef relPosition_;
    int longTargetRegion_, latTargetRegion_, targetDir_, carDir_, longMetersBetween_, latMetersBetween_, murderMode_, murderEndTime_, inTargetRegion_, nitrousTicks_, nitrousMinForeDistance_, nitrousMinAftDistance_, aggressionLevel_, slowDownEndTime_, barrierTicks32_;
    AIState_Chase() {}
    AIState_Chase(Car_tObj *carObj, Car_tObj *target, coorddef *pt, int a, int b, int c, int d, int e);

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

struct AIState_GotoSlice : public AIState_Normal {
    int targetSlice_, stopWhenArrivedAtSlice_;
    AIState_GotoSlice() {}
    AIState_GotoSlice(Car_tObj *carObj, int a, int b);

    void Execute();
    int InTargetSliceRange(int a);
};

struct AIHigh_BTC_Wingman : public AIHigh_BTC_Cop {
    int currentRole_, newRole_;
    AIHigh_BTC_HumanCop *newHumanBoss_;
    int spikeBeltPlaced_, spikeBeltSlice_, spikeBeltInterceptReleaseTime_;
    AIHigh_BTC_Wingman() {}
    AIHigh_BTC_Wingman(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_Wingman();
    void HighExecute();
    int CheckForActivation();
    int UpdateFreezeModeAndPullOverMode();
    void SetupWingman(AIHigh_BTC_HumanCop *humanCop);
    void SetupBlockader(AIHigh_BTC_HumanCop *humanCop, int spikeBeltRequest);
};

struct AIHigh_Traffic : public AIHigh_Base {
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    AIHigh_Traffic() {}
    AIHigh_Traffic(Car_tObj *carObj);
    Car_tObj *CheckForCops(int *p);
    AIHigh_Cop *CopCheck(int *p);
    void HighExecute();
    trigger_t *CheckForNewTriggers();
};

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};

struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size, s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

struct Skidmark_Segment {
    SVECTOR svx[2];
    CVECTOR rgb;
    int type;
    Skidmark_Segment *next;
};

struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};

struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {
    AIHigh_BTC_HumanPerp() {}
    ~AIHigh_BTC_HumanPerp();
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
};

struct AIHigh_BTC_AIPerp : public AIHigh_BTC_Perp {
    int perpMode_, creationTime_, madeContactTime_, timeUntilContact_, escapeDuration_, originalMass_, originalMassInv_;
    Car_tObj *closestCopCarObj_;
    int closestCopCarDistanceMeters_;
    AIHigh_BTC_AIPerp() {}
    AIHigh_BTC_AIPerp(Car_tObj *carObj);
    ~AIHigh_BTC_AIPerp();
    void AvoidCops();
    void CalculateTimeTillContact();
    void FindClosestCop();
    void HighExecute();
    void NewStage(AIHigh_BTC_HumanCop *cop);
};

struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];

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

struct AIHigh_Human : public AIHigh_Player {
    AIHigh_Human() {}
    AIHigh_Human(Car_tObj *carObj);
    ~AIHigh_Human();
    void HighExecute();
};

struct AIHigh_Opponent : public AIHigh_Player {
    int attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent() {}
    AIHigh_Opponent(Car_tObj *carObj);
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
};

struct tCopMurderThresholds {
    int ticksInChaseRegionForMurder, minLatMetersDistanceForMurder, minLongMetersDistanceForMurder, murderTicks, nitrousTicks;
};

struct AIState_Idle : public AIState_Base {
    int roadPosition_, idleInPlaceFlag_;
    AIState_Idle() {}

    void Execute();
    void SetIdlePosition(int pos);
};

struct AICop_spikeBelt_t {
    int active_, slice_, leftLatPos_, rightLatPos_, freshenTime_;
};

struct Udff_tInfo {
    int type, handle;
    char *memPtr;
};

struct AIPhysic_Config_t {
    int latvelcalc_lookahead, min_lookahead, max_lookahead, look_ahead_factor, skid_value;
    AIPhysic_ModelConfig_t ICModel, OOCModel;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};

struct AIDataRecord_TrackCurve_t : public AIDataRecord_t {

    AIDataRecord_TrackCurve_t() {}
    AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_TrackCurve_t();
    int Get(int i);
};

struct AIDataRecord_CarTracking_t : public AIDataRecord_t {

    AIDataRecord_CarTracking_t() {}
    ~AIDataRecord_CarTracking_t();
    int Get(int i);
};

struct AISpeeds_tLeaderBoard {
    Car_tObj *leadRacer, *leadHumanRacer, *leadAIRacer, *lastAIRacer;
};

struct AISpeeds_Upgrade_t {
    int accMult, brakeMult, handlingMult, topSpeedMult;
};

struct AISpeeds_tSlotInfo {
    int distanceMaintainTime32, minDistanceMeters, maxDistanceMeters;
    unsigned int fallBackRandomTime_TickPercent;
};

struct speedData_t {
    u_short endSlice, speedMPS;
};

struct AIState_Offroad : public AIState_Base {
    int startSlice_;
    coorddef startPosition_;
    matrixtdef startOrientation_;
    coorddef startHeading_;
    int targetSlice_;
    coorddef targetPosition_;
    int longMetersBetween_, letGo_, maxSpeedMPS_, releaseTime_;
    AIState_Offroad() {}
    AIState_Offroad(Car_tObj *carObj, int a, coorddef *pt, matrixtdef *mat, int b, int c, int d);

    void UnleashIfInRange(Car_tObj *carObj);
    void Execute();
};

struct AIState_Purgatory : public AIState_NonActive {
    AIState_Purgatory() {}
    AIState_Purgatory(Car_tObj *carObj);

    int TestForRelease();
    void Execute();
    static void StartUp();
};

struct AIState_RovingTraffic : public AIState_Base {
    trigger_pathPosition_t *path_;
    int numPathPoints_, pathIndex_;
    long waitTick_;
    AIState_RovingTraffic() {}
    AIState_RovingTraffic(Car_tObj *carObj, trigger_t *trig);

    void CheckIfCarIsNearbyAndStop(Car_tObj *carObj, int &status);
    void Execute();
    int TestForRelease();
};

struct AIState_Donuts : public AIState_Base {
    int donutLookForward_, donutMode_;
    AIState_Donuts() {}

    void Execute();
};

struct AIState_Cruise : public AIState_Normal {
    int cruiseMode_, cruiseSpeed_, cruiseFactor_;
    AIState_Cruise() {}
    AIState_Cruise(Car_tObj *carObj, cruiseMode_t mode, int a);

    void Execute();
};

struct accelscale_t {
    int scale;
};

struct copTuning_t {
    int regularCopAccMultiplier, superCopAccMultiplier, regularCopTopSpeedCap, superCopTopSpeedCap;
};

struct AITune_tTrackInfo {
    int oneWay, driveSide, roughLapTimeSeconds;
};

struct AITune_BTC_t {
    int glueMult, speedMult, weightMult, baseChaseTime, wingmanTime, blockaderTime, spikeBeltTime;
};

struct tQuat {
    short x, y, z, w;
};

struct Trk_AnimateBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
    u_char simIndex, boomIndex;
    short pad2;
};

struct Anim_tFrame {
    long x, y, z;
    short qx, qy, qz, qw;
};

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax, inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC {
    void *issurfacelocked;
};

struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
};

struct AudioClc_tSource {
    Car_tObj *car;
    int distToCamera, dopplerShift, relVelocity, gameTicks, distSq, frequency, channel, horn, hornOn, hornOff, hornCount, pursuit, yelled;
};

struct AudioClc_tPlayer {
    int cameraMode, gameTicks, warnings;
    coorddef lastview;
    AudioClc_tSource source;
};

struct AudioClc_tCLCache {
    Car_tObj *ptr;
    int dst;
};

struct SNDPLAYOPTS {
    int patnum;
    char bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    u_short pitchmult, timemult, azimuth;
    short elevation;
};

struct SndBnk_t {
    int bnkID;
    char *phdr, *pdata;
};

struct Channels_t {
    int Partial, SFXnum;
};

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct tTexture_ShapeInfo {
    shapetbl *shpptr;
    long clutID;
    char depth;
    u_long type : 8;
    long next : 24;
    short width, height, centerx, centery, shapex, shapey;
    u_short tpage, clut;
};

struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    BOOL fNeverAnyEnabled;
    tMenuItem *fItemList[16];
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
    void *fOnButtonPress;
    short VertHelp;
    __nfs4_vtbl_ptr_t (*_vf)[11];

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

struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;
    __nfs4_vtbl_ptr_t (*_vf)[6];

    tListIterator() {}
    tListIterator(short *selection, char *valPtr);
    ~tListIterator();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tListIteratorRange : public tListIterator {
    tListIteratorRange() {}

    tListIteratorRange(char minValue, char maxValue, char *valPtr);
    ~tListIteratorRange();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tMenuItem {
    tMenuItem() {}
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    __nfs4_vtbl_ptr_t (*_vf)[11];

    tMenuItem(unsigned int textDescription);
    ~tMenuItem();
    long DebounceKeys();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void UpdateTransition(bool selected);
    void *TransitionIsFinished();
    void UpdateSelFade(bool selected);
    int Draw(int x, int y, bool selected);
    int Draw(int x, int y, int w, bool selected);
    void TransitionOn();
    void TransitionOff();

};

struct tMenuItemInteractive : public tMenuItem {
    tMenuItemInteractive() {}

    tMenuItemInteractive(unsigned int textDescription);
    ~tMenuItemInteractive();

};

struct tCarInfo {
    char fCarID;
    u_char fSimNumber, fCarClass, fABSAvailable, fDefaultColor, fCopClass, fDefaultTires, fAvailable;
    char fShapeName[8], fSmallName[8], fQTVRName[8];
    long fPrices[4];
    u_char fStats[4][5];
    u_long fColorList[16];
    u_char fSpeechColors[16];
    u_long fHudColor[2];
    char fDayTachFile[8], fNightTachFile[8];
    char fNumLightColors, fNumDarkColors;
    u_char fCountries;
    char fColorOrder[16];
    u_char fPursuitAvailable, fEnginePatch;
    char fSpeechCarID;
    u_char fTractionAvailable, fExoticCar, fUpgrades, fColor, fViewable, fCountry, fCarIndex;
    u_char fReserved[3];
};

struct tOwnedCarInfo {
    char fCarID;
    u_char fUpgrades, fCarColor, fPad;
};

struct tCarManager {
    u_long fNumCars;
    tCarInfo *fCars;
    tOwnedCarInfo fCarGarage[2][32], fPinkSlipsCars[2][32];
    u_char fAvailableCars[48], fViewableCars[48];
    u_char fPinkSlipsAvailableCars[2][48], fPinkSlipsViewableCars[2][48];
    short fCarTextList[49];

    void SetClassAvailable(tCarClassType carClass, bool avail);


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

struct tfrontEnd {
    short randomSeed;
    char currentPlayer, gameMode, raceType, style, skillLevel, catchup, ghostcar, tractionassist, bestline;
    short pinkSlipsWinner[5];
    char timeOfDay[5], weather[5];
    char fog, localSpeech, opponentUpgrades;
    char track[5];
    int recordlaptime;
    char laps;
    char lapind[5], trackdirection[5], trackmirrored[5], traffic[5], situations[5];
    char pinkSlipsTrackIndex, pinkSlipsNumTracks;
    char pinkSlipsWins[2];
    long pinkSlipsCash[2];
    short cheatFlags, cheatFlagsActive, secretFlags, pinkSlipsForfeit;
    char playerCar[2], transmission[2];
    char carColors[2][48], carCountry[2][48];
    char tournament, specialevent, tier;
    char garageCar[2], pinkSlipsCar[2];
    char upgrade, dealerCar, sellerCar, carListType, policeTier, policeMission, congratsCopCar, congratsCopCountry;
    short settingsActive[2];
    char steeringSensitivity[2][48], tireType[2][48], suspension[2][48], carDownforce[2][48], engineTuning[2][48];
    char ABS[2];
    char damage;
    char rampSteer[2], rampGas[2], rampBrake[2];
    char oppCar, oppNumber, measurement;
    char displaySpeed[2], displayTach[2], displayMap[2], displayOpponentID[2], displayTime[2], displayPosition[2], displayLapNumber[2], displayMirror[2];
    char cameraType[2][4], cameraSway[2][4];
    char language, musicVolume, sfxVolume, narrationVolume, engineVolume, ambientVolume, audioMode, song, sensitivity;
    char steeringRange[2], deadSpot[2], ImaxRange[2], IImaxRange[2], J1MAX[2], J1MIN[2], J2MAX[2], J2MIN[2], shockMode[2], shockImpact[2];
    short controlType[2];
    char controlConfig[2];
    char playerNameList[2][8], allUpperCasedPlayerNameList[2][8], licensePlate[2][8];
    char headstart, numBTracksActivated, checkPointType;
    char checkPointDisplay[2], defaultedPlayerName[2];
    BOOL FEPlayList[40];
    u_long gPinkSlipsNoCheat[2];
    BOOL GotAPlayList;
    BOOL AnalogOn[2];
};

struct CopSpeak_tRequest {
    Car_tObj *car;
    int buffer, offset, size, filehandle, ophandle, phrase;
    char player, sfx, bank, noise;
};

struct AudioCmn_tReTrig {
    int count, pan;
    short delay, nextd;
    int patch;
    char bend, amp;
    coorddef pos;
};

struct AudioCmn_tAsyncSfxSlot {
    int bank, patch, handle, ticks, addr;
    char *header;
};

struct AudioMus_tCurrentSong {
    int newsong, index, remaining;
    AudioMus_tSongEntry info;
};

struct AudioMus_tSongList {
    int numsongs, currentsong;
    AudioMus_tSongEntry song[0];
};

struct SNDREQUESTSTATUS {
    int state, currenttime, timetoend, timebuffered;
};

struct SNDSTREAMSTATUS {
    int outstandingrequests, currentrequest, timebuffered;
};

struct SNDLIMITS {
    int dmabuflen;
    u_char numdmabufs, numdmamsgs, nummicrotalkinstances, microtalkinstanceabort;
    short numrspcmds, pad;
    int audiostreambufsize, packetbufsize;
};

struct CdlLOC {
    u_char minute, second, sector, track;
};

struct AudioMus_tMusicGlobals {
    int volume, totalsongs, availablesongs, requestsong, firstswitch, switchsong, newswitch, failby, errorcode, fadetime, randomize;
    char *songname;
    char title64[64];
    char *streambuffer;
    int streamhandle, requesthandle, serveractive, driveractive, greedy, threshold;
    char *bigfileheader;
    SNDSTREAMSTATUS streamstatus;
    SNDREQUESTSTATUS requeststatus;
    char bigfilename[64];
    char playlist[32];
    AudioMus_tCurrentSong current;
};

struct CAudioList {
    int id_, numElements_, slice_, versionNumber_;
};

struct AudioEng_tEvent {
    char use, patnum, pad1, pad2;
    short delta, max;
    int attackdelta, decaydelta;
};

struct AudioEng_tTable {
    char xlate[512];
};

struct AudioEng_tDef {
    int id;
    char ver, resolved, startevent, controllerpercent;
    short lowrandomtargetlevel, lowrandomtargetrange;
    int lowrandomattacktime, lowrandomattackrange;
    short highrandomtargetlevel, highrandomtargetrange;
    int highrandomattacktime, highrandomattackrange;
    char patchnum[8];
    AudioEng_tEvent event[16];
    AudioEng_tTable *pvoltable[8], *pbendtable[8];
};

struct AudioEng_tChanAttr {
    short min, max;
    char *xlate;
    char patchnum;
};

struct AudioEng_tAdjustments {
    u_char inCarBoost, inCarExhaust, outCarExhaust, fwdEngBoost, rwdExhBoost, outCarBoost, pitchScale, timbreScale;
};

struct AudioEng_tVoiceAttr {
    char vol;
    u_short pitch, azim;
    int handle;
};

struct AudioEng_tState {
    u_short vol, dop, azi, sep, esp;
    u_char exh, gas;
};

struct AudioEng_t {
    AudioEng_tAdjustments adjust;
    int tick;
    int vol[16];
    int azi, sep, dop;
    char bhandle, pad;
    AudioEng_tState queue[16];
    char setpos, plypos;
    AudioEng_tChanAttr chan[16];
    AudioEng_tVoiceAttr left[16], right[16];
    char delay[16];
    char *tables;
};

struct AudioElem {
    coorddef cp;
    u_short nextDelay;
    char patchID, fadeIn;
    short range;
    char minDelay, randomDelay, type;
    signed char chan;
    char minRepeat, randomRepeat;
};

struct AudioTrk_tAmbientChannel {
    AudioElem *se;
    int handle, slice;
    short patch, repeat;
};

struct AudioTrk_tGlobals {
    AudioTrk_tAmbientChannel chan[16];
};

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

struct Draw_DCache {
    Draw_tCacheHeader head;
    MATRIX matB, matNight, matCop, identMat;
    int otz;
    VECTOR tVn0, tVn1, tVn2, tVn3;
    short light, doublelayer;
};

struct Chunk {
    RelCoord16 boundPts[4], chunkboundPts[4];
    u_char quadCounts[6];
    u_char pad[2];
    Trk_Quad *renderQuads[4];
    Group *stripBuf, *lorezstripBuf, *objInstanceBuf, *objSpecialInstanceBuf, *simSliceBuf, *simQuadBuf, *simObjBuf, *sfxBuf, *lineBuf, *objVertexBuf, *objQuadBuf, *objQuadInstanceBuf;
    short firstSimSliceInd, chunkInd;
    Group *vertexBuf;



    void InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem);
};

struct BW_tContextMgr {
    int initialized, count;
    BW_tContext contexts[2];
};

struct tBuildEntry {
    short chunkInd;
    char geomRez, enableBits;
};

struct CHorizonSpec {
    int mirror, angle, yoffset, height;
    CVECTOR frontColor[2], backColor[2];
    char ringPMX[16];
};

struct CSkySpec {
    int type, flags;
    CVECTOR frontcolors[5], backcolors[5];
    CVECTOR clearcolor;
    int sunAngleInSky, sunHeightInSky, moonAngleInSky, moonHeightInSky, numStars, starAngleLow, starAngleHigh, starBrightMin, starBrightMax;
    CVECTOR starBaseColor;
    int starRandomSeed;
    CVECTOR sunBeamColor, sunHaloColor;
    int yoffset;
    char cloudIndices[5][4];
    int ringAngles[5];
};

struct CNightSpec {
    CVECTOR nightcolor;
};

struct CWeatherSpec {
    int type, intensity_limit;
};

struct CFogSpec {
    int contrast;
    CVECTOR color;
    int start, dist2base;
};

struct CDepthCueSpec {
    CVECTOR color;
    int distance;
};

struct CWorldColor {
    int contrast;
    CVECTOR contrast_color;
    short worldR, worldG, worldB, type;
};

struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

struct tNormalCacheEntry {
    short sliceInd;
    u_char triangleFlag;
    char quadInd;
    coorddef normal, forward;
    u_long accessTime;
};

struct camera_info {
    BO_tNewtonObj *anchor, *target;
    coorddef position, relpos, audioPos;
    int TVHeight;
    matrixtdef rotation;
    int twist;
    coorddef wallLeft, wallRight;
    short mode, camNum;
    char modechange : 1;
    char pitch : 1;
    char jostling : 1;
    char tracking : 1;
    char checkwalls : 1;
    char noLookBack : 1;
    char checkcollisions : 1;
    char splitscreen : 1;
    char intransition, tumbling;
    char direction : 1;
    char zooming : 2;
    char inCar : 1;
    short circleCounter, circleAngle;
    char animNum;
    signed char animHandle;
    char splineMode;
    int forceFocus;
    signed char focusOnAICar;
    int POInhibitor;
    BWorldSm_Pos slicePos;
};

struct camera_flags {
    coorddef arm;
    int pitch : 1;
    int jostling : 1;
    int tracking : 1;
    int checkwalls : 1;
    int noLookBack : 1;
    int checkcollisions : 1;
};

struct Camera_tCamSlot {
    char mode;
    char track : 1;
    char zoom : 2;
    char splineMode : 3;
    short fov;
    coorddef pos;
    int height, splineOffset;
    COORD16 euler;
    short slice;
};

struct SimpleMem {
    void *heap, *freeMem;
    int freeMemSize;


    void *Alloc(int len, int feign);
    void *FeignAlloc(int len);
    void ResizeToFit();
};

struct SerializedGroup {
    int m_type, m_length, dummy, m_num_elements;



    SerializedGroup *LocateNextGroupType(int type);
    SerializedGroup *LocateGroupType(int type, int index);
    SerializedGroup *LocateGroupNum(int index);
    void *LocateCreateGroupType(int type, SimpleMem *mem, int index);
    Group *CreateLiteGroup(SerializedGroup *source, SimpleMem *mem);
    Group *CreateLiteGroupDataSize(SerializedGroup *source, SimpleMem *mem, int dataSize);
};

struct Trk_SimpleInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
};

struct Clock_tGameClock {
    int time128Hz, time64Hz, time32Hz;
};

struct Object_tSimObjList {
    int numObjects, chunk, numObjects2, chunk2;
};

struct HudPmx_tShape {
    Draw_tPixMap pixmap;
    short width, height;
};

struct HudPmx_tUV {
    u_char u0, v0;
    u_short clut;
};

struct SPCHNFSType_vs_KMH_MPH {
    u_long flags;
};

struct SPCHNFSType_VOICE {
    u_long flags;
};

struct CarBankName {
    char *fFull, *fMake, *fModel;
};

struct Speech {
    tCarBankPair fCarBank;
    tLocationBankPair fLocationBank;
    tCallSignBankPair fCallSignBank;
    int fLocationCount;
    BOOL fFileOpen;
    int fFileHandle;
    long *fBankOffset;
    int fBankCount, fBlpClpBank, fStaticBank, fCarCount, fCopCount, fSuperCount, fMultiplePerps;
    Car_tObj *fSpeakerCar;
    MobileSpeaker *fMobile[4];
    DispatchSpeaker *fDispatch;
};

struct MobileSpeaker {
    Speaker _base_Speaker;
    SPCHNFSType_VOICE fVoice;
    SPCHNFSType_vs_KMH_MPH fSpeedType;
    int fSpeed, fUnit;
    Car_tObj *fCarObj, *fPerp;
};

struct DispatchSpeaker {
    Speaker _base_Speaker;
    int fStatusCount;
    Speaker *fStatusSub;
    int fUpdateCount;
    Car_tObj *fPerp[2];
};

struct Speech_tCarDescription {
    char *game, *full, *make, *model;
};

struct Speech_tLocationDescription {
    char *name;
    short start, end;
};

struct Speech_tCallSignDescription {
    char *AllUnits;
    char *Dispatch[5];
    char *Mobile[15];
};

struct Speech_tMobileVoiceAttr {
    int voice, pitch;
};

struct CopSpeak_tFileIndex {
    long offset, size;
};

struct CopSpeak_tBankHeader {
    int id;
    u_char ver;
};

struct CopSpeak_tBank {
    int FileHandle, FileOpen;
    CopSpeak_tFileIndex *Index;
    int Count;
};

struct dashhud_info {
    int splitscreen;
    char name[9];
    int conversion, flashtime, flashlap;
    int showhud[2], showmap[2], wrongway[2];
    int laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed, position, opponents, record, tutor;
    int warning[2];
};

struct FEI_tList {
    int v;
    int *p;
};

struct GameSetup_tData {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops, trafficDensity, localCar, catchupLogic, replayMode, instantReplay, mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment, song, Weather, Fog, Damage, Time, randSeed, easter;
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit, checkpointType;
    int checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech, SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};

struct Input_tResults {
    char steering;
    u_char gas, brake, flags;
};

struct tPMenuCommand {
    int type;
    tPMenu *nextMenu;
};

struct tPMenu {
    int fCurrentItem;
    BOOL fHighlight;
    tPMenuItem *fItemList[16];
    tPMenu *fNextMenu;
    int fNumItems;
    __nfs4_vtbl_ptr_t (*_vf)[5];

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

struct tPListIterator {
    short *fSelectionList;
    int *fValue;
    __nfs4_vtbl_ptr_t (*_vf)[6];

    tPListIterator() {}
    tPListIterator(short *selection, int *valPtr);
    ~tPListIterator();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);
};

struct tPListIteratorIndexed : public tPListIterator {
    char *fIndex;

    tPListIteratorIndexed(short *selection, int *valPtr, char *index);
    ~tPListIteratorIndexed();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    int Decrement(tPlayer player);
};

struct tPMenuItem {
    unsigned int fFlags, fTextDescription;
    __nfs4_vtbl_ptr_t (*_vf)[7];

    tPMenuItem(unsigned int textDescription);
    ~tPMenuItem();
    tPMenu *NextMenu();
    void *Debounce();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
    void *IsEnabled();
    void *IsDisabled();
};

struct tPMenuItemNonInteractiveText : public tPMenuItem {

    tPMenuItemNonInteractiveText(unsigned int textDescription);
    ~tPMenuItemNonInteractiveText();
    void Draw(bool selected);
    void *IsNavigable();
};

struct tPMenuItemInteractive : public tPMenuItem {

    tPMenuItemInteractive(unsigned int textDescription);
    ~tPMenuItemInteractive();
    void Draw(bool selected);
    void *IsNavigable();
};

struct tPMenuItemLeftRightChoice : public tPMenuItemInteractive {
    tPListIterator *fData;

    tPMenuItemLeftRightChoice(unsigned int textDescription, tPListIterator *dataPtr);
    ~tPMenuItemLeftRightChoice();
    int ProcessInput(tInputKeyType &keyval, tPMenuCommand &menu_cmd);
    void Draw(bool selected);
};

struct tPMenuItemLeftRightSlider : public tPMenuItemInteractive {
    int *fData;
    char fMaxVal;

    tPMenuItemLeftRightSlider(unsigned int textDescription, int *dataPtr, char maxVal);
    ~tPMenuItemLeftRightSlider();
    void *Debounce();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &menu_command);
    void Draw(bool selected);
};

struct tPMenuItemLeftRightSliderIndexed : public tPMenuItemLeftRightSlider {
    char *fIndex;

    tPMenuItemLeftRightSliderIndexed(unsigned int textDescription, int *dataPtr, char maxVal, char *index);
    ~tPMenuItemLeftRightSliderIndexed();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
    void Draw(bool selected);
};

struct tPMenuItemGoToMenuButton : public tPMenuItemInteractive {
    tPMenu *fNewMenu;
    void *fOnButtonPress;

    tPMenuItemGoToMenuButton(unsigned int textDescription, tPMenu *newMenu, void (*OnButtonPress)(tPMenuCommand&));
    ~tPMenuItemGoToMenuButton();
    tPMenu *NextMenu();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
};

struct tPMenuItemCommandButton : public tPMenuItemInteractive {
    int fCommand;

    tPMenuItemCommandButton(unsigned int textDescription, tPMenuCommandType command);
    ~tPMenuItemCommandButton();
    void ProcessInput(tInputKeyType &keyval, tPMenuCommand &command);
};

struct tPauseMenuDefs {
    tPMenuItemNonInteractiveText itemGamePaused;
    tPMenuItemCommandButton itemContinue, itemRestart;
    tPMenuItemGoToMenuButton itemOptions;
    tPMenuItemCommandButton itemQuitRace, itemForfeitRace;
    tPMenu menuPause;
    tPMenuItemNonInteractiveText itemOptionsTitle;
    tPMenuItemGoToMenuButton itemAudioSettings, itemControllerSettings;
    tPMenu menuOptions;
    tPMenuItemNonInteractiveText itemAudioSettingsTitle;
    tPListIterator iteratorAudioMode;
    tPMenuItemLeftRightChoice itemAudioSettingsAudioMode;
    tPMenuItemLeftRightSlider itemAudioSettingsMusicVolume, itemAudioSettingsFXVolume, itemAudioSettingsSpeechVolume, itemAudioSettingsEngineVolume, itemAudioSettingsAmbientVolume;
    tPMenu menuAudioSettings;
    tPListIteratorIndexed iteratorConfig;
    tPMenuItemNonInteractiveText itemControllerSettingsTitle;
    tPMenuItemLeftRightChoice itemControllerConfig;
    tPMenuItemLeftRightSliderIndexed itemControllerShockMode, itemControllerShockImpact;
    tPMenu menuControllerConfig;
    tPMenuItemNonInteractiveText itemConfirmTitle, itemConfirmAreYouSure;
    tPMenuItemCommandButton itemConfirmNo, itemConfirmYes;
    tPMenu menuConfirmYesNo;
};

struct tNfsSystemInfo {
    int userRam;
};

struct tListIteratorIndexed : public tListIterator {
    tListIteratorIndexed() {}
    char *fIndex;

    tListIteratorIndexed(short *selection, char *valPtr, char *index);
    ~tListIteratorIndexed();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tShapeInformation {
    tTexture_ShapeInfo *fShapes;
    char *fFile, *fDestFile;
    unsigned int async_handle;
    u_short fNumShapes, fFlags;
    char fFilename[16];
    BOOL fLoadCancelled;
};

struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    BOOL fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
    __nfs4_vtbl_ptr_t (*_vf)[10];

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
    int TransitionOff(tScreen_TransitionType type, tMenu *menu);
    int TransitionOn(tScreen_TransitionType type, tMenu *menu);
    void UpdateTransition();
    int TransitionIsFinished();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void DrawForeground();
    void DrawBackground();
};

struct tCarLineup {
    BOOL isPlayerCar;
    int personality;
    char position;
    int carModel;
    char carColor, carUpgrades;
};

struct tTrackInformation {
    char fTrackID;
    u_char fSimNumber, fTrackDifficulty, fAvailable, fIsEgg, fLengthKM, fLengthMiles, fNumMoments;
    char fShapeName[8], fSplineName[8];
    char fCountry, fDispatch, fReverseCall, fLanguage;
    char fTrafficCars[6];
    short fTX, fTY, fSX, fSY;
    u_char fSpeedoCountry, fPad;
    long fRotate;
};

struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    BOOL fAvailableTracks[16], fViewableTracks[16];

    void SetClassAvailable(tTrackClassType cls, bool avail);


    void Initialize();
    void LoadTracks(tSaveTrackInfo &load);
    void SaveTracks(tSaveTrackInfo &save);
    void GetTrack(short trackNumber, tTrackInformation &trackInfo);
    void LoadDescription();
    void ReleaseDescription();
    void SetTrackAvailable(short track, bool avail);
    tTrackInformation *GetTrackByID(short track);

};

struct tTierInfo {
    u_char fNumTournaments, fDescriptionID, fTournOffset, fPad;
    u_char fReserved[8];
};

struct tTourneyInfo {
    char fTournamentID;
    u_char fNumTracks, fTrackOffset, fOpponentCarClass, fTraffic, fKnockout, fNumCars, fAwardCar, fAwardCarModel, fAwardCarUpgrades;
    u_short fActivateFlags, fRequiredFlags;
    u_char fActivatedTrack, fActivatedCarClass, fActivatedCar, fRequiredTournamentID, fRequiredCar, fRequiredUpgrades, fSpecificUpgrades, fRequiredCheatID, fTrophyID, fPad;
    long fPrize[6];
    long fEntranceFee;
    u_char fPersonalities[5], fOpponentCar[5], fOpponentUpgrades[5];
    u_char fActivatedTrackClass, fActivatedCheat, fNumLaps;
    u_char fReserved[14];
};

struct tTrackInfo {
    char fTrackNumber;
    u_char fDirection, fMirrored, fTimeOfDay, fWeather, fRandom, fSituations, fPad;
    long fPrize[6];
    u_long fDifficulty;
    u_char fReserved[4];
};

struct tTournamentDefinition {
    tTierInfo fTiers[3];
    tTourneyInfo fTournaments[64];
    tTrackInfo fTracks[128];
};

struct tAwardInformation {
    long fMoney, fTournMoney;
    u_short fActivateFlags;
    char fActivateTrack;
    int fActivateCarClass, fActivateCar, fActivateTrackClass;
    long fActivateCheat;
    BOOL fAwardCar, fAwardCarGarageFull;
    long fAwardCarBonusMoney;
    int fAwardCarModel;
    char fAwardCarColor, fAwardCarUpgrades;
    BOOL fCompletedTier;
    short fCompletedText;
    int fCompletedCar;
    BOOL fCompletedGarageFull;
    long fCompletedBonusMoney;
};

struct tCompetitor {
    int fPersonality;
    u_char fVariation;
    char fIsPlayerCar;
    BOOL fEliminated;
    u_short fPoints;
    u_char fPosition;
};

struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    short fNumRacers, fPadNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65];
    short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;


    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
    void UpdateTrackList(short tier, short tournament);
    short *GetTrackList(short tier, short tournament);
    void GetTrackToRace(tTrackInfo &);
    void StartNewTournament(unsigned char, unsigned char);
    short IsTournamentFinished();
    void UpdateTournFinishMoney();
    void UpdateTrackFinishMoney();
    void CalcTrackFinishDamageBill(bool, long &, long &);
    void UpdateTrackFinishPoints();
    short AdvanceToNextTrack();
    short GetLastTrackRaced();
    void SaveTournament(tSaveTournament &);
    void LoadTournament(tSaveTournament &);
    short GetNumCompetitors();
    void UpdateCarLineup();
    long GetTrackFinishPrize(short);
    long GetTournamentFinishPrize(short);
    void GetAwardInformation(tAwardInformation &);
    void UpdateAwardInformation();
    short TournPointTotal(short *);
    short PlayerRanking(short);
    void CalcTierFinishPrize();
    void GetTrophyName(tTourneyInfo *, tTrophySize, char *, int);
    void *ValidCar(tCarInfo &);
};

struct tMissionTierInfo {
    u_char fNumMissions, fDescriptionID, fMissionOffset, fPad;
};

struct tMissionInfo {
    u_char fDescriptionID, fTrackNumber, fDirection, fMirrored, fTimeOfDay, fWeather, fTraffic, fPad;
    u_short fStageOffset;
    u_char fNumStages;
    u_char fReserved[9];
};

struct tStageInfo {
    u_char fCarModel, fColor, fAIPersonality, fDirection;
    short fTimeLimit, fWingman, fSpikeBelt, fBlockadeCop;
    u_char fPlacement, fStyle;
    u_short fDistance;
    u_long fSpeed, fWeight, fGlue;
    u_char fSpeechColor;
    u_char fReserved[15];
};

struct tAcademyDefinition {
    tMissionTierInfo fTiers[8];
    tMissionInfo fMissions[64];
    tStageInfo fStages[256];
};

struct tMissionManager {
    char fNumTiers;
    tAcademyDefinition *fDefinition;

    void Initialize();
    void LoadDescription(bool LoadHotPursuit);
    void ReleaseDescription();
    short GetMissionStages(short tier, short mission, tStageInfo **pStages);
    void GetMissionToRace(tMissionInfo **mission);
};

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};

struct tDialogBase : public tScreen {
    short specificPlayer, left, top, width, height, reservedheight;
    BOOL currentlyOn;
    long startTicks, timeOutTicks;
    short OffsetX, OffsetY, MaxW, MaxH;
    BOOL fFullyOpen;
    short fDefault, ReturnValue;
    int fFadeText;
    tDialogBase();

    void Display();


    short ShouldTimeOut();
    int InitializeClass();
    static int DrawAllDialogs();
    int HideAllDialogs();
    static int GetTopMostDialog();
    void Hide();
    void Draw();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    ~tDialogBase();

};

struct tDialogMessageString : public tDialogBase {
    char *string;
    BOOL Centerit;
    tDialogMessageString();

    void CalculateDimensions();
    void Draw();
    ~tDialogMessageString();

};

struct tDialogInteractive : public tDialogMessageString {
    BOOL ReadyToReturnValue, fCurrentlyRunning;

    short Run();

};

struct tDialogYesNo : public tDialogInteractive {
    int yesnowords[2];

    void CalculateDimensions();
    tDialogYesNo();
    void Draw();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    ~tDialogYesNo();

};

struct tCredit {
    short titleTextID, subTitleTextID, titleX, titleY, titleJustify, titleWidth, subTitleX, subTitleY, subTitleJustify, subTitleWidth, textX, textY, textJustify, creditType, bgNumber, pad;
    char text[292];
};

struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    BOOL fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    BOOL StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;

    void Setup();
    int Init(int arg1);
    void DeInit();
    void RealDeInit();
    void Draw(bool selected);
    void SetupCurrCredit();
    void DrawCurrCredit();
};

struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};

struct ObjectMultiAnim {
    ObjectAnim _base_ObjectAnim;
    coorddef impactVel;
    Trk_SimObject *simObj;
    Trk_CollideBoomInst *objCollideInstance;
    Trk_ObjectDef *objDef;
    AnimDef *animParms;
    int objectAngle, impactAngle;
    AnimScript *script;
    ObjectFinishedMultiAnim *finishedAnim;
};

struct ObjectSignAnim {
    ObjectAnim _base_ObjectAnim;
    coorddef impactVel;
    Trk_SimObject *simObj;
    Trk_CollideBoomInst *objCollideInstance;
    Trk_ObjectDef *objDef;
    AnimDef *animParms;
    int objectAngle, impactAngle;
    AnimScript *script;
    ObjectFinishedSignAnim *finishedAnim;
};

struct Object_tIMassObjInfo {
    Trk_AnimateInst *animInst;
    coorddef dimension, lastPos;
    int lastTick;
};

struct Physics_tWheelAccStruct {
    int acc, roadGrip, steeringAcc, steeringAngle;
    coorddef velCap, finalAcc;
    int frontTire, skid;
};

struct Draw_tVertex {
    PCOORD16 sv;
};

struct Draw_CarCache {
    Draw_tCacheHeader head;
    MATRIX matB;
    int pad;
    u_long *sub_ot;
    int otz, sub_otz, bfct;
    DR_MODE drawModeOn, drawModeOff;
    Draw_tPixMap *pmxStart;
    Draw_tPixMap ePmx0, ePmx1;
    int eAddZ, sub_otSize;
    long color, eColor0, eColor1, eColor2;
    VECTOR tv;
    COORD16 vt0;
    u_char u0, v0;
    COORD16 vt1;
    u_char u1, v1;
    COORD16 vt2;
    u_char u2, v2;
    short dvx0, dvy0, dvx1, dvy1, dvx2, dvy2;
    Draw_CarVertex tV[96];
    COORD16 vt3;
    u_char u3, v3;
    COORD16 vt4;
    u_char u4, v4;
    COORD16 vt5;
    u_char u5, v5;
    COORD16 vt6;
    u_char offsetU0, offsetV0;
    COORD16 vt7;
    u_char offsetU1, offsetV1;
    COORD16 vt8;
    u_char offsetU2, offsetV2;
};

struct Transformer_zScene {
    Transformer_zObj *obj[57];
    Transformer_zOverlay overlay[90];
};

struct R3DCar_tEnvMapInfo {
    int eScaleX, eScaleY, rideHeight, upgradeHeight;
};


struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
};



struct POLY_FT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
    short x3, y3;
    u_char u3, v3;
    u_short pad2;
};



struct DR_STP {
    u_long tag;
    u_long code[2];
};


struct tControllerData {
    char steering[32];
    u_char gas[32], brake[32], states[32];
};

struct tReplayInterface {
    int pause, speed, end, camera, selection, depressed, changeCamera, statsScreen;
};

struct tReplayCameraModes {
    int defaultCamera, timeCounter, cameraMode, cutToNextCamera;
};

struct tReplayBuffer {
    GameSetup_tData gameSetup;
    int size;
    char buffer[24576];
};

struct CSceneList {
    int id_, numElements_, slice_, versionNumber_;
};

struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim, goalClockTicks, currentClockTicks;
};

struct sim_queue {
    Input_tResults Buffer[2][32];
    int Validity[2][32];
    int HeadTime;
    int TailTime[2];
};

struct Souffle_tISouffle {
    char type, id, wind, cycle;
    int aspeed, angle;
    coorddef source, motion, extramotion;
    SVECTOR trans;
    int rndpixmap, ground, colour;
};

struct Stats_tPosition {
    int car, slice, sliceTime, isHuman;
};

struct Trk_Material {
    short shapeIndex;
    u_char flag, uvFlag, r, g, b;
    char textureCount;
    u_char interval;
    char pad;
};

struct TrackHeader {
    int type, version, maxMetaChunkSize, maxGeomCollSize, maxFullSize, maxSplitSize, metaChunkCount, chunkCount;
};

struct SaveSurface {
    short fCount, fMaxCount;
    tSaveSurface *fStack;


    void Save(Trk_NewSimQuad *simQuad);
    void RestoreAll();
};

struct tBoundingSphere {
    COORD16 cp;
    short radius;
};

struct Track_MipMap {
    u_short code[2];
    int shapeParentIndex, mipMapIndex;
};

struct Track_MultiPalette {
    u_char charcode[2];
    short palnum, origshapeindex, actualshapeindex;
};

struct Track_tMaterialController {
    short type;
    u_char textureMax;
    char pad;
    u_char uv0, uv1, uv2, uv3;
    char textureCount;
    u_char interval;
    short pmxIndex;
    Track_tMaterial *matPtr;
};

struct tSkid {
    coorddef pt;
    CVECTOR clr;
    int type;
    Skidmark_Segment *nseg;
    int chunk;
};

struct SNDSYSOPTS {
    SNDSYSCAP cap;
    SNDSYSSET set;
    SNDSYSVEC vec;
};

struct SpuVolume {
    short left, right;
};

struct SpuExtAttr {
    SpuVolume volume;
    long reverb, mix;
};

struct SpuStVoiceAttr {
    char status, pad1, pad2, pad3;
    long last_size;
    u_long buf_addr, data_addr;
};

struct CarIO_textureInfo {
    char *tex, *pal;
    int palShare;
};

struct Input_tDeviceList {
    char *devicename;
    void *devicefunc, *startupfunc;
};

struct dflip {
    DISPENV disp;
    char *server;
};

struct Draw_tView {
    int otsize, membudget;
    DRAWENV drawenv[2];
    u_long *ot[2];
};


struct POLY_FT3 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
};



struct POLY_G3 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, pad1;
    short x1, y1;
    u_char r2, g2, b2, pad2;
    short x2, y2;
};


struct DrawC_tEnvMap {
    short slice, tex, extra;
};


struct POLY_GT3 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    u_char r1, g1, b1, p1;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    u_char r2, g2, b2, p2;
    short x2, y2;
    u_char u2, v2;
    u_short pad2;
};



struct DR_TWIN {
    u_long tag;
    u_long code[2];
};


struct Trk_Line {
    u_char firstPoint, slice, type, quadIndex;
};

struct Draw_tGiveShelbyMoreCache {
    Draw_tCacheHeader head;
    MATRIX matB, matNight, matCop, identMat;
    int otz;
    VECTOR tVn0, tVn1, tVn2, tVn3;
    short light, doublelayer, startfog, distfog;
    CCOORD16 *vertices;
    u_char chunkInd, rezInd, garb3, quadCount;
    void *quads;
    int offset;
    Track_tMaterial *materials;
    COORD16 trans;
    Track_tArtresource *artInfo;
    Trk_NewStrip *stripPtr;
    short numStrips;
    char nightFlags, zeroGTETransFlag;
    short night_ZNear;
    u_char night_XDistShift, night_ZDistShift, night_DrawLightning, night_LightningType, fogstate, padnight;
    POLY_GT4 GT4Prim;
    u_short tpage, clut;
    short offsubdivid;
    u_char code, magiknum;
    Draw_SVertex v0, v1, v2, v3;
    Draw_SubdivStruct div;
};

struct Draw_tCtrlSkidmark {
    matrixtdef m;
    coorddef t;
    int count;
    Skidmark_Chunk *smp;
};

struct ChunkObjectInfo {
    Trk_SimObject *simObjs;
    Group *objInstanceBuf;
    int doFrustumClip, zClipSq, offset;
    short *visList;
};

struct Force_tGlobal {
    u_char active, high, low, jolt, time, fade;
    u_char actuator[2];
};

struct charactertbl {
    u_char index[2];
    u_char width, height;
    u_char u[2], v[2];
    char advance, xoffset, yoffset;
};


struct SPRT {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short w, h;
};


struct cluttbl {
    unsigned int type : 8;
    int next : 24;
    short width, height, centerx, centery, shapex, shapey;
    short data[16];
};


struct POLY_G4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, pad1;
    short x1, y1;
    u_char r2, g2, b2, pad2;
    short x2, y2;
    u_char r3, g3, b3, pad3;
    short x3, y3;
};



struct LINE_G2 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, p1;
    short x1, y1;
};


struct Draw_FlareCache {
    Draw_tCacheHeader head;
};

struct FLARE_DEF {
    DVECTOR pos[2], oldpos[2];
    u_short screenData[2][5][5];
    int size;
    FLARE_PIECE_DEF *piece;
    char isDrawn[2];
};

struct Flare_tInfo {
    u_long chalo, cbeam;
    int scale, flags;
};


struct TILE_1 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
};


struct Draw_HorizonCache {
    Draw_tCacheHeader head;
    DVECTOR scptTop[17], scptMidBot[17], scptPmxLeft[17], scptPmxRight[17];
    int vertexTop[18];
};

struct Draw_SkyCache {
    Draw_tCacheHeader head;
    DVECTOR pSkyMesh[85];
    int pSkyZ[85];
};

struct tHrz_LightningFork {
    DVECTOR pos;
    char pmxIndex;
};

struct tHrz_Lightning {
    tHrz_LightningFork forks[16];
    int brightness;
    char numForks;
};


struct POLY_F3 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2;
};


struct tSmallCoordXY {
    short x, y;
};

struct tBTCPerpInfo {
    char name[8];
    int time;
    BOOL caught;
};

struct tCompRGB {
    char r, g, b;
};

struct tNightInitCache {
    tCompRGB table[257];
};

struct CARD_FILE_HEADER {
    char magic[2];
    char type, numslots;
    char documentname[64];
    char pad[28];
    char clut[32];
    char icon[3][128];
};

struct eacelement {
    eacelement *link;
};

struct sfxsouffle {
    Draw_tPixMap pmx;
    SVECTOR v0, v1, v2, v3;
};

struct Sfx_tCache {
    Draw_tCacheHeader head;
    int otz;
};

struct Texture_pal8bit {
    int x, y;
    short pal[256];
};

struct CSVECTOR {
    int r, g, b;
};

struct TP_ZPaletteSystem {
    int numdepthclut;
};

struct FogKey {
    short distance, slice;
    FogKey *next, *prev;
};

struct CTrackSpecHeader {
    int version, num_spec;
};

struct CTrackSpec {
    short fogstate, weatherstate, horizonstate, skystate, nightstate, depthcuestate, worldcolorstate, pad0;
    CFogSpec fogspec;
    CWeatherSpec weatherspec;
    CHorizonSpec horizonspec;
    CSkySpec skyspec;
    CNightSpec nightspec;
    CDepthCueSpec depthcuespec;
    CWorldColor worldcolorspec;
};

struct Weather_tSys {
    int num[2];
    SVECTOR velocity;
    long hdist;
    short znear, zfar, length, bottom, top, height, width;
};

struct Weather_tSplatInfo {
    DVECTOR pos;
    int startTick;
};


struct DR_AREA {
    u_long tag;
    u_long code[2];
};


struct tMenuCommand {
    int type;
    tMenu *nextMenu;
};

struct tListIteratorRangeIndexed : public tListIteratorRange {
    tListIteratorRangeIndexed() {}
    char *fIndex;

    tListIteratorRangeIndexed(char minValue, char maxValue, char *valPtr, char *index);
    ~tListIteratorRangeIndexed();
    int Value(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tMenuItemLeftRightChoice() {}
    tListIterator *fData;

    tMenuItemLeftRightChoice(unsigned int textDescription, tListIterator *dataPtr);
    ~tMenuItemLeftRightChoice();
    int ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void Draw(bool selected);

};

struct tMenuItemLeftRightSlider : public tMenuItemInteractive {
    tMenuItemLeftRightSlider() {}
    tListIterator *fData;
    short fX, fY, fWidth, fHeight;

    tMenuItemLeftRightSlider(unsigned int textDescription, tListIterator *dataPtr);
    ~tMenuItemLeftRightSlider();
    long DebounceKeys();
    int ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    void Draw(bool selected);
    void SetDimensions(short x, short y, short width, short height);

};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    tMenuItemGoToMenuButton() {}
    void *fOnButtonPress;

    tMenuItemGoToMenuButton(unsigned int textDescription, tMenu *newMenu, void (*OnButtonPress)(tMenuCommand&));
    ~tMenuItemGoToMenuButton();
    int ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);

};

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

struct tDialogHelp : public tDialogBase {
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;

    void AddItem(short textID,short controllerID);
    void CalculateDimensions();
    void Draw();
    ~tDialogHelp();

};

struct tDialogMessageStringWithTimeout : public tDialogMessageString {
    ~tDialogMessageStringWithTimeout();
};

struct tDialogNoInputMessage : public tDialogMessageString {

    void ProcessInput(tPlayer atPlayer,tInputKeyType &keyval, tMenuCommand &command);
    ~tDialogNoInputMessage();

};

struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2], fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    BOOL waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    BOOL gotName[2], needName[2];
    int speechToPlay[2];
    void Redraw();

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

struct tMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuButton {
    tMenuItemGoToMenuNFS4Button() {}
    int fOrdinalPos;
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;

    tMenuItemGoToMenuNFS4Button(unsigned int textDescription,tMenu *newMenu, void (*OnButtonPress)(tMenuCommand&),int firstFrame,int numFrames);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int x,int y,bool selected);
    void TransitionOn();
    void TransitionOff();
    void * TransitionIsFinished();
    void UpdateTransition(bool selected);
    void Draw(bool selected);

};

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    tMenuItemNFS4LeftRightChoice() {}
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;

    tMenuItemNFS4LeftRightChoice(unsigned int textDescription,tListIterator *dataPtr, int firstFrame,int numFrames);
    ~tMenuItemNFS4LeftRightChoice();
    void Draw(int x,int y,bool selected);
    void TransitionOn();
    void TransitionOff();
    void * TransitionIsFinished();
    void UpdateTransition(bool selected);

};

struct tBlankMenuItemNFS4LeftRightChoice : public tMenuItemNFS4LeftRightChoice {
    void *TransitionIsFinished();
    void Draw(int, int, char);
    ~tBlankMenuItemNFS4LeftRightChoice();
};

struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {

    void Draw(int x,int y,bool selected);
    ~tMenuItemOptionsLeftRightChoice();

};

struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;

    void TransitionOn();
    void Draw(int x,int y,bool selected);
    ~tMenuItemOptionsTwoItemChoice();

};

struct tMenuNFS4 : public tMenu {
    tMenuNFS4() {}
    BOOL fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    char fTransitionDirection, fLastItem, fNumItems;

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

struct tMenuNFS4TwoPlayer : public tMenuNFS4 {
    tMenuNFS4TwoPlayer() {}

    tMenuNFS4TwoPlayer(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...);
    ~tMenuNFS4TwoPlayer();
    void DrawItem(int item);

};

struct tMenuNFS4Bottom : public tMenuNFS4 {
    tMenuNFS4Bottom() {}

    tMenuNFS4Bottom(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...);
    ~tMenuNFS4Bottom();
    void Draw();

};

struct tMenuBlank : public tMenuNFS4 {
    tMenuBlank() {}

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

struct tMenuOptions : public tMenuNFS4 {
    tMenuOptions() {}
    u_long fMenuEnterTicks;
    short fPlayer;

    tMenuOptions(unsigned int flags,tScreen *screenHandler,tMenu *nextMenu, tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,short player, tMenuItem *firstItem,...);
    ~tMenuOptions();
    void Draw();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command);
    void * IsSubMenu();

};

struct tMenuItemLeftRightFade : public tMenuItemLeftRightChoice {
    tMenuItemLeftRightFade() {}
    short fFadeVal, fFadeDir;
    BOOL fInTransition;
    int flareextra;


    tMenuItemLeftRightFade(unsigned int, tListIterator *);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);
    void MyLeftRightDraw(int, int);

};

struct tOptionsMenu : public tMenu {
    tOptionsMenu() {}
    BOOL fInMenuTransition;
    char fTransitionDirection;
    short fPrevItem;
    int fScreenFade, fFirstFrame, fNumFrames;


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

struct tInsideBoxMenu : public tMenu {
    short fPrevItem, fMoving, fMovingDir;


    tInsideBoxMenu() {}
    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxMenu();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int Draw(short, short, short, short, short);

};

struct tMenuItemSlidingMenu : public tMenuItem {
    tMenuItemSlidingMenu() {}
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    BOOL fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    BOOL fFillback;


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

struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    BOOL fActive;


    int UpdatefOpenHeight(bool);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tMenuItemDisplayLeftRightChoice : public tMenuItemLeftRightFade {


    int Draw(int, int, bool);

};

struct tMenuItemOnOffLeftRightChoice : public tMenuItemLeftRightFade {
    short fOnFade;


    void TransitionOn();
    int Draw(int, int, bool);

};

struct tMenuItemLeftRightAudioSlider : public tMenuItemLeftRightSlider {
    tMenuItemLeftRightAudioSlider() {}
    short fFadeVal, fFadeDir;
    BOOL fInTransition;
    short fAudioArt;
    int flareextra;


    tMenuItemLeftRightAudioSlider(unsigned int, tListIterator *, int);
    ~tMenuItemLeftRightAudioSlider();
    int Draw(int, int, bool);
    int Percentage();
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);

};

struct tInsideBoxSongMenu : public tInsideBoxMenu {
    tInsideBoxSongMenu() {}
    short fOnOffFade[5], fSelFade[5];


    tInsideBoxSongMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxSongMenu();
    void Draw(short, short, short, short, short);
    void DrawOneSong(short, short, short, short, short, short);
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tMenuItemControllerLeftRightChoice : public tMenuItemLeftRightFade {


    int Draw(int, int, bool);

};

struct tInsideBoxLeftRightSlider : public tMenuItemLeftRightSlider {
    tInsideBoxLeftRightSlider() {}


    tInsideBoxLeftRightSlider(unsigned int, tListIterator *);
    ~tInsideBoxLeftRightSlider();
    int Draw(int, int, int, bool);

};

struct tInsideBoxTwoWaySlider : public tMenuItemLeftRightSlider {
    tInsideBoxTwoWaySlider() {}
    short fType;
    BOOL fActive;


    tInsideBoxTwoWaySlider(unsigned int, tListIterator *, int);
    ~tInsideBoxTwoWaySlider();
    int ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int Draw(int, int, int, bool);
    void Calibrate();

};

struct tUserNameMenuItem : public tMenuItem {
    tUserNameMenuItem() {}
    char *fData;
    short fMaxStringLength, fCurrentColumn, fCurrentRow;
    char fRowList[10][9];
    short fPlayer, fFadeVal, fFadeDir;
    BOOL fInTransition;


    tUserNameMenuItem(unsigned int);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int Draw(bool);
    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);

};

struct tMenuItemGoToMenuButtonFade : public tMenuItemGoToMenuButton {
    short fFadeVal, fFadeDir;
    BOOL fInTransition;
    short fEnableVal;


    void TransitionOff();
    void TransitionOn();
    void * TransitionIsFinished();
    void UpdateTransition(bool);

};

struct tMemoryCardMenuItem : public tMenuItemGoToMenuButtonFade {


    int Draw(bool);

};

struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {
    void *TransitionIsFinished();
    void Draw(int, int, char);
    void Draw(int);
    ~tBlankMenuItemGoToMenuNFS4Button();
};

struct tInsideBoxControllerLeftRightSlider {
    tInsideBoxLeftRightSlider _base_tInsideBoxLeftRightSlider;


    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

};

struct tSaveCarInfo {
    tOwnedCarInfo fSaveInfo[32];
    u_char fSaveAvailable[48], fSaveViewable[48];
};

struct tListIteratorCar : public tListIterator {
    tListIteratorCar() {}
    int fCarListFilter;
    tCarManager *fCarManager;
    int fNameLength;

    tListIteratorCar(char *valPtr,tCarManager *carManager);
    ~tListIteratorCar();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer atIndex);
    void AdjustPosition(tPlayer atIndex,short direction);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    void * ValidCar(tPlayer atIndex,char carNumber);

};

struct tListIteratorCarColor : public tListIterator {
    tListIteratorCarColor() {}
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;

    tListIteratorCarColor(char *value,char *player,char *playerCar,int indexSize, tCarManager *carManager);
    ~tListIteratorCarColor();
    char Value(tPlayer arg1);
    int TextValue(tPlayer arg1);
    int Increment(tPlayer arg1);
    void Decrement(tPlayer arg1);

};

struct tSaveTrackInfo {
    u_char fTrackActivated[16];
};

struct tListIteratorTrack : public tListIteratorIndexed {
    tListIteratorTrack() {}
    tTrackManager *fTrackManager;

    tListIteratorTrack(char *valPtr, char *index, tTrackManager *trackManager);
    ~tListIteratorTrack();
    short TextValue(tPlayer atIndex);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    void *ValidTrack(char track);

};

struct tSaveTournament {
    long fSaveMoney;
    u_char fSaveTier, fSaveTournament, fSaveTrack, fSaveNumRacers;
    tCompetitor fSaveCompetitors[6];
    u_char fSaveBestPlacement[64];
    short fSaveTierFinishPrize[4];
};

struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;

    tListIteratorTournament() {}
    tListIteratorTournament(char *valPtr, tTournamentManager *tournManager);
    ~tListIteratorTournament();
    int Value(tPlayer);
    int TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
    void *ValidTournament(char);
};

struct tTVConfig {
    int state;
    short transition;
    u_short destBrightness, flags;
    short fxWide, fxThin;
    int tint;
    short x, y, w, h;
    u_char u, v, uw, vh, shapeType;
    u_short clut, tpage, shapex, shapey, clutID, flip_axis;
};

struct tVideoTransition {
    int state;
    u_short flags;
    u_char u, v, uw, vh;
    u_short clut, tpage;
    unsigned int tint;
    short bright;
};

struct tVideo {
    char x, y, width, height, tileWidth, tileHeight, deltaX, deltaY;
};

struct FE3d_zUV {
    u_char u, v;
};

struct FE3d_zFacet {
    u_short vertexId0, vertexId1, vertexId2, uvId0, uvId1, uvId2;
    SVECTOR normal[3];
    CVECTOR color;
    u_char flag, pad1, pad2, pad3;
};

struct FE3d_zObj {
    int numVertex, numUV, numFacet;
    u_char textureId, textureWidth, textureHeight, pad1;
    COORD16 *vertex;
    FE3d_zUV *uv;
    COORD16 *Nvertex;
    FE3d_zFacet *facet;
};

struct tScreenUserName : public tScreen {
    tOptionsMenu *callingMenu;
    short fTextFade;
    BOOL fInTransition;
    char fRowList[10][9];
    tScreenUserName();

    void Initialize();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawVerticalLine(short x, short y, short gridpos);
    void DrawHorizontalLine(short x, short y, short gridpos);
    void DrawBackground();
    ~tScreenUserName();
};

struct tScreenTournamentStandings : public tScreen {
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    BOOL gotmoney, gotbonus, gotbilled, fDrawMoney, fCountedDown, fStartCountdownNOW;
    int fCountSpeed;

    tScreenTournamentStandings();
    void Initialize();
    void Cleanup();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    void DrawBackground();
    ~tScreenTournamentStandings();
};

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {
    tScreenTournamentStandings3item();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    ~tScreenTournamentStandings3item();
};

struct LUMPYHEAD {
    u_long type, len, num, hlen;
};

struct FILEINFO {
    unsigned int offset, length;
    char name[1];
};

struct SPEECHINFO {
    char name[4];
    int multiplay, nHandle, nSoundHandle;
    char areLoading, soundIsPlaying, playNextOne;
    char *pBankHeader, *sSpeechData, *lastSpeechData;
    int vivHandle;
};

struct tDialogBackUpOnly : public tDialogMessageString {
    tDialogBackUpOnly(int);


    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval, tMenuCommand &command);
    ~tDialogBackUpOnly();

};

struct tDialogYesNoMem : public tDialogYesNo {

    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command );
    ~tDialogYesNoMem();

};

struct tDialogYesNoTri : public tDialogYesNo {

    void ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command );
    ~tDialogYesNoTri();

};

struct CARDINFO_def {
    int status, lasterror, numfiles, freeblocks;
    DIRENTRY dir[15];
};

struct MCRDFILEHEADER_def {
    u_char magicnumber[2];
    u_char type, nslots;
    u_short title[32];
    u_char unused[28];
    u_char iconclut[32];
    u_char icon1[128], icon2[128], icon3[128];
};

struct MCRDFILEINFO_def {
    int cardnum;
    char name[24];
    char *title;
    int size, offset;
    unsigned int flags;
    MCRDFILEHEADER_def header;
    void *pData;
    shapetbl *icon[3];
};

struct helpKeyData {
    short text, button;
};

struct tHelpData {
    char autoGenerate;
    helpKeyData items[4];
};

struct tScreenControllerConfig : public tScreen {
    Force_tGlobal fShaker;
    char fPrevConfig, fTextConfig, fTextController, fPrevController;
    short fFade[2], fFadeController[2];
    int fStartTick;
    short fGotTick, fAnim, fAnimFrame, fAnimStart, fAnimStop, fAnimStep, fAnimController, fSwap, fAnimFade, fAnimFadeStart, fAnimFadeStop, fAnimFadeFrame, fAnimFadeController, CurrentlyLoadedArt, negconChoice;
    BOOL fTransitionedIn, fTransitioningIn, fTransitioningOut;
    short fArrowFade, fArrowFadeDir, fTextTypeOn;
    BOOL fFadeTextOut;
    short mult;
    tDialogYesNo negconPopUp;
    int fTimeOutStartTick;
    BOOL SuperFastFadeOut, fPlayedInSound;
    short fShakingItem;
    BOOL fResetShakeTimeOut;
    char fCurrentController;
    int player;

    void ClearActuators();
    void SetActuators(int max);
    void TurnOffShakers();
    void ShakeIt();
    short AnimKeyPoints(bool forward, bool pt);
    void CheckConfigs();
    void SwapInController();
    void SetCurrentController(bool firsttime);
    int CalcAnimFrame(int frame);
    void ActualDrawController(int frame, int fadelevelmain, int fadeleveltop, int shakex, int shakey);
    void DrawController();
    void HorzVertLine(short *ArrowLoc, bool type);
    void DrawArrow(short *ArrowLoc);
    void DrawBackground();
    void DrawForeground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    int GetHelpText();
    tScreenControllerConfig();
# 5122 "C:/Temp/nfs4-wt46-a10/recon/nfs4_types.h"
    ~tScreenControllerConfig() { }
};

struct tCheat {
    u_char name[8];
    int cheat;
};

struct tOldMenu {
    char *artFileName, *backgrName;
    short driver, current, flags, helpvariant;
    tItemButton *item[16];
};

struct tItemButton {
    short type, text;
    tOldMenu *nextMenu;
    char *value;
    short *selection;
    char defaultvalue;
    u_char flags, cases;
};

struct tPSXToFEMapping {
    int PSXKey, FEKey;
};

struct tListIteratorDoubleIndexed : public tListIterator {
    char *fIndex1;
    int index1multiplier;
    char *fIndex2;

    ~tListIteratorDoubleIndexed();
    int Value(tPlayer player);
    int TextValue(tPlayer player);
    int Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tListIteratorMultiPlayer : public tListIterator {

    ~tListIteratorMultiPlayer();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);

};

struct tScreenMain : public tScreen {
    int hVideo, fFrame;
    u_long fStartTicks, fAnimTicks;
    short fAnimLocation;
    int fState;
    tTVConfig tvConfigs[16];
    int tvStates[16];
    tVideoTransition tvTransitions[16];
    BOOL fTVsInitialized;
    char fTransitionDirection;
    BOOL fAnimationUploaded;
    short fPreviousAnim, fWarningFade, fPreviousMovie, fCurrentMovie;
    BOOL bVideoAborted;
    u_long fMovieTicks;
    tShapeInformation fVideoShapes[2];
    int fCurrentSlot;
    int fCurrentBG[2];
    int fNumTVsInTransition;
    tScreenMain();

    void SwapBackground(int num);
    int DoneLoadingBackground();
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

struct MCRDFILE_def {
    char *name, *title;
    int size, offset;
    unsigned int flags;
    void *pData;
    shapetbl *icon[3];
    u_char *numicons, *numblocks;
};

struct tVideoWall {
    tTVConfig *fTVs;
    short fFirstTVShape, fNumTVs;
    tTexture_ShapeInfo *fTVShapes;
    short *tvOrder;
    u_long fTVTicks;
    short fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY, fAvailableTextID, fAvailable, fAvailableBright, fValid, fAvailableX, fAvailableY;
    tTexture_ShapeInfo *fIconShapes;
    short fIcon, fIconFrames, fIconX, fIconY;
    BOOL fUpdated;

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

struct tOverlay {
    RECT location[2];
    short transition, delta, direction, ID;
};

struct tScreenCarSelect : public tScreen {
    tOverlay fOverlays[7];
    tOverlay *fCurrentOverlays[4];
    short fState, fPreviousCar, fPreviousCarID, fPreviousCountry;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall[2];
    short fBrightness[2], fDestBrightness[2];
    long fFadeTicks[2];
    BOOL fTVsInitialized, fInShowroom;
    u_long fShowroomTicks, fSpeechTicks;
    BOOL fSpeechPlayed;
    int fSplineInterval;
    u_long fCameraRotation;

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
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    void DrawVideoWall(short s);
    int GetCar(tCarInfo &car);
    void SetBrightness(short a, short b);
    void UpdateBrightness(short s);
    void DrawBackground();
    void DrawSliders(tCarInfo &car, short a, short b);
    void DrawForeground();
};

struct tScreenCarSelectDuel : public tScreenCarSelect {
    short fPreviousOpponent;
    BOOL fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;
    tScreenCarSelectDuel();

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

struct tScreenCarSelectTwoPlayer : public tScreenCarSelect {
    tDialogBackUpOnly CarDialog;
    tScreenCarSelectTwoPlayer();




    ~tScreenCarSelectTwoPlayer() { }
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

struct tScreenPinkSlipsCarSelect : public tScreenCarSelectTwoPlayer {
    int waitfordialog;
    CARDINFO_def *pCI;
    int fStartCheckTick;
    BOOL fCardFailed, fExitingScreen;
    tScreenPinkSlipsCarSelect();




    ~tScreenPinkSlipsCarSelect() { }
    int GetCar(tCarInfo &car);
    void DrawBackground();
    void DoMemCardStuff();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void SetDialog();
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
};

struct tScreenTournSelect : public tScreen {
    int hVideo, fFrame;
    tTVConfig tvConfigs[8];
    tTVConfig trophyTV[4];
    short fPreviousMovie, fCurrentMovie;
    u_long fStartTicks, fTVTicks;
    short fTransitionDirection;
    char fPreviousTrophy;
    BOOL fTVsInitialized;
    int PreCalculatedTournamentY, fPrevi;

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

struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    tScreenPinkSlipStandings();
    void DrawBackground();
    int ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    ~tScreenPinkSlipStandings();
};

struct tScreenTrophyRoom : public tScreen {
    tShapeInformation fTrophyShapes;
    short fNumTrophies;
    int startTicks;
    short fShapeCount;
    BOOL fLoadingTrophy;
    char fPreviousTrophy, fDoUpdate;
    BOOL fClearScreen;
    char fBrightness;
    u_long fStartTicks;
    short fTextInfo[16];
    char thisisuseless;
    int tier;
    short fRealCurrentTourn[2];
    short fTrophyList[64];

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

struct tScreenTrophyInfo : public tScreen {
    int BannerCol;
    tScreenTrophyInfo();

    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawBackground();
    ~tScreenTrophyInfo();
};

struct tScreenDisplay : public tScreen {
    tScreenDisplay();

    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    ~tScreenDisplay();
};

struct tScreenAudio : public tScreen {
    short fShapeCount;
    char prevAudioMode;
    short audioTest;
    int audioTestHandle;
    short fPrevSelectedSong;
    char fCurrentAudioMode;
    short fSelectedSong;
    AudioMus_tSongList *songlist;

    void PlaySound();
    void DrawForeground();
    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    tScreenAudio();
    void Initialize();
    void Cleanup();
    ~tScreenAudio();
};

struct tScreenMemcard : public tScreen {
    int theNFS4icon, card;
    CARDINFO_def *pCI;
    char fMemTitle[15][32];
    char goticon[15];
    u_char numicon[15], numblock[15];
    MCRDFILE_def fMemFile[15];
    u_short fMemIconClutId[15];
    short fFadeIcon[15];
    BOOL fReadyToGetNewIcons, fInitedMemCard;
    char fMemCardMessage[40];
    int fMemCardMessageTextSys, message;
    short memcardanimframe, count, cursorPosition;
    int checkingstart;
    BOOL fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons;
    int fScreenFadeReadyTick;
    short player;
    BOOL fGetNewIcons;

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

struct tScreenCongrats : public tScreen {
    int congratsMessage, trophy, smallSpinningThing, fNumSpinShapes, fNumSmallSpinShapes, fCarPlayer;
    long TotalCash, CashAwarded;
    int framenum, starttick;
    BOOL InExtraSpin;
    int InExtraSpinTick;
    tCarInfo fCarInfo;
    BOOL fGotCar;
    int fEnterTick;
    BOOL fCountedDown, fStartCountdownNOW;
    int fCountSpeed, fSpeechToPlay;
    short fCarX, fCarY;
    float fCarCX, fCarCY;

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

struct tScreenTournamentTrophy : public tScreenCongrats {
    short fShapeCount;
    char fDoUpdate;
    tScreenTournamentTrophy();
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    int GetCar(tCarInfo &car);
    void DrawCongratsMessage();
    void CalculatePrizes();
    ~tScreenTournamentTrophy();
};

struct tScreenPinkSlipCongrats : public tScreenCongrats {
    short fWinner;
    tScreenPinkSlipCongrats();
    void DrawCongratsMessage();
    int GetCar(tCarInfo &car);
    void CalculatePrizes();
    void Initialize();
    void Cleanup();
    ~tScreenPinkSlipCongrats();
};

struct tScreenBeTheCopCongrats : public tScreenCongrats {
    tScreenBeTheCopCongrats();
    int GetCar(tCarInfo &car);
    void CalculatePrizes();
    void DrawCongratsMessage();
    ~tScreenBeTheCopCongrats();
};

struct tScreenTournamentCongrats : public tScreenCongrats {
    tScreenTournamentCongrats();
    int GetCar(tCarInfo &car);
    void CalculatePrizes();
    void DrawCongratsMessage();
    ~tScreenTournamentCongrats();
};

struct tScreenTrackRecords : public tScreen {
    tRecordBuffer *TrackRecords;
    int flare_intensity, flareextra;
    BOOL fReadNewData;
    tScreenTrackRecords();

    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void DrawOneRecord(int index, bool newrecord, int y);
    void DrawRecords(short maxitem);
    void DrawBackground();
    ~tScreenTrackRecords();
};

struct tScreenTrackSelect : public tScreen {
    int hVideo, fFrame;
    short fPreviousTrack, fMovieTrack, fBrightness, fDestBrightness, fStartBrightness;
    u_long fStartTicks;
    BOOL fTicksSet;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    BOOL fTVsInitialized;
    u_long fVideoTicks;
    tScreenTrackSelect();

    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void SetBrightness(short bright);
    void UpdateBrightness(tTrackInformation &trackInfo);
    void UpdateVideoWall(tTrackInformation &trackInfo);
    void DrawVideoWall();
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    ~tScreenTrackSelect();
};

struct tScreenTrackInfo : public tScreen {
    tTrackInfo fTrack;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    tScreenTrackInfo();

    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void DrawBackground();
    void Initialize();
    void ProcessInput(tPlayer player, tInputKeyType &key, tMenuCommand &cmd);
    ~tScreenTrackInfo();
};

struct tScreenPinkSlips : public tScreen {
    tMenu *fMenu;
    int hVideo, fFrame;
    short fPreviousTrack, fBrightness, fDestBrightness, fStartBrightness;
    u_long fStartTicks, fTVTicks;
    char fTransitionDirection;
    tTVConfig fTrackTVs[8];
    tTVConfig fImageTVs[4];
    BOOL fTVsInitialized;
    tScreenPinkSlips();

    void DrawBackground();
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void UpdateVideoWall(tTrackInformation &trackInfo);
    void DrawVideoWall();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
    ~tScreenPinkSlips();
};

struct tAllScreens {
    tScreenMain screenMain;
    tScreenCarSelect screenCarSelect;
    tScreenCarSelectDuel screenCarSelectDuel;
    tScreenCarSelectTwoPlayer screenCarSelectTwoPlayer, screenCarSelectPlayerTwo;
    tScreenPinkSlipsCarSelect screenPinkSlipsCarSelectTwoPlayer, screenPinkSlipsCarSelectPlayerTwo;
    tScreenTrackRecords screenTrackRecords;
    tScreenTrackInfo screenTrackInfo;
    tScreenTrackSelect screenTrackSelect;
    tScreenTournSelect screenTournSelect;
    tScreenTournamentStandings screenTournamentStandings;
    tScreenTournamentTrophy screenTournamentTrophy;
    tScreenTrophyRoom screenTrophyRoom;
    tScreenTrophyInfo screenTrophyInfo;
    tScreenControllerConfig screenControllerConfig;
    tScreenDisplay screenDisplay;
    tScreenAudio screenAudio;
    tScreenMemcard screenMemcard;
    tScreenUserName screenUserName;
    tScreenPinkSlipCongrats screenPinkSlipCongrats;
    tScreenPinkSlipStandings screenPinkSlipStandings;
    tScreenTournamentStandings3item screenTournamentStandings3item;
    tScreenPinkSlips screenPinkSlips;
    tScreenBeTheCopCongrats screenBeTheCopCongrats;
    tScreenTournamentCongrats screenTournamentCongrats;
    tAllScreens();
    ~tAllScreens();
};

struct tPerpModelList {
    int carModel;
    char carColor;
};

struct tFEStream {
    short totalCars, totalModels, currentCar, numPlayers;
    tCarInfo playerCars[2];
    short numOpponents;
    tCarLineup carLineup[6];
    short numCops, numSuperCops;
    int copCars[6];
    short copCountry[6];
    short numTraffic;
    short trafficCars[6];
    short numPerpObjects, numPerps;
    tMissionInfo *pMission;
    tStageInfo *pStages;
    tPerpModelList perps[6];
    tTrackInformation trackInfo;
    tTrackInfo track;
};

struct tCarInLineup {
    char isPlayerCar, isAlive, AIPersonality, LineupPosition;
};

struct tGlobalMenuDefs {
    tMenuItemGoToMenuNFS4Button itemMainOnePlayerRace, itemMainTwoPlayerRace, itemMainTrophyRoom, itemMainOptions;
    tMenuNFS4 menuMain;
    tMenuItemGoToMenuNFS4Button itemTournTrophyRoom, itemSETrophyRoom;
    tMenuNFS4 menuTrophyRoomSelect;
    tMenuBlank menuTrophyInfo;
    tMenuItemGoToMenuNFS4Button itemSkillBeginner, itemSkillIntermediate, itemSkillExpert;
    tMenuNFS4 menuSkillLevel;
    tMenuItemGoToMenuNFS4Button itemOnePlayerTestDrive, itemOnePlayerSingleRace, itemOnePlayerPursuit, itemOnePlayerTournament, itemOnePlayerSpecialEvents;
    tMenuNFS4 menuOnePlayer;
    tMenuItemGoToMenuNFS4Button itemSingleRaceSolo, itemSingleRaceDuel, itemSingleRaceFullGrid;
    tMenuNFS4 menuSingleRace;
    tMenuItemGoToMenuNFS4Button itemHotPursuitSolo, itemHotPursuitDuel;
    tMenuNFS4 menuHotPursuit;
    tListIteratorTournament iteratorTournament;
    tMenuItemGoToMenuNFS4Button itemTournamentContinue;
    tMenuItemNFS4LeftRightChoice itemTournamentSelect;
    tMenuNFS4 menuTournament;
    tListIteratorTournament iteratorSpecialEvent;
    tMenuItemGoToMenuNFS4Button itemSpecialEventContinue;
    tMenuItemNFS4LeftRightChoice itemSpecialEventSelect;
    tMenuNFS4 menuSpecialEvent;
    tMenuItemGoToMenuNFS4Button itemTwoPlayerTestDrive, itemTwoPlayerDuel, itemTwoPlayerHotPursuit, itemTwoPlayerPinkSlips;
    tMenuNFS4 menuTwoPlayer;
    tMenuItemGoToMenuNFS4Button itemBestOfOne, itemBestOfThree, itemBestOfFive;
    tMenuNFS4 menuPinkSlipSelect;
    tMenuItemGoToMenuNFS4Button itemPinkSlipsContinue;
    tMenuItemNFS4LeftRightChoice itemTrack1, itemTrack2, itemTrack3, itemTrack4, itemTrack5;
    tMenuNFS4 menuPinkSlipsBestOfThree, menuPinkSlipsBestOfFive;
    tListIteratorTrack iteratorTrack;
    tMenuItemGoToMenuNFS4Button itemTrackContinue;
    tMenuItemNFS4LeftRightChoice itemTrack;
    tMenuItemGoToMenuNFS4Button itemTrackRecords;
    tMenuNFS4 menuSingleTrackSelect, menuTestDriveTrackSelect;
    tListIteratorIndexed iteratorLaps, iteratorTrackDirection, iteratorTrackMirrored, iteratorTimeOfDay, iteratorWeather, iteratorTraffic;
    tListIterator iteratorLocalSpeech;
    tMenuItemOptionsLeftRightChoice itemLaps, itemTrackDirection;
    tMenuItemOptionsTwoItemChoice itemTrackMirrored, itemTimeOfDay, itemWeather, itemTraffic, itemLocalSpeech;
    tMenuOptions menuTrackOptions;
    tBlankMenuItemGoToMenuNFS4Button menuTrackRecordsItem;
    tOptionsMenu menuTrackRecords;
    tMenuItemGoToMenuNFS4Button itemTrackInfoContinue;
    tMenuNFS4 menuTrackInfo;
    tListIteratorCar iteratorCar1;
    tListIteratorCarColor iteratorColor;
    tMenuItemGoToMenuNFS4Button itemCarSelectRace;
    tMenuItemNFS4LeftRightChoice itemCar, itemColor;
    tMenuItemGoToMenuNFS4Button itemShowcase;
    tMenuNFS4 menuSingleCarSelect;
    tListIteratorCar iteratorGarageCar;
    tMenuItemNFS4LeftRightChoice itemGarageCar;
    tMenuItemGoToMenuNFS4Button itemCarDealer, itemUpgradeCar;
    tMenuNFS4 menuCarGarage, menuPostCarGarage;
    tListIteratorCar iteratorOpponentCar;
    tMenuItemGoToMenuNFS4Button itemDuelRace;
    tMenuItemNFS4LeftRightChoice itemCar2, itemColor2;
    tMenuItemGoToMenuNFS4Button itemGoToDuelBuyCar;
    tMenuItemNFS4LeftRightChoice itemOpponentCar;
    tMenuNFS4 menuDuelCarSelect, menuHPDuelCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerOneRace;
    tMenuItemNFS4LeftRightChoice itemCarP1, itemColorP1;
    tMenuNFS4TwoPlayer menuPlayerOneCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerTwoRace;
    tMenuItemNFS4LeftRightChoice itemCarP2, itemColorP2;
    tMenuNFS4TwoPlayer menuPlayerTwoCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerOneGarageRace;
    tMenuItemNFS4LeftRightChoice itemGarageCarP1;
    tMenuNFS4TwoPlayer menuPlayerOneGarage;
    tMenuItemGoToMenuNFS4Button itemPlayerTwoGarageRace;
    tMenuItemNFS4LeftRightChoice itemGarageCarP2;
    tMenuNFS4TwoPlayer menuPlayerTwoGarage;
    tListIteratorCar iteratorPinkSlipsCar;
    tMenuItemGoToMenuNFS4Button itemPlayerOnePinkSlipRace;
    tMenuItemNFS4LeftRightChoice itemPinkSlipCarP1;
    tMenuNFS4TwoPlayer menuPlayerOnePinkSlipCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerTwoPinkSlipRace;
    tMenuItemNFS4LeftRightChoice itemPinkSlipCarP2;
    tMenuNFS4TwoPlayer menuPlayerTwoPinkSlipCarSelect;
    tMenuItemGoToMenuNFS4Button itemGoToBuyCar, itemGoToSellCar;
    tMenuNFS4 menuGoToCarDealer;
    tListIteratorCar iteratorDealerCar;
    tListIteratorCarColor iteratorDealerColor;
    tMenuItemNFS4LeftRightChoice itemDealerCar, itemDealerColor;
    tMenuItemGoToMenuNFS4Button itemBuyCar, itemDealerShowroom;
    tMenuNFS4 menuCarDealer;
    tListIteratorCar iteratorSellerCar;
    tMenuItemNFS4LeftRightChoice itemSellerCar;
    tMenuItemGoToMenuNFS4Button itemSellCar;
    tMenuNFS4 menuCarSeller;
    tMenuItemGoToMenuNFS4Button itemPurchaseUpgrade1, itemPurchaseUpgrade2, itemPurchaseUpgrade3;
    tMenuNFS4 menuCarUpgrades;
    tListIteratorIndexed iteratorTransmission, iteratorABS;
    tListIterator iteratorDamage, iteratorOpponentUpgrades;
    tMenuItemOptionsLeftRightChoice itemTransmission, itemABS, itemDamage, itemTransmission2, itemABS2, itemDamage2, itemOpponentUpgrades;
    tMenuOptions menuCarOptions, menuCarOptionsPlayerOne, menuCarOptionsPlayerTwo, menuPinkSlipCarOptionsPlayerOne, menuPinkSlipCarOptionsPlayerTwo;
    tMenuBlank menuShowroom;
    tMenuItemGoToMenuNFS4Button itemOptionsAudio, itemOptionsDisplay, itemOptionsControllers, itemOptionsMemoryCard, itemOptionsUsername, itemOptionsCredits;
    tMenuNFS4 menuOptions;
    tListIteratorRange iteratorMusicVolume, iteratorSoundEffectsVolume, iteratorEngineVolume, iteratorSpeechVolume, iteratorAmbientVolume;
    tListIterator iteratorAudioMode;
    tMenuItemLeftRightAudioSlider itemMusicVolume, itemSoundEffectsVolume, itemEngineVolume, itemSpeechVolume, itemAmbientVolume;
    tMenuItemDisplayLeftRightChoice itemAudioMode;
    tMenuItemSlidingActivated itemSlidingPlayList;
    tInsideBoxSongMenu menuPlayListMenu;
    tOptionsMenu menuAudio;
    tListIteratorIndexed iteratorDisplaySpeedometer, iteratorDisplayMap, iteratorDisplayOpponentID, iteratorDisplayTime, iteratorDisplayPosition, iteratorDisplayLapNumber;
    tListIterator iteratorDisplaySplitTime;
    tListIteratorIndexed iteratorDisplaySplitDisplay;
    tMenuItemDisplayLeftRightChoice itemDisplaySpeedometer, itemDisplayMap, itemDisplayOpponentID;
    tMenuItemOnOffLeftRightChoice itemDisplayTime, itemDisplayPosition, itemDisplayLapNumber;
    tMenuItemDisplayLeftRightChoice itemDisplaySplitTime, itemDisplaySplitDisplay;
    tOptionsMenu menuDisplayOptions;
    tListIteratorIndexed iteratorControllerConfigSelected;
    tMenuItemControllerLeftRightChoice itemControllerConfigSelected;
    tMenuItemSlidingMenu itemControllerSettings;
    tOptionsMenu menuControllerConfig;
    tListIteratorRangeIndexed iteratorControllerShockMode;
    tInsideBoxControllerLeftRightSlider itemControllerShockMode;
    tListIteratorRangeIndexed iteratorControllerShockImpact;
    tInsideBoxControllerLeftRightSlider itemControllerShockImpact;
    tListIteratorRangeIndexed iteratorControllerSteeringRange1;
    tInsideBoxTwoWaySlider itemControllerSteeringRange1;
    tListIteratorRangeIndexed iteratorControllerDeadSpot1;
    tInsideBoxTwoWaySlider itemControllerDeadSpot1;
    tListIteratorRangeIndexed iteratorControllerSteeringRange2;
    tInsideBoxTwoWaySlider itemControllerSteeringRange2;
    tListIteratorRangeIndexed iteratorControllerDeadSpot2;
    tInsideBoxTwoWaySlider itemControllerDeadSpot2;
    tListIteratorRangeIndexed iteratorControllerJoyRange;
    tInsideBoxTwoWaySlider itemControllerJoyRange;
    tListIteratorRangeIndexed iteratorControllerCenterPoint;
    tInsideBoxTwoWaySlider itemControllerCenterPoint;
    tListIteratorRangeIndexed iteratorControllerIMax;
    tInsideBoxTwoWaySlider itemControllerIMax;
    tListIteratorRangeIndexed iteratorControllerIIMax;
    tInsideBoxTwoWaySlider itemControllerIIMax;
    tInsideBoxMenu menuControllerDualShock, menuControllerAnalog, menuControllerDualShockAnalog, menuControllerNegcon;
    tMemoryCardMenuItem itemSaveGame, itemLoadGame;
    tOptionsMenu menuMemory;
    tUserNameMenuItem menuItemUserName, menuItemUserName1, menuItemUserName2;
    tOptionsMenu menuUserName;
    tListIterator iteratorChangeTrophy;
    tBlankMenuItemNFS4LeftRightChoice itemChangeTrophy;
    tMenuNFS4Bottom menuTrophyRoom;
    tMenuItemGoToMenuNFS4Button itemPinkSlipStandingsForward, itemPinkSlipStandingsExit;
    tMenuNFS4 menuPinkSlipStandings;
    tMenuItemGoToMenuNFS4Button itemTournStandingsForward, itemTournStandingsExit;
    tMenuNFS4 menuTournamentStandings;
    tMenuItemGoToMenuNFS4Button itemTournamentFinishedHome;
    tMenuNFS4 menuTournamentFinished;
    tMenuBlank menuTournamentTrophy;
    tOptionsMenu menuPostGamePlayer1Name, menuPostGamePlayer2Name;
    tBlankMenuItemGoToMenuNFS4Button itemPostGameTrackRecordsContinue;
    tOptionsMenu menuPostGameTrackRecords;
    tMenuBlank menuPinkSlipCongrats, menuBeTheCopCongrats, menuTierCompleteCongrats, menuCredits;
    tMemoryCardMenuItem itemMemContinue;
    tOptionsMenu menuPostGameSave;

    tGlobalMenuDefs();
    ~tGlobalMenuDefs();
};

struct tMemCardData {
    u_long fSize, bonus;
    tfrontEnd frontEnd;
    tSaveCarInfo carInfo;
    tSaveTrackInfo trackInfo;
    tSaveTournament tournament;
    tRecordBuffer records[187];
    u_long pinkSlipsNoCheat, frontEndCRC, carInfoCRC, trackInfoCRC, tournamentCRC, recordsCRC;
};

struct MCRDOPTS_def {
    PRODUCTLOC productLocation;
    char *productCode;
    int bMoveIconsToVram;
    RECT VramIconArea;
    void *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;
};

struct tVideoWallConfig {
    short numVideos, flags;
    tVideo *videos[4];
};

struct tVertex {
    short x, y;
};


struct LINE_F2 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1;
};


struct CdlFILE {
    CdlLOC pos;
    u_long size;
    char name[16];
};

struct DECENV {
    u_long *vlcbuf[2];
    int vlcid;
    u_short *imgbuf;
    RECT rect[2];
    int rectid;
    RECT slice;
    int isdone;
};

struct CDSECTOR {
    u_short id, type, secCount, nSectors;
    u_long frameCount, frameSize;
    u_short width, height;
    u_long headm, headv;
};


struct DR_OFFSET {
    u_long tag;
    u_long code[2];
};


struct fMemCardInfo_def {
    PRODUCTLOC productLocation;
    char productCode[16];
    int bMoveIconsToVram;
    RECT VramIconArea;
    void *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;
    MANAGERTASK task;
    int bReady, fMultitap;
    long channel;
    int existencecheckticks[8];
    MCRDFILEHEADER_def header;
    MCRDFILEINFO_def fileinfo;
    CARDINFO_def card[8];
};

struct MDECSTRUCT {
    int id, width, height, bpp;
    RECT framerect, striprect;
    int striprectsize;
    u_long *stripbuf, *vlcbuf;
};

struct tMdecHandle {
    int numhandles, hDecode;
};

struct windowtbl {
    long id;
    int x, y, width, height;
    u_char bpp, type, ram, unused;
    int minx, miny, maxx, maxy;
    shapetbl *shape;
    DISPENV dispenv;
    DRAWENV drawenv;
};

struct STREAMCHUNKHDR {
    long type, size;
};

struct VIDEOSTRUCT {
    int id, bufferwidth, bufferheight;
    char *streambuffer;
    int mdechandle;
    windowtbl *frame;
    long videotap;
    VIDEOSTATE state;
    long streamrequestid;
    int reftime, displaytime, displaytimefrac, displaytimeincr, framewidth, frameheight, droppedframes;
};

struct ARGB {
    u_char b, g, r, a;
};

struct scoorddef {
    int x, y;
};

struct RPOINT {
    scoorddef uv;
    coorddef xyz;
    scoorddef xy;
    int light;
    ARGB fog;
};

struct PSXCDFILEINFO_def {
    u_char name[12];
    int sector, length;
};

struct tPadModuleState {
    int initialized;
    PAD_COMMON buf[8];
    tActiveTime state[8];
};



typedef shapetbl SHAPE;
typedef coorddef LIBCOORD;
typedef matrixtdef MATRIX3DT;
typedef cdstreamstruct CDSTREAM;
typedef linedef LINE;
typedef COORD16 Transformer_zVertex;
typedef void *va_list;
typedef unsigned int u_int;

typedef void *physadr;

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
# 81 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp" 2
# 1 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h" 1






# 1 "C:/Temp/nfs4-wt46-a10/recon/lib/libfns.h" 1
# 16 "C:/Temp/nfs4-wt46-a10/recon/lib/libfns.h"
# 1 "C:/Temp/nfs4-wt46-a10/recon/nfs4_types.h" 1
# 17 "C:/Temp/nfs4-wt46-a10/recon/lib/libfns.h" 2

extern "C" {







int ClearImage(...);
u_long * ClearOTagR(...);
void DrawOTag(...);
long DrawSync(...);
unsigned short GetClut(...);
int GetTPage(...);
int LoadImage(...);
int MoveImage(...);
DISPENV * PutDispEnv(...);
DRAWENV * PutDrawEnv(...);
DISPENV * SetDefDispEnv(...);
DRAWENV * SetDefDrawEnv(...);
void SetDispMask(...);
void SetDrawArea(...);
void SetDrawEnv(...);
void SetDrawMode(...);
void SetDrawStp(...);
void SetPolyF3(...);
void SetPolyF4(...);
void SetPolyFT4(...);
void SetPolyG4(...);
void SetPolyGT4(...);
void SetSemiTrans(...);
void SetShadeTex(...);
void SetTexWindow(...);
int StoreImage(...);

void InitGeom(...);
MATRIX * RotMatrix(...);
MATRIX * RotMatrixZ(...);
void SetFarColor(...);
void SetFogNear(...);
void SetGeomScreen(...);
int VectorNormal(...);
long VectorNormalS(...);

int GetRCnt(...);
void ResetCallback(...);
void SetVideoMode(...);
int VSync(...);
void VSyncCallback(...);

void FlushCache(...);

int PadGetState(...);
int PadInfoMode(...);
void PadSetAct(...);
int PadSetActAlign(...);
void PadSetMainMode(...);
void PadStartCom(...);






int CdDiskReady(...);
int FILE_addbigsync(...);
int FILE_closesync(...);
int FILE_completeop(...);
void FILE_delbigsync(...);
void FILE_init(...);
int FILE_opensync(...);
int FILE_operror(...);
int FILE_opstatus(...);
int FILE_read(...);
int FILE_readsync(...);
void PAD_restore(...);
u_short PAD_state(int);
void PAD_update(...);
int SND3dpos(...);
int SNDSTRM_autovol(...);
int SNDSTRM_create(...);
int SNDSTRM_destroy(...);
int SNDSTRM_getvol(...);
int SNDSTRM_overhead(...);
int SNDSTRM_purge(...);
int SNDSTRM_queuefile(...);
int SNDSTRM_requeststatus(...);
void SNDSTRM_setgreedylevel(...);
void SNDSTRM_setgreedystate(...);
void SNDSTRM_setpriority(...);
int SNDSTRM_status(...);
int SNDSTRM_vol(...);
int SNDSYS_getopts(...);
void SNDSYS_init(...);
void SNDSYS_restore(...);
int SNDSYS_setopts(...);
int SNDSYS_vectortoreal(...);
void SNDautovol(...);
int SNDbankadd(...);
void SNDbankheadercopy(...);
int SNDbankheadersize(...);
int SNDbankremove(...);
int SNDfxinitbus(...);
int SNDfxmasterlevel(...);
int SNDgetlimits(...);
int SNDmastervol(...);
int SNDmemlargestunused(...);
int SNDover(...);
int SNDpan(...);
int SNDpitchbend(...);
int SNDpitchmult(...);
int SNDplay(...);
void SNDplaysetdef(...);
int SNDsetlimits(...);
int SNDstop(...);
int SNDtimeremaining(...);
void SNDvol(...);
void * SetSp(...);
double __adddf3(...);
double __divdf3(...);
float __divsf3(...);
double __extendsfdf2(...);
int __fixsfsi(...);
double __floatsidf(...);
float __floatsisf(...);
int __ltdf2(...);
void __main(...);
float __mulsf3(...);
float __truncdfsf2(...);
int addsystemtask(...);
int addtimer(...);
void asyncidle(...);
unsigned int asyncloadfile(...);
unsigned int asyncloadfileat(...);
int asyncloadsegment(...);
int atoi(...);
int bigcount(...);
void blockclear(...);
void blockfill(...);
void blockmove(...);
void cancelasyncload(...);
int ccos(...);
unsigned long crc16(...);
void crossproduct(...);
int csin(...);
int delsystemtask(...);
int deltimer(...);
int fastintcos(...);
int fastintsin(...);
int filesize(...);
int fixedatan(...);
int fixedcos(...);





int fixeddiv(...);
int rdiv(...);
int fixedmult(...);
int fixedsin(...);
void fixedsincos(...);
int fixedsqrt(...);
void fixedxformx(...);
int fixedxformy(...);
void fixedxformz(...);
char * getasyncreadadr(...);
int getasyncreadstatus(...);
charactertbl * getcharacter(...);
int geti(...);
long getm(...);
int gettick(...);
short * iSNDserveradd100hzclient(...);
int iSNDserverremove100hzclient(...);
void iSPCH_EACseedrandom(...);
void initasync(...);
void initjoy(...);
void initlinkmode(...);
void initmemadr(...);
void inittimer(...);
int intarccos(...);
int intatan(...);
int intsincos(...);
int isqrt(...);
int largestunused(...);
int loadbigfileheader(...);
void * loadfileadr(...);
char * loadfileadrz(...);
void * loadfileatadr(...);
int loadfileatadrz(...);
void * loadpackadr(...);
void * loadpackadrz(...);
int loadshapeadr(...);
void * locatebig(...);
void *locatebigentry(...);
void *locatebigentryz(...);
void *locateshape(...);
void *locateshapez(...);
void * memcpy(...);
void * memset(...);
void movfxya(...);
void padinit(...);
int purgememadr(...);
int puts(...);
void qsort(...);
int rand(...);
int random(...);
void reorthogonalize(...);
void * reservememadr(...);
void resizememadr(...);
void restoregp(...);
int rinverse(...);
void savegp(...);
void seedrandom(...);
void setasyncfile(...);
void setdirectory(...);
void setfont(...);
void settrans(...);
int shapedepth(...);
void shapename(...);
void *shapepointer(...);
int shapetoclutid(...);
int sprintf(...);
char * strcat(...);
char * strchr(...);
int strcmp(...);
char * strcpy(...);
unsigned int strlen(...);
int strncmp(...);
char * strncpy(...);
char * strstr(...);
int systemtask(...);
void timedwait(...);
void transform(...);
void transpose(...);
long unbtree(...);
long unhuff(...);
long unrefpack(...);
void vramfxya(...);
void waitdraw(...);
int wildcard(...);
int xformy(...);

}
# 8 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h" 2


typedef unsigned int undefined3;
static inline u_int CONCAT31(u_int hi3, u_char lo1) { return (hi3 << 8) | lo1; }




extern SPRT *gSprt1;
# 27 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h"
extern u_short gFontClut;
extern int gFlip;


extern DRender_tView gCView;
# 57 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h"
extern short Hud_NextPerp[2];
extern int StatsTimer[2];




extern HudPmx_tShape HudPmx_gShapes[];
extern HudPmx_tUV HudPmx_gHudNumberUV[];


extern Car_tObj *Cars_gRaceCarList[];
extern Car_tObj *Cars_gHumanRaceCarList[];
extern Car_tObj *Cars_gCopCarList[];
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gSortedList[];
extern int Cars_gNumRaceCars;
extern int Cars_gNumHumanRaceCars;
extern int Cars_gNumCars;
extern int Cars_gNumCopCars;
extern GameSetup_tData GameSetup_gData;
extern Sim_tSimGlobalVar simGlobal;
extern camera_info Camera_gInfo[2];
extern dashhud_info DashHUD_gInfo;
extern int Input_gLookBehind[2];
extern tPadModuleState gPadinfo;
extern tBTCPerpInfo BTCPerpInfo[2][10];
# 91 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h"
extern int Font_GetUVWH(char c, int *u, int *v, int *w, int *h, int *yo);
extern int Font_Getcharacter(int c);
extern void Font_TextColor(int idx);
extern void Font_TextXY(char *s, int x, int y);
extern char *TextSys_Word(int id);
extern int textpixels(char *s);


extern int Draw_SetView(int a, int b, int c, int d, int e, int f, int g, int h, int i);
extern void Draw_StartRenderingView(int id);
extern void Draw_StopRenderingView(int id);


extern void Flare_2DHalo(int a, int b, int c, int d, int e);
extern int Stats_GetPosition(Car_tObj *car);
extern int Input_WingCommandMode(int player);
extern int DashHUD_CheckWrongWay(int player);
extern int DashHUD_HUDCalc(int player);
extern void CopSpeak_Debug(void);
extern int AudioMus_Buffered(void);
extern int AudioMus_GetCurrentSong(void);
extern int AudioMus_Threshold(void);
extern void AudioCmn_PlayWrongWaySFX(void);
extern void HudPmx_Kill(void);
extern void Hud_RenderStatsView(void);
extern void Hud_BTCStats(short player, bool flag);


extern int ticks;
extern int trap_unused;
extern int trap_unused;
extern void trap(int code);
# 132 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h"
extern int Replay_ReplayMode;
extern tReplayInterface Replay_ReplayInterface;
# 144 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h"
extern Trk_NewSlice *BWorldSm_slices;
extern Sim_tSimSystemVar simVar;
# 158 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud_externs.h"
extern char countdown; extern int countdownTick_216;




extern char countdown; extern int countdownTick_216;
# 82 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp" 2



int BigBTCTime_state1 = 50;
int BigBTCTime_state2;
signed char oldCountdown = -1;
tSmallCoordXY Hud_gElementPositions[2][19] = { { {22, 54}, {159, 19}, {8, 19}, {18, 35}, {8, 204}, {221, 24}, {23, -2}, {21, -2}, {23, -3}, {2, -4}, {7, 50}, {4, 18}, {-41, 0}, {90, 212}, {253, 162}, {8, 196}, {218, 20}, {160, 97}, {160, 97} }, { {22, 56}, {252, 17}, {8, 17}, {26, 30}, {8, 101}, {128, 18}, {23, -2}, {21, -2}, {23, -3}, {2, -1}, {7, 52}, {4, 18}, {-42, 0}, {90, 105}, {259, 60}, {8, 72}, {215, 22}, {160, 99}, {160, 42} } };
u_long day_needle[30] = { 657850u, 16053492u, 657850u, 657850u, 657850u, 236260u, 657850u, 657850u, 657850u, 657850u, 526344u, 657850u, 16053492u, 43184u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 43184u, 657850u, 0, 0, 0 };
u_long night_needle[30] = { 657850u, 1147055u, 4168420u, 657850u, 657850u, 236260u, 657850u, 657850u, 657850u, 657850u, 526344u, 4110581u, 2648104u, 43184u, 657850u, 657850u, 4110581u, 4168420u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 4110581u, 43184u, 657850u, 0, 0, 0 };
u_long Hud_Character[5] = { 4347332u, 4337928u, 15776284u, 7617052u, 0 };
float fMapScaleX[11] = { 39.5f, 50.0f, 44.0f, 43.5f, 39.5f, 52.599998474121094f, 43.400001525878906f, 33.5f, 35.599998474121094f, 29.799999237060547f, 38.0f };
float fMapScaleY[11] = { 40.79999923706055f, 50.0f, 46.099998474121094f, 45.29999923706055f, 36.70000076293945f, 51.20000076293945f, 42.400001525878906f, 32.5f, 37.29999923706055f, 27.399999618530273f, 37.900001525878906f };
short fMapOffX[11] = { 7, 0, 16, 3, -88, 19, 2, -5, -3, 45, 4 };
short fMapOffY[11] = { 7, 0, -3, 2, -12, -7, 7, 4, 0, -32, -2 };
short fMapRotate[11] = { 4032, 0, 454, 2476, 3694, 3689, 3758, 3822, 1370, 3808, 32 };
CVECTOR Hud_gMarkerColor[12];
CVECTOR Hud_gCopMarkerColor[12];
char HudminChar[6] = { 58, 58, 39, 39, 39, 46 };
char HudsecChar[6] = { 46, 58, 34, 34, 34, 44 };
int BTC_playedsoundalready;
char Hud_gWingmanInterface[2];
char Hud_gWingmanFlashIcon[2];
int Hud_gWingmanFlashTicks[2];
int Hud_gDebugInfo = 1;
int HudBustedOverlay;
int Hud_gCdActive;
int Hud_ActivateCDPlayer;
int BTC_Countdown;
int FinalBTC_Countdown;
int Hud_BeTheCop;
int Hud_kTurnSongOffNext;
short HudBustedOverlayPlayer;
int mapMarkerMCos;
int mapMarkerMSin;
int Hud_gHudView[2];
int Hud_gMapView[2];
int Hud_gTacView[2];
int Hud_gStatsView;
# 131 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
int HudMapOffsetY;
long gMapRotate;
long gMapScaleX;
long gMapScaleY;
int gMapOffX;
int gMapOffY;
int Hud_gCdLastTick;
int Hud_gCdScrollTitle;
tSmallCoordXY *g1Player;
SPRT *gSprite0;
SPRT *gSprite1;
char currentSpriteTransparent;
int currentSpriteColor;
int HudSplitTimeDiff1[2];
int HudSplitTimeDiff2[2];
int BTC_BonusTime;
int BTC_BonusTimeTick;
int BTC_UserHasControl;
# 170 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
int PerpOverlayOn[2];
int PerpOverlayMessage[2];
int Hud_gShowedCDPlayer;
DR_MODE gTPage0[2][4];
DR_MODE gTPage1[2][4];
POLY_F4 gHudF4[14];
POLY_FT4 gHudFT4[10];
POLY_G4 gHudG4[8];
char BTC_CurrentPerpName[10];



typedef struct { unsigned addr:24; unsigned len:8; } Hud_PTag;


void Hud_CreateHudViews(void);
void Hud_GoTpage(int page);
void Hud_DebugInfo(void);
void Hud_DebugCrap(void);
void Hud_BuildSprite(SPRT *sprt,int shapeIdx,int x,int y,u_long color,int trans);
void Hud_BuildSprite2(SPRT *sprt,int shapeIdx,int x,int y);
void Hud_FBuildSprite(int shapeIdx,int x,int y,u_long color,int trans);
void Hud_BuildSpriteFromFont(SPRT *sprt,char ch,int x,int y);
void Hud_BuildF3(POLY_F3 *prim,HudPmx_tShape *shape,int x,int y,u_long color);
void Hud_BuildGT4(POLY_GT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color);
void Hud_BuildFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans);
void Hud_BuildMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans);
void Hud_BuildMapMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans);
void Hud_BuildF4(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color);
void Hud_BuildF4o(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color,signed char x0off,signed char x1off);
void Hud_FBuildGT4(HudPmx_tShape *shape, int x, int y, u_long col1);
void Hud_FBuildFT4(HudPmx_tShape *shape, int x, int y, u_long col1);
void Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char x0off, char x1off);
void uppercase(char *string);
void Hud_Kill(void);
void Hud_Init0(void);
void Hud_InitMapFrame(int i,int mode);
void Hud_BuildTimeSprites(SPRT *sprt,char *str,int x,int y);
void Hud_Init(void);
void Hud_InitTables(void);
void Hud_BuildETimeString(SPRT *sprt,int time);
void * Hud_BuildDistanceString(SPRT *sprt,int player);
void Hud_BuildTimeString(SPRT *sprt,int time);
void Hud_BuildTach(int player);
int Hud_BuildString(char *str,int x,int y,int color,int player,bool justwidth);
void Hud_BuildNumbers0(int player);
void Hud_BuildNumbers(int player);
void Hud_InitMap(void);
void Hud_BuildMapMarkers(int player);
void Hud_WingmanFlash(int player,int index);
void Hud_BuildWingmanInterface(int player);
void Hud_InitCdPlayer(void);
void Hud_BuildCdPlayer(int type,int arg1);
int Hud_BuildRadar(int player);
void Hud_BuildReplay(void);
int Hud_NextPlayer(int player);
char * Hud_NextPlayerNameOrCarOrTime(int player);
void Hud_RenderMapView(void);
void Hud_BlackThinBox(int x, int y, int w, int h);
void Hud_Draw321Num(int x,int y,int num,int flare_intensity,int arg4,int arg5);
void Hud_Render321Go(void);
void BigBTCTime(int secs);
void Hud_RenderHudView(void);
void Hud_RenderTacView(void);
void Hud_ParseTime(int nTime,char *sLapTime);
void Hud_RenderPauseBox(int x, int y, int w, int h);
void Hud_Render(void);
void Hud_PositionMap(void);
void Hud_BTC_Update(char *perpname,int timeleft,bool userHasControl);
void Hud_BustedOverlayOn(int time,char *name,bool caught,short player);
void Hud_BustedOverlayOff(void);
void Hud_Reset(void);
void Hud_BTC_QuitOut(void);
void Hud_BTC_BonusTime(long extratime);
void Hud_Perp_OverlayOn(int player,int level);
void Hud_Perp_OverlayOff(int player);



void Hud_CreateHudViews(void)
{
  int i;

  Hud_InitTables();
  Hud_BeTheCop = 0;
  for (i = 0; i < GameSetup_gData.numCars; i++) {
    if (GameSetup_gData.carInfo[i].carClass & 0x40) Hud_BeTheCop = 1;
  }
  if (GameSetup_gData.numPlayerRaceCars >= 2) {
    HudMapOffsetY = -6;
  } else if ((GameSetup_gData.numPlayerRaceCars + GameSetup_gData.numOpponentRaceCars) == 1
             || Hud_BeTheCop != 0) {
    HudMapOffsetY = 8;
  } else {
    HudMapOffsetY = 0;
  }
  if (GameSetup_gData.commMode == 1) {
    Hud_gMapView[0] = Draw_SetView(0x105, HudMapOffsetY + 0x13e, 0x245, HudMapOffsetY + 0x13e, 0x2d, 0x30, 0, 0, 1);
    Hud_gMapView[1] = Draw_SetView(0x105, HudMapOffsetY + 0x1a9, 0x245, HudMapOffsetY + 0x1a9, 0x2d, 0x30, 0, 0, 1);
    Hud_gHudView[0] = Draw_SetView(0, 0x100, 0x140, 0x100, 0x140, 0x78, 0, 0, 1);
    Hud_gHudView[1] = Draw_SetView(0, 0x178, 0x140, 0x178, 0x140, 0x78, 0, 0, 1);
    Hud_gTacView[0] = Draw_SetView(0x115, 0x113, 0x255, 0x113, 0x1c, 0x1c, 0, 0, 1);
    Hud_gTacView[1] = Draw_SetView(0x115, 0x17c, 0x255, 0x17c, 0x1c, 0x1c, 0, 0, 1);
  } else {
    Hud_gMapView[0] = Draw_SetView(0xff, HudMapOffsetY + 0x1a4, 0x23f, HudMapOffsetY + 0x1a4, 0x2d, 0x30, 0, 0, 1);
    Hud_gHudView[0] = Draw_SetView(0, 0x100, 0x140, 0x100, 0x140, 0xf0, 0, 0, 1);
    Hud_gTacView[0] = Draw_SetView(0xb8, 0x115, 0x1f8, 0x115, 0x1c, 0x1c, 0, 0, 1);
  }
  Hud_gStatsView = Draw_SetView(0, 0x100, 0x140, 0x100, 0x140, 0xf0, 0, 0, 1);
}


void Hud_GoTpage(int page)

{
  int addr_24;
  u_int tp1_hi;
  DR_MODE *prim;
  u_char *p;
  u_char *tp1;

  addr_24 = (int)&(*(u_char **)0x1F800000);
  p = (*(u_char **)0x1F800004);
  tp1 = (*(u_char **)0x1F800000);
  *(u_int *)p =
       *(u_int *)p & 0xff000000 | *(u_int *)*(u_char **)addr_24 & 0xffffff;
  tp1_hi = *(u_int *)tp1 & 0xff000000;
  (*(u_char **)0x1F800004) = p + 0xc;
  addr_24 = (u_int)p & 0xffffff;
  *(u_int *)tp1 = tp1_hi | addr_24;
  SetDrawMode((DR_MODE *)p,0,0,(page * 0x40 + 0x80U & 0x3ff) >> 6,(RECT *)0x0);
  return;
}


void Hud_DebugInfo(void)
{
  char string[20];
  int b, t;

  sprintf(string, "SLC %d", (int)(Cars_gList[0]->N).simRoadInfo.slice);
  Font_TextXY(string, 0xe6, 0x2d);
  Hud_FBuildF4(1, 0xe6, 0x30, textpixels(string) + 5, 10, 0x50505, '\0', '\0');
  b = AudioMus_Buffered();
  t = AudioMus_Threshold();
  sprintf(string, "AUD %d.%d/%d.%d", b / 1000, (b % 1000) / 100, t / 1000, (t % 1000) / 100);
  Font_TextXY(string, 0xe6, 0x23);
  Hud_FBuildF4(1, 0xe6, 0x26, textpixels(string) + 5, 10, 0x50505, '\0', '\0');
  CopSpeak_Debug();
}


void Hud_DebugCrap(void)

{
  return;
}


void Hud_BuildSprite(SPRT *sprt,int shapeIdx,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_short uVar2;
  int tu1;
  HudPmx_tShape *shape;
  HudPmx_tShape *pHVar3;
  u_int uVar4;
  u_int uVar5;

  pHVar3 = HudPmx_gShapes + shapeIdx;
  SetSemiTrans(sprt,trans);
  *(u_char *)((int)&sprt->tag + 3) = 4;
  uVar4 = color | 0x66000000;
  *(u_int *)&sprt->r0 = uVar4;
  uVar5 = y << 0x10 | x;
  *(u_int *)&sprt->x0 = uVar5;
  *(u_int *)&sprt->u0 = *(u_int *)&pHVar3->pixmap;
  *(u_int *)&sprt->w = (int)HudPmx_gShapes[shapeIdx].height << 0x10 | (int)HudPmx_gShapes[shapeIdx].width;
  return;
}


void Hud_BuildSprite2(SPRT *sprt,int shapeIdx,int x,int y)

{
  Hud_BuildSprite(sprt,shapeIdx,x,y,currentSpriteColor,(u_int)(u_char)currentSpriteTransparent);
  return;
}
# 368 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_FBuildSprite(int shapeIdx,int x,int y,u_long color,int trans)

{
  u_char *prim;
  u_char *prev_pkt;

  prim = (*(u_char **)0x1F800004);
  prev_pkt = (*(u_char **)0x1F800000);
  ((Hud_PTag *)prim)->addr = ((Hud_PTag *)prev_pkt)->addr;
  (*(u_char **)0x1F800004) = prim + 0x14;
  ((Hud_PTag *)prev_pkt)->addr = (u_int)prim;
  Hud_BuildSprite((SPRT *)prim,shapeIdx,x,y,color,trans);
  return;
}


void Hud_BuildSpriteFromFont(SPRT *sprt,char ch,int x,int y)

{
  int u;
  int v;
  int w;
  int h;
  int yo;

  Font_GetUVWH(ch,&u,&v,&w,&h,&yo);
  *(u_char *)((int)&sprt->tag + 3) = 4;
  *(u_int *)&sprt->r0 = currentSpriteColor | 0x66000000;
  *(u_int *)&sprt->x0 = (y + yo) * 0x10000 | x;
  sprt->u0 = (u_char)u;
  sprt->v0 = (u_char)v;
  sprt->clut = gFontClut;
  sprt->w = (short)w;
  sprt->h = (short)h;
  return;
}


void Hud_BuildF3(POLY_F3 *prim,HudPmx_tShape *shape,int x,int y,u_long color)

{
  u_int uVar1;
  int iVar2;
  int iVar3;

  *(u_int *)&prim->r0 = color;
  SetPolyF3(prim);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  iVar2 = (short)shape->height / 2;
  *(u_int *)&prim->x1 = (y - iVar2) * 0x10000 | x + shape->width;
  iVar3 = (short)shape->height / 2;
  *(u_int *)&prim->x2 = (y + iVar3) * 0x10000 | x + shape->width;
  return;
}


void Hud_BuildGT4(POLY_GT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color)

{
  u_char uVar1;
  u_short uVar2;
  u_int uVar3;
  int tu2;
  int uv23_pack;
  int tpage_clut;
  int w_h_pack;

  *(u_char *)((int)&prim->tag + 3) = 0xc;
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->r0 = color | 0x3e000000;
  *(u_int *)&prim->r1 = color;
  *(u_int *)&prim->r2 = color;
  *(u_int *)&prim->r3 = color;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  return;
}


void Hud_BuildFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_short uVar2;
  u_int uVar3;
  int tu2;
  int tu3;
  int tu4;
  int tu5;

  *(u_int *)&prim->r0 = color;
  SetPolyFT4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  return;
}


void Hud_BuildMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_char uVar2;
  u_short uVar3;
  u_int uVar4;
  int tu2;
  int tu3;
  int tu4;
  int tu5;

  *(u_int *)&prim->r0 = color;
  SetPolyFT4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  prim->u1 = prim->u1 - 1;
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  prim->u3 = prim->u3 - 1;
  return;
}


void Hud_BuildMapMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_char uVar2;
  u_short uVar3;
  u_int uVar4;
  int tu2;
  int tu3;

  *(u_int *)&prim->r0 = color;
  SetPolyFT4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  prim->x0 = prim->x0 + -3;
  prim->x1 = prim->x1 + -3;
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  prim->x2 = prim->x2 + -3;
  prim->x3 = prim->x3 + -3;
  return;
}


void Hud_BuildF4(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color)

{
  u_int uVar3;

  *(u_int *)&prim->r0 = color;
  SetPolyF4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->x1 = y << 0x10 | x + w;
  uVar3 = (y + h) * 0x10000;
  *(u_int *)&prim->x2 = uVar3 | x;
  *(u_int *)&prim->x3 = uVar3 | x + w;
  return;
}


void Hud_BuildG4(POLY_G4 *prim,int trans,int x,int y,int w,int h,u_long col1,u_long col2,u_long col3,
               u_long col4)

{
  u_int uVar3;

  *(u_int *)&prim->r0 = col1;
  *(u_int *)&prim->r1 = col2;
  *(u_int *)&prim->r2 = col3;
  *(u_int *)&prim->r3 = col4;
  SetPolyG4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->x1 = y << 0x10 | x + w;
  uVar3 = (y + h) * 0x10000;
  *(u_int *)&prim->x2 = uVar3 | x;
  *(u_int *)&prim->x3 = uVar3 | x + w;
  return;
}


void Hud_BuildF4o(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color,signed char x0off,signed char x1off)

{
  u_int uVar1;
  u_int uVar2;
  u_int uVar3;
  u_int uVar4;

  *(u_int *)&prim->r0 = color;
  SetPolyF4(prim);
  SetSemiTrans(prim,trans);
  uVar2 = y << 0x10 | x + x0off;
  *(u_int *)&prim->x0 = uVar2;
  uVar1 = y << 0x10 | x + w + (int)x1off;
  *(u_int *)&prim->x1 = uVar1;
  uVar3 = (y + h) * 0x10000;
  uVar4 = uVar3 | x;
  *(u_int *)&prim->x2 = uVar4;
  uVar3 = uVar3 | x + w;
  *(u_int *)&prim->x3 = uVar3;
  return;
}


void Hud_FBuildGT4(HudPmx_tShape *shape, int x, int y, u_long col1)
{
  POLY_GT4 *prim;
  u_char *prev_pkt;
  u_int prev_hi;
  int pkt_addr24;

  prim = (POLY_GT4 *)(*(u_char **)0x1F800004);
  prev_pkt = (*(u_char **)0x1F800000);
  *(u_int *)prim =
       *(u_int *)prim & 0xff000000 | *(u_int *)(*(u_char **)0x1F800000) & 0xffffff;
  prev_hi = *(u_int *)prev_pkt & 0xff000000;
  (*(u_char **)0x1F800004) = (u_char *)prim + 0x34;
  pkt_addr24 = (u_int)prim & 0xffffff;
  *(u_int *)prev_pkt = prev_hi | pkt_addr24;
  Hud_BuildGT4(prim, shape, x, y, col1);
}


void Hud_FBuildFT4(HudPmx_tShape *shape, int x, int y, u_long col1)
{
  POLY_FT4 *prim;
  u_char *prev_pkt;
  u_int prev_hi;
  int pkt_addr24;

  prim = (POLY_FT4 *)(*(u_char **)0x1F800004);
  prev_pkt = (*(u_char **)0x1F800000);
  *(u_int *)prim =
       *(u_int *)prim & 0xff000000 | *(u_int *)(*(u_char **)0x1F800000) & 0xffffff;
  prev_hi = *(u_int *)prev_pkt & 0xff000000;
  (*(u_char **)0x1F800004) = (u_char *)prim + 0x28;
  pkt_addr24 = (u_int)prim & 0xffffff;
  *(u_int *)prev_pkt = prev_hi | pkt_addr24;
  Hud_BuildFT4(prim, shape, x, y, col1, 0);
}
# 660 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char x0off, char x1off)
{
  POLY_F4 *prim;
  u_char *prev_pkt;

  prim = (POLY_F4 *)(*(u_char **)0x1F800004);
  prev_pkt = (*(u_char **)0x1F800000);
  ((Hud_PTag *)prim)->addr = ((Hud_PTag *)prev_pkt)->addr;
  (*(u_char **)0x1F800004) = (u_char *)prim + 0x18;
  ((Hud_PTag *)prev_pkt)->addr = (u_int)prim;
  Hud_BuildF4o(prim, transparent, x, y, w, h, col1, x0off, x1off);
}


void uppercase(char *string)

{
  u_int uVar1;
  int n;
  u_char *pbVar2;

  uVar1 = strlen(string);
  n = 0;
  if (0 < (int)uVar1) {
    do {
      pbVar2 = (u_char *)(string + n);
      if ((u_int)(*pbVar2 - 0x61) < 0x1au) {
        *pbVar2 = *pbVar2 + (u_char)0xe0;
      }
      n = n + 1;
    } while (n < (int)uVar1);
  }
  return;
}


void Hud_Kill(void)

{
  HudPmx_Kill();
  if (gSprite0 != (SPRT *)0x0) {
    purgememadr(gSprite0);
  }
  gSprite0 = (SPRT *)0x0;
  if (gSprite1 != (SPRT *)0x0) {
    purgememadr(gSprite1);
  }
  gSprite1 = (SPRT *)0x0;
  return;
}


void Hud_Init0(void)

{
  gSprite0 = reservememadr("HUD1",0x80c,0);
  if (GameSetup_gData.commMode == 1) {
    gSprite1 = reservememadr("HUD2",0x80c,0);
  }
  return;
}


void Hud_InitMapFrame(int i,int mode)

{
  SPRT *gSprt1;
  POLY_F4 *HudF4;
  POLY_FT4 *HudFT4;
  long splitY;
  int lx;
  int h1;
  int h2;
  int h3;
  int w1;
  int w2;
  int w3;

  if (i != 0) {
    gSprt1 = gSprite1;
  }
  else {
    gSprt1 = gSprite0;
  }
  HudF4 = gHudF4;
  if (i != 0) {
    HudF4 = gHudF4 + 7;
  }
  HudFT4 = gHudFT4;
  if (i != 0) {
    HudFT4 = gHudFT4 + 5;
  }
  splitY = 0;
  if (i != 0) {
    splitY = -0xd;
  }
  h1 = (int)HudPmx_gShapes[0xe].height;
  w1 = (int)HudPmx_gShapes[0xe].width;
  lx = (int)g1Player[0xe].x;
  h3 = h1 - (int)HudPmx_gShapes[0x14].height;
  w3 = w1 - (int)HudPmx_gShapes[0x18].width;
  h2 = (int)HudPmx_gShapes[0x18].height;
  w2 = (int)HudPmx_gShapes[0x14].width;
  if (mode == 1) {
    lx = lx + -0x1e;
  }
  currentSpriteColor = 0xff5721;
  currentSpriteTransparent = '\0';
  Hud_BuildSprite2(gSprt1 + 0x3f,0xe,lx,g1Player[0xe].y + HudMapOffsetY + splitY);
  Hud_BuildSprite2(gSprt1 + 0x40,0xf,g1Player[0xe].x + w1 + w2,
             g1Player[0xe].y + HudMapOffsetY + splitY);
  Hud_BuildSprite2(gSprt1 + 0x41,0x10,lx,g1Player[0xe].y + HudMapOffsetY + h1 + h2 + splitY);
  Hud_BuildSprite2(gSprt1 + 0x42,0x11,g1Player[0xe].x + w1 + w2,
             g1Player[0xe].y + HudMapOffsetY + h1 + h2 + splitY);
  Hud_BuildSprite2(gSprt1 + 0x43,mode + 0x14,lx + w1,g1Player[0xe].y + HudMapOffsetY + splitY);
  Hud_BuildSprite2(gSprt1 + 0x44,mode + 0x14,lx + w1,
             g1Player[0xe].y + HudMapOffsetY + h1 + h2 + h3 + splitY);
  Hud_BuildSprite2(gSprt1 + 0x45,0x18,lx,g1Player[0xe].y + HudMapOffsetY + h1 + splitY)
  ;
  Hud_BuildSprite2(gSprt1 + 0x46,0x18,g1Player[0xe].x + w1 + w2 + w3,
             g1Player[0xe].y + HudMapOffsetY + h1 + splitY);
  Hud_BuildF4(HudF4 + 4,1,0,0,0x2d,0x30,0);
  if (GameSetup_gData.mirrorTrack != 0) {
    Hud_BuildMapMirrorFT4(HudFT4,HudPmx_gShapes + 0x78,0,0,0x808080,1);
  }
  else {
    Hud_BuildFT4(HudFT4,HudPmx_gShapes + 0x78,0,0,0x808080,1);
  }
  Hud_BuildFT4(HudFT4 + 1,HudPmx_gShapes + 0x70,0,0,0x808080,1);
  Hud_BuildMirrorFT4(HudFT4 + 2,HudPmx_gShapes + 0x70,(int)HudPmx_gShapes[0x70].width,0,0x808080,1);
  Hud_BuildFT4(HudFT4 + 3,HudPmx_gShapes + 0x71,0,0,0x808080,1);
  Hud_BuildMirrorFT4(HudFT4 + 4,HudPmx_gShapes + 0x71,(int)HudPmx_gShapes[0x71].width,0,0x808080,1);
  return;
}
# 833 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildTimeSprites(SPRT *sprt,char *str,int x,int y)

{
  char cVar2;
  charactertbl *pcVar6;
  int w;
  int c;
  u_int uVar7;
  char langSec;
  char langMin;
  u_char bVar3;
  u_char bVar4;
  u_char bVar5;



  char minSep [6] = {':', ':', '\'', '\'', '\'', '.'} ;
  char secSep [6] = {'.', ':', '"', '"', '"', ','} ;

  langMin = minSep[GameSetup_gData.userSetting.language];
  langSec = secSep[GameSetup_gData.userSetting.language];
  c = (u_char)*str;
  while (c != 0) {
    if (c == 0x4d) {
      c = langMin;
    }
    if (c == 0x53) {
      c = langSec;
    }
    w = (signed char)((charactertbl *)Font_Getcharacter(c))->advance + 1;
    Hud_BuildSpriteFromFont(sprt++,(char)c,x,y);
    str = str + 1;
    x = x + w;
    c = (u_char)*str;
  }
  return;
}
# 889 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_Init(void)

{
  int x;
  int y;
  int i;
  int j;
  int w1;
  int w2;
  u_long textcolour;
  int sye;
  int syc;

  textcolour = 0xa0a0a0;
  i = 0;
  do {
    j = 0;
    do {
      SetDrawMode(&gTPage0[i][j],0,0,2,(RECT *)0x0);
      SetDrawMode(&gTPage1[i][j],0,0,3,(RECT *)0x0);
      j = j + 1;
    } while (j < 4);
    i = i + 1;
  } while (i < 2);
  i = 0;
  while (true) {
    if (DashHUD_gInfo.splitscreen < i) break;
    {
    SPRT *gSprt1;
    POLY_F4 *HudF4;
    POLY_G4 *HudG4;
    long splitY;
    int timelapshift;

    if (i != 0) {
      gSprt1 = gSprite1;
    }
    else {
      gSprt1 = gSprite0;
    }
    HudF4 = gHudF4;
    if (i != 0) {
      HudF4 = gHudF4 + 7;
    }
    HudG4 = gHudG4;
    if (i != 0) {
      HudG4 = gHudG4 + 4;
    }
    splitY = 0;
    if (i != 0) {
      splitY = -0xf;
    }
    timelapshift = (GameSetup_gData.carInfo[i].HudTime == 0) * 0x10;
    if (GameSetup_gData.carInfo[i].HudLapnum == 0) {
      timelapshift = timelapshift + 0x10;
    }
    Hud_BuildSprite(gSprt1,0x68,g1Player->x,(g1Player->y + splitY) - timelapshift,0xbebe,0);
    currentSpriteColor = 0x808080;
    Hud_BuildSprite2(gSprt1 + 1,0x80,g1Player[1].x,g1Player[1].y + splitY);
    Hud_BuildSprite2(gSprt1 + 2,(i != 0) ? 0x83 : 0x81,0,0);
    *(int *)&gSprt1[2].w = 0x1c001c;
    w1 = HudPmx_gShapes[0x6b].width;
    w2 = 0x46;
    if (Hud_BeTheCop != 0) {
      w2 = 0x2e;
    }
    x = g1Player[2].x;
    y = g1Player[2].y + splitY;
    Hud_BuildSprite2(gSprt1 + 4,0x69,x,y);
    x = x + w1;
    Hud_BuildG4(HudG4,1,x,y,w2,10,0,0x707070,0,0x707070);
    x = x + w2;
    Hud_BuildSprite2(gSprt1 + 5,0x7d,x,y);
    Hud_BuildF4(HudF4,1,x,y + 7,7,3,0x707070);
    w1 = HudPmx_gShapes[0x6b].width;
    x = g1Player[3].x;
    timelapshift = (GameSetup_gData.carInfo[i].HudTime == 0) * 0x10;
    y = (g1Player[3].y + splitY) - timelapshift;
    Hud_BuildSprite2(gSprt1 + 6,0x6b,x,y);
    x = x + w1;
    w2 = 0x1d;
    Hud_BuildG4(HudG4 + 1,1,x,y,w2,10,0,0x707070,0,0x707070);
    x = x + w2;
    Hud_BuildF4(HudF4 + 1,1,x,y + 7,7,3,0x707070);
    Hud_BuildSprite2(gSprt1 + 7,0x7d,x,y);
    w1 = HudPmx_gShapes[0x6b].width;
    x = g1Player[4].x;
    y = g1Player[4].y + splitY;
    Hud_BuildSprite2(gSprt1 + 8,0x69,x,y);
    x = x + w1;
    w2 = 0x3c;
    Hud_BuildG4(HudG4 + 3,1,x,y,w2,10,0,0x707070,0,0x707070);
    x = x + w2;
    Hud_BuildF4(HudF4 + 2,1,x,y + 7,7,3,0x707070);
    Hud_BuildSprite2(gSprt1 + 9,0x7d,x,y);
    w1 = HudPmx_gShapes[0x76].width;
    w2 = 0x26;
    if (Hud_BeTheCop == 0) {
      w2 = 0x32;
      if (GameSetup_gData.checkpointHUD[i] == 0) {
        w2 = 0x3d;
      }
    }






    if (*(volatile int *)&Hud_BeTheCop != 0) {
      x = g1Player[2].x + 0xe;
    }
    else {
      x = g1Player[5].x;
    }
    if (Hud_BeTheCop != 0) {
      sye = splitY + 0xe;
      y = g1Player[2].y + sye;
    }
    else {
      y = g1Player[5].y + splitY;
    }
    Hud_BuildSprite2(gSprt1 + 10,0x76,x,y);
    x = x + w1;
    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);
    x = x + w2;
    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);
    Hud_BuildSprite(gSprt1 + 0xb,0x7d,x,y,0x808080,0);
    currentSpriteColor = textcolour;
    Hud_BuildTimeSprites(gSprt1 + 0xc,"00M00S00",g1Player[2].x + g1Player[6].x,
               g1Player[2].y + splitY + g1Player[6].y);
    Hud_BuildTimeSprites(gSprt1 + 0x14,"0/0",g1Player[3].x + g1Player[7].x,
               (g1Player[3].y + g1Player[7].y + splitY) - timelapshift);
    currentSpriteColor = 0xa0a0a0;
    Hud_BuildTimeSprites(gSprt1 + 0x17,"0M00S00",g1Player[4].x + g1Player[8].x,
               g1Player[4].y + g1Player[8].y + splitY + 1);
    if (Hud_BeTheCop != 0) {
      x = g1Player[2].x + 0x10;
    }
    else {
      x = g1Player[5].x + g1Player[9].x;
    }
    if (Hud_BeTheCop != 0) {
      syc = splitY + 0xc;
      y = g1Player[2].y + syc;
    }
    else {
      y = g1Player[5].y + splitY + 1;
    }
    x = x + HudPmx_gShapes[0x76].width;
    Hud_BuildTimeSprites(gSprt1 + 0x1e,
               (GameSetup_gData.checkpointHUD[i] == 0) ? "0M00S00" : "0.000",
               x,y);
    HudSplitTimeDiff1[i] = gSprt1[0x1f].y0 - gSprt1[0x1e].y0;
    currentSpriteColor = textcolour;
    HudSplitTimeDiff2[i] = gSprt1[0x22].y0 - gSprt1[0x1e].y0;
    w1 = HudPmx_gShapes[0x2c].width;
    w2 = HudPmx_gShapes[0x47].width;
    x = g1Player[0xe].x + g1Player[10].x;
    y = g1Player[0xe].y + HudMapOffsetY + g1Player[10].y + splitY;
    if ((i == 0) && (DashHUD_gInfo.splitscreen != 0)) {
      y = y + -2;
    }
    j = 0;
    Hud_BuildSprite(gSprt1 + 0x28,0x3e,g1Player[0xe].x + 0x13,y + -1,0x808080,0);
    Hud_BuildSprite2(gSprt1 + 0x25,0x2c,x,y);
    x = x + w1;
    Hud_BuildSprite2(gSprt1 + 0x26,0x47,x,y);
    Hud_BuildSprite2(gSprt1 + 0x27,0x36,x + w2,y);
    currentSpriteColor = 0x808080;
    x = g1Player[1].x + g1Player[0xb].x;
    y = g1Player[1].y + g1Player[0xb].y + splitY;
    Hud_BuildSprite2(gSprt1 + 0x31,0x1a,x + -1,y);
    Hud_BuildSprite2(gSprt1 + 0x32,0x1b,x + -2,y + -1);
    x = x + 2;
    y = y + 6;
    do {
      Hud_BuildSprite2(gSprt1 + 0x29 + j,j + 0x1c,x,y);
      j = j + 1;
    } while (j < 8);
    Hud_InitMapFrame(i,0);
    }
    i = i + 1;
  }
  {
  SPRT *spriteReplay;
  int baseX;
  int baseY;

  spriteReplay = gSprite0;
  i = 0;
  currentSpriteColor = 0x808080;
  currentSpriteTransparent = 1;
  baseX = g1Player[0xd].x;
  baseY = g1Player[0xd].y;
  Hud_BuildSprite2(spriteReplay + 0x37,0x6f,baseX,baseY);
  Hud_BuildSprite2(spriteReplay + 0x33,0x6c,baseX + 0x12,baseY);
  Hud_BuildSprite2(spriteReplay + 0x34,0x6e,baseX + 0x25,baseY);
  Hud_BuildSprite2(spriteReplay + 0x35,0x3f,baseX + 0x3a,baseY);
  Hud_BuildSprite2(spriteReplay + 0x38,0x72,baseX + 0x4a,baseY);
  Hud_BuildSprite2(spriteReplay + 0x36,0,baseX + 0x6d,baseY + -7);
  Hud_BuildSprite2(spriteReplay + 0x39,3,0,baseY + 4);
  }
  currentSpriteTransparent = 0;
  Hud_InitCdPlayer();
  Hud_Reset();
  BTC_BonusTime = 0;
  BTC_Countdown = 0;
  FinalBTC_Countdown = 0;
  BTC_UserHasControl = 0;
  HudBustedOverlay = 0;
  do {
    PerpOverlayOn[i] = 0;
    PerpOverlayMessage[i] = 0;
    i = i + 1;
  } while (i < 2);
  Hud_kTurnSongOffNext = 0;
  return;
}


void Hud_InitTables(void)

{
  tSmallCoordXY (*patVar1) [19];

  patVar1 = Hud_gElementPositions;
  if (1 < GameSetup_gData.numPlayerRaceCars) {
    patVar1 = Hud_gElementPositions + 1;
  }
  g1Player = *patVar1;
  return;
}


void Hud_BuildETimeString(SPRT *sprt,int time)

{
  int min;
  int sec;
  int hun;
  int temp1;
  int temp2;

  if (time < 0) {
    time = 0;
  }
  temp2 = __builtin_abs(time);
  temp1 = temp2 / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
# 1181 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
  hun = (temp2 - temp1 * 0x40) * 100 / 0x40;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun % 10];
  return;
}


void * Hud_BuildDistanceString(SPRT *sprt,int player)

{
  int slices;
  int dist;

  dist = (Cars_gHumanRaceCarList[player]->stats).checkpointUpdate * 6;
  slices = __builtin_abs(dist);
  if (GameSetup_gData.checkpointHUD[player] == 2) {
    slices = (slices * 1000) / 0x647;
  }
  if (9999 < slices) {
    return (void *)0x0;
  }
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[slices / 1000];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[(slices % 1000) / 100];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[(slices % 100) / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[slices % 10];
  return (void *)0x1;
}


void Hud_BuildTimeString(SPRT *sprt,int time)

{
  int min;
  int sec;
  int hun;
  int temp1;
  int temp2;

  time = __builtin_abs(time);
  temp1 = time / 0x40;
  temp2 = time - temp1 * 0x40;
  min = temp1 / 0x3c;
  sec = temp1 % 0x3c;
  hun = temp2 * 100 / 0x40;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun % 10];
  return;
}
# 1296 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildTach(int player)

{
  int fangle;
  int sin;
  int cos;
  int rpm;
  SPRT *gSprt1;
  u_long clut;
  u_long x;
  u_long y;
  int cos1;
  int sin1;
  int carType;
  u_long color;
  int tachNeedle_p;
  u_char *prim;
  u_char *prim2;
  void *tp9;
  u_char *tp3;
  short ts3;
  short ts4;
  short ts1;

  if (player != 0) {
    gSprt1 = gSprite1;
  }
  else {
    gSprt1 = gSprite0;
  }
  carType = 0x1d;
  if (GameSetup_gData.carInfo[player].carType < 0x1e) {
    carType = GameSetup_gData.carInfo[player].carType;
  }
  if (GameSetup_gData.Time != 0) {
    color = night_needle[carType];
  }
  else {
    color = day_needle[carType];
  }
  rpm = DashHUD_gInfo.rpm;
  fangle = (rpm * 0x10000) / 0x2a30 + 0x5999;
  if (fangle < 0x5999) {
    fangle = 0x5999;
  }
  if (0x13334 < fangle) {
    fangle = 0x13334;
  }
  fixedsincos(fangle,&sin,&cos);


  if (player != 0) {
    tachNeedle_p = (int)&HudPmx_gShapes[0x83];
  }
  else {
    tachNeedle_p = (int)&HudPmx_gShapes[0x81];
  }
  clut = *(u_long *)tachNeedle_p;
  clut = clut & 0xffff0000;
  x = fixedmult(cos,0x1d);
  y = fixedmult(sin,0x1d);
  clut = clut | (y + 0x9d) << 8;
  if (player != 0) {
    clut = clut | (x + 0x75);
  }
  else {
    clut = clut | (x + 0x1d);
  }
  *(u_int *)&gSprt1[2].u0 = clut;
  cos1 = fixedmult(cos,10) + 0xe;
  sin1 = fixedmult(sin,10) + 0xe;
  {
    u_char *pal;

    prim = (*(u_char **)0x1F800004);
    pal = (*(u_char **)0x1F800000);
    tp9 = (void *)(prim + 0x14);
    ((Hud_PTag *)prim)->addr = ((Hud_PTag *)pal)->addr;
    (*(u_char **)0x1F800004) = prim + 0x14;
    ((Hud_PTag *)pal)->addr = (u_int)prim;
    ((Hud_PTag *)tp9)->addr = ((Hud_PTag *)pal)->addr;
    (*(u_char **)0x1F800004) = prim + 0x24;
    ((Hud_PTag *)pal)->addr = (u_int)tp9;
    ((u_char *)tp9)[3] = 3;
    *(short *)((u_char *)tp9 + 8) = 0xe - (short)x;
    *(u_long *)((u_char *)tp9 + 4) = color + 0x484848 | 0x42000000;
    *(short *)((u_char *)tp9 + 10) = 0xe - (short)y;
    *(short *)((u_char *)tp9 + 0xe) = (short)sin1;
    *(u_short *)((u_char *)tp9 + 0xc) = (u_short)cos1;
    prim2 = (*(u_char **)0x1F800004);
    pal = (*(u_char **)0x1F800000);
    ((Hud_PTag *)prim2)->addr = ((Hud_PTag *)pal)->addr;
    (*(u_char **)0x1F800004) = prim2 + 0x14;
    ((Hud_PTag *)pal)->addr = (u_int)prim2;
  }
  Hud_BuildF3((POLY_F3 *)prim,HudPmx_gShapes + 0x82,cos1,sin1,color);
  Hud_BuildF3((POLY_F3 *)prim2,HudPmx_gShapes + 0x82,cos1,sin1,0);
  prim[7] = prim[7] & 0xfd;
  fixedsincos(fangle + -0x200,&sin,&cos);
  ts3 = 0xe - (short)fixedmult(cos,0x20);
  *(short *)(prim + 0xc) = ts3;
  *(short *)(prim2 + 0xc) = ts3;
  ts4 = 0xe - (short)fixedmult(sin,0x20);
  *(short *)(prim + 0xe) = ts4;
  *(short *)(prim2 + 0xe) = ts4;
  fixedsincos(fangle + 0x200,&sin,&cos);
  ts1 = 0xe - (short)fixedmult(cos,0x20);
  *(short *)(prim + 0x10) = ts1;
  *(short *)(prim2 + 0x10) = ts1;
  ts1 = 0xe - (short)fixedmult(sin,0x20);
  *(short *)(prim + 0x12) = ts1;
  *(short *)(prim2 + 0x12) = ts1;
  tp3 = (*(u_char **)0x1F800000);
  *(short *)(prim2 + 10) = *(short *)(prim2 + 10) + 2;
  *(short *)(prim2 + 0x12) = ts1 + 2;
  *(short *)(prim2 + 0xe) = *(short *)(prim2 + 0xe) + 2;
  ((Hud_PTag *)&gSprt1[2])->addr = ((Hud_PTag *)tp3)->addr;
  ((Hud_PTag *)tp3)->addr = (u_int)(gSprt1 + 2);
  return;
}






extern HudPmx_tShape D_80111A1C[];
extern HudPmx_tShape D_801119E0[];
# 1434 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
int Hud_BuildString(char *str,int x,int y,int color,int player,bool justwidth)

{
  int offy;
  char alphShape;
  int ix;
  int i;
  int ox;
  int numch;
  int iw1;
  int iw2;
  int iw3;
  int iw4;
  int iw5;

  Hud_GoTpage(1);
  ix = x;
  ox = x;
  numch = strlen(str);
  i = 0;
  while (true) {
    if (numch <= i) break;
    if (*str == ' ') {
      ix = ix + 3;
    }
    else if (*str == '*') {
      ix = ix + 2;
      if (gPadinfo.buf[0].ID == '#') {
        if (justwidth == 0) {
          Hud_FBuildSprite(0xad,ix,y,color,0);
        }
        iw1 = ix + 3;
        ix = iw1 + D_80111A1C[0].width;
      }
      else {
        if (justwidth == 0) {
          Hud_FBuildSprite(0xaa,ix,y,color,0);
        }
        iw2 = ix + 3;
        ix = iw2 + D_801119E0[0].width;
      }
      if (GameSetup_gData.commMode == 1) {
        if (gPadinfo.buf[4].ID == '#') {
          if (gPadinfo.buf[0].ID == '#') goto HudBuildStr_next;
        }
        else if (gPadinfo.buf[0].ID != '#') goto HudBuildStr_next;
        if (gPadinfo.buf[4].ID == '#') {
            if (justwidth == 0) {
            Hud_FBuildSprite(0xad,ix,y,color,0);
          }
          iw3 = ix + 3;
        ix = iw3 + D_80111A1C[0].width;
        }
        else {
            if (justwidth == 0) {
            Hud_FBuildSprite(0xaa,ix,y,color,0);
          }
          iw4 = ix + 3;
        ix = iw4 + D_801119E0[0].width;
        }
      }
    }
    else {
      offy = 0;
      if (*str == '^') {
        alphShape = 0xaa;
        if (gPadinfo.buf[player * 4].ID == '#') {
          alphShape = 0xad;
        }
      }
      else if (*str == '(') {
        alphShape = 0xa9;
        if (gPadinfo.buf[player * 4].ID == '#') {
          alphShape = 0xab;
        }
      }
      else if (*str == ')') {
        alphShape = 0xa8;
        if (gPadinfo.buf[player * 4].ID == '#') {
          alphShape = 0xac;
        }
      }
      else if (*str == '&') {
        alphShape = 0xae;
      }
      else {
        alphShape = *str + 0x6e;
        if (9 < (u_char)(*str - 0x30U)) {
          if (*str == '-') {
            alphShape = 0x48;
          }
          else if (*str == ':') {
            alphShape = 0x49;
          }
          else {
            alphShape = *str + 0x8a;
            if ((u_char)(*str + 0x40U) < 0x1d) {
              offy = -1;
              goto HudBuildStr_haveShape;
            }
            {




              alphShape = *str + 0x43;
              if ((u_char)*str == 0xe5) {
                offy = -1;
                alphShape = 0x67;
              }
            }
          }
        }
      }
HudBuildStr_haveShape:
      if (justwidth == 0) {
        Hud_FBuildSprite((u_int)alphShape,ix,y + offy,color,0);
      }
      iw5 = ix + 1;
      ix = iw5 + HudPmx_gShapes[alphShape].width;
    }
HudBuildStr_next:
    str = str + 1;
    i = i + 1;
  }
  Hud_GoTpage(0);
  return ix - ox;
}
# 1584 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildNumbers0(int player)

{
  int i;
  SPRT *pSprt;
  POLY_F4 *HudF4;
  POLY_G4 *HudG4;
  int splitY;
  int y;
  int primAddr;

  i = player;
  if (player != 0) {
    pSprt = gSprite1;
  }
  else {
    pSprt = gSprite0;
  }
  HudF4 = gHudF4;
  if (i != 0) {
    HudF4 = HudF4 + 7;
  }
  HudG4 = gHudG4;
  if (i != 0) {
    HudG4 = HudG4 + 4;
  }
  splitY = 0;
  if (i != 0) {
    splitY = -0xf;
  }
  if (GameSetup_gData.carInfo[player].HudTime != 0) {
    if ((DashHUD_gInfo.flashtime == 0) || ((simGlobal.gameTicks & 0x10U) == 0)) {
      Hud_BuildETimeString(pSprt + 12,
                           Hud_BeTheCop != 0 ? BTC_Countdown : DashHUD_gInfo.laptime);
    }
    {
      u_int *pal;
      {
        int j;
        int num;

        num = 8;
        if (Hud_BeTheCop != 0) {
          num = 5;
        }
        j = 0xc;
        num = num + j;
        if (j < num) {
          pal = (u_int *)(*(u_char **)0x1F800000);
          do {
            ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
            ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
            j = j + 1;
          } while (j < num);
        }
      }
      {
        int j;

        j = 4;
        pal = (u_int *)(*(u_char **)0x1F800000);
        do {
          ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
          ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
          j = j + 1;
        } while (j < 6);
        pal = (u_int *)(*(u_char **)0x1F800000);
        ((Hud_PTag *)HudG4)->addr = ((Hud_PTag *)pal)->addr;
        ((Hud_PTag *)pal)->addr = (u_int)HudG4;
        ((Hud_PTag *)HudF4)->addr = ((Hud_PTag *)pal)->addr;
        ((Hud_PTag *)pal)->addr = (u_int)HudF4;
      }
    }
  }
  if (Hud_BeTheCop == 0) {
    y = g1Player[5].y;
    y = y + splitY;
    y = y + g1Player[9].y;
    pSprt[10].y0 = y;
    HudG4[2].y0 = y;
    HudG4[2].y1 = y;
    HudG4[2].y2 = y + 10;
    HudG4[2].y3 = y + 10;
    pSprt[11].y0 = y;
    HudF4[3].y0 = y + 7;
    HudF4[3].y1 = y + 7;
    HudF4[3].y2 = y + 10;
    HudF4[3].y3 = y + 10;
    y = y + 1;
    pSprt[30].y0 = y;
    pSprt[32].y0 = y;
    pSprt[33].y0 = y;
    pSprt[31].y0 = *(u_short *)&HudSplitTimeDiff1[player] + y;
    pSprt[35].y0 = y;
    pSprt[36].y0 = y;
    pSprt[34].y0 = *(u_short *)&HudSplitTimeDiff2[player] + y;
  }
  primAddr = BTC_BonusTime;
  if ((BTC_BonusTime != 0) && (Hud_BeTheCop != 0)) {
    if (GameSetup_gData.carInfo[player].HudTime == 0) {
      return;
    }
    {
      int j;
      u_char *pal;
      SPRT *p;

      p = pSprt + 30;
      *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x76].pixmap);
      if (primAddr < 0) {
        primAddr = 0;
      }
      Hud_BuildTimeString(p,primAddr);
      j = 0x1e;
      pal = (*(u_char **)0x1F800000);
      do {
        ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
        ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
        j = j + 1;
      } while (j < 0x22);
      j = 10;
      do {
        if (j == 10) {
          Hud_GoTpage(0);
          ((Hud_PTag *)&pSprt[10])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
          ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[10];
          Hud_GoTpage(1);
        }
        else {
          ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
          ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[j];
        }
        j = j + 1;
      } while (j < 0xc);
    }
  }
  else {
    if (GameSetup_gData.checkpointType == 0) {
      return;
    }
    if (GameSetup_gData.checkpointHUD[player] == 0) {
      if ((Cars_gHumanRaceCarList[player]->stats).checkpointDisplay < 1) {
        return;
      }
      y = (Cars_gHumanRaceCarList[player]->stats).checkpointDifference;
      if (y < -0x95ff) {
        return;
      }
      if (0x95ff < y) {
        return;
      }
      if (Hud_BeTheCop != 0) {
        return;
      }
      if (DashHUD_gInfo.wrongway[player] != 0) {
        return;
      }
      if (y < 0) {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x77].pixmap);
      }
      else {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x76].pixmap);
      }
      {
        int j;
        u_char *pal;
        SPRT *p;

        Hud_BuildTimeString(pSprt + 30,(Cars_gHumanRaceCarList[player]->stats).checkpointDifference);
        j = 0x1e;
        pal = (*(u_char **)0x1F800000);
        do {
          ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
          ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
          j = j + 1;
        } while (j < 0x25);
        j = 10;
        do {
          if (j == 10) {
            Hud_GoTpage(0);
            ((Hud_PTag *)&pSprt[10])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
            ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[10];
            Hud_GoTpage(1);
          }
          else {
            ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
            ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[j];
          }
          j = j + 1;
        } while (j < 0xc);
      }
    }
    else {
      y = (int)Hud_BuildDistanceString(pSprt + 30,player);
      if (y == 0) {
        return;
      }
      if ((Cars_gHumanRaceCarList[player]->stats).checkpointUpdate < 0) {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x77].pixmap);
      }
      else {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x76].pixmap);
      }
      {
        int j;
        u_char *pal;
        SPRT *p;

        j = 0x1e;
        pal = (*(u_char **)0x1F800000);
        do {
          ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
          ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
          j = j + 1;
        } while (j < 0x23);
        j = 10;
        do {
          if (j == 10) {
            Hud_GoTpage(0);
            ((Hud_PTag *)&pSprt[10])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
            ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[10];
            Hud_GoTpage(1);
          }
          else {
            ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
            ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[j];
          }
          j = j + 1;
        } while (j < 0xc);
      }
    }
  }
  {
    u_char *pal;

    pal = (*(u_char **)0x1F800000);
    ((Hud_PTag *)&HudG4[2])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&HudG4[2];
    ((Hud_PTag *)&HudF4[3])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&HudF4[3];
  }
  return;
}
# 1875 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildNumbers(int player)

{
  int i;
  SPRT *pSprt;
  POLY_F4 *HudF4;
  POLY_G4 *HudG4;
  int splitY;

  i = player;
  if (i != 0) {
    pSprt = gSprite1;
  }
  else {
    pSprt = gSprite0;
  }
  HudF4 = gHudF4;
  if (player != 0) {
    HudF4 = HudF4 + 7;
  }
  HudG4 = gHudG4;
  if (player != 0) {
    HudG4 = HudG4 + 4;
  }
  splitY = 0;
  if (player != 0) {
    splitY = -0xf;
  }
  if (((GameSetup_gData.carInfo[i].HudLapnum != 0) && (Hud_BeTheCop == 0)) &&
     (DashHUD_gInfo.maxlaps != 1)) {
    int j;
    u_char *pal;

    *(int *)&pSprt[20].u0 = *(int *)&HudPmx_gHudNumberUV[DashHUD_gInfo.lap];
    *(int *)&pSprt[22].u0 = *(int *)&HudPmx_gHudNumberUV[DashHUD_gInfo.maxlaps];
    j = 0x14;
    pal = (*(u_char **)0x1F800000);
    do {
      ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
      j = j + 1;
    } while (j < 0x17);
    j = 6;
    pal = (*(u_char **)0x1F800000);
    do {
      ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
      j = j + 1;
    } while (j < 8);
    pal = (*(u_char **)0x1F800000);
    ((Hud_PTag *)&HudG4[1])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&HudG4[1];
    ((Hud_PTag *)&HudF4[1])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&HudF4[1];
  }
  if ((((GameSetup_gData.carInfo[i].HudTime != 0) && (DashHUD_gInfo.record != 0)) &&
      ((DashHUD_gInfo.record < 0x9600 && ((Hud_BeTheCop == 0 && (Hud_gShowedCDPlayer == 0)))))) &&
     (DashHUD_gInfo.maxlaps != 1)) {
    int j;
    u_char *pal;

    if ((DashHUD_gInfo.flashtime == 0) || ((simGlobal.gameTicks & 0x10U) == 0)) {
      Hud_BuildTimeString(pSprt + 23,DashHUD_gInfo.record);
    }
    j = 0x17;
    pal = (*(u_char **)0x1F800000);
    do {
      ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
      j = j + 1;
    } while (j < 0x1e);
    j = 8;
    pal = (*(u_char **)0x1F800000);
    do {
      ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
      j = j + 1;
    } while (j < 10);
    pal = (*(u_char **)0x1F800000);
    ((Hud_PTag *)&HudG4[3])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&HudG4[3];
    ((Hud_PTag *)&HudF4[2])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&HudF4[2];
  }
  if (((GameSetup_gData.carInfo[i].HudPosition != 0) && (Hud_BeTheCop == 0)) &&
     (1 < DashHUD_gInfo.opponents)) {
    int j;
    u_char *pal;

    pSprt[37].x0 = (g1Player[0xe].x + g1Player[10].x + HudPmx_gShapes[0x2c].width + -2) -
                   HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;
    *(int *)&pSprt[37].u0 = *(int *)&HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].pixmap;
    pSprt[37].w = HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;
    *(u_int *)&pSprt[39].u0 = *(u_int *)&HudPmx_gShapes[DashHUD_gInfo.opponents + 0x35].pixmap;
    pSprt[39].w = HudPmx_gShapes[DashHUD_gInfo.opponents + 0x35].width;
    j = 0x25;
    pal = (*(u_char **)0x1F800000);
    do {
      ((Hud_PTag *)&pSprt[j])->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)&pSprt[j];
      j = j + 1;
    } while (j < 0x28);
    if (GameSetup_gData.carInfo[j].HudMap != 0) {
      Hud_GoTpage(0);
      ((Hud_PTag *)&pSprt[40])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[40];
      Hud_GoTpage(1);
    }
  }
  Hud_GoTpage(0);
  if (GameSetup_gData.carInfo[i].HudTach != 0) {
    switch (DashHUD_gInfo.gear) {
    case 0:
      ((Hud_PTag *)&pSprt[48])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[48];
      break;
    case 1:
      ((Hud_PTag *)&pSprt[47])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[47];
      break;
    default:
      ((Hud_PTag *)&pSprt[DashHUD_gInfo.gear + 39])->addr =
           ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[DashHUD_gInfo.gear + 39];
      break;
    }
    if (GameSetup_gData.carInfo[i].HudSpeed == 0) {
      ((Hud_PTag *)&pSprt[50])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[50];
    }
    else {
      ((Hud_PTag *)&pSprt[49])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)&pSprt[49];
    }
  }
  Hud_GoTpage(1);
  if (GameSetup_gData.carInfo[player].HudTach != 0) {
    int speed;
    int hun;
    int ten;
    int x;
    int y;
    int w1;
    int w2;
    int w3;
    int w7;
    int color2;
    POLY_GT4 *prim;
    u_long SpeedColor;

    speed = fixedmult(GameSetup_gData.carInfo[i].HudSpeedMult,DashHUD_gInfo.speed) / 0x10000;
    SpeedColor = 0xc8c8c8;
    color2 = 0x505050;
    w1 = HudPmx_gShapes[0x2c].width + 1;
    w2 = w1 + HudPmx_gShapes[0x2d].width >> 1;
    w7 = w1 + HudPmx_gShapes[0x33].width >> 1;
    w3 = w1 - w2;
    x = ((int)g1Player[1].x + (int)g1Player[0xc].x + 4) + w1 * 2;
    y = (int)g1Player[1].y + (int)g1Player[0xc].y + splitY;
    prim = (POLY_GT4 *)(*(u_char **)0x1F800004);
    (*(u_char **)0x1F800004) = (*(u_char **)0x1F800004) + 0x34;
    ((Hud_PTag *)prim)->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
    ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)prim;
    hun = speed / 100;
    ten = speed / 10 + hun * -10;
    Hud_BuildGT4(prim,HudPmx_gShapes + speed % 10 + 0x2c,x,y,SpeedColor);
    *(u_int *)&prim->r3 = color2;
    *(u_int *)&prim->r2 = color2;
    if (ten == 1) {
      x = x - w2;
    }
    else if (ten == 7) {
      x = x - w7;
    }
    else {
      x = x - w1;
    }
    if ((hun != 0) || (ten != 0)) {
      prim = (POLY_GT4 *)(*(u_char **)0x1F800004);
      (*(u_char **)0x1F800004) = (*(u_char **)0x1F800004) + 0x34;
      ((Hud_PTag *)prim)->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)prim;
      Hud_BuildGT4(prim,HudPmx_gShapes + ten + 0x2c,x,y,SpeedColor);
      *(u_int *)&prim->r3 = color2;
      *(u_int *)&prim->r2 = color2;
    }
    if (ten == 1) {
      x = x - w3;
    }
    if (hun != 0) {
      prim = (POLY_GT4 *)(*(u_char **)0x1F800004);
      (*(u_char **)0x1F800004) = (*(u_char **)0x1F800004) + 0x34;
      ((Hud_PTag *)prim)->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)prim;
      x = x - 1 - (int)HudPmx_gShapes[hun + 0x2c].width;
      Hud_BuildGT4(prim,HudPmx_gShapes + hun + 0x2c,x,y,SpeedColor);
      *(u_int *)&prim->r3 = color2;
      *(u_int *)&prim->r2 = color2;
    }
  }
  if ((DashHUD_gInfo.wrongway[i] != 0) && ((simGlobal.gameTicks >> 5 & 1U) != 0)) {
    u_char *pal;

    pal = (*(u_char **)0x1F800000);
    ((Hud_PTag *)&pSprt[0])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&pSprt[0];
  }
  return;
}






void Hud_InitMap(void)

{
  int iVar4;
  int i;

  iVar4 = Cars_gNumRaceCars;
  i = 0;
  if (0 < Cars_gNumRaceCars) {
    do {
      *(int *)&Hud_gMarkerColor[i] = Cars_gRaceCarList[i]->carInfo->HudColour;
      i = i + 1;
    } while (i < iVar4);
  }
  iVar4 = Cars_gNumCopCars;
  i = 0;
  if (0 < Cars_gNumCopCars) {
    do {
      *(int *)&Hud_gCopMarkerColor[i] = Cars_gCopCarList[i]->carInfo->HudColour;
      i = i + 1;
    } while (i < iVar4);
  }
  return;
}
# 2155 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildMapMarkers(int player)

{




  int i;
  int rx;
  int rz;
  int x;
  int z;
  int cenX;
  int cenZ;
  int mapy;
  int mapx;

  cenX = gMapOffX;
  cenZ = gMapOffY + 2;
  mapx = 0x16;
  mapy = 0x18;
  i = 0;
  while (true) {
    if (Cars_gNumCopCars <= i) break;
    if (Cars_gCopCarList[i]->N.active != '\0') {
      SPRT *sprt;
      int slice;
      u_char *pal;
      u_char **pktcell;

      slice = Cars_gCopCarList[i]->N.simRoadInfo.slice;
      rx = BWorldSm_slices[slice].center[0] / gMapScaleX;
      rz = BWorldSm_slices[slice].center[2] / gMapScaleY;
      x = (cenX + fixedmult(mapMarkerMCos,rx)) - fixedmult(mapMarkerMSin,rz);
      z = cenZ + fixedmult(mapMarkerMSin,rx) + fixedmult(mapMarkerMCos,rz);
      if (GameSetup_gData.mirrorTrack != 0) {
        x = -x;
      }
      pktcell = (u_char **)0x1F800004;
      sprt = (SPRT *)*pktcell;
      pal = (*(u_char **)0x1F800000);
      ((Hud_PTag *)sprt)->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)sprt;
      *pktcell = (u_char *)sprt + 0x14;
      if ((*(u_int *)((char *)Cars_gCopCarList[i] + 0x570) & 2) != 0) {
        currentSpriteColor = ((gFlip == 0) && (simVar.quickPauseSim == 0)) ? 0xff0000 : 0xff;
      }
      else {
        currentSpriteColor = *(u_long *)&Hud_gCopMarkerColor[i];
      }
      Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);
    }
    i = i + 1;
  }
  i = 0;
  while (true) {
    if (Cars_gNumRaceCars <= i) break;
    if (Cars_gRaceCarList[i]->N.active != '\0') {
      SPRT *sprt;
      int slice;
      u_char *pal;
      u_char **pktcell;

      slice = Cars_gRaceCarList[i]->N.simRoadInfo.slice;
      rx = BWorldSm_slices[slice].center[0] / gMapScaleX;
      rz = BWorldSm_slices[slice].center[2] / gMapScaleY;
      x = (cenX + fixedmult(mapMarkerMCos,rx)) - fixedmult(mapMarkerMSin,rz);
      z = cenZ + fixedmult(mapMarkerMSin,rx) + fixedmult(mapMarkerMCos,rz);
      if (GameSetup_gData.mirrorTrack != 0) {
        x = -x;
      }
      pktcell = (u_char **)0x1F800004;
      sprt = (SPRT *)*pktcell;
      pal = (*(u_char **)0x1F800000);
      ((Hud_PTag *)sprt)->addr = ((Hud_PTag *)pal)->addr;
      ((Hud_PTag *)pal)->addr = (u_int)sprt;
      *pktcell = (u_char *)sprt + 0x14;
      if ((Cars_gRaceCarList[i]->carFlags & 0x200U) != 0) {
        if ((*(u_int *)((char *)Cars_gRaceCarList[i] + 0x570) & 2) != 0) {
          currentSpriteColor = ((gFlip == 0) && (simVar.quickPauseSim == 0)) ? 0xff0000 : 0xff;
        }
        else {
          currentSpriteColor = *(u_long *)&Hud_gMarkerColor[i];
        }
        Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);
      }
      else if ((Cars_gRaceCarList[i]->carFlags & 4U) != 0) {
        Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
      else {
        Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
    }
    i = i + 1;
  }
}
# 2264 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_WingmanFlash(int player,int index)

{

  if ((Replay_ReplayMode < 2) && (HudBustedOverlay == 0)) {
    if (Hud_gWingmanInterface[player] != '\x01') {
      Hud_InitMapFrame(player,1);
      Hud_gWingmanInterface[player] = '\x01';
    }
    Hud_gWingmanFlashIcon[player] = (char)index;
    Hud_gWingmanFlashTicks[player] = ticks + 100;
  }
  return;
}
# 2339 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildWingmanInterface(int player)

{


  int splitY;
  int flashTicks;
  int now;
  POLY_F4 *poly;
  u_char *pal;
  int x;
  int xf;
  int y;

  splitY = 0;
  if (player != 0) {
    splitY = -0xf;
  }
  now = ticks;
  flashTicks = Hud_gWingmanFlashTicks[player] - now;
  x = (int)g1Player[0xe].x;
  xf = x - 0x1c;
  y = g1Player[0xe].y + HudMapOffsetY + (splitY + 2);
  Hud_BuildString(TextSys_Word(0x29),x - 0x1b,y + 3,0x808080,0,false);
  Hud_BuildString(TextSys_Word(0x2a),x - 0x1b,y + 0xc,0x808080,player,false);
  Hud_BuildString(TextSys_Word(0x2b),x - 0x1b,y + 0x15,0x808080,player,false);
  Hud_BuildString(TextSys_Word(0x2c),x - 0x1b,y + 0x1e,0x808080,player,false);
  Hud_BuildString(TextSys_Word(0x2d),x - 0x1b,y + 0x27,0x808080,player,false);
  if (0 < flashTicks) {
    pal = (*(u_char **)0x1F800000);
    poly = (POLY_F4 *)(*(u_char **)0x1F800004);
    ((Hud_PTag *)poly)->addr = ((Hud_PTag *)pal)->addr;
    (*(u_char **)0x1F800004) = (u_char *)poly + 0x18;
    ((Hud_PTag *)pal)->addr = (u_int)poly;
    Hud_BuildF4(poly,0,x - 0x10,y + ((u_char)Hud_gWingmanFlashIcon[player] + 1) * 9 + 2,0x3f,8,
               (flashTicks % 0x14) * 10);
  }
  {
    int i;

    i = 0;
    do {
      pal = (*(u_char **)0x1F800000);
      poly = (POLY_F4 *)(*(u_char **)0x1F800004);
      ((Hud_PTag *)poly)->addr = ((Hud_PTag *)pal)->addr;
      (*(u_char **)0x1F800004) = (u_char *)poly + 0x18;
      ((Hud_PTag *)pal)->addr = (u_int)poly;
      Hud_BuildF4(poly,0,xf,y + i * 9 + 2,0x4b,7,0);
      i = i + 1;
    } while (i < 5);
  }
  pal = (*(u_char **)0x1F800000);
  poly = (POLY_F4 *)(*(u_char **)0x1F800004);
  ((Hud_PTag *)poly)->addr = ((Hud_PTag *)pal)->addr;
  (*(u_char **)0x1F800004) = (u_char *)poly + 0x18;
  ((Hud_PTag *)pal)->addr = (u_int)poly;
  Hud_BuildF4(poly,1,xf,y,0x4b,0x30,0);
  return;
}


void Hud_InitCdPlayer(void)

{
  Hud_gCdLastTick = 0;
  Hud_gCdScrollTitle = 0;
  Hud_gCdActive = 0;
  Hud_ActivateCDPlayer = (u_int)(Replay_ReplayMode < 2);
  return;
}
# 2441 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildCdPlayer(int type,int arg1)

{
  int bVar2;
  int sec;
  u_int uVar5;
  int w;
  u_char *p;
  int tx;
  char *s;
  char *artist;
  char *title;
  int index;
  int time;
  char strindex [4];
  char strscrolltitle [30];
  char strartist [30];
  char strtitle [30];
  char strtime [10];
  char strtest [2];
  static bool keepup;




  int x = g1Player[0xf].x + 2;
  int y = g1Player[0xf].y + 2;
  if (type == 0) {
    keepup = 1;
  }
  int dx = 0;
  strtest[1] = 0;
  AudioMus_tCurrentSong *currentSong = AudioMus_GetCurrentSong();
  if (currentSong == (AudioMus_tCurrentSong *)0x0) {
    return 0;
  }
  if (Hud_gCdActive == 0) {





    bVar2 = (((simGlobal.gameTicks < 0x240) || (((u_char)countdown < 4 && (Hud_BeTheCop == 0)))) ||
        ((uVar5 = PAD_state(4), (uVar5 & 0x400) != 0 &&
         (DashHUD_gInfo.splitscreen != 0)))) ||
       ((uVar5 = PAD_state(0), (uVar5 & 0x400) != 0 &&
        ((Hud_BeTheCop == 0 || (DashHUD_gInfo.splitscreen != 0)))));



    if (!bVar2) {
      if ((gPadinfo.buf[0].ID == '#') && (0xbf < gPadinfo.buf[0].data.negcon.leftshift)) {
        if ((Hud_BeTheCop != 0) && (DashHUD_gInfo.splitscreen == 0)) goto HudCdPlay_checkBuf4;
        goto HudCdPlay_activateGate;
      }
HudCdPlay_checkBuf4:
      if ((gPadinfo.buf[4].ID == '#') && (0xbf < gPadinfo.buf[4].data.negcon.leftshift) &&
          (DashHUD_gInfo.splitscreen != 0)) {
        goto HudCdPlay_activateGate;
      }
    }
    else {
HudCdPlay_activateGate:
      Hud_gCdActive = 1;
      Hud_ActivateCDPlayer = 1;
    }
  }
  if (Hud_ActivateCDPlayer != 0) {
    if (Hud_BeTheCop != 0) {
      Hud_gCdActive = 1;
    }
    Hud_ActivateCDPlayer = 0;
    Hud_gCdScrollTitle = 1;
    Hud_gCdLastTick = ticks;
    if (type == 0) {
      keepup = 1;
    }
    else {
      keepup = 0;
    }
  }
  if (keepup != 0) {
    type = 0;
  }
  time = currentSong->remaining;
  index = currentSong->index;



  if ((currentSong->info).title != (char *)0x0) {
    sprintf(strtitle,"%s",(currentSong->info).title);
    title = strtitle;
  }
  else {
    title = (char *)0x0;
  }
  if ((currentSong->info).artist != (char *)0x0) {
    sprintf(strartist,"%s",(currentSong->info).artist);
    artist = strartist;
  }
  else {
    artist = (char *)0x0;
  }
  uppercase(title);
  if ((type == 0) && (artist != (char *)0x0)) {
    uppercase(artist);
  }
  if (Hud_gCdActive == 0) {
    Hud_kTurnSongOffNext = 1;
    return 1;
  }


  if (0 < index) {
    sprintf(strindex,"%02d",index);
    if (title == (char *)0x0) {
      Hud_gCdScrollTitle = 1;
      Hud_gCdLastTick = ticks;
      goto HudCdPlay_nullStringFallback;
    }
  }
  else {




    if (index == 0) {
      sprintf(strindex,"- -");
      artist = (char *)0x0;
      title = TextSys_Word(0x44);
    }
    else if (index == -2) {
      sprintf(strindex,"- -");
      artist = (char *)0x0;
      title = TextSys_Word(0x45);
    }
    else {
      sprintf(strindex,"- -");
      artist = (char *)0x0;
      if (title != (char *)0x0) goto HudCdPlay_nullStringFallback;
      title = TextSys_Word(0x46);
    }
HudCdPlay_nullStringFallback:



    if (title == (char *)0x0) goto HudCdPlay_nullTitleTail;
  }
  if (Hud_gCdScrollTitle < Hud_BuildString(title,0,0,0,0,true) + 0x4c) {



HudCdPlay_scrollTick:
    if (ticks > Hud_gCdLastTick) {
      Hud_gCdLastTick = Hud_gCdLastTick + 4;
      Hud_gCdScrollTitle = Hud_gCdScrollTitle + 1;
      goto HudCdPlay_scrollTick;
    }
  }
  else if (Hud_gCdLastTick + 0x80 < ticks) {
    Hud_gCdActive = 0;
  }
  dx = 0;
  s = strscrolltitle;
  tx = 0x4c - Hud_gCdScrollTitle;
  if (*title != 0) {
    p = (u_char *)title;



    while (1) {
      if ((int)((u_char *)title + 0x3f) <= (int)p) break;
      if (*p == 0x20) {
        w = 3;
      }
      else {

        if ((u_int)(*p - 0x30) < 10) {
          w = *p + 0x6e;
        }
        else {
          w = *p + 0x43;
        }
        w = HudPmx_gShapes[w].width + 1;
      }
      if (0x4b < tx + w) break;

      if (0 <= tx) {
        *s = *p;
        s = s + 1;
      }
      else {
        dx = dx + w;
      }
      p = p + 1;
      tx = tx + w;
      if (*p == 0) break;
    }
  }
  *s = 0;
  goto HudCdPlay_buildOutString;
HudCdPlay_nullTitleTail:
  keepup = 0;
  Hud_gCdLastTick = ticks;
HudCdPlay_buildOutString:
  if (type == 0) {
    if (title == (char *)0x0) {
      return 1;
    }
    Hud_gShowedCDPlayer = 1;
    Hud_BuildString(strscrolltitle,(x + dx + 10) - (Hud_gCdScrollTitle - 0x4c),y + 0xa,
               0xbebe,0,false);
    if (artist != (char *)0x0) {
      Hud_BuildString(artist,x + 0xa,y + 0x13,0x808080,0,false);
    }
    Hud_GoTpage(0);
    Hud_BlackThinBox(g1Player[0xf].x + 10,g1Player[0xf].y + 10,0x50,0x12);
    Hud_FBuildF4(0,g1Player[0xf].x + 10,g1Player[0xf].y + 10,0x50,0x12,0,'\0','\0');
  }
  else {
    Hud_gShowedCDPlayer = 1;
    Font_TextColor(4);
    Font_TextXY(strindex,x,y - 2);
    if (title != (char *)0x0) {
      Font_TextColor(3);
      Hud_BuildString(strscrolltitle,(x + dx + 0x16) - (Hud_gCdScrollTitle - 0x4c),y + 3,
                 0xbebe,0,false);
      Hud_GoTpage(0);
      if (index != 0) {



        int min = time / 60000;
        time = time - min * 60000;
        sec = time / 1000;
        sprintf(strtime,"%1d%c%02d",min,
                   (u_int)(u_char)"::\'\'\'."[GameSetup_gData.userSetting.language],
                   sec);
        Font_TextColor(4);
        Font_TextXY(strtime,(x - textpixels(strtime)) + 0x5c,y + 0xc);
      }
    }
    Hud_BlackThinBox((int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0x1c);
    Hud_FBuildF4(0,(int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0xe,0,'\0','\0');
    Hud_FBuildF4(0,(int)g1Player[0xf].x,g1Player[0xf].y + 0x1b,0x66,1,0,'\0','\0');
    Hud_FBuildF4(1,(int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0x1c,0,'\0','\0');
  }
}


int Hud_BuildRadar(int player)

{




  BO_tNewtonObj *car;
  int i;
  int x;
  int z;
  int cenX;
  int cenZ;
  int mapx;
  int mapz;
  int m00;
  int m01;
  int m10;
  int m11;
  coorddef scr [15];
  int visible;

  car = Camera_gInfo[player].anchor;
  visible = 0;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;
  m01 = car->orientMat.m[6] >> 8;
  m10 = car->orientMat.m[2] >> 8;
  m11 = car->orientMat.m[8] >> 8;
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
  for (i = 0; i < Cars_gNumRaceCars; i++) {
    x = (Cars_gRaceCarList[i]->N.position.x >> 8) - cenX;
    z = (-Cars_gRaceCarList[i]->N.position.z >> 8) - cenZ;
    scr[i].x = m00 * x + m01 * z >> 0x10;
    scr[i].z = m10 * x + m11 * z >> 0x11;
    if (GameSetup_gData.mirrorTrack != 0) {
      scr[i].x = -scr[i].x;
    }
    if ((Cars_gRaceCarList[i]->N.active != '\0') && (Cars_gRaceCarList[i]->carIndex != player)) {
      if ((-mapx < scr[i].x) && (scr[i].x < mapx)) {
        if ((-mapz < scr[i].z) && (scr[i].z < mapz)) {
          visible = 1;
        }
      }
    }
  }
  for (i = 0; i < Cars_gNumCopCars; i++) {
    if (Cars_gCopCarList[i]->N.active != '\0') {
      x = (Cars_gCopCarList[i]->N.position.x >> 8) - cenX;
      z = (-Cars_gCopCarList[i]->N.position.z >> 8) - cenZ;
      scr[Cars_gNumRaceCars + i].x = m00 * x + m01 * z >> 0x10;
      scr[Cars_gNumRaceCars + i].z = m10 * x + m11 * z >> 0x11;
      if (GameSetup_gData.mirrorTrack != 0) {
        scr[Cars_gNumRaceCars + i].x = -scr[Cars_gNumRaceCars + i].x;
      }
      if ((-mapx < scr[Cars_gNumRaceCars + i].x) && (scr[Cars_gNumRaceCars + i].x < mapx)) {
        if ((-mapz < scr[Cars_gNumRaceCars + i].z) && (scr[Cars_gNumRaceCars + i].z < mapz)) {
          visible = 1;
        }
      }
    }
  }
  if (visible == 0) {
    for (i = 0; i < Cars_gNumRaceCars; i++) {
      if (Cars_gRaceCarList[i]->N.active != '\0') {
        scr[i].x = scr[i].x >> 2;
        scr[i].z = scr[i].z >> 2;
        if (Cars_gRaceCarList[i]->carIndex != player) {
          if ((-mapx < scr[i].x) && (scr[i].x < mapx) && (-mapz < scr[i].z) && (scr[i].z < mapz)) {
            visible = 2;
          }
        }
      }
    }
    for (i = 0; i < Cars_gNumCopCars; i++) {
      scr[i + Cars_gNumRaceCars].x = scr[i + Cars_gNumRaceCars].x >> 2;
      scr[i + Cars_gNumRaceCars].z = scr[i + Cars_gNumRaceCars].z >> 2;
      if ((-mapx < scr[i + Cars_gNumRaceCars].x) && (scr[i + Cars_gNumRaceCars].x < mapx) &&
          (-mapz < scr[i + Cars_gNumRaceCars].z) && (scr[i + Cars_gNumRaceCars].z < mapz)) {
        visible = 2;
      }
    }
  }
  i = 0;
  while (true) {
    if (Cars_gNumCopCars <= i) break;
    if (Cars_gCopCarList[i]->N.active != '\0') {
      SPRT *sprt;
      u_char *pal;
      u_int tag;

      sprt = (SPRT *)(*(u_char **)0x1F800004);
      pal = (*(u_char **)0x1F800000);




      ((Hud_PTag *)sprt)->addr = ((Hud_PTag *)pal)->addr;
      (*(u_char **)0x1F800004) = (u_char *)sprt + 0x14;
      ((Hud_PTag *)pal)->addr = (u_int)sprt;







      if ((gFlip != 0) || (simVar.quickPauseSim != 0)) {
        currentSpriteColor = 0xff;
      }
      else {
        currentSpriteColor = 0xff0000;
      }
      Hud_BuildSprite(sprt,0x7a,scr[i + Cars_gNumRaceCars].x + mapx + -2 & 0xffff,
                 scr[i + Cars_gNumRaceCars].z + mapz & 0xffff,currentSpriteColor,0);
    }
    i = i + 1;
  }
  i = 0;
  while (true) {
    if (Cars_gNumRaceCars <= i) break;
    if ((i != player) && (Cars_gRaceCarList[i]->N.active != '\0')) {
      SPRT *sprt;
      u_char *pal;

      sprt = (SPRT *)(*(u_char **)0x1F800004);
      pal = (*(u_char **)0x1F800000);
      *(u_int *)sprt = *(u_int *)sprt & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)sprt & 0xffffff;
      (*(u_char **)0x1F800004) = (u_char *)sprt + 0x14;
      if ((Cars_gRaceCarList[i]->carFlags & 4U) != 0) {
        Hud_BuildSprite(sprt,0x79,scr[i].x + mapx + -3 & 0xffff,scr[i].z + mapz & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
      else {
        Hud_BuildSprite(sprt,0x7a,scr[i].x + mapx + -2 & 0xffff,scr[i].z + mapz & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
    }
    i = i + 1;
  }
  return visible;
}
# 2868 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_BuildReplay(void)

{


  int i;
  char hilite [5] = {4,0,1,2,3};
  int spr;
  SPRT *tSs1;
  u_char *pal;

  i = 0x33;
  do {
    tSs1 = gSprite0;
    *(u_int *)&tSs1[i].r0 = 0x66808080;
    i = i + 1;
  } while (i < 0x3f);
  *(u_int *)&tSs1[(u_char)hilite[Replay_ReplayInterface.selection] + 0x33].r0 = 0x6600bebe;
  if (Replay_ReplayInterface.selection == 3) {
    *(u_int *)&tSs1[0x38].r0 = 0x6600bebe;
  }
  *(u_int *)&gSprite0[0x34].u0 =
       *(u_int *)&(HudPmx_gShapes + 0x6e - Replay_ReplayInterface.pause)->pixmap.u0;




  switch (Replay_ReplayInterface.speed) {
  case 0:
    spr = 0x72;
    break;
  case 1:
    spr = 0x73;
    break;
  case 2:
    spr = 0x75;
    break;
  default:
    spr = 0x74;
    break;
  }
  gSprite0[0x38].u0 = HudPmx_gShapes[spr].pixmap.u0;
  gSprite0[0x38].v0 = HudPmx_gShapes[spr].pixmap.v0;
  *(u_int *)&gSprite0[0x39].u0 =
       *(u_int *)&HudPmx_gShapes[Replay_ReplayInterface.camera + 2].pixmap.u0;
  gSprite0[0x39].x0 = g1Player[0xd].x + 0x75;
  if (Replay_ReplayInterface.selection == 4) {
    *(u_int *)&gSprite0[0x39].r0 = 0x6600bebe;
  }
  else {
    *(u_int *)&gSprite0[0x39].r0 = 0x66808080;
  }
  i = 0x33;
  tSs1 = gSprite0;
  ((Hud_PTag *)&tSs1[0x39])->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
  pal = (*(u_char **)0x1F800000);
  ((Hud_PTag *)pal)->addr = (u_int)&tSs1[0x39];
  do {
    ((Hud_PTag *)&tSs1[i])->addr = ((Hud_PTag *)pal)->addr;
    ((Hud_PTag *)pal)->addr = (u_int)&tSs1[i];
    i = i + 1;
  } while (i < 0x38);
  tSs1 = gSprite0;
  pal = (*(u_char **)0x1F800000);
  ((Hud_PTag *)&tSs1[0x38])->addr = ((Hud_PTag *)pal)->addr;
  ((Hud_PTag *)pal)->addr = (u_int)&tSs1[0x38];
  ((Hud_PTag *)&gTPage1[0][3])->addr = ((Hud_PTag *)pal)->addr;
  ((Hud_PTag *)pal)->addr = (u_int)&gTPage1[0][3];
  ((Hud_PTag *)&gTPage0[0][3])->addr = ((Hud_PTag *)pal)->addr;
  ((Hud_PTag *)pal)->addr = (u_int)&gTPage0[0][3];
  return;
}
# 2951 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
extern int D_8011321C[];
# 2981 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
int Hud_NextPlayer(int player)

{
  int iVar4;
  int iVar1;
  u_int uVar3;
  int j;
  int i;
  Car_tObj *carObj;
  Car_tObj *carObj_00;
  int direction;
  u_int uVar5;

  uVar5 = (u_int)(0 < *(int *)((player << 2) + (int)Input_gLookBehind) != 0 < DashHUD_gInfo.wrongway[player]);
  carObj_00 = Cars_gHumanRaceCarList[player];
  if (1 < Cars_gNumRaceCars) {
    iVar1 = Stats_GetPosition(carObj_00);
    if ((iVar1 == 1) && (uVar5 == 0)) {







      __asm__ volatile("");
      return -1;
    }
    iVar4 = 0;
    uVar5 = uVar5 ^ D_8011321C[0];
    iVar1 = carObj_00->sortIndex;
    if (0 < Cars_gNumCars + -1) {
      do {
        if (uVar5 != 0) {
          iVar1 = iVar1 + -1;
        }
        else {
          iVar1 = iVar1 + 1;
        }
        if (iVar1 < 0) {
          iVar1 = iVar1 + Cars_gNumCars;
        }
        if (Cars_gNumCars <= iVar1) {
          iVar1 = 0;
        }
        carObj = Cars_gSortedList[iVar1];
        uVar3 = *(u_int *)((int)carObj + 0x260);
        if ((uVar3 & 4) != 0) {
          if (player != 0) {
            return 7;
          }
          return 8;
        }
        iVar4 = iVar4 + 1;
        if ((uVar3 & 8) != 0) {
          return *(int *)((int)carObj + 0x4ec);
        }
      } while (iVar4 < Cars_gNumCars + -1);
    }
  }
  return -1;
}
# 3072 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
char * Hud_NextPlayerNameOrCarOrTime(int player)

{
  int iVar1;
  int iVar2;
  int j;
  int i;
  int iVar3;
  Car_tObj *carObj;
  Car_tObj *carObj_00;
  int direction;
  u_int uVar4;

  uVar4 = (u_int)(0 < Input_gLookBehind[player] != 0 < DashHUD_gInfo.wrongway[player]);
  carObj_00 = Cars_gHumanRaceCarList[player];
  if (1 < Cars_gNumRaceCars) {
    iVar1 = Stats_GetPosition(carObj_00);
    if ((iVar1 == 1) && (uVar4 == 0)) {
      return "";
    }
    {
      iVar3 = 0;
      uVar4 = uVar4 ^ GameSetup_gData.reverseTrack;
      iVar1 = carObj_00->sortIndex;
      if (0 < Cars_gNumCars + -1) {
        do {
          if (uVar4 != 0) {
            iVar1 = iVar1 + -1;
          }
          else {
            iVar1 = iVar1 + 1;
          }
          if (iVar1 < 0) {
            iVar1 = iVar1 + Cars_gNumCars;
          }
          if (Cars_gNumCars <= iVar1) {
            iVar1 = 0;
          }
          iVar2 = (int)Cars_gSortedList[iVar1];
          if ((*(u_int *)(iVar2 + 0x260) & 0xc) != 0) {
            if (GameSetup_gData.carInfo[player].HudOpponentID == 2) {
              return (char *)(iVar2 + 0x249);
            }
            return (char *)(*(int *)(iVar2 + 0x288) + 0x5c);
          }
          iVar3 = iVar3 + 1;
        } while (iVar3 < Cars_gNumCars + -1);
      }
    }
  }
  return "";
}
# 3143 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_RenderMapView(void)

{
  int j;

  j = 0;
  while (true) {
    if (DashHUD_gInfo.splitscreen < j) break;
    if (((GameSetup_gData.carInfo[j].HudMap != 0) && (DashHUD_gInfo.showhud[j] != 0)) &&
       (Hud_gWingmanInterface[j] == '\0')) {
      POLY_FT4 *HudFT4;

      HudFT4 = gHudFT4;
      if (j != 0) {
        HudFT4 = HudFT4 + 5;
      }
      Draw_StartRenderingView(Hud_gMapView[j]);
      if (GameSetup_gData.carInfo[j].HudMap == 1) {
        u_char *pal;

        Hud_BuildMapMarkers(j);



        pal = (*(u_char **)0x1F800000);
# 3176 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
        ((Hud_PTag *)HudFT4)->addr = ((Hud_PTag *)pal)->addr;
        ((Hud_PTag *)pal)->addr = (u_int)HudFT4;
      }
      else {
        u_char *pal;

        if (Hud_BuildRadar(j) == 1) {
          pal = (*(u_char **)0x1F800000);
          HudFT4[1].tag =
               (u_long *)((u_int)HudFT4[1].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)(HudFT4 + 1) & 0xffffff;


          HudFT4[2].tag =
               (u_long *)((u_int)HudFT4[2].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)(HudFT4 + 2) & 0xffffff;
        }
        else {
          pal = (*(u_char **)0x1F800000);
          HudFT4[3].tag =
               (u_long *)((u_int)HudFT4[3].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)(HudFT4 + 3) & 0xffffff;
          HudFT4[4].tag =
               (u_long *)((u_int)HudFT4[4].tag & 0xff000000 | *(u_int *)pal & 0xffffff);



          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)(HudFT4 + 4) & 0xffffff;
        }
      }
      {



        DR_MODE *tp = &gTPage1[j][1];
        u_char *pal = (*(u_char **)0x1F800000);

        tp->tag = tp->tag & 0xff000000 | *(u_int *)pal & 0xffffff;
        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tp & 0xffffff;
      }
      Draw_StopRenderingView(Hud_gMapView[j]);
    }
    j = j + 1;
  }
  return;
}


static inline int hud_sub2(int a, int b) { return a - b; }

void Hud_BlackThinBox(int x, int y, int w, int h)
{
  short CORNERHEIGHT;
  int CORNERWIDTH;
  int x_left, top_w, side_y, side_h, x_right, y_bottom;

  CORNERWIDTH = HudPmx_gShapes[0x11].width;
  x_left = hud_sub2(x + CORNERWIDTH, 2);
  top_w = hud_sub2(w, CORNERWIDTH * 2) + 2;
  CORNERHEIGHT = HudPmx_gShapes[0x11].height;

  Hud_FBuildF4(0, x_left, hud_sub2(y, 2), top_w, 2, 0, '\0', '\0');

  side_y = hud_sub2(y + CORNERHEIGHT, 2);
  side_h = hud_sub2(h, CORNERHEIGHT * 2) + 4;
  Hud_FBuildF4(0, hud_sub2(x, 2), side_y, 2, side_h, 0, '\0', '\0');

  x_right = x + w;
  Hud_FBuildF4(0, hud_sub2(x_right, 2), side_y, 2, side_h, 0, '\0', '\0');

  y_bottom = y + h;
  Hud_FBuildF4(0, x_left, y_bottom, top_w, 2, 0, '\0', '\0');

  Hud_FBuildGT4(&HudPmx_gShapes[0xe], hud_sub2(x, 2), hud_sub2(y, 2), 0);
  Hud_FBuildGT4(&HudPmx_gShapes[0xf], hud_sub2(x_right, CORNERWIDTH), hud_sub2(y, 2), 0);
  Hud_FBuildGT4(&HudPmx_gShapes[0x10], hud_sub2(x, 2), hud_sub2(y_bottom, hud_sub2(CORNERHEIGHT, 2)), 0);
  Hud_FBuildGT4(&HudPmx_gShapes[0x11], hud_sub2(x_right, CORNERWIDTH), hud_sub2(y_bottom, CORNERHEIGHT - 2), 0);
}


void Hud_Draw321Num(int x,int y,int num,int flare_intensity,int arg4,int arg5)

{
# 3305 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
  int i;
  int j;
  int k;
  int by;
  int index;

  if (flare_intensity != 0) {
    k = 0;
    i = 0;
    do {
      j = 0;
      by = y;
      by = by + i * 9;
      do {
        if ((Hud_Character[num] & 1 << k) != 0) {
          Flare_2DHalo(x + j * 10 + 4,by + 4,flare_intensity,flare_intensity,6);
        }
        j = j + 1;
        k = k + 1;
      } while (j < 5);
      i = i + 1;
    } while (i < 5);
  }
  Hud_BlackThinBox(x - 3,y - 2,0x38,0x31);
  k = 0;
  i = 0;
  do {
    j = 0;
    by = y + i * 9 + 1;
    do {
      index = (Hud_Character[num] & 1 << k) != 0;
      Hud_FBuildSprite(index | 0x3c,x + j * 10 + 1,by,0x808080,0);
      j = j + 1;
      k = k + 1;
    } while (j < 5);
    i = i + 1;
  } while (i < 5);
  Hud_FBuildF4(0,x - 3,y - 2,0x38,0x31,0,'\0','\0');
  Hud_GoTpage(1);
  return;
}


void Hud_Render321Go(void)

{
  static u_long countdownTick;
  u_long currentTick;
  u_int uVar1;
  int flare_intensity;
  int flare_intensity_00;
  int num;
  int num_00;
  u_long y;
  int y_00;
  u_long x;

  gCView.id = Hud_gStatsView;
  Draw_StartRenderingView(Hud_gStatsView);
  y_00 = (int)g1Player[0x11].y;
  x = 160;
  if ((int)oldCountdown != (u_int)(u_char)countdown) {
    oldCountdown = countdown;
    countdownTick_216 = ticks;
  }
  uVar1 = ticks - countdownTick_216;
  if ((u_char)countdown == 4) {
    if (uVar1 < 100) {
      flare_intensity_00 = 8000 - uVar1 * 0x50;
      goto HudRender321_drawCountNum;
    }
  }
  else if (uVar1 < 100) {
    flare_intensity_00 = 6000 - uVar1 * 0x3c;
    goto HudRender321_drawCountNum;
  }
  flare_intensity_00 = 0;
HudRender321_drawCountNum:
  num_00 = 4 - (u_int)(u_char)countdown;
  if ((u_char)countdown != 4) {
    Hud_Draw321Num(x-0x58,y_00,num_00,flare_intensity_00,1,0);
    Hud_Draw321Num(x-0x19,y_00,num_00,flare_intensity_00,0,0);
    Hud_Draw321Num(x+0x26,y_00,num_00,flare_intensity_00,0,1);
  }
  Draw_StopRenderingView(Hud_gStatsView);
  return;
}
# 3413 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void BigBTCTime(int secs)

{
  POLY_GT4 *prim;
  int x;
  int y;
  int xx;
  int yy;
  int Col;
  int Col2;
  int w1;
  int w2;
  int ten;

  if (((BTC_BonusTime == 0) && (HudBustedOverlay == 0)) && (-1 < secs)) {
    if (secs != BigBTCTime_state1) {
      BigBTCTime_state1 = secs;
      BigBTCTime_state2 = ticks;
    }
    x = g1Player[0xf].x + 2;
    y = g1Player[0xf].y;
    xx = x;
    yy = y;
    w1 = HudPmx_gShapes[0x2c].width + 1;
    w2 = HudPmx_gShapes[0x2d].width + 1;
    if (0xa < secs) {
      Col = 0xc800;
      BTC_playedsoundalready = 0;
      Col2 = 0x6400;
    }
    else {
      int diff;

      diff = ticks - BigBTCTime_state2;
      if (diff < 0x40) {
        Hud_BlackThinBox(xx,yy,w1 * 2,0xe);
        Hud_FBuildF4(0,xx,yy,w1 * 2,0xe,0,'\0','\0');
        BTC_playedsoundalready = 0;
        return;
      }
      if (BTC_playedsoundalready == 0) {
        AudioCmn_PlayWrongWaySFX();
        BTC_playedsoundalready = 1;
      }
      Col = 200;
      Col2 = 100;
    }
    x = x + w1;
    prim = (POLY_GT4 *)(*(u_char **)0x1F800004);
    (*(u_char **)0x1F800004) = (u_char *)prim + 0x34;
    ((Hud_PTag *)prim)->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
    ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)prim;
    Hud_BuildGT4(prim,HudPmx_gShapes + 0x2c + secs % 10,x + -1,y,Col);
    *(int *)((char *)prim + 0x28) = Col2;
    *(int *)((char *)prim + 0x1c) = Col2;
    ten = secs / 10;
    if (ten != 0) {
      if (ten == 1) {
        x = x - w2;
      }
      else {
        x = x - w1;
      }
      prim = (POLY_GT4 *)(*(u_char **)0x1F800004);
      (*(u_char **)0x1F800004) = (u_char *)prim + 0x34;
      ((Hud_PTag *)prim)->addr = ((Hud_PTag *)(*(u_char **)0x1F800000))->addr;
      ((Hud_PTag *)(*(u_char **)0x1F800000))->addr = (u_int)prim;
      Hud_BuildGT4(prim,HudPmx_gShapes + 0x2c + ten,x,y,Col);
      *(int *)((char *)prim + 0x28) = Col2;
      *(int *)((char *)prim + 0x1c) = Col2;
    }
    Hud_BlackThinBox(xx,yy,w1 * 2,0xe);
    Hud_FBuildF4(0,xx,yy,w1 * 2,0xe,0,'\0','\0');
  }
  return;
}


void Hud_RenderHudView(void)
{





  char sBuildOutput[64];
  int j;
  int viewOff;
  int tpageOff;

  viewOff = 0;
  tpageOff = 0;
  j = 0;
  while (true) {
    int splitY;

    if (DashHUD_gInfo.splitscreen < j) break;
    splitY = 0;
    if (j != 0) splitY = -0xf;
    Draw_StartRenderingView(*(int *)((int)Hud_gHudView + viewOff));
    Hud_DebugInfo();
    Hud_DebugCrap();
    if ((GameSetup_gData.raceType == 1) && (*(int *)((int)PerpOverlayOn + viewOff) != 0)) {
      int flare_intensity;
      u_long x;
      u_long y;
      u_long ww;
      u_long ww2;
      u_long color;
      int flare_type;

      ww = textpixels(TextSys_Word(*(int *)((int)PerpOverlayMessage + viewOff) + 0x41));
      y = g1Player[0x12].y + splitY;
      Font_TextColor(4);
      ww2 = ww >> 1;
      Font_TextXY(TextSys_Word(*(int *)((int)PerpOverlayMessage + viewOff) + 0x41),
                  0xa0 - (ww2 + 1), y);
      color = 0x800000;
      if ((simGlobal.gameTicks >> 4 & 1) != 0) color = 0x80;
      flare_type = 10;
      if ((simGlobal.gameTicks >> 4 & 1) != 0) flare_type = 8;
      x = 0xa0 - ww2;
      flare_intensity = 4000 - (simGlobal.gameTicks % 0xf) * 0xfa;
      Flare_2DHalo(x - 0x23, y + 8, flare_intensity, flare_intensity, flare_type);
      Flare_2DHalo(x - 0x2d, y + 8, flare_intensity, flare_intensity, flare_type);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], x - 0x26, y + 5, color);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], x - 0x30, y + 5, color);
      color = 0x800000;
      if ((simGlobal.gameTicks >> 4 & 1) == 0) color = 0x80;
      flare_type = 10;
      if ((simGlobal.gameTicks >> 4 & 1) == 0) flare_type = 8;
      Flare_2DHalo(ww2 + 0xc0, y + 8, flare_intensity, flare_intensity, flare_type);
      Flare_2DHalo(ww2 + 0xca, y + 8, flare_intensity, flare_intensity, flare_type);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], ww2 + 0xbd, y + 5, color);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], ww2 + 0xc7, y + 5, color);
      Hud_BlackThinBox(x - 0x31, y, ww + 0x62, 0x11);
      Hud_FBuildF4(0, x - 0x31, y, 0x17, 0x11, 0, '\0', '\0');
      Hud_FBuildF4(0, ww2 + 0xba, y, 0x15, 0x11, 0, '\0', '\0');
      Hud_FBuildF4(0, ww2 + 0xba, y + 3, 0x16, 0xb, 0, '\0', '\0');
      Hud_FBuildF4(1, x - 0x1a, y, ww + 0x36, 0x11, 0x461414, '\0', '\0');
    }
    if (j == DashHUD_gInfo.splitscreen) {
      if ((u_int)((BTC_Countdown >> 6) - 1U) < 0x1e) {
        BigBTCTime(BTC_Countdown >> 6);
      } else {
        Hud_BuildCdPlayer((0x23f < simGlobal.gameTicks) &&
                          ((3 < (u_char)countdown) || (Hud_BeTheCop != 0)), j);
      }
    }
    if (((dashhud_info *)((int)&DashHUD_gInfo + viewOff))->showhud[0] != 0) {
      SPRT *gSprt1;
      int nextplayer;

      if (j != 0) {
        gSprt1 = gSprite1;
      } else {
        gSprt1 = gSprite0;
      }
      DashHUD_CheckWrongWay(j);
      DashHUD_HUDCalc(j);
      Hud_BuildNumbers0(j);
      Hud_BuildNumbers(j);
      {
        u_char *pal;
        u_int *tagp;

        pal = (*(u_char **)0x1F800000);
        tagp = (u_int *)((int)gTPage0 + tpageOff);
        *tagp = *tagp & 0xff000000 | *(u_int *)pal & 0xffffff;
        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & 0xffffff;
        if (GameSetup_gData.carInfo[j].HudTach != 0) {
          gSprt1[1].tag = (u_long *)((u_int)gSprt1[1].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)(gSprt1 + 1) & 0xffffff;
        }
      }
      if (GameSetup_gData.carInfo[j].HudMap != 0) {
        if (((GameSetup_gData.carInfo[j].HudOpponentID != 0) && (Hud_BeTheCop == 0)) &&
            (GameSetup_gData.commMode != 1)) {
          nextplayer = Hud_NextPlayer(j);
          if (-1 < nextplayer) {
            if ((nextplayer < 9) && (Hud_BeTheCop == 0)) {
              int w1;
              int w2;
              int totalwidth;
              int h;

              w1 = (int)HudPmx_gShapes[0xe].width;
              w2 = (int)HudPmx_gShapes[0x14].width;
              totalwidth = (int)HudPmx_gShapes[0x78].width + 2;
              sprintf(sBuildOutput, "%s", Hud_NextPlayerNameOrCarOrTime(j));
              Hud_GoTpage(1);
              uppercase(sBuildOutput);
              Hud_BuildString(sBuildOutput,
                              (int)g1Player[0xe].x +
                              (totalwidth - Hud_BuildString(sBuildOutput, 0, 0, 0, 0, true) >> 1),
                              ((g1Player[0xe].y + HudMapOffsetY + splitY) -
                               (int)HudPmx_gShapes[0xe].height) + 1, 0x808080, 0, false);
              Hud_GoTpage(0);
              Hud_FBuildGT4(&HudPmx_gShapes[0xe], (int)g1Player[0xe].x,
                            (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height,
                            0x808080);
              Hud_FBuildGT4(&HudPmx_gShapes[0xf], (int)g1Player[0xe].x + w1 + w2,
                            (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xf].height,
                            0x808080);
              Hud_FBuildF4(0, (int)g1Player[0xe].x + 2,
                           (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height,
                           w1 + w2 + 3, (int)HudPmx_gShapes[0xe].height, 0, '\0', '\0');
              h = 2;
              if (Hud_gWingmanInterface[j] == '\0') h = 3;
              Hud_FBuildF4(0, (int)g1Player[0xe].x, g1Player[0xe].y + HudMapOffsetY + splitY, 3, h,
                           0, '\0', '\0');
              Hud_FBuildF4(0, ((int)g1Player[0xe].x + w1 + w2 + (int)HudPmx_gShapes[0xf].width) - 3,
                           g1Player[0xe].y + HudMapOffsetY + splitY, 3, 3, 0, '\0', '\0');
            }
          }
        }
        {
          int i;
          u_char *pal;

          i = 0x3f;
          pal = (*(u_char **)0x1F800000);
          do {
            gSprt1[i].tag = (u_long *)((u_int)gSprt1[i].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
            *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&gSprt1[i] & 0xffffff;
            i = i + 1;
          } while (i < 0x47);
        }
      }
    }
    if (((j == 0) && (1 < Replay_ReplayMode)) && (Replay_ReplayInterface.statsScreen == 0)) {
      Hud_BuildReplay();
    }
    {
      u_char *pal;
      u_int *tagp;

      pal = (*(u_char **)0x1F800000);
      tagp = (u_int *)((int)gTPage1 + tpageOff);
      *tagp = *tagp & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & 0xffffff;
    }
    if (((((dashhud_info *)((int)&DashHUD_gInfo + viewOff))->showhud[0] != 0) &&
         (Hud_gWingmanInterface[j] != '\0')) && (Replay_ReplayMode < 2)) {
      Hud_BuildWingmanInterface(j);
    }
    {
      u_char *pal;
      u_int *tagp;
      int *viewp;

      pal = (*(u_char **)0x1F800000);
      viewp = (int *)((int)Hud_gHudView + viewOff);
      tagp = (u_int *)((int)gTPage0 + tpageOff + 0xc);
      viewOff = viewOff + 4;
      tpageOff = tpageOff + 0x30;
      *tagp = *tagp & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & 0xffffff;
      Draw_StopRenderingView(*viewp);
    }
    j = j + 1;
  }
}
# 3720 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
void Hud_RenderTacView(void)

{
  int j;

  j = 0;
  if (-1 < DashHUD_gInfo.splitscreen) {
    do {




      int j4;

      j4 = j * 4;
      if ((GameSetup_gData.carInfo[j].HudTach != 0) &&
          (((int *)(j4 + (int)&DashHUD_gInfo))[7] != 0)) {
        u_char *pal;
        DR_MODE *tp;

        Draw_StartRenderingView(*(int *)(j4 + (int)Hud_gTacView));
        DashHUD_HUDCalc(j);
        Hud_BuildTach(j);
        pal = (*(u_char **)0x1F800000);


        tp = &gTPage1[j][2];
        tp->tag = tp->tag & 0xff000000 | *(u_int *)pal & 0xffffff;
        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tp & 0xffffff;
        Draw_StopRenderingView(*(int *)(j4 + (int)Hud_gTacView));
      }
      j = j + 1;
    } while (j <= DashHUD_gInfo.splitscreen);
  }
  return;
}





extern int D_801132CC[];


void Hud_ParseTime(int nTime,char *sLapTime)

{
  int centi_total;
  int min;
  bool showtime;
  int iVar1;
  int sec;

  if (nTime < 0) {
    nTime = 0;
  }
  showtime = nTime != 0;
  centi_total = nTime * 0x6400;
  if (centi_total < 0) {
    centi_total = centi_total + 0x3fff;
  }
  nTime = centi_total >> 0xe;
  min = (nTime / 6000) * 0x10000 >> 0x10;
  nTime = nTime + min * -6000;
  sec = (nTime / 100) * 0x10000 >> 0x10;
  nTime = nTime + sec * -100;
  if (!(min < 0x3c)) {
    showtime = 0;
  }
  if (showtime != 0) {
    sprintf(sLapTime,"%01d%c%02d%c%02d",min,
               (u_int)(u_char)HudminChar[GameSetup_gData.userSetting.language],sec,
               (u_int)(u_char)HudsecChar[GameSetup_gData.userSetting.language],
               nTime * 0x10000 >> 0x10);
  }
  else {
    iVar1 = D_801132CC[0];
    sprintf(sLapTime," - %c - - %c - -",
               (u_int)(u_char)HudminChar[iVar1],
               (u_int)(u_char)HudsecChar[iVar1]);
  }
  return;
}


void Hud_RenderPauseBox(int x, int y, int w, int h)
{
  short CORNERWIDTH, CORNERHEIGHT;

  CORNERWIDTH = HudPmx_gShapes[0x11].width;
  CORNERHEIGHT = HudPmx_gShapes[0x11].height;

  Hud_FBuildFT4(&HudPmx_gShapes[0xe], x - 2, y + 0xa, 0);
  Hud_FBuildFT4(&HudPmx_gShapes[0xf], (x + w) - CORNERWIDTH, y + 0xa, 0);
  Hud_FBuildFT4(&HudPmx_gShapes[0x10], x - 2, (y + h) - CORNERHEIGHT, 0);
  Hud_FBuildFT4(&HudPmx_gShapes[0x11], (x + w) - CORNERWIDTH, (y + h) - CORNERHEIGHT, 0);

  Hud_FBuildF4(0, x, (y + h) - 2, w, 2, 0, '\0', '\0');
  Hud_BlackThinBox(x, y, w, h);
  Hud_FBuildF4(0, x, y, w, 0xc, 0, '\0', '\0');
  Hud_FBuildF4(1, x, y + 0xc, w, h - 0xc, 0x461414, '\0', '\0');
}


void Hud_Render(void)

{
  short player;
  int countamount;
  int count;
  int wingmode;
  int remain;
  int i;
  char *iface;
  int j;

  if (Replay_ReplayInterface.statsScreen != 0) {
    if (simGlobal.gameTicks < 0x240) {
      DashHUD_gInfo.showhud[0] = 0;
      DashHUD_gInfo.showhud[1] = 0;
    }
    gCView.id = Hud_gStatsView;
    Draw_StartRenderingView(Hud_gStatsView);
    Hud_DebugCrap();
    Hud_RenderStatsView();
    Draw_StopRenderingView(Hud_gStatsView);
    return;
  }
  if (((HudBustedOverlay == 0) && (BTC_BonusTime != 0)) && (0xfa < ticks - BTC_BonusTimeTick)) {




    if (DashHUD_gInfo.splitscreen != 0) {
      if ((Cars_gRaceCarList[0]->carFlags & 0x200U) == 0) goto HudRender_amt250;
      if ((Cars_gRaceCarList[1]->carFlags & 0x200U) == 0) {
        countamount = 0xfa;
        goto HudRender_amtDone;
      }
    }
    countamount = 0x32;
    goto HudRender_amtDone;
HudRender_amt250:
    countamount = 0xfa;
HudRender_amtDone:
    remain = BTC_BonusTime;
    count = countamount;
    if (remain < countamount) {
      count = remain;
    }
    remain = remain - countamount;
    BTC_Countdown = BTC_Countdown + count;



    if (remain < 0) {
      remain = 0;
    }
    BTC_BonusTime = remain;
  }
  if ((Hud_BeTheCop != 0) && (BTC_UserHasControl == 0)) {
    for (i = 0; i <= DashHUD_gInfo.splitscreen; i = i + 1) {
        Draw_StartRenderingView(Hud_gHudView[i]);
        Hud_GoTpage(1);
        if (((i == 0) && (1 < Replay_ReplayMode)) && (Replay_ReplayInterface.statsScreen == 0)) {
          Hud_BuildReplay();
        }
        if (i == DashHUD_gInfo.splitscreen) {
# 3897 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
          countamount = 1;
          if (simGlobal.gameTicks < 0x240) {
            if (countdown == '\0') {
              countamount = 0;
# 3914 "C:\\Temp\\nfs4-wt46-a10\\recon\\game\\psx\\hud.cpp"
              __asm__ volatile("" : : "r"(countamount));
            }
          }
          Hud_BuildCdPlayer(countamount,i);
        }
        if (DashHUD_gInfo.showhud[i] != 0) {
          Hud_DebugInfo();
          Hud_BuildNumbers0(i);
        }
        Hud_GoTpage(0);
        Draw_StopRenderingView(Hud_gHudView[i]);
    }
  }
  else {
    if ((HudBustedOverlay != 0) && (Replay_ReplayMode < 2)) {
      player = HudBustedOverlayPlayer;
      gCView.id = Hud_gStatsView;
      Draw_StartRenderingView(Hud_gStatsView);
      StatsTimer[player] = StatsTimer[player] + 1;
      Hud_BTCStats(player,false);
      Draw_StopRenderingView(Hud_gStatsView);
    }
    j = 0;





    while (true) {
      if (2 <= j) break;
      wingmode = Input_WingCommandMode(j);
      if (((u_char)Hud_gWingmanInterface[j] == wingmode) && (HudBustedOverlay != 0)) {
        Hud_gWingmanInterface[j] = 0;
        Hud_InitMapFrame(j,0);
      }
      else if (ticks > Hud_gWingmanFlashTicks[j]) {
        if ((u_char)Hud_gWingmanInterface[j] != wingmode) {
          if (1 < Replay_ReplayMode) goto HudRender_initMapFrame;
          if (HudBustedOverlay == 0) {
            Hud_InitMapFrame(j,wingmode);
            Hud_gWingmanInterface[j] = (char)wingmode;
          }
        }
        if (Replay_ReplayMode < 2) goto HudRender_next;
HudRender_initMapFrame:
        Hud_gWingmanInterface[j] = 0;
        Hud_InitMapFrame(j,0);
      }
HudRender_next:
      j = j + 1;
    }
    Hud_gShowedCDPlayer = 0;
    if (((simGlobal.gameTicks < 0x240) && (countdown != '\0')) && (Hud_BeTheCop == 0)) {
      Hud_Render321Go();
    }
    Hud_RenderHudView();
    Hud_RenderMapView();
    Hud_RenderTacView();
  }
  return;
}


void Hud_PositionMap(void)
{
  int track;

  gMapScaleX = (int)(fMapScaleX[track = GameSetup_gData.track] * 65536.0f);
  gMapScaleY = (int)(fMapScaleY[track] * 65536.0f);
  gMapOffX = fMapOffX[track];
  if (GameSetup_gData.mirrorTrack != 0) {
    gMapOffX = gMapOffX - 2;
  }
  gMapOffY = fMapOffY[track];
  gMapRotate = fMapRotate[track];
  mapMarkerMCos = ccos(gMapRotate) << 4;
  mapMarkerMSin = csin(gMapRotate) << 4;
}


void Hud_BTC_Update(char *perpname,int timeleft,bool userHasControl)

{

  sprintf(BTC_CurrentPerpName,perpname);
  BTC_UserHasControl = userHasControl;
  if ((BTC_BonusTime == 0) && (HudBustedOverlay == 0)) {
    BTC_Countdown = timeleft << 1;
  }
  return;
}


void Hud_BustedOverlayOn(int time,char *name,bool caught,short player)

{
  char *pcVar1;
  int iVar2;
  short *psVar3;
  int iVar4;
  int i;

  StatsTimer[player] = 0;
  if (Replay_ReplayMode < 2) {
    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][*psVar3].name,name);
    if (caught != 0) {
      BTCPerpInfo[player][*psVar3].caught = 1;
      BTCPerpInfo[player][*psVar3].time = time;
      *psVar3 = *psVar3 + 1;
    }
    else {
      i = 0;
      iVar4 = 0;
      do {
        psVar3 = Hud_NextPerp + i;
        iVar2 = (int)*psVar3;






        if ((iVar2 == 0) || (BTCPerpInfo[i][iVar2 - 1].caught != 0)) {
          BTCPerpInfo[i][iVar2].caught = 0;
          BTCPerpInfo[i][*psVar3].time = 0;
          sprintf(BTCPerpInfo[i][*psVar3].name,BTC_CurrentPerpName);
          *psVar3 = *psVar3 + 1;
        }
        i = i + 1;
        iVar4 = iVar4 + 0xa0;
      } while (i < 2);
    }
    HudBustedOverlay = 1;
    HudBustedOverlayPlayer = player;
  }
  return;
}


void Hud_BustedOverlayOff(void)

{
  HudBustedOverlay = 0;
  return;
}


void Hud_Reset(void)

{
  short *psVar1;
  int iVar2;
  int i;

  iVar2 = 0;
  if (Replay_ReplayMode < 2) {
    do {
      Hud_NextPerp[iVar2] = 0;
      iVar2 = iVar2 + 1;
      BTC_CurrentPerpName[0] = '\0';
    } while (iVar2 < 2);
  }
  BTC_BonusTime = 0;
  HudBustedOverlay = 0;
  PerpOverlayOn[0] = 0;
  PerpOverlayOn[1] = 0;
  BTC_UserHasControl = 0;
  return;
}






void Hud_BTC_QuitOut(void)

{
  short *perp_idx;
  tBTCPerpInfo *row_base;
  int row_off;
  int i;
  int slot_i;
  char *name_tail;

  if (HudBustedOverlay == 0) {
    slot_i = 0;
    do {
      perp_idx = Hud_NextPerp + slot_i;
      sprintf(BTCPerpInfo[slot_i][*perp_idx].name,BTC_CurrentPerpName);
      BTCPerpInfo[slot_i][*perp_idx].caught = 0;
      BTCPerpInfo[slot_i][*perp_idx].time = 0;
      *perp_idx = *perp_idx + 1;
      slot_i = slot_i + 1;
    } while (slot_i < 2);
  }
  return;
}


void Hud_BTC_BonusTime(long extratime)

{
  BTC_BonusTime = extratime;
  BTC_BonusTimeTick = ticks;
  return;
}


void Hud_Perp_OverlayOn(int player,int level)

{
  *(int *)((player << 2) + (int)PerpOverlayOn) = 1;
  *(int *)((player << 2) + (int)PerpOverlayMessage) = level;
  return;
}


void Hud_Perp_OverlayOff(int player)

{
  int rpm;
  int slice;
  int temp1;
  int offy;
  int speed;
  int sec;
  char *artist;
  char *title;
  int rx;
  int flashTicks;
  int lx;
  char langSec;
  int ten;
  int w7;
  int sin;
  int cos;
  int ox;
  int cenX;
  int cenZ;
  int u;
  int v;
  int yo;

  *(int *)((player << 2) + (int)PerpOverlayOn) = 0;
  return;
}




int countdownTick_216;
