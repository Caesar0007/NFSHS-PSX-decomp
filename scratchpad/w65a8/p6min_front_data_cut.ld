SECTIONS
{
    .out 0x8004c7a0 :
    {
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
    }
    /DISCARD/ : { *(*) }
}
