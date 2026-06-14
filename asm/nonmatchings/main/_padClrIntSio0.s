.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padClrIntSio0, 0x90

glabel _padClrIntSio0
    /* F5D38 80105538 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F5D3C 8010553C 1380033C */  lui        $v1, %hi(D_80137CD8)
    /* F5D40 80105540 D87C638C */  lw         $v1, %lo(D_80137CD8)($v1)
    /* F5D44 80105544 1380043C */  lui        $a0, %hi(D_80137CDC)
    /* F5D48 80105548 DC7C848C */  lw         $a0, %lo(D_80137CDC)($a0)
    /* F5D4C 8010554C 7FFF0224 */  addiu      $v0, $zero, -0x81
    /* F5D50 80105550 1000BFAF */  sw         $ra, 0x10($sp)
    /* F5D54 80105554 000062AC */  sw         $v0, 0x0($v1)
    /* F5D58 80105558 04008294 */  lhu        $v0, 0x4($a0)
    /* F5D5C 8010555C 00000000 */  nop
    /* F5D60 80105560 80004230 */  andi       $v0, $v0, 0x80
    /* F5D64 80105564 0D004010 */  beqz       $v0, .L8010559C
    /* F5D68 80105568 00000000 */   nop
  .L8010556C:
    /* F5D6C 8010556C 0230040C */  jal        chkRC2wait
    /* F5D70 80105570 00000000 */   nop
    /* F5D74 80105574 10004014 */  bnez       $v0, .L801055B8
    /* F5D78 80105578 21100000 */   addu      $v0, $zero, $zero
    /* F5D7C 8010557C 1380023C */  lui        $v0, %hi(D_80137CDC)
    /* F5D80 80105580 DC7C428C */  lw         $v0, %lo(D_80137CDC)($v0)
    /* F5D84 80105584 00000000 */  nop
    /* F5D88 80105588 04004294 */  lhu        $v0, 0x4($v0)
    /* F5D8C 8010558C 00000000 */  nop
    /* F5D90 80105590 80004230 */  andi       $v0, $v0, 0x80
    /* F5D94 80105594 F5FF4014 */  bnez       $v0, .L8010556C
    /* F5D98 80105598 00000000 */   nop
  .L8010559C:
    /* F5D9C 8010559C 1380043C */  lui        $a0, %hi(D_80137CDC)
    /* F5DA0 801055A0 DC7C848C */  lw         $a0, %lo(D_80137CDC)($a0)
    /* F5DA4 801055A4 00000000 */  nop
    /* F5DA8 801055A8 0A008394 */  lhu        $v1, 0xA($a0)
    /* F5DAC 801055AC 01000224 */  addiu      $v0, $zero, 0x1
    /* F5DB0 801055B0 10006334 */  ori        $v1, $v1, 0x10
    /* F5DB4 801055B4 0A0083A4 */  sh         $v1, 0xA($a0)
  .L801055B8:
    /* F5DB8 801055B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* F5DBC 801055BC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F5DC0 801055C0 0800E003 */  jr         $ra
    /* F5DC4 801055C4 00000000 */   nop
endlabel _padClrIntSio0
