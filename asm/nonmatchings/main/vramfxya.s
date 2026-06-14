.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching vramfxya, 0x294

glabel vramfxya
    /* E71A8 800F69A8 B0FBBD27 */  addiu      $sp, $sp, -0x450
    /* E71AC 800F69AC 4004B6AF */  sw         $s6, 0x440($sp)
    /* E71B0 800F69B0 6004B68F */  lw         $s6, 0x460($sp)
    /* E71B4 800F69B4 2804B0AF */  sw         $s0, 0x428($sp)
    /* E71B8 800F69B8 21808000 */  addu       $s0, $a0, $zero
    /* E71BC 800F69BC 4404B7AF */  sw         $s7, 0x444($sp)
    /* E71C0 800F69C0 21B8A000 */  addu       $s7, $a1, $zero
    /* E71C4 800F69C4 4804BEAF */  sw         $fp, 0x448($sp)
    /* E71C8 800F69C8 21F0C000 */  addu       $fp, $a2, $zero
    /* E71CC 800F69CC 3C04B5AF */  sw         $s5, 0x43C($sp)
    /* E71D0 800F69D0 21A8E000 */  addu       $s5, $a3, $zero
    /* E71D4 800F69D4 4C04BFAF */  sw         $ra, 0x44C($sp)
    /* E71D8 800F69D8 3804B4AF */  sw         $s4, 0x438($sp)
    /* E71DC 800F69DC 3404B3AF */  sw         $s3, 0x434($sp)
    /* E71E0 800F69E0 3004B2AF */  sw         $s2, 0x430($sp)
    /* E71E4 800F69E4 89000012 */  beqz       $s0, .L800F6C0C
    /* E71E8 800F69E8 2C04B1AF */   sw        $s1, 0x42C($sp)
    /* E71EC 800F69EC 00F01424 */  addiu      $s4, $zero, -0x1000
    /* E71F0 800F69F0 00F0113C */  lui        $s1, (0xF000FFFF >> 16)
    /* E71F4 800F69F4 FFFF3136 */  ori        $s1, $s1, (0xF000FFFF & 0xFFFF)
    /* E71F8 800F69F8 FF0FB332 */  andi       $s3, $s5, 0xFFF
    /* E71FC 800F69FC FF0FC232 */  andi       $v0, $s6, 0xFFF
    /* E7200 800F6A00 00940200 */  sll        $s2, $v0, 16
    /* E7204 800F6A04 1800A827 */  addiu      $t0, $sp, 0x18
    /* E7208 800F6A08 2404A8AF */  sw         $t0, 0x424($sp)
  .L800F6A0C:
    /* E720C 800F6A0C 00000292 */  lbu        $v0, 0x0($s0)
    /* E7210 800F6A10 00000000 */  nop
    /* E7214 800F6A14 F7004230 */  andi       $v0, $v0, 0xF7
    /* E7218 800F6A18 DEFF4324 */  addiu      $v1, $v0, -0x22
    /* E721C 800F6A1C 2200622C */  sltiu      $v0, $v1, 0x22
    /* E7220 800F6A20 6F004010 */  beqz       $v0, .L800F6BE0
    /* E7224 800F6A24 0580023C */   lui       $v0, %hi(jtbl_80056FD8)
    /* E7228 800F6A28 D86F4224 */  addiu      $v0, $v0, %lo(jtbl_80056FD8)
    /* E722C 800F6A2C 80180300 */  sll        $v1, $v1, 2
    /* E7230 800F6A30 21186200 */  addu       $v1, $v1, $v0
    /* E7234 800F6A34 0000628C */  lw         $v0, 0x0($v1)
    /* E7238 800F6A38 00000000 */  nop
    /* E723C 800F6A3C 08004000 */  jr         $v0
    /* E7240 800F6A40 00000000 */   nop
  jlabel .L800F6A44
    /* E7244 800F6A44 21200002 */  addu       $a0, $s0, $zero
    /* E7248 800F6A48 FF0FE332 */  andi       $v1, $s7, 0xFFF
    /* E724C 800F6A4C 0C00028E */  lw         $v0, 0xC($s0)
    /* E7250 800F6A50 00000592 */  lbu        $a1, 0x0($s0)
    /* E7254 800F6A54 24105400 */  and        $v0, $v0, $s4
    /* E7258 800F6A58 25104300 */  or         $v0, $v0, $v1
    /* E725C 800F6A5C 24105100 */  and        $v0, $v0, $s1
    /* E7260 800F6A60 FF0FC333 */  andi       $v1, $fp, 0xFFF
    /* E7264 800F6A64 001C0300 */  sll        $v1, $v1, 16
    /* E7268 800F6A68 25104300 */  or         $v0, $v0, $v1
    /* E726C 800F6A6C 0800A534 */  ori        $a1, $a1, 0x8
    /* E7270 800F6A70 0C0002AE */  sw         $v0, 0xC($s0)
    /* E7274 800F6A74 000005A2 */  sb         $a1, 0x0($s0)
    /* E7278 800F6A78 1000B7A7 */  sh         $s7, 0x10($sp)
    /* E727C 800F6A7C F9D0030C */  jal        shapedepth
    /* E7280 800F6A80 1200BEA7 */   sh        $fp, 0x12($sp)
    /* E7284 800F6A84 04000386 */  lh         $v1, 0x4($s0)
    /* E7288 800F6A88 00000000 */  nop
    /* E728C 800F6A8C 18006200 */  mult       $v1, $v0
    /* E7290 800F6A90 12180000 */  mflo       $v1
    /* E7294 800F6A94 0F006224 */  addiu      $v0, $v1, 0xF
    /* E7298 800F6A98 02004104 */  bgez       $v0, .L800F6AA4
    /* E729C 800F6A9C 1000A427 */   addiu     $a0, $sp, 0x10
    /* E72A0 800F6AA0 1E006224 */  addiu      $v0, $v1, 0x1E
  .L800F6AA4:
    /* E72A4 800F6AA4 03110200 */  sra        $v0, $v0, 4
    /* E72A8 800F6AA8 1400A2A7 */  sh         $v0, 0x14($sp)
    /* E72AC 800F6AAC 06000296 */  lhu        $v0, 0x6($s0)
    /* E72B0 800F6AB0 10000526 */  addiu      $a1, $s0, 0x10
    /* E72B4 800F6AB4 F6DA0308 */  j          .L800F6BD8
    /* E72B8 800F6AB8 1600A2A7 */   sh        $v0, 0x16($sp)
  jlabel .L800F6ABC
    /* E72BC 800F6ABC 1000A427 */  addiu      $a0, $sp, 0x10
    /* E72C0 800F6AC0 E7DA0308 */  j          .L800F6B9C
    /* E72C4 800F6AC4 10000526 */   addiu     $a1, $s0, 0x10
  jlabel .L800F6AC8
    /* E72C8 800F6AC8 04000286 */  lh         $v0, 0x4($s0)
    /* E72CC 800F6ACC 00000000 */  nop
    /* E72D0 800F6AD0 15004018 */  blez       $v0, .L800F6B28
    /* E72D4 800F6AD4 21300000 */   addu      $a2, $zero, $zero
    /* E72D8 800F6AD8 2404A78F */  lw         $a3, 0x424($sp)
    /* E72DC 800F6ADC 21280002 */  addu       $a1, $s0, $zero
  .L800F6AE0:
    /* E72E0 800F6AE0 1200A290 */  lbu        $v0, 0x12($a1)
    /* E72E4 800F6AE4 1100A390 */  lbu        $v1, 0x11($a1)
    /* E72E8 800F6AE8 1000A490 */  lbu        $a0, 0x10($a1)
    /* E72EC 800F6AEC 0300A524 */  addiu      $a1, $a1, 0x3
    /* E72F0 800F6AF0 0100C624 */  addiu      $a2, $a2, 0x1
    /* E72F4 800F6AF4 42100200 */  srl        $v0, $v0, 1
    /* E72F8 800F6AF8 42180300 */  srl        $v1, $v1, 1
    /* E72FC 800F6AFC 42200400 */  srl        $a0, $a0, 1
    /* E7300 800F6B00 80120200 */  sll        $v0, $v0, 10
    /* E7304 800F6B04 40190300 */  sll        $v1, $v1, 5
    /* E7308 800F6B08 25104300 */  or         $v0, $v0, $v1
    /* E730C 800F6B0C 25208200 */  or         $a0, $a0, $v0
    /* E7310 800F6B10 0000E4A4 */  sh         $a0, 0x0($a3)
    /* E7314 800F6B14 04000286 */  lh         $v0, 0x4($s0)
    /* E7318 800F6B18 00000000 */  nop
    /* E731C 800F6B1C 2A10C200 */  slt        $v0, $a2, $v0
    /* E7320 800F6B20 EFFF4014 */  bnez       $v0, .L800F6AE0
    /* E7324 800F6B24 0200E724 */   addiu     $a3, $a3, 0x2
  .L800F6B28:
    /* E7328 800F6B28 1000A427 */  addiu      $a0, $sp, 0x10
    /* E732C 800F6B2C E7DA0308 */  j          .L800F6B9C
    /* E7330 800F6B30 1800A527 */   addiu     $a1, $sp, 0x18
  jlabel .L800F6B34
    /* E7334 800F6B34 04000286 */  lh         $v0, 0x4($s0)
    /* E7338 800F6B38 00000000 */  nop
    /* E733C 800F6B3C 15004018 */  blez       $v0, .L800F6B94
    /* E7340 800F6B40 21300000 */   addu      $a2, $zero, $zero
    /* E7344 800F6B44 1802A727 */  addiu      $a3, $sp, 0x218
    /* E7348 800F6B48 21280002 */  addu       $a1, $s0, $zero
  .L800F6B4C:
    /* E734C 800F6B4C 1200A290 */  lbu        $v0, 0x12($a1)
    /* E7350 800F6B50 1100A390 */  lbu        $v1, 0x11($a1)
    /* E7354 800F6B54 1000A490 */  lbu        $a0, 0x10($a1)
    /* E7358 800F6B58 0300A524 */  addiu      $a1, $a1, 0x3
    /* E735C 800F6B5C 0100C624 */  addiu      $a2, $a2, 0x1
    /* E7360 800F6B60 C2100200 */  srl        $v0, $v0, 3
    /* E7364 800F6B64 C2180300 */  srl        $v1, $v1, 3
    /* E7368 800F6B68 C2200400 */  srl        $a0, $a0, 3
    /* E736C 800F6B6C 80120200 */  sll        $v0, $v0, 10
    /* E7370 800F6B70 40190300 */  sll        $v1, $v1, 5
    /* E7374 800F6B74 25104300 */  or         $v0, $v0, $v1
    /* E7378 800F6B78 25208200 */  or         $a0, $a0, $v0
    /* E737C 800F6B7C 0000E4A4 */  sh         $a0, 0x0($a3)
    /* E7380 800F6B80 04000286 */  lh         $v0, 0x4($s0)
    /* E7384 800F6B84 00000000 */  nop
    /* E7388 800F6B88 2A10C200 */  slt        $v0, $a2, $v0
    /* E738C 800F6B8C EFFF4014 */  bnez       $v0, .L800F6B4C
    /* E7390 800F6B90 0200E724 */   addiu     $a3, $a3, 0x2
  .L800F6B94:
    /* E7394 800F6B94 1000A427 */  addiu      $a0, $sp, 0x10
    /* E7398 800F6B98 1802A527 */  addiu      $a1, $sp, 0x218
  .L800F6B9C:
    /* E739C 800F6B9C 0C00028E */  lw         $v0, 0xC($s0)
    /* E73A0 800F6BA0 00000392 */  lbu        $v1, 0x0($s0)
    /* E73A4 800F6BA4 24105400 */  and        $v0, $v0, $s4
    /* E73A8 800F6BA8 25105300 */  or         $v0, $v0, $s3
    /* E73AC 800F6BAC 24105100 */  and        $v0, $v0, $s1
    /* E73B0 800F6BB0 25105200 */  or         $v0, $v0, $s2
    /* E73B4 800F6BB4 08006334 */  ori        $v1, $v1, 0x8
    /* E73B8 800F6BB8 0C0002AE */  sw         $v0, 0xC($s0)
    /* E73BC 800F6BBC 000003A2 */  sb         $v1, 0x0($s0)
    /* E73C0 800F6BC0 1000B5A7 */  sh         $s5, 0x10($sp)
    /* E73C4 800F6BC4 1200B6A7 */  sh         $s6, 0x12($sp)
    /* E73C8 800F6BC8 04000396 */  lhu        $v1, 0x4($s0)
    /* E73CC 800F6BCC 01000224 */  addiu      $v0, $zero, 0x1
    /* E73D0 800F6BD0 1600A2A7 */  sh         $v0, 0x16($sp)
    /* E73D4 800F6BD4 1400A3A7 */  sh         $v1, 0x14($sp)
  .L800F6BD8:
    /* E73D8 800F6BD8 58DA030C */  jal        vramimage
    /* E73DC 800F6BDC 00000000 */   nop
  jlabel .L800F6BE0
    /* E73E0 800F6BE0 0000038E */  lw         $v1, 0x0($s0)
    /* E73E4 800F6BE4 00FF0224 */  addiu      $v0, $zero, -0x100
    /* E73E8 800F6BE8 24106200 */  and        $v0, $v1, $v0
    /* E73EC 800F6BEC 03004010 */  beqz       $v0, .L800F6BFC
    /* E73F0 800F6BF0 03120300 */   sra       $v0, $v1, 8
    /* E73F4 800F6BF4 00DB0308 */  j          .L800F6C00
    /* E73F8 800F6BF8 21200202 */   addu      $a0, $s0, $v0
  .L800F6BFC:
    /* E73FC 800F6BFC 21200000 */  addu       $a0, $zero, $zero
  .L800F6C00:
    /* E7400 800F6C00 21808000 */  addu       $s0, $a0, $zero
    /* E7404 800F6C04 81FF0016 */  bnez       $s0, .L800F6A0C
    /* E7408 800F6C08 00000000 */   nop
  .L800F6C0C:
    /* E740C 800F6C0C 4C04BF8F */  lw         $ra, 0x44C($sp)
    /* E7410 800F6C10 4804BE8F */  lw         $fp, 0x448($sp)
    /* E7414 800F6C14 4404B78F */  lw         $s7, 0x444($sp)
    /* E7418 800F6C18 4004B68F */  lw         $s6, 0x440($sp)
    /* E741C 800F6C1C 3C04B58F */  lw         $s5, 0x43C($sp)
    /* E7420 800F6C20 3804B48F */  lw         $s4, 0x438($sp)
    /* E7424 800F6C24 3404B38F */  lw         $s3, 0x434($sp)
    /* E7428 800F6C28 3004B28F */  lw         $s2, 0x430($sp)
    /* E742C 800F6C2C 2C04B18F */  lw         $s1, 0x42C($sp)
    /* E7430 800F6C30 2804B08F */  lw         $s0, 0x428($sp)
    /* E7434 800F6C34 0800E003 */  jr         $ra
    /* E7438 800F6C38 5004BD27 */   addiu     $sp, $sp, 0x450
endlabel vramfxya
