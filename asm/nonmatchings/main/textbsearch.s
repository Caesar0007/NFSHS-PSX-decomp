.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching textbsearch, 0xA0

glabel textbsearch
    /* E4C70 800F4470 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E4C74 800F4474 2000B4AF */  sw         $s4, 0x20($sp)
    /* E4C78 800F4478 21A08000 */  addu       $s4, $a0, $zero
    /* E4C7C 800F447C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E4C80 800F4480 2190A000 */  addu       $s2, $a1, $zero
    /* E4C84 800F4484 1400B1AF */  sw         $s1, 0x14($sp)
    /* E4C88 800F4488 2188C000 */  addu       $s1, $a2, $zero
    /* E4C8C 800F448C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E4C90 800F4490 2198E000 */  addu       $s3, $a3, $zero
    /* E4C94 800F4494 2400BFAF */  sw         $ra, 0x24($sp)
    /* E4C98 800F4498 14002012 */  beqz       $s1, .L800F44EC
    /* E4C9C 800F449C 1000B0AF */   sw        $s0, 0x10($sp)
    /* E4CA0 800F44A0 43101100 */  sra        $v0, $s1, 1
  .L800F44A4:
    /* E4CA4 800F44A4 18005300 */  mult       $v0, $s3
    /* E4CA8 800F44A8 02000524 */  addiu      $a1, $zero, 0x2
    /* E4CAC 800F44AC 12180000 */  mflo       $v1
    /* E4CB0 800F44B0 21804302 */  addu       $s0, $s2, $v1
    /* E4CB4 800F44B4 23CC030C */  jal        geti
    /* E4CB8 800F44B8 21200002 */   addu      $a0, $s0, $zero
    /* E4CBC 800F44BC 23108202 */  subu       $v0, $s4, $v0
    /* E4CC0 800F44C0 03004014 */  bnez       $v0, .L800F44D0
    /* E4CC4 800F44C4 00000000 */   nop
    /* E4CC8 800F44C8 3CD10308 */  j          .L800F44F0
    /* E4CCC 800F44CC 21100002 */   addu      $v0, $s0, $zero
  .L800F44D0:
    /* E4CD0 800F44D0 03004018 */  blez       $v0, .L800F44E0
    /* E4CD4 800F44D4 00000000 */   nop
    /* E4CD8 800F44D8 21901302 */  addu       $s2, $s0, $s3
    /* E4CDC 800F44DC FFFF3126 */  addiu      $s1, $s1, -0x1
  .L800F44E0:
    /* E4CE0 800F44E0 43881100 */  sra        $s1, $s1, 1
    /* E4CE4 800F44E4 EFFF2016 */  bnez       $s1, .L800F44A4
    /* E4CE8 800F44E8 43101100 */   sra       $v0, $s1, 1
  .L800F44EC:
    /* E4CEC 800F44EC 21100000 */  addu       $v0, $zero, $zero
  .L800F44F0:
    /* E4CF0 800F44F0 2400BF8F */  lw         $ra, 0x24($sp)
    /* E4CF4 800F44F4 2000B48F */  lw         $s4, 0x20($sp)
    /* E4CF8 800F44F8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E4CFC 800F44FC 1800B28F */  lw         $s2, 0x18($sp)
    /* E4D00 800F4500 1400B18F */  lw         $s1, 0x14($sp)
    /* E4D04 800F4504 1000B08F */  lw         $s0, 0x10($sp)
    /* E4D08 800F4508 0800E003 */  jr         $ra
    /* E4D0C 800F450C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel textbsearch
