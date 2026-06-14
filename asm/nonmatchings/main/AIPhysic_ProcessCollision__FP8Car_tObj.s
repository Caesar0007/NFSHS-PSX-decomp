.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_ProcessCollision__FP8Car_tObj, 0x7C

glabel AIPhysic_ProcessCollision__FP8Car_tObj
    /* 5D174 8006C974 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D178 8006C978 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5D17C 8006C97C 9001838C */  lw         $v1, 0x190($a0)
    /* 5D180 8006C980 99D90234 */  ori        $v0, $zero, 0xD999
    /* 5D184 8006C984 2A104300 */  slt        $v0, $v0, $v1
    /* 5D188 8006C988 15004010 */  beqz       $v0, .L8006C9E0
    /* 5D18C 8006C98C 00000000 */   nop
    /* 5D190 8006C990 9401828C */  lw         $v0, 0x194($a0)
    /* 5D194 8006C994 00000000 */  nop
    /* 5D198 8006C998 11004010 */  beqz       $v0, .L8006C9E0
    /* 5D19C 8006C99C 0900033C */   lui       $v1, (0x9FFFF >> 16)
    /* 5D1A0 8006C9A0 6405828C */  lw         $v0, 0x564($a0)
    /* 5D1A4 8006C9A4 FFFF6334 */  ori        $v1, $v1, (0x9FFFF & 0xFFFF)
    /* 5D1A8 8006C9A8 02004104 */  bgez       $v0, .L8006C9B4
    /* 5D1AC 8006C9AC 00000000 */   nop
    /* 5D1B0 8006C9B0 23100200 */  negu       $v0, $v0
  .L8006C9B4:
    /* 5D1B4 8006C9B4 2A186200 */  slt        $v1, $v1, $v0
    /* 5D1B8 8006C9B8 09006014 */  bnez       $v1, .L8006C9E0
    /* 5D1BC 8006C9BC 00000000 */   nop
    /* 5D1C0 8006C9C0 6002828C */  lw         $v0, 0x260($a0)
    /* 5D1C4 8006C9C4 00000000 */  nop
    /* 5D1C8 8006C9C8 10004230 */  andi       $v0, $v0, 0x10
    /* 5D1CC 8006C9CC 02004010 */  beqz       $v0, .L8006C9D8
    /* 5D1D0 8006C9D0 60000524 */   addiu     $a1, $zero, 0x60
    /* 5D1D4 8006C9D4 A0000524 */  addiu      $a1, $zero, 0xA0
  .L8006C9D8:
    /* 5D1D8 8006C9D8 7CB2010C */  jal        AIPhysic_ChangeDirection__FP8Car_tObji
    /* 5D1DC 8006C9DC 00000000 */   nop
  .L8006C9E0:
    /* 5D1E0 8006C9E0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5D1E4 8006C9E4 00000000 */  nop
    /* 5D1E8 8006C9E8 0800E003 */  jr         $ra
    /* 5D1EC 8006C9EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_ProcessCollision__FP8Car_tObj
