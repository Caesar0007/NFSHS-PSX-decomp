.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__16tScreenCarSelect, 0x208

glabel Initialize__16tScreenCarSelect
    /* 2C588 8003BD88 C0FEBD27 */  addiu      $sp, $sp, -0x140
    /* 2C58C 8003BD8C 3801B0AF */  sw         $s0, 0x138($sp)
    /* 2C590 8003BD90 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2C594 8003BD94 00464524 */  addiu      $a1, $v0, %lo(frontEnd)
    /* 2C598 8003BD98 3C01BFAF */  sw         $ra, 0x13C($sp)
    /* 2C59C 8003BD9C 0400A390 */  lbu        $v1, 0x4($a1)
    /* 2C5A0 8003BDA0 02000224 */  addiu      $v0, $zero, 0x2
    /* 2C5A4 8003BDA4 0C006214 */  bne        $v1, $v0, .L8003BDD8
    /* 2C5A8 8003BDA8 21808000 */   addu      $s0, $a0, $zero
    /* 2C5AC 8003BDAC 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 2C5B0 8003BDB0 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 2C5B4 8003BDB4 A3C9000C */  jal        GetTrackToRace__18tTournamentManagerR10tTrackInfo
    /* 2C5B8 8003BDB8 1001A527 */   addiu     $a1, $sp, 0x110
    /* 2C5BC 8003BDBC 1180043C */  lui        $a0, %hi(trackManager)
    /* 2C5C0 8003BDC0 1001A583 */  lb         $a1, 0x110($sp)
    /* 2C5C4 8003BDC4 4087000C */  jal        GetTrackByID__13tTrackManagers
    /* 2C5C8 8003BDC8 504A8424 */   addiu     $a0, $a0, %lo(trackManager)
    /* 2C5CC 8003BDCC 01004390 */  lbu        $v1, 0x1($v0)
    /* 2C5D0 8003BDD0 7FEF0008 */  j          .L8003BDFC
    /* 2C5D4 8003BDD4 1180023C */   lui       $v0, %hi(D_80113228)
  .L8003BDD8:
    /* 2C5D8 8003BDD8 1180043C */  lui        $a0, %hi(trackManager)
    /* 2C5DC 8003BDDC 4600A290 */  lbu        $v0, 0x46($a1)
    /* 2C5E0 8003BDE0 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 2C5E4 8003BDE4 21104500 */  addu       $v0, $v0, $a1
    /* 2C5E8 8003BDE8 23004590 */  lbu        $a1, 0x23($v0)
    /* 2C5EC 8003BDEC A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 2C5F0 8003BDF0 E000A627 */   addiu     $a2, $sp, 0xE0
    /* 2C5F4 8003BDF4 E100A393 */  lbu        $v1, 0xE1($sp)
    /* 2C5F8 8003BDF8 1180023C */  lui        $v0, %hi(D_80113228)
  .L8003BDFC:
    /* 2C5FC 8003BDFC 283243AC */  sw         $v1, %lo(D_80113228)($v0)
    /* 2C600 8003BE00 0580033C */  lui        $v1, %hi(gShowroomLights)
    /* 2C604 8003BE04 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2C608 8003BE08 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2C60C 8003BE0C 01000224 */  addiu      $v0, $zero, 0x1
    /* 2C610 8003BE10 B41462AC */  sw         $v0, %lo(gShowroomLights)($v1)
    /* 2C614 8003BE14 3820838C */  lw         $v1, 0x2038($a0)
    /* 2C618 8003BE18 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 2C61C 8003BE1C 24286200 */  and        $a1, $v1, $v0
    /* 2C620 8003BE20 1180023C */  lui        $v0, %hi(D_80114604)
    /* 2C624 8003BE24 382085AC */  sw         $a1, 0x2038($a0)
    /* 2C628 8003BE28 04464390 */  lbu        $v1, %lo(D_80114604)($v0)
    /* 2C62C 8003BE2C 02000224 */  addiu      $v0, $zero, 0x2
    /* 2C630 8003BE30 02006214 */  bne        $v1, $v0, .L8003BE3C
    /* 2C634 8003BE34 0100A234 */   ori       $v0, $a1, 0x1
    /* 2C638 8003BE38 382082AC */  sw         $v0, 0x2038($a0)
  .L8003BE3C:
    /* 2C63C 8003BE3C 2B98000C */  jal        Initialize__7tScreen
    /* 2C640 8003BE40 21200002 */   addu      $a0, $s0, $zero
    /* 2C644 8003BE44 6000028E */  lw         $v0, 0x60($s0)
    /* 2C648 8003BE48 00000000 */  nop
    /* 2C64C 8003BE4C 70004484 */  lh         $a0, 0x70($v0)
    /* 2C650 8003BE50 7400428C */  lw         $v0, 0x74($v0)
    /* 2C654 8003BE54 00000000 */  nop
    /* 2C658 8003BE58 09F84000 */  jalr       $v0
    /* 2C65C 8003BE5C 21200402 */   addu      $a0, $s0, $a0
    /* 2C660 8003BE60 F3AD000C */  jal        SetLicensePlate__Fv
    /* 2C664 8003BE64 00000000 */   nop
    /* 2C668 8003BE68 6000028E */  lw         $v0, 0x60($s0)
    /* 2C66C 8003BE6C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2C670 8003BE70 840300AE */  sw         $zero, 0x384($s0)
    /* 2C674 8003BE74 9C0300AE */  sw         $zero, 0x39C($s0)
    /* 2C678 8003BE78 880300AE */  sw         $zero, 0x388($s0)
    /* 2C67C 8003BE7C 68004484 */  lh         $a0, 0x68($v0)
    /* 2C680 8003BE80 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2C684 8003BE84 00000000 */  nop
    /* 2C688 8003BE88 09F84000 */  jalr       $v0
    /* 2C68C 8003BE8C 21200402 */   addu      $a0, $s0, $a0
    /* 2C690 8003BE90 0C004010 */  beqz       $v0, .L8003BEC4
    /* 2C694 8003BE94 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 2C698 8003BE98 D800A293 */  lbu        $v0, 0xD8($sp)
    /* 2C69C 8003BE9C 00000000 */  nop
    /* 2C6A0 8003BEA0 1E0102A6 */  sh         $v0, 0x11E($s0)
    /* 2C6A4 8003BEA4 1000A293 */  lbu        $v0, 0x10($sp)
    /* 2C6A8 8003BEA8 00000000 */  nop
    /* 2C6AC 8003BEAC 00160200 */  sll        $v0, $v0, 24
    /* 2C6B0 8003BEB0 03160200 */  sra        $v0, $v0, 24
    /* 2C6B4 8003BEB4 200102A6 */  sh         $v0, 0x120($s0)
    /* 2C6B8 8003BEB8 D700A293 */  lbu        $v0, 0xD7($sp)
    /* 2C6BC 8003BEBC B4EF0008 */  j          .L8003BED0
    /* 2C6C0 8003BEC0 220102A6 */   sh        $v0, 0x122($s0)
  .L8003BEC4:
    /* 2C6C4 8003BEC4 1E0102A6 */  sh         $v0, 0x11E($s0)
    /* 2C6C8 8003BEC8 220102A6 */  sh         $v0, 0x122($s0)
    /* 2C6CC 8003BECC 200102A6 */  sh         $v0, 0x120($s0)
  .L8003BED0:
    /* 2C6D0 8003BED0 1480023C */  lui        $v0, %hi(ticks)
    /* 2C6D4 8003BED4 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 2C6D8 8003BED8 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2C6DC 8003BEDC 760300A6 */  sh         $zero, 0x376($s0)
    /* 2C6E0 8003BEE0 740300A6 */  sh         $zero, 0x374($s0)
    /* 2C6E4 8003BEE4 7A0300A6 */  sh         $zero, 0x37A($s0)
    /* 2C6E8 8003BEE8 780300A6 */  sh         $zero, 0x378($s0)
    /* 2C6EC 8003BEEC 8C0303AE */  sw         $v1, 0x38C($s0)
    /* 2C6F0 8003BEF0 6000038E */  lw         $v1, 0x60($s0)
    /* 2C6F4 8003BEF4 00FF4224 */  addiu      $v0, $v0, -0x100
    /* 2C6F8 8003BEF8 800302AE */  sw         $v0, 0x380($s0)
    /* 2C6FC 8003BEFC 7C0302AE */  sw         $v0, 0x37C($s0)
    /* 2C700 8003BF00 58006484 */  lh         $a0, 0x58($v1)
    /* 2C704 8003BF04 5C00628C */  lw         $v0, 0x5C($v1)
    /* 2C708 8003BF08 00000000 */  nop
    /* 2C70C 8003BF0C 09F84000 */  jalr       $v0
    /* 2C710 8003BF10 21200402 */   addu      $a0, $s0, $a0
    /* 2C714 8003BF14 21280000 */  addu       $a1, $zero, $zero
  .L8003BF18:
    /* 2C718 8003BF18 00140500 */  sll        $v0, $a1, 16
    /* 2C71C 8003BF1C 0100A424 */  addiu      $a0, $a1, 0x1
    /* 2C720 8003BF20 21288000 */  addu       $a1, $a0, $zero
    /* 2C724 8003BF24 03140200 */  sra        $v0, $v0, 16
    /* 2C728 8003BF28 40180200 */  sll        $v1, $v0, 1
    /* 2C72C 8003BF2C 21186200 */  addu       $v1, $v1, $v0
    /* 2C730 8003BF30 C0180300 */  sll        $v1, $v1, 3
    /* 2C734 8003BF34 21180302 */  addu       $v1, $s0, $v1
    /* 2C738 8003BF38 00240400 */  sll        $a0, $a0, 16
    /* 2C73C 8003BF3C 03240400 */  sra        $a0, $a0, 16
    /* 2C740 8003BF40 07008428 */  slti       $a0, $a0, 0x7
    /* 2C744 8003BF44 740060A4 */  sh         $zero, 0x74($v1)
    /* 2C748 8003BF48 F3FF8014 */  bnez       $a0, .L8003BF18
    /* 2C74C 8003BF4C 780060A4 */   sh        $zero, 0x78($v1)
    /* 2C750 8003BF50 21280000 */  addu       $a1, $zero, $zero
  .L8003BF54:
    /* 2C754 8003BF54 00140500 */  sll        $v0, $a1, 16
    /* 2C758 8003BF58 83130200 */  sra        $v0, $v0, 14
    /* 2C75C 8003BF5C 21100202 */  addu       $v0, $s0, $v0
    /* 2C760 8003BF60 0C0140AC */  sw         $zero, 0x10C($v0)
    /* 2C764 8003BF64 0100A224 */  addiu      $v0, $a1, 0x1
    /* 2C768 8003BF68 21284000 */  addu       $a1, $v0, $zero
    /* 2C76C 8003BF6C 00140200 */  sll        $v0, $v0, 16
    /* 2C770 8003BF70 03140200 */  sra        $v0, $v0, 16
    /* 2C774 8003BF74 04004228 */  slti       $v0, $v0, 0x4
    /* 2C778 8003BF78 F6FF4014 */  bnez       $v0, .L8003BF54
    /* 2C77C 8003BF7C 00000000 */   nop
    /* 2C780 8003BF80 3C01BF8F */  lw         $ra, 0x13C($sp)
    /* 2C784 8003BF84 3801B08F */  lw         $s0, 0x138($sp)
    /* 2C788 8003BF88 0800E003 */  jr         $ra
    /* 2C78C 8003BF8C 4001BD27 */   addiu     $sp, $sp, 0x140
endlabel Initialize__16tScreenCarSelect
