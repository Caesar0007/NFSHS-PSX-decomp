.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _get_card_event_x, 0xD8

glabel _get_card_event_x
    /* FA2B0 80109AB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA2B4 80109AB4 1400BFAF */  sw         $ra, 0x14($sp)
    /* FA2B8 80109AB8 1000B0AF */  sw         $s0, 0x10($sp)
  .L80109ABC:
    /* FA2BC 80109ABC 1580023C */  lui        $v0, %hi(D_80148A20)
    /* FA2C0 80109AC0 208A428C */  lw         $v0, %lo(D_80148A20)($v0)
    /* FA2C4 80109AC4 1580043C */  lui        $a0, %hi(D_80148A1C)
    /* FA2C8 80109AC8 1C8A848C */  lw         $a0, %lo(D_80148A1C)($a0)
    /* FA2CC 80109ACC 1580033C */  lui        $v1, %hi(D_80148A24)
    /* FA2D0 80109AD0 248A638C */  lw         $v1, %lo(D_80148A24)($v1)
    /* FA2D4 80109AD4 40100200 */  sll        $v0, $v0, 1
    /* FA2D8 80109AD8 21208200 */  addu       $a0, $a0, $v0
    /* FA2DC 80109ADC 80180300 */  sll        $v1, $v1, 2
    /* FA2E0 80109AE0 1580023C */  lui        $v0, %hi(D_80148A28)
    /* FA2E4 80109AE4 288A428C */  lw         $v0, %lo(D_80148A28)($v0)
    /* FA2E8 80109AE8 21208300 */  addu       $a0, $a0, $v1
    /* FA2EC 80109AEC C0100200 */  sll        $v0, $v0, 3
    /* FA2F0 80109AF0 21808200 */  addu       $s0, $a0, $v0
    /* FA2F4 80109AF4 F1FF0012 */  beqz       $s0, .L80109ABC
    /* FA2F8 80109AF8 00000000 */   nop
    /* FA2FC 80109AFC 1580043C */  lui        $a0, %hi(D_801489EC)
    /* FA300 80109B00 EC89848C */  lw         $a0, %lo(D_801489EC)($a0)
    /* FA304 80109B04 1D32040C */  jal        TestEvent
    /* FA308 80109B08 00000000 */   nop
    /* FA30C 80109B0C 1580043C */  lui        $a0, %hi(D_801489F0)
    /* FA310 80109B10 F089848C */  lw         $a0, %lo(D_801489F0)($a0)
    /* FA314 80109B14 1D32040C */  jal        TestEvent
    /* FA318 80109B18 00000000 */   nop
    /* FA31C 80109B1C 1580043C */  lui        $a0, %hi(D_801489F4)
    /* FA320 80109B20 F489848C */  lw         $a0, %lo(D_801489F4)($a0)
    /* FA324 80109B24 1D32040C */  jal        TestEvent
    /* FA328 80109B28 00000000 */   nop
    /* FA32C 80109B2C 1580043C */  lui        $a0, %hi(D_801489F8)
    /* FA330 80109B30 F889848C */  lw         $a0, %lo(D_801489F8)($a0)
    /* FA334 80109B34 1D32040C */  jal        TestEvent
    /* FA338 80109B38 00000000 */   nop
    /* FA33C 80109B3C 1580013C */  lui        $at, %hi(D_80148A28)
    /* FA340 80109B40 288A20AC */  sw         $zero, %lo(D_80148A28)($at)
    /* FA344 80109B44 1580023C */  lui        $v0, %hi(D_80148A28)
    /* FA348 80109B48 288A428C */  lw         $v0, %lo(D_80148A28)($v0)
    /* FA34C 80109B4C 1580013C */  lui        $at, %hi(D_80148A24)
    /* FA350 80109B50 248A22AC */  sw         $v0, %lo(D_80148A24)($at)
    /* FA354 80109B54 1580023C */  lui        $v0, %hi(D_80148A24)
    /* FA358 80109B58 248A428C */  lw         $v0, %lo(D_80148A24)($v0)
    /* FA35C 80109B5C 1580013C */  lui        $at, %hi(D_80148A20)
    /* FA360 80109B60 208A22AC */  sw         $v0, %lo(D_80148A20)($at)
    /* FA364 80109B64 1580033C */  lui        $v1, %hi(D_80148A20)
    /* FA368 80109B68 208A638C */  lw         $v1, %lo(D_80148A20)($v1)
    /* FA36C 80109B6C 43101000 */  sra        $v0, $s0, 1
    /* FA370 80109B70 1580013C */  lui        $at, %hi(D_80148A1C)
    /* FA374 80109B74 1C8A23AC */  sw         $v1, %lo(D_80148A1C)($at)
    /* FA378 80109B78 1400BF8F */  lw         $ra, 0x14($sp)
    /* FA37C 80109B7C 1000B08F */  lw         $s0, 0x10($sp)
    /* FA380 80109B80 0800E003 */  jr         $ra
    /* FA384 80109B84 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _get_card_event_x
