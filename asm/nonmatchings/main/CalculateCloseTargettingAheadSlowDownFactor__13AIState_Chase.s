.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase, 0x8C

glabel CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase
    /* 60B7C 8007037C 1D00023C */  lui        $v0, (0x1DFFFF >> 16)
    /* 60B80 80070380 6800838C */  lw         $v1, 0x68($a0)
    /* 60B84 80070384 FFFF4234 */  ori        $v0, $v0, (0x1DFFFF & 0xFFFF)
    /* 60B88 80070388 02006104 */  bgez       $v1, .L80070394
    /* 60B8C 8007038C 00000000 */   nop
    /* 60B90 80070390 23180300 */  negu       $v1, $v1
  .L80070394:
    /* 60B94 80070394 2A104300 */  slt        $v0, $v0, $v1
    /* 60B98 80070398 03004014 */  bnez       $v0, .L800703A8
    /* 60B9C 8007039C 99990534 */   ori       $a1, $zero, 0x9999
    /* 60BA0 800703A0 00C10108 */  j          .L80070400
    /* 60BA4 800703A4 33F30534 */   ori       $a1, $zero, 0xF333
  .L800703A8:
    /* 60BA8 800703A8 3100023C */  lui        $v0, (0x31FFFF >> 16)
    /* 60BAC 800703AC FFFF4234 */  ori        $v0, $v0, (0x31FFFF & 0xFFFF)
    /* 60BB0 800703B0 2A104300 */  slt        $v0, $v0, $v1
    /* 60BB4 800703B4 05004010 */  beqz       $v0, .L800703CC
    /* 60BB8 800703B8 6300023C */   lui       $v0, (0x63FFFF >> 16)
    /* 60BBC 800703BC FFFF4234 */  ori        $v0, $v0, (0x63FFFF & 0xFFFF)
    /* 60BC0 800703C0 2A104300 */  slt        $v0, $v0, $v1
    /* 60BC4 800703C4 03004014 */  bnez       $v0, .L800703D4
    /* 60BC8 800703C8 9500023C */   lui       $v0, (0x95FFFF >> 16)
  .L800703CC:
    /* 60BCC 800703CC 00C10108 */  j          .L80070400
    /* 60BD0 800703D0 CCCC0534 */   ori       $a1, $zero, 0xCCCC
  .L800703D4:
    /* 60BD4 800703D4 FFFF4234 */  ori        $v0, $v0, (0x95FFFF & 0xFFFF)
    /* 60BD8 800703D8 2A104300 */  slt        $v0, $v0, $v1
    /* 60BDC 800703DC 03004014 */  bnez       $v0, .L800703EC
    /* 60BE0 800703E0 C700023C */   lui       $v0, (0xC7FFFF >> 16)
    /* 60BE4 800703E4 00C10108 */  j          .L80070400
    /* 60BE8 800703E8 00C00534 */   ori       $a1, $zero, 0xC000
  .L800703EC:
    /* 60BEC 800703EC FFFF4234 */  ori        $v0, $v0, (0xC7FFFF & 0xFFFF)
    /* 60BF0 800703F0 2A104300 */  slt        $v0, $v0, $v1
    /* 60BF4 800703F4 02004014 */  bnez       $v0, .L80070400
    /* 60BF8 800703F8 00000000 */   nop
    /* 60BFC 800703FC 33B30534 */  ori        $a1, $zero, 0xB333
  .L80070400:
    /* 60C00 80070400 0800E003 */  jr         $ra
    /* 60C04 80070404 2110A000 */   addu      $v0, $a1, $zero
endlabel CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase
