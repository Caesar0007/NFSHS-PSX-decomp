.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching freeop, 0x48

glabel freeop
    /* DD9F8 800ED1F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DD9FC 800ED1FC 1400BFAF */  sw         $ra, 0x14($sp)
    /* DDA00 800ED200 1000B0AF */  sw         $s0, 0x10($sp)
    /* DDA04 800ED204 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* DDA08 800ED208 00000000 */  nop
    /* DDA0C 800ED20C FEFB0124 */  addiu      $at, $zero, -0x402
    /* DDA10 800ED210 24400102 */  and        $t0, $s0, $at
    /* DDA14 800ED214 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DDA18 800ED218 00000000 */  nop
    /* DDA1C 800ED21C 00000000 */  nop
    /* DDA20 800ED220 00000000 */  nop
    /* DDA24 800ED224 E8C5030C */  jal        blockclear
    /* DDA28 800ED228 30000524 */   addiu     $a1, $zero, 0x30
    /* DDA2C 800ED22C 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* DDA30 800ED230 1400BF8F */  lw         $ra, 0x14($sp)
    /* DDA34 800ED234 1000B08F */  lw         $s0, 0x10($sp)
    /* DDA38 800ED238 0800E003 */  jr         $ra
    /* DDA3C 800ED23C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel freeop
