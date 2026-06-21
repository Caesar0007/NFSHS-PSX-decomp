.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddUpgradesToPinkSlipsList__11tCarManagersss, 0xD8

glabel AddUpgradesToPinkSlipsList__11tCarManagersss
    /* 717C 8001697C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 7180 80016980 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7184 80016984 21908000 */  addu       $s2, $a0, $zero
    /* 7188 80016988 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 718C 8001698C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7190 80016990 00840500 */  sll        $s0, $a1, 16
    /* 7194 80016994 03841000 */  sra        $s0, $s0, 16
    /* 7198 80016998 1400B1AF */  sw         $s1, 0x14($sp)
    /* 719C 8001699C 008C0700 */  sll        $s1, $a3, 16
    /* 71A0 800169A0 2000BFAF */  sw         $ra, 0x20($sp)
    /* 71A4 800169A4 0000428E */  lw         $v0, 0x0($s2)
    /* 71A8 800169A8 438A1100 */  sra        $s1, $s1, 9
    /* 71AC 800169AC 23100202 */  subu       $v0, $s0, $v0
    /* 71B0 800169B0 80100200 */  sll        $v0, $v0, 2
    /* 71B4 800169B4 21105100 */  addu       $v0, $v0, $s1
    /* 71B8 800169B8 21104202 */  addu       $v0, $s2, $v0
    /* 71BC 800169BC 08014580 */  lb         $a1, 0x108($v0)
    /* 71C0 800169C0 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 71C4 800169C4 2198C000 */   addu      $s3, $a2, $zero
    /* 71C8 800169C8 21300000 */  addu       $a2, $zero, $zero
    /* 71CC 800169CC 01000724 */  addiu      $a3, $zero, 0x1
    /* 71D0 800169D0 0418C700 */  sllv       $v1, $a3, $a2
  .L800169D4:
    /* 71D4 800169D4 24106302 */  and        $v0, $s3, $v1
    /* 71D8 800169D8 00140200 */  sll        $v0, $v0, 16
    /* 71DC 800169DC 0F004010 */  beqz       $v0, .L80016A1C
    /* 71E0 800169E0 21286000 */   addu      $a1, $v1, $zero
    /* 71E4 800169E4 0000428E */  lw         $v0, 0x0($s2)
    /* 71E8 800169E8 00000000 */  nop
    /* 71EC 800169EC 23100202 */  subu       $v0, $s0, $v0
    /* 71F0 800169F0 80100200 */  sll        $v0, $v0, 2
    /* 71F4 800169F4 21105100 */  addu       $v0, $v0, $s1
    /* 71F8 800169F8 21204202 */  addu       $a0, $s2, $v0
    /* 71FC 800169FC 00140300 */  sll        $v0, $v1, 16
    /* 7200 80016A00 09018390 */  lbu        $v1, 0x109($a0)
    /* 7204 80016A04 03140200 */  sra        $v0, $v0, 16
    /* 7208 80016A08 24106200 */  and        $v0, $v1, $v0
    /* 720C 80016A0C 04004014 */  bnez       $v0, .L80016A20
    /* 7210 80016A10 0100C224 */   addiu     $v0, $a2, 0x1
    /* 7214 80016A14 2510A300 */  or         $v0, $a1, $v1
    /* 7218 80016A18 090182A0 */  sb         $v0, 0x109($a0)
  .L80016A1C:
    /* 721C 80016A1C 0100C224 */  addiu      $v0, $a2, 0x1
  .L80016A20:
    /* 7220 80016A20 21304000 */  addu       $a2, $v0, $zero
    /* 7224 80016A24 00140200 */  sll        $v0, $v0, 16
    /* 7228 80016A28 03140200 */  sra        $v0, $v0, 16
    /* 722C 80016A2C 03004228 */  slti       $v0, $v0, 0x3
    /* 7230 80016A30 E8FF4014 */  bnez       $v0, .L800169D4
    /* 7234 80016A34 0418C700 */   sllv      $v1, $a3, $a2
    /* 7238 80016A38 2000BF8F */  lw         $ra, 0x20($sp)
    /* 723C 80016A3C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 7240 80016A40 1800B28F */  lw         $s2, 0x18($sp)
    /* 7244 80016A44 1400B18F */  lw         $s1, 0x14($sp)
    /* 7248 80016A48 1000B08F */  lw         $s0, 0x10($sp)
    /* 724C 80016A4C 0800E003 */  jr         $ra
    /* 7250 80016A50 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AddUpgradesToPinkSlipsList__11tCarManagersss
