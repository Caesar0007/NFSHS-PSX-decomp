.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindClosestCop__17AIHigh_BTC_AIPerp, 0x100

glabel FindClosestCop__17AIHigh_BTC_AIPerp
    /* 50FB4 800607B4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 50FB8 800607B8 2400B5AF */  sw         $s5, 0x24($sp)
    /* 50FBC 800607BC 21A88000 */  addu       $s5, $a0, $zero
    /* 50FC0 800607C0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 50FC4 800607C4 0F27143C */  lui        $s4, (0x270F0000 >> 16)
    /* 50FC8 800607C8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 50FCC 800607CC 21908002 */  addu       $s2, $s4, $zero
    /* 50FD0 800607D0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 50FD4 800607D4 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 50FD8 800607D8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 50FDC 800607DC 21880000 */  addu       $s1, $zero, $zero
    /* 50FE0 800607E0 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 50FE4 800607E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50FE8 800607E8 48FA5024 */  addiu      $s0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 50FEC 800607EC 2800BFAF */  sw         $ra, 0x28($sp)
  .L800607F0:
    /* 50FF0 800607F0 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 50FF4 800607F4 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 50FF8 800607F8 00000000 */  nop
    /* 50FFC 800607FC 2A102202 */  slt        $v0, $s1, $v0
    /* 51000 80060800 19004010 */  beqz       $v0, .L80060868
    /* 51004 80060804 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 51008 80060808 0000058E */  lw         $a1, 0x0($s0)
    /* 5100C 8006080C 00000000 */  nop
    /* 51010 80060810 6002A28C */  lw         $v0, 0x260($a1)
    /* 51014 80060814 00000000 */  nop
    /* 51018 80060818 00024230 */  andi       $v0, $v0, 0x200
    /* 5101C 8006081C 0F004010 */  beqz       $v0, .L8006085C
    /* 51020 80060820 00000000 */   nop
    /* 51024 80060824 0000A48E */  lw         $a0, 0x0($s5)
    /* 51028 80060828 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 5102C 8006082C 00000000 */   nop
    /* 51030 80060830 21184000 */  addu       $v1, $v0, $zero
    /* 51034 80060834 02004104 */  bgez       $v0, .L80060840
    /* 51038 80060838 21204000 */   addu      $a0, $v0, $zero
    /* 5103C 8006083C 23200400 */  negu       $a0, $a0
  .L80060840:
    /* 51040 80060840 2A109200 */  slt        $v0, $a0, $s2
    /* 51044 80060844 05004010 */  beqz       $v0, .L8006085C
    /* 51048 80060848 00000000 */   nop
    /* 5104C 8006084C 21A06000 */  addu       $s4, $v1, $zero
    /* 51050 80060850 0000028E */  lw         $v0, 0x0($s0)
    /* 51054 80060854 21908000 */  addu       $s2, $a0, $zero
    /* 51058 80060858 5402538C */  lw         $s3, 0x254($v0)
  .L8006085C:
    /* 5105C 8006085C 04001026 */  addiu      $s0, $s0, 0x4
    /* 51060 80060860 FC810108 */  j          .L800607F0
    /* 51064 80060864 01003126 */   addiu     $s1, $s1, 0x1
  .L80060868:
    /* 51068 80060868 03006216 */  bne        $s3, $v0, .L80060878
    /* 5106C 8006086C 1180023C */   lui       $v0, %hi(Cars_gList)
    /* 51070 80060870 24820108 */  j          .L80060890
    /* 51074 80060874 A400A0AE */   sw        $zero, 0xA4($s5)
  .L80060878:
    /* 51078 80060878 DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 5107C 8006087C 80181300 */  sll        $v1, $s3, 2
    /* 51080 80060880 21186200 */  addu       $v1, $v1, $v0
    /* 51084 80060884 0000628C */  lw         $v0, 0x0($v1)
    /* 51088 80060888 A800B4AE */  sw         $s4, 0xA8($s5)
    /* 5108C 8006088C A400A2AE */  sw         $v0, 0xA4($s5)
  .L80060890:
    /* 51090 80060890 2800BF8F */  lw         $ra, 0x28($sp)
    /* 51094 80060894 2400B58F */  lw         $s5, 0x24($sp)
    /* 51098 80060898 2000B48F */  lw         $s4, 0x20($sp)
    /* 5109C 8006089C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 510A0 800608A0 1800B28F */  lw         $s2, 0x18($sp)
    /* 510A4 800608A4 1400B18F */  lw         $s1, 0x14($sp)
    /* 510A8 800608A8 1000B08F */  lw         $s0, 0x10($sp)
    /* 510AC 800608AC 0800E003 */  jr         $ra
    /* 510B0 800608B0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FindClosestCop__17AIHigh_BTC_AIPerp
