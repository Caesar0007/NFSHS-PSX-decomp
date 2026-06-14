.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef, 0x94

glabel AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
    /* 63824 80073024 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 63828 80073028 3400BFAF */  sw         $ra, 0x34($sp)
    /* 6382C 8007302C 3000B0AF */  sw         $s0, 0x30($sp)
    /* 63830 80073030 0000828C */  lw         $v0, 0x0($a0)
    /* 63834 80073034 0000A38C */  lw         $v1, 0x0($a1)
    /* 63838 80073038 00000000 */  nop
    /* 6383C 8007303C 23104300 */  subu       $v0, $v0, $v1
    /* 63840 80073040 1000A2AF */  sw         $v0, 0x10($sp)
    /* 63844 80073044 0400828C */  lw         $v0, 0x4($a0)
    /* 63848 80073048 0400A38C */  lw         $v1, 0x4($a1)
    /* 6384C 8007304C 00000000 */  nop
    /* 63850 80073050 23104300 */  subu       $v0, $v0, $v1
    /* 63854 80073054 1400A2AF */  sw         $v0, 0x14($sp)
    /* 63858 80073058 0800828C */  lw         $v0, 0x8($a0)
    /* 6385C 8007305C 0800A38C */  lw         $v1, 0x8($a1)
    /* 63860 80073060 00000000 */  nop
    /* 63864 80073064 23104300 */  subu       $v0, $v0, $v1
    /* 63868 80073068 1800A2AF */  sw         $v0, 0x18($sp)
    /* 6386C 8007306C 1800C78C */  lw         $a3, 0x18($a2)
    /* 63870 80073070 1C00C88C */  lw         $t0, 0x1C($a2)
    /* 63874 80073074 2000C98C */  lw         $t1, 0x20($a2)
    /* 63878 80073078 2000A7AF */  sw         $a3, 0x20($sp)
    /* 6387C 8007307C 2400A8AF */  sw         $t0, 0x24($sp)
    /* 63880 80073080 2800A9AF */  sw         $t1, 0x28($sp)
    /* 63884 80073084 1000A48F */  lw         $a0, 0x10($sp)
    /* 63888 80073088 2000A58F */  lw         $a1, 0x20($sp)
    /* 6388C 8007308C CA90030C */  jal        fixedmult
    /* 63890 80073090 00000000 */   nop
    /* 63894 80073094 1800A48F */  lw         $a0, 0x18($sp)
    /* 63898 80073098 2800A58F */  lw         $a1, 0x28($sp)
    /* 6389C 8007309C CA90030C */  jal        fixedmult
    /* 638A0 800730A0 21804000 */   addu      $s0, $v0, $zero
    /* 638A4 800730A4 21100202 */  addu       $v0, $s0, $v0
    /* 638A8 800730A8 3400BF8F */  lw         $ra, 0x34($sp)
    /* 638AC 800730AC 3000B08F */  lw         $s0, 0x30($sp)
    /* 638B0 800730B0 0800E003 */  jr         $ra
    /* 638B4 800730B4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
