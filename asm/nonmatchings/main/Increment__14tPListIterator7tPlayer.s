.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__14tPListIterator7tPlayer, 0x6C

glabel Increment__14tPListIterator7tPlayer
    /* 978A4 800A70A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 978A8 800A70A8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 978AC 800A70AC 0400838C */  lw         $v1, 0x4($a0)
    /* 978B0 800A70B0 00000000 */  nop
    /* 978B4 800A70B4 0000628C */  lw         $v0, 0x0($v1)
    /* 978B8 800A70B8 00000000 */  nop
    /* 978BC 800A70BC 01004224 */  addiu      $v0, $v0, 0x1
    /* 978C0 800A70C0 000062AC */  sw         $v0, 0x0($v1)
    /* 978C4 800A70C4 0400858C */  lw         $a1, 0x4($a0)
    /* 978C8 800A70C8 00000000 */  nop
    /* 978CC 800A70CC 0000A28C */  lw         $v0, 0x0($a1)
    /* 978D0 800A70D0 0000838C */  lw         $v1, 0x0($a0)
    /* 978D4 800A70D4 40100200 */  sll        $v0, $v0, 1
    /* 978D8 800A70D8 21104300 */  addu       $v0, $v0, $v1
    /* 978DC 800A70DC 00004284 */  lh         $v0, 0x0($v0)
    /* 978E0 800A70E0 00000000 */  nop
    /* 978E4 800A70E4 02004014 */  bnez       $v0, .L800A70F0
    /* 978E8 800A70E8 00000000 */   nop
    /* 978EC 800A70EC 0000A0AC */  sw         $zero, 0x0($a1)
  .L800A70F0:
    /* 978F0 800A70F0 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 978F4 800A70F4 05000424 */   addiu     $a0, $zero, 0x5
    /* 978F8 800A70F8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 978FC 800A70FC 01000224 */  addiu      $v0, $zero, 0x1
    /* 97900 800A7100 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* 97904 800A7104 40D222AC */  sw         $v0, %lo(gMPauseUpdateNextTime)($at)
    /* 97908 800A7108 0800E003 */  jr         $ra
    /* 9790C 800A710C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Increment__14tPListIterator7tPlayer
