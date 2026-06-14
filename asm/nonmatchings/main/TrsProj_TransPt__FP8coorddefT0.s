.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching TrsProj_TransPt__FP8coorddefT0, 0x8C

glabel TrsProj_TransPt__FP8coorddefT0
    /* D23CC 800E1BCC 0000828C */  lw         $v0, 0x0($a0)
    /* D23D0 800E1BD0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D23D4 800E1BD4 83120200 */  sra        $v0, $v0, 10
    /* D23D8 800E1BD8 0000A2A7 */  sh         $v0, 0x0($sp)
    /* D23DC 800E1BDC 0400828C */  lw         $v0, 0x4($a0)
    /* D23E0 800E1BE0 00000000 */  nop
    /* D23E4 800E1BE4 83120200 */  sra        $v0, $v0, 10
    /* D23E8 800E1BE8 0200A2A7 */  sh         $v0, 0x2($sp)
    /* D23EC 800E1BEC 0800828C */  lw         $v0, 0x8($a0)
    /* D23F0 800E1BF0 00000000 */  nop
    /* D23F4 800E1BF4 83120200 */  sra        $v0, $v0, 10
    /* D23F8 800E1BF8 0400A2A7 */  sh         $v0, 0x4($sp)
    /* D23FC 800E1BFC 0000A0CB */  lwc2       $0, 0x0($sp)
    /* D2400 800E1C00 0400A1CB */  lwc2       $1, 0x4($sp)
    /* D2404 800E1C04 00000000 */  nop
    /* D2408 800E1C08 00000000 */  nop
    /* D240C 800E1C0C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D2410 800E1C10 0800A227 */  addiu      $v0, $sp, 0x8
    /* D2414 800E1C14 000059E8 */  swc2       $25, 0x0($v0)
    /* D2418 800E1C18 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* D241C 800E1C1C 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* D2420 800E1C20 0800A28F */  lw         $v0, 0x8($sp)
    /* D2424 800E1C24 00000000 */  nop
    /* D2428 800E1C28 80120200 */  sll        $v0, $v0, 10
    /* D242C 800E1C2C 0000A2AC */  sw         $v0, 0x0($a1)
    /* D2430 800E1C30 0C00A28F */  lw         $v0, 0xC($sp)
    /* D2434 800E1C34 00000000 */  nop
    /* D2438 800E1C38 80120200 */  sll        $v0, $v0, 10
    /* D243C 800E1C3C 0400A2AC */  sw         $v0, 0x4($a1)
    /* D2440 800E1C40 1000A28F */  lw         $v0, 0x10($sp)
    /* D2444 800E1C44 00000000 */  nop
    /* D2448 800E1C48 80120200 */  sll        $v0, $v0, 10
    /* D244C 800E1C4C 0800A2AC */  sw         $v0, 0x8($a1)
    /* D2450 800E1C50 0800E003 */  jr         $ra
    /* D2454 800E1C54 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TrsProj_TransPt__FP8coorddefT0
