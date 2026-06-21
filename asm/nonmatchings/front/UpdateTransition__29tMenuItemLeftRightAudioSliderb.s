.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__29tMenuItemLeftRightAudioSliderb, 0x4C

glabel UpdateTransition__29tMenuItemLeftRightAudioSliderb
    /* F0D4 8001E8D4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F0D8 8001E8D8 1000BFAF */  sw         $ra, 0x10($sp)
    /* F0DC 8001E8DC 28008284 */  lh         $v0, 0x28($a0)
    /* F0E0 8001E8E0 2A008384 */  lh         $v1, 0x2A($a0)
    /* F0E4 8001E8E4 00000000 */  nop
    /* F0E8 8001E8E8 21184300 */  addu       $v1, $v0, $v1
    /* F0EC 8001E8EC 81006228 */  slti       $v0, $v1, 0x81
    /* F0F0 8001E8F0 02004014 */  bnez       $v0, .L8001E8FC
    /* F0F4 8001E8F4 00000000 */   nop
    /* F0F8 8001E8F8 80000324 */  addiu      $v1, $zero, 0x80
  .L8001E8FC:
    /* F0FC 8001E8FC 02006104 */  bgez       $v1, .L8001E908
    /* F100 8001E900 00000000 */   nop
    /* F104 8001E904 21180000 */  addu       $v1, $zero, $zero
  .L8001E908:
    /* F108 8001E908 EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* F10C 8001E90C 280083A4 */   sh        $v1, 0x28($a0)
    /* F110 8001E910 1000BF8F */  lw         $ra, 0x10($sp)
    /* F114 8001E914 00000000 */  nop
    /* F118 8001E918 0800E003 */  jr         $ra
    /* F11C 8001E91C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateTransition__29tMenuItemLeftRightAudioSliderb
