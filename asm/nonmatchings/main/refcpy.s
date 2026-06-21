.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching refcpy, 0x64

glabel refcpy
    /* E5A54 800F5254 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E5A58 800F5258 0400A22C */  sltiu      $v0, $a1, 0x4
    /* E5A5C 800F525C 1400BFAF */  sw         $ra, 0x14($sp)
    /* E5A60 800F5260 0D004010 */  beqz       $v0, .L800F5298
    /* E5A64 800F5264 1000B0AF */   sw        $s0, 0x10($sp)
    /* E5A68 800F5268 01000224 */  addiu      $v0, $zero, 0x1
    /* E5A6C 800F526C 0600A214 */  bne        $a1, $v0, .L800F5288
    /* E5A70 800F5270 21808600 */   addu      $s0, $a0, $a2
    /* E5A74 800F5274 FFFF8590 */  lbu        $a1, -0x1($a0)
    /* E5A78 800F5278 C690030C */  jal        memset
    /* E5A7C 800F527C 00000000 */   nop
    /* E5A80 800F5280 AAD40308 */  j          .L800F52A8
    /* E5A84 800F5284 21100002 */   addu      $v0, $s0, $zero
  .L800F5288:
    /* E5A88 800F5288 8DD4030C */  jal        memcpyb
    /* E5A8C 800F528C 23288500 */   subu      $a1, $a0, $a1
    /* E5A90 800F5290 AAD40308 */  j          .L800F52A8
    /* E5A94 800F5294 21100002 */   addu      $v0, $s0, $zero
  .L800F5298:
    /* E5A98 800F5298 70D4030C */  jal        memcpyl
    /* E5A9C 800F529C 23288500 */   subu      $a1, $a0, $a1
    /* E5AA0 800F52A0 21804000 */  addu       $s0, $v0, $zero
    /* E5AA4 800F52A4 21100002 */  addu       $v0, $s0, $zero
  .L800F52A8:
    /* E5AA8 800F52A8 1400BF8F */  lw         $ra, 0x14($sp)
    /* E5AAC 800F52AC 1000B08F */  lw         $s0, 0x10($sp)
    /* E5AB0 800F52B0 0800E003 */  jr         $ra
    /* E5AB4 800F52B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel refcpy
