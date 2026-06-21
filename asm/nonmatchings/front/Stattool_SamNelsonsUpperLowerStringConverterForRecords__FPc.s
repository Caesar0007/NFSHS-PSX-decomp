.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc, 0x7C

glabel Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
    /* 3B3D0 8004ABD0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3B3D4 8004ABD4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3B3D8 8004ABD8 21808000 */  addu       $s0, $a0, $zero
    /* 3B3DC 8004ABDC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3B3E0 8004ABE0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3B3E4 8004ABE4 549A000C */  jal        s_lower__FPc
    /* 3B3E8 8004ABE8 1400B1AF */   sw        $s1, 0x14($sp)
    /* 3B3EC 8004ABEC 00001192 */  lbu        $s1, 0x0($s0)
    /* 3B3F0 8004ABF0 AD2A010C */  jal        UserNameUpperCaseOneLetter__FPc
    /* 3B3F4 8004ABF4 21200002 */   addu      $a0, $s0, $zero
    /* 3B3F8 8004ABF8 01001026 */  addiu      $s0, $s0, 0x1
    /* 3B3FC 8004ABFC 00000292 */  lbu        $v0, 0x0($s0)
    /* 3B400 8004AC00 00000000 */  nop
    /* 3B404 8004AC04 0B004010 */  beqz       $v0, .L8004AC34
    /* 3B408 8004AC08 20001224 */   addiu     $s2, $zero, 0x20
  .L8004AC0C:
    /* 3B40C 8004AC0C 03003216 */  bne        $s1, $s2, .L8004AC1C
    /* 3B410 8004AC10 00000000 */   nop
    /* 3B414 8004AC14 AD2A010C */  jal        UserNameUpperCaseOneLetter__FPc
    /* 3B418 8004AC18 21200002 */   addu      $a0, $s0, $zero
  .L8004AC1C:
    /* 3B41C 8004AC1C 00001192 */  lbu        $s1, 0x0($s0)
    /* 3B420 8004AC20 01001026 */  addiu      $s0, $s0, 0x1
    /* 3B424 8004AC24 00000292 */  lbu        $v0, 0x0($s0)
    /* 3B428 8004AC28 00000000 */  nop
    /* 3B42C 8004AC2C F7FF4014 */  bnez       $v0, .L8004AC0C
    /* 3B430 8004AC30 00000000 */   nop
  .L8004AC34:
    /* 3B434 8004AC34 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3B438 8004AC38 1800B28F */  lw         $s2, 0x18($sp)
    /* 3B43C 8004AC3C 1400B18F */  lw         $s1, 0x14($sp)
    /* 3B440 8004AC40 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B444 8004AC44 0800E003 */  jr         $ra
    /* 3B448 8004AC48 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
