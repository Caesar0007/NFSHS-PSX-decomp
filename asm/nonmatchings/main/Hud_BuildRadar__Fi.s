.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildRadar__Fi, 0x708

glabel Hud_BuildRadar__Fi
    /* C7348 800D6B48 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* C734C 800D6B4C D000B0AF */  sw         $s0, 0xD0($sp)
    /* C7350 800D6B50 21800000 */  addu       $s0, $zero, $zero
    /* C7354 800D6B54 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* C7358 800D6B58 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* C735C 800D6B5C F800A4AF */  sw         $a0, 0xF8($sp)
    /* C7360 800D6B60 00110400 */  sll        $v0, $a0, 4
    /* C7364 800D6B64 21104400 */  addu       $v0, $v0, $a0
    /* C7368 800D6B68 00110200 */  sll        $v0, $v0, 4
    /* C736C 800D6B6C 21104300 */  addu       $v0, $v0, $v1
    /* C7370 800D6B70 E800B6AF */  sw         $s6, 0xE8($sp)
    /* C7374 800D6B74 21B00002 */  addu       $s6, $s0, $zero
    /* C7378 800D6B78 F000BEAF */  sw         $fp, 0xF0($sp)
    /* C737C 800D6B7C 16001E24 */  addiu      $fp, $zero, 0x16
    /* C7380 800D6B80 F400BFAF */  sw         $ra, 0xF4($sp)
    /* C7384 800D6B84 EC00B7AF */  sw         $s7, 0xEC($sp)
    /* C7388 800D6B88 E400B5AF */  sw         $s5, 0xE4($sp)
    /* C738C 800D6B8C E000B4AF */  sw         $s4, 0xE0($sp)
    /* C7390 800D6B90 DC00B3AF */  sw         $s3, 0xDC($sp)
    /* C7394 800D6B94 D800B2AF */  sw         $s2, 0xD8($sp)
    /* C7398 800D6B98 D400B1AF */  sw         $s1, 0xD4($sp)
    /* C739C 800D6B9C 0000428C */  lw         $v0, 0x0($v0)
    /* C73A0 800D6BA0 18001724 */  addiu      $s7, $zero, 0x18
    /* C73A4 800D6BA4 F000438C */  lw         $v1, 0xF0($v0)
    /* C73A8 800D6BA8 0801448C */  lw         $a0, 0x108($v0)
    /* C73AC 800D6BAC 03720300 */  sra        $t6, $v1, 8
    /* C73B0 800D6BB0 036A0400 */  sra        $t5, $a0, 8
    /* C73B4 800D6BB4 F800438C */  lw         $v1, 0xF8($v0)
    /* C73B8 800D6BB8 1001448C */  lw         $a0, 0x110($v0)
    /* C73BC 800D6BBC 03620300 */  sra        $t4, $v1, 8
    /* C73C0 800D6BC0 03220400 */  sra        $a0, $a0, 8
    /* C73C4 800D6BC4 A000438C */  lw         $v1, 0xA0($v0)
    /* C73C8 800D6BC8 A800428C */  lw         $v0, 0xA8($v0)
    /* C73CC 800D6BCC 035A0300 */  sra        $t3, $v1, 8
    /* C73D0 800D6BD0 23100200 */  negu       $v0, $v0
    /* C73D4 800D6BD4 1480033C */  lui        $v1, %hi(Cars_gNumRaceCars)
    /* C73D8 800D6BD8 F8C7638C */  lw         $v1, %lo(Cars_gNumRaceCars)($v1)
    /* C73DC 800D6BDC 00000000 */  nop
    /* C73E0 800D6BE0 50006018 */  blez       $v1, .L800D6D24
    /* C73E4 800D6BE4 03520200 */   sra       $t2, $v0, 8
    /* C73E8 800D6BE8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C73EC 800D6BEC EC315224 */  addiu      $s2, $v0, %lo(GameSetup_gData)
    /* C73F0 800D6BF0 EAFF1124 */  addiu      $s1, $zero, -0x16
    /* C73F4 800D6BF4 E8FF0F24 */  addiu      $t7, $zero, -0x18
    /* C73F8 800D6BF8 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* C73FC 800D6BFC 00FA4824 */  addiu      $t0, $v0, %lo(Cars_gRaceCarList)
    /* C7400 800D6C00 21480002 */  addu       $t1, $s0, $zero
  .L800D6C04:
    /* C7404 800D6C04 0000038D */  lw         $v1, 0x0($t0)
    /* C7408 800D6C08 00000000 */  nop
    /* C740C 800D6C0C A000628C */  lw         $v0, 0xA0($v1)
    /* C7410 800D6C10 00000000 */  nop
    /* C7414 800D6C14 03120200 */  sra        $v0, $v0, 8
    /* C7418 800D6C18 23284B00 */  subu       $a1, $v0, $t3
    /* C741C 800D6C1C 1800C501 */  mult       $t6, $a1
    /* C7420 800D6C20 A800628C */  lw         $v0, 0xA8($v1)
    /* C7424 800D6C24 00000000 */  nop
    /* C7428 800D6C28 23100200 */  negu       $v0, $v0
    /* C742C 800D6C2C 12380000 */  mflo       $a3
    /* C7430 800D6C30 03120200 */  sra        $v0, $v0, 8
    /* C7434 800D6C34 23104A00 */  subu       $v0, $v0, $t2
    /* C7438 800D6C38 1800A201 */  mult       $t5, $v0
    /* C743C 800D6C3C 12980000 */  mflo       $s3
    /* C7440 800D6C40 00000000 */  nop
    /* C7444 800D6C44 00000000 */  nop
    /* C7448 800D6C48 18008501 */  mult       $t4, $a1
    /* C744C 800D6C4C 12300000 */  mflo       $a2
    /* C7450 800D6C50 00000000 */  nop
    /* C7454 800D6C54 00000000 */  nop
    /* C7458 800D6C58 18008200 */  mult       $a0, $v0
    /* C745C 800D6C5C 1800A227 */  addiu      $v0, $sp, 0x18
    /* C7460 800D6C60 21284900 */  addu       $a1, $v0, $t1
    /* C7464 800D6C64 2110F300 */  addu       $v0, $a3, $s3
    /* C7468 800D6C68 03140200 */  sra        $v0, $v0, 16
    /* C746C 800D6C6C 0000A2AC */  sw         $v0, 0x0($a1)
    /* C7470 800D6C70 12180000 */  mflo       $v1
    /* C7474 800D6C74 2110C300 */  addu       $v0, $a2, $v1
    /* C7478 800D6C78 43140200 */  sra        $v0, $v0, 17
    /* C747C 800D6C7C 0800A2AC */  sw         $v0, 0x8($a1)
    /* C7480 800D6C80 2C00428E */  lw         $v0, 0x2C($s2)
    /* C7484 800D6C84 00000000 */  nop
    /* C7488 800D6C88 05004010 */  beqz       $v0, .L800D6CA0
    /* C748C 800D6C8C 00000000 */   nop
    /* C7490 800D6C90 0000A28C */  lw         $v0, 0x0($a1)
    /* C7494 800D6C94 00000000 */  nop
    /* C7498 800D6C98 23100200 */  negu       $v0, $v0
    /* C749C 800D6C9C 0000A2AC */  sw         $v0, 0x0($a1)
  .L800D6CA0:
    /* C74A0 800D6CA0 0000038D */  lw         $v1, 0x0($t0)
    /* C74A4 800D6CA4 00000000 */  nop
    /* C74A8 800D6CA8 91006290 */  lbu        $v0, 0x91($v1)
    /* C74AC 800D6CAC 00000000 */  nop
    /* C74B0 800D6CB0 15004010 */  beqz       $v0, .L800D6D08
    /* C74B4 800D6CB4 00000000 */   nop
    /* C74B8 800D6CB8 5402628C */  lw         $v0, 0x254($v1)
    /* C74BC 800D6CBC F800B88F */  lw         $t8, 0xF8($sp)
    /* C74C0 800D6CC0 00000000 */  nop
    /* C74C4 800D6CC4 10005810 */  beq        $v0, $t8, .L800D6D08
    /* C74C8 800D6CC8 00000000 */   nop
    /* C74CC 800D6CCC 0000A38C */  lw         $v1, 0x0($a1)
    /* C74D0 800D6CD0 00000000 */  nop
    /* C74D4 800D6CD4 2A102302 */  slt        $v0, $s1, $v1
    /* C74D8 800D6CD8 0B004010 */  beqz       $v0, .L800D6D08
    /* C74DC 800D6CDC 2A107E00 */   slt       $v0, $v1, $fp
    /* C74E0 800D6CE0 09004010 */  beqz       $v0, .L800D6D08
    /* C74E4 800D6CE4 00000000 */   nop
    /* C74E8 800D6CE8 0800A38C */  lw         $v1, 0x8($a1)
    /* C74EC 800D6CEC 00000000 */  nop
    /* C74F0 800D6CF0 2A10E301 */  slt        $v0, $t7, $v1
    /* C74F4 800D6CF4 04004010 */  beqz       $v0, .L800D6D08
    /* C74F8 800D6CF8 2A107700 */   slt       $v0, $v1, $s7
    /* C74FC 800D6CFC 02004010 */  beqz       $v0, .L800D6D08
    /* C7500 800D6D00 00000000 */   nop
    /* C7504 800D6D04 01001624 */  addiu      $s6, $zero, 0x1
  .L800D6D08:
    /* C7508 800D6D08 04000825 */  addiu      $t0, $t0, 0x4
    /* C750C 800D6D0C 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* C7510 800D6D10 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* C7514 800D6D14 01001026 */  addiu      $s0, $s0, 0x1
    /* C7518 800D6D18 2A100202 */  slt        $v0, $s0, $v0
    /* C751C 800D6D1C B9FF4014 */  bnez       $v0, .L800D6C04
    /* C7520 800D6D20 0C002925 */   addiu     $t1, $t1, 0xC
  .L800D6D24:
    /* C7524 800D6D24 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* C7528 800D6D28 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* C752C 800D6D2C 00000000 */  nop
    /* C7530 800D6D30 4D004018 */  blez       $v0, .L800D6E68
    /* C7534 800D6D34 21800000 */   addu      $s0, $zero, $zero
    /* C7538 800D6D38 1800B227 */  addiu      $s2, $sp, 0x18
    /* C753C 800D6D3C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C7540 800D6D40 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* C7544 800D6D44 23881E00 */  negu       $s1, $fp
    /* C7548 800D6D48 23781700 */  negu       $t7, $s7
    /* C754C 800D6D4C 1480083C */  lui        $t0, %hi(Cars_gNumRaceCars)
    /* C7550 800D6D50 F8C7088D */  lw         $t0, %lo(Cars_gNumRaceCars)($t0)
    /* C7554 800D6D54 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* C7558 800D6D58 B4FA4924 */  addiu      $t1, $v0, %lo(Cars_gCopCarList)
  .L800D6D5C:
    /* C755C 800D6D5C 0000238D */  lw         $v1, 0x0($t1)
    /* C7560 800D6D60 00000000 */  nop
    /* C7564 800D6D64 91006290 */  lbu        $v0, 0x91($v1)
    /* C7568 800D6D68 00000000 */  nop
    /* C756C 800D6D6C 37004010 */  beqz       $v0, .L800D6E4C
    /* C7570 800D6D70 00000000 */   nop
    /* C7574 800D6D74 A000628C */  lw         $v0, 0xA0($v1)
    /* C7578 800D6D78 00000000 */  nop
    /* C757C 800D6D7C 03120200 */  sra        $v0, $v0, 8
    /* C7580 800D6D80 23284B00 */  subu       $a1, $v0, $t3
    /* C7584 800D6D84 1800C501 */  mult       $t6, $a1
    /* C7588 800D6D88 A800628C */  lw         $v0, 0xA8($v1)
    /* C758C 800D6D8C 00000000 */  nop
    /* C7590 800D6D90 23100200 */  negu       $v0, $v0
    /* C7594 800D6D94 12380000 */  mflo       $a3
    /* C7598 800D6D98 03120200 */  sra        $v0, $v0, 8
    /* C759C 800D6D9C 23104A00 */  subu       $v0, $v0, $t2
    /* C75A0 800D6DA0 1800A201 */  mult       $t5, $v0
    /* C75A4 800D6DA4 12A00000 */  mflo       $s4
    /* C75A8 800D6DA8 00000000 */  nop
    /* C75AC 800D6DAC 00000000 */  nop
    /* C75B0 800D6DB0 18008501 */  mult       $t4, $a1
    /* C75B4 800D6DB4 12300000 */  mflo       $a2
    /* C75B8 800D6DB8 00000000 */  nop
    /* C75BC 800D6DBC 00000000 */  nop
    /* C75C0 800D6DC0 18008200 */  mult       $a0, $v0
    /* C75C4 800D6DC4 40100800 */  sll        $v0, $t0, 1
    /* C75C8 800D6DC8 21104800 */  addu       $v0, $v0, $t0
    /* C75CC 800D6DCC 80100200 */  sll        $v0, $v0, 2
    /* C75D0 800D6DD0 21284202 */  addu       $a1, $s2, $v0
    /* C75D4 800D6DD4 2110F400 */  addu       $v0, $a3, $s4
    /* C75D8 800D6DD8 03140200 */  sra        $v0, $v0, 16
    /* C75DC 800D6DDC 0000A2AC */  sw         $v0, 0x0($a1)
    /* C75E0 800D6DE0 12180000 */  mflo       $v1
    /* C75E4 800D6DE4 2110C300 */  addu       $v0, $a2, $v1
    /* C75E8 800D6DE8 43140200 */  sra        $v0, $v0, 17
    /* C75EC 800D6DEC 0800A2AC */  sw         $v0, 0x8($a1)
    /* C75F0 800D6DF0 2C00628E */  lw         $v0, 0x2C($s3)
    /* C75F4 800D6DF4 00000000 */  nop
    /* C75F8 800D6DF8 05004010 */  beqz       $v0, .L800D6E10
    /* C75FC 800D6DFC 00000000 */   nop
    /* C7600 800D6E00 0000A28C */  lw         $v0, 0x0($a1)
    /* C7604 800D6E04 00000000 */  nop
    /* C7608 800D6E08 23100200 */  negu       $v0, $v0
    /* C760C 800D6E0C 0000A2AC */  sw         $v0, 0x0($a1)
  .L800D6E10:
    /* C7610 800D6E10 0000A38C */  lw         $v1, 0x0($a1)
    /* C7614 800D6E14 00000000 */  nop
    /* C7618 800D6E18 2A102302 */  slt        $v0, $s1, $v1
    /* C761C 800D6E1C 0B004010 */  beqz       $v0, .L800D6E4C
    /* C7620 800D6E20 2A107E00 */   slt       $v0, $v1, $fp
    /* C7624 800D6E24 09004010 */  beqz       $v0, .L800D6E4C
    /* C7628 800D6E28 00000000 */   nop
    /* C762C 800D6E2C 0800A38C */  lw         $v1, 0x8($a1)
    /* C7630 800D6E30 00000000 */  nop
    /* C7634 800D6E34 2A10E301 */  slt        $v0, $t7, $v1
    /* C7638 800D6E38 04004010 */  beqz       $v0, .L800D6E4C
    /* C763C 800D6E3C 2A107700 */   slt       $v0, $v1, $s7
    /* C7640 800D6E40 02004010 */  beqz       $v0, .L800D6E4C
    /* C7644 800D6E44 00000000 */   nop
    /* C7648 800D6E48 01001624 */  addiu      $s6, $zero, 0x1
  .L800D6E4C:
    /* C764C 800D6E4C 01000825 */  addiu      $t0, $t0, 0x1
    /* C7650 800D6E50 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* C7654 800D6E54 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* C7658 800D6E58 01001026 */  addiu      $s0, $s0, 0x1
    /* C765C 800D6E5C 2A100202 */  slt        $v0, $s0, $v0
    /* C7660 800D6E60 BEFF4014 */  bnez       $v0, .L800D6D5C
    /* C7664 800D6E64 04002925 */   addiu     $t1, $t1, 0x4
  .L800D6E68:
    /* C7668 800D6E68 5600C016 */  bnez       $s6, .L800D6FC4
    /* C766C 800D6E6C 00000000 */   nop
    /* C7670 800D6E70 1480033C */  lui        $v1, %hi(Cars_gNumRaceCars)
    /* C7674 800D6E74 F8C7638C */  lw         $v1, %lo(Cars_gNumRaceCars)($v1)
    /* C7678 800D6E78 00000000 */  nop
    /* C767C 800D6E7C 2A10C302 */  slt        $v0, $s6, $v1
    /* C7680 800D6E80 2A004010 */  beqz       $v0, .L800D6F2C
    /* C7684 800D6E84 21800000 */   addu      $s0, $zero, $zero
    /* C7688 800D6E88 23481E00 */  negu       $t1, $fp
    /* C768C 800D6E8C 23401700 */  negu       $t0, $s7
    /* C7690 800D6E90 21386000 */  addu       $a3, $v1, $zero
    /* C7694 800D6E94 1800A527 */  addiu      $a1, $sp, 0x18
    /* C7698 800D6E98 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* C769C 800D6E9C 00FA4624 */  addiu      $a2, $v0, %lo(Cars_gRaceCarList)
  .L800D6EA0:
    /* C76A0 800D6EA0 0000C28C */  lw         $v0, 0x0($a2)
    /* C76A4 800D6EA4 00000000 */  nop
    /* C76A8 800D6EA8 91004290 */  lbu        $v0, 0x91($v0)
    /* C76AC 800D6EAC 00000000 */  nop
    /* C76B0 800D6EB0 19004010 */  beqz       $v0, .L800D6F18
    /* C76B4 800D6EB4 00000000 */   nop
    /* C76B8 800D6EB8 0000A28C */  lw         $v0, 0x0($a1)
    /* C76BC 800D6EBC 0800A38C */  lw         $v1, 0x8($a1)
    /* C76C0 800D6EC0 83100200 */  sra        $v0, $v0, 2
    /* C76C4 800D6EC4 83180300 */  sra        $v1, $v1, 2
    /* C76C8 800D6EC8 0000A2AC */  sw         $v0, 0x0($a1)
    /* C76CC 800D6ECC 0800A3AC */  sw         $v1, 0x8($a1)
    /* C76D0 800D6ED0 0000C28C */  lw         $v0, 0x0($a2)
    /* C76D4 800D6ED4 F800B88F */  lw         $t8, 0xF8($sp)
    /* C76D8 800D6ED8 5402428C */  lw         $v0, 0x254($v0)
    /* C76DC 800D6EDC 00000000 */  nop
    /* C76E0 800D6EE0 0D005810 */  beq        $v0, $t8, .L800D6F18
    /* C76E4 800D6EE4 00000000 */   nop
    /* C76E8 800D6EE8 0000A48C */  lw         $a0, 0x0($a1)
    /* C76EC 800D6EEC 00000000 */  nop
    /* C76F0 800D6EF0 2A102401 */  slt        $v0, $t1, $a0
    /* C76F4 800D6EF4 08004010 */  beqz       $v0, .L800D6F18
    /* C76F8 800D6EF8 2A109E00 */   slt       $v0, $a0, $fp
    /* C76FC 800D6EFC 06004010 */  beqz       $v0, .L800D6F18
    /* C7700 800D6F00 2A100301 */   slt       $v0, $t0, $v1
    /* C7704 800D6F04 04004010 */  beqz       $v0, .L800D6F18
    /* C7708 800D6F08 2A107700 */   slt       $v0, $v1, $s7
    /* C770C 800D6F0C 02004010 */  beqz       $v0, .L800D6F18
    /* C7710 800D6F10 00000000 */   nop
    /* C7714 800D6F14 02001624 */  addiu      $s6, $zero, 0x2
  .L800D6F18:
    /* C7718 800D6F18 0C00A524 */  addiu      $a1, $a1, 0xC
    /* C771C 800D6F1C 01001026 */  addiu      $s0, $s0, 0x1
    /* C7720 800D6F20 2A100702 */  slt        $v0, $s0, $a3
    /* C7724 800D6F24 DEFF4014 */  bnez       $v0, .L800D6EA0
    /* C7728 800D6F28 0400C624 */   addiu     $a2, $a2, 0x4
  .L800D6F2C:
    /* C772C 800D6F2C 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* C7730 800D6F30 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* C7734 800D6F34 00000000 */  nop
    /* C7738 800D6F38 22004018 */  blez       $v0, .L800D6FC4
    /* C773C 800D6F3C 21800000 */   addu      $s0, $zero, $zero
    /* C7740 800D6F40 14800A3C */  lui        $t2, %hi(Cars_gNumRaceCars)
    /* C7744 800D6F44 F8C74A8D */  lw         $t2, %lo(Cars_gNumRaceCars)($t2)
    /* C7748 800D6F48 1800A927 */  addiu      $t1, $sp, 0x18
    /* C774C 800D6F4C 23401E00 */  negu       $t0, $fp
    /* C7750 800D6F50 23381700 */  negu       $a3, $s7
    /* C7754 800D6F54 21304000 */  addu       $a2, $v0, $zero
    /* C7758 800D6F58 21100A02 */  addu       $v0, $s0, $t2
  .L800D6F5C:
    /* C775C 800D6F5C 40180200 */  sll        $v1, $v0, 1
    /* C7760 800D6F60 21186200 */  addu       $v1, $v1, $v0
    /* C7764 800D6F64 80180300 */  sll        $v1, $v1, 2
    /* C7768 800D6F68 21182301 */  addu       $v1, $t1, $v1
    /* C776C 800D6F6C 0000628C */  lw         $v0, 0x0($v1)
    /* C7770 800D6F70 00000000 */  nop
    /* C7774 800D6F74 83100200 */  sra        $v0, $v0, 2
    /* C7778 800D6F78 000062AC */  sw         $v0, 0x0($v1)
    /* C777C 800D6F7C 0800628C */  lw         $v0, 0x8($v1)
    /* C7780 800D6F80 0000658C */  lw         $a1, 0x0($v1)
    /* C7784 800D6F84 83200200 */  sra        $a0, $v0, 2
    /* C7788 800D6F88 2A100501 */  slt        $v0, $t0, $a1
    /* C778C 800D6F8C 09004010 */  beqz       $v0, .L800D6FB4
    /* C7790 800D6F90 080064AC */   sw        $a0, 0x8($v1)
    /* C7794 800D6F94 2A10BE00 */  slt        $v0, $a1, $fp
    /* C7798 800D6F98 06004010 */  beqz       $v0, .L800D6FB4
    /* C779C 800D6F9C 2A10E400 */   slt       $v0, $a3, $a0
    /* C77A0 800D6FA0 04004010 */  beqz       $v0, .L800D6FB4
    /* C77A4 800D6FA4 2A109700 */   slt       $v0, $a0, $s7
    /* C77A8 800D6FA8 02004010 */  beqz       $v0, .L800D6FB4
    /* C77AC 800D6FAC 00000000 */   nop
    /* C77B0 800D6FB0 02001624 */  addiu      $s6, $zero, 0x2
  .L800D6FB4:
    /* C77B4 800D6FB4 01001026 */  addiu      $s0, $s0, 0x1
    /* C77B8 800D6FB8 2A100602 */  slt        $v0, $s0, $a2
    /* C77BC 800D6FBC E7FF4014 */  bnez       $v0, .L800D6F5C
    /* C77C0 800D6FC0 21100A02 */   addu      $v0, $s0, $t2
  .L800D6FC4:
    /* C77C4 800D6FC4 21800000 */  addu       $s0, $zero, $zero
    /* C77C8 800D6FC8 801F133C */  lui        $s3, (0x1F800004 >> 16)
    /* C77CC 800D6FCC 04007336 */  ori        $s3, $s3, (0x1F800004 & 0xFFFF)
    /* C77D0 800D6FD0 FF00123C */  lui        $s2, (0xFFFFFF >> 16)
    /* C77D4 800D6FD4 FFFF5236 */  ori        $s2, $s2, (0xFFFFFF & 0xFFFF)
    /* C77D8 800D6FD8 00FF143C */  lui        $s4, (0xFF000000 >> 16)
    /* C77DC 800D6FDC 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* C77E0 800D6FE0 B4FA5124 */  addiu      $s1, $v0, %lo(Cars_gCopCarList)
  .L800D6FE4:
    /* C77E4 800D6FE4 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* C77E8 800D6FE8 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* C77EC 800D6FEC 00000000 */  nop
    /* C77F0 800D6FF0 2A100202 */  slt        $v0, $s0, $v0
    /* C77F4 800D6FF4 39004010 */  beqz       $v0, .L800D70DC
    /* C77F8 800D6FF8 801F153C */   lui       $s5, (0x1F800004 >> 16)
    /* C77FC 800D6FFC 0000228E */  lw         $v0, 0x0($s1)
    /* C7800 800D7000 00000000 */  nop
    /* C7804 800D7004 91004290 */  lbu        $v0, 0x91($v0)
    /* C7808 800D7008 00000000 */  nop
    /* C780C 800D700C 30004010 */  beqz       $v0, .L800D70D0
    /* C7810 800D7010 00000000 */   nop
    /* C7814 800D7014 0000668E */  lw         $a2, 0x0($s3)
    /* C7818 800D7018 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C781C 800D701C 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C7820 800D7020 0000C38C */  lw         $v1, 0x0($a2)
    /* C7824 800D7024 0000A28C */  lw         $v0, 0x0($a1)
    /* C7828 800D7028 24187400 */  and        $v1, $v1, $s4
    /* C782C 800D702C 24105200 */  and        $v0, $v0, $s2
    /* C7830 800D7030 25186200 */  or         $v1, $v1, $v0
    /* C7834 800D7034 0000C3AC */  sw         $v1, 0x0($a2)
    /* C7838 800D7038 0000A38C */  lw         $v1, 0x0($a1)
    /* C783C 800D703C 1400C224 */  addiu      $v0, $a2, 0x14
    /* C7840 800D7040 000062AE */  sw         $v0, 0x0($s3)
    /* C7844 800D7044 2410D200 */  and        $v0, $a2, $s2
    /* C7848 800D7048 1480043C */  lui        $a0, %hi(gFlip)
    /* C784C 800D704C B4D7848C */  lw         $a0, %lo(gFlip)($a0)
    /* C7850 800D7050 24187400 */  and        $v1, $v1, $s4
    /* C7854 800D7054 25186200 */  or         $v1, $v1, $v0
    /* C7858 800D7058 06008014 */  bnez       $a0, .L800D7074
    /* C785C 800D705C 0000A3AC */   sw        $v1, 0x0($a1)
    /* C7860 800D7060 1280023C */  lui        $v0, %hi(D_8011E0D4)
    /* C7864 800D7064 D4E0428C */  lw         $v0, %lo(D_8011E0D4)($v0)
    /* C7868 800D7068 00000000 */  nop
    /* C786C 800D706C 02004010 */  beqz       $v0, .L800D7078
    /* C7870 800D7070 FF00023C */   lui       $v0, (0xFF0000 >> 16)
  .L800D7074:
    /* C7874 800D7074 FF000224 */  addiu      $v0, $zero, 0xFF
  .L800D7078:
    /* C7878 800D7078 C81882AF */  sw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C787C 800D707C 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* C7880 800D7080 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* C7884 800D7084 2120C000 */  addu       $a0, $a2, $zero
    /* C7888 800D7088 21100202 */  addu       $v0, $s0, $v0
    /* C788C 800D708C 40180200 */  sll        $v1, $v0, 1
    /* C7890 800D7090 21186200 */  addu       $v1, $v1, $v0
    /* C7894 800D7094 80180300 */  sll        $v1, $v1, 2
    /* C7898 800D7098 1800A227 */  addiu      $v0, $sp, 0x18
    /* C789C 800D709C 21104300 */  addu       $v0, $v0, $v1
    /* C78A0 800D70A0 0000468C */  lw         $a2, 0x0($v0)
    /* C78A4 800D70A4 0800478C */  lw         $a3, 0x8($v0)
    /* C78A8 800D70A8 C818828F */  lw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C78AC 800D70AC 7A000524 */  addiu      $a1, $zero, 0x7A
    /* C78B0 800D70B0 1400A0AF */  sw         $zero, 0x14($sp)
    /* C78B4 800D70B4 2130DE00 */  addu       $a2, $a2, $fp
    /* C78B8 800D70B8 FEFFC624 */  addiu      $a2, $a2, -0x2
    /* C78BC 800D70BC FFFFC630 */  andi       $a2, $a2, 0xFFFF
    /* C78C0 800D70C0 2138F700 */  addu       $a3, $a3, $s7
    /* C78C4 800D70C4 FFFFE730 */  andi       $a3, $a3, 0xFFFF
    /* C78C8 800D70C8 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C78CC 800D70CC 1000A2AF */   sw        $v0, 0x10($sp)
  .L800D70D0:
    /* C78D0 800D70D0 04003126 */  addiu      $s1, $s1, 0x4
    /* C78D4 800D70D4 F95B0308 */  j          .L800D6FE4
    /* C78D8 800D70D8 01001026 */   addiu     $s0, $s0, 0x1
  .L800D70DC:
    /* C78DC 800D70DC 21800000 */  addu       $s0, $zero, $zero
    /* C78E0 800D70E0 0400B536 */  ori        $s5, $s5, (0x1F800004 & 0xFFFF)
    /* C78E4 800D70E4 FF00143C */  lui        $s4, (0xFFFFFF >> 16)
    /* C78E8 800D70E8 FFFF9436 */  ori        $s4, $s4, (0xFFFFFF & 0xFFFF)
    /* C78EC 800D70EC 21900002 */  addu       $s2, $s0, $zero
    /* C78F0 800D70F0 1280133C */  lui        $s3, %hi(Hud_gMarkerColor)
    /* C78F4 800D70F4 600B7326 */  addiu      $s3, $s3, %lo(Hud_gMarkerColor)
    /* C78F8 800D70F8 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* C78FC 800D70FC 00FA5124 */  addiu      $s1, $v0, %lo(Cars_gRaceCarList)
  .L800D7100:
    /* C7900 800D7100 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* C7904 800D7104 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* C7908 800D7108 00000000 */  nop
    /* C790C 800D710C 2A100202 */  slt        $v0, $s0, $v0
    /* C7910 800D7110 43004010 */  beqz       $v0, .L800D7220
    /* C7914 800D7114 2110C002 */   addu      $v0, $s6, $zero
    /* C7918 800D7118 F800B88F */  lw         $t8, 0xF8($sp)
    /* C791C 800D711C 00000000 */  nop
    /* C7920 800D7120 3A001812 */  beq        $s0, $t8, .L800D720C
    /* C7924 800D7124 00000000 */   nop
    /* C7928 800D7128 0000228E */  lw         $v0, 0x0($s1)
    /* C792C 800D712C 00000000 */  nop
    /* C7930 800D7130 91004290 */  lbu        $v0, 0x91($v0)
    /* C7934 800D7134 00000000 */  nop
    /* C7938 800D7138 34004010 */  beqz       $v0, .L800D720C
    /* C793C 800D713C 80301000 */   sll       $a2, $s0, 2
    /* C7940 800D7140 00FF183C */  lui        $t8, (0xFF000000 >> 16)
    /* C7944 800D7144 0000A58E */  lw         $a1, 0x0($s5)
    /* C7948 800D7148 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C794C 800D714C 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C7950 800D7150 0000A38C */  lw         $v1, 0x0($a1)
    /* C7954 800D7154 0000828C */  lw         $v0, 0x0($a0)
    /* C7958 800D7158 24187800 */  and        $v1, $v1, $t8
    /* C795C 800D715C 24105400 */  and        $v0, $v0, $s4
    /* C7960 800D7160 25186200 */  or         $v1, $v1, $v0
    /* C7964 800D7164 0000A3AC */  sw         $v1, 0x0($a1)
    /* C7968 800D7168 0000828C */  lw         $v0, 0x0($a0)
    /* C796C 800D716C 2418B400 */  and        $v1, $a1, $s4
    /* C7970 800D7170 24105800 */  and        $v0, $v0, $t8
    /* C7974 800D7174 25104300 */  or         $v0, $v0, $v1
    /* C7978 800D7178 000082AC */  sw         $v0, 0x0($a0)
    /* C797C 800D717C 0000228E */  lw         $v0, 0x0($s1)
    /* C7980 800D7180 00000000 */  nop
    /* C7984 800D7184 6002438C */  lw         $v1, 0x260($v0)
    /* C7988 800D7188 1400A224 */  addiu      $v0, $a1, 0x14
    /* C798C 800D718C 04006330 */  andi       $v1, $v1, 0x4
    /* C7990 800D7190 0C006010 */  beqz       $v1, .L800D71C4
    /* C7994 800D7194 0000A2AE */   sw        $v0, 0x0($s5)
    /* C7998 800D7198 2120A000 */  addu       $a0, $a1, $zero
    /* C799C 800D719C 1800A227 */  addiu      $v0, $sp, 0x18
    /* C79A0 800D71A0 21105200 */  addu       $v0, $v0, $s2
    /* C79A4 800D71A4 0000468C */  lw         $a2, 0x0($v0)
    /* C79A8 800D71A8 0800478C */  lw         $a3, 0x8($v0)
    /* C79AC 800D71AC 0000628E */  lw         $v0, 0x0($s3)
    /* C79B0 800D71B0 79000524 */  addiu      $a1, $zero, 0x79
    /* C79B4 800D71B4 1400A0AF */  sw         $zero, 0x14($sp)
    /* C79B8 800D71B8 2130DE00 */  addu       $a2, $a2, $fp
    /* C79BC 800D71BC 7E5C0308 */  j          .L800D71F8
    /* C79C0 800D71C0 FDFFC624 */   addiu     $a2, $a2, -0x3
  .L800D71C4:
    /* C79C4 800D71C4 2120A000 */  addu       $a0, $a1, $zero
    /* C79C8 800D71C8 1800A227 */  addiu      $v0, $sp, 0x18
    /* C79CC 800D71CC 21105200 */  addu       $v0, $v0, $s2
    /* C79D0 800D71D0 1280183C */  lui        $t8, %hi(Hud_gMarkerColor)
    /* C79D4 800D71D4 600B1827 */  addiu      $t8, $t8, %lo(Hud_gMarkerColor)
    /* C79D8 800D71D8 2118D800 */  addu       $v1, $a2, $t8
    /* C79DC 800D71DC 0000468C */  lw         $a2, 0x0($v0)
    /* C79E0 800D71E0 0800478C */  lw         $a3, 0x8($v0)
    /* C79E4 800D71E4 0000628C */  lw         $v0, 0x0($v1)
    /* C79E8 800D71E8 7A000524 */  addiu      $a1, $zero, 0x7A
    /* C79EC 800D71EC 1400A0AF */  sw         $zero, 0x14($sp)
    /* C79F0 800D71F0 2130DE00 */  addu       $a2, $a2, $fp
    /* C79F4 800D71F4 FEFFC624 */  addiu      $a2, $a2, -0x2
  .L800D71F8:
    /* C79F8 800D71F8 FFFFC630 */  andi       $a2, $a2, 0xFFFF
    /* C79FC 800D71FC 2138F700 */  addu       $a3, $a3, $s7
    /* C7A00 800D7200 FFFFE730 */  andi       $a3, $a3, 0xFFFF
    /* C7A04 800D7204 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C7A08 800D7208 1000A2AF */   sw        $v0, 0x10($sp)
  .L800D720C:
    /* C7A0C 800D720C 0C005226 */  addiu      $s2, $s2, 0xC
    /* C7A10 800D7210 04007326 */  addiu      $s3, $s3, 0x4
    /* C7A14 800D7214 04003126 */  addiu      $s1, $s1, 0x4
    /* C7A18 800D7218 405C0308 */  j          .L800D7100
    /* C7A1C 800D721C 01001026 */   addiu     $s0, $s0, 0x1
  .L800D7220:
    /* C7A20 800D7220 F400BF8F */  lw         $ra, 0xF4($sp)
    /* C7A24 800D7224 F000BE8F */  lw         $fp, 0xF0($sp)
    /* C7A28 800D7228 EC00B78F */  lw         $s7, 0xEC($sp)
    /* C7A2C 800D722C E800B68F */  lw         $s6, 0xE8($sp)
    /* C7A30 800D7230 E400B58F */  lw         $s5, 0xE4($sp)
    /* C7A34 800D7234 E000B48F */  lw         $s4, 0xE0($sp)
    /* C7A38 800D7238 DC00B38F */  lw         $s3, 0xDC($sp)
    /* C7A3C 800D723C D800B28F */  lw         $s2, 0xD8($sp)
    /* C7A40 800D7240 D400B18F */  lw         $s1, 0xD4($sp)
    /* C7A44 800D7244 D000B08F */  lw         $s0, 0xD0($sp)
    /* C7A48 800D7248 0800E003 */  jr         $ra
    /* C7A4C 800D724C F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel Hud_BuildRadar__Fi
