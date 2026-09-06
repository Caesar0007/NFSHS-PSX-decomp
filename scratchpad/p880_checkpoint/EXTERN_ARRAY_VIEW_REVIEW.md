# Extern array-view candidates (one syntax family)

100 sites across 37 files.

This inventories extern array declarations with explicit asm linkage labels.
It does not prove each is wrong or active. Genuine native arrays and hardware
views may be legitimate. Each requires native type/storage, ownership and
actual-user/compiler checks before alteration. Other macro-view syntaxes are
outside this lexical inventory. Declaration-audit marker counts do not cover
all these external source views.

| Source | Alias | Target | Declared shape |
| --- | --- | --- | --- |
| recon/eaclib/psx/sndpsxz/salloc.c:58 | sndgs_v | sndgs | unsigned char [] |
| recon/eaclib/psx/sndpsxz/salloc.c:76 | DAT_801478f4_v | DAT_801478f4 | int [] |
| recon/eaclib/psx/sndpsxz/smemman.c:62 | sndmm_b | sndmm | unsigned char [] |
| recon/frontend/common/fecheats.cpp:20 | A_Stats_gTrackRecords | Stats_gTrackRecords | tRecordBuffer [] |
| recon/frontend/common/fecheats.cpp:23 | A_FEApp | FEApp | tFEApplication * [] |
| recon/frontend/common/fecheats.cpp:25 | A_gFECheats | gFECheats | unsigned int [] |
| recon/frontend/common/fecheats.cpp:26 | A_gFEBonus | gFEBonus | unsigned int [] |
| recon/frontend/common/fecredits.cpp:17 | A_FECredits_lastFadeTick | D_80051AA4 | int [] |
| recon/frontend/common/fedialog.cpp:11 | gHelpShapesA | gHelpShapes | tTexture_ShapeInfo * [] |
| recon/frontend/common/fememcard.cpp:78 | Stats_gTrackRecords_arr | Stats_gTrackRecords | int [] |
| recon/frontend/common/fememcard.cpp:82 | ticks_arr | ticks | volatile int [] |
| recon/frontend/common/fememcard.cpp:83 | nomessage_arr | nomessage | int [] |
| recon/frontend/common/fememcard.cpp:84 | MEMCARD_INITIALIZED_arr | MEMCARD_INITIALIZED | int [] |
| recon/frontend/common/fememcard.cpp:85 | CURRENTLYUSINGMEMCARD_arr | CURRENTLYUSINGMEMCARD | int [] |
| recon/frontend/common/fememcard.cpp:86 | MEMCARDFRONTENDISINITTED_arr | MEMCARDFRONTENDISINITTED | int [] |
| recon/frontend/common/femenuoptions.cpp:3002 | menu_kUserNameRowsA | menu_kUserNameRows | short [] |
| recon/frontend/common/femenuoptions.cpp:3038 | FEAppA | FEApp | tFEApplication * [] |
| recon/frontend/common/fescreen.cpp:17 | A_Draw_gPlayer1View | Draw_gPlayer1View | int [] |
| recon/frontend/common/fescreen.cpp:19 | A_screenheight | screenheight | int [] |
| recon/frontend/common/fescreen.cpp:21 | A__7tScreen_fSuppressLoadingText | _7tScreen_fSuppressLoadingText | int [] |
| recon/frontend/common/fetextrender.cpp:26 | gSemiTransText_arr | gSemiTransText | int [] |
| recon/frontend/common/front.cpp:10 | MEMCARDFRONTENDISINITTED_words | MEMCARDFRONTENDISINITTED | int [] |
| recon/frontend/common/screencarselect.cpp:7 | FEAppB | FEApp | tFEApplication * [] |
| recon/frontend/common/screencarselect.cpp:2178 | FEAppA | FEApp | tFEApplication * [] |
| recon/frontend/common/screenmemcard.cpp:10 | A_ticks | ticks | int [] |
| recon/frontend/common/screenmemcard.cpp:12 | A_CURRENTLYUSINGMEMCARD | CURRENTLYUSINGMEMCARD | int [] |
| recon/frontend/common/screenmemcard.cpp:26 | A_GRIDMEMCARD_STARTX | GRIDMEMCARD_STARTX | int [] |
| recon/frontend/common/screenmemcard.cpp:27 | A_GRIDMEMCARD_STARTY | GRIDMEMCARD_STARTY | int [] |
| recon/frontend/common/screenmemcard.cpp:28 | A_MEMCARD_DELTAX | MEMCARD_DELTAX | int [] |
| recon/frontend/common/screenmemcard.cpp:29 | A_MEMCARD_DELTAY | MEMCARD_DELTAY | int [] |
| recon/frontend/common/screenmemcard.cpp:30 | A_EXTRAYATTOP | EXTRAYATTOP | int [] |
| recon/frontend/common/screenmemcard.cpp:31 | A_GRIDMEMCARDGOURAUDBIT_X | GRIDMEMCARDGOURAUDBIT_X | int [] |
| recon/frontend/common/screenmemcard.cpp:32 | A_GRIDMEMCARDGOURAUDBIT_Y | GRIDMEMCARDGOURAUDBIT_Y | int [] |
| recon/frontend/common/screenmemcard.cpp:33 | A_GRIDMEMCARD_WIDTH | GRIDMEMCARD_WIDTH | int [] |
| recon/frontend/common/screenmemcard.cpp:34 | A_GRIDMEMCARD_HEIGHT | GRIDMEMCARD_HEIGHT | int [] |
| recon/frontend/common/screenmemcard.cpp:35 | A_MEMCARDICONOFFX | MEMCARDICONOFFX | int [] |
| recon/frontend/common/screenmemcard.cpp:36 | A_MEMCARDICONOFFY | MEMCARDICONOFFY | int [] |
| recon/frontend/common/screenmemcard.cpp:37 | A_kMemCardMessageX | kMemCardMessageX | int [] |
| recon/frontend/common/screenmemcard.cpp:38 | A_kMemCardMessageY | kMemCardMessageY | int [] |
| recon/frontend/common/screenmemcard.cpp:39 | A_kMemCardMessage1X | kMemCardMessage1X | int [] |
| recon/frontend/common/screenmemcard.cpp:40 | A_kMemCardMessage1Y | kMemCardMessage1Y | int [] |
| recon/frontend/common/screenmemcard.cpp:41 | A_kMemCardMessageH | kMemCardMessageH | int [] |
| recon/frontend/common/screenmemcard.cpp:42 | A_kMemCardMessageH1 | kMemCardMessageH1 | int [] |
| recon/frontend/common/screenpinkslips.cpp:13 | A_FEApp | FEApp | tFEApplication * [] |
| recon/frontend/common/screenpinkslips.cpp:17 | A_ticks | ticks | int [] |
| recon/frontend/common/screentrackrecords.cpp:93 | NewBestLapA | NewBestLap | bool [] |
| recon/frontend/common/screentracks.cpp:433 | FEAppA | FEApp | tFEApplication * [] |
| recon/frontend/common/statchk.cpp:17 | A_NewRecords | NewRecords | int [] |
| recon/frontend/common/statchk.cpp:18 | A_NewBestLap | NewBestLap | int [] |
| recon/frontend/psx/drawshp_externs.h:10 | gHelpShapes_v | gHelpShapes | tTexture_ShapeInfo * [] |
| recon/frontend/psx/mdec_externs.h:12 | ticks_v | ticks | int [] |
| recon/frontend/psx/movie.cpp:26 | loc_v | loc | CdlLOC [] |
| recon/frontend/psx/movie.cpp:27 | StCdIntrFlag_v | StCdIntrFlag | int [] |
| recon/frontend/psx/movie.cpp:28 | user_exit_v | user_exit | short [] |
| recon/frontend/psx/movie.cpp:39 | width_v | width | int [] |
| recon/frontend/psx/movie.cpp:41 | height_v | height | int [] |
| recon/frontend/psx/movie.cpp:43 | PPWTop_v | PPWTop | short [] |
| recon/frontend/psx/movie.cpp:45 | PPWBottom_v | PPWBottom | short [] |
| recon/frontend/psx/movie.cpp:47 | gMode_v | gMode | short [] |
| recon/frontend/psx/movie.cpp:49 | gIsRGB24_v | gIsRGB24 | int [] |
| recon/frontend/psx/movie.cpp:51 | gMovieHeight_v | gMovieHeight | short [] |
| recon/frontend/psx/movie.cpp:53 | gMovieWidth_v | gMovieWidth | short [] |
| recon/frontend/psx/movie.cpp:55 | gMovieFrame_v | gMovieFrame | u_long [] |
| recon/frontend/psx/movie.cpp:56 | gEndFrame_v | gEndFrame | u_long [] |
| recon/frontend/psx/movie.cpp:72 | bMovieLoaded_v | bMovieLoaded | int [] |
| recon/frontend/psx/movie.cpp:73 | bStopMovie_v | bStopMovie | int [] |
| recon/frontend/psx/movie.cpp:74 | bRewindMovie_v | bRewindMovie | int [] |
| recon/frontend/psx/movie.cpp:75 | isFirstSlice_v | isFirstSlice | int [] |
| recon/frontend/psx/movie.cpp:90 | vlcbuf0_v | vlcbuf0 | u_long  * [] |
| recon/frontend/psx/movie.cpp:91 | vlcbuf1_v | vlcbuf1 | u_long  * [] |
| recon/frontend/psx/movie.cpp:92 | imgbuf_v | imgbuf | u_short * [] |
| recon/frontend/psx/movie.cpp:93 | sect_buff_v | sect_buff | u_long  * [] |
| recon/frontend/psx/psxfront_externs.h:104 | gEnviro | gEnviro | PSXFront_DFlipCodegenView [2] |
| recon/frontend/psx/video.cpp:24 | ticks_a | ticks | int [] |
| recon/game/common/aiinit_externs.h:21 | AIInit_leaderBoardCars | leaderBoard | Car_tObj * [] |
| recon/game/common/camera_externs.h:37 | Camera_ReplayCamera | Replay_ReplayCamera | linedef [] |
| recon/game/common/replay_externs.h:51 | StatsTimerPlayer1Cell | StatsTimer | int [1] |
| recon/game/common/replay_externs.h:52 | StatsTimerPlayer2Cell | D_8013D99C | int [1] |
| recon/game/common/speech.cpp:3754 | Speech_vtableTypeName | D_80055BD0 | const char [4] |
| recon/game/common/speech_externs.h:130 | Speaker_vtable | _vt_Q26Speech7Speaker | const __vtbl_ptr_type [] |
| recon/game/common/speech_externs.h:131 | MobileSpeaker_vtable | _vt_Q26Speech13MobileSpeaker | const __vtbl_ptr_type [] |
| recon/game/common/speech_externs.h:132 | DispatchSpeaker_vtable | _vt_Q26Speech15DispatchSpeaker | const __vtbl_ptr_type [] |
| recon/game/psx/cario_externs.h:22 | CarIO_textureName | D_8011E804 | CarIO_textureInfo [51] |
| recon/game/psx/drawc_externs.h:81 | hilight_colors | D_8011F4B4 | u_long [5] |
| recon/game/psx/draww.cpp:5309 | gClutDepth_v | gClutDepth | short [] |
| recon/game/psx/fe3dmenu_externs.h:23 | R3DCar_Clock_v | R3DCar_Clock | int [] |
| recon/game/psx/fe3dmenu_externs.h:24 | R3DCar_ClockLast_v | R3DCar_ClockLast | int [] |
| recon/game/psx/fe3dmenu_externs.h:25 | R3DCar_InMenu_v | R3DCar_InMenu | int [] |
| recon/game/psx/fe3dmenu_externs.h:30 | generic128HzClock_v | generic128HzClock | volatile int [] |
| recon/game/psx/fe3dmenu_externs.h:31 | stackSpeedUpEnbabledFlag_v | stackSpeedUpEnbabledFlag | int [] |
| recon/game/psx/fe3dmenu_externs.h:32 | showRoomFlag_v | showRoomFlag | int [] |
| recon/game/psx/fe3dmenu_externs.h:33 | gWSavePtr_v | gWSavePtr | u_long [] |
| recon/game/psx/hud.cpp:5825 | DashHUD_view | DashHUD_gInfo | int [] |
| recon/game/psx/loading_externs.h:6 | loading_languageNames | D_80120D00 | char          * [] |
| recon/game/psx/overlays.cpp:21 | StatsTimerPlayer1ClampStore | StatsTimer | int [1] |
| recon/game/psx/overlays.cpp:22 | StatsTimerPlayer2ClampStore | D_8013D99C | int [1] |
| recon/game/psx/psxcontroller_externs.h:14 | hoff | D_8013DAC0 | int [] |
| recon/syslib/psx/libetc/INTR_DMA.c:49 | dma_cb | D_8013BD24 | Callback [8] |
| recon/syslib/psx/libetc/INTR_VB.c:46 | vsync_cb | D_80137CF0 | Callback [8] |
| recon/syslib/psx/libgpu/FONT.c:70 | _fnt | Font | struct Font [8] |
