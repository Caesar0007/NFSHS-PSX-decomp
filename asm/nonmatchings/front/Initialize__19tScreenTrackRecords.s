.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__19tScreenTrackRecords, 0x58

glabel Initialize__19tScreenTrackRecords
    /* 32E6C 8004266C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 32E70 80042670 1000B0AF */  sw         $s0, 0x10($sp)
    /* 32E74 80042674 21808000 */  addu       $s0, $a0, $zero
    /* 32E78 80042678 1400BFAF */  sw         $ra, 0x14($sp)
    /* 32E7C 8004267C 2B98000C */  jal        Initialize__7tScreen
    /* 32E80 80042680 6C0000AE */   sw        $zero, 0x6C($s0)
    /* 32E84 80042684 0180043C */  lui        $a0, %hi(D_80011FDC)
    /* 32E88 80042688 DC1F8424 */  addiu      $a0, $a0, %lo(D_80011FDC)
    /* 32E8C 8004268C 68010524 */  addiu      $a1, $zero, 0x168
    /* 32E90 80042690 CF94030C */  jal        reservememadr
    /* 32E94 80042694 10000624 */   addiu     $a2, $zero, 0x10
    /* 32E98 80042698 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 32E9C 8004269C 640002AE */   sw        $v0, 0x64($s0)
    /* 32EA0 800426A0 00140200 */  sll        $v0, $v0, 16
    /* 32EA4 800426A4 6400058E */  lw         $a1, 0x64($s0)
    /* 32EA8 800426A8 862B010C */  jal        Stattool_GetRecords__FsP13tRecordBuffer
    /* 32EAC 800426AC 03240200 */   sra       $a0, $v0, 16
    /* 32EB0 800426B0 700000AE */  sw         $zero, 0x70($s0)
    /* 32EB4 800426B4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 32EB8 800426B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 32EBC 800426BC 0800E003 */  jr         $ra
    /* 32EC0 800426C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__19tScreenTrackRecords
