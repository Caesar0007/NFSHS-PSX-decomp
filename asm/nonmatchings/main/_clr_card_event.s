.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _clr_card_event, 0x108

glabel _clr_card_event
    /* FA0D0 801098D0 1580043C */  lui        $a0, %hi(D_801489EC)
    /* FA0D4 801098D4 EC89848C */  lw         $a0, %lo(D_801489EC)($a0)
    /* FA0D8 801098D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA0DC 801098DC 1000BFAF */  sw         $ra, 0x10($sp)
    /* FA0E0 801098E0 1D32040C */  jal        TestEvent
    /* FA0E4 801098E4 00000000 */   nop
    /* FA0E8 801098E8 1580043C */  lui        $a0, %hi(D_801489F0)
    /* FA0EC 801098EC F089848C */  lw         $a0, %lo(D_801489F0)($a0)
    /* FA0F0 801098F0 1D32040C */  jal        TestEvent
    /* FA0F4 801098F4 00000000 */   nop
    /* FA0F8 801098F8 1580043C */  lui        $a0, %hi(D_801489F4)
    /* FA0FC 801098FC F489848C */  lw         $a0, %lo(D_801489F4)($a0)
    /* FA100 80109900 1D32040C */  jal        TestEvent
    /* FA104 80109904 00000000 */   nop
    /* FA108 80109908 1580043C */  lui        $a0, %hi(D_801489F8)
    /* FA10C 8010990C F889848C */  lw         $a0, %lo(D_801489F8)($a0)
    /* FA110 80109910 1D32040C */  jal        TestEvent
    /* FA114 80109914 00000000 */   nop
    /* FA118 80109918 1580043C */  lui        $a0, %hi(D_801489FC)
    /* FA11C 8010991C FC89848C */  lw         $a0, %lo(D_801489FC)($a0)
    /* FA120 80109920 1D32040C */  jal        TestEvent
    /* FA124 80109924 00000000 */   nop
    /* FA128 80109928 1580043C */  lui        $a0, %hi(D_80148A00)
    /* FA12C 8010992C 008A848C */  lw         $a0, %lo(D_80148A00)($a0)
    /* FA130 80109930 1D32040C */  jal        TestEvent
    /* FA134 80109934 00000000 */   nop
    /* FA138 80109938 1580043C */  lui        $a0, %hi(D_80148A04)
    /* FA13C 8010993C 048A848C */  lw         $a0, %lo(D_80148A04)($a0)
    /* FA140 80109940 1D32040C */  jal        TestEvent
    /* FA144 80109944 00000000 */   nop
    /* FA148 80109948 1580043C */  lui        $a0, %hi(D_80148A08)
    /* FA14C 8010994C 088A848C */  lw         $a0, %lo(D_80148A08)($a0)
    /* FA150 80109950 1D32040C */  jal        TestEvent
    /* FA154 80109954 00000000 */   nop
    /* FA158 80109958 1580013C */  lui        $at, %hi(D_80148A18)
    /* FA15C 8010995C 188A20AC */  sw         $zero, %lo(D_80148A18)($at)
    /* FA160 80109960 1580023C */  lui        $v0, %hi(D_80148A18)
    /* FA164 80109964 188A428C */  lw         $v0, %lo(D_80148A18)($v0)
    /* FA168 80109968 1580013C */  lui        $at, %hi(D_80148A14)
    /* FA16C 8010996C 148A22AC */  sw         $v0, %lo(D_80148A14)($at)
    /* FA170 80109970 1580023C */  lui        $v0, %hi(D_80148A14)
    /* FA174 80109974 148A428C */  lw         $v0, %lo(D_80148A14)($v0)
    /* FA178 80109978 1580013C */  lui        $at, %hi(D_80148A10)
    /* FA17C 8010997C 108A22AC */  sw         $v0, %lo(D_80148A10)($at)
    /* FA180 80109980 1580023C */  lui        $v0, %hi(D_80148A10)
    /* FA184 80109984 108A428C */  lw         $v0, %lo(D_80148A10)($v0)
    /* FA188 80109988 1580013C */  lui        $at, %hi(D_80148A0C)
    /* FA18C 8010998C 0C8A22AC */  sw         $v0, %lo(D_80148A0C)($at)
    /* FA190 80109990 1580013C */  lui        $at, %hi(D_80148A28)
    /* FA194 80109994 288A20AC */  sw         $zero, %lo(D_80148A28)($at)
    /* FA198 80109998 1580023C */  lui        $v0, %hi(D_80148A28)
    /* FA19C 8010999C 288A428C */  lw         $v0, %lo(D_80148A28)($v0)
    /* FA1A0 801099A0 1580013C */  lui        $at, %hi(D_80148A24)
    /* FA1A4 801099A4 248A22AC */  sw         $v0, %lo(D_80148A24)($at)
    /* FA1A8 801099A8 1580023C */  lui        $v0, %hi(D_80148A24)
    /* FA1AC 801099AC 248A428C */  lw         $v0, %lo(D_80148A24)($v0)
    /* FA1B0 801099B0 1580013C */  lui        $at, %hi(D_80148A20)
    /* FA1B4 801099B4 208A22AC */  sw         $v0, %lo(D_80148A20)($at)
    /* FA1B8 801099B8 1580023C */  lui        $v0, %hi(D_80148A20)
    /* FA1BC 801099BC 208A428C */  lw         $v0, %lo(D_80148A20)($v0)
    /* FA1C0 801099C0 1580013C */  lui        $at, %hi(D_80148A1C)
    /* FA1C4 801099C4 1C8A22AC */  sw         $v0, %lo(D_80148A1C)($at)
    /* FA1C8 801099C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* FA1CC 801099CC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* FA1D0 801099D0 0800E003 */  jr         $ra
    /* FA1D4 801099D4 00000000 */   nop
endlabel _clr_card_event
