.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForControlsPressed__15AIHigh_BTC_Perp, 0xA0

glabel CheckForControlsPressed__15AIHigh_BTC_Perp
    /* 501B8 8005F9B8 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 501BC 8005F9BC 48FA438C */  lw         $v1, %lo(Cars_gHumanRaceCarList)($v0)
    /* 501C0 8005F9C0 00000000 */  nop
    /* 501C4 8005F9C4 6002628C */  lw         $v0, 0x260($v1)
    /* 501C8 8005F9C8 00000000 */  nop
    /* 501CC 8005F9CC 00024230 */  andi       $v0, $v0, 0x200
    /* 501D0 8005F9D0 0A004010 */  beqz       $v0, .L8005F9FC
    /* 501D4 8005F9D4 21200000 */   addu      $a0, $zero, $zero
    /* 501D8 8005F9D8 3C046294 */  lhu        $v0, 0x43C($v1)
    /* 501DC 8005F9DC 00000000 */  nop
    /* 501E0 8005F9E0 05004014 */  bnez       $v0, .L8005F9F8
    /* 501E4 8005F9E4 3C046324 */   addiu     $v1, $v1, 0x43C
    /* 501E8 8005F9E8 09006390 */  lbu        $v1, 0x9($v1)
    /* 501EC 8005F9EC 01000224 */  addiu      $v0, $zero, 0x1
    /* 501F0 8005F9F0 02006214 */  bne        $v1, $v0, .L8005F9FC
    /* 501F4 8005F9F4 00000000 */   nop
  .L8005F9F8:
    /* 501F8 8005F9F8 01000424 */  addiu      $a0, $zero, 0x1
  .L8005F9FC:
    /* 501FC 8005F9FC 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 50200 8005FA00 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 50204 8005FA04 02000224 */  addiu      $v0, $zero, 0x2
    /* 50208 8005FA08 11006214 */  bne        $v1, $v0, .L8005FA50
    /* 5020C 8005FA0C 1180023C */   lui       $v0, %hi(D_8010FA4C)
    /* 50210 8005FA10 4CFA438C */  lw         $v1, %lo(D_8010FA4C)($v0)
    /* 50214 8005FA14 00000000 */  nop
    /* 50218 8005FA18 6002628C */  lw         $v0, 0x260($v1)
    /* 5021C 8005FA1C 00000000 */  nop
    /* 50220 8005FA20 00024230 */  andi       $v0, $v0, 0x200
    /* 50224 8005FA24 0A004010 */  beqz       $v0, .L8005FA50
    /* 50228 8005FA28 00000000 */   nop
    /* 5022C 8005FA2C 3C046294 */  lhu        $v0, 0x43C($v1)
    /* 50230 8005FA30 00000000 */  nop
    /* 50234 8005FA34 05004014 */  bnez       $v0, .L8005FA4C
    /* 50238 8005FA38 3C046324 */   addiu     $v1, $v1, 0x43C
    /* 5023C 8005FA3C 09006390 */  lbu        $v1, 0x9($v1)
    /* 50240 8005FA40 01000224 */  addiu      $v0, $zero, 0x1
    /* 50244 8005FA44 02006214 */  bne        $v1, $v0, .L8005FA50
    /* 50248 8005FA48 00000000 */   nop
  .L8005FA4C:
    /* 5024C 8005FA4C 01000424 */  addiu      $a0, $zero, 0x1
  .L8005FA50:
    /* 50250 8005FA50 0800E003 */  jr         $ra
    /* 50254 8005FA54 21108000 */   addu      $v0, $a0, $zero
endlabel CheckForControlsPressed__15AIHigh_BTC_Perp
