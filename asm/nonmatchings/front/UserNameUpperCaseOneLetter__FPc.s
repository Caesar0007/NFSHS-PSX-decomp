.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UserNameUpperCaseOneLetter__FPc, 0x11C

glabel UserNameUpperCaseOneLetter__FPc
    /* 3B2B4 8004AAB4 00008390 */  lbu        $v1, 0x0($a0)
    /* 3B2B8 8004AAB8 00000000 */  nop
    /* 3B2BC 8004AABC 9FFF6224 */  addiu      $v0, $v1, -0x61
    /* 3B2C0 8004AAC0 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* 3B2C4 8004AAC4 03004010 */  beqz       $v0, .L8004AAD4
    /* 3B2C8 8004AAC8 E0006224 */   addiu     $v0, $v1, 0xE0
    /* 3B2CC 8004AACC 0800E003 */  jr         $ra
    /* 3B2D0 8004AAD0 000082A0 */   sb        $v0, 0x0($a0)
  .L8004AAD4:
    /* 3B2D4 8004AAD4 00008290 */  lbu        $v0, 0x0($a0)
    /* 3B2D8 8004AAD8 00000000 */  nop
    /* 3B2DC 8004AADC 20FF4324 */  addiu      $v1, $v0, -0xE0
    /* 3B2E0 8004AAE0 1D00622C */  sltiu      $v0, $v1, 0x1D
    /* 3B2E4 8004AAE4 38004010 */  beqz       $v0, .L8004ABC8
    /* 3B2E8 8004AAE8 0180023C */   lui       $v0, %hi(jtbl_80012538)
    /* 3B2EC 8004AAEC 38254224 */  addiu      $v0, $v0, %lo(jtbl_80012538)
    /* 3B2F0 8004AAF0 80180300 */  sll        $v1, $v1, 2
    /* 3B2F4 8004AAF4 21186200 */  addu       $v1, $v1, $v0
    /* 3B2F8 8004AAF8 0000628C */  lw         $v0, 0x0($v1)
    /* 3B2FC 8004AAFC 00000000 */  nop
    /* 3B300 8004AB00 08004000 */  jr         $v0
    /* 3B304 8004AB04 00000000 */   nop
  jlabel .L8004AB08
    /* 3B308 8004AB08 C4000224 */  addiu      $v0, $zero, 0xC4
    /* 3B30C 8004AB0C 0800E003 */  jr         $ra
    /* 3B310 8004AB10 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB14
    /* 3B314 8004AB14 D6000224 */  addiu      $v0, $zero, 0xD6
    /* 3B318 8004AB18 0800E003 */  jr         $ra
    /* 3B31C 8004AB1C 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB20
    /* 3B320 8004AB20 DC000224 */  addiu      $v0, $zero, 0xDC
    /* 3B324 8004AB24 0800E003 */  jr         $ra
    /* 3B328 8004AB28 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB2C
    /* 3B32C 8004AB2C 45000224 */  addiu      $v0, $zero, 0x45
    /* 3B330 8004AB30 0800E003 */  jr         $ra
    /* 3B334 8004AB34 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB38
    /* 3B338 8004AB38 41000224 */  addiu      $v0, $zero, 0x41
    /* 3B33C 8004AB3C 0800E003 */  jr         $ra
    /* 3B340 8004AB40 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB44
    /* 3B344 8004AB44 49000224 */  addiu      $v0, $zero, 0x49
    /* 3B348 8004AB48 0800E003 */  jr         $ra
    /* 3B34C 8004AB4C 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB50
    /* 3B350 8004AB50 4F000224 */  addiu      $v0, $zero, 0x4F
    /* 3B354 8004AB54 0800E003 */  jr         $ra
    /* 3B358 8004AB58 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB5C
    /* 3B35C 8004AB5C 55000224 */  addiu      $v0, $zero, 0x55
    /* 3B360 8004AB60 0800E003 */  jr         $ra
    /* 3B364 8004AB64 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB68
    /* 3B368 8004AB68 D1000224 */  addiu      $v0, $zero, 0xD1
    /* 3B36C 8004AB6C 0800E003 */  jr         $ra
    /* 3B370 8004AB70 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB74
    /* 3B374 8004AB74 C5000224 */  addiu      $v0, $zero, 0xC5
    /* 3B378 8004AB78 0800E003 */  jr         $ra
    /* 3B37C 8004AB7C 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB80
    /* 3B380 8004AB80 C0000224 */  addiu      $v0, $zero, 0xC0
    /* 3B384 8004AB84 0800E003 */  jr         $ra
    /* 3B388 8004AB88 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004AB8C
    /* 3B38C 8004AB8C 1180023C */  lui        $v0, %hi(D_80114940)
    /* 3B390 8004AB90 40494390 */  lbu        $v1, %lo(D_80114940)($v0)
    /* 3B394 8004AB94 04000224 */  addiu      $v0, $zero, 0x4
    /* 3B398 8004AB98 02006214 */  bne        $v1, $v0, .L8004ABA4
    /* 3B39C 8004AB9C 45000224 */   addiu     $v0, $zero, 0x45
    /* 3B3A0 8004ABA0 C8000224 */  addiu      $v0, $zero, 0xC8
  .L8004ABA4:
    /* 3B3A4 8004ABA4 000082A0 */  sb         $v0, 0x0($a0)
  jlabel .L8004ABA8
    /* 3B3A8 8004ABA8 CC000224 */  addiu      $v0, $zero, 0xCC
    /* 3B3AC 8004ABAC 0800E003 */  jr         $ra
    /* 3B3B0 8004ABB0 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004ABB4
    /* 3B3B4 8004ABB4 D2000224 */  addiu      $v0, $zero, 0xD2
    /* 3B3B8 8004ABB8 0800E003 */  jr         $ra
    /* 3B3BC 8004ABBC 000082A0 */   sb        $v0, 0x0($a0)
  jlabel .L8004ABC0
    /* 3B3C0 8004ABC0 D9000224 */  addiu      $v0, $zero, 0xD9
    /* 3B3C4 8004ABC4 000082A0 */  sb         $v0, 0x0($a0)
  jlabel .L8004ABC8
    /* 3B3C8 8004ABC8 0800E003 */  jr         $ra
    /* 3B3CC 8004ABCC 00000000 */   nop
endlabel UserNameUpperCaseOneLetter__FPc
