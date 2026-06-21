.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x88

glabel ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* D508 8001CD08 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D50C 8001CD0C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D510 8001CD10 21808000 */  addu       $s0, $a0, $zero
    /* D514 8001CD14 1800B2AF */  sw         $s2, 0x18($sp)
    /* D518 8001CD18 2190A000 */  addu       $s2, $a1, $zero
    /* D51C 8001CD1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D520 8001CD20 2188C000 */  addu       $s1, $a2, $zero
    /* D524 8001CD24 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D528 8001CD28 2000BFAF */  sw         $ra, 0x20($sp)
    /* D52C 8001CD2C 2596000C */  jal        GetNumberEnabledItems__5tMenu
    /* D530 8001CD30 2198E000 */   addu      $s3, $a3, $zero
    /* D534 8001CD34 00140200 */  sll        $v0, $v0, 16
    /* D538 8001CD38 0A004014 */  bnez       $v0, .L8001CD64
    /* D53C 8001CD3C 21200002 */   addu      $a0, $s0, $zero
    /* D540 8001CD40 080000AE */  sw         $zero, 0x8($s0)
    /* D544 8001CD44 0000238E */  lw         $v1, 0x0($s1)
    /* D548 8001CD48 10000224 */  addiu      $v0, $zero, 0x10
    /* D54C 8001CD4C 05006210 */  beq        $v1, $v0, .L8001CD64
    /* D550 8001CD50 04000224 */   addiu     $v0, $zero, 0x4
    /* D554 8001CD54 03006210 */  beq        $v1, $v0, .L8001CD64
    /* D558 8001CD58 01000224 */   addiu     $v0, $zero, 0x1
    /* D55C 8001CD5C 000022AE */  sw         $v0, 0x0($s1)
    /* D560 8001CD60 21200002 */  addu       $a0, $s0, $zero
  .L8001CD64:
    /* D564 8001CD64 21284002 */  addu       $a1, $s2, $zero
    /* D568 8001CD68 21302002 */  addu       $a2, $s1, $zero
    /* D56C 8001CD6C 5E95000C */  jal        ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* D570 8001CD70 21386002 */   addu      $a3, $s3, $zero
    /* D574 8001CD74 2000BF8F */  lw         $ra, 0x20($sp)
    /* D578 8001CD78 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D57C 8001CD7C 1800B28F */  lw         $s2, 0x18($sp)
    /* D580 8001CD80 1400B18F */  lw         $s1, 0x14($sp)
    /* D584 8001CD84 1000B08F */  lw         $s0, 0x10($sp)
    /* D588 8001CD88 0800E003 */  jr         $ra
    /* D58C 8001CD8C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
