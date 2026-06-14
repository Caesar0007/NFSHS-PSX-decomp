.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching quickSirenOn__Fi, 0x74

glabel quickSirenOn__Fi
    /* 69F1C 8007971C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 69F20 80079720 1800B0AF */  sw         $s0, 0x18($sp)
    /* 69F24 80079724 21808000 */  addu       $s0, $a0, $zero
    /* 69F28 80079728 08000524 */  addiu      $a1, $zero, 0x8
    /* 69F2C 8007972C 01000232 */  andi       $v0, $s0, 0x1
    /* 69F30 80079730 02004010 */  beqz       $v0, .L8007973C
    /* 69F34 80079734 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* 69F38 80079738 06000524 */  addiu      $a1, $zero, 0x6
  .L8007973C:
    /* 69F3C 8007973C 1180033C */  lui        $v1, %hi(sirenCurrentPitch)
    /* 69F40 80079740 F0E76324 */  addiu      $v1, $v1, %lo(sirenCurrentPitch)
    /* 69F44 80079744 80101000 */  sll        $v0, $s0, 2
    /* 69F48 80079748 21104300 */  addu       $v0, $v0, $v1
    /* 69F4C 8007974C 0000428C */  lw         $v0, 0x0($v0)
    /* 69F50 80079750 40000624 */  addiu      $a2, $zero, 0x40
    /* 69F54 80079754 1000A2AF */  sw         $v0, 0x10($sp)
    /* 69F58 80079758 1180023C */  lui        $v0, %hi(D_8010E8CC)
    /* 69F5C 8007975C CCE8448C */  lw         $a0, %lo(D_8010E8CC)($v0)
    /* 69F60 80079760 E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* 69F64 80079764 21380000 */   addu      $a3, $zero, $zero
    /* 69F68 80079768 1180043C */  lui        $a0, %hi(gaChannel)
    /* 69F6C 8007976C FCE88424 */  addiu      $a0, $a0, %lo(gaChannel)
    /* 69F70 80079770 2B000326 */  addiu      $v1, $s0, 0x2B
    /* 69F74 80079774 C0180300 */  sll        $v1, $v1, 3
    /* 69F78 80079778 21186400 */  addu       $v1, $v1, $a0
    /* 69F7C 8007977C 000062AC */  sw         $v0, 0x0($v1)
    /* 69F80 80079780 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 69F84 80079784 1800B08F */  lw         $s0, 0x18($sp)
    /* 69F88 80079788 0800E003 */  jr         $ra
    /* 69F8C 8007978C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel quickSirenOn__Fi
