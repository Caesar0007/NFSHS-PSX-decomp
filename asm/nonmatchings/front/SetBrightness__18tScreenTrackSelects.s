.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetBrightness__18tScreenTrackSelects, 0x30

glabel SetBrightness__18tScreenTrackSelects
    /* 32568 80041D68 00140500 */  sll        $v0, $a1, 16
    /* 3256C 80041D6C 72008384 */  lh         $v1, 0x72($a0)
    /* 32570 80041D70 03140200 */  sra        $v0, $v0, 16
    /* 32574 80041D74 06004310 */  beq        $v0, $v1, .L80041D90
    /* 32578 80041D78 1480023C */   lui       $v0, %hi(ticks)
    /* 3257C 80041D7C 70008394 */  lhu        $v1, 0x70($a0)
    /* 32580 80041D80 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 32584 80041D84 720085A4 */  sh         $a1, 0x72($a0)
    /* 32588 80041D88 740083A4 */  sh         $v1, 0x74($a0)
    /* 3258C 80041D8C 780082AC */  sw         $v0, 0x78($a0)
  .L80041D90:
    /* 32590 80041D90 0800E003 */  jr         $ra
    /* 32594 80041D94 00000000 */   nop
endlabel SetBrightness__18tScreenTrackSelects
