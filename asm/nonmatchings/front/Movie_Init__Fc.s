.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_Init__Fc, 0x1D0

glabel Movie_Init__Fc
    /* 3CE08 8004C608 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3CE0C 8004C60C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3CE10 8004C610 0580023C */  lui        $v0, %hi(movie24bit)
    /* 3CE14 8004C614 F8294224 */  addiu      $v0, $v0, %lo(movie24bit)
    /* 3CE18 8004C618 08004010 */  beqz       $v0, .L8004C63C
    /* 3CE1C 8004C61C 21388000 */   addu      $a3, $a0, $zero
    /* 3CE20 8004C620 0580033C */  lui        $v1, %hi(D_80052CFC)
    /* 3CE24 8004C624 03000224 */  addiu      $v0, $zero, 0x3
    /* 3CE28 8004C628 FC2C62A4 */  sh         $v0, %lo(D_80052CFC)($v1)
    /* 3CE2C 8004C62C 0580033C */  lui        $v1, %hi(D_80052CFE)
    /* 3CE30 8004C630 02000224 */  addiu      $v0, $zero, 0x2
    /* 3CE34 8004C634 94310108 */  j          .L8004C650
    /* 3CE38 8004C638 FE2C62A4 */   sh        $v0, %lo(D_80052CFE)($v1)
  .L8004C63C:
    /* 3CE3C 8004C63C 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3CE40 8004C640 01000324 */  addiu      $v1, $zero, 0x1
    /* 3CE44 8004C644 FC2C43A4 */  sh         $v1, %lo(D_80052CFC)($v0)
    /* 3CE48 8004C648 0580023C */  lui        $v0, %hi(D_80052CFE)
    /* 3CE4C 8004C64C FE2C43A4 */  sh         $v1, %lo(D_80052CFE)($v0)
  .L8004C650:
    /* 3CE50 8004C650 21200000 */  addu       $a0, $zero, $zero
    /* 3CE54 8004C654 21288000 */  addu       $a1, $a0, $zero
    /* 3CE58 8004C658 21308000 */  addu       $a2, $a0, $zero
    /* 3CE5C 8004C65C 0580023C */  lui        $v0, %hi(moviewidth)
    /* 3CE60 8004C660 182A4224 */  addiu      $v0, $v0, %lo(moviewidth)
    /* 3CE64 8004C664 FF00E330 */  andi       $v1, $a3, 0xFF
    /* 3CE68 8004C668 40180300 */  sll        $v1, $v1, 1
    /* 3CE6C 8004C66C 21106200 */  addu       $v0, $v1, $v0
    /* 3CE70 8004C670 00004794 */  lhu        $a3, 0x0($v0)
    /* 3CE74 8004C674 0580023C */  lui        $v0, %hi(D_80052D0A)
    /* 3CE78 8004C678 0A2D47A4 */  sh         $a3, %lo(D_80052D0A)($v0)
    /* 3CE7C 8004C67C 0580023C */  lui        $v0, %hi(movieheight)
    /* 3CE80 8004C680 0C2A4224 */  addiu      $v0, $v0, %lo(movieheight)
    /* 3CE84 8004C684 21186200 */  addu       $v1, $v1, $v0
    /* 3CE88 8004C688 0580023C */  lui        $v0, %hi(D_80052D08)
    /* 3CE8C 8004C68C 00006394 */  lhu        $v1, 0x0($v1)
    /* 3CE90 8004C690 00010724 */  addiu      $a3, $zero, 0x100
    /* 3CE94 8004C694 2C32010C */  jal        Movie_SetDecodeOffset__Fssss
    /* 3CE98 8004C698 082D43A4 */   sh        $v1, %lo(D_80052D08)($v0)
    /* 3CE9C 8004C69C 21200000 */  addu       $a0, $zero, $zero
    /* 3CEA0 8004C6A0 0580023C */  lui        $v0, %hi(D_80052D0C)
    /* 3CEA4 8004C6A4 0C2D40AC */  sw         $zero, %lo(D_80052D0C)($v0)
    /* 3CEA8 8004C6A8 0580023C */  lui        $v0, %hi(D_80052D10)
    /* 3CEAC 8004C6AC 102D40AC */  sw         $zero, %lo(D_80052D10)($v0)
    /* 3CEB0 8004C6B0 0580023C */  lui        $v0, %hi(D_80052D14)
    /* 3CEB4 8004C6B4 C3C1030C */  jal        settrans
    /* 3CEB8 8004C6B8 142D40AC */   sw        $zero, %lo(D_80052D14)($v0)
    /* 3CEBC 8004C6BC 0180043C */  lui        $a0, %hi(D_80012790)
    /* 3CEC0 8004C6C0 90278424 */  addiu      $a0, $a0, %lo(D_80012790)
    /* 3CEC4 8004C6C4 0200053C */  lui        $a1, (0x28000 >> 16)
    /* 3CEC8 8004C6C8 0080A534 */  ori        $a1, $a1, (0x28000 & 0xFFFF)
    /* 3CECC 8004C6CC 10000624 */  addiu      $a2, $zero, 0x10
    /* 3CED0 8004C6D0 0580023C */  lui        $v0, %hi(download)
    /* 3CED4 8004C6D4 CF94030C */  jal        reservememadr
    /* 3CED8 8004C6D8 302A40A4 */   sh        $zero, %lo(download)($v0)
    /* 3CEDC 8004C6DC 0180043C */  lui        $a0, %hi(D_80012798)
    /* 3CEE0 8004C6E0 98278424 */  addiu      $a0, $a0, %lo(D_80012798)
    /* 3CEE4 8004C6E4 0200053C */  lui        $a1, (0x28000 >> 16)
    /* 3CEE8 8004C6E8 0080A534 */  ori        $a1, $a1, (0x28000 & 0xFFFF)
    /* 3CEEC 8004C6EC 10000624 */  addiu      $a2, $zero, 0x10
    /* 3CEF0 8004C6F0 0580033C */  lui        $v1, %hi(D_80052D58)
    /* 3CEF4 8004C6F4 CF94030C */  jal        reservememadr
    /* 3CEF8 8004C6F8 582D62AC */   sw        $v0, %lo(D_80052D58)($v1)
    /* 3CEFC 8004C6FC 0580033C */  lui        $v1, %hi(D_80052CFC)
    /* 3CF00 8004C700 0580043C */  lui        $a0, %hi(D_80052CFE)
    /* 3CF04 8004C704 FC2C6384 */  lh         $v1, %lo(D_80052CFC)($v1)
    /* 3CF08 8004C708 FE2C8484 */  lh         $a0, %lo(D_80052CFE)($a0)
    /* 3CF0C 8004C70C 40190300 */  sll        $v1, $v1, 5
    /* 3CF10 8004C710 1B006400 */  divu       $zero, $v1, $a0
    /* 3CF14 8004C714 02008014 */  bnez       $a0, .L8004C720
    /* 3CF18 8004C718 00000000 */   nop
    /* 3CF1C 8004C71C 0D000700 */  break      7
  .L8004C720:
    /* 3CF20 8004C720 12180000 */  mflo       $v1
    /* 3CF24 8004C724 10000624 */  addiu      $a2, $zero, 0x10
    /* 3CF28 8004C728 0580053C */  lui        $a1, %hi(D_80052D5C)
    /* 3CF2C 8004C72C 5C2DA2AC */  sw         $v0, %lo(D_80052D5C)($a1)
    /* 3CF30 8004C730 0180043C */  lui        $a0, %hi(D_800127A0)
    /* 3CF34 8004C734 A0278424 */  addiu      $a0, $a0, %lo(D_800127A0)
    /* 3CF38 8004C738 00290300 */  sll        $a1, $v1, 4
    /* 3CF3C 8004C73C 2328A300 */  subu       $a1, $a1, $v1
    /* 3CF40 8004C740 CF94030C */  jal        reservememadr
    /* 3CF44 8004C744 40290500 */   sll       $a1, $a1, 5
    /* 3CF48 8004C748 0180043C */  lui        $a0, %hi(D_800127A8)
    /* 3CF4C 8004C74C A8278424 */  addiu      $a0, $a0, %lo(D_800127A8)
    /* 3CF50 8004C750 0100053C */  lui        $a1, (0x10000 >> 16)
    /* 3CF54 8004C754 10000624 */  addiu      $a2, $zero, 0x10
    /* 3CF58 8004C758 0580033C */  lui        $v1, %hi(D_80052D60)
    /* 3CF5C 8004C75C CF94030C */  jal        reservememadr
    /* 3CF60 8004C760 602D62AC */   sw        $v0, %lo(D_80052D60)($v1)
    /* 3CF64 8004C764 0580033C */  lui        $v1, %hi(D_80052D64)
    /* 3CF68 8004C768 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 3CF6C 8004C76C 642D62AC */   sw        $v0, %lo(D_80052D64)($v1)
    /* 3CF70 8004C770 2AE9030C */  jal        CD_Restart
    /* 3CF74 8004C774 21200000 */   addu      $a0, $zero, $zero
    /* 3CF78 8004C778 0B000424 */  addiu      $a0, $zero, 0xB
    /* 3CF7C 8004C77C 21280000 */  addu       $a1, $zero, $zero
    /* 3CF80 8004C780 C9DE030C */  jal        CdControlB
    /* 3CF84 8004C784 2130A000 */   addu      $a2, $a1, $zero
    /* 3CF88 8004C788 09000424 */  addiu      $a0, $zero, 0x9
    /* 3CF8C 8004C78C 21280000 */  addu       $a1, $zero, $zero
    /* 3CF90 8004C790 C9DE030C */  jal        CdControlB
    /* 3CF94 8004C794 2130A000 */   addu      $a2, $a1, $zero
    /* 3CF98 8004C798 0C000424 */  addiu      $a0, $zero, 0xC
    /* 3CF9C 8004C79C 21280000 */  addu       $a1, $zero, $zero
    /* 3CFA0 8004C7A0 C9DE030C */  jal        CdControlB
    /* 3CFA4 8004C7A4 2130A000 */   addu      $a2, $a1, $zero
    /* 3CFA8 8004C7A8 B5E2030C */  jal        DecDCToutCallback
    /* 3CFAC 8004C7AC 21200000 */   addu      $a0, $zero, $zero
    /* 3CFB0 8004C7B0 2CDF030C */  jal        CdDataCallback
    /* 3CFB4 8004C7B4 21200000 */   addu      $a0, $zero, $zero
    /* 3CFB8 8004C7B8 28DE030C */  jal        CdReadyCallback
    /* 3CFBC 8004C7BC 21200000 */   addu      $a0, $zero, $zero
    /* 3CFC0 8004C7C0 00DD030C */  jal        DecDCTvlcSize
    /* 3CFC4 8004C7C4 21200000 */   addu      $a0, $zero, $zero
    /* 3CFC8 8004C7C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3CFCC 8004C7CC 00000000 */  nop
    /* 3CFD0 8004C7D0 0800E003 */  jr         $ra
    /* 3CFD4 8004C7D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Movie_Init__Fc
