.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_KillStatus__Fv, 0x6C

glabel Object_KillStatus__Fv
    /* 95A58 800A5258 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 95A5C 800A525C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 95A60 800A5260 21880000 */  addu       $s1, $zero, $zero
    /* 95A64 800A5264 1180023C */  lui        $v0, %hi(gSimObjAnims)
    /* 95A68 800A5268 1000B0AF */  sw         $s0, 0x10($sp)
    /* 95A6C 800A526C 605D5024 */  addiu      $s0, $v0, %lo(gSimObjAnims)
    /* 95A70 800A5270 1800BFAF */  sw         $ra, 0x18($sp)
  .L800A5274:
    /* 95A74 800A5274 0000038E */  lw         $v1, 0x0($s0)
    /* 95A78 800A5278 00000000 */  nop
    /* 95A7C 800A527C 08006010 */  beqz       $v1, .L800A52A0
    /* 95A80 800A5280 03000524 */   addiu     $a1, $zero, 0x3
    /* 95A84 800A5284 0000628C */  lw         $v0, 0x0($v1)
    /* 95A88 800A5288 00000000 */  nop
    /* 95A8C 800A528C 08004484 */  lh         $a0, 0x8($v0)
    /* 95A90 800A5290 0C00428C */  lw         $v0, 0xC($v0)
    /* 95A94 800A5294 00000000 */  nop
    /* 95A98 800A5298 09F84000 */  jalr       $v0
    /* 95A9C 800A529C 21206400 */   addu      $a0, $v1, $a0
  .L800A52A0:
    /* 95AA0 800A52A0 01003126 */  addiu      $s1, $s1, 0x1
    /* 95AA4 800A52A4 C201222A */  slti       $v0, $s1, 0x1C2
    /* 95AA8 800A52A8 F2FF4014 */  bnez       $v0, .L800A5274
    /* 95AAC 800A52AC 04001026 */   addiu     $s0, $s0, 0x4
    /* 95AB0 800A52B0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 95AB4 800A52B4 1400B18F */  lw         $s1, 0x14($sp)
    /* 95AB8 800A52B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 95ABC 800A52BC 0800E003 */  jr         $ra
    /* 95AC0 800A52C0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Object_KillStatus__Fv
