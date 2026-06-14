.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadpackadrz, 0xF8

glabel loadpackadrz
    /* D6464 800E5C64 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D6468 800E5C68 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D646C 800E5C6C 21988000 */  addu       $s3, $a0, $zero
    /* D6470 800E5C70 2000B4AF */  sw         $s4, 0x20($sp)
    /* D6474 800E5C74 21A0A000 */  addu       $s4, $a1, $zero
    /* D6478 800E5C78 1000B0AF */  sw         $s0, 0x10($sp)
    /* D647C 800E5C7C 21800000 */  addu       $s0, $zero, $zero
    /* D6480 800E5C80 2400BFAF */  sw         $ra, 0x24($sp)
    /* D6484 800E5C84 1800B2AF */  sw         $s2, 0x18($sp)
    /* D6488 800E5C88 FA95030C */  jal        loadfileadr
    /* D648C 800E5C8C 1400B1AF */   sw        $s1, 0x14($sp)
    /* D6490 800E5C90 21884000 */  addu       $s1, $v0, $zero
    /* D6494 800E5C94 29002012 */  beqz       $s1, .L800E5D3C
    /* D6498 800E5C98 21100002 */   addu      $v0, $s0, $zero
    /* D649C 800E5C9C 0190030C */  jal        unpacksize
    /* D64A0 800E5CA0 21202002 */   addu      $a0, $s1, $zero
    /* D64A4 800E5CA4 21904000 */  addu       $s2, $v0, $zero
    /* D64A8 800E5CA8 23004012 */  beqz       $s2, .L800E5D38
    /* D64AC 800E5CAC 21802002 */   addu      $s0, $s1, $zero
    /* D64B0 800E5CB0 B594030C */  jal        getblocksize
    /* D64B4 800E5CB4 21202002 */   addu      $a0, $s1, $zero
    /* D64B8 800E5CB8 21206002 */  addu       $a0, $s3, $zero
    /* D64BC 800E5CBC 21284000 */  addu       $a1, $v0, $zero
    /* D64C0 800E5CC0 CF94030C */  jal        reservememadr
    /* D64C4 800E5CC4 1000863A */   xori      $a2, $s4, 0x10
    /* D64C8 800E5CC8 21202002 */  addu       $a0, $s1, $zero
    /* D64CC 800E5CCC B594030C */  jal        getblocksize
    /* D64D0 800E5CD0 21804000 */   addu      $s0, $v0, $zero
    /* D64D4 800E5CD4 21202002 */  addu       $a0, $s1, $zero
    /* D64D8 800E5CD8 21280002 */  addu       $a1, $s0, $zero
    /* D64DC 800E5CDC B798030C */  jal        blockmove
    /* D64E0 800E5CE0 21304000 */   addu      $a2, $v0, $zero
    /* D64E4 800E5CE4 5095030C */  jal        purgememadr
    /* D64E8 800E5CE8 21202002 */   addu      $a0, $s1, $zero
    /* D64EC 800E5CEC 21880002 */  addu       $s1, $s0, $zero
    /* D64F0 800E5CF0 21206002 */  addu       $a0, $s3, $zero
    /* D64F4 800E5CF4 21284002 */  addu       $a1, $s2, $zero
    /* D64F8 800E5CF8 CF94030C */  jal        reservememadr
    /* D64FC 800E5CFC 21308002 */   addu      $a2, $s4, $zero
    /* D6500 800E5D00 21804000 */  addu       $s0, $v0, $zero
    /* D6504 800E5D04 08000012 */  beqz       $s0, .L800E5D28
    /* D6508 800E5D08 21202002 */   addu      $a0, $s1, $zero
    /* D650C 800E5D0C 9A8F030C */  jal        unpackz
    /* D6510 800E5D10 21280002 */   addu      $a1, $s0, $zero
    /* D6514 800E5D14 04004014 */  bnez       $v0, .L800E5D28
    /* D6518 800E5D18 00000000 */   nop
    /* D651C 800E5D1C 5095030C */  jal        purgememadr
    /* D6520 800E5D20 21200002 */   addu      $a0, $s0, $zero
    /* D6524 800E5D24 21800000 */  addu       $s0, $zero, $zero
  .L800E5D28:
    /* D6528 800E5D28 5095030C */  jal        purgememadr
    /* D652C 800E5D2C 21202002 */   addu      $a0, $s1, $zero
    /* D6530 800E5D30 4F970308 */  j          .L800E5D3C
    /* D6534 800E5D34 21100002 */   addu      $v0, $s0, $zero
  .L800E5D38:
    /* D6538 800E5D38 21100002 */  addu       $v0, $s0, $zero
  .L800E5D3C:
    /* D653C 800E5D3C 2400BF8F */  lw         $ra, 0x24($sp)
    /* D6540 800E5D40 2000B48F */  lw         $s4, 0x20($sp)
    /* D6544 800E5D44 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D6548 800E5D48 1800B28F */  lw         $s2, 0x18($sp)
    /* D654C 800E5D4C 1400B18F */  lw         $s1, 0x14($sp)
    /* D6550 800E5D50 1000B08F */  lw         $s0, 0x10($sp)
    /* D6554 800E5D54 0800E003 */  jr         $ra
    /* D6558 800E5D58 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadpackadrz
