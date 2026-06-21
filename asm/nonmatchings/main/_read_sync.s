.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _read_sync, 0x34

glabel _read_sync
    /* F907C 8010887C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9080 80108880 1000B0AF */  sw         $s0, 0x10($sp)
    /* F9084 80108884 1480103C */  lui        $s0, %hi(D_8013C2B8)
    /* F9088 80108888 B8C21026 */  addiu      $s0, $s0, %lo(D_8013C2B8)
    /* F908C 8010888C 1400BFAF */  sw         $ra, 0x14($sp)
    /* F9090 80108890 0000048E */  lw         $a0, 0x0($s0)
    /* F9094 80108894 23DE030C */  jal        CdSyncCallback
    /* F9098 80108898 D8FF1026 */   addiu     $s0, $s0, -0x28
    /* F909C 8010889C 240000AE */  sw         $zero, 0x24($s0)
    /* F90A0 801088A0 1400BF8F */  lw         $ra, 0x14($sp)
    /* F90A4 801088A4 1000B08F */  lw         $s0, 0x10($sp)
    /* F90A8 801088A8 0800E003 */  jr         $ra
    /* F90AC 801088AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _read_sync
