.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PCread, 0xC0

glabel PCread
    /* F73E4 80106BE4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F73E8 80106BE8 2000B4AF */  sw         $s4, 0x20($sp)
    /* F73EC 80106BEC 21A08000 */  addu       $s4, $a0, $zero
    /* F73F0 80106BF0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F73F4 80106BF4 2198A000 */  addu       $s3, $a1, $zero
    /* F73F8 80106BF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* F73FC 80106BFC 2180C000 */  addu       $s0, $a2, $zero
    /* F7400 80106C00 1800B2AF */  sw         $s2, 0x18($sp)
    /* F7404 80106C04 21900000 */  addu       $s2, $zero, $zero
    /* F7408 80106C08 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* F740C 80106C0C 2800B6AF */  sw         $s6, 0x28($sp)
    /* F7410 80106C10 2400B5AF */  sw         $s5, 0x24($sp)
    /* F7414 80106C14 17000012 */  beqz       $s0, .L80106C74
    /* F7418 80106C18 1400B1AF */   sw        $s1, 0x14($sp)
    /* F741C 80106C1C 00801634 */  ori        $s6, $zero, 0x8000
    /* F7420 80106C20 FFFF1524 */  addiu      $s5, $zero, -0x1
    /* F7424 80106C24 2B10D002 */  sltu       $v0, $s6, $s0
  .L80106C28:
    /* F7428 80106C28 02004010 */  beqz       $v0, .L80106C34
    /* F742C 80106C2C 21880002 */   addu      $s1, $s0, $zero
    /* F7430 80106C30 00801134 */  ori        $s1, $zero, 0x8000
  .L80106C34:
    /* F7434 80106C34 21200000 */  addu       $a0, $zero, $zero
    /* F7438 80106C38 21288002 */  addu       $a1, $s4, $zero
    /* F743C 80106C3C 21302002 */  addu       $a2, $s1, $zero
    /* F7440 80106C40 C231040C */  jal        _SN_read
    /* F7444 80106C44 21386002 */   addu      $a3, $s3, $zero
    /* F7448 80106C48 03005514 */  bne        $v0, $s5, .L80106C58
    /* F744C 80106C4C 21904202 */   addu      $s2, $s2, $v0
    /* F7450 80106C50 1E1B0408 */  j          .L80106C78
    /* F7454 80106C54 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80106C58:
    /* F7458 80106C58 21986202 */  addu       $s3, $s3, $v0
    /* F745C 80106C5C 23800202 */  subu       $s0, $s0, $v0
    /* F7460 80106C60 2A105100 */  slt        $v0, $v0, $s1
    /* F7464 80106C64 03004014 */  bnez       $v0, .L80106C74
    /* F7468 80106C68 00000000 */   nop
    /* F746C 80106C6C EEFF0016 */  bnez       $s0, .L80106C28
    /* F7470 80106C70 2B10D002 */   sltu      $v0, $s6, $s0
  .L80106C74:
    /* F7474 80106C74 21104002 */  addu       $v0, $s2, $zero
  .L80106C78:
    /* F7478 80106C78 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* F747C 80106C7C 2800B68F */  lw         $s6, 0x28($sp)
    /* F7480 80106C80 2400B58F */  lw         $s5, 0x24($sp)
    /* F7484 80106C84 2000B48F */  lw         $s4, 0x20($sp)
    /* F7488 80106C88 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F748C 80106C8C 1800B28F */  lw         $s2, 0x18($sp)
    /* F7490 80106C90 1400B18F */  lw         $s1, 0x14($sp)
    /* F7494 80106C94 1000B08F */  lw         $s0, 0x10($sp)
    /* F7498 80106C98 3000BD27 */  addiu      $sp, $sp, 0x30
    /* F749C 80106C9C 0800E003 */  jr         $ra
    /* F74A0 80106CA0 00000000 */   nop
endlabel PCread
