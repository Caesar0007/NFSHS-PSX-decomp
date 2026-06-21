.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_ReturnRecordLapTime__Fs, 0x64

glabel Stattool_ReturnRecordLapTime__Fs
    /* 3B660 8004AE60 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3B664 8004AE64 2800B0AF */  sw         $s0, 0x28($sp)
    /* 3B668 8004AE68 21808000 */  addu       $s0, $a0, $zero
    /* 3B66C 8004AE6C 0180043C */  lui        $a0, %hi(D_800125D4)
    /* 3B670 8004AE70 D4258424 */  addiu      $a0, $a0, %lo(D_800125D4)
    /* 3B674 8004AE74 68010524 */  addiu      $a1, $zero, 0x168
    /* 3B678 8004AE78 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 3B67C 8004AE7C CF94030C */  jal        reservememadr
    /* 3B680 8004AE80 10000624 */   addiu     $a2, $zero, 0x10
    /* 3B684 8004AE84 00841000 */  sll        $s0, $s0, 16
    /* 3B688 8004AE88 03241000 */  sra        $a0, $s0, 16
    /* 3B68C 8004AE8C 21804000 */  addu       $s0, $v0, $zero
    /* 3B690 8004AE90 862B010C */  jal        Stattool_GetRecords__FsP13tRecordBuffer
    /* 3B694 8004AE94 21280002 */   addu      $a1, $s0, $zero
    /* 3B698 8004AE98 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3B69C 8004AE9C 21280002 */  addu       $a1, $s0, $zero
    /* 3B6A0 8004AEA0 B1AA030C */  jal        memcpy
    /* 3B6A4 8004AEA4 14000624 */   addiu     $a2, $zero, 0x14
    /* 3B6A8 8004AEA8 5095030C */  jal        purgememadr
    /* 3B6AC 8004AEAC 21200002 */   addu      $a0, $s0, $zero
    /* 3B6B0 8004AEB0 2000A28F */  lw         $v0, 0x20($sp)
    /* 3B6B4 8004AEB4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 3B6B8 8004AEB8 2800B08F */  lw         $s0, 0x28($sp)
    /* 3B6BC 8004AEBC 0800E003 */  jr         $ra
    /* 3B6C0 8004AEC0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Stattool_ReturnRecordLapTime__Fs
