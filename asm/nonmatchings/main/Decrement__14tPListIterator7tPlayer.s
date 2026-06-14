.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__14tPListIterator7tPlayer, 0xA0

glabel Decrement__14tPListIterator7tPlayer
    /* 97910 800A7110 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97914 800A7114 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97918 800A7118 0400838C */  lw         $v1, 0x4($a0)
    /* 9791C 800A711C 00000000 */  nop
    /* 97920 800A7120 0000628C */  lw         $v0, 0x0($v1)
    /* 97924 800A7124 00000000 */  nop
    /* 97928 800A7128 17004014 */  bnez       $v0, .L800A7188
    /* 9792C 800A712C 21286000 */   addu      $a1, $v1, $zero
    /* 97930 800A7130 0000828C */  lw         $v0, 0x0($a0)
    /* 97934 800A7134 00000000 */  nop
    /* 97938 800A7138 02004284 */  lh         $v0, 0x2($v0)
    /* 9793C 800A713C 00000000 */  nop
    /* 97940 800A7140 13004018 */  blez       $v0, .L800A7190
    /* 97944 800A7144 00000000 */   nop
  .L800A7148:
    /* 97948 800A7148 0000A28C */  lw         $v0, 0x0($a1)
    /* 9794C 800A714C 00000000 */  nop
    /* 97950 800A7150 01004224 */  addiu      $v0, $v0, 0x1
    /* 97954 800A7154 0000A2AC */  sw         $v0, 0x0($a1)
    /* 97958 800A7158 0400858C */  lw         $a1, 0x4($a0)
    /* 9795C 800A715C 00000000 */  nop
    /* 97960 800A7160 0000A28C */  lw         $v0, 0x0($a1)
    /* 97964 800A7164 0000838C */  lw         $v1, 0x0($a0)
    /* 97968 800A7168 40100200 */  sll        $v0, $v0, 1
    /* 9796C 800A716C 21104300 */  addu       $v0, $v0, $v1
    /* 97970 800A7170 02004284 */  lh         $v0, 0x2($v0)
    /* 97974 800A7174 00000000 */  nop
    /* 97978 800A7178 05004018 */  blez       $v0, .L800A7190
    /* 9797C 800A717C 00000000 */   nop
    /* 97980 800A7180 529C0208 */  j          .L800A7148
    /* 97984 800A7184 00000000 */   nop
  .L800A7188:
    /* 97988 800A7188 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 9798C 800A718C 000062AC */  sw         $v0, 0x0($v1)
  .L800A7190:
    /* 97990 800A7190 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 97994 800A7194 05000424 */   addiu     $a0, $zero, 0x5
    /* 97998 800A7198 1000BF8F */  lw         $ra, 0x10($sp)
    /* 9799C 800A719C 01000224 */  addiu      $v0, $zero, 0x1
    /* 979A0 800A71A0 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* 979A4 800A71A4 40D222AC */  sw         $v0, %lo(gMPauseUpdateNextTime)($at)
    /* 979A8 800A71A8 0800E003 */  jr         $ra
    /* 979AC 800A71AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Decrement__14tPListIterator7tPlayer
