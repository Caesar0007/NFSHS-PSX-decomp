.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_InitialMemCardCheck__Fv, 0x4C

glabel Front_InitialMemCardCheck__Fv
    /* 18148 80027948 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1814C 8002794C 1480023C */  lui        $v0, %hi(MEMCARDFRONTENDISINITTED)
    /* 18150 80027950 84D240AC */  sw         $zero, %lo(MEMCARDFRONTENDISINITTED)($v0)
    /* 18154 80027954 0580023C */  lui        $v0, %hi(gPSXMemCardFull)
    /* 18158 80027958 101940AC */  sw         $zero, %lo(gPSXMemCardFull)($v0)
    /* 1815C 8002795C 0580023C */  lui        $v0, %hi(memCardReadOK)
    /* 18160 80027960 1180043C */  lui        $a0, %hi(Stats_gTrackRecords)
    /* 18164 80027964 944D8424 */  addiu      $a0, $a0, %lo(Stats_gTrackRecords)
    /* 18168 80027968 21280000 */  addu       $a1, $zero, $zero
    /* 1816C 8002796C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 18170 80027970 262B010C */  jal        Stattool_GetAllDefaultRecords__FP13tRecordBufferb
    /* 18174 80027974 381940AC */   sw        $zero, %lo(memCardReadOK)($v0)
    /* 18178 80027978 929D000C */  jal        InitFrontEndStructure__Fv
    /* 1817C 8002797C 00000000 */   nop
    /* 18180 80027980 1000BF8F */  lw         $ra, 0x10($sp)
    /* 18184 80027984 1180023C */  lui        $v0, %hi(D_80114940)
    /* 18188 80027988 404940A0 */  sb         $zero, %lo(D_80114940)($v0)
    /* 1818C 8002798C 0800E003 */  jr         $ra
    /* 18190 80027990 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Front_InitialMemCardCheck__Fv
