.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching data_ready_callback, 0x8C

glabel data_ready_callback
    /* F8F98 80108798 1480023C */  lui        $v0, %hi(StRingIdx2)
    /* F8F9C 8010879C B46C428C */  lw         $v0, %lo(StRingIdx2)($v0)
    /* F8FA0 801087A0 1480033C */  lui        $v1, %hi(StRingAddr)
    /* F8FA4 801087A4 AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* F8FA8 801087A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F8FAC 801087AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* F8FB0 801087B0 40110200 */  sll        $v0, $v0, 5
    /* F8FB4 801087B4 21186200 */  addu       $v1, $v1, $v0
    /* F8FB8 801087B8 02000224 */  addiu      $v0, $zero, 0x2
    /* F8FBC 801087BC 000062A4 */  sh         $v0, 0x0($v1)
    /* F8FC0 801087C0 1580063C */  lui        $a2, %hi(D_801489D0)
    /* F8FC4 801087C4 D089C624 */  addiu      $a2, $a2, %lo(D_801489D0)
    /* F8FC8 801087C8 1F006288 */  lwl        $v0, 0x1F($v1)
    /* F8FCC 801087CC 1C006298 */  lwr        $v0, 0x1C($v1)
    /* F8FD0 801087D0 00000000 */  nop
    /* F8FD4 801087D4 0300C2A8 */  swl        $v0, 0x3($a2)
    /* F8FD8 801087D8 0000C2B8 */  swr        $v0, 0x0($a2)
    /* F8FDC 801087DC 0800628C */  lw         $v0, 0x8($v1)
    /* F8FE0 801087E0 1480033C */  lui        $v1, %hi(StRingIdx1)
    /* F8FE4 801087E4 B06C638C */  lw         $v1, %lo(StRingIdx1)($v1)
    /* F8FE8 801087E8 1480043C */  lui        $a0, %hi(StFunc1)
    /* F8FEC 801087EC 7448848C */  lw         $a0, %lo(StFunc1)($a0)
    /* F8FF0 801087F0 1580013C */  lui        $at, %hi(D_801489D4)
    /* F8FF4 801087F4 D48922AC */  sw         $v0, %lo(D_801489D4)($at)
    /* F8FF8 801087F8 1480013C */  lui        $at, %hi(StRingIdx2)
    /* F8FFC 801087FC 03008010 */  beqz       $a0, .L8010880C
    /* F9000 80108800 B46C23AC */   sw        $v1, %lo(StRingIdx2)($at)
    /* F9004 80108804 09F88000 */  jalr       $a0
    /* F9008 80108808 00000000 */   nop
  .L8010880C:
    /* F900C 8010880C 1480013C */  lui        $at, %hi(StFinalSector)
    /* F9010 80108810 A46C20AC */  sw         $zero, %lo(StFinalSector)($at)
    /* F9014 80108814 1000BF8F */  lw         $ra, 0x10($sp)
    /* F9018 80108818 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F901C 8010881C 0800E003 */  jr         $ra
    /* F9020 80108820 00000000 */   nop
endlabel data_ready_callback
