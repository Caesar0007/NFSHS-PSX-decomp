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
    .nfs4 0x80010000 : AT(nfs4_ROM_START) SUBALIGN(16)
    {
        FILL(0x00000000);
        nfs4_RODATA_START = .;
        build/asm/data/rdata_80010000.rodata.s.o(.rodata);
        build/src/front.c.o(.rodata);
        build/asm/data/rdata_80054548.rodata.s.o(.rodata);
        build/src/main.c.o(.rodata);
        . = ALIGN(., 16);
        nfs4_RODATA_END = .;
        nfs4_RODATA_SIZE = ABSOLUTE(nfs4_RODATA_END - nfs4_RODATA_START);
        nfs4_TEXT_START = .;
        build/src/front.c.o(.text);
        build/src/main.c.o(.text);
        . = ALIGN(., 16);
        nfs4_TEXT_END = .;
        nfs4_TEXT_SIZE = ABSOLUTE(nfs4_TEXT_END - nfs4_TEXT_START);
        nfs4_DATA_START = .;
        build/asm/data/front_data.data.s.o(.data);
        build/asm/data/front_bss.data.s.o(.data);
        build/asm/data/rdata_80010000.rodata.s.o(.data);
        build/src/front.c.o(.data);
        build/asm/data/rdata_80054548.rodata.s.o(.data);
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
        build/asm/data/tail.data.s.o(.data);
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
        build/asm/data/sdata_8013C54C_r03.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o06.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o07.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r04.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o08.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r05.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o09.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r06.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o10.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r07.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o11.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r08.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o12.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o13.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o14.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o15.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o16.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r09.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o17.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o18.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o19.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r10.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o20.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r11.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o21.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r12.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o22.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r13.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o23.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r14.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o24.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o25.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o26.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r15.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o27.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r16.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o28.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r17.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o29.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r18.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o30.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r19.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o31.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o32.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r20.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o33.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r21.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_o34.sdata.s.o(.sdata);
        build/asm/data/sdata_8013C54C_r22.sdata.s.o(.sdata);
        . = ALIGN(., 16);
        nfs4_SDATA_END = .;
        nfs4_SDATA_SIZE = ABSOLUTE(nfs4_SDATA_END - nfs4_SDATA_START);
        nfs4_SBSS_START = .;
        build/asm/data/sbss.sbss.s.o(.sbss);
        . = ALIGN(., 16);
        nfs4_SBSS_END = .;
        nfs4_SBSS_SIZE = ABSOLUTE(nfs4_SBSS_END - nfs4_SBSS_START);
        nfs4_BSS_START = .;
        build/asm/data/rdata_80010000.rodata.s.o(.bss);
        build/src/front.c.o(.bss);
        build/asm/data/rdata_80054548.rodata.s.o(.bss);
        build/src/main.c.o(.bss);
        build/asm/data/bss.bss.s.o(.bss);
        . = ALIGN(., 16);
        nfs4_BSS_END = .;
        nfs4_BSS_SIZE = ABSOLUTE(nfs4_BSS_END - nfs4_BSS_START);
    }
    __romPos += SIZEOF(.nfs4);
    __romPos = ALIGN(__romPos, 16);
    . = ALIGN(., 16);
    nfs4_ROM_END = __romPos;
    nfs4_VRAM_END = .;

    .src_rest : SUBALIGN(4) { *(.text); *(.rodata); *(.data); *(.sdata); *(.sbss); *(.bss); *(COMMON); }
    /DISCARD/ :
    {
        *(.pdr); *(.reginfo); *(.MIPS.abiflags); *(.gnu.attributes); *(.comment); *(.mdebug*);
    }
}
