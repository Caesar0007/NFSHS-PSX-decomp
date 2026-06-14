.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_DeInitCar__FP8Car_tObj, 0x50

glabel AIPhysic_DeInitCar__FP8Car_tObj
    /* 5D5D4 8006CDD4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D5D8 8006CDD8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D5DC 8006CDDC 21808000 */  addu       $s0, $a0, $zero
    /* 5D5E0 8006CDE0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5D5E4 8006CDE4 6002028E */  lw         $v0, 0x260($s0)
    /* 5D5E8 8006CDE8 00000000 */  nop
    /* 5D5EC 8006CDEC 02004230 */  andi       $v0, $v0, 0x2
    /* 5D5F0 8006CDF0 08004010 */  beqz       $v0, .L8006CE14
    /* 5D5F4 8006CDF4 00000000 */   nop
    /* 5D5F8 8006CDF8 B806048E */  lw         $a0, 0x6B8($s0)
    /* 5D5FC 8006CDFC 00000000 */  nop
    /* 5D600 8006CE00 04008010 */  beqz       $a0, .L8006CE14
    /* 5D604 8006CE04 00000000 */   nop
    /* 5D608 8006CE08 6B8F020C */  jal        __builtin_delete
    /* 5D60C 8006CE0C 00000000 */   nop
    /* 5D610 8006CE10 B80600AE */  sw         $zero, 0x6B8($s0)
  .L8006CE14:
    /* 5D614 8006CE14 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5D618 8006CE18 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D61C 8006CE1C 0800E003 */  jr         $ra
    /* 5D620 8006CE20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_DeInitCar__FP8Car_tObj
