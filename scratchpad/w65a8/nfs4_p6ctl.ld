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
    scratchpad/w65a8/ctl_obj/front_data.data.s.o(.data);   /* W65-A8 P6 CONTROL: the whole un-split blob, 19 pieces collapsed */
        build/asm/data/front_bss.data.s.o(.data);
        /* W65-A5: rdata_80010000 is now 33 pieces (the .L localize cut); every piece's .data is EMPTY (objdump size 0, re-asserted by relink_nfs4ld.py). */
        build/src/front.c.o(.data);
        /* W65-A5: rdata_80054548 is now 61 pieces (the .L localize cut); every piece's .data is EMPTY (objdump size 0, re-asserted by relink_nfs4ld.py). */
        build/src/main.c.o(.data);
        /* W63-A19: the 0x8010CCD4 .data run, sliced at the recon-TU
         * ownership boundaries (scratchpad/w63a19/ownmap_data.txt).
         * _rNN = residual; _oNN = a window a recon TU owns (SPLAT LANE
         * ONLY -- see linkers/nfs4_recon.data.ldfrag). */
    scratchpad/w65a8/ctl_obj/data_8010CCD4.data.s.o(.data);   /* W65-A8 P6 CONTROL: the whole un-split blob, 56 pieces collapsed */
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
    scratchpad/w65a8/ctl_obj/sdata_8013C54C.sdata.s.o(.sdata);   /* W65-A8 P6 CONTROL: the whole un-split blob, 58 pieces collapsed */
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
        /* W65-A5: rdata_80010000 is now 33 pieces (the .L localize cut); every piece's .bss is EMPTY (objdump size 0, re-asserted by relink_nfs4ld.py). */
        build/src/front.c.o(.bss);
        /* W65-A5: rdata_80054548 is now 61 pieces (the .L localize cut); every piece's .bss is EMPTY (objdump size 0, re-asserted by relink_nfs4ld.py). */
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
