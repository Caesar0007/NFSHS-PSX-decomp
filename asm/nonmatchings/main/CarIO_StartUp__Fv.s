.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_StartUp__Fv, 0x6C

glabel CarIO_StartUp__Fv
    /* AC710 800BBF10 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AC714 800BBF14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC718 800BBF18 07004014 */  bnez       $v0, .L800BBF38
    /* AC71C 800BBF1C 1000BFAF */   sw        $ra, 0x10($sp)
    /* AC720 800BBF20 0580043C */  lui        $a0, %hi(D_8005676C)
    /* AC724 800BBF24 6C678424 */  addiu      $a0, $a0, %lo(D_8005676C)
    /* AC728 800BBF28 40260524 */  addiu      $a1, $zero, 0x2640
    /* AC72C 800BBF2C CF94030C */  jal        reservememadr
    /* AC730 800BBF30 21300000 */   addu      $a2, $zero, $zero
    /* AC734 800BBF34 D01182AF */  sw         $v0, %gp_rel(CarIO_carPixMap)($gp)
  .L800BBF38:
    /* AC738 800BBF38 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AC73C 800BBF3C 63020324 */  addiu      $v1, $zero, 0x263
    /* AC740 800BBF40 30264224 */  addiu      $v0, $v0, 0x2630
  .L800BBF44:
    /* AC744 800BBF44 0E0040A4 */  sh         $zero, 0xE($v0)
    /* AC748 800BBF48 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* AC74C 800BBF4C FDFF6104 */  bgez       $v1, .L800BBF44
    /* AC750 800BBF50 F0FF4224 */   addiu     $v0, $v0, -0x10
    /* AC754 800BBF54 1000BF8F */  lw         $ra, 0x10($sp)
    /* AC758 800BBF58 F01180AF */  sw         $zero, %gp_rel(CarIO_carPixMapCount)($gp)
    /* AC75C 800BBF5C F41180AF */  sw         $zero, %gp_rel(CarIO_carVRamCount)($gp)
    /* AC760 800BBF60 F81180AF */  sw         $zero, %gp_rel(CarIO_licenseSFX_Count)($gp)
    /* AC764 800BBF64 041280AF */  sw         $zero, %gp_rel(CarIO_Plate2)($gp)
    /* AC768 800BBF68 FC1180AF */  sw         $zero, %gp_rel(CarIO_Plate1)($gp)
    /* AC76C 800BBF6C 081280AF */  sw         $zero, %gp_rel(D_8013D754)($gp)
    /* AC770 800BBF70 001280AF */  sw         $zero, %gp_rel(D_8013D74C)($gp)
    /* AC774 800BBF74 0800E003 */  jr         $ra
    /* AC778 800BBF78 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CarIO_StartUp__Fv
