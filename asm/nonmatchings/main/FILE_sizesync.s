.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_sizesync, 0x54

glabel FILE_sizesync
    /* DB1A4 800EA9A4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB1A8 800EA9A8 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB1AC 800EA9AC 21880000 */  addu       $s1, $zero, $zero
    /* DB1B0 800EA9B0 21302002 */  addu       $a2, $s1, $zero
    /* DB1B4 800EA9B4 1800BFAF */  sw         $ra, 0x18($sp)
    /* DB1B8 800EA9B8 74B1030C */  jal        FILE_size
    /* DB1BC 800EA9BC 1000B0AF */   sw        $s0, 0x10($sp)
    /* DB1C0 800EA9C0 21804000 */  addu       $s0, $v0, $zero
    /* DB1C4 800EA9C4 07000012 */  beqz       $s0, .L800EA9E4
    /* DB1C8 800EA9C8 21102002 */   addu      $v0, $s1, $zero
    /* DB1CC 800EA9CC 6FB0030C */  jal        FILE_waitop
    /* DB1D0 800EA9D0 21200002 */   addu      $a0, $s0, $zero
    /* DB1D4 800EA9D4 ACB0030C */  jal        FILE_completeop
    /* DB1D8 800EA9D8 21200002 */   addu      $a0, $s0, $zero
    /* DB1DC 800EA9DC 21884000 */  addu       $s1, $v0, $zero
    /* DB1E0 800EA9E0 21102002 */  addu       $v0, $s1, $zero
  .L800EA9E4:
    /* DB1E4 800EA9E4 1800BF8F */  lw         $ra, 0x18($sp)
    /* DB1E8 800EA9E8 1400B18F */  lw         $s1, 0x14($sp)
    /* DB1EC 800EA9EC 1000B08F */  lw         $s0, 0x10($sp)
    /* DB1F0 800EA9F0 0800E003 */  jr         $ra
    /* DB1F4 800EA9F4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_sizesync
