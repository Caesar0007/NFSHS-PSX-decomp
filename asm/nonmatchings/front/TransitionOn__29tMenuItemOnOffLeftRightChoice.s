.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__29tMenuItemOnOffLeftRightChoice, 0x64

glabel TransitionOn__29tMenuItemOnOffLeftRightChoice
    /* EB20 8001E320 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB24 8001E324 1000B0AF */  sw         $s0, 0x10($sp)
    /* EB28 8001E328 21808000 */  addu       $s0, $a0, $zero
    /* EB2C 8001E32C 1400BFAF */  sw         $ra, 0x14($sp)
    /* EB30 8001E330 1C00028E */  lw         $v0, 0x1C($s0)
    /* EB34 8001E334 00000000 */  nop
    /* EB38 8001E338 0C00438C */  lw         $v1, 0xC($v0)
    /* EB3C 8001E33C 00000000 */  nop
    /* EB40 8001E340 10006484 */  lh         $a0, 0x10($v1)
    /* EB44 8001E344 00000000 */  nop
    /* EB48 8001E348 21204400 */  addu       $a0, $v0, $a0
    /* EB4C 8001E34C 1400628C */  lw         $v0, 0x14($v1)
    /* EB50 8001E350 00000000 */  nop
    /* EB54 8001E354 09F84000 */  jalr       $v0
    /* EB58 8001E358 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* EB5C 8001E35C 21200002 */  addu       $a0, $s0, $zero
    /* EB60 8001E360 FF004230 */  andi       $v0, $v0, 0xFF
    /* EB64 8001E364 2B100200 */  sltu       $v0, $zero, $v0
    /* EB68 8001E368 C0110200 */  sll        $v0, $v0, 7
    /* EB6C 8001E36C EB70000C */  jal        TransitionOn__22tMenuItemLeftRightFade
    /* EB70 8001E370 2C0082A4 */   sh        $v0, 0x2C($a0)
    /* EB74 8001E374 1400BF8F */  lw         $ra, 0x14($sp)
    /* EB78 8001E378 1000B08F */  lw         $s0, 0x10($sp)
    /* EB7C 8001E37C 0800E003 */  jr         $ra
    /* EB80 8001E380 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TransitionOn__29tMenuItemOnOffLeftRightChoice
