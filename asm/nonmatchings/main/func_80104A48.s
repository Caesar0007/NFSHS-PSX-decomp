.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80104A48, 0x68

glabel func_80104A48
    /* F5248 80104A48 1380033C */  lui        $v1, %hi(D_80137CD8)
    /* F524C 80104A4C D87C638C */  lw         $v1, %lo(D_80137CD8)($v1)
    /* F5250 80104A50 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F5254 80104A54 1000BFAF */  sw         $ra, 0x10($sp)
    /* F5258 80104A58 0400628C */  lw         $v0, 0x4($v1)
    /* F525C 80104A5C 00000000 */  nop
    /* F5260 80104A60 01004230 */  andi       $v0, $v0, 0x1
    /* F5264 80104A64 0E004010 */  beqz       $v0, .L80104AA0
    /* F5268 80104A68 21100000 */   addu      $v0, $zero, $zero
    /* F526C 80104A6C 0000628C */  lw         $v0, 0x0($v1)
    /* F5270 80104A70 00000000 */  nop
    /* F5274 80104A74 01004230 */  andi       $v0, $v0, 0x1
    /* F5278 80104A78 09004010 */  beqz       $v0, .L80104AA0
    /* F527C 80104A7C 21100000 */   addu      $v0, $zero, $zero
    /* F5280 80104A80 1380023C */  lui        $v0, %hi(_padFuncIntGun)
    /* F5284 80104A84 A07C428C */  lw         $v0, %lo(_padFuncIntGun)($v0)
    /* F5288 80104A88 00000000 */  nop
    /* F528C 80104A8C 03004010 */  beqz       $v0, .L80104A9C
    /* F5290 80104A90 00000000 */   nop
    /* F5294 80104A94 09F84000 */  jalr       $v0
    /* F5298 80104A98 00000000 */   nop
  .L80104A9C:
    /* F529C 80104A9C 01000224 */  addiu      $v0, $zero, 0x1
  .L80104AA0:
    /* F52A0 80104AA0 1000BF8F */  lw         $ra, 0x10($sp)
    /* F52A4 80104AA4 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F52A8 80104AA8 0800E003 */  jr         $ra
    /* F52AC 80104AAC 00000000 */   nop
endlabel func_80104A48
