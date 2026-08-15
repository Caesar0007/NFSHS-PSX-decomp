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
        build/asm/data/data_8010CCD4_r09.data.s.o(.data);
        build/asm/data/data_8010CCD4_o20.data.s.o(.data);
        build/asm/data/data_8010CCD4_o21.data.s.o(.data);
        build/asm/data/data_8010CCD4_r10.data.s.o(.data);
        build/asm/data/data_8010CCD4_o22.data.s.o(.data);
        build/asm/data/data_8010CCD4_r11.data.s.o(.data);
        build/asm/data/data_8010CCD4_o23.data.s.o(.data);
        build/asm/data/data_8010CCD4_o24.data.s.o(.data);
        build/asm/data/data_8010CCD4_r12.data.s.o(.data);
        build/asm/data/data_8010CCD4_o25.data.s.o(.data);
        build/asm/data/data_8010CCD4_r13.data.s.o(.data);
        build/asm/data/data_8010CCD4_o26.data.s.o(.data);
        build/asm/data/data_8010CCD4_r14.data.s.o(.data);
        build/asm/data/data_8010CCD4_o27.data.s.o(.data);
        build/asm/data/data_8010CCD4_r15.data.s.o(.data);
        build/asm/data/data_8010CCD4_o28.data.s.o(.data);
        build/asm/data/data_8010CCD4_r16.data.s.o(.data);
        build/asm/data/data_8010CCD4_o29.data.s.o(.data);
        build/asm/data/data_8010CCD4_r17.data.s.o(.data);
        build/asm/data/data_8010CCD4_o30.data.s.o(.data);
        build/asm/data/data_8010CCD4_r18.data.s.o(.data);
        build/asm/data/data_8010CCD4_o31.data.s.o(.data);
        build/asm/data/data_8010CCD4_r19.data.s.o(.data);
        build/asm/data/data_8010CCD4_o32.data.s.o(.data);
        build/asm/data/data_8010CCD4_r20.data.s.o(.data);
        build/asm/data/data_8010CCD4_o33.data.s.o(.data);
        build/asm/data/data_8010CCD4_r21.data.s.o(.data);
        build/asm/data/tail.data.s.o(.data);
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
        build/asm/data/sdata_8013C54C_r10.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o21.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r11.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o22.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r12.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o23.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r13.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o24.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r14.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o25.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r15.sdata.s.o(.sdata);
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
