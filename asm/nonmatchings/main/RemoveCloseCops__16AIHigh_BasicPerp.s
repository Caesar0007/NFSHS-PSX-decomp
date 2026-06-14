.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RemoveCloseCops__16AIHigh_BasicPerp, 0x150

glabel RemoveCloseCops__16AIHigh_BasicPerp
    /* 4C57C 8005BD7C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4C580 8005BD80 2800B6AF */  sw         $s6, 0x28($sp)
    /* 4C584 8005BD84 21B08000 */  addu       $s6, $a0, $zero
    /* 4C588 8005BD88 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4C58C 8005BD8C 21900000 */  addu       $s2, $zero, $zero
    /* 4C590 8005BD90 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4C594 8005BD94 2400B5AF */  sw         $s5, 0x24($sp)
    /* 4C598 8005BD98 38CD5524 */  addiu      $s5, $v0, %lo(highLevelAIObjs)
    /* 4C59C 8005BD9C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 4C5A0 8005BDA0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4C5A4 8005BDA4 EC315424 */  addiu      $s4, $v0, %lo(GameSetup_gData)
    /* 4C5A8 8005BDA8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4C5AC 8005BDAC 01001324 */  addiu      $s3, $zero, 0x1
    /* 4C5B0 8005BDB0 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 4C5B4 8005BDB4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4C5B8 8005BDB8 B4FA5124 */  addiu      $s1, $v0, %lo(Cars_gCopCarList)
    /* 4C5BC 8005BDBC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 4C5C0 8005BDC0 1000B0AF */  sw         $s0, 0x10($sp)
  .L8005BDC4:
    /* 4C5C4 8005BDC4 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 4C5C8 8005BDC8 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 4C5CC 8005BDCC 00000000 */  nop
    /* 4C5D0 8005BDD0 2A104202 */  slt        $v0, $s2, $v0
    /* 4C5D4 8005BDD4 33004010 */  beqz       $v0, .L8005BEA4
    /* 4C5D8 8005BDD8 00000000 */   nop
    /* 4C5DC 8005BDDC 0000308E */  lw         $s0, 0x0($s1)
    /* 4C5E0 8005BDE0 00000000 */  nop
    /* 4C5E4 8005BDE4 7005028E */  lw         $v0, 0x570($s0)
    /* 4C5E8 8005BDE8 00000000 */  nop
    /* 4C5EC 8005BDEC 04004230 */  andi       $v0, $v0, 0x4
    /* 4C5F0 8005BDF0 29004014 */  bnez       $v0, .L8005BE98
    /* 4C5F4 8005BDF4 00000000 */   nop
    /* 4C5F8 8005BDF8 0000C58E */  lw         $a1, 0x0($s6)
    /* 4C5FC 8005BDFC 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4C600 8005BE00 21200002 */   addu      $a0, $s0, $zero
    /* 4C604 8005BE04 9500033C */  lui        $v1, (0x95FFFF >> 16)
    /* 4C608 8005BE08 FFFF6334 */  ori        $v1, $v1, (0x95FFFF & 0xFFFF)
    /* 4C60C 8005BE0C 02004104 */  bgez       $v0, .L8005BE18
    /* 4C610 8005BE10 21304000 */   addu      $a2, $v0, $zero
    /* 4C614 8005BE14 23300600 */  negu       $a2, $a2
  .L8005BE18:
    /* 4C618 8005BE18 2A186600 */  slt        $v1, $v1, $a2
    /* 4C61C 8005BE1C 1E006014 */  bnez       $v1, .L8005BE98
    /* 4C620 8005BE20 00000000 */   nop
    /* 4C624 8005BE24 5402028E */  lw         $v0, 0x254($s0)
    /* 4C628 8005BE28 3000838E */  lw         $v1, 0x30($s4)
    /* 4C62C 8005BE2C 80100200 */  sll        $v0, $v0, 2
    /* 4C630 8005BE30 21105500 */  addu       $v0, $v0, $s5
    /* 4C634 8005BE34 0000448C */  lw         $a0, 0x0($v0)
    /* 4C638 8005BE38 02006014 */  bnez       $v1, .L8005BE44
    /* 4C63C 8005BE3C 01000524 */   addiu     $a1, $zero, 0x1
    /* 4C640 8005BE40 FFFF0524 */  addiu      $a1, $zero, -0x1
  .L8005BE44:
    /* 4C644 8005BE44 1D00023C */  lui        $v0, (0x1DFFFF >> 16)
    /* 4C648 8005BE48 FFFF4234 */  ori        $v0, $v0, (0x1DFFFF & 0xFFFF)
    /* 4C64C 8005BE4C 2A104600 */  slt        $v0, $v0, $a2
    /* 4C650 8005BE50 540505AE */  sw         $a1, 0x554($s0)
    /* 4C654 8005BE54 500505AE */  sw         $a1, 0x550($s0)
    /* 4C658 8005BE58 03004014 */  bnez       $v0, .L8005BE68
    /* 4C65C 8005BE5C F00613AE */   sw        $s3, 0x6F0($s0)
    /* 4C660 8005BE60 9C6F0108 */  j          .L8005BE70
    /* 4C664 8005BE64 540093AC */   sw        $s3, 0x54($a0)
  .L8005BE68:
    /* 4C668 8005BE68 02000224 */  addiu      $v0, $zero, 0x2
    /* 4C66C 8005BE6C 540082AC */  sw         $v0, 0x54($a0)
  .L8005BE70:
    /* 4C670 8005BE70 0000848C */  lw         $a0, 0x0($a0)
    /* 4C674 8005BE74 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4C678 8005BE78 00000000 */   nop
    /* 4C67C 8005BE7C 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4C680 8005BE80 00000000 */  nop
    /* 4C684 8005BE84 80006484 */  lh         $a0, 0x80($v1)
    /* 4C688 8005BE88 8400638C */  lw         $v1, 0x84($v1)
    /* 4C68C 8005BE8C 00000000 */  nop
    /* 4C690 8005BE90 09F86000 */  jalr       $v1
    /* 4C694 8005BE94 21204400 */   addu      $a0, $v0, $a0
  .L8005BE98:
    /* 4C698 8005BE98 04003126 */  addiu      $s1, $s1, 0x4
    /* 4C69C 8005BE9C 716F0108 */  j          .L8005BDC4
    /* 4C6A0 8005BEA0 01005226 */   addiu     $s2, $s2, 0x1
  .L8005BEA4:
    /* 4C6A4 8005BEA4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 4C6A8 8005BEA8 2800B68F */  lw         $s6, 0x28($sp)
    /* 4C6AC 8005BEAC 2400B58F */  lw         $s5, 0x24($sp)
    /* 4C6B0 8005BEB0 2000B48F */  lw         $s4, 0x20($sp)
    /* 4C6B4 8005BEB4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4C6B8 8005BEB8 1800B28F */  lw         $s2, 0x18($sp)
    /* 4C6BC 8005BEBC 1400B18F */  lw         $s1, 0x14($sp)
    /* 4C6C0 8005BEC0 1000B08F */  lw         $s0, 0x10($sp)
    /* 4C6C4 8005BEC4 0800E003 */  jr         $ra
    /* 4C6C8 8005BEC8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel RemoveCloseCops__16AIHigh_BasicPerp
