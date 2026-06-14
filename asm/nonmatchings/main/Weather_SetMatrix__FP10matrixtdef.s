.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Weather_SetMatrix__FP10matrixtdef, 0xC4

glabel Weather_SetMatrix__FP10matrixtdef
    /* D25D0 800E1DD0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D25D4 800E1DD4 0000828C */  lw         $v0, 0x0($a0)
    /* D25D8 800E1DD8 0C00838C */  lw         $v1, 0xC($a0)
    /* D25DC 800E1DDC 1800858C */  lw         $a1, 0x18($a0)
    /* D25E0 800E1DE0 03110200 */  sra        $v0, $v0, 4
    /* D25E4 800E1DE4 03190300 */  sra        $v1, $v1, 4
    /* D25E8 800E1DE8 03290500 */  sra        $a1, $a1, 4
    /* D25EC 800E1DEC 0000A2A7 */  sh         $v0, 0x0($sp)
    /* D25F0 800E1DF0 0200A3A7 */  sh         $v1, 0x2($sp)
    /* D25F4 800E1DF4 0400A5A7 */  sh         $a1, 0x4($sp)
    /* D25F8 800E1DF8 0400828C */  lw         $v0, 0x4($a0)
    /* D25FC 800E1DFC 1000838C */  lw         $v1, 0x10($a0)
    /* D2600 800E1E00 1C00858C */  lw         $a1, 0x1C($a0)
    /* D2604 800E1E04 03110200 */  sra        $v0, $v0, 4
    /* D2608 800E1E08 03190300 */  sra        $v1, $v1, 4
    /* D260C 800E1E0C 03290500 */  sra        $a1, $a1, 4
    /* D2610 800E1E10 0600A2A7 */  sh         $v0, 0x6($sp)
    /* D2614 800E1E14 0800A3A7 */  sh         $v1, 0x8($sp)
    /* D2618 800E1E18 0A00A5A7 */  sh         $a1, 0xA($sp)
    /* D261C 800E1E1C 0800828C */  lw         $v0, 0x8($a0)
    /* D2620 800E1E20 1400838C */  lw         $v1, 0x14($a0)
    /* D2624 800E1E24 2000848C */  lw         $a0, 0x20($a0)
    /* D2628 800E1E28 1400A0AF */  sw         $zero, 0x14($sp)
    /* D262C 800E1E2C 1800A0AF */  sw         $zero, 0x18($sp)
    /* D2630 800E1E30 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* D2634 800E1E34 03110200 */  sra        $v0, $v0, 4
    /* D2638 800E1E38 03190300 */  sra        $v1, $v1, 4
    /* D263C 800E1E3C 03210400 */  sra        $a0, $a0, 4
    /* D2640 800E1E40 0C00A2A7 */  sh         $v0, 0xC($sp)
    /* D2644 800E1E44 0E00A3A7 */  sh         $v1, 0xE($sp)
    /* D2648 800E1E48 1000A4A7 */  sh         $a0, 0x10($sp)
    /* D264C 800E1E4C 0000AC8F */  lw         $t4, 0x0($sp)
    /* D2650 800E1E50 0400AD8F */  lw         $t5, 0x4($sp)
    /* D2654 800E1E54 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* D2658 800E1E58 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* D265C 800E1E5C 0800AC8F */  lw         $t4, 0x8($sp)
    /* D2660 800E1E60 0C00AD8F */  lw         $t5, 0xC($sp)
    /* D2664 800E1E64 1000AE8F */  lw         $t6, 0x10($sp)
    /* D2668 800E1E68 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* D266C 800E1E6C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* D2670 800E1E70 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* D2674 800E1E74 1400AC8F */  lw         $t4, 0x14($sp)
    /* D2678 800E1E78 1800AD8F */  lw         $t5, 0x18($sp)
    /* D267C 800E1E7C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* D2680 800E1E80 1C00AE8F */  lw         $t6, 0x1C($sp)
    /* D2684 800E1E84 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* D2688 800E1E88 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* D268C 800E1E8C 0800E003 */  jr         $ra
    /* D2690 800E1E90 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Weather_SetMatrix__FP10matrixtdef
