.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SuperCopSirenOn__Fi, 0x68

glabel SuperCopSirenOn__Fi
    /* 69F90 80079790 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 69F94 80079794 1800B0AF */  sw         $s0, 0x18($sp)
    /* 69F98 80079798 21808000 */  addu       $s0, $a0, $zero
    /* 69F9C 8007979C 1180033C */  lui        $v1, %hi(sirenCurrentPitch)
    /* 69FA0 800797A0 F0E76324 */  addiu      $v1, $v1, %lo(sirenCurrentPitch)
    /* 69FA4 800797A4 80101000 */  sll        $v0, $s0, 2
    /* 69FA8 800797A8 21104300 */  addu       $v0, $v0, $v1
    /* 69FAC 800797AC 09000524 */  addiu      $a1, $zero, 0x9
    /* 69FB0 800797B0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 69FB4 800797B4 0000428C */  lw         $v0, 0x0($v0)
    /* 69FB8 800797B8 40000624 */  addiu      $a2, $zero, 0x40
    /* 69FBC 800797BC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 69FC0 800797C0 1180023C */  lui        $v0, %hi(D_8010E8CC)
    /* 69FC4 800797C4 CCE8448C */  lw         $a0, %lo(D_8010E8CC)($v0)
    /* 69FC8 800797C8 E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* 69FCC 800797CC 21380000 */   addu      $a3, $zero, $zero
    /* 69FD0 800797D0 1180033C */  lui        $v1, %hi(gaChannel)
    /* 69FD4 800797D4 FCE86324 */  addiu      $v1, $v1, %lo(gaChannel)
    /* 69FD8 800797D8 2B001026 */  addiu      $s0, $s0, 0x2B
    /* 69FDC 800797DC C0801000 */  sll        $s0, $s0, 3
    /* 69FE0 800797E0 21800302 */  addu       $s0, $s0, $v1
    /* 69FE4 800797E4 000002AE */  sw         $v0, 0x0($s0)
    /* 69FE8 800797E8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 69FEC 800797EC 1800B08F */  lw         $s0, 0x18($sp)
    /* 69FF0 800797F0 0800E003 */  jr         $ra
    /* 69FF4 800797F4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SuperCopSirenOn__Fi
