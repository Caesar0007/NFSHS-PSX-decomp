.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc, 0x48

glabel __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
    /* 5D624 8006CE24 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5D628 8006CE28 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D62C 8006CE2C 21808000 */  addu       $s0, $a0, $zero
    /* 5D630 8006CE30 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5D634 8006CE34 2188C000 */  addu       $s1, $a2, $zero
    /* 5D638 8006CE38 0580023C */  lui        $v0, %hi(_vt_14AIDataRecord_t)
    /* 5D63C 8006CE3C AC544224 */  addiu      $v0, $v0, %lo(_vt_14AIDataRecord_t)
    /* 5D640 8006CE40 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5D644 8006CE44 B1B3010C */  jal        AddRecordToCollection__14AIDataRecord_t
    /* 5D648 8006CE48 540002AE */   sw        $v0, 0x54($s0)
    /* 5D64C 8006CE4C 21100002 */  addu       $v0, $s0, $zero
    /* 5D650 8006CE50 4C0051AC */  sw         $s1, 0x4C($v0)
    /* 5D654 8006CE54 500040AC */  sw         $zero, 0x50($v0)
    /* 5D658 8006CE58 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5D65C 8006CE5C 1400B18F */  lw         $s1, 0x14($sp)
    /* 5D660 8006CE60 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D664 8006CE64 0800E003 */  jr         $ra
    /* 5D668 8006CE68 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
