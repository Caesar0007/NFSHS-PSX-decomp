.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8004D5DC, 0xB0

glabel func_8004D5DC
    /* 3DDDC 8004D5DC F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* 3DDE0 8004D5E0 2C00838C */  lw         $v1, 0x2C($a0)
    /* 3DDE4 8004D5E4 8000023C */  lui        $v0, (0x800000 >> 16)
    /* 3DDE8 8004D5E8 0000A2AF */  sw         $v0, 0x0($sp)
    /* 3DDEC 8004D5EC 24006014 */  bnez       $v1, .L8004D680
    /* 3DDF0 8004D5F0 0580023C */   lui       $v0, %hi(D_80052A28)
    /* 3DDF4 8004D5F4 01000624 */  addiu      $a2, $zero, 0x1
    /* 3DDF8 8004D5F8 282A438C */  lw         $v1, %lo(D_80052A28)($v0)
    /* 3DDFC 8004D5FC F0000224 */  addiu      $v0, $zero, 0xF0
    /* 3DE00 8004D600 23104300 */  subu       $v0, $v0, $v1
    /* 3DE04 8004D604 C21F0200 */  srl        $v1, $v0, 31
    /* 3DE08 8004D608 21104300 */  addu       $v0, $v0, $v1
    /* 3DE0C 8004D60C 0728C200 */  srav       $a1, $v0, $a2
  .L8004D610:
    /* 3DE10 8004D610 0000A28F */  lw         $v0, 0x0($sp)
    /* 3DE14 8004D614 00000000 */  nop
    /* 3DE18 8004D618 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 3DE1C 8004D61C 0000A2AF */  sw         $v0, 0x0($sp)
    /* 3DE20 8004D620 0000A28F */  lw         $v0, 0x0($sp)
    /* 3DE24 8004D624 00000000 */  nop
    /* 3DE28 8004D628 11004014 */  bnez       $v0, .L8004D670
    /* 3DE2C 8004D62C 00000000 */   nop
    /* 3DE30 8004D630 2000828C */  lw         $v0, 0x20($a0)
    /* 3DE34 8004D634 2C0086AC */  sw         $a2, 0x2C($a0)
    /* 3DE38 8004D638 0100422C */  sltiu      $v0, $v0, 0x1
    /* 3DE3C 8004D63C 200082AC */  sw         $v0, 0x20($a0)
    /* 3DE40 8004D640 C0100200 */  sll        $v0, $v0, 3
    /* 3DE44 8004D644 21108200 */  addu       $v0, $a0, $v0
    /* 3DE48 8004D648 10004394 */  lhu        $v1, 0x10($v0)
    /* 3DE4C 8004D64C 2000828C */  lw         $v0, 0x20($a0)
    /* 3DE50 8004D650 00000000 */  nop
    /* 3DE54 8004D654 C0100200 */  sll        $v0, $v0, 3
    /* 3DE58 8004D658 21108200 */  addu       $v0, $a0, $v0
    /* 3DE5C 8004D65C 240083A4 */  sh         $v1, 0x24($a0)
    /* 3DE60 8004D660 12004294 */  lhu        $v0, 0x12($v0)
    /* 3DE64 8004D664 00000000 */  nop
    /* 3DE68 8004D668 21104500 */  addu       $v0, $v0, $a1
    /* 3DE6C 8004D66C 260082A4 */  sh         $v0, 0x26($a0)
  .L8004D670:
    /* 3DE70 8004D670 2C00828C */  lw         $v0, 0x2C($a0)
    /* 3DE74 8004D674 00000000 */  nop
    /* 3DE78 8004D678 E5FF4010 */  beqz       $v0, .L8004D610
    /* 3DE7C 8004D67C 00000000 */   nop
  .L8004D680:
    /* 3DE80 8004D680 2C0080AC */  sw         $zero, 0x2C($a0)
    /* 3DE84 8004D684 0800E003 */  jr         $ra
    /* 3DE88 8004D688 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel func_8004D5DC
