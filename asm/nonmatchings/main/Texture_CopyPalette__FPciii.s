.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_CopyPalette__FPciii, 0x60

glabel Texture_CopyPalette__FPciii
    /* D023C 800DFA3C C415828F */  lw         $v0, %gp_rel(Texture_palNum)($gp)
    /* D0240 800DFA40 21400000 */  addu       $t0, $zero, $zero
    /* D0244 800DFA44 80190200 */  sll        $v1, $v0, 6
    /* D0248 800DFA48 21186200 */  addu       $v1, $v1, $v0
    /* D024C 800DFA4C C015828F */  lw         $v0, %gp_rel(Texture_palCopy)($gp)
    /* D0250 800DFA50 C0180300 */  sll        $v1, $v1, 3
    /* D0254 800DFA54 21186200 */  addu       $v1, $v1, $v0
    /* D0258 800DFA58 08006924 */  addiu      $t1, $v1, 0x8
    /* D025C 800DFA5C 000066AC */  sw         $a2, 0x0($v1)
    /* D0260 800DFA60 0800A018 */  blez       $a1, .L800DFA84
    /* D0264 800DFA64 040067AC */   sw        $a3, 0x4($v1)
  .L800DFA68:
    /* D0268 800DFA68 00008294 */  lhu        $v0, 0x0($a0)
    /* D026C 800DFA6C 02008424 */  addiu      $a0, $a0, 0x2
    /* D0270 800DFA70 01000825 */  addiu      $t0, $t0, 0x1
    /* D0274 800DFA74 000022A5 */  sh         $v0, 0x0($t1)
    /* D0278 800DFA78 2A100501 */  slt        $v0, $t0, $a1
    /* D027C 800DFA7C FAFF4014 */  bnez       $v0, .L800DFA68
    /* D0280 800DFA80 02002925 */   addiu     $t1, $t1, 0x2
  .L800DFA84:
    /* D0284 800DFA84 C415828F */  lw         $v0, %gp_rel(Texture_palNum)($gp)
    /* D0288 800DFA88 00000000 */  nop
    /* D028C 800DFA8C 01004224 */  addiu      $v0, $v0, 0x1
    /* D0290 800DFA90 C41582AF */  sw         $v0, %gp_rel(Texture_palNum)($gp)
    /* D0294 800DFA94 0800E003 */  jr         $ra
    /* D0298 800DFA98 00000000 */   nop
endlabel Texture_CopyPalette__FPciii
