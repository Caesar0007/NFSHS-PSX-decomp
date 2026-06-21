.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80028B64, 0x130

glabel func_80028B64
    /* 19364 80028B64 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 19368 80028B68 2000B4AF */  sw         $s4, 0x20($sp)
    /* 1936C 80028B6C 21A08000 */  addu       $s4, $a0, $zero
    /* 19370 80028B70 1180023C */  lui        $v0, %hi(D_80114604)
    /* 19374 80028B74 2400BFAF */  sw         $ra, 0x24($sp)
    /* 19378 80028B78 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1937C 80028B7C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 19380 80028B80 1400B1AF */  sw         $s1, 0x14($sp)
    /* 19384 80028B84 1000B0AF */  sw         $s0, 0x10($sp)
    /* 19388 80028B88 580280AE */  sw         $zero, 0x258($s4)
    /* 1938C 80028B8C 5C0280AE */  sw         $zero, 0x25C($s4)
    /* 19390 80028B90 04464390 */  lbu        $v1, %lo(D_80114604)($v0)
    /* 19394 80028B94 01000224 */  addiu      $v0, $zero, 0x1
    /* 19398 80028B98 36006214 */  bne        $v1, $v0, .L80028C74
    /* 1939C 80028B9C 21300000 */   addu      $a2, $zero, $zero
    /* 193A0 80028BA0 06008386 */  lh         $v1, 0x6($s4)
    /* 193A4 80028BA4 00000000 */  nop
    /* 193A8 80028BA8 2A10C300 */  slt        $v0, $a2, $v1
    /* 193AC 80028BAC 1B004010 */  beqz       $v0, .L80028C1C
    /* 193B0 80028BB0 2120C000 */   addu      $a0, $a2, $zero
    /* 193B4 80028BB4 07000724 */  addiu      $a3, $zero, 0x7
    /* 193B8 80028BB8 21286000 */  addu       $a1, $v1, $zero
    /* 193BC 80028BBC 001C0400 */  sll        $v1, $a0, 16
  .L80028BC0:
    /* 193C0 80028BC0 031C0300 */  sra        $v1, $v1, 16
    /* 193C4 80028BC4 40100300 */  sll        $v0, $v1, 1
    /* 193C8 80028BC8 21104300 */  addu       $v0, $v0, $v1
    /* 193CC 80028BCC 00190200 */  sll        $v1, $v0, 4
    /* 193D0 80028BD0 21104300 */  addu       $v0, $v0, $v1
    /* 193D4 80028BD4 80100200 */  sll        $v0, $v0, 2
    /* 193D8 80028BD8 21188202 */  addu       $v1, $s4, $v0
    /* 193DC 80028BDC 0A006290 */  lbu        $v0, 0xA($v1)
    /* 193E0 80028BE0 00000000 */  nop
    /* 193E4 80028BE4 23004714 */  bne        $v0, $a3, .L80028C74
    /* 193E8 80028BE8 00000000 */   nop
    /* 193EC 80028BEC 08006380 */  lb         $v1, 0x8($v1)
    /* 193F0 80028BF0 00000000 */  nop
    /* 193F4 80028BF4 2A10C300 */  slt        $v0, $a2, $v1
    /* 193F8 80028BF8 02004010 */  beqz       $v0, .L80028C04
    /* 193FC 80028BFC 01008224 */   addiu     $v0, $a0, 0x1
    /* 19400 80028C00 21306000 */  addu       $a2, $v1, $zero
  .L80028C04:
    /* 19404 80028C04 21204000 */  addu       $a0, $v0, $zero
    /* 19408 80028C08 00140200 */  sll        $v0, $v0, 16
    /* 1940C 80028C0C 03140200 */  sra        $v0, $v0, 16
    /* 19410 80028C10 2A104500 */  slt        $v0, $v0, $a1
    /* 19414 80028C14 EAFF4014 */  bnez       $v0, .L80028BC0
    /* 19418 80028C18 001C0400 */   sll       $v1, $a0, 16
  .L80028C1C:
    /* 1941C 80028C1C 1480113C */  lui        $s1, %hi(missionManager)
    /* 19420 80028C20 B8D23126 */  addiu      $s1, $s1, %lo(missionManager)
    /* 19424 80028C24 21202002 */  addu       $a0, $s1, $zero
    /* 19428 80028C28 01000524 */  addiu      $a1, $zero, 0x1
    /* 1942C 80028C2C 1180103C */  lui        $s0, %hi(frontEnd)
    /* 19430 80028C30 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 19434 80028C34 2B011292 */  lbu        $s2, 0x12B($s0)
    /* 19438 80028C38 2C011392 */  lbu        $s3, 0x12C($s0)
    /* 1943C 80028C3C EAFFC224 */  addiu      $v0, $a2, -0x16
    /* 19440 80028C40 2B0102A2 */  sb         $v0, 0x12B($s0)
    /* 19444 80028C44 1FD0000C */  jal        LoadDescription__15tMissionManagerb
    /* 19448 80028C48 2C0100A2 */   sb        $zero, 0x12C($s0)
    /* 1944C 80028C4C 21202002 */  addu       $a0, $s1, $zero
    /* 19450 80028C50 97D0000C */  jal        GetMissionToRace__15tMissionManagerPP12tMissionInfo
    /* 19454 80028C54 58028526 */   addiu     $a1, $s4, 0x258
    /* 19458 80028C58 21202002 */  addu       $a0, $s1, $zero
    /* 1945C 80028C5C 2B010592 */  lbu        $a1, 0x12B($s0)
    /* 19460 80028C60 2C010692 */  lbu        $a2, 0x12C($s0)
    /* 19464 80028C64 7DD0000C */  jal        GetMissionStages__15tMissionManagerssPP10tStageInfo
    /* 19468 80028C68 5C028726 */   addiu     $a3, $s4, 0x25C
    /* 1946C 80028C6C 2B0112A2 */  sb         $s2, 0x12B($s0)
    /* 19470 80028C70 2C0113A2 */  sb         $s3, 0x12C($s0)
  .L80028C74:
    /* 19474 80028C74 2400BF8F */  lw         $ra, 0x24($sp)
    /* 19478 80028C78 2000B48F */  lw         $s4, 0x20($sp)
    /* 1947C 80028C7C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 19480 80028C80 1800B28F */  lw         $s2, 0x18($sp)
    /* 19484 80028C84 1400B18F */  lw         $s1, 0x14($sp)
    /* 19488 80028C88 1000B08F */  lw         $s0, 0x10($sp)
    /* 1948C 80028C8C 0800E003 */  jr         $ra
    /* 19490 80028C90 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_80028B64
