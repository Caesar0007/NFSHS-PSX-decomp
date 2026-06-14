.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_start, 0x1DC

glabel _card_start
    /* F9E20 80109620 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9E24 80109624 1400BFAF */  sw         $ra, 0x14($sp)
    /* F9E28 80109628 631A040C */  jal        EnterCriticalSection
    /* F9E2C 8010962C 1000B0AF */   sw        $s0, 0x10($sp)
    /* F9E30 80109630 00F4043C */  lui        $a0, (0xF4000001 >> 16)
    /* F9E34 80109634 01008434 */  ori        $a0, $a0, (0xF4000001 & 0xFFFF)
    /* F9E38 80109638 04000524 */  addiu      $a1, $zero, 0x4
    /* F9E3C 8010963C 00100624 */  addiu      $a2, $zero, 0x1000
    /* F9E40 80109640 1180073C */  lui        $a3, %hi(funcEvSpIOE)
    /* F9E44 80109644 5095E724 */  addiu      $a3, $a3, %lo(funcEvSpIOE)
    /* F9E48 80109648 881B040C */  jal        OpenEvent
    /* F9E4C 8010964C 21804000 */   addu      $s0, $v0, $zero
    /* F9E50 80109650 00F4043C */  lui        $a0, (0xF4000001 >> 16)
    /* F9E54 80109654 01008434 */  ori        $a0, $a0, (0xF4000001 & 0xFFFF)
    /* F9E58 80109658 00800534 */  ori        $a1, $zero, 0x8000
    /* F9E5C 8010965C 1180073C */  lui        $a3, %hi(funcEvSpError)
    /* F9E60 80109660 6495E724 */  addiu      $a3, $a3, %lo(funcEvSpError)
    /* F9E64 80109664 1580013C */  lui        $at, %hi(D_801489EC)
    /* F9E68 80109668 EC8922AC */  sw         $v0, %lo(D_801489EC)($at)
    /* F9E6C 8010966C 881B040C */  jal        OpenEvent
    /* F9E70 80109670 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9E74 80109674 00F4043C */  lui        $a0, (0xF4000001 >> 16)
    /* F9E78 80109678 01008434 */  ori        $a0, $a0, (0xF4000001 & 0xFFFF)
    /* F9E7C 8010967C 00010524 */  addiu      $a1, $zero, 0x100
    /* F9E80 80109680 1180073C */  lui        $a3, %hi(funcEvSpTimeout)
    /* F9E84 80109684 7895E724 */  addiu      $a3, $a3, %lo(funcEvSpTimeout)
    /* F9E88 80109688 1580013C */  lui        $at, %hi(D_801489F0)
    /* F9E8C 8010968C F08922AC */  sw         $v0, %lo(D_801489F0)($at)
    /* F9E90 80109690 881B040C */  jal        OpenEvent
    /* F9E94 80109694 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9E98 80109698 00F4043C */  lui        $a0, (0xF4000001 >> 16)
    /* F9E9C 8010969C 01008434 */  ori        $a0, $a0, (0xF4000001 & 0xFFFF)
    /* F9EA0 801096A0 00200524 */  addiu      $a1, $zero, 0x2000
    /* F9EA4 801096A4 1180073C */  lui        $a3, %hi(funcEvSpNewcard)
    /* F9EA8 801096A8 8C95E724 */  addiu      $a3, $a3, %lo(funcEvSpNewcard)
    /* F9EAC 801096AC 1580013C */  lui        $at, %hi(D_801489F4)
    /* F9EB0 801096B0 F48922AC */  sw         $v0, %lo(D_801489F4)($at)
    /* F9EB4 801096B4 881B040C */  jal        OpenEvent
    /* F9EB8 801096B8 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9EBC 801096BC 00F0043C */  lui        $a0, (0xF0000011 >> 16)
    /* F9EC0 801096C0 11008434 */  ori        $a0, $a0, (0xF0000011 & 0xFFFF)
    /* F9EC4 801096C4 04000524 */  addiu      $a1, $zero, 0x4
    /* F9EC8 801096C8 1180073C */  lui        $a3, %hi(funcEvSpIOEx)
    /* F9ECC 801096CC A095E724 */  addiu      $a3, $a3, %lo(funcEvSpIOEx)
    /* F9ED0 801096D0 1580013C */  lui        $at, %hi(D_801489F8)
    /* F9ED4 801096D4 F88922AC */  sw         $v0, %lo(D_801489F8)($at)
    /* F9ED8 801096D8 881B040C */  jal        OpenEvent
    /* F9EDC 801096DC 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9EE0 801096E0 00F0043C */  lui        $a0, (0xF0000011 >> 16)
    /* F9EE4 801096E4 11008434 */  ori        $a0, $a0, (0xF0000011 & 0xFFFF)
    /* F9EE8 801096E8 00800534 */  ori        $a1, $zero, 0x8000
    /* F9EEC 801096EC 1180073C */  lui        $a3, %hi(funcEvSpErrorx)
    /* F9EF0 801096F0 B495E724 */  addiu      $a3, $a3, %lo(funcEvSpErrorx)
    /* F9EF4 801096F4 1580013C */  lui        $at, %hi(D_801489FC)
    /* F9EF8 801096F8 FC8922AC */  sw         $v0, %lo(D_801489FC)($at)
    /* F9EFC 801096FC 881B040C */  jal        OpenEvent
    /* F9F00 80109700 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9F04 80109704 00F0043C */  lui        $a0, (0xF0000011 >> 16)
    /* F9F08 80109708 11008434 */  ori        $a0, $a0, (0xF0000011 & 0xFFFF)
    /* F9F0C 8010970C 00010524 */  addiu      $a1, $zero, 0x100
    /* F9F10 80109710 1180073C */  lui        $a3, %hi(funcEvSpTimeoutx)
    /* F9F14 80109714 C895E724 */  addiu      $a3, $a3, %lo(funcEvSpTimeoutx)
    /* F9F18 80109718 1580013C */  lui        $at, %hi(D_80148A00)
    /* F9F1C 8010971C 008A22AC */  sw         $v0, %lo(D_80148A00)($at)
    /* F9F20 80109720 881B040C */  jal        OpenEvent
    /* F9F24 80109724 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9F28 80109728 00F0043C */  lui        $a0, (0xF0000011 >> 16)
    /* F9F2C 8010972C 11008434 */  ori        $a0, $a0, (0xF0000011 & 0xFFFF)
    /* F9F30 80109730 00200524 */  addiu      $a1, $zero, 0x2000
    /* F9F34 80109734 1180073C */  lui        $a3, %hi(funcEvSpNewcardx)
    /* F9F38 80109738 DC95E724 */  addiu      $a3, $a3, %lo(funcEvSpNewcardx)
    /* F9F3C 8010973C 1580013C */  lui        $at, %hi(D_80148A04)
    /* F9F40 80109740 048A22AC */  sw         $v0, %lo(D_80148A04)($at)
    /* F9F44 80109744 881B040C */  jal        OpenEvent
    /* F9F48 80109748 00100624 */   addiu     $a2, $zero, 0x1000
    /* F9F4C 8010974C 1580043C */  lui        $a0, %hi(D_801489EC)
    /* F9F50 80109750 EC89848C */  lw         $a0, %lo(D_801489EC)($a0)
    /* F9F54 80109754 1580013C */  lui        $at, %hi(D_80148A08)
    /* F9F58 80109758 841B040C */  jal        EnableEvent
    /* F9F5C 8010975C 088A22AC */   sw        $v0, %lo(D_80148A08)($at)
    /* F9F60 80109760 1580043C */  lui        $a0, %hi(D_801489F0)
    /* F9F64 80109764 F089848C */  lw         $a0, %lo(D_801489F0)($a0)
    /* F9F68 80109768 841B040C */  jal        EnableEvent
    /* F9F6C 8010976C 00000000 */   nop
    /* F9F70 80109770 1580043C */  lui        $a0, %hi(D_801489F4)
    /* F9F74 80109774 F489848C */  lw         $a0, %lo(D_801489F4)($a0)
    /* F9F78 80109778 841B040C */  jal        EnableEvent
    /* F9F7C 8010977C 00000000 */   nop
    /* F9F80 80109780 1580043C */  lui        $a0, %hi(D_801489F8)
    /* F9F84 80109784 F889848C */  lw         $a0, %lo(D_801489F8)($a0)
    /* F9F88 80109788 841B040C */  jal        EnableEvent
    /* F9F8C 8010978C 00000000 */   nop
    /* F9F90 80109790 1580043C */  lui        $a0, %hi(D_801489FC)
    /* F9F94 80109794 FC89848C */  lw         $a0, %lo(D_801489FC)($a0)
    /* F9F98 80109798 841B040C */  jal        EnableEvent
    /* F9F9C 8010979C 00000000 */   nop
    /* F9FA0 801097A0 1580043C */  lui        $a0, %hi(D_80148A00)
    /* F9FA4 801097A4 008A848C */  lw         $a0, %lo(D_80148A00)($a0)
    /* F9FA8 801097A8 841B040C */  jal        EnableEvent
    /* F9FAC 801097AC 00000000 */   nop
    /* F9FB0 801097B0 1580043C */  lui        $a0, %hi(D_80148A04)
    /* F9FB4 801097B4 048A848C */  lw         $a0, %lo(D_80148A04)($a0)
    /* F9FB8 801097B8 841B040C */  jal        EnableEvent
    /* F9FBC 801097BC 00000000 */   nop
    /* F9FC0 801097C0 1580043C */  lui        $a0, %hi(D_80148A08)
    /* F9FC4 801097C4 088A848C */  lw         $a0, %lo(D_80148A08)($a0)
    /* F9FC8 801097C8 841B040C */  jal        EnableEvent
    /* F9FCC 801097CC 00000000 */   nop
    /* F9FD0 801097D0 3426040C */  jal        _clr_card_event
    /* F9FD4 801097D4 00000000 */   nop
    /* F9FD8 801097D8 01000224 */  addiu      $v0, $zero, 0x1
    /* F9FDC 801097DC 03000216 */  bne        $s0, $v0, .L801097EC
    /* F9FE0 801097E0 00000000 */   nop
    /* F9FE4 801097E4 5B1A040C */  jal        ExitCriticalSection
    /* F9FE8 801097E8 00000000 */   nop
  .L801097EC:
    /* F9FEC 801097EC 1400BF8F */  lw         $ra, 0x14($sp)
    /* F9FF0 801097F0 1000B08F */  lw         $s0, 0x10($sp)
    /* F9FF4 801097F4 0800E003 */  jr         $ra
    /* F9FF8 801097F8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _card_start
