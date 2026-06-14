.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BTC_QuitOut__Fv, 0xC4

glabel Hud_BTC_QuitOut__Fv
    /* CA048 800D9848 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* CA04C 800D984C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CA050 800D9850 2000BFAF */  sw         $ra, 0x20($sp)
    /* CA054 800D9854 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CA058 800D9858 1800B2AF */  sw         $s2, 0x18($sp)
    /* CA05C 800D985C 1400B1AF */  sw         $s1, 0x14($sp)
    /* CA060 800D9860 23004014 */  bnez       $v0, .L800D98F0
    /* CA064 800D9864 1000B0AF */   sw        $s0, 0x10($sp)
    /* CA068 800D9868 21900000 */  addu       $s2, $zero, $zero
    /* CA06C 800D986C 1280023C */  lui        $v0, %hi(BTCPerpInfo)
    /* CA070 800D9870 C00B5324 */  addiu      $s3, $v0, %lo(BTCPerpInfo)
    /* CA074 800D9874 21884002 */  addu       $s1, $s2, $zero
  .L800D9878:
    /* CA078 800D9878 40801200 */  sll        $s0, $s2, 1
    /* CA07C 800D987C 1480023C */  lui        $v0, %hi(Hud_NextPerp)
    /* CA080 800D9880 94D94224 */  addiu      $v0, $v0, %lo(Hud_NextPerp)
    /* CA084 800D9884 21800202 */  addu       $s0, $s0, $v0
    /* CA088 800D9888 1480053C */  lui        $a1, %hi(D_8013E850)
    /* CA08C 800D988C 00000486 */  lh         $a0, 0x0($s0)
    /* CA090 800D9890 50E8A524 */  addiu      $a1, $a1, %lo(D_8013E850)
    /* CA094 800D9894 00210400 */  sll        $a0, $a0, 4
    /* CA098 800D9898 21209300 */  addu       $a0, $a0, $s3
    /* CA09C 800D989C 2F91030C */  jal        sprintf
    /* CA0A0 800D98A0 21202402 */   addu      $a0, $s1, $a0
    /* CA0A4 800D98A4 00000286 */  lh         $v0, 0x0($s0)
    /* CA0A8 800D98A8 00000000 */  nop
    /* CA0AC 800D98AC 00110200 */  sll        $v0, $v0, 4
    /* CA0B0 800D98B0 21105100 */  addu       $v0, $v0, $s1
    /* CA0B4 800D98B4 21105300 */  addu       $v0, $v0, $s3
    /* CA0B8 800D98B8 0C0040AC */  sw         $zero, 0xC($v0)
    /* CA0BC 800D98BC 00000286 */  lh         $v0, 0x0($s0)
    /* CA0C0 800D98C0 01005226 */  addiu      $s2, $s2, 0x1
    /* CA0C4 800D98C4 00110200 */  sll        $v0, $v0, 4
    /* CA0C8 800D98C8 21105100 */  addu       $v0, $v0, $s1
    /* CA0CC 800D98CC 21105300 */  addu       $v0, $v0, $s3
    /* CA0D0 800D98D0 080040AC */  sw         $zero, 0x8($v0)
    /* CA0D4 800D98D4 00000296 */  lhu        $v0, 0x0($s0)
    /* CA0D8 800D98D8 00000000 */  nop
    /* CA0DC 800D98DC 01004224 */  addiu      $v0, $v0, 0x1
    /* CA0E0 800D98E0 000002A6 */  sh         $v0, 0x0($s0)
    /* CA0E4 800D98E4 0200422A */  slti       $v0, $s2, 0x2
    /* CA0E8 800D98E8 E3FF4014 */  bnez       $v0, .L800D9878
    /* CA0EC 800D98EC A0003126 */   addiu     $s1, $s1, 0xA0
  .L800D98F0:
    /* CA0F0 800D98F0 2000BF8F */  lw         $ra, 0x20($sp)
    /* CA0F4 800D98F4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CA0F8 800D98F8 1800B28F */  lw         $s2, 0x18($sp)
    /* CA0FC 800D98FC 1400B18F */  lw         $s1, 0x14($sp)
    /* CA100 800D9900 1000B08F */  lw         $s0, 0x10($sp)
    /* CA104 800D9904 0800E003 */  jr         $ra
    /* CA108 800D9908 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_BTC_QuitOut__Fv
