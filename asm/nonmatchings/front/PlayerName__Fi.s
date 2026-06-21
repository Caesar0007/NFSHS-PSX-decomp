.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PlayerName__Fi, 0x8C

glabel PlayerName__Fi
    /* 1C1FC 8002B9FC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1C200 8002BA00 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1C204 8002BA04 21908000 */  addu       $s2, $a0, $zero
    /* 1C208 8002BA08 C0281200 */  sll        $a1, $s2, 3
    /* 1C20C 8002BA0C 1180023C */  lui        $v0, %hi(D_80114974)
    /* 1C210 8002BA10 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1C214 8002BA14 74495124 */  addiu      $s1, $v0, %lo(D_80114974)
    /* 1C218 8002BA18 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1C21C 8002BA1C 2180B100 */  addu       $s0, $a1, $s1
    /* 1C220 8002BA20 21200002 */  addu       $a0, $s0, $zero
    /* 1C224 8002BA24 F0FF2226 */  addiu      $v0, $s1, -0x10
    /* 1C228 8002BA28 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1C22C 8002BA2C 2F91030C */  jal        sprintf
    /* 1C230 8002BA30 2128A200 */   addu      $a1, $a1, $v0
    /* 1C234 8002BA34 DDA7030C */  jal        strlen
    /* 1C238 8002BA38 21200002 */   addu      $a0, $s0, $zero
    /* 1C23C 8002BA3C 05004010 */  beqz       $v0, .L8002BA54
    /* 1C240 8002BA40 01000224 */   addiu     $v0, $zero, 0x1
    /* 1C244 8002BA44 132B010C */  jal        StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
    /* 1C248 8002BA48 21200002 */   addu      $a0, $s0, $zero
    /* 1C24C 8002BA4C 9CAE0008 */  j          .L8002BA70
    /* 1C250 8002BA50 21100002 */   addu      $v0, $s0, $zero
  .L8002BA54:
    /* 1C254 8002BA54 8FFC2392 */  lbu        $v1, -0x371($s1)
    /* 1C258 8002BA58 00000000 */  nop
    /* 1C25C 8002BA5C 02006214 */  bne        $v1, $v0, .L8002BA68
    /* 1C260 8002BA60 4E000424 */   addiu     $a0, $zero, 0x4E
    /* 1C264 8002BA64 50004426 */  addiu      $a0, $s2, 0x50
  .L8002BA68:
    /* 1C268 8002BA68 94E4020C */  jal        TextSys_Word__Fi
    /* 1C26C 8002BA6C 00000000 */   nop
  .L8002BA70:
    /* 1C270 8002BA70 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 1C274 8002BA74 1800B28F */  lw         $s2, 0x18($sp)
    /* 1C278 8002BA78 1400B18F */  lw         $s1, 0x14($sp)
    /* 1C27C 8002BA7C 1000B08F */  lw         $s0, 0x10($sp)
    /* 1C280 8002BA80 0800E003 */  jr         $ra
    /* 1C284 8002BA84 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PlayerName__Fi
