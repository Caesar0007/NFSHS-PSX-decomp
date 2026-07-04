.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching freehandle, 0x48

glabel freehandle
    /* DDAF0 800ED2F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DDAF4 800ED2F4 1400BFAF */  sw         $ra, 0x14($sp)
    /* DDAF8 800ED2F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* DDAFC 800ED2FC 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* DDB00 800ED300 00000000 */  nop
    /* DDB04 800ED304 FEFB0124 */  addiu      $at, $zero, -0x402
    /* DDB08 800ED308 24400102 */  and        $t0, $s0, $at
    /* DDB0C 800ED30C 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DDB10 800ED310 00000000 */  nop
    /* DDB14 800ED314 00000000 */  nop
    /* DDB18 800ED318 00000000 */  nop
    /* DDB1C 800ED31C E8C5030C */  jal        blockclear
    /* DDB20 800ED320 4C000524 */   addiu     $a1, $zero, 0x4C
    /* DDB24 800ED324 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* DDB28 800ED328 1400BF8F */  lw         $ra, 0x14($sp)
    /* DDB2C 800ED32C 1000B08F */  lw         $s0, 0x10($sp)
    /* DDB30 800ED330 0800E003 */  jr         $ra
    /* DDB34 800ED334 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel freehandle
