.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_open, 0xC0

glabel FILE_open
    /* DCB6C 800EC36C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DCB70 800EC370 2000B4AF */  sw         $s4, 0x20($sp)
    /* DCB74 800EC374 21A08000 */  addu       $s4, $a0, $zero
    /* DCB78 800EC378 1400B1AF */  sw         $s1, 0x14($sp)
    /* DCB7C 800EC37C 2188A000 */  addu       $s1, $a1, $zero
    /* DCB80 800EC380 1800B2AF */  sw         $s2, 0x18($sp)
    /* DCB84 800EC384 2190C000 */  addu       $s2, $a2, $zero
    /* DCB88 800EC388 1000B0AF */  sw         $s0, 0x10($sp)
    /* DCB8C 800EC38C 2180E000 */  addu       $s0, $a3, $zero
    /* DCB90 800EC390 2400BFAF */  sw         $ra, 0x24($sp)
    /* DCB94 800EC394 37B4030C */  jal        reserveop
    /* DCB98 800EC398 1C00B3AF */   sw        $s3, 0x1C($sp)
    /* DCB9C 800EC39C 0FFF043C */  lui        $a0, (0xFF0FFFFF >> 16)
    /* DCBA0 800EC3A0 21984000 */  addu       $s3, $v0, $zero
    /* DCBA4 800EC3A4 FFFF8434 */  ori        $a0, $a0, (0xFF0FFFFF & 0xFFFF)
    /* DCBA8 800EC3A8 0000638E */  lw         $v1, 0x0($s3)
    /* DCBAC 800EC3AC 2000023C */  lui        $v0, (0x200000 >> 16)
    /* DCBB0 800EC3B0 140070AE */  sw         $s0, 0x14($s3)
    /* DCBB4 800EC3B4 180071AE */  sw         $s1, 0x18($s3)
    /* DCBB8 800EC3B8 100072AE */  sw         $s2, 0x10($s3)
    /* DCBBC 800EC3BC 24186400 */  and        $v1, $v1, $a0
    /* DCBC0 800EC3C0 25186200 */  or         $v1, $v1, $v0
    /* DCBC4 800EC3C4 90B4030C */  jal        reservehandle
    /* DCBC8 800EC3C8 000063AE */   sw        $v1, 0x0($s3)
    /* DCBCC 800EC3CC 05004014 */  bnez       $v0, .L800EC3E4
    /* DCBD0 800EC3D0 240062AE */   sw        $v0, 0x24($s3)
    /* DCBD4 800EC3D4 02000224 */  addiu      $v0, $zero, 0x2
    /* DCBD8 800EC3D8 0C0062AE */  sw         $v0, 0xC($s3)
    /* DCBDC 800EC3DC 35B4030C */  jal        func_800ED0D4
    /* DCBE0 800EC3E0 21206002 */   addu      $a0, $s3, $zero
  .L800EC3E4:
    /* DCBE4 800EC3E4 DDA7030C */  jal        strlen
    /* DCBE8 800EC3E8 21208002 */   addu      $a0, $s4, $zero
    /* DCBEC 800EC3EC 21288002 */  addu       $a1, $s4, $zero
    /* DCBF0 800EC3F0 2400648E */  lw         $a0, 0x24($s3)
    /* DCBF4 800EC3F4 40000624 */  addiu      $a2, $zero, 0x40
    /* DCBF8 800EC3F8 41D8030C */  jal        strncpy
    /* DCBFC 800EC3FC 0C008424 */   addiu     $a0, $a0, 0xC
    /* DCC00 800EC400 E6B2030C */  jal        iFILE_ExecCommand
    /* DCC04 800EC404 21206002 */   addu      $a0, $s3, $zero
    /* DCC08 800EC408 0000628E */  lw         $v0, 0x0($s3)
    /* DCC0C 800EC40C 2400BF8F */  lw         $ra, 0x24($sp)
    /* DCC10 800EC410 2000B48F */  lw         $s4, 0x20($sp)
    /* DCC14 800EC414 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DCC18 800EC418 1800B28F */  lw         $s2, 0x18($sp)
    /* DCC1C 800EC41C 1400B18F */  lw         $s1, 0x14($sp)
    /* DCC20 800EC420 1000B08F */  lw         $s0, 0x10($sp)
    /* DCC24 800EC424 0800E003 */  jr         $ra
    /* DCC28 800EC428 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FILE_open
