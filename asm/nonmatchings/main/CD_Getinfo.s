.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Getinfo, 0x74

glabel CD_Getinfo
    /* EB120 800FA920 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EB124 800FA924 1400B1AF */  sw         $s1, 0x14($sp)
    /* EB128 800FA928 2188C000 */  addu       $s1, $a2, $zero
    /* EB12C 800FA92C 1480023C */  lui        $v0, %hi(D_80146CF8)
    /* EB130 800FA930 80200400 */  sll        $a0, $a0, 2
    /* EB134 800FA934 F86C428C */  lw         $v0, %lo(D_80146CF8)($v0)
    /* EB138 800FA938 FCFF8424 */  addiu      $a0, $a0, -0x4
    /* EB13C 800FA93C 1800BFAF */  sw         $ra, 0x18($sp)
    /* EB140 800FA940 1000B0AF */  sw         $s0, 0x10($sp)
    /* EB144 800FA944 0500A010 */  beqz       $a1, .L800FA95C
    /* EB148 800FA948 21804400 */   addu      $s0, $v0, $a0
    /* EB14C 800FA94C 2120A000 */  addu       $a0, $a1, $zero
    /* EB150 800FA950 0000058E */  lw         $a1, 0x0($s0)
    /* EB154 800FA954 41D8030C */  jal        strncpy
    /* EB158 800FA958 0C000624 */   addiu     $a2, $zero, 0xC
  .L800FA95C:
    /* EB15C 800FA95C 06002012 */  beqz       $s1, .L800FA978
    /* EB160 800FA960 00000000 */   nop
    /* EB164 800FA964 0000028E */  lw         $v0, 0x0($s0)
    /* EB168 800FA968 00000000 */  nop
    /* EB16C 800FA96C 1000428C */  lw         $v0, 0x10($v0)
    /* EB170 800FA970 00000000 */  nop
    /* EB174 800FA974 000022AE */  sw         $v0, 0x0($s1)
  .L800FA978:
    /* EB178 800FA978 0000028E */  lw         $v0, 0x0($s0)
    /* EB17C 800FA97C 1800BF8F */  lw         $ra, 0x18($sp)
    /* EB180 800FA980 1400B18F */  lw         $s1, 0x14($sp)
    /* EB184 800FA984 1000B08F */  lw         $s0, 0x10($sp)
    /* EB188 800FA988 1000428C */  lw         $v0, 0x10($v0)
    /* EB18C 800FA98C 0800E003 */  jr         $ra
    /* EB190 800FA990 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CD_Getinfo
