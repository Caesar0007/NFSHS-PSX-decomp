.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme, 0x90

glabel __18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* F120 8001E920 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F124 8001E924 2000B0AF */  sw         $s0, 0x20($sp)
    /* F128 8001E928 21808000 */  addu       $s0, $a0, $zero
    /* F12C 8001E92C 3800A88F */  lw         $t0, 0x38($sp)
    /* F130 8001E930 3C00A98F */  lw         $t1, 0x3C($sp)
    /* F134 8001E934 4000A28F */  lw         $v0, 0x40($sp)
    /* F138 8001E938 4400A38F */  lw         $v1, 0x44($sp)
    /* F13C 8001E93C 2400BFAF */  sw         $ra, 0x24($sp)
    /* F140 8001E940 00140200 */  sll        $v0, $v0, 16
    /* F144 8001E944 03140200 */  sra        $v0, $v0, 16
    /* F148 8001E948 1000A8AF */  sw         $t0, 0x10($sp)
    /* F14C 8001E94C 1400A9AF */  sw         $t1, 0x14($sp)
    /* F150 8001E950 1B95000C */  jal        __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* F154 8001E954 1800A2AF */   sw        $v0, 0x18($sp)
    /* F158 8001E958 21200000 */  addu       $a0, $zero, $zero
    /* F15C 8001E95C 21180002 */  addu       $v1, $s0, $zero
    /* F160 8001E960 0180023C */  lui        $v0, %hi(_vt_18tInsideBoxSongMenu)
    /* F164 8001E964 780C4224 */  addiu      $v0, $v0, %lo(_vt_18tInsideBoxSongMenu)
    /* F168 8001E968 680002AE */  sw         $v0, 0x68($s0)
  .L8001E96C:
    /* F16C 8001E96C 7E0060A4 */  sh         $zero, 0x7E($v1)
    /* F170 8001E970 740060A4 */  sh         $zero, 0x74($v1)
    /* F174 8001E974 01008424 */  addiu      $a0, $a0, 0x1
    /* F178 8001E978 05008228 */  slti       $v0, $a0, 0x5
    /* F17C 8001E97C FBFF4014 */  bnez       $v0, .L8001E96C
    /* F180 8001E980 02006324 */   addiu     $v1, $v1, 0x2
    /* F184 8001E984 21200002 */  addu       $a0, $s0, $zero
    /* F188 8001E988 4400A58F */  lw         $a1, 0x44($sp)
    /* F18C 8001E98C 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* F190 8001E990 4800A627 */   addiu     $a2, $sp, 0x48
    /* F194 8001E994 21100002 */  addu       $v0, $s0, $zero
    /* F198 8001E998 6E0040A4 */  sh         $zero, 0x6E($v0)
    /* F19C 8001E99C 700040A4 */  sh         $zero, 0x70($v0)
    /* F1A0 8001E9A0 2400BF8F */  lw         $ra, 0x24($sp)
    /* F1A4 8001E9A4 2000B08F */  lw         $s0, 0x20($sp)
    /* F1A8 8001E9A8 0800E003 */  jr         $ra
    /* F1AC 8001E9AC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
