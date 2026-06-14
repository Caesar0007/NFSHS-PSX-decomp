.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSYS_service, 0x70

glabel SNDSYS_service
    /* F5078 80104878 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F507C 8010487C 1480023C */  lui        $v0, %hi(sndgs)
    /* F5080 80104880 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* F5084 80104884 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* F5088 80104888 1800B2AF */  sw         $s2, 0x18($sp)
    /* F508C 8010488C 1400B1AF */  sw         $s1, 0x14($sp)
    /* F5090 80104890 1000B0AF */  sw         $s0, 0x10($sp)
    /* F5094 80104894 41006280 */  lb         $v0, 0x41($v1)
    /* F5098 80104898 00000000 */  nop
    /* F509C 8010489C 0C004018 */  blez       $v0, .L801048D0
    /* F50A0 801048A0 21800000 */   addu      $s0, $zero, $zero
    /* F50A4 801048A4 21906000 */  addu       $s2, $v1, $zero
    /* F50A8 801048A8 21884002 */  addu       $s1, $s2, $zero
  .L801048AC:
    /* F50AC 801048AC 6400228E */  lw         $v0, 0x64($s1)
    /* F50B0 801048B0 00000000 */  nop
    /* F50B4 801048B4 09F84000 */  jalr       $v0
    /* F50B8 801048B8 04003126 */   addiu     $s1, $s1, 0x4
    /* F50BC 801048BC 41004282 */  lb         $v0, 0x41($s2)
    /* F50C0 801048C0 01001026 */  addiu      $s0, $s0, 0x1
    /* F50C4 801048C4 2A100202 */  slt        $v0, $s0, $v0
    /* F50C8 801048C8 F8FF4014 */  bnez       $v0, .L801048AC
    /* F50CC 801048CC 00000000 */   nop
  .L801048D0:
    /* F50D0 801048D0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* F50D4 801048D4 1800B28F */  lw         $s2, 0x18($sp)
    /* F50D8 801048D8 1400B18F */  lw         $s1, 0x14($sp)
    /* F50DC 801048DC 1000B08F */  lw         $s0, 0x10($sp)
    /* F50E0 801048E0 0800E003 */  jr         $ra
    /* F50E4 801048E4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSYS_service
