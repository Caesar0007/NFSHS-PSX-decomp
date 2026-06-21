.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__29tMenuItemOptionsTwoItemChoice, 0x5C

glabel TransitionOn__29tMenuItemOptionsTwoItemChoice
    /* B5B8 8001ADB8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* B5BC 8001ADBC 1000B0AF */  sw         $s0, 0x10($sp)
    /* B5C0 8001ADC0 21808000 */  addu       $s0, $a0, $zero
    /* B5C4 8001ADC4 1400BFAF */  sw         $ra, 0x14($sp)
    /* B5C8 8001ADC8 1C00028E */  lw         $v0, 0x1C($s0)
    /* B5CC 8001ADCC 00000000 */  nop
    /* B5D0 8001ADD0 0C00438C */  lw         $v1, 0xC($v0)
    /* B5D4 8001ADD4 00000000 */  nop
    /* B5D8 8001ADD8 10006484 */  lh         $a0, 0x10($v1)
    /* B5DC 8001ADDC 00000000 */  nop
    /* B5E0 8001ADE0 21204400 */  addu       $a0, $v0, $a0
    /* B5E4 8001ADE4 1400628C */  lw         $v0, 0x14($v1)
    /* B5E8 8001ADE8 00000000 */  nop
    /* B5EC 8001ADEC 09F84000 */  jalr       $v0
    /* B5F0 8001ADF0 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* B5F4 8001ADF4 FF004230 */  andi       $v0, $v0, 0xFF
    /* B5F8 8001ADF8 2B100200 */  sltu       $v0, $zero, $v0
    /* B5FC 8001ADFC C0110200 */  sll        $v0, $v0, 7
    /* B600 8001AE00 200002A6 */  sh         $v0, 0x20($s0)
    /* B604 8001AE04 1400BF8F */  lw         $ra, 0x14($sp)
    /* B608 8001AE08 1000B08F */  lw         $s0, 0x10($sp)
    /* B60C 8001AE0C 0800E003 */  jr         $ra
    /* B610 8001AE10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TransitionOn__29tMenuItemOptionsTwoItemChoice
