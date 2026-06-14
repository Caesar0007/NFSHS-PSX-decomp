.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14AIDataRecord_t, 0x58

glabel ___14AIDataRecord_t
    /* 5D66C 8006CE6C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5D670 8006CE70 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5D674 8006CE74 21888000 */  addu       $s1, $a0, $zero
    /* 5D678 8006CE78 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D67C 8006CE7C 2180A000 */  addu       $s0, $a1, $zero
    /* 5D680 8006CE80 0580023C */  lui        $v0, %hi(_vt_14AIDataRecord_t)
    /* 5D684 8006CE84 AC544224 */  addiu      $v0, $v0, %lo(_vt_14AIDataRecord_t)
    /* 5D688 8006CE88 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5D68C 8006CE8C 48B4010C */  jal        SaveAndPurge__14AIDataRecord_t
    /* 5D690 8006CE90 540022AE */   sw        $v0, 0x54($s1)
    /* 5D694 8006CE94 C0B3010C */  jal        RemoveRecordFromCollection__14AIDataRecord_t
    /* 5D698 8006CE98 21202002 */   addu      $a0, $s1, $zero
    /* 5D69C 8006CE9C 01001032 */  andi       $s0, $s0, 0x1
    /* 5D6A0 8006CEA0 03000012 */  beqz       $s0, .L8006CEB0
    /* 5D6A4 8006CEA4 00000000 */   nop
    /* 5D6A8 8006CEA8 6B8F020C */  jal        __builtin_delete
    /* 5D6AC 8006CEAC 21202002 */   addu      $a0, $s1, $zero
  .L8006CEB0:
    /* 5D6B0 8006CEB0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5D6B4 8006CEB4 1400B18F */  lw         $s1, 0x14($sp)
    /* 5D6B8 8006CEB8 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D6BC 8006CEBC 0800E003 */  jr         $ra
    /* 5D6C0 8006CEC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___14AIDataRecord_t
