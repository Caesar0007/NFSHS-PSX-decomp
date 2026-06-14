.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _get_card_event, 0xD8

glabel _get_card_event
    /* FA1D8 801099D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA1DC 801099DC 1400BFAF */  sw         $ra, 0x14($sp)
    /* FA1E0 801099E0 1000B0AF */  sw         $s0, 0x10($sp)
  .L801099E4:
    /* FA1E4 801099E4 1580023C */  lui        $v0, %hi(D_80148A10)
    /* FA1E8 801099E8 108A428C */  lw         $v0, %lo(D_80148A10)($v0)
    /* FA1EC 801099EC 1580043C */  lui        $a0, %hi(D_80148A0C)
    /* FA1F0 801099F0 0C8A848C */  lw         $a0, %lo(D_80148A0C)($a0)
    /* FA1F4 801099F4 1580033C */  lui        $v1, %hi(D_80148A14)
    /* FA1F8 801099F8 148A638C */  lw         $v1, %lo(D_80148A14)($v1)
    /* FA1FC 801099FC 40100200 */  sll        $v0, $v0, 1
    /* FA200 80109A00 21208200 */  addu       $a0, $a0, $v0
    /* FA204 80109A04 80180300 */  sll        $v1, $v1, 2
    /* FA208 80109A08 1580023C */  lui        $v0, %hi(D_80148A18)
    /* FA20C 80109A0C 188A428C */  lw         $v0, %lo(D_80148A18)($v0)
    /* FA210 80109A10 21208300 */  addu       $a0, $a0, $v1
    /* FA214 80109A14 C0100200 */  sll        $v0, $v0, 3
    /* FA218 80109A18 21808200 */  addu       $s0, $a0, $v0
    /* FA21C 80109A1C F1FF0012 */  beqz       $s0, .L801099E4
    /* FA220 80109A20 00000000 */   nop
    /* FA224 80109A24 1580043C */  lui        $a0, %hi(D_801489FC)
    /* FA228 80109A28 FC89848C */  lw         $a0, %lo(D_801489FC)($a0)
    /* FA22C 80109A2C 1D32040C */  jal        TestEvent
    /* FA230 80109A30 00000000 */   nop
    /* FA234 80109A34 1580043C */  lui        $a0, %hi(D_80148A00)
    /* FA238 80109A38 008A848C */  lw         $a0, %lo(D_80148A00)($a0)
    /* FA23C 80109A3C 1D32040C */  jal        TestEvent
    /* FA240 80109A40 00000000 */   nop
    /* FA244 80109A44 1580043C */  lui        $a0, %hi(D_80148A04)
    /* FA248 80109A48 048A848C */  lw         $a0, %lo(D_80148A04)($a0)
    /* FA24C 80109A4C 1D32040C */  jal        TestEvent
    /* FA250 80109A50 00000000 */   nop
    /* FA254 80109A54 1580043C */  lui        $a0, %hi(D_80148A08)
    /* FA258 80109A58 088A848C */  lw         $a0, %lo(D_80148A08)($a0)
    /* FA25C 80109A5C 1D32040C */  jal        TestEvent
    /* FA260 80109A60 00000000 */   nop
    /* FA264 80109A64 1580013C */  lui        $at, %hi(D_80148A18)
    /* FA268 80109A68 188A20AC */  sw         $zero, %lo(D_80148A18)($at)
    /* FA26C 80109A6C 1580023C */  lui        $v0, %hi(D_80148A18)
    /* FA270 80109A70 188A428C */  lw         $v0, %lo(D_80148A18)($v0)
    /* FA274 80109A74 1580013C */  lui        $at, %hi(D_80148A14)
    /* FA278 80109A78 148A22AC */  sw         $v0, %lo(D_80148A14)($at)
    /* FA27C 80109A7C 1580023C */  lui        $v0, %hi(D_80148A14)
    /* FA280 80109A80 148A428C */  lw         $v0, %lo(D_80148A14)($v0)
    /* FA284 80109A84 1580013C */  lui        $at, %hi(D_80148A10)
    /* FA288 80109A88 108A22AC */  sw         $v0, %lo(D_80148A10)($at)
    /* FA28C 80109A8C 1580033C */  lui        $v1, %hi(D_80148A10)
    /* FA290 80109A90 108A638C */  lw         $v1, %lo(D_80148A10)($v1)
    /* FA294 80109A94 43101000 */  sra        $v0, $s0, 1
    /* FA298 80109A98 1580013C */  lui        $at, %hi(D_80148A0C)
    /* FA29C 80109A9C 0C8A23AC */  sw         $v1, %lo(D_80148A0C)($at)
    /* FA2A0 80109AA0 1400BF8F */  lw         $ra, 0x14($sp)
    /* FA2A4 80109AA4 1000B08F */  lw         $s0, 0x10($sp)
    /* FA2A8 80109AA8 0800E003 */  jr         $ra
    /* FA2AC 80109AAC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _get_card_event
