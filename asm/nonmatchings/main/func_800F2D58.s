.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F2D58, 0xA0

glabel func_800F2D58
    /* E3558 800F2D58 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E355C 800F2D5C 1000B0AF */  sw         $s0, 0x10($sp)
    /* E3560 800F2D60 1380103C */  lui        $s0, %hi(D_80134AF8)
    /* E3564 800F2D64 F84A1026 */  addiu      $s0, $s0, %lo(D_80134AF8)
    /* E3568 800F2D68 1400BFAF */  sw         $ra, 0x14($sp)
    /* E356C 800F2D6C 00000296 */  lhu        $v0, 0x0($s0)
    /* E3570 800F2D70 00000000 */  nop
    /* E3574 800F2D74 1C004010 */  beqz       $v0, .L800F2DE8
    /* E3578 800F2D78 21100000 */   addu      $v0, $zero, $zero
    /* E357C 800F2D7C 631A040C */  jal        EnterCriticalSection
    /* E3580 800F2D80 00000000 */   nop
    /* E3584 800F2D84 1380023C */  lui        $v0, %hi(D_80135B88)
    /* E3588 800F2D88 885B428C */  lw         $v0, %lo(D_80135B88)($v0)
    /* E358C 800F2D8C 1380043C */  lui        $a0, %hi(D_80135B8C)
    /* E3590 800F2D90 8C5B848C */  lw         $a0, %lo(D_80135B8C)($a0)
    /* E3594 800F2D94 00004394 */  lhu        $v1, 0x0($v0)
    /* E3598 800F2D98 00000000 */  nop
    /* E359C 800F2D9C 320003A6 */  sh         $v1, 0x32($s0)
    /* E35A0 800F2DA0 0000838C */  lw         $v1, 0x0($a0)
    /* E35A4 800F2DA4 1380043C */  lui        $a0, %hi(D_80135B84)
    /* E35A8 800F2DA8 845B848C */  lw         $a0, %lo(D_80135B84)($a0)
    /* E35AC 800F2DAC 340003AE */  sw         $v1, 0x34($s0)
    /* E35B0 800F2DB0 000040A4 */  sh         $zero, 0x0($v0)
    /* E35B4 800F2DB4 00004294 */  lhu        $v0, 0x0($v0)
    /* E35B8 800F2DB8 00000000 */  nop
    /* E35BC 800F2DBC 000082A4 */  sh         $v0, 0x0($a0)
    /* E35C0 800F2DC0 1380043C */  lui        $a0, %hi(D_80135B8C)
    /* E35C4 800F2DC4 8C5B848C */  lw         $a0, %lo(D_80135B8C)($a0)
    /* E35C8 800F2DC8 7777033C */  lui        $v1, (0x77777777 >> 16)
    /* E35CC 800F2DCC 0000828C */  lw         $v0, 0x0($a0)
    /* E35D0 800F2DD0 77776334 */  ori        $v1, $v1, (0x77777777 & 0xFFFF)
    /* E35D4 800F2DD4 24104300 */  and        $v0, $v0, $v1
    /* E35D8 800F2DD8 671A040C */  jal        ResetEntryInt
    /* E35DC 800F2DDC 000082AC */   sw        $v0, 0x0($a0)
    /* E35E0 800F2DE0 21100002 */  addu       $v0, $s0, $zero
    /* E35E4 800F2DE4 000040A4 */  sh         $zero, 0x0($v0)
  .L800F2DE8:
    /* E35E8 800F2DE8 1400BF8F */  lw         $ra, 0x14($sp)
    /* E35EC 800F2DEC 1000B08F */  lw         $s0, 0x10($sp)
    /* E35F0 800F2DF0 0800E003 */  jr         $ra
    /* E35F4 800F2DF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800F2D58
