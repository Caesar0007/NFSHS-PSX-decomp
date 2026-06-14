.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching systemtask, 0xEC

glabel systemtask
    /* D7404 800E6C04 F016838F */  lw         $v1, %gp_rel(D_8013DC3C)($gp)
    /* D7408 800E6C08 1480023C */  lui        $v0, %hi(libticks)
    /* D740C 800E6C0C B0DC428C */  lw         $v0, %lo(libticks)($v0)
    /* D7410 800E6C10 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D7414 800E6C14 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D7418 800E6C18 21988000 */  addu       $s3, $a0, $zero
    /* D741C 800E6C1C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D7420 800E6C20 21900000 */  addu       $s2, $zero, $zero
    /* D7424 800E6C24 2000BFAF */  sw         $ra, 0x20($sp)
    /* D7428 800E6C28 1400B1AF */  sw         $s1, 0x14($sp)
    /* D742C 800E6C2C 28006210 */  beq        $v1, $v0, .L800E6CD0
    /* D7430 800E6C30 1000B0AF */   sw        $s0, 0x10($sp)
    /* D7434 800E6C34 21884002 */  addu       $s1, $s2, $zero
    /* D7438 800E6C38 1480023C */  lui        $v0, %hi(D_8013E980)
    /* D743C 800E6C3C 1480033C */  lui        $v1, %hi(libticks)
    /* D7440 800E6C40 B0DC638C */  lw         $v1, %lo(libticks)($v1)
    /* D7444 800E6C44 80E95024 */  addiu      $s0, $v0, %lo(D_8013E980)
    /* D7448 800E6C48 F01683AF */  sw         $v1, %gp_rel(D_8013DC3C)($gp)
  .L800E6C4C:
    /* D744C 800E6C4C 0000068E */  lw         $a2, 0x0($s0)
    /* D7450 800E6C50 00000000 */  nop
    /* D7454 800E6C54 1A00C010 */  beqz       $a2, .L800E6CC0
    /* D7458 800E6C58 00000000 */   nop
    /* D745C 800E6C5C 1480023C */  lui        $v0, %hi(libticks)
    /* D7460 800E6C60 B0DC428C */  lw         $v0, %lo(libticks)($v0)
    /* D7464 800E6C64 0800038E */  lw         $v1, 0x8($s0)
    /* D7468 800E6C68 00000000 */  nop
    /* D746C 800E6C6C 2A104300 */  slt        $v0, $v0, $v1
    /* D7470 800E6C70 13004014 */  bnez       $v0, .L800E6CC0
    /* D7474 800E6C74 00000000 */   nop
    /* D7478 800E6C78 0C00028E */  lw         $v0, 0xC($s0)
    /* D747C 800E6C7C 00000000 */  nop
    /* D7480 800E6C80 0F004014 */  bnez       $v0, .L800E6CC0
    /* D7484 800E6C84 01000224 */   addiu     $v0, $zero, 0x1
    /* D7488 800E6C88 21286000 */  addu       $a1, $v1, $zero
    /* D748C 800E6C8C 0C0002AE */  sw         $v0, 0xC($s0)
    /* D7490 800E6C90 1480023C */  lui        $v0, %hi(libticks)
    /* D7494 800E6C94 B0DC428C */  lw         $v0, %lo(libticks)($v0)
    /* D7498 800E6C98 21206002 */  addu       $a0, $s3, $zero
    /* D749C 800E6C9C 09F8C000 */  jalr       $a2
    /* D74A0 800E6CA0 23284500 */   subu      $a1, $v0, $a1
    /* D74A4 800E6CA4 1480033C */  lui        $v1, %hi(libticks)
    /* D74A8 800E6CA8 B0DC638C */  lw         $v1, %lo(libticks)($v1)
    /* D74AC 800E6CAC 0400048E */  lw         $a0, 0x4($s0)
    /* D74B0 800E6CB0 25904202 */  or         $s2, $s2, $v0
    /* D74B4 800E6CB4 0C0000AE */  sw         $zero, 0xC($s0)
    /* D74B8 800E6CB8 21186400 */  addu       $v1, $v1, $a0
    /* D74BC 800E6CBC 080003AE */  sw         $v1, 0x8($s0)
  .L800E6CC0:
    /* D74C0 800E6CC0 01003126 */  addiu      $s1, $s1, 0x1
    /* D74C4 800E6CC4 1000222A */  slti       $v0, $s1, 0x10
    /* D74C8 800E6CC8 E0FF4014 */  bnez       $v0, .L800E6C4C
    /* D74CC 800E6CCC 10001026 */   addiu     $s0, $s0, 0x10
  .L800E6CD0:
    /* D74D0 800E6CD0 21104002 */  addu       $v0, $s2, $zero
    /* D74D4 800E6CD4 2000BF8F */  lw         $ra, 0x20($sp)
    /* D74D8 800E6CD8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D74DC 800E6CDC 1800B28F */  lw         $s2, 0x18($sp)
    /* D74E0 800E6CE0 1400B18F */  lw         $s1, 0x14($sp)
    /* D74E4 800E6CE4 1000B08F */  lw         $s0, 0x10($sp)
    /* D74E8 800E6CE8 0800E003 */  jr         $ra
    /* D74EC 800E6CEC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel systemtask
