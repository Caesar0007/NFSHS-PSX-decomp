SECTIONS
{
    .out 0x8010ccd4 :
    {
        scratchpad/w65a8/ctl_obj/data_8010CCD4.data.s.o(.data);
    }
    /DISCARD/ : { *(*) }
}
