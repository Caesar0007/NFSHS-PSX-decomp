.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_stop, 0xB4

glabel _card_stop
    /* FA01C 8010981C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA020 80109820 1400BFAF */  sw         $ra, 0x14($sp)
    /* FA024 80109824 631A040C */  jal        EnterCriticalSection
    /* FA028 80109828 1000B0AF */   sw        $s0, 0x10($sp)
    /* FA02C 8010982C 1580043C */  lui        $a0, %hi(D_801489EC)
    /* FA030 80109830 EC89848C */  lw         $a0, %lo(D_801489EC)($a0)
    /* FA034 80109834 1932040C */  jal        CloseEvent
    /* FA038 80109838 21804000 */   addu      $s0, $v0, $zero
    /* FA03C 8010983C 1580043C */  lui        $a0, %hi(D_801489F0)
    /* FA040 80109840 F089848C */  lw         $a0, %lo(D_801489F0)($a0)
    /* FA044 80109844 1932040C */  jal        CloseEvent
    /* FA048 80109848 00000000 */   nop
    /* FA04C 8010984C 1580043C */  lui        $a0, %hi(D_801489F4)
    /* FA050 80109850 F489848C */  lw         $a0, %lo(D_801489F4)($a0)
    /* FA054 80109854 1932040C */  jal        CloseEvent
    /* FA058 80109858 00000000 */   nop
    /* FA05C 8010985C 1580043C */  lui        $a0, %hi(D_801489F8)
    /* FA060 80109860 F889848C */  lw         $a0, %lo(D_801489F8)($a0)
    /* FA064 80109864 1932040C */  jal        CloseEvent
    /* FA068 80109868 00000000 */   nop
    /* FA06C 8010986C 1580043C */  lui        $a0, %hi(D_801489FC)
    /* FA070 80109870 FC89848C */  lw         $a0, %lo(D_801489FC)($a0)
    /* FA074 80109874 1932040C */  jal        CloseEvent
    /* FA078 80109878 00000000 */   nop
    /* FA07C 8010987C 1580043C */  lui        $a0, %hi(D_80148A00)
    /* FA080 80109880 008A848C */  lw         $a0, %lo(D_80148A00)($a0)
    /* FA084 80109884 1932040C */  jal        CloseEvent
    /* FA088 80109888 00000000 */   nop
    /* FA08C 8010988C 1580043C */  lui        $a0, %hi(D_80148A04)
    /* FA090 80109890 048A848C */  lw         $a0, %lo(D_80148A04)($a0)
    /* FA094 80109894 1932040C */  jal        CloseEvent
    /* FA098 80109898 00000000 */   nop
    /* FA09C 8010989C 1580043C */  lui        $a0, %hi(D_80148A08)
    /* FA0A0 801098A0 088A848C */  lw         $a0, %lo(D_80148A08)($a0)
    /* FA0A4 801098A4 1932040C */  jal        CloseEvent
    /* FA0A8 801098A8 00000000 */   nop
    /* FA0AC 801098AC 01000224 */  addiu      $v0, $zero, 0x1
    /* FA0B0 801098B0 03000216 */  bne        $s0, $v0, .L801098C0
    /* FA0B4 801098B4 00000000 */   nop
    /* FA0B8 801098B8 5B1A040C */  jal        ExitCriticalSection
    /* FA0BC 801098BC 00000000 */   nop
  .L801098C0:
    /* FA0C0 801098C0 1400BF8F */  lw         $ra, 0x14($sp)
    /* FA0C4 801098C4 1000B08F */  lw         $s0, 0x10($sp)
    /* FA0C8 801098C8 0800E003 */  jr         $ra
    /* FA0CC 801098CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _card_stop
