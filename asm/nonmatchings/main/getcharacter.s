.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getcharacter, 0x8C

glabel getcharacter
    /* E4D10 800F4510 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E4D14 800F4514 1400B1AF */  sw         $s1, 0x14($sp)
    /* E4D18 800F4518 21888000 */  addu       $s1, $a0, $zero
    /* E4D1C 800F451C 02000524 */  addiu      $a1, $zero, 0x2
    /* E4D20 800F4520 1380023C */  lui        $v0, %hi(currentfont)
    /* E4D24 800F4524 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E4D28 800F4528 A05B5324 */  addiu      $s3, $v0, %lo(currentfont)
    /* E4D2C 800F452C E0FF2326 */  addiu      $v1, $s1, -0x20
    /* E4D30 800F4530 40100300 */  sll        $v0, $v1, 1
    /* E4D34 800F4534 21104300 */  addu       $v0, $v0, $v1
    /* E4D38 800F4538 0410A200 */  sllv       $v0, $v0, $a1
    /* E4D3C 800F453C 2000BFAF */  sw         $ra, 0x20($sp)
    /* E4D40 800F4540 1800B2AF */  sw         $s2, 0x18($sp)
    /* E4D44 800F4544 1000B0AF */  sw         $s0, 0x10($sp)
    /* E4D48 800F4548 8400728E */  lw         $s2, 0x84($s3)
    /* E4D4C 800F454C 23104300 */  subu       $v0, $v0, $v1
    /* E4D50 800F4550 21804202 */  addu       $s0, $s2, $v0
    /* E4D54 800F4554 23CC030C */  jal        geti
    /* E4D58 800F4558 21200002 */   addu      $a0, $s0, $zero
    /* E4D5C 800F455C 07005110 */  beq        $v0, $s1, .L800F457C
    /* E4D60 800F4560 21202002 */   addu      $a0, $s1, $zero
    /* E4D64 800F4564 21284002 */  addu       $a1, $s2, $zero
    /* E4D68 800F4568 7400668E */  lw         $a2, 0x74($s3)
    /* E4D6C 800F456C 1CD1030C */  jal        textbsearch
    /* E4D70 800F4570 0B000724 */   addiu     $a3, $zero, 0xB
    /* E4D74 800F4574 60D10308 */  j          .L800F4580
    /* E4D78 800F4578 00000000 */   nop
  .L800F457C:
    /* E4D7C 800F457C 21100002 */  addu       $v0, $s0, $zero
  .L800F4580:
    /* E4D80 800F4580 2000BF8F */  lw         $ra, 0x20($sp)
    /* E4D84 800F4584 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E4D88 800F4588 1800B28F */  lw         $s2, 0x18($sp)
    /* E4D8C 800F458C 1400B18F */  lw         $s1, 0x14($sp)
    /* E4D90 800F4590 1000B08F */  lw         $s0, 0x10($sp)
    /* E4D94 800F4594 0800E003 */  jr         $ra
    /* E4D98 800F4598 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel getcharacter
