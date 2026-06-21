.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PlayerNameMixedCase__Fi, 0x6C

glabel PlayerNameMixedCase__Fi
    /* 1C288 8002BA88 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1C28C 8002BA8C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1C290 8002BA90 21908000 */  addu       $s2, $a0, $zero
    /* 1C294 8002BA94 C0181200 */  sll        $v1, $s2, 3
    /* 1C298 8002BA98 1180023C */  lui        $v0, %hi(D_80114964)
    /* 1C29C 8002BA9C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1C2A0 8002BAA0 64495124 */  addiu      $s1, $v0, %lo(D_80114964)
    /* 1C2A4 8002BAA4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1C2A8 8002BAA8 21807100 */  addu       $s0, $v1, $s1
    /* 1C2AC 8002BAAC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1C2B0 8002BAB0 DDA7030C */  jal        strlen
    /* 1C2B4 8002BAB4 21200002 */   addu      $a0, $s0, $zero
    /* 1C2B8 8002BAB8 08004014 */  bnez       $v0, .L8002BADC
    /* 1C2BC 8002BABC 21100002 */   addu      $v0, $s0, $zero
    /* 1C2C0 8002BAC0 9FFC2392 */  lbu        $v1, -0x361($s1)
    /* 1C2C4 8002BAC4 01000224 */  addiu      $v0, $zero, 0x1
    /* 1C2C8 8002BAC8 02006214 */  bne        $v1, $v0, .L8002BAD4
    /* 1C2CC 8002BACC 4E000424 */   addiu     $a0, $zero, 0x4E
    /* 1C2D0 8002BAD0 50004426 */  addiu      $a0, $s2, 0x50
  .L8002BAD4:
    /* 1C2D4 8002BAD4 94E4020C */  jal        TextSys_Word__Fi
    /* 1C2D8 8002BAD8 00000000 */   nop
  .L8002BADC:
    /* 1C2DC 8002BADC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 1C2E0 8002BAE0 1800B28F */  lw         $s2, 0x18($sp)
    /* 1C2E4 8002BAE4 1400B18F */  lw         $s1, 0x14($sp)
    /* 1C2E8 8002BAE8 1000B08F */  lw         $s0, 0x10($sp)
    /* 1C2EC 8002BAEC 0800E003 */  jr         $ra
    /* 1C2F0 8002BAF0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PlayerNameMixedCase__Fi
