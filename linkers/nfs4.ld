SECTIONS
{
    __romPos = 0;
    _gp = 0x8013C54C;
    PROVIDE(ticksA = ticks);
    header_ROM_START = __romPos;
    header_VRAM = ADDR(.header);
    .header : AT(header_ROM_START) SUBALIGN(16)
    {
        FILL(0x00000000);
        header_DATA_START = .;
        build/asm/header.s.o(.data);
        header_DATA_END = .;
        header_DATA_SIZE = ABSOLUTE(header_DATA_END - header_DATA_START);
    }
    __romPos += SIZEOF(.header);
    header_ROM_END = __romPos;
    header_VRAM_END = .;

    nfs4_ROM_START = __romPos;
    nfs4_VRAM = ADDR(.nfs4);
    /* W65-A5: SUBALIGN(16) -> SUBALIGN(4).  SUBALIGN forces EVERY input
     * section in this region to the given alignment, so it silently pads
     * between the blob PIECES the ownership sweeps cut (front_data since
     * W64-A18, the two rodata blobs now): piece boundaries are 4-aligned,
     * not 16.  With 94 rodata pieces added it stops being latent and ld
     * dies `final link failed: file truncated`.  Retail bases are
     * 4-aligned (catalog 14B), and the group boundaries that really do
     * need 16 are held by the explicit `. = ALIGN(., 16);` statements
     * below.  PROVEN: with SUBALIGN(4) the .nfs4 image built from the 94
     * pieces is byte-identical (238416 B) to the one built from the two
     * un-split control blobs, and both links emit the same 2077
     * diagnostics (scratchpad/w65a5/p6.py). */
    .nfs4 0x80010000 : AT(nfs4_ROM_START) SUBALIGN(4)
    {
        FILL(0x00000000);
        nfs4_RODATA_START = .;
        build/asm/data/rdata_80010000_r00.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j00.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r01.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j01.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r02.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j02.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r03.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j03.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r04.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j04.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j05.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j06.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j07.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r05.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j08.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r06.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j09.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r07.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j10.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r08.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j11.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r09.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j12.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r10.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j13.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r11.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j14.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r12.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j15.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j16.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r13.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_j17.rodata.s.o(.rodata);
        build/asm/data/rdata_80010000_r14.rodata.s.o(.rodata);
        build/src/front.c.o(.rodata);
        build/asm/data/rdata_80054548_r00.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j00.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r01.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j01.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j02.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r02.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j03.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r03.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j04.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r04.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j05.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r05.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j06.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r06.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j07.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j08.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j09.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r07.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j10.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r08.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j11.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j12.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j13.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j14.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r09.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j15.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r10.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j16.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r11.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j17.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r12.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j18.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r13.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j19.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r14.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j20.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j21.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r15.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j22.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r16.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j23.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r17.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j24.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j25.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j26.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r18.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j27.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r19.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j28.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j29.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r20.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j30.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r21.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j31.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r22.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j32.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j33.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r23.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j34.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_r24.rodata.s.o(.rodata);
        build/asm/data/rdata_80054548_j35.rodata.s.o(.rodata);
        build/src/main.c.o(.rodata);
        build/src/*(.rodata);
        . = ALIGN(., 16);
        nfs4_RODATA_END = .;
        nfs4_RODATA_SIZE = ABSOLUTE(nfs4_RODATA_END - nfs4_RODATA_START);
        nfs4_TEXT_START = .;
        build/src/front.c.o(.text);
        build/src/main.c.o(.text);
        /* W67-A5 .text spine BEGIN (generated by scratchpad/w67a5/gen_text_spine.py;
         * order = implied retail base (VA - section offset, mode over each
         * object's .text symbols) -- the W62-A19 spine rule.  Entries
         * marked `interleaver' are the objects probe_link's ABSOLUTE
         * placement would drop (location counter backwards); in this
         * CONTIGUOUS region relative order is all there is, so they sit
         * at their sorted position (the strict spine stays a subsequence).
         * WILDCARD patterns on purpose: an exact filename here would be
         * OPENED AS AN INPUT by the splat link (no object list ->
         * byte-identity would break, W65-A7 absolute-path trap). */
        */src/game/common/minfront.c.o(.text);  /* 0x800128f0 +0x48 */
        */src/game/psx/fe3dmenu.c.o(.text);  /* 0x80012938 +0x668 */
        */src/frontend/common/feapp.c.o(.text);  /* 0x80012fa0 +0x27c0 */
        */src/frontend/common/feaudio.c.o(.text);  /* 0x80015780 +0xa30 */
        */src/frontend/common/fecars.c.o(.text);  /* 0x800161b0 +0x2518 */
        */src/frontend/common/fedialog.c.o(.text);  /* 0x800186c8 +0x1940 */
        */src/frontend/common/femenuextended.c.o(.text);  /* 0x8001a018 +0x1f58 */
        */src/frontend/common/femenuoptions.c.o(.text);  /* 0x8001bf48 +0x4d78 interleaver */
        */src/frontend/common/fetextrender.c.o(.text);  /* 0x80020cd8 +0xd38 */
        */src/frontend/common/fetracks.c.o(.text);  /* 0x80021a10 +0x5e8 */
        */src/frontend/common/fetv.c.o(.text);  /* 0x80021ff8 +0x1248 */
        */src/frontend/common/fecheats.c.o(.text);  /* 0x80023410 +0x658 */
        */src/frontend/common/feinput.c.o(.text);  /* 0x80023898 +0x538 interleaver */
        */src/frontend/common/femenu.c.o(.text);  /* 0x80023dd0 +0x1ce8 */
        */src/frontend/common/fescreen.c.o(.text);  /* 0x80025ab8 +0xe38 */
        */src/frontend/common/fetools.c.o(.text);  /* 0x800268f0 +0x568 */
        */src/frontend/common/front.c.o(.text);  /* 0x80026e58 +0x5288 */
        */src/frontend/common/femenudefs.c.o(.text);  /* 0x8002c1f0 +0x6148 */
        */src/frontend/common/fetourn.c.o(.text);  /* 0x800327b8 +0x1e38 */
        */src/frontend/common/fememcard.c.o(.text);  /* 0x8003351c +0x1868 interleaver */
        */src/frontend/common/femission.c.o(.text);  /* 0x80034060 +0x240 interleaver */
        */src/frontend/common/fecredits.c.o(.text);  /* 0x80035ae8 +0xca8 */
        */src/frontend/common/fevideowall.c.o(.text);  /* 0x80036790 +0x790 */
        */src/frontend/common/screenmain.c.o(.text);  /* 0x80036f20 +0x1c48 */
        */src/frontend/common/screenpinkslips.c.o(.text);  /* 0x80038b68 +0xc88 */
        */src/frontend/common/screenpost.c.o(.text);  /* 0x800397f0 +0x1100 */
        */src/frontend/common/screencarselect.c.o(.text);  /* 0x8003ab88 +0x4e88 */
        */src/frontend/common/screentournselect.c.o(.text);  /* 0x8003f778 +0xdf8 interleaver */
        */src/frontend/common/screentrophyroom.c.o(.text);  /* 0x80040570 +0xa98 */
        */src/frontend/common/screentrophyinfo.c.o(.text);  /* 0x80041008 +0x5f8 */
        */src/frontend/common/screentracks.c.o(.text);  /* 0x80041600 +0xbf8 */
        */src/frontend/common/screentrackinfo.c.o(.text);  /* 0x800421f8 +0x450 */
        */src/frontend/common/screentrackrecords.c.o(.text);  /* 0x80042648 +0xad0 */
        */src/frontend/common/screencontroller.c.o(.text);  /* 0x80043118 +0x2838 */
        */src/frontend/common/screendisplay.c.o(.text);  /* 0x80045950 +0xd8 */
        */src/frontend/common/screenaudio.c.o(.text);  /* 0x80045a28 +0x8f8 */
        */src/frontend/common/screenmemcard.c.o(.text);  /* 0x80046320 +0x1b40 */
        */src/frontend/common/screencongrats.c.o(.text);  /* 0x80047e48 +0x19e0 interleaver */
        */src/frontend/common/statchk.c.o(.text);  /* 0x80049840 +0x1028 */
        */src/frontend/common/stattool.c.o(.text);  /* 0x8004a868 +0x720 */
        */src/frontend/common/screenusername.c.o(.text);  /* 0x8004af88 +0x870 */
        */src/frontend/common/fefades.c.o(.text);  /* 0x8004b7f8 +0x340 */
        */src/frontend/common/felines.c.o(.text);  /* 0x8004bb38 +0x2c8 */
        */src/frontend/psx/drawshp.c.o(.text);  /* 0x8004be00 +0x808 */
        */src/frontend/psx/movie.c.o(.text);  /* 0x8004c608 +0x10d0 */
        */src/frontend/psx/mmeffect.c.o(.text);  /* 0x8004d6d8 +0xa0 */
        */src/frontend/psx/psxfront.c.o(.text);  /* 0x8004d778 +0x1988 */
        */src/frontend/psx/fetexture.c.o(.text);  /* 0x8004f100 +0x2e0 */
        */src/frontend/psx/memcard.c.o(.text);  /* 0x8004f3e0 +0x1498 */
        */src/frontend/common/mcrd.c.o(.text);  /* 0x80050244 +0x48 interleaver */
        */src/frontend/psx/mdec.c.o(.text);  /* 0x800508c0 +0x408 */
        */src/frontend/psx/video.c.o(.text);  /* 0x80050cc8 +0x598 */
        */src/game/common/ai.c.o(.text);  /* 0x80057994 +0x30ac */
        */src/game/common/aidelaycar.c.o(.text);  /* 0x8005aa28 +0x36c interleaver */
        */src/game/common/aihigh.c.o(.text);  /* 0x8005ad94 +0x76c */
        */src/game/common/aih_basicperp.c.o(.text);  /* 0x8005b500 +0xc64 */
        */src/game/common/aih_basiccop.c.o(.text);  /* 0x8005c164 +0xa08 */
        */src/game/common/aih_btccop.c.o(.text);  /* 0x8005cb90 +0x2b48 */
        */src/game/common/aih_btcperp.c.o(.text);  /* 0x8005f6b4 +0x1d4c interleaver */
        */src/game/common/aih_play.c.o(.text);  /* 0x80061400 +0x1e70 */
        */src/game/common/aih_hum.c.o(.text);  /* 0x80063270 +0x98 */
        */src/game/common/aih_opp.c.o(.text);  /* 0x80063308 +0x8f8 */
        */src/game/common/aih_cop.c.o(.text);  /* 0x80063c00 +0x208c */
        */src/game/common/aih_traf.c.o(.text);  /* 0x80065c8c +0xd20 */
        */src/game/common/aicop.c.o(.text);  /* 0x800669ac +0x204 */
        */src/aiinit.c.o(.text);  /* 0x80066d20 +0xaa0 */
        */src/game/common/ailife.c.o(.text);  /* 0x80067650 +0x1398 interleaver */
        */src/aiphysic.c.o(.text);  /* 0x800685b4 +0x3bec */
        */src/aiperson.c.o(.text);  /* 0x80068a34 +0x850 interleaver */
        */src/aidatarecord.c.o(.text);  /* 0x8006ce24 +0x790 */
        */src/game/common/aispeeds.c.o(.text);  /* 0x8006d5c0 +0x2144 */
        */src/aiscript.c.o(.text);  /* 0x8006f700 +0x2ac interleaver */
        */src/game/common/aistate.c.o(.text);  /* 0x8006f9c8 +0x2ec8 */
        */src/game/common/aitriger.c.o(.text);  /* 0x8007286c +0x5fc interleaver */
        */src/aitune.c.o(.text);  /* 0x80072ec0 +0x128 */
        */src/game/common/AIWORLD.c.o(.text);  /* 0x80072fc4 +0xb04 interleaver */
        */src/game/common/anim.c.o(.text);  /* 0x80073a94 +0xc9c */
        */src/game/common/audioclc.c.o(.text);  /* 0x80074738 +0x1cf0 */
        */src/game/common/audiocmn.c.o(.text);  /* 0x800769d4 +0x3ad4 */
        */src/game/common/audiomus.c.o(.text);  /* 0x80079ef4 +0x1638 interleaver */
        */src/game/common/audedit.c.o(.text);  /* 0x8007b52c +0x7c */
        */src/game/common/audioeng.c.o(.text);  /* 0x8007b5a8 +0x106c */
        */src/game/common/audiotrk.c.o(.text);  /* 0x8007c614 +0xfb0 */
        */src/game/common/bworld.c.o(.text);  /* 0x8007d5c4 +0x134c */
        */src/game/common/bworldSm.c.o(.text);  /* 0x8007e918 +0x1cfc */
        */src/game/common/camera.c.o(.text);  /* 0x8008060c +0x5778 interleaver */
        */src/game/common/cars.c.o(.text);  /* 0x80085dd0 +0x5678 */
        */src/game/common/chunk.c.o(.text);  /* 0x8008b920 +0x53c */
        */src/game/common/clock.c.o(.text);  /* 0x8008b938 +0x138 interleaver */
        */src/game/common/collide.c.o(.text);  /* 0x8008ba70 +0x6450 interleaver */
        */src/game/common/color.c.o(.text);  /* 0x80091ec0 +0x11c */
        */src/game/common/control.c.o(.text);  /* 0x80091fe4 +0x488 */
        */src/game/common/hudpmx.c.o(.text);  /* 0x800924dc +0xaf0 */
        */src/game/common/spchevnt.c.o(.text);  /* 0x80092f54 +0x1394 interleaver */
        */src/game/common/speech.c.o(.text);  /* 0x800942e8 +0x50f4 */
        */src/game/common/copspeak.c.o(.text);  /* 0x80099504 +0x1ae0 */
        */src/game/common/dashhud.c.o(.text);  /* 0x8009aebc +0x50c interleaver */
        */src/game/common/fastrand.c.o(.text);  /* 0x8009b3d0 +0x90 */
        */src/game/common/genericpmx.c.o(.text);  /* 0x8009b458 +0x944 interleaver */
        */src/game/common/gmesetup.c.o(.text);  /* 0x8009bd9c +0x38c */
        */src/game/common/group.c.o(.text);  /* 0x8009c128 +0x21c */
        */src/game/common/input.c.o(.text);  /* 0x8009c344 +0x10a0 */
        */src/game/common/mathnfs.c.o(.text);  /* 0x8009d3e4 +0xaf0 */
        */src/game/common/mpause.c.o(.text);  /* 0x8009e3e8 +0x1058 */
        */src/game/common/newton.c.o(.text);  /* 0x8009ef2c +0x4e30 interleaver */
        */src/game/common/new.c.o(.text);  /* 0x800a3d5c +0x90 */
        */src/game/common/nfs3.c.o(.text);  /* 0x800a408c +0xcf8 */
        */src/game/common/object.c.o(.text);  /* 0x800a4ae4 +0x2330 interleaver */
        */src/game/common/paths.c.o(.text);  /* 0x800a6e14 +0x4c */
        */src/game/common/pausemenu.c.o(.text);  /* 0x800a6eb0 +0x1868 */
        */src/game/common/physics.c.o(.text);  /* 0x800a86d0 +0x4f00 interleaver */
        */src/game/common/quatern.c.o(.text);  /* 0x800ad5c8 +0x664 */
        */src/game/common/r3dcar.c.o(.text);  /* 0x800adc2c +0x5480 */
        */src/game/common/render.c.o(.text);  /* 0x800b30b4 +0xba0 */
        */src/game/common/replay.c.o(.text);  /* 0x800b3c4c +0x2330 interleaver */
        */src/game/common/scene.c.o(.text);  /* 0x800b5f7c +0x240 */
        */src/game/common/schedule.c.o(.text);  /* 0x800b61bc +0x3b8 */
        */src/game/common/sim.c.o(.text);  /* 0x800b6574 +0xcdc */
        */src/game/common/simplemem.c.o(.text);  /* 0x800b7250 +0x9c */
        */src/game/common/simqueue.c.o(.text);  /* 0x800b72ec +0x360 */
        */src/game/common/souffle.c.o(.text);  /* 0x800b764c +0x90c */
        */src/game/common/stats.c.o(.text);  /* 0x800b7f58 +0x1200 */
        */src/game/common/textsys.c.o(.text);  /* 0x800b9158 +0x1a0 */
        */src/game/common/track.c.o(.text);  /* 0x800b92f8 +0x1d70 */
        */src/game/common/trgsfx.c.o(.text);  /* 0x800bb068 +0x9a0 */
        */src/game/common/udff.c.o(.text);  /* 0x800bba08 +0x17c */
        */src/game/psx/audio.c.o(.text);  /* 0x800bbb84 +0x38c */
        */src/game/psx/cario.c.o(.text);  /* 0x800bbf10 +0x14b0 */
        */src/game/psx/device.c.o(.text);  /* 0x800bd3c0 +0x700 */
        */src/game/psx/draw.c.o(.text);  /* 0x800bdac0 +0xc10 */
        */src/game/psx/drawc.c.o(.text);  /* 0x800be6f0 +0x6958 */
        */src/game/psx/draww.c.o(.text);  /* 0x800c5028 +0x5970 interleaver */
        */src/game/psx/force.c.o(.text);  /* 0x800ca998 +0x874 */
        */src/game/psx/font.c.o(.text);  /* 0x800cb2ac +0xaa4 */
        */src/game/psx/flare.c.o(.text);  /* 0x800cbccc +0x38c4 interleaver */
        */src/game/psx/hrzsku.c.o(.text);  /* 0x800cf78c +0x250c */
        */src/game/psx/hud.c.o(.text);  /* 0x800d1bbc +0x7ee8 interleaver */
        */src/game/psx/overlays.c.o(.text);  /* 0x800d9968 +0x1750 */
        */src/game/psx/loading.c.o(.text);  /* 0x800db0b8 +0x260 */
        */src/game/psx/night.c.o(.text);  /* 0x800db318 +0xfa0 */
        */src/game/psx/platform.c.o(.text);  /* 0x800dc2b8 +0x214 */
        */src/game/psx/psxcontroller.c.o(.text);  /* 0x800dc4cc +0x9f8 */
        */src/game/psx/rpause.c.o(.text);  /* 0x800dcec4 +0x18c */
        */src/game/psx/sfx.c.o(.text);  /* 0x800dd050 +0x16a4 */
        */src/game/psx/skidmark.c.o(.text);  /* 0x800de6f4 +0xec0 */
        */src/game/psx/texture.c.o(.text);  /* 0x800df5b4 +0x12d0 */
        */src/game/psx/textureprocess.c.o(.text);  /* 0x800e0884 +0xcc0 */
        */src/game/psx/trackspec.c.o(.text);  /* 0x800e1544 +0x3e8 */
        */src/game/psx/trsproj.c.o(.text);  /* 0x800e192c +0x494 */
        */src/game/psx/weather.c.o(.text);  /* 0x800e1dd0 +0x1fcc */
        */src/game/psx/textpix.c.o(.text);  /* 0x800e3d8c +0xb4 interleaver */
        */src/game/psx/textpsx.c.o(.text);  /* 0x800e3e48 +0x28 */
        */src/game/psx/unpack.c.o(.text);  /* 0x800e3e68 +0x1bc interleaver */
        */src/syslib/psx/2mbyte/2mbyte.c.o(.text);  /* 0x800e402c +0xc4 */
        */src/eaclib/psx/pad.c.o(.text);  /* 0x800e40e8 +0x230 interleaver */
        */src/syslib/psx/libc/C43.c.o(.text);  /* 0x800e4318 +0x10 */
        */src/eaclib/psx/eacpsxz/fixdmult.c.o(.text);  /* 0x800e4328 +0x2c */
        */src/syslib/psx/libsn/PUREV.c.o(.text);  /* 0x800e4354 +0x4 */
        */src/eaclib/psx/eacpsxz/trnspos.c.o(.text);  /* 0x800e4358 +0xac */
        */src/eaclib/psx/eacpsxz/fixddiv.c.o(.text);  /* 0x800e4404 +0xa8 */
        */src/syslib/psx/libapi/A39.c.o(.text);  /* 0x800e44ac +0x10 */
        */src/syslib/psx/libc/SPRINTF.c.o(.text);  /* 0x800e44bc +0x890 */
        */src/eaclib/psx/eacpsxz/memstd.c.o(.text);  /* 0x800e4d74 +0x8bc */
        */src/eaclib/psx/eacpsxz/nsync.c.o(.text);  /* 0x800e5608 +0x4bc interleaver */
        */src/syslib/psx/libc/C25.c.o(.text);  /* 0x800e5b28 +0x10 */
        */src/eaclib/psx/eacpsxz/atanfunc.c.o(.text);  /* 0x800e5b38 +0x12c */
        */src/eaclib/psx/eacpsxz/nloadpk.c.o(.text);  /* 0x800e5c64 +0x118 */
        */src/syslib/psx/libc/C23.c.o(.text);  /* 0x800e5d7c +0x10 */
        */src/syslib/psx/libc/QSORT.c.o(.text);  /* 0x800e5d8c +0x190 */
        */src/eaclib/psx/eacpsxz/locatbig.c.o(.text);  /* 0x800e5ea8 +0x3b0 interleaver */
        */src/syslib/psx/libc/C36.c.o(.text);  /* 0x800e62cc +0x10 */
        */src/eaclib/psx/eacpsxz/blkmov.c.o(.text);  /* 0x800e62dc +0x31c */
        */src/eaclib/psx/sndpsxz/sbremove.c.o(.text);  /* 0x800e65f8 +0x23c */
        */src/eaclib/psx/sndpsxz/splysdef.c.o(.text);  /* 0x800e6834 +0x50 */
        */src/eaclib/psx/sndpsxz/span.c.o(.text);  /* 0x800e6884 +0x14c */
        */src/eaclib/psx/sndpsxz/svol.c.o(.text);  /* 0x800e69d0 +0x124 */
        */src/eaclib/psx/eacpsxz/systask.c.o(.text);  /* 0x800e6af4 +0x1fc */
        */src/eaclib/psx/sndpsxz/sstsetpr.c.o(.text);  /* 0x800e6cf0 +0x68 */
        */src/eaclib/psx/sndpsxz/seffect.c.o(.text);  /* 0x800e6d58 +0x130 */
        */src/eaclib/psx/spchpsxz/spchevnt.c.o(.text);  /* 0x800e6ec4 +0x8f8 */
        */src/eaclib/psx/eacpsxz/random.c.o(.text);  /* 0x800e77a8 +0x140 interleaver */
        */src/syslib/psx/libc/C21.c.o(.text);  /* 0x800e78e8 +0x10 */
        */src/eaclib/psx/sndpsxz/sbend.c.o(.text);  /* 0x800e78f8 +0x138 */
        */src/eaclib/psx/sndpsxz/splay.c.o(.text);  /* 0x800e7a30 +0xe4 */
        */src/eaclib/psx/sndpsxz/sover.c.o(.text);  /* 0x800e7b14 +0x50 */
        */src/eaclib/psx/sndpsxz/sbhdrsze.c.o(.text);  /* 0x800e7b64 +0x44 */
        */src/eaclib/psx/sndpsxz/sbhdrcpy.c.o(.text);  /* 0x800e7ba8 +0x144 */
        */src/eaclib/psx/sndpsxz/sdmemlu.c.o(.text);  /* 0x800e7cec +0x100 */
        */src/eaclib/psx/sndpsxz/sbadd.c.o(.text);  /* 0x800e7dec +0x94 */
        */src/eaclib/psx/sndpsxz/sstop.c.o(.text);  /* 0x800e7e80 +0x88 */
        */src/eaclib/psx/sndpsxz/spitch.c.o(.text);  /* 0x800e7f08 +0xe8 */
        */src/eaclib/psx/sndpsxz/smasterv.c.o(.text);  /* 0x800e7ff0 +0xd4 */
        */src/syslib/psx/libc/A63.c.o(.text);  /* 0x800e80cc +0x18 */
        */src/eaclib/psx/sndpsxz/s3dlow.c.o(.text);  /* 0x800e80e4 +0xc4 */
        */src/eaclib/psx/sndpsxz/sstopall.c.o(.text);  /* 0x800e81a8 +0x78 */
        */src/eaclib/psx/eacpsxz/timer.c.o(.text);  /* 0x800e8230 +0xb0 */
        */src/eaclib/psx/sndpsxz/sautovol.c.o(.text);  /* 0x800e82d0 +0x11c interleaver */
        */src/eaclib/psx/sndpsxz/sstgetv.c.o(.text);  /* 0x800e83ec +0x5c */
        */src/syslib/psx/libcd/TYPE.c.o(.text);  /* 0x800e8448 +0x290 */
        */src/eaclib/psx/sndpsxz/sststat.c.o(.text);  /* 0x800e86d8 +0xf8 */
        */src/eaclib/psx/sndpsxz/sstrstat.c.o(.text);  /* 0x800e87d0 +0x170 */
        */src/eaclib/psx/eacpsxz/wildcard.c.o(.text);  /* 0x800e89bc +0x2d4 */
        */src/eaclib/psx/sndpsxz/sst.c.o(.text);  /* 0x800e8c14 +0xf30 interleaver */
        */src/eaclib/psx/sndpsxz/spvoices.c.o(.text);  /* 0x800e9b44 +0x1ec */
        */src/eaclib/psx/sndpsxz/sstsetgl.c.o(.text);  /* 0x800e9d30 +0x5c */
        */src/eaclib/psx/sndpsxz/sstsetgs.c.o(.text);  /* 0x800e9d8c +0x5c */
        */src/eaclib/psx/sndpsxz/sstautov.c.o(.text);  /* 0x800e9de8 +0x88 */
        */src/syslib/psx/libapi/COUNTER.c.o(.text);  /* 0x800e9e70 +0x104 */
        */src/syslib/psx/libc/C27.c.o(.text);  /* 0x800e9f74 +0x10 */
        */src/eaclib/psx/sndpsxz/slimits.c.o(.text);  /* 0x800e9f84 +0xd0 */
        */src/eaclib/psx/sndpsxz/sstovrhd.c.o(.text);  /* 0x800ea054 +0x84 */
        */src/eaclib/psx/sndpsxz/sstvol.c.o(.text);  /* 0x800ea0d8 +0x60 */
        */src/eaclib/psx/sndpsxz/sserver.c.o(.text);  /* 0x800ea138 +0x594 */
        */src/eaclib/psx/eacpsxz/syncfile.c.o(.text);  /* 0x800ea8a8 +0x3f8 */
        */src/syslib/psx/libc/C42.c.o(.text);  /* 0x800eaac4 +0x10 interleaver */
        */src/syslib/psx/libc/C47.c.o(.text);  /* 0x800eaad4 +0x10 interleaver */
        */src/eaclib/psx/eacpsxz/crossprd.c.o(.text);  /* 0x800eaae4 +0xb8 interleaver */
        */src/eaclib/psx/eacpsxz/xform.c.o(.text);  /* 0x800eab48 +0x190 interleaver */
        */src/syslib/psx/libgte/REG13.c.o(.text);  /* 0x800eab9c +0x10 interleaver */
        */src/eaclib/psx/eacpsxz/asinfunc.c.o(.text);  /* 0x800eacd8 +0xe4 */
        */src/eaclib/psx/eacpsxz/isincos.c.o(.text);  /* 0x800eadbc +0x11c */
        */src/eaclib/psx/eacpsxz/trnsfrm.c.o(.text);  /* 0x800eaed8 +0x110 */
        */src/eaclib/psx/eacpsxz/addtimer.c.o(.text);  /* 0x800eafe8 +0x98 */
        */src/eaclib/psx/eacpsxz/savegp.c.o(.text);  /* 0x800eb080 +0x2c */
        */src/eaclib/psx/eacpsxz/fixdsqrt.c.o(.text);  /* 0x800eb0ac +0x54 */
        */src/syslib/psx/libc/C16.c.o(.text);  /* 0x800eb100 +0x10 */
        */src/eaclib/psx/eacpsxz/locatshp.c.o(.text);  /* 0x800eb110 +0xc0 */
        */src/syslib/psx/libc/C24.c.o(.text);  /* 0x800eb1d0 +0x10 */
        */src/eaclib/psx/spchpsxz/spchbank.c.o(.text);  /* 0x800eb1e0 +0x3c4 */
        */src/eaclib/psx/spchpsxz/spchinit.c.o(.text);  /* 0x800eb5a4 +0x240 */
        */src/syslib/psx/libmath/FLTSIDF.c.o(.text);  /* 0x800eb7e4 +0x100 */
        */src/syslib/psx/libmath/LTDF2.c.o(.text);  /* 0x800eb8e4 +0xe0 */
        */src/eaclib/psx/spchpsxz/spchrand.c.o(.text);  /* 0x800eb9c4 +0x210 */
        */src/eaclib/psx/spchpsxz/spchrslv.c.o(.text);  /* 0x800ebbd4 +0x20 */
        */src/eaclib/psx/eacpsxz/nfile.c.o(.text);  /* 0x800ec0d4 +0x1744 */
        */src/eaclib/psx/sndpsxz/stimerem.c.o(.text);  /* 0x800ed338 +0xb4 interleaver */
        */src/eaclib/psx/eacpsxz/fixdinv.c.o(.text);  /* 0x800ed3ec +0x38 interleaver */
        */src/eaclib/psx/eacpsxz/fixdsin.c.o(.text);  /* 0x800ed424 +0x104 interleaver */
        */src/eaclib/psx/eacpsxz/fixdatan.c.o(.text);  /* 0x800ed528 +0x148 interleaver */
        */src/syslib/psx/libgpu/SYS.c.o(.text);  /* 0x800ed574 +0x27f0 interleaver */
        */src/syslib/psx/libpad/PADENTRY.c.o(.text);  /* 0x800efe60 +0x39c */
        */src/eaclib/psx/eacpsxz/matrix.c.o(.text);  /* 0x800f01fc +0x318 */
        */src/syslib/psx/libmath/GTDF2.c.o(.text);  /* 0x800f0514 +0xe0 */
        */src/eaclib/psx/eacpsxz/primate.c.o(.text);  /* 0x800f05f4 +0x144 */
        */src/eaclib/psx/eacpsxz/movf.c.o(.text);  /* 0x800f0738 +0x374 */
        */src/eaclib/psx/eacpsxz/shpsubs.c.o(.text);  /* 0x800f0ab8 +0x70 */
        */src/eaclib/psx/eacpsxz/nasync.c.o(.text);  /* 0x800f11b0 +0xc54 */
        */src/syslib/psx/libetc/VMODE.c.o(.text);  /* 0x800f1770 +0x30 interleaver */
        */src/eaclib/psx/eacpsxz/blkfill.c.o(.text);  /* 0x800f17a4 +0x144 interleaver */
        */src/eaclib/psx/eacpsxz/sinfunc.c.o(.text);  /* 0x800f18e4 +0x6c interleaver */
        */src/eaclib/psx/eacpsxz/resize.c.o(.text);  /* 0x800f1950 +0x178 interleaver */
        */src/syslib/psx/libgte/MSC02.c.o(.text);  /* 0x800f1ac8 +0x134 interleaver */
        */src/syslib/psx/libgpu/P00.c.o(.text);  /* 0x800f1bfc +0x40 interleaver */
        */src/eaclib/psx/eacpsxz/loadshp.c.o(.text);  /* 0x800f1c3c +0xbc interleaver */
        */src/eaclib/psx/eacpsxz/exit.c.o(.text);  /* 0x800f1cf8 +0x60 interleaver */
        */src/eaclib/psx/sndpsxz/ssysinit.c.o(.text);  /* 0x800f1d58 +0x3d8 interleaver */
        */src/eaclib/psx/sndpsxz/ssysreal.c.o(.text);  /* 0x800f2130 +0x6c */
        */src/syslib/psx/libgte/MSC00.c.o(.text);  /* 0x800f21a4 +0x88 */
        */src/syslib/psx/libgpu/EXT.c.o(.text);  /* 0x800f222c +0xf0 */
        */src/syslib/psx/libetc/VSYNC.c.o(.text);  /* 0x800f231c +0x210 */
        */src/syslib/psx/libgte/FGO_01.c.o(.text);  /* 0x800f252c +0x290 */
        */src/syslib/psx/libgte/REG11.c.o(.text);  /* 0x800f27bc +0x20 */
        */src/syslib/psx/libgte/FOG_01.c.o(.text);  /* 0x800f27dc +0x70 */
        */src/syslib/psx/libetc/INTR.c.o(.text);  /* 0x800f284c +0x648 */
        */src/eaclib/psx/eacpsxz/setfont.c.o(.text);  /* 0x800f2e94 +0x190 */
        */src/eaclib/psx/eacpsxz/getm.c.o(.text);  /* 0x800f3024 +0x88 */
        */src/eaclib/psx/eacpsxz/textcrnt.c.o(.text);  /* 0x800f30ac +0x50 */
        */src/syslib/psx/libgpu/P10.c.o(.text);  /* 0x800f30fc +0x30 */
        */src/syslib/psx/libgte/FGO_06.c.o(.text);  /* 0x800f312c +0x1a0 */
        */src/eaclib/psx/eacpsxz/isqrt.c.o(.text);  /* 0x800f32cc +0x1c4 */
        */src/syslib/psx/libgpu/P19.c.o(.text);  /* 0x800f3490 +0x20 */
        */src/syslib/psx/libmath/MULSF3.c.o(.text);  /* 0x800f34b0 +0x140 */
        */src/syslib/psx/libgpu/P12.c.o(.text);  /* 0x800f35f0 +0x20 */
        */src/syslib/psx/libgpu/P16.c.o(.text);  /* 0x800f3610 +0x20 */
        */src/syslib/psx/libgpu/P18.c.o(.text);  /* 0x800f3630 +0x20 */
        */src/syslib/psx/libgpu/P17.c.o(.text);  /* 0x800f3650 +0x20 */
        */src/eaclib/psx/eacpsxz/fsincos.c.o(.text);  /* 0x800f3670 +0xb8 */
        */src/syslib/psx/libgte/COR_02.c.o(.text);  /* 0x800f3728 +0xd0 */
        */src/syslib/psx/libgte/COR_03.c.o(.text);  /* 0x800f37f8 +0x140 */
        */src/syslib/psx/libmath/FIXSFSI.c.o(.text);  /* 0x800f3938 +0xc0 */
        */src/eaclib/psx/eacpsxz/joystkn.c.o(.text);  /* 0x800f39f8 +0x3c */
        */src/eaclib/psx/eacpsxz/fileroot.c.o(.text);  /* 0x800f3a34 +0x744 */
        */src/eaclib/psx/eacpsxz/meminit.c.o(.text);  /* 0x800f4178 +0x8 */
        */src/eaclib/psx/eacpsxz/inittmr.c.o(.text);  /* 0x800f4180 +0x254 */
        */src/syslib/psx/libapi/C68.c.o(.text);  /* 0x800f43d4 +0x10 */
        */src/eaclib/psx/eacpsxz/shpdepth.c.o(.text);  /* 0x800f43e4 +0x6c */
        */src/syslib/psx/libgpu/P01.c.o(.text);  /* 0x800f4450 +0x20 */
        */src/eaclib/psx/eacpsxz/textfor.c.o(.text);  /* 0x800f4510 +0x12c */
        */src/eaclib/psx/eacpsxz/unhuff.c.o(.text);  /* 0x800f459c +0xd1c interleaver */
        */src/eaclib/psx/eacpsxz/unref.c.o(.text);  /* 0x800f52b8 +0x2fc */
        */src/eaclib/psx/eacpsxz/unbtree.c.o(.text);  /* 0x800f55b4 +0x210 */
        */src/syslib/psx/libmath/EXTSFDF2.c.o(.text);  /* 0x800f57c4 +0x160 */
        */src/syslib/psx/libmath/TRUDFSF2.c.o(.text);  /* 0x800f5924 +0x130 */
        */src/syslib/psx/libmath/ADDDF3.c.o(.text);  /* 0x800f5a54 +0x380 */
        */src/syslib/psx/libmath/DIVDF3.c.o(.text);  /* 0x800f60b4 +0x330 */
        */src/syslib/psx/libc/C26.c.o(.text);  /* 0x800f6104 +0x10 interleaver */
        */src/eaclib/psx/eacpsxz/nullfunc.c.o(.text);  /* 0x800f6114 +0x8 interleaver */
        */src/syslib/psx/libgpu/P11.c.o(.text);  /* 0x800f611c +0x30 interleaver */
        */src/eaclib/psx/eacpsxz/crc.c.o(.text);  /* 0x800f614c +0xc8 interleaver */
        */src/syslib/psx/libc/C30.c.o(.text);  /* 0x800f6214 +0x10 interleaver */
        */src/syslib/psx/libmath/FLTSISF.c.o(.text);  /* 0x800f6224 +0xc0 interleaver */
        */src/syslib/psx/libmath/MULDF3.c.o(.text);  /* 0x800f65f8 +0x400 */
        */src/syslib/psx/libmath/DIVSF3.c.o(.text);  /* 0x800f66e4 +0x150 interleaver */
        */src/syslib/psx/libmath/FIXDFSI.c.o(.text);  /* 0x800f6834 +0x100 interleaver */
        */src/eaclib/psx/eacpsxz/vramfxya.c.o(.text);  /* 0x800f6960 +0x308 interleaver */
        */src/eaclib/psx/eacpsxz/shpclut.c.o(.text);  /* 0x800f6c3c +0xdc */
        */src/syslib/psx/libgpu/FONT.c.o(.text);  /* 0x800f6d18 +0x6e8 */
        */src/syslib/psx/libpress/VLC.c.o(.text);  /* 0x800f7400 +0x380 */
        */src/syslib/psx/libcd/cdcont.c.o(.text);  /* 0x800f7780 +0x6f8 */
        */src/syslib/psx/libcd/stcdint.c.o(.text);  /* 0x800f7e78 +0xaf0 */
        */src/syslib/psx/libpress/LIBPRESS.c.o(.text);  /* 0x800f89c8 +0x500 */
        */src/syslib/psx/libcd/cdread2.c.o(.text);  /* 0x800f8f48 +0xb0 */
        */src/syslib/psx/libcd/stream.c.o(.text);  /* 0x800f8ff8 +0x120 */
        */src/syslib/psx/libcd/iso9660.c.o(.text);  /* 0x800f9014 +0x970 interleaver */
        */src/eaclib/psx/eacpsxz/cdfs.c.o(.text);  /* 0x800f9d50 +0xeac */
        */src/eaclib/psx/sndpsxz/scdvol.c.o(.text);  /* 0x800faa44 +0x68 interleaver */
        */src/syslib/psx/libmcrd/LIBMCRD.c.o(.text);  /* 0x800faaac +0x17a4 interleaver */
        */src/eaclib/psx/eacpsxz/cluttype.c.o(.text);  /* 0x800fc250 +0x44 */
        */src/eaclib/psx/eacpsxz/shptype.c.o(.text);  /* 0x800fc294 +0x64 */
        */src/eaclib/psx/eacpsxz/stream.c.o(.text);  /* 0x800fcde0 +0x1a20 */
        */src/syslib/psx/libapi/C57.c.o(.text);  /* 0x800fdd18 +0x10 interleaver */
        */src/syslib/psx/libpad/PADPORTD.c.o(.text);  /* 0x800fdd28 +0x660 interleaver */
        */src/syslib/psx/libc/C46.c.o(.text);  /* 0x800fe388 +0x10 interleaver */
        */src/syslib/psx/libc/MEMMOVE.c.o(.text);  /* 0x800fe398 +0x70 interleaver */
        */src/eaclib/psx/eacpsxz/threads.c.o(.text);  /* 0x800fe408 +0x1c interleaver */
        */src/eaclib/psx/eacpsxz/callback.c.o(.text);  /* 0x800fe424 +0x64 interleaver */
        */src/eaclib/psx/eacpsxz/math64a.c.o(.text);  /* 0x800fe488 +0x98 interleaver */
        */src/eaclib/psx/eacpsxz/stricmp.c.o(.text);  /* 0x800fe520 +0x74 interleaver */
        */src/eaclib/psx/sndpsxz/sdata.c.o(.text);  /* 0x800fe594 +0x20 interleaver */
        */src/eaclib/psx/sndpsxz/sbirmpat.c.o(.text);  /* 0x800fe5b4 +0x108 interleaver */
        */src/eaclib/psx/sndpsxz/sbvalid.c.o(.text);  /* 0x800fe6bc +0x68 interleaver */
        */src/eaclib/psx/sndpsxz/salloc.c.o(.text);  /* 0x800fe724 +0x70c interleaver */
        */src/eaclib/psx/sndpsxz/s3dpos.c.o(.text);  /* 0x800fee30 +0x11c */
        */src/eaclib/psx/sndpsxz/spatkey.c.o(.text);  /* 0x800fef4c +0x65c */
        */src/eaclib/psx/sndpsxz/slib.c.o(.text);  /* 0x800ff5a8 +0x8e8 */
        */src/eaclib/psx/sndpsxz/sdfx.c.o(.text);  /* 0x800ffe3c +0x3d0 interleaver */
        */src/eaclib/psx/sndpsxz/sdriver.c.o(.text);  /* 0x800ffe90 +0x35c */
        */src/eaclib/psx/sndpsxz/sfxlevel.c.o(.text);  /* 0x801005bc +0x154 */
        */src/eaclib/psx/spchpsxz/spchdata.c.o(.text);  /* 0x80100710 +0x6c */
        */src/eaclib/psx/spchpsxz/spchpick.c.o(.text);  /* 0x801007a0 +0x1184 */
        */src/eaclib/psx/sndpsxz/sclcptch.c.o(.text);  /* 0x80101900 +0x1bc interleaver */
        */src/eaclib/psx/sndpsxz/stagpat.c.o(.text);  /* 0x80101ac4 +0xbb0 */
        */src/eaclib/psx/sndpsxz/sbdload.c.o(.text);  /* 0x8010266c +0x150 interleaver */
        */src/eaclib/psx/sndpsxz/sballoc.c.o(.text);  /* 0x801027bc +0x54 */
        */src/eaclib/psx/sndpsxz/sgetvol.c.o(.text);  /* 0x80102810 +0x9c */
        */src/syslib/psx/libc/C63.c.o(.text);  /* 0x801028ac +0x10 */
        */src/eaclib/psx/sndpsxz/spktplay.c.o(.text);  /* 0x801028bc +0xb68 */
        */src/eaclib/psx/sndpsxz/smath64.c.o(.text);  /* 0x80103424 +0xe4 */
        */src/eaclib/psx/sndpsxz/sstgetrp.c.o(.text);  /* 0x80103508 +0x88 */
        */src/syslib/psx/libc/C31.c.o(.text);  /* 0x80103590 +0x10 */
        */src/syslib/psx/libc/C38.c.o(.text);  /* 0x801035a0 +0x10 */
        */src/eaclib/psx/sndpsxz/spat2hdr.c.o(.text);  /* 0x801035b0 +0x184 */
        */src/syslib/psx/libc/MEMCMP.c.o(.text);  /* 0x80103734 +0x50 */
        */src/eaclib/psx/sndpsxz/sdpacket.c.o(.text);  /* 0x80103784 +0x1018 */
        */src/eaclib/psx/sndpsxz/ssysserv.c.o(.text);  /* 0x8010479c +0x14c */
        */src/syslib/psx/libmath/DBSHIFTU.c.o(.text);  /* 0x801048e8 +0xc0 */
        */src/eaclib/psx/sndpsxz/sdtimrem.c.o(.text);  /* 0x801049a8 +0x64 */
        */src/syslib/psx/libapi/C73.c.o(.text);  /* 0x80104a0c +0x10 */
        */src/syslib/psx/libpad/PADMAIN.c.o(.text);  /* 0x80104cb8 +0xbd4 */
        */src/syslib/psx/libpad/PADCMD.c.o(.text);  /* 0x80105ac4 +0x950 */
        */src/eaclib/psx/eacpsxz/trnsmult.c.o(.text);  /* 0x80105f40 +0x144 interleaver */
        */src/eaclib/psx/eacpsxz/fastmovf.c.o(.text);  /* 0x80106084 +0x124 interleaver */
        */src/eaclib/psx/sndpsxz/smemman.c.o(.text);  /* 0x801061a8 +0x2ac interleaver */
        */src/syslib/psx/libgte/PATCHGTE.c.o(.text);  /* 0x80106454 +0xe0 */
        */src/syslib/psx/libetc/INTR_VB.c.o(.text);  /* 0x80106534 +0x120 */
        */src/syslib/psx/libapi/A91.c.o(.text);  /* 0x80106654 +0x10 */
        */src/syslib/psx/libapi/L10.c.o(.text);  /* 0x80106664 +0x10 */
        */src/syslib/psx/libgte/REG03.c.o(.text);  /* 0x80106674 +0x18 */
        */src/syslib/psx/libc/C19.c.o(.text);  /* 0x8010668c +0x10 */
        */src/syslib/psx/libapi/A25.c.o(.text);  /* 0x8010669c +0x10 */
        */src/syslib/psx/libetc/INTR_DMA.c.o(.text);  /* 0x801066ac +0x2a0 */
        */src/syslib/psx/libapi/C114.c.o(.text);  /* 0x80106954 +0x18 */
        */src/syslib/psx/libapi/A37.c.o(.text);  /* 0x8010696c +0x10 */
        */src/syslib/psx/libapi/A23.c.o(.text);  /* 0x8010697c +0x10 */
        */src/syslib/psx/libapi/A36.c.o(.text);  /* 0x8010698c +0x10 */
        */src/syslib/psx/libapi/A24.c.o(.text);  /* 0x8010699c +0x10 */
        */src/eaclib/psx/eacpsxz/textcode.c.o(.text);  /* 0x801069ac +0x18 */
        */src/eaclib/psx/eacpsxz/isqrttbl.c.o(.text);  /* 0x801069c4 +0x90 */
        */src/syslib/psx/libmath/FERR.c.o(.text);  /* 0x80106a54 +0x70 */
        */src/syslib/psx/libgte/COR_01.c.o(.text);  /* 0x80106ac4 +0x120 */
        */src/syslib/psx/libsn/READ.c.o(.text);  /* 0x80106be4 +0xc0 */
        */src/syslib/psx/libsn/OPEN.c.o(.text);  /* 0x80106ca4 +0x20 */
        */src/syslib/psx/libsn/FSINIT.c.o(.text);  /* 0x80106cc4 +0xc */
        */src/syslib/psx/libsn/CREAT.c.o(.text);  /* 0x80106cd0 +0x20 */
        */src/eaclib/psx/eacpsxz/devsys.c.o(.text);  /* 0x80106cf0 +0x2c */
        */src/syslib/psx/libsn/LSEEK.c.o(.text);  /* 0x80106d1c +0x24 */
        */src/syslib/psx/libsn/CLOSE.c.o(.text);  /* 0x80106d40 +0x10 */
        */src/syslib/psx/libsn/WRITE.c.o(.text);  /* 0x80106d50 +0xc0 */
        */src/syslib/psx/libapi/A12.c.o(.text);  /* 0x80106e10 +0x10 */
        */src/syslib/psx/libapi/A08.c.o(.text);  /* 0x80106e20 +0x10 */
        */src/syslib/psx/libapi/A13.c.o(.text);  /* 0x80106e30 +0x10 */
        */src/syslib/psx/libmath/DBSHIFT.c.o(.text);  /* 0x80106e40 +0xc0 */
        */src/syslib/psx/libmath/MAINASU.c.o(.text);  /* 0x80106f00 +0x70 */
        */src/syslib/psx/libmath/ADDMANT.c.o(.text);  /* 0x80106f70 +0xb0 */
        */src/syslib/psx/libgpu/P09.c.o(.text);  /* 0x80107020 +0x20 */
        */src/syslib/psx/libgpu/P06.c.o(.text);  /* 0x80107040 +0x40 */
        */src/syslib/psx/libcd/drv.c.o(.text);  /* 0x80107080 +0x16d8 */
        */src/syslib/psx/libcd/cdread.c.o(.text);  /* 0x801085dc +0x800 interleaver */
        */src/syslib/psx/libcd/streamhelp.c.o(.text);  /* 0x801085e8 +0x2dc interleaver */
        */src/syslib/psx/libds/DSCB.c.o(.text);  /* 0x80108824 +0x38 */
        */src/syslib/psx/libc/C37.c.o(.text);  /* 0x8010907c +0x10 */
        */src/syslib/psx/libcd/event.c.o(.text);  /* 0x801090c8 +0x150 */
        */src/syslib/psx/libc/BSEARCH.c.o(.text);  /* 0x801091dc +0xc0 interleaver */
        */src/syslib/psx/libcd/toc.c.o(.text);  /* 0x801092c0 +0x250 */
        */src/eaclib/psx/sndpsxz/sdcdvol.c.o(.text);  /* 0x801094ec +0x64 interleaver */
        */src/syslib/psx/libmcrd/BIOS.c.o(.text);  /* 0x80109550 +0x6b0 */
        */src/syslib/psx/libmcrd/USERFUNC.c.o(.text);  /* 0x80109c00 +0x110 */
        */src/syslib/psx/libcard/C171.c.o(.text);  /* 0x80109d10 +0x10 */
        */src/syslib/psx/libcard/CARD.c.o(.text);  /* 0x80109d20 +0x40 */
        */src/syslib/psx/libcard/C172.c.o(.text);  /* 0x80109d60 +0x10 */
        */src/syslib/psx/libapi/A50.c.o(.text);  /* 0x80109d70 +0x10 */
        */src/syslib/psx/libapi/A54.c.o(.text);  /* 0x80109d80 +0x10 */
        */src/syslib/psx/libapi/A51.c.o(.text);  /* 0x80109d90 +0x10 */
        */src/syslib/psx/libapi/A52.c.o(.text);  /* 0x80109da0 +0x10 */
        */src/syslib/psx/libapi/A53.c.o(.text);  /* 0x80109db0 +0x10 */
        */src/syslib/psx/libapi/FIRST.c.o(.text);  /* 0x80109dc0 +0x2a0 */
        */src/syslib/psx/libpad/PADSEQD.c.o(.text);  /* 0x80109fa4 +0x490 interleaver */
        */src/syslib/psx/libapi/A67.c.o(.text);  /* 0x8010a060 +0x10 */
        */src/syslib/psx/libapi/A69.c.o(.text);  /* 0x8010a070 +0x10 */
        */src/syslib/psx/libapi/A65.c.o(.text);  /* 0x8010a080 +0x10 */
        */src/syslib/psx/libcard/A80.c.o(.text);  /* 0x8010a090 +0x10 */
        */src/syslib/psx/libcard/A78.c.o(.text);  /* 0x8010a0a0 +0x10 */
        */src/syslib/psx/libc/C40.c.o(.text);  /* 0x8010a540 +0x10 */
        */src/eaclib/psx/sndpsxz/sdmemman.c.o(.text);  /* 0x8010a550 +0x330 */
        */src/eaclib/psx/sndpsxz/sdma.c.o(.text);  /* 0x8010a880 +0x65c */
        */src/eaclib/psx/sndpsxz/saetodv.c.o(.text);  /* 0x8010aef4 +0x1cc */
        */src/eaclib/psx/sndpsxz/saetolrv.c.o(.text);  /* 0x8010b0a8 +0x58 interleaver */
        */src/eaclib/psx/spchpsxz/spchrule.c.o(.text);  /* 0x8010b158 +0x4ac */
        */src/eaclib/psx/spchpsxz/spchsamp.c.o(.text);  /* 0x8010b5d4 +0x1b0 interleaver */
        */src/eaclib/psx/sndpsxz/sdresolv.c.o(.text);  /* 0x8010b75c +0x2ec */
        */src/eaclib/psx/sndpsxz/sdplapat.c.o(.text);  /* 0x8010ba48 +0x2ac */
        */src/eaclib/psx/sndpsxz/srrange.c.o(.text);  /* 0x8010bcf4 +0x5c */
        */src/eaclib/psx/sndpsxz/sgettag.c.o(.text);  /* 0x8010bd50 +0x130 */
        */src/eaclib/psx/sndpsxz/srandom.c.o(.text);  /* 0x8010be80 +0x100 */
        */src/eaclib/psx/sndpsxz/sdspuirq.c.o(.text);  /* 0x8010bf80 +0x48 */
        */src/syslib/psx/libapi/L03.c.o(.text);  /* 0x8010bfc8 +0x10 */
        */src/syslib/psx/libapi/L02.c.o(.text);  /* 0x8010bfd8 +0x10 */
        */src/syslib/psx/libpad/WAITRC2.c.o(.text);  /* 0x8010bfe8 +0xc0 */
        */src/syslib/psx/libpad/MCXMAIN.c.o(.text);  /* 0x8010c0a8 +0x5f0 */
        */src/syslib/psx/libgpu/P34.c.o(.text);  /* 0x8010c698 +0x60 */
        */src/syslib/psx/libapi/A07.c.o(.text);  /* 0x8010c6f8 +0x10 */
        */src/syslib/psx/libsn/SNREAD.c.o(.text);  /* 0x8010c708 +0x18 */
        */src/syslib/psx/libsn/SNWRITE.c.o(.text);  /* 0x8010c720 +0x18 */
        */src/eaclib/psx/sndpsxz/spvtolrv.c.o(.text);  /* 0x8010c738 +0x4c */
        */src/syslib/psx/libcard/INIT.c.o(.text);  /* 0x8010c784 +0x6c */
        */src/syslib/psx/libcard/CARDINIT.c.o(.text);  /* 0x8010c7f0 +0x64 */
        */src/syslib/psx/libapi/C112.c.o(.text);  /* 0x8010c854 +0x10 */
        */src/syslib/psx/libapi/A09.c.o(.text);  /* 0x8010c864 +0x10 */
        */src/syslib/psx/libapi/A11.c.o(.text);  /* 0x8010c874 +0x10 */
        */src/syslib/psx/libapi/A66.c.o(.text);  /* 0x8010c884 +0x10 */
        */src/eaclib/psx/sndpsxz/saelib.c.o(.text);  /* 0x8010c894 +0x94 */
        */src/eaclib/psx/sndpsxz/sgetdata.c.o(.text);  /* 0x8010c928 +0x88 */
        */src/syslib/psx/libapi/PAD.c.o(.text);  /* 0x8010c9b0 +0x10 */
        */src/syslib/psx/libcard/A74.c.o(.text);  /* 0x8010c9c0 +0x80 */
        */src/syslib/psx/libcard/PATCH.c.o(.text);  /* 0x8010ca0c +0x160 interleaver */
        */src/syslib/psx/libcard/A75.c.o(.text);  /* 0x8010cba0 +0x10 */
        */src/syslib/psx/libcard/A76.c.o(.text);  /* 0x8010cbb0 +0x10 */
        */src/syslib/psx/libcard/END.c.o(.text);  /* 0x8010cbc0 +0x80 */
        */src/eaclib/psx/sndpsxz/ssine.c.o(.text);  /* 0x8010cc40 +0x94 */
        /* W67-A5 .text spine END */
        build/src/*(.text);
        . = ALIGN(., 16);
        nfs4_TEXT_END = .;
        nfs4_TEXT_SIZE = ABSOLUTE(nfs4_TEXT_END - nfs4_TEXT_START);
        nfs4_DATA_START = .;
        build/asm/data/front_data_r00.data.s.o(.data);
        build/asm/data/front_data_o00.data.s.o(.data);
        build/asm/data/front_data_r01.data.s.o(.data);
        build/asm/data/front_data_o01.data.s.o(.data);
        build/asm/data/front_data_r02.data.s.o(.data);
        build/asm/data/front_data_o02.data.s.o(.data);
        build/asm/data/front_data_r03.data.s.o(.data);
        build/asm/data/front_data_o03.data.s.o(.data);
        build/asm/data/front_data_o04.data.s.o(.data);
        build/asm/data/front_data_r04.data.s.o(.data);
        build/asm/data/front_data_o05.data.s.o(.data);
        build/asm/data/front_data_o06.data.s.o(.data);
        build/asm/data/front_data_r05.data.s.o(.data);
        build/asm/data/front_data_o07.data.s.o(.data);
        build/asm/data/front_data_r06.data.s.o(.data);
        build/asm/data/front_data_o08.data.s.o(.data);
        build/asm/data/front_data_r07.data.s.o(.data);
        build/asm/data/front_data_o09.data.s.o(.data);
        build/asm/data/front_data_r08.data.s.o(.data);
        build/asm/data/front_bss.data.s.o(.data);
        /* W65-A5: rdata_80010000 is now 33 pieces (the .L localize
         * cut).  Every piece's .data is EMPTY, but a zero-size input section still
         * takes part in SUBALIGN, so the entries are KEPT (dropping them cost a
         * 4-byte fill and shifted the image -- caught by P6). */
        build/asm/data/rdata_80010000_r00.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j00.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r01.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j01.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r02.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j02.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r03.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j03.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r04.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j04.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j05.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j06.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j07.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r05.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j08.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r06.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j09.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r07.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j10.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r08.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j11.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r09.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j12.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r10.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j13.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r11.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j14.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r12.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j15.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j16.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r13.rodata.s.o(.data);
        build/asm/data/rdata_80010000_j17.rodata.s.o(.data);
        build/asm/data/rdata_80010000_r14.rodata.s.o(.data);
        build/src/front.c.o(.data);
        /* W65-A5: rdata_80054548 is now 61 pieces (the .L localize
         * cut).  Every piece's .data is EMPTY, but a zero-size input section still
         * takes part in SUBALIGN, so the entries are KEPT (dropping them cost a
         * 4-byte fill and shifted the image -- caught by P6). */
        build/asm/data/rdata_80054548_r00.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j00.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r01.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j01.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j02.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r02.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j03.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r03.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j04.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r04.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j05.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r05.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j06.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r06.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j07.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j08.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j09.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r07.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j10.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r08.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j11.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j12.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j13.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j14.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r09.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j15.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r10.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j16.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r11.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j17.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r12.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j18.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r13.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j19.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r14.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j20.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j21.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r15.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j22.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r16.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j23.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r17.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j24.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j25.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j26.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r18.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j27.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r19.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j28.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j29.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r20.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j30.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r21.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j31.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r22.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j32.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j33.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r23.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j34.rodata.s.o(.data);
        build/asm/data/rdata_80054548_r24.rodata.s.o(.data);
        build/asm/data/rdata_80054548_j35.rodata.s.o(.data);
        build/src/main.c.o(.data);
        /* W63-A19: the 0x8010CCD4 .data run, sliced at the recon-TU
         * ownership boundaries (scratchpad/w63a19/ownmap_data.txt).
         * _rNN = residual; _oNN = a window a recon TU owns (SPLAT LANE
         * ONLY -- see linkers/nfs4_recon.data.ldfrag). */
        build/asm/data/data_8010CCD4_r00.data.s.o(.data);
        build/asm/data/data_8010CCD4_o00.data.s.o(.data);
        build/asm/data/data_8010CCD4_o01.data.s.o(.data);
        build/asm/data/data_8010CCD4_o02.data.s.o(.data);
        build/asm/data/data_8010CCD4_r01.data.s.o(.data);
        build/asm/data/data_8010CCD4_o03.data.s.o(.data);
        build/asm/data/data_8010CCD4_o04.data.s.o(.data);
        build/asm/data/data_8010CCD4_o05.data.s.o(.data);
        build/asm/data/data_8010CCD4_o06.data.s.o(.data);
        build/asm/data/data_8010CCD4_r02.data.s.o(.data);
        build/asm/data/data_8010CCD4_o07.data.s.o(.data);
        build/asm/data/data_8010CCD4_r03.data.s.o(.data);
        build/asm/data/data_8010CCD4_o08.data.s.o(.data);
        build/asm/data/data_8010CCD4_o09.data.s.o(.data);
        build/asm/data/data_8010CCD4_o10.data.s.o(.data);
        build/asm/data/data_8010CCD4_o11.data.s.o(.data);
        build/asm/data/data_8010CCD4_r04.data.s.o(.data);
        build/asm/data/data_8010CCD4_o12.data.s.o(.data);
        build/asm/data/data_8010CCD4_r05.data.s.o(.data);
        build/asm/data/data_8010CCD4_o13.data.s.o(.data);
        build/asm/data/data_8010CCD4_r06.data.s.o(.data);
        build/asm/data/data_8010CCD4_o14.data.s.o(.data);
        build/asm/data/data_8010CCD4_o15.data.s.o(.data);
        build/asm/data/data_8010CCD4_r07.data.s.o(.data);
        build/asm/data/data_8010CCD4_o16.data.s.o(.data);
        build/asm/data/data_8010CCD4_r08.data.s.o(.data);
        build/asm/data/data_8010CCD4_o17.data.s.o(.data);
        build/asm/data/data_8010CCD4_o18.data.s.o(.data);
        build/asm/data/data_8010CCD4_o19.data.s.o(.data);
        build/asm/data/data_8010CCD4_r09.data.s.o(.data.r09_pre);
        /* Legacy lane retains the original gmesetup.obj lookup-name payload. */
        build/asm/data/data_8010CCD4_r09.data.s.o(.data.r09_gmesetup_names_legacy);
        build/asm/data/data_8010CCD4_o20.data.s.o(.data);
        build/asm/data/data_8010CCD4_o21.data.s.o(.data);
        build/asm/data/data_8010CCD4_r10.data.s.o(.data);
        build/asm/data/data_8010CCD4_o22.data.s.o(.data);
        build/asm/data/data_8010CCD4_r11.data.s.o(.data);
        build/asm/data/data_8010CCD4_o23.data.s.o(.data);
        build/asm/data/data_8010CCD4_o24.data.s.o(.data);
        build/asm/data/data_8010CCD4_r12.data.s.o(.data);
        build/asm/data/data_8010CCD4_o25.data.s.o(.data);
        /* SYM ownership seams: the legacy lane retains the original replay,
           schedule, and Stats payloads between the same neighbors. */
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_pre);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_replay_legacy);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_schedule_legacy);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_sim_legacy);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_stats_legacy);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_textsys_legacy);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_track_legacy);
        /* Legacy lane keeps the original bytes for the TrgSfx SYM ownership window. */
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_trgsfx_legacy);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data.r13_after_trgsfx);
        build/asm/data/data_8010CCD4_o26.data.s.o(.data);
        build/asm/data/data_8010CCD4_r14.data.s.o(.data);
        build/asm/data/data_8010CCD4_o27.data.s.o(.data);
        build/asm/data/data_8010CCD4_r15.data.s.o(.data);
        build/asm/data/data_8010CCD4_o28.data.s.o(.data);
        build/asm/data/data_8010CCD4_r16.data.s.o(.data);
        build/asm/data/data_8010CCD4_o29.data.s.o(.data);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data.table_blob);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data.r17_post_table);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data.sndef_blob);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data.r17_post_sndef);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data.atantbl_blob);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data.r17_post_atantbl);
        build/asm/data/data_8010CCD4_o30.data.s.o(.data);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.ctype_blob);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.r18_gap_after_ctype);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.asintbl_blob);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.r18_gap_after_asintbl);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.sintbl_blob);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.fatantbl_blob);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.r18_post_tables);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.cstbl_blob);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data.r18_post_cstbl);
        build/asm/data/data_8010CCD4_o31.data.s.o(.data);
        build/asm/data/data_8010CCD4_r19.data.s.o(.data);
        build/asm/data/data_8010CCD4_o32.data.s.o(.data);
        build/asm/data/data_8010CCD4_r20.data.s.o(.data);
        build/asm/data/data_8010CCD4_o33.data.s.o(.data);
        build/asm/data/data_8010CCD4_r21.data.s.o(.data);
        build/asm/data/tail.data.s.o(.data.tail_pre_simqueue);
        /* Legacy lane retains simqueue.obj's output/maxTicks tail-data words. */
        build/asm/data/tail.data.s.o(.data.tail_simqueue_output_legacy);
        build/asm/data/tail.data.s.o(.data.tail_simqueue_max_legacy);
        build/asm/data/tail.data.s.o(.data.tail_after_simqueue);
        build/src/*(.data);
        . = ALIGN(., 16);
        nfs4_DATA_END = .;
        nfs4_DATA_SIZE = ABSOLUTE(nfs4_DATA_END - nfs4_DATA_START);
        nfs4_SDATA_START = .;
        /* W63-A19: the 0x8013C54C sdata run, sliced at the recon-TU
         * ownership boundaries (scratchpad/w63a19/ownmap_sdata.txt).
         * _rNN = residual (no recon TU defines it) -- BOTH lanes.
         * _oNN = a window a recon TU owns -- SPLAT LANE ONLY; the
         *        recon-lane script links that object's own section
         *        here instead (linkers/nfs4_recon.sdata.ldfrag). */
        build/asm/data/sdata_8013C54C_r00.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o00.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o01.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o02.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r01.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o03.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o04.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r02.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o05.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o06.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r03.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o07.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o08.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r04.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o09.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r05.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o10.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r06.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o11.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r07.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o12.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r08.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o13.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o14.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o15.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o16.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o17.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r09.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o18.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o19.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o20.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r10.sdata.s.o(.sdata.r10_pre_new);
        /* Legacy lane retains the original new.obj heap-pointer word. */
        build/asm/data/sdata_8013C54C_r10.sdata.s.o(.sdata.r10_new_legacy);
        build/asm/data/sdata_8013C54C_r10.sdata.s.o(.sdata.r10_after_new);
        build/asm/data/sdata_8013C54C_o21.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r11.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o22.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r12.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o23.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r13.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o24.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r14.sdata.s.o(.sdata.r14_replay_counter_legacy);
        build/asm/data/sdata_8013C54C_o25.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r15.sdata.s.o(.sdata.r15_pre_simqueue);
        /* Legacy lane retains simqueue.obj's three initialized state words. */
        build/asm/data/sdata_8013C54C_r15.sdata.s.o(.sdata.r15_simqueue_legacy);
        build/asm/data/sdata_8013C54C_r15.sdata.s.o(.sdata.r15_after_simqueue);
        build/asm/data/sdata_8013C54C_o26.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r16.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o27.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o28.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o29.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r17.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o30.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r18.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o31.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r19.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o32.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r20.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o33.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r21.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o34.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o35.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o36.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r22.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r22.sdata.s.o(.sdata.vars_blob);
        build/asm/data/sdata_8013C54C_r22.sdata.s.o(.sdata.r22_post_vars);
        build/asm/data/sdata_8013C54C_o37.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r23.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o38.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r24.sdata.s.o(.sdata);
        build/src/*(.sdata);
        . = ALIGN(., 16);
        nfs4_SDATA_END = .;
        nfs4_SDATA_SIZE = ABSOLUTE(nfs4_SDATA_END - nfs4_SDATA_START);
        nfs4_SBSS_START = .;
        build/asm/data/sbss.sbss.s.o(.sbss);
        build/src/*(.sbss);
        . = ALIGN(., 16);
        nfs4_SBSS_END = .;
        nfs4_SBSS_SIZE = ABSOLUTE(nfs4_SBSS_END - nfs4_SBSS_START);
        nfs4_BSS_START = .;
        /* W65-A5: rdata_80010000 is now 33 pieces (the .L localize
         * cut).  Every piece's .bss is EMPTY, but a zero-size input section still
         * takes part in SUBALIGN, so the entries are KEPT (dropping them cost a
         * 4-byte fill and shifted the image -- caught by P6). */
        build/asm/data/rdata_80010000_r00.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j00.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r01.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j01.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r02.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j02.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r03.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j03.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r04.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j04.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j05.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j06.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j07.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r05.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j08.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r06.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j09.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r07.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j10.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r08.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j11.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r09.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j12.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r10.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j13.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r11.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j14.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r12.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j15.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j16.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r13.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_j17.rodata.s.o(.bss);
        build/asm/data/rdata_80010000_r14.rodata.s.o(.bss);
        build/src/front.c.o(.bss);
        /* W65-A5: rdata_80054548 is now 61 pieces (the .L localize
         * cut).  Every piece's .bss is EMPTY, but a zero-size input section still
         * takes part in SUBALIGN, so the entries are KEPT (dropping them cost a
         * 4-byte fill and shifted the image -- caught by P6). */
        build/asm/data/rdata_80054548_r00.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j00.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r01.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j01.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j02.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r02.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j03.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r03.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j04.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r04.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j05.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r05.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j06.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r06.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j07.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j08.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j09.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r07.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j10.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r08.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j11.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j12.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j13.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j14.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r09.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j15.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r10.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j16.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r11.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j17.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r12.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j18.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r13.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j19.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r14.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j20.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j21.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r15.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j22.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r16.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j23.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r17.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j24.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j25.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j26.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r18.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j27.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r19.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j28.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j29.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r20.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j30.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r21.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j31.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r22.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j32.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j33.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r23.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j34.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_r24.rodata.s.o(.bss);
        build/asm/data/rdata_80054548_j35.rodata.s.o(.bss);
        build/src/main.c.o(.bss);
        build/asm/data/bss.bss.s.o(.bss);
        build/src/*(.bss);
        build/src/*(COMMON);
        . = ALIGN(., 16);
        nfs4_BSS_END = .;
        nfs4_BSS_SIZE = ABSOLUTE(nfs4_BSS_END - nfs4_BSS_START);
    }
    __romPos += SIZEOF(.nfs4);
    __romPos = ALIGN(__romPos, 16);
    . = ALIGN(., 16);
    nfs4_ROM_END = __romPos;
    nfs4_VRAM_END = .;

    /* W65-A7: the trailing `*(*)` rule ate 459 of the src lane's 461
     * per-module objects ("defined in discarded section" x1975).  It is
     * narrowed to metadata + linker-generated sections ONLY; every real
     * input section is now placed by the catch-alls above.  The list is
     * derived from a census of every input section across both lanes
     * (scratchpad/w65a7/seccensus.py) plus the ld-generated .rel.dyn --
     * dropping .rel.dyn is what keeps the splat link byte-identical. */
    /DISCARD/ :
    {
        *(.pdr); *(.reginfo); *(.MIPS.abiflags); *(.gnu.attributes);
        *(.comment); *(.mdebug*); *(.rel.dyn); *(.rel*); *(.note*);
        *(.debug*); *(.line); *(.stab*); *(.got*); *(.dyn*);
    }
}
