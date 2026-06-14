.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_GoTpage__Fi, 0x90

glabel Hud_GoTpage__Fi
    /* C256C 800D1D6C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C2570 800D1D70 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* C2574 800D1D74 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* C2578 800D1D78 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C257C 800D1D7C FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C2580 800D1D80 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C2584 800D1D84 1800BFAF */  sw         $ra, 0x18($sp)
    /* C2588 800D1D88 0000268D */  lw         $a2, 0x0($t1)
    /* C258C 800D1D8C 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C2590 800D1D90 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C2594 800D1D94 0000C38C */  lw         $v1, 0x0($a2)
    /* C2598 800D1D98 0000E28C */  lw         $v0, 0x0($a3)
    /* C259C 800D1D9C 24186800 */  and        $v1, $v1, $t0
    /* C25A0 800D1DA0 24104500 */  and        $v0, $v0, $a1
    /* C25A4 800D1DA4 25186200 */  or         $v1, $v1, $v0
    /* C25A8 800D1DA8 0000C3AC */  sw         $v1, 0x0($a2)
    /* C25AC 800D1DAC 0C00C324 */  addiu      $v1, $a2, 0xC
    /* C25B0 800D1DB0 0000E28C */  lw         $v0, 0x0($a3)
    /* C25B4 800D1DB4 2428C500 */  and        $a1, $a2, $a1
    /* C25B8 800D1DB8 000023AD */  sw         $v1, 0x0($t1)
    /* C25BC 800D1DBC 24104800 */  and        $v0, $v0, $t0
    /* C25C0 800D1DC0 25104500 */  or         $v0, $v0, $a1
    /* C25C4 800D1DC4 0000E2AC */  sw         $v0, 0x0($a3)
    /* C25C8 800D1DC8 80390400 */  sll        $a3, $a0, 6
    /* C25CC 800D1DCC 8000E724 */  addiu      $a3, $a3, 0x80
    /* C25D0 800D1DD0 FF03E730 */  andi       $a3, $a3, 0x3FF
    /* C25D4 800D1DD4 2120C000 */  addu       $a0, $a2, $zero
    /* C25D8 800D1DD8 21280000 */  addu       $a1, $zero, $zero
    /* C25DC 800D1DDC 2130A000 */  addu       $a2, $a1, $zero
    /* C25E0 800D1DE0 82390700 */  srl        $a3, $a3, 6
    /* C25E4 800D1DE4 EFB8030C */  jal        SetDrawMode
    /* C25E8 800D1DE8 1000A0AF */   sw        $zero, 0x10($sp)
    /* C25EC 800D1DEC 1800BF8F */  lw         $ra, 0x18($sp)
    /* C25F0 800D1DF0 00000000 */  nop
    /* C25F4 800D1DF4 0800E003 */  jr         $ra
    /* C25F8 800D1DF8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_GoTpage__Fi
