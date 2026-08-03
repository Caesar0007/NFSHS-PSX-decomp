# 0 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"




# 1 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.h" 1



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
# 5 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.h" 2


void Quick_DD(int a,int b,int c);
void PSXFront_AllocateDrawMemory(void);
void PSXFront_FreeDrawMemory(void);
void InitializeSpinningCars(void);
void CleanupSpinningCars(void);
void CleanupSpinningCarsMenu(void);
void DoTitleScreen(void);
void DoLanguageScreen(void);
void PSXExitFrontend(void);
void PSX_AllocShapes(void);
void Init_RenderingEnvironment(void);
void Init_PSX_FrontEnd(void);
void AdjustShapeDrawing(tTexture_ShapeInfo *tShp,int *x,int *y,int *flags,int bright,int *color, tDrawShapeExtended *extra);
void DrawGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr);
void DrawFlatShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr);
void DrawShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra);
void ScaleGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color, int abr);
void ScaleFlatShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color, int abr);
void ScaleShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra);
void LoadAllHelpShapes(void);
void PSXDrawSquare(int col,int x,int y,int w,int h);
void PSXDrawGouraudSquare(int x,int y,int w,int h,int c1,int c2,int c3,int c4);
void PSXDrawTransGouraudSquare(int x,int y,int w,int h,int opacity,int c1,int c2,int c3,int c4);
void PSXDrawTransSquare(int col,int x,int y,int w,int h,short opacity);
void FontUpsideDownBlit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6);


extern tTexture_ShapeInfo *gHelpShapes[];
extern Car_tObj *gCarObj[2];
extern char titleScreenDisplayed[];
extern short gFadeBrightness;
extern char *creditShapeFile[];
# 6 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp" 2
# 1 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront_externs.h" 1





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
# 7 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront_externs.h" 2

typedef void EAC_timerproc(void);

extern "C" {
void AudioCmn_LoadFESamples(void);
void Audio_DeInitDriver(void);
void Audio_InitDriver(int buffersize, int spusize);
void CarIO_CleanUp(void);
void CarIO_ReStart(void);
void CarIO_StartUp(void);
void ClearPrimitivesBuffer(void);
void DrawC_ReadeMapData(void);
void Draw_DirectSetEnvironment(int x, int y, int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);
void Draw_InitViewOT(void);
void Draw_InitViews(void);
int Draw_SetView(int x0, int y0, int x1, int y1, int w, int h, int dtd, int isbg, int otsize);
void Draw_SetViewMemBudget(int viewid, int totalmem);
void FETextRender_SetABR(int abr, bool trans);
void FETexture_LoadPmx(char * f, int index, tTexture_ShapeInfo * dest);
void Fe3D_InitShowroom(void);
void FeTools_init(void);
void Front_InitialMemCardCheck(void);
void Front_SecondaryMemCardCheck(void);
void Platform_ResetDCTBuffer(void);
void R3DCar_CleanUp(void);
void R3DCar_DeInstantiate3DCar(Car_tObj * carObj);
void R3DCar_DeInstantiate3DCarMenu(Car_tObj * carObj);
void R3DCar_Instantiate3DCar(Car_tObj * carObj, int index);
void R3DCar_PostStartUp(void);
void R3DCar_StartUp(void);
void SetPlayList(int ivealreadygotone);
void TextSys_LoadWords(int language);
void Texture_CleanupMenuTexture(void);
void Texture_InitMenuClut(void);
void Texture_InitMenuTexture(void);
void Texture_KillMenuTexture(void);
int elapsedticks(void);
int play_movie(char movie);
void trap(int code);



extern u_char CF_DVLC[49096];
extern int ComingIntoTheFrontEndTheVeryFirstTime[];
extern int DrawC_gMenuColor[2];
extern int DrawC_gMenuLights[];
extern int DrawC_gMenuLightsDirection[];
extern int Draw_gDoVSync[];
extern int Draw_gPlayer1View[];
extern int Draw_gRearView[];
extern char GameSetup_gCarNames[51][5];
extern GameSetup_tData GameSetup_gData;
extern char *Paths_Paths[50];
extern int R3DCar_InMenu[];
extern u_long font_tint;
extern tfrontEnd frontEnd;
extern DRender_tView gCView;





extern tTexture_ShapeInfo *gCurrentShapes[];
extern dflip gEnviro[2];
extern int gFlip[];
extern u_short gFontClut;
extern int gMenuRotate[2];
extern int inFrontEnd[];
extern int screenbpp[];
extern int screenwidth[];
}
# 7 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp" 2


static char *STR_FRMT[2];

static u_short ofs[2];
static char rendering3DEnvInit__[8];





void Quick_DD(int a,int b,int c)

{
  Draw_DirectSetEnvironment(0,0,0x200,0xf0,a,b,c,0,0,0);
  return;
}




void PSXFront_AllocateDrawMemory(void)

{
  Draw_InitViewOT();
  gEnviro[0].server = (char *)reservememadr("ps0",80000,0x10);
  gEnviro[1].server = (char *)reservememadr("ps1",80000,0x10);
  Draw_SetViewMemBudget(Draw_gPlayer1View[0],80000);
  return;
}




void PSXFront_FreeDrawMemory(void)

{
  ClearPrimitivesBuffer();
  return;
}




void InitializeSpinningCars(void)

{



  Car_tObj *carObj;
  int i;

  if (rendering3DEnvInit__[0] == '\0') {
    R3DCar_InMenu[0] = 1;
    Platform_ResetDCTBuffer();
    Texture_InitMenuTexture();
    inFrontEnd[0] = 1;
    CarIO_StartUp();
    R3DCar_StartUp();
    inFrontEnd[0] = 0;
    DrawC_ReadeMapData();
    Fe3D_InitShowroom();
    GameSetup_gData.Weather = 0;
    i = 0;
    while (1) {
      if (2 <= i) break;
      carObj = (Car_tObj *)reservememadr("carObj",0x8dc,0);
      gCarObj[i] = carObj;
      blockclear(carObj,0x8dc);
      carObj->carInfo = &GameSetup_gData.carInfo[i];
      carObj->carInfo->carType = 1;
      strcpy(carObj->carName,GameSetup_gCarNames[carObj->carInfo->carType]);
      (carObj->N).objID = i | 0x100;
      R3DCar_Instantiate3DCar(carObj,i);
      (carObj->N).active = '\x01';
      i = i + 1;
    }
    R3DCar_PostStartUp();
    gMenuRotate[1] = 0;
    gMenuRotate[0] = 0;
    blockclear(&gCView,0x8c);
    DrawC_gMenuColor[1] = -1;
    DrawC_gMenuColor[0] = -1;
    DrawC_gMenuLights[0] = 0;
    DrawC_gMenuLightsDirection[0] = 0;
    rendering3DEnvInit__[0] = '\x01';
  }
  return;
}




void CleanupSpinningCars(void)

{



  int handle;
  int i;
  char fname [60];

  if (rendering3DEnvInit__[0] != '\0') {
    DrawSync(0);
    for (i = 0; i < 2; i = i + 1) {
      R3DCar_DeInstantiate3DCar(gCarObj[i]);
      purgememadr(gCarObj[i]);
    }
    inFrontEnd[0] = 1;
    R3DCar_CleanUp();
    CarIO_CleanUp();
    inFrontEnd[0] = 0;
    Texture_KillMenuTexture();
    PSXFront_FreeDrawMemory();
    R3DCar_InMenu[0] = 0;
    gFlip[0] = -1;
    rendering3DEnvInit__[0] = '\0';
    Platform_ResetDCTBuffer();
    sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
    handle = asyncloadfileat(fname,CF_DVLC);
    while (getasyncreadstatus(handle) == 0) {
      systemtask(0);
    }
  }
  return;
}




void CleanupSpinningCarsMenu(void)

{
  Car_tObj *carObj;
  Car_tObj **ppCar;
  int i;

  if (rendering3DEnvInit__[0] != '\0') {
    DrawSync(0);
    i = 0;
    ppCar = gCarObj;
    do {
      carObj = *ppCar;
      ppCar = ppCar + 1;
      i = i + 1;
      R3DCar_DeInstantiate3DCarMenu(carObj);
    } while (i < 2);
    Texture_CleanupMenuTexture();
    CarIO_ReStart();
  }
  return;
}




void DoTitleScreen(void)

{
  void *shape;
  shapetbl *tempShp2;
  char fileName [48];
  char artfilename [20];

  elapsedticks();
  if (creditShapeFile[0] == (char *)0x0) {
    sprintf(artfilename,"title.psh");
    sprintf(fileName,STR_FRMT[0],Paths_Paths[0x20],artfilename);
    creditShapeFile[0] = (char *)loadshapeadr(fileName,(void *)0x0);
    systemtask(0);
    if (creditShapeFile[0] == (char *)0x0) {
      return;
    }
  }
  shape = (tTexture_ShapeInfo *)locateshapez(creditShapeFile[0],(void *)"back");
  Quick_DD(1,0,1);
  settrans(0);
  movfxya(shape,0,0);
  settrans(1);
  Quick_DD(0,1,0);
  purgememadr(creditShapeFile[0]);
  creditShapeFile[0] = (char *)0x0;
  titleScreenDisplayed[0] = '\x01';
  return;
}




void DoLanguageScreen(void)

{
  Front_InitialMemCardCheck();
  if ((u_char)frontEnd.language == 0xff) {
    frontEnd.language = '\0';
  }
  return;
}




void PSXExitFrontend(void)

{
  CleanupSpinningCars();
  deltimer(PAD_update);
  Audio_DeInitDriver();
  if (gHelpShapes[0] != (tTexture_ShapeInfo *)0x0) {
    purgememadr(gHelpShapes[0]);
    gHelpShapes[0] = (tTexture_ShapeInfo *)0x0;
  }
  ComingIntoTheFrontEndTheVeryFirstTime[0] = 0;
  return;
}




void PSX_AllocShapes(void)

{
  tTexture_ShapeInfo **slot = gHelpShapes;

  *slot = (tTexture_ShapeInfo *)reservememadr("gHelpShapes",0x760,0);
  blockclear(*slot,0x760);
  return;
}




void Init_RenderingEnvironment(void)

{
  SetDefDispEnv(&gEnviro[0].disp,0,0x100,0x200,0xf0);
  SetDefDispEnv(&gEnviro[1].disp,0,0,0x200,0xf0);
  Draw_InitViews();
  Draw_gRearView[0] = -1;





  Draw_gPlayer1View[0] =
       Draw_SetView
                 (0,0,0,0x100,0x200,0xf0,0,1,10);
  blockclear(&gCView,0x8c);
  gCView.id = Draw_gPlayer1View[0];
  PSXFront_AllocateDrawMemory();
  Draw_gDoVSync[0] = 1;
  FETextRender_SetABR(0,false);
  gFlip[0] = 0;
  return;
}




void Init_PSX_FrontEnd(void)

{




  gFlip[0] = -1;
  addtimer(PAD_update);
  InitGeom();
  PSX_AllocShapes();
  Texture_InitMenuClut();
  screenwidth[0] = 0x200;
  screenbpp[0] = 0x10;
  if (ComingIntoTheFrontEndTheVeryFirstTime[0] != 0) {
    if (play_movie('\x04') != 1) {
      play_movie('\0');
    }
    initlinkmode(0,1,1);
    Init_RenderingEnvironment();
    initlinkmode(0,0x14,0);
    DoLanguageScreen();
    TextSys_LoadWords((uint)(byte)frontEnd.language);
    DoTitleScreen();
    initlinkmode(0,1,1);
    Front_SecondaryMemCardCheck();
  }
  else {
    Init_RenderingEnvironment();
    TextSys_LoadWords((uint)(byte)frontEnd.language);
  }
  FeTools_init();
  Audio_InitDriver(0xd800,0x18000);
  SetPlayList(frontEnd.GotAPlayList);
  AudioCmn_LoadFESamples();
  LoadAllHelpShapes();
  return;
}




extern "C" void AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tTexture_ShapeInfo *tShp,int *x,int *y,int *flags,int bright,int *color,
               tDrawShapeExtended *extra)

{
# 322 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
  short fadetop;
  short fadebottom;

  if ((*flags & 0x400U) != 0) {
    *x = *x - tShp->centerx;
    *y = *y - tShp->centery;
  }
  else if (*y <= 0) {
    *x = *x - tShp->centerx;
    *y = -(tShp->centery + *y);
  }
  if ((*flags & 0x100U) != 0) {
    *x = *x - ((int)((uint)(ushort)tShp->width << 0x10) >> 0x11);
    *y = *y - ((int)((uint)(ushort)tShp->height << 0x10) >> 0x11);
  }
  if ((*flags & 0x20U) != 0) {
    *y = (extra->flip_axis * 2 - (*y + tShp->height)) + 1;
    *flags = *flags | 2;
  }
  if ((*flags & 0x10U) != 0) {


    *color = (((extra->tint[0] >> 0x10) & 0xff) * bright / 128) << 0x10 |
             ((extra->tint[0] >> 8 & 0xff) * bright / 128) << 8 |
             (int)*(byte *)((int)extra->tint) * bright / 128;
  }
  else if ((*flags & 0x80U) != 0) {
    short i;
    for (i = 0; i < 4; i = i + 1) {
      color[i] = (((extra->tint[i] >> 0x10) & 0xff) * bright / 128) << 0x10 |
                 ((extra->tint[i] >> 8 & 0xff) * bright / 128) << 8 |
                 (int)*(byte *)((int)(extra->tint + i)) * bright / 128;
    }
  }
  else if ((*flags & 0x40U) != 0) {
    int fbot;
    int ftop;



    int rawT;
    int rawB;


    rawT = ((uint)(ushort)extra->flip_axis - (uint)(ushort)*y) + 1;
    fadetop = rawT;
    if (rawT * 0x10000 < 0) {
      fadetop = -rawT;
    }
    fadetop = fadetop << 1;
    if (0x80 < fadetop) {
      fadetop = 0x80;
    }
    rawB = ((uint)(ushort)extra->flip_axis - ((uint)(ushort)*y + (uint)(ushort)tShp->height)) + 1;
    fadebottom = rawB;
    if (rawB * 0x10000 < 0) {
      fadebottom = -rawB;
    }
    fadebottom = fadebottom << 1;
    if (0x80 < fadebottom) {
      fadebottom = 0x80;
    }


    fbot = 0x80 - fadebottom;
    ftop = 0x80 - fadetop;
    *color = fbot << 0x10 | fbot << 8 | fbot;
    color[1] = fbot << 0x10 | fbot << 8 | fbot;
    color[2] = ftop << 0x10 | ftop << 8 | ftop;
    color[3] = ftop << 0x10 | ftop << 8 | ftop;
  }
  else {
    *color = bright << 0x10 | bright << 8 | bright;
  }
  return;
}
# 408 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
typedef struct { unsigned addr : 24, len : 8; } PSXFront_PTag;
# 471 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
void DrawGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr)

{





  u_char *prim;
  short width;
  short height;
  short u;
  short v;
  short vh;
  short bpp;
  short i;
  int w;
  short w1;
  int deadfrm[2];


  height = shp->height;
  width = shp->width;
  bpp = (byte)shp->depth;
  if ((flags & 2) != 0) {
    y = y + height;
    height = -height;
  }
  v = (byte)shp->shapey;
  vh = shp->height;
# 616 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
  if ((flags & 2) != 0) {
    v = (byte)shp->shapey - 1;
  }






  i = 0;
  while (i < shp->width) {
    int addw;
    int texX;
    int wsel;
    int c3;

    texX = (uint)(ushort)shp->shapex + (i * bpp) / 16;
    u = (i + ((int)((uint)(ushort)shp->shapex << 0x10) >> 0xc) / bpp) -
        ((int)((texX & 0xffffffc0U) << 0x10) >> 0xc) / bpp;
    wsel = 0xff - u;
    if (shp->width - i < wsel) {
      wsel = shp->width - i;
    }
    w = wsel;
    uint *pal;



    uint addr24;

    prim = (*(u_char **)0x1F800004);
    (*(u_char **)0x1F800004) = prim + 0x34;





    pal = (uint *)(*(u_char **)0x1F800000);

    ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)pal)->addr;
    ((PSXFront_PTag *)pal)->addr = (uint)prim;
    *(int *)(prim + 4) = color[0];
    *(int *)(prim + 0x10) = color[1];
    *(int *)(prim + 0x1c) = color[2];
# 668 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
    c3 = color[3];
    prim[7] = (flags & 1) * 2 + 0x3c;
    prim[3] = 0xc;
    *(int *)(prim + 0x28) = c3;
    *(short *)(prim + 0xe) = GetClut((shp->clutID & 0x3fU) << 4,shp->clutID >> 6);
    *(ushort *)(prim + 0x1a) =
         ((byte)shp->type & 3) << 7 | (abr & 3U) << 5 |
         (shp->shapey & 0x100) >> 4 |
         (texX & 0x3c0U) >> 6 | ((ushort)shp->shapey & 0x200) << 2;
    addw = 0;
    if (((flags & 4) != 0) && (shp->width < 0xff)) {
      u = u - 1;
      addw = 1;
    }
    w1 = w;
    prim[0xc] = u;
    prim[0xd] = v;
    prim[0x18] = u + w1;
# 700 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
    prim[0x19] = prim[0xd];
    prim[0x24] = u;
    prim[0x30] = u + w1;
    prim[0x25] = vh + v;
    prim[0x31] = vh + v;
    if (w1 <= 0) {
      w1 = 1;
    }
    if ((flags & 4) != 0) {
      addw = addw - 1;

      *(short *)(prim + 8) = ((width + x) - i) + addw;
      *(short *)(prim + 10) = y;
      *(short *)(prim + 0x14) = ((shp->width + x) - (i + w1)) + addw;
      *(short *)(prim + 0x16) = y;
      *(short *)(prim + 0x20) = ((shp->width + x) - i) + addw;
      *(short *)(prim + 0x22) = y + height;
      *(short *)(prim + 0x2c) = ((shp->width + x) - (i + w1)) + addw;
      *(short *)(prim + 0x2e) = y + height;
    }
    else {
      *(short *)(prim + 8) = i + x;
      *(short *)(prim + 10) = y;
      *(short *)(prim + 0x14) = w1 + (i + x);
      *(short *)(prim + 0x16) = y;
      *(short *)(prim + 0x20) = i + x;
      *(short *)(prim + 0x22) = y + height;
      *(short *)(prim + 0x2c) = w1 + (i + x);
      *(short *)(prim + 0x2e) = y + height;
    }
    i = i + w1;
  }
  return;
}




void DrawFlatShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr)

{
  int c0;

  c0 = *color;
  color[3] = c0;
  color[2] = c0;
  color[1] = c0;



  DrawGouraudShape(shp,flags,x,y,color,abr);
  return;
}




void DrawShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra)

{




  tTexture_ShapeInfo *tShp;
  int color [4];
  int bright;

  if ((flags & 8) != 0) {
    tShp = gHelpShapes[0] + index;
  }
  else {
    tShp = gCurrentShapes[0] + index;
  }
  bright = 0x80 - fade;
  if ((flags & 0x200) != 0) {
    tShp = extra->custom_shapes + index;
  }
  AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tShp,&x,&y,&flags,bright * 0x10000 >> 0x10,color,extra);


  if ((flags & 0xc0U) != 0) {
    DrawGouraudShape(tShp,flags,x,y,color,abr);
  }
  else {
    DrawFlatShape(tShp,flags,x,y,color,abr);
  }
  return;
}
# 842 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
void ScaleGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color,
               int abr)

{




  u_char *prim;
  short width;
  short height;
  short bpp;
  char u;
  char v;
  char uw;
  char vh;
  int xm1;
  int one;


  uint *pal;






  prim = (*(u_char **)0x1F800004);
  pal = (uint *)(*(u_char **)0x1F800000);
  width = shp->width;
  height = shp->height;
  bpp = (byte)shp->depth;

  ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)pal)->addr;
  (*(u_char **)0x1F800004) = prim + 0x34;
  ((PSXFront_PTag *)pal)->addr = (uint)prim;
  *(int *)(prim + 4) = color[0];
  *(int *)(prim + 0x10) = color[1];
  *(int *)(prim + 0x1c) = color[2];
  *(int *)(prim + 0x28) = color[3];
  SetPolyGT4((POLY_GT4 *)prim);
  SetSemiTrans(prim,flags & 1);
  one = 1;
  *(short *)(prim + 0xe) = GetClut((shp->clutID & 0x3fU) << 4,shp->clutID >> 6);
  *(ushort *)(prim + 0x1a) =
       ((byte)shp->type & 3) << 7 | (abr & 3U) << 5 |
       (shp->shapey & 0x100) >> 4 |
       ((ushort)shp->shapex & 0x3c0U) >> 6 | ((ushort)shp->shapey & 0x200) << 2;
  if ((flags & 4U) != 0) {
    x = x + fixedmult(scalex,width);
    width = -width;
  }
  if ((flags & 2U) != 0) {
    y = y + fixedmult(scaley,height);
    height = -height;
  }
  *(short *)(prim + 8) = x;
  *(short *)(prim + 10) = y;
  *(short *)(prim + 0x14) = (x - one) + fixedmult(scalex,width);
  *(short *)(prim + 0x16) = y;
  *(short *)(prim + 0x20) = x;
  *(short *)(prim + 0x22) = y + fixedmult(scaley,height);
  xm1 = x - one;
  xm1 = xm1 + fixedmult(scalex,width);
  *(short *)(prim + 0x2c) = xm1;
  *(short *)(prim + 0x2e) = y + fixedmult(scaley,height);
  {





    int sw = (byte)shp->width;
    int sh_ = (byte)shp->height;
    u = (((ushort)shp->shapex & 0x3f) << 4) / bpp;
    v = (byte)shp->shapey;
    if ((flags & 4U) != 0) {
      u = u - one;


    }
    uw = u + sw;
    if ((flags & 2U) != 0) {
      v = (byte)shp->shapey - one;
    }
    prim[0xd] = v;
    prim[0x19] = v;
    vh = v + sh_;
    prim[0xc] = u;
    do {

      prim[0x18] = uw;
      prim[0x24] = u;
      prim[0x25] = vh;
      prim[0x30] = uw;
      prim[0x31] = vh;
    } while (0);
  }
  return;
}




void ScaleFlatShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color,
               int abr)

{
  int c0;

  c0 = *color;
  color[3] = c0;
  color[2] = c0;
  color[1] = c0;
  ScaleGouraudShape(shp,flags,x,y,scalex,scaley,color,abr);
  return;
}




void ScaleShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra)

{



  tTexture_ShapeInfo *tShp;
  int scalex = 0x20000;
  int scaley = 0x10000;
  int color [4];
  int bright;

  if ((flags & 8) != 0) {
    tShp = gHelpShapes[0] + index;
  }
  else {
    tShp = gCurrentShapes[0] + index;
  }
  bright = 0x80 - fade;
  if ((flags & 0x200) != 0) {
    tShp = extra->custom_shapes + index;
  }
  AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tShp,&x,&y,&flags,bright * 0x10000 >> 0x10,color,extra);
  if ((flags & 0xc0U) != 0) {
    ScaleGouraudShape(tShp,flags,x,y,scalex,scaley,color,abr);
  }
  else {
    ScaleFlatShape(tShp,flags,x,y,scalex,scaley,color,abr);
  }
  return;
}




void LoadAllHelpShapes(void)

{
  char *f;
  int i;
  int index;
  char *permFile;
  char fullName [48];

  sprintf(fullName,"%szperm.psh",Paths_Paths[0x20]);
  f = (char *)loadshapeadr(fullName,(void *)0x0);
  if (f != (char *)0x0) {
    index = 0;
    do {
      FETexture_LoadPmx(f,index,gHelpShapes[0] + index);
      index = index + 1;
    } while (index < 0x3b);
    purgememadr(f);
  }
  return;
}





void PSXDrawSquare(int col,int x,int y,int w,int h)

{





  POLY_F4 *prim;
  uint link;

  prim = (POLY_F4 *)(*(u_char **)0x1F800004);

  prim->tag = prim->tag & 0xff000000 | *(uint *)(*(u_char **)0x1F800000) & 0xffffff;





  link = *(uint *)(*(u_char **)0x1F800000);
  (*(u_char **)0x1F800004) = (u_char *)prim + 0x18;
  *(uint *)(*(u_char **)0x1F800000) = link & 0xff000000 | (uint)prim & 0xffffff;
  *(int *)&prim->r0 = col;
  prim->code = 0x28;
  *((u_char *)prim + 3) = 5;
  prim->y0 = y;
  prim->y1 = y;
  prim->x0 = x;
  prim->x1 = x + w;
  prim->x2 = x;
  prim->y2 = y + h;
  prim->x3 = x + w;
  prim->y3 = y + h;
  return;
}





void PSXDrawGouraudSquare(int x,int y,int w,int h,int c1,int c2,int c3,int c4)

{





  uint otWord;
  POLY_G4 *prevPrim;
  POLY_G4 *prim;

  prim = (POLY_G4 *)(*(u_char **)0x1F800004);
  prevPrim = (POLY_G4 *)(*(u_char **)0x1F800000);
  prim->tag = prim->tag & 0xff000000 | prevPrim->tag & 0xffffff;
  otWord = prevPrim->tag;
  (*(u_char **)0x1F800004) = (u_char *)prim + 0x24;
  prevPrim->tag = otWord & 0xff000000 | (uint)prim & 0xffffff;
  *(int *)&prim->r0 = c1;
  *(int *)&prim->r1 = c2;
  *(int *)&prim->r2 = c3;
  *(int *)&prim->r3 = c4;
  SetPolyG4(prim);
  prim->x0 = x;
  prim->y0 = y;
  prim->x1 = x + w;
  prim->y1 = y;
  prim->x2 = x;
  prim->y2 = y + h;
  prim->x3 = x + w;
  prim->y3 = y + h;
  return;
}







void PSXDrawTransGouraudSquare(int x,int y,int w,int h,int opacity,int c1,int c2,int c3,int c4)

{



  int i;
  POLY_G4 *prevPrim;
  POLY_G4 *prim;

  i = 0;
  if (0 < opacity) {
    do {
      prim = (POLY_G4 *)(*(u_char **)0x1F800004);
      prevPrim = (POLY_G4 *)(*(u_char **)0x1F800000);
      i = i + 1;




      ((PSXFront_PTag *)prim)->addr = prevPrim->tag;
      (*(u_char **)0x1F800004) = (u_char *)prim + 0x24;
      ((PSXFront_PTag *)prevPrim)->addr = (uint)prim;
      *(int *)&prim->r0 = c1;
      *(int *)&prim->r1 = c2;
      *(int *)&prim->r2 = c3;
      *(int *)&prim->r3 = c4;
      prim->code = 0x39;
      ((u_char *)prim)[3] = 8;
      *(uint *)&prim->x0 = y << 0x10 | x;
      *(uint *)&prim->x2 = (y + h) << 0x10 | x;
      *(uint *)&prim->x1 = y << 0x10 | (x + w);
      *(uint *)&prim->x3 = (y + h) << 0x10 | (x + w);
    } while (i < opacity);
  }
  return;
}





void PSXDrawTransSquare(int col,int x,int y,int w,int h,short opacity)

{



  short i;
  POLY_F4 *prevPrim;
  POLY_F4 *prim;

  i = 0;
  if (0 < opacity) {
    do {
      prim = (POLY_F4 *)(*(u_char **)0x1F800004);
      prevPrim = (POLY_F4 *)(*(u_char **)0x1F800000);
      i = i + 1;





      ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)prevPrim)->addr;
      (*(u_char **)0x1F800004) = (u_char *)prim + 0x18;
      ((PSXFront_PTag *)prevPrim)->addr = (uint)prim;
      *(int *)&prim->r0 = col;
      prim->code = 0x2a;
      ((u_char *)prim)[3] = 5;
      prim->x0 = x;
      prim->y0 = y;
      prim->x1 = x + w;
      prim->y1 = y;
      prim->x2 = x;
      prim->y2 = y + h;
      prim->x3 = x + w;
      prim->y3 = y + h;
    } while (i < opacity);
  }
  return;
}





void FontUpsideDownBlit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6)

{
# 1258 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\psxfront.cpp"
  u_char *prim;
  u_char *prevPrim;
  int linkAddr;
  int width;
  int height;
  int dv;
  int yoff;
  int ybase;
  int hoff;
  int ytop;

  width = ch->width;
  prim = (*(u_char **)0x1F800004);
  prim[0xc] = u;
  prevPrim = (*(u_char **)0x1F800000);
  height = ch->height;
  yoff = *(signed char *)&ch->yoffset;
  ybase = y - yoff;
  hoff = height + yoff;
  dv = (((*(int *)((int)src + 0xc) << 4) >> 0x14) + v & 0xff) - 1;
  linkAddr = (uint)prim & 0xffffff;
  (*(u_char **)0x1F800004) = prim + 0x28;
  *(uint *)prim = *(uint *)prim & 0xff000000 | *(uint *)prevPrim & 0xffffff;







  *(u_long *)(prim + 4) = font_tint;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  prim[3] = 9;
  prim[7] = 0x2c;
  *(ushort *)(prim + 0xe) = gFontClut;
  *(ushort *)(prim + 0x16) =
       (*(byte *)src & 3) << 7 | (uint)*(int *)((int)src + 0xc) >> 0x14 & 0x10 |
       (*(int *)((int)src + 0xc) & 0x3ff) >> 6;
  prim[0xd] = dv;
  prim[0x15] = dv;
  prim[0x14] = u + width;
  ytop = (ybase + 5) - hoff;
  *(short *)(prim + 0x1a) = ytop;
  prim[0x1c] = u;
  prim[0x1d] = dv + height;
  prim[0x24] = u + width;
  prim[0x25] = dv + height;
  *(short *)(prim + 8) = x;
  *(short *)(prim + 10) = ytop + height;
  *(short *)(prim + 0x10) = x + width;
  *(short *)(prim + 0x12) = ytop + height;
  *(short *)(prim + 0x18) = x;
  *(short *)(prim + 0x20) = x + width;
  *(short *)(prim + 0x22) = ytop;
  return;
}
