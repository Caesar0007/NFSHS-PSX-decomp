.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrackSpec_Load__Fii, 0x60

glabel TrackSpec_Load__Fii
    /* D20CC 800E18CC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D20D0 800E18D0 0580023C */  lui        $v0, %hi(D_80056AD4)
    /* D20D4 800E18D4 80280500 */  sll        $a1, $a1, 2
    /* D20D8 800E18D8 C0200400 */  sll        $a0, $a0, 3
    /* D20DC 800E18DC 2128A400 */  addu       $a1, $a1, $a0
    /* D20E0 800E18E0 2000BFAF */  sw         $ra, 0x20($sp)
    /* D20E4 800E18E4 D46A4824 */  addiu      $t0, $v0, %lo(D_80056AD4)
    /* D20E8 800E18E8 0000038D */  lw         $v1, 0x0($t0)
    /* D20EC 800E18EC 0400068D */  lw         $a2, 0x4($t0)
    /* D20F0 800E18F0 0800078D */  lw         $a3, 0x8($t0)
    /* D20F4 800E18F4 1000A3AF */  sw         $v1, 0x10($sp)
    /* D20F8 800E18F8 1400A6AF */  sw         $a2, 0x14($sp)
    /* D20FC 800E18FC 1800A7AF */  sw         $a3, 0x18($sp)
    /* D2100 800E1900 0C00038D */  lw         $v1, 0xC($t0)
    /* D2104 800E1904 00000000 */  nop
    /* D2108 800E1908 1C00A3AF */  sw         $v1, 0x1C($sp)
    /* D210C 800E190C 2110A503 */  addu       $v0, $sp, $a1
    /* D2110 800E1910 1000448C */  lw         $a0, 0x10($v0)
    /* D2114 800E1914 F485030C */  jal        TrackSpec_Read__Fi
    /* D2118 800E1918 00000000 */   nop
    /* D211C 800E191C 2000BF8F */  lw         $ra, 0x20($sp)
    /* D2120 800E1920 00000000 */  nop
    /* D2124 800E1924 0800E003 */  jr         $ra
    /* D2128 800E1928 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel TrackSpec_Load__Fii
