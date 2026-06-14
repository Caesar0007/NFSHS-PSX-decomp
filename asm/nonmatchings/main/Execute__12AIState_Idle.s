.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__12AIState_Idle, 0xBC

glabel Execute__12AIState_Idle
    /* 60334 8006FB34 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 60338 8006FB38 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6033C 8006FB3C 21808000 */  addu       $s0, $a0, $zero
    /* 60340 8006FB40 1400BFAF */  sw         $ra, 0x14($sp)
    /* 60344 8006FB44 0C00028E */  lw         $v0, 0xC($s0)
    /* 60348 8006FB48 00000000 */  nop
    /* 6034C 8006FB4C 09004010 */  beqz       $v0, .L8006FB74
    /* 60350 8006FB50 0100043C */   lui       $a0, (0x1FFFE >> 16)
    /* 60354 8006FB54 0000028E */  lw         $v0, 0x0($s0)
    /* 60358 8006FB58 00000000 */  nop
    /* 6035C 8006FB5C 5C0540AC */  sw         $zero, 0x55C($v0)
    /* 60360 8006FB60 0000038E */  lw         $v1, 0x0($s0)
    /* 60364 8006FB64 00000000 */  nop
    /* 60368 8006FB68 7405628C */  lw         $v0, 0x574($v1)
    /* 6036C 8006FB6C F8BE0108 */  j          .L8006FBE0
    /* 60370 8006FB70 580562AC */   sw        $v0, 0x558($v1)
  .L8006FB74:
    /* 60374 8006FB74 0000058E */  lw         $a1, 0x0($s0)
    /* 60378 8006FB78 0800038E */  lw         $v1, 0x8($s0)
    /* 6037C 8006FB7C 7405A28C */  lw         $v0, 0x574($a1)
    /* 60380 8006FB80 FEFF8434 */  ori        $a0, $a0, (0x1FFFE & 0xFFFF)
    /* 60384 8006FB84 23104300 */  subu       $v0, $v0, $v1
    /* 60388 8006FB88 FFFF0334 */  ori        $v1, $zero, 0xFFFF
    /* 6038C 8006FB8C 21104300 */  addu       $v0, $v0, $v1
    /* 60390 8006FB90 2B208200 */  sltu       $a0, $a0, $v0
    /* 60394 8006FB94 03008014 */  bnez       $a0, .L8006FBA4
    /* 60398 8006FB98 00000000 */   nop
    /* 6039C 8006FB9C F4BE0108 */  j          .L8006FBD0
    /* 603A0 8006FBA0 5C05A0AC */   sw        $zero, 0x55C($a1)
  .L8006FBA4:
    /* 603A4 8006FBA4 77BB010C */  jal        AISpeeds_CalcDesiredSpeed__FP8Car_tObj
    /* 603A8 8006FBA8 2120A000 */   addu      $a0, $a1, $zero
    /* 603AC 8006FBAC 0000038E */  lw         $v1, 0x0($s0)
    /* 603B0 8006FBB0 00000000 */  nop
    /* 603B4 8006FBB4 5C05628C */  lw         $v0, 0x55C($v1)
    /* 603B8 8006FBB8 00000000 */  nop
    /* 603BC 8006FBBC 02004104 */  bgez       $v0, .L8006FBC8
    /* 603C0 8006FBC0 00000000 */   nop
    /* 603C4 8006FBC4 03004224 */  addiu      $v0, $v0, 0x3
  .L8006FBC8:
    /* 603C8 8006FBC8 83100200 */  sra        $v0, $v0, 2
    /* 603CC 8006FBCC 5C0562AC */  sw         $v0, 0x55C($v1)
  .L8006FBD0:
    /* 603D0 8006FBD0 0000038E */  lw         $v1, 0x0($s0)
    /* 603D4 8006FBD4 0800028E */  lw         $v0, 0x8($s0)
    /* 603D8 8006FBD8 00000000 */  nop
    /* 603DC 8006FBDC 580562AC */  sw         $v0, 0x558($v1)
  .L8006FBE0:
    /* 603E0 8006FBE0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 603E4 8006FBE4 1000B08F */  lw         $s0, 0x10($sp)
    /* 603E8 8006FBE8 0800E003 */  jr         $ra
    /* 603EC 8006FBEC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Execute__12AIState_Idle
