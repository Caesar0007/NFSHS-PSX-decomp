.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToBestOfOne__FR12tMenuCommand, 0x5C

glabel MenuExtended_GoToBestOfOne__FR12tMenuCommand
    /* 1D384 8002CB84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1D388 8002CB88 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1D38C 8002CB8C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1D390 8002CB90 AFB2000C */  jal        PinkSlipsPreSave__Fv
    /* 1D394 8002CB94 21808000 */   addu      $s0, $a0, $zero
    /* 1D398 8002CB98 07004010 */  beqz       $v0, .L8002CBB8
    /* 1D39C 8002CB9C 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1D3A0 8002CBA0 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1D3A4 8002CBA4 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D3A8 8002CBA8 000003AE */  sw         $v1, 0x0($s0)
    /* 1D3AC 8002CBAC 200D4224 */  addiu      $v0, $v0, 0xD20
    /* 1D3B0 8002CBB0 EFB20008 */  j          .L8002CBBC
    /* 1D3B4 8002CBB4 040002AE */   sw        $v0, 0x4($s0)
  .L8002CBB8:
    /* 1D3B8 8002CBB8 000000AE */  sw         $zero, 0x0($s0)
  .L8002CBBC:
    /* 1D3BC 8002CBBC 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1D3C0 8002CBC0 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1D3C4 8002CBC4 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D3C8 8002CBC8 460040A0 */  sb         $zero, 0x46($v0)
    /* 1D3CC 8002CBCC 470043A0 */  sb         $v1, 0x47($v0)
    /* 1D3D0 8002CBD0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1D3D4 8002CBD4 1000B08F */  lw         $s0, 0x10($sp)
    /* 1D3D8 8002CBD8 0800E003 */  jr         $ra
    /* 1D3DC 8002CBDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_GoToBestOfOne__FR12tMenuCommand
