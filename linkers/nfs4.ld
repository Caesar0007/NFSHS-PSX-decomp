SECTIONS
{
    __romPos = 0;
    _gp = 0x8013C54C;
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
        build/asm/data/data_8010CCD4.data.s.o(.data);
        build/asm/data/tail.data.s.o(.data);
        . = ALIGN(., 16);
        nfs4_DATA_END = .;
        nfs4_DATA_SIZE = ABSOLUTE(nfs4_DATA_END - nfs4_DATA_START);
        nfs4_SDATA_START = .;
        build/asm/data/sdata_8013C54C.sdata.s.o(.sdata);
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

    /DISCARD/ :
    {
        *(*);
    }
}
