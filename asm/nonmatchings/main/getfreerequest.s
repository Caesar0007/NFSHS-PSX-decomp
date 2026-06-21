.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching getfreerequest, 0x78

glabel getfreerequest
    /* ECC00 800FC400 00600640 */  mfc0       $a2, $12 /* handwritten instruction */
    /* ECC04 800FC404 00000000 */  nop
    /* ECC08 800FC408 FEFB0124 */  addiu      $at, $zero, -0x402
    /* ECC0C 800FC40C 2440C100 */  and        $t0, $a2, $at
    /* ECC10 800FC410 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ECC14 800FC414 00000000 */  nop
    /* ECC18 800FC418 00000000 */  nop
    /* ECC1C 800FC41C 00000000 */  nop
    /* ECC20 800FC420 5800828C */  lw         $v0, 0x58($a0)
    /* ECC24 800FC424 00000000 */  nop
    /* ECC28 800FC428 10004010 */  beqz       $v0, .L800FC46C
    /* ECC2C 800FC42C 21280000 */   addu      $a1, $zero, $zero
    /* ECC30 800FC430 21284000 */  addu       $a1, $v0, $zero
    /* ECC34 800FC434 9019828F */  lw         $v0, %gp_rel(D_8013DEDC)($gp)
    /* ECC38 800FC438 0C00A38C */  lw         $v1, 0xC($a1)
    /* ECC3C 800FC43C 00014224 */  addiu      $v0, $v0, 0x100
    /* ECC40 800FC440 580083AC */  sw         $v1, 0x58($a0)
    /* ECC44 800FC444 901982AF */  sw         $v0, %gp_rel(D_8013DEDC)($gp)
    /* ECC48 800FC448 03004014 */  bnez       $v0, .L800FC458
    /* ECC4C 800FC44C 00000000 */   nop
    /* ECC50 800FC450 00010224 */  addiu      $v0, $zero, 0x100
    /* ECC54 800FC454 901982AF */  sw         $v0, %gp_rel(D_8013DEDC)($gp)
  .L800FC458:
    /* ECC58 800FC458 0000A290 */  lbu        $v0, 0x0($a1)
    /* ECC5C 800FC45C 9019838F */  lw         $v1, %gp_rel(D_8013DEDC)($gp)
    /* ECC60 800FC460 00000000 */  nop
    /* ECC64 800FC464 25104300 */  or         $v0, $v0, $v1
    /* ECC68 800FC468 0000A2AC */  sw         $v0, 0x0($a1)
  .L800FC46C:
    /* ECC6C 800FC46C 00608640 */  mtc0       $a2, $12 /* handwritten instruction */
    /* ECC70 800FC470 0800E003 */  jr         $ra
    /* ECC74 800FC474 2110A000 */   addu      $v0, $a1, $zero
endlabel getfreerequest
