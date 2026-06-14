.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FC2F8, 0x3C

glabel func_800FC2F8
    /* ECAF8 800FC2F8 03008014 */  bnez       $a0, .L800FC308
    /* ECAFC 800FC2FC 524D033C */   lui       $v1, (0x4D525453 >> 16)
    /* ECB00 800FC300 0800E003 */  jr         $ra
    /* ECB04 800FC304 01000224 */   addiu     $v0, $zero, 0x1
  .L800FC308:
    /* ECB08 800FC308 0000878C */  lw         $a3, 0x0($a0)
    /* ECB0C 800FC30C 00000000 */  nop
    /* ECB10 800FC310 0000E28C */  lw         $v0, 0x0($a3)
    /* ECB14 800FC314 53546334 */  ori        $v1, $v1, (0x4D525453 & 0xFFFF)
    /* ECB18 800FC318 04004314 */  bne        $v0, $v1, .L800FC32C
    /* ECB1C 800FC31C 21100000 */   addu      $v0, $zero, $zero
    /* ECB20 800FC320 0000C4AC */  sw         $a0, 0x0($a2)
    /* ECB24 800FC324 0800E003 */  jr         $ra
    /* ECB28 800FC328 0000A7AC */   sw        $a3, 0x0($a1)
  .L800FC32C:
    /* ECB2C 800FC32C 0800E003 */  jr         $ra
    /* ECB30 800FC330 01000224 */   addiu     $v0, $zero, 0x1
endlabel func_800FC2F8
