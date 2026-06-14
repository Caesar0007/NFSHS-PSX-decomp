.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching xformy, 0x64

glabel xformy
    /* D62C4 800E5AC4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D62C8 800E5AC8 1800B0AF */  sw         $s0, 0x18($sp)
    /* D62CC 800E5ACC 21808000 */  addu       $s0, $a0, $zero
    /* D62D0 800E5AD0 2120A000 */  addu       $a0, $a1, $zero
    /* D62D4 800E5AD4 1000A527 */  addiu      $a1, $sp, 0x10
    /* D62D8 800E5AD8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D62DC 800E5ADC 6FAB030C */  jal        intsincos
    /* D62E0 800E5AE0 1400A627 */   addiu     $a2, $sp, 0x14
    /* D62E4 800E5AE4 040000AE */  sw         $zero, 0x4($s0)
    /* D62E8 800E5AE8 0C0000AE */  sw         $zero, 0xC($s0)
    /* D62EC 800E5AEC 1400A48F */  lw         $a0, 0x14($sp)
    /* D62F0 800E5AF0 1000A38F */  lw         $v1, 0x10($sp)
    /* D62F4 800E5AF4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* D62F8 800E5AF8 100002AE */  sw         $v0, 0x10($s0)
    /* D62FC 800E5AFC 140000AE */  sw         $zero, 0x14($s0)
    /* D6300 800E5B00 1C0000AE */  sw         $zero, 0x1C($s0)
    /* D6304 800E5B04 23100300 */  negu       $v0, $v1
    /* D6308 800E5B08 000004AE */  sw         $a0, 0x0($s0)
    /* D630C 800E5B0C 080002AE */  sw         $v0, 0x8($s0)
    /* D6310 800E5B10 180003AE */  sw         $v1, 0x18($s0)
    /* D6314 800E5B14 200004AE */  sw         $a0, 0x20($s0)
    /* D6318 800E5B18 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D631C 800E5B1C 1800B08F */  lw         $s0, 0x18($sp)
    /* D6320 800E5B20 0800E003 */  jr         $ra
    /* D6324 800E5B24 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel xformy
