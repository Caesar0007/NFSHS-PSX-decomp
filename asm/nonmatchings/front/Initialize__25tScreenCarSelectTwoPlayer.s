.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__25tScreenCarSelectTwoPlayer, 0x50

glabel Initialize__25tScreenCarSelectTwoPlayer
    /* 2F5C0 8003EDC0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2F5C4 8003EDC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F5C8 8003EDC8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2F5CC 8003EDCC 62EF000C */  jal        Initialize__16tScreenCarSelect
    /* 2F5D0 8003EDD0 21808000 */   addu      $s0, $a0, $zero
    /* 2F5D4 8003EDD4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2F5D8 8003EDD8 1C0100A6 */  sh         $zero, 0x11C($s0)
    /* 2F5DC 8003EDDC 1E0102A6 */  sh         $v0, 0x11E($s0)
    /* 2F5E0 8003EDE0 200102A6 */  sh         $v0, 0x120($s0)
    /* 2F5E4 8003EDE4 220102A6 */  sh         $v0, 0x122($s0)
    /* 2F5E8 8003EDE8 7A0300A6 */  sh         $zero, 0x37A($s0)
    /* 2F5EC 8003EDEC 780300A6 */  sh         $zero, 0x378($s0)
    /* 2F5F0 8003EDF0 760300A6 */  sh         $zero, 0x376($s0)
    /* 2F5F4 8003EDF4 740300A6 */  sh         $zero, 0x374($s0)
    /* 2F5F8 8003EDF8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2F5FC 8003EDFC 1000B08F */  lw         $s0, 0x10($sp)
    /* 2F600 8003EE00 0580023C */  lui        $v0, %hi(gShowroomLights)
    /* 2F604 8003EE04 B41440AC */  sw         $zero, %lo(gShowroomLights)($v0)
    /* 2F608 8003EE08 0800E003 */  jr         $ra
    /* 2F60C 8003EE0C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__25tScreenCarSelectTwoPlayer
