.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetPinkSlips__FR12tMenuCommand, 0xC0

glabel MenuExtended_SetPinkSlips__FR12tMenuCommand
    /* 1E5B4 8002DDB4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1E5B8 8002DDB8 0580023C */  lui        $v0, %hi(screenMain)
    /* 1E5BC 8002DDBC 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1E5C0 8002DDC0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1E5C4 8002DDC4 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1E5C8 8002DDC8 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1E5CC 8002DDCC 21180000 */  addu       $v1, $zero, $zero
    /* 1E5D0 8002DDD0 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1E5D4 8002DDD4 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1E5D8 8002DDD8 21204000 */  addu       $a0, $v0, $zero
    /* 1E5DC 8002DDDC 06000224 */  addiu      $v0, $zero, 0x6
    /* 1E5E0 8002DDE0 040082A0 */  sb         $v0, 0x4($a0)
    /* 1E5E4 8002DDE4 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E5E8 8002DDE8 030082A0 */  sb         $v0, 0x3($a0)
    /* 1E5EC 8002DDEC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 1E5F0 8002DDF0 1E0380A0 */  sb         $zero, 0x31E($a0)
    /* 1E5F4 8002DDF4 5A0082A4 */  sh         $v0, 0x5A($a0)
    /* 1E5F8 8002DDF8 460080A0 */  sb         $zero, 0x46($a0)
    /* 1E5FC 8002DDFC 00140300 */  sll        $v0, $v1, 16
  .L8002DE00:
    /* 1E600 8002DE00 03140200 */  sra        $v0, $v0, 16
    /* 1E604 8002DE04 21104400 */  addu       $v0, $v0, $a0
    /* 1E608 8002DE08 480040A0 */  sb         $zero, 0x48($v0)
    /* 1E60C 8002DE0C 01006224 */  addiu      $v0, $v1, 0x1
    /* 1E610 8002DE10 21184000 */  addu       $v1, $v0, $zero
    /* 1E614 8002DE14 00140200 */  sll        $v0, $v0, 16
    /* 1E618 8002DE18 03140200 */  sra        $v0, $v0, 16
    /* 1E61C 8002DE1C 02004228 */  slti       $v0, $v0, 0x2
    /* 1E620 8002DE20 F7FF4014 */  bnez       $v0, .L8002DE00
    /* 1E624 8002DE24 00140300 */   sll       $v0, $v1, 16
    /* 1E628 8002DE28 21180000 */  addu       $v1, $zero, $zero
    /* 1E62C 8002DE2C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1E630 8002DE30 00464524 */  addiu      $a1, $v0, %lo(frontEnd)
    /* 1E634 8002DE34 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L8002DE38:
    /* 1E638 8002DE38 00140300 */  sll        $v0, $v1, 16
    /* 1E63C 8002DE3C C3130200 */  sra        $v0, $v0, 15
    /* 1E640 8002DE40 21104500 */  addu       $v0, $v0, $a1
    /* 1E644 8002DE44 0C0044A4 */  sh         $a0, 0xC($v0)
    /* 1E648 8002DE48 01006224 */  addiu      $v0, $v1, 0x1
    /* 1E64C 8002DE4C 21184000 */  addu       $v1, $v0, $zero
    /* 1E650 8002DE50 00140200 */  sll        $v0, $v0, 16
    /* 1E654 8002DE54 03140200 */  sra        $v0, $v0, 16
    /* 1E658 8002DE58 05004228 */  slti       $v0, $v0, 0x5
    /* 1E65C 8002DE5C F6FF4014 */  bnez       $v0, .L8002DE38
    /* 1E660 8002DE60 00000000 */   nop
    /* 1E664 8002DE64 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1E668 8002DE68 00000000 */  nop
    /* 1E66C 8002DE6C 0800E003 */  jr         $ra
    /* 1E670 8002DE70 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetPinkSlips__FR12tMenuCommand
