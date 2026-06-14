.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_GetTorque__FP8Car_tObji, 0x3C

glabel Physics_GetTorque__FP8Car_tObji
    /* 99AE4 800A92E4 2900A628 */  slti       $a2, $a1, 0x29
    /* 99AE8 800A92E8 0200C014 */  bnez       $a2, .L800A92F4
    /* 99AEC 800A92EC 2110A000 */   addu      $v0, $a1, $zero
    /* 99AF0 800A92F0 28000224 */  addiu      $v0, $zero, 0x28
  .L800A92F4:
    /* 99AF4 800A92F4 04004018 */  blez       $v0, .L800A9308
    /* 99AF8 800A92F8 21180000 */   addu      $v1, $zero, $zero
    /* 99AFC 800A92FC 0200C010 */  beqz       $a2, .L800A9308
    /* 99B00 800A9300 28000324 */   addiu     $v1, $zero, 0x28
    /* 99B04 800A9304 2118A000 */  addu       $v1, $a1, $zero
  .L800A9308:
    /* 99B08 800A9308 6404828C */  lw         $v0, 0x464($a0)
    /* 99B0C 800A930C 80180300 */  sll        $v1, $v1, 2
    /* 99B10 800A9310 21104300 */  addu       $v0, $v0, $v1
    /* 99B14 800A9314 4C00428C */  lw         $v0, 0x4C($v0)
    /* 99B18 800A9318 0800E003 */  jr         $ra
    /* 99B1C 800A931C 00000000 */   nop
endlabel Physics_GetTorque__FP8Car_tObji
