.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__10tMenuBlank, 0x64

glabel Draw__10tMenuBlank
    /* C124 8001B924 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C128 8001B928 1000B0AF */  sw         $s0, 0x10($sp)
    /* C12C 8001B92C 21808000 */  addu       $s0, $a0, $zero
    /* C130 8001B930 1400BFAF */  sw         $ra, 0x14($sp)
    /* C134 8001B934 7000028E */  lw         $v0, 0x70($s0)
    /* C138 8001B938 00000000 */  nop
    /* C13C 8001B93C 0E004010 */  beqz       $v0, .L8001B978
    /* C140 8001B940 00000000 */   nop
    /* C144 8001B944 6800028E */  lw         $v0, 0x68($s0)
    /* C148 8001B948 00000000 */  nop
    /* C14C 8001B94C 38004484 */  lh         $a0, 0x38($v0)
    /* C150 8001B950 3C00428C */  lw         $v0, 0x3C($v0)
    /* C154 8001B954 00000000 */  nop
    /* C158 8001B958 09F84000 */  jalr       $v0
    /* C15C 8001B95C 21200402 */   addu      $a0, $s0, $a0
    /* C160 8001B960 76000292 */  lbu        $v0, 0x76($s0)
    /* C164 8001B964 74000396 */  lhu        $v1, 0x74($s0)
    /* C168 8001B968 00160200 */  sll        $v0, $v0, 24
    /* C16C 8001B96C 03160200 */  sra        $v0, $v0, 24
    /* C170 8001B970 21186200 */  addu       $v1, $v1, $v0
    /* C174 8001B974 740003A6 */  sh         $v1, 0x74($s0)
  .L8001B978:
    /* C178 8001B978 1400BF8F */  lw         $ra, 0x14($sp)
    /* C17C 8001B97C 1000B08F */  lw         $s0, 0x10($sp)
    /* C180 8001B980 0800E003 */  jr         $ra
    /* C184 8001B984 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw__10tMenuBlank
