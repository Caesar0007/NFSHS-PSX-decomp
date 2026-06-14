.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii, 0x108

glabel __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
    /* 603FC 8006FBFC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 60400 8006FC00 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 60404 8006FC04 4800B38F */  lw         $s3, 0x48($sp)
    /* 60408 8006FC08 2400B5AF */  sw         $s5, 0x24($sp)
    /* 6040C 8006FC0C 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 60410 8006FC10 2800B6AF */  sw         $s6, 0x28($sp)
    /* 60414 8006FC14 5000B68F */  lw         $s6, 0x50($sp)
    /* 60418 8006FC18 3000BEAF */  sw         $fp, 0x30($sp)
    /* 6041C 8006FC1C 21F08000 */  addu       $fp, $a0, $zero
    /* 60420 8006FC20 1000B0AF */  sw         $s0, 0x10($sp)
    /* 60424 8006FC24 2180A000 */  addu       $s0, $a1, $zero
    /* 60428 8006FC28 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6042C 8006FC2C 2190C000 */  addu       $s2, $a2, $zero
    /* 60430 8006FC30 2000B4AF */  sw         $s4, 0x20($sp)
    /* 60434 8006FC34 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 60438 8006FC38 5400B78F */  lw         $s7, 0x54($sp)
    /* 6043C 8006FC3C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 60440 8006FC40 5800B18F */  lw         $s1, 0x58($sp)
    /* 60444 8006FC44 3400BFAF */  sw         $ra, 0x34($sp)
    /* 60448 8006FC48 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 6044C 8006FC4C 21A0E000 */   addu      $s4, $a3, $zero
    /* 60450 8006FC50 0800C427 */  addiu      $a0, $fp, 0x8
    /* 60454 8006FC54 21280002 */  addu       $a1, $s0, $zero
    /* 60458 8006FC58 21304002 */  addu       $a2, $s2, $zero
    /* 6045C 8006FC5C 0580023C */  lui        $v0, %hi(_vt_13AIState_Chase)
    /* 60460 8006FC60 E0554224 */  addiu      $v0, $v0, %lo(_vt_13AIState_Chase)
    /* 60464 8006FC64 0400C2AF */  sw         $v0, 0x4($fp)
    /* 60468 8006FC68 8A6A010C */  jal        __10AIDelayCarP8Car_tObjT1i
    /* 6046C 8006FC6C 21382002 */   addu      $a3, $s1, $zero
    /* 60470 8006FC70 2120C003 */  addu       $a0, $fp, $zero
    /* 60474 8006FC74 21284002 */  addu       $a1, $s2, $zero
    /* 60478 8006FC78 21308002 */  addu       $a2, $s4, $zero
    /* 6047C 8006FC7C 63BF010C */  jal        SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
    /* 60480 8006FC80 7C00D3AF */   sw        $s3, 0x7C($fp)
    /* 60484 8006FC84 0000C28F */  lw         $v0, 0x0($fp)
    /* 60488 8006FC88 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 6048C 8006FC8C 3C0743AC */  sw         $v1, 0x73C($v0)
    /* 60490 8006FC90 0000C28F */  lw         $v0, 0x0($fp)
    /* 60494 8006FC94 00000000 */  nop
    /* 60498 8006FC98 400743AC */  sw         $v1, 0x740($v0)
    /* 6049C 8006FC9C 0000C38F */  lw         $v1, 0x0($fp)
    /* 604A0 8006FCA0 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 604A4 8006FCA4 8000D5AF */  sw         $s5, 0x80($fp)
    /* 604A8 8006FCA8 8400D6AF */  sw         $s6, 0x84($fp)
    /* 604AC 8006FCAC 8800D7AF */  sw         $s7, 0x88($fp)
    /* 604B0 8006FCB0 8C00C0AF */  sw         $zero, 0x8C($fp)
    /* 604B4 8006FCB4 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 604B8 8006FCB8 5405638C */  lw         $v1, 0x554($v1)
    /* 604BC 8006FCBC 02004014 */  bnez       $v0, .L8006FCC8
    /* 604C0 8006FCC0 27100300 */   nor       $v0, $zero, $v1
    /* 604C4 8006FCC4 01006238 */  xori       $v0, $v1, 0x1
  .L8006FCC8:
    /* 604C8 8006FCC8 4400C0AF */  sw         $zero, 0x44($fp)
    /* 604CC 8006FCCC 2110C003 */  addu       $v0, $fp, $zero
    /* 604D0 8006FCD0 9000C0AF */  sw         $zero, 0x90($fp)
    /* 604D4 8006FCD4 3400BF8F */  lw         $ra, 0x34($sp)
    /* 604D8 8006FCD8 3000BE8F */  lw         $fp, 0x30($sp)
    /* 604DC 8006FCDC 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 604E0 8006FCE0 2800B68F */  lw         $s6, 0x28($sp)
    /* 604E4 8006FCE4 2400B58F */  lw         $s5, 0x24($sp)
    /* 604E8 8006FCE8 2000B48F */  lw         $s4, 0x20($sp)
    /* 604EC 8006FCEC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 604F0 8006FCF0 1800B28F */  lw         $s2, 0x18($sp)
    /* 604F4 8006FCF4 1400B18F */  lw         $s1, 0x14($sp)
    /* 604F8 8006FCF8 1000B08F */  lw         $s0, 0x10($sp)
    /* 604FC 8006FCFC 0800E003 */  jr         $ra
    /* 60500 8006FD00 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
