SECTIONS
{
    .out 0x8004c7a0 :
    {
        scratchpad/w65a8/ctl_obj/front_data.data.s.o(.data);
    }
    /DISCARD/ : { *(*) }
}
