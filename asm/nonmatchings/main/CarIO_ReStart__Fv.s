.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_ReStart__Fv, 0x4C

glabel CarIO_ReStart__Fv
    /* AC7A4 800BBFA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC7A8 800BBFA8 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AC7AC 800BBFAC 63020324 */  addiu      $v1, $zero, 0x263
    /* AC7B0 800BBFB0 1000BFAF */  sw         $ra, 0x10($sp)
    /* AC7B4 800BBFB4 30264224 */  addiu      $v0, $v0, 0x2630
  .L800BBFB8:
    /* AC7B8 800BBFB8 0E0040A4 */  sh         $zero, 0xE($v0)
    /* AC7BC 800BBFBC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* AC7C0 800BBFC0 FDFF6104 */  bgez       $v1, .L800BBFB8
    /* AC7C4 800BBFC4 F0FF4224 */   addiu     $v0, $v0, -0x10
    /* AC7C8 800BBFC8 F01180AF */  sw         $zero, %gp_rel(CarIO_carPixMapCount)($gp)
    /* AC7CC 800BBFCC F41180AF */  sw         $zero, %gp_rel(CarIO_carVRamCount)($gp)
    /* AC7D0 800BBFD0 7CF1020C */  jal        CarIO_CleanUpLicense__Fi
    /* AC7D4 800BBFD4 21200000 */   addu      $a0, $zero, $zero
    /* AC7D8 800BBFD8 7CF1020C */  jal        CarIO_CleanUpLicense__Fi
    /* AC7DC 800BBFDC 01000424 */   addiu     $a0, $zero, 0x1
    /* AC7E0 800BBFE0 1000BF8F */  lw         $ra, 0x10($sp)
    /* AC7E4 800BBFE4 00000000 */  nop
    /* AC7E8 800BBFE8 0800E003 */  jr         $ra
    /* AC7EC 800BBFEC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CarIO_ReStart__Fv
