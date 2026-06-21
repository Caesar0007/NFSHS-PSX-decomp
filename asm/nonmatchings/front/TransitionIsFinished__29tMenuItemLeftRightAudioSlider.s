.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__29tMenuItemLeftRightAudioSlider, 0x5C

glabel TransitionIsFinished__29tMenuItemLeftRightAudioSlider
    /* F078 8001E878 2A008284 */  lh         $v0, 0x2A($a0)
    /* F07C 8001E87C 00000000 */  nop
    /* F080 8001E880 06004104 */  bgez       $v0, .L8001E89C
    /* F084 8001E884 2C0080AC */   sw        $zero, 0x2C($a0)
    /* F088 8001E888 28008284 */  lh         $v0, 0x28($a0)
    /* F08C 8001E88C 00000000 */  nop
    /* F090 8001E890 02004018 */  blez       $v0, .L8001E89C
    /* F094 8001E894 01000224 */   addiu     $v0, $zero, 0x1
    /* F098 8001E898 2C0082AC */  sw         $v0, 0x2C($a0)
  .L8001E89C:
    /* F09C 8001E89C 2A008284 */  lh         $v0, 0x2A($a0)
    /* F0A0 8001E8A0 00000000 */  nop
    /* F0A4 8001E8A4 08004018 */  blez       $v0, .L8001E8C8
    /* F0A8 8001E8A8 00000000 */   nop
    /* F0AC 8001E8AC 28008284 */  lh         $v0, 0x28($a0)
    /* F0B0 8001E8B0 00000000 */  nop
    /* F0B4 8001E8B4 80004228 */  slti       $v0, $v0, 0x80
    /* F0B8 8001E8B8 03004010 */  beqz       $v0, .L8001E8C8
    /* F0BC 8001E8BC 00000000 */   nop
    /* F0C0 8001E8C0 01000224 */  addiu      $v0, $zero, 0x1
    /* F0C4 8001E8C4 2C0082AC */  sw         $v0, 0x2C($a0)
  .L8001E8C8:
    /* F0C8 8001E8C8 2C00828C */  lw         $v0, 0x2C($a0)
    /* F0CC 8001E8CC 0800E003 */  jr         $ra
    /* F0D0 8001E8D0 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__29tMenuItemLeftRightAudioSlider
