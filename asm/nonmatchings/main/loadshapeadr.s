.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadshapeadr, 0xBC

glabel loadshapeadr
    /* E243C 800F1C3C 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* E2440 800F1C40 21108000 */  addu       $v0, $a0, $zero
    /* E2444 800F1C44 9000B0AF */  sw         $s0, 0x90($sp)
    /* E2448 800F1C48 2180A000 */  addu       $s0, $a1, $zero
    /* E244C 800F1C4C 1000A427 */  addiu      $a0, $sp, 0x10
    /* E2450 800F1C50 9400BFAF */  sw         $ra, 0x94($sp)
    /* E2454 800F1C54 CA96030C */  jal        strcpy
    /* E2458 800F1C58 21284000 */   addu      $a1, $v0, $zero
    /* E245C 800F1C5C DDA7030C */  jal        strlen
    /* E2460 800F1C60 1000A427 */   addiu     $a0, $sp, 0x10
    /* E2464 800F1C64 1000A427 */  addiu      $a0, $sp, 0x10
    /* E2468 800F1C68 21108200 */  addu       $v0, $a0, $v0
    /* E246C 800F1C6C FFFF4324 */  addiu      $v1, $v0, -0x1
    /* E2470 800F1C70 2B108300 */  sltu       $v0, $a0, $v1
    /* E2474 800F1C74 12004010 */  beqz       $v0, .L800F1CC0
    /* E2478 800F1C78 2E000824 */   addiu     $t0, $zero, 0x2E
    /* E247C 800F1C7C 3A000724 */  addiu      $a3, $zero, 0x3A
    /* E2480 800F1C80 2F000624 */  addiu      $a2, $zero, 0x2F
    /* E2484 800F1C84 5C000524 */  addiu      $a1, $zero, 0x5C
  .L800F1C88:
    /* E2488 800F1C88 00006290 */  lbu        $v0, 0x0($v1)
    /* E248C 800F1C8C 00000000 */  nop
    /* E2490 800F1C90 12004810 */  beq        $v0, $t0, .L800F1CDC
    /* E2494 800F1C94 00000000 */   nop
    /* E2498 800F1C98 09004710 */  beq        $v0, $a3, .L800F1CC0
    /* E249C 800F1C9C 00000000 */   nop
    /* E24A0 800F1CA0 07004610 */  beq        $v0, $a2, .L800F1CC0
    /* E24A4 800F1CA4 00000000 */   nop
    /* E24A8 800F1CA8 05004510 */  beq        $v0, $a1, .L800F1CC0
    /* E24AC 800F1CAC 00000000 */   nop
    /* E24B0 800F1CB0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* E24B4 800F1CB4 2B108300 */  sltu       $v0, $a0, $v1
    /* E24B8 800F1CB8 F3FF4014 */  bnez       $v0, .L800F1C88
    /* E24BC 800F1CBC 00000000 */   nop
  .L800F1CC0:
    /* E24C0 800F1CC0 00006390 */  lbu        $v1, 0x0($v1)
    /* E24C4 800F1CC4 2E000224 */  addiu      $v0, $zero, 0x2E
    /* E24C8 800F1CC8 05006210 */  beq        $v1, $v0, .L800F1CE0
    /* E24CC 800F1CCC 1000A427 */   addiu     $a0, $sp, 0x10
    /* E24D0 800F1CD0 D417858F */  lw         $a1, %gp_rel(shapeext)($gp)
    /* E24D4 800F1CD4 3A9E030C */  jal        strcat
    /* E24D8 800F1CD8 1000A427 */   addiu     $a0, $sp, 0x10
  .L800F1CDC:
    /* E24DC 800F1CDC 1000A427 */  addiu      $a0, $sp, 0x10
  .L800F1CE0:
    /* E24E0 800F1CE0 5797030C */  jal        loadpackadr
    /* E24E4 800F1CE4 21280002 */   addu      $a1, $s0, $zero
    /* E24E8 800F1CE8 9400BF8F */  lw         $ra, 0x94($sp)
    /* E24EC 800F1CEC 9000B08F */  lw         $s0, 0x90($sp)
    /* E24F0 800F1CF0 0800E003 */  jr         $ra
    /* E24F4 800F1CF4 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel loadshapeadr
