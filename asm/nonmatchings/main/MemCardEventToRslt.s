.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardEventToRslt, 0x54

glabel MemCardEventToRslt
    /* EC91C 800FC11C 01000224 */  addiu      $v0, $zero, 0x1
    /* EC920 800FC120 10008210 */  beq        $a0, $v0, .L800FC164
    /* EC924 800FC124 21180000 */   addu      $v1, $zero, $zero
    /* EC928 800FC128 02008228 */  slti       $v0, $a0, 0x2
    /* EC92C 800FC12C 05004010 */  beqz       $v0, .L800FC144
    /* EC930 800FC130 00000000 */   nop
    /* EC934 800FC134 0C008010 */  beqz       $a0, .L800FC168
    /* EC938 800FC138 00000000 */   nop
    /* EC93C 800FC13C 5AF00308 */  j          .L800FC168
    /* EC940 800FC140 00808334 */   ori       $v1, $a0, 0x8000
  .L800FC144:
    /* EC944 800FC144 02000224 */  addiu      $v0, $zero, 0x2
    /* EC948 800FC148 07008210 */  beq        $a0, $v0, .L800FC168
    /* EC94C 800FC14C 01000324 */   addiu     $v1, $zero, 0x1
    /* EC950 800FC150 04000224 */  addiu      $v0, $zero, 0x4
    /* EC954 800FC154 04008214 */  bne        $a0, $v0, .L800FC168
    /* EC958 800FC158 00808334 */   ori       $v1, $a0, 0x8000
    /* EC95C 800FC15C 5AF00308 */  j          .L800FC168
    /* EC960 800FC160 03000324 */   addiu     $v1, $zero, 0x3
  .L800FC164:
    /* EC964 800FC164 02000324 */  addiu      $v1, $zero, 0x2
  .L800FC168:
    /* EC968 800FC168 0800E003 */  jr         $ra
    /* EC96C 800FC16C 21106000 */   addu      $v0, $v1, $zero
endlabel MemCardEventToRslt
