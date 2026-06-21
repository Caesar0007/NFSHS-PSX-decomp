.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xD0

glabel ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* D62C 8001CE2C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D630 8001CE30 1000BFAF */  sw         $ra, 0x10($sp)
    /* D634 8001CE34 6E008284 */  lh         $v0, 0x6E($a0)
    /* D638 8001CE38 00000000 */  nop
    /* D63C 8001CE3C 09004010 */  beqz       $v0, .L8001CE64
    /* D640 8001CE40 00020224 */   addiu     $v0, $zero, 0x200
    /* D644 8001CE44 0000C38C */  lw         $v1, 0x0($a2)
    /* D648 8001CE48 00000000 */  nop
    /* D64C 8001CE4C 03006210 */  beq        $v1, $v0, .L8001CE5C
    /* D650 8001CE50 00040224 */   addiu     $v0, $zero, 0x400
    /* D654 8001CE54 05006214 */  bne        $v1, $v0, .L8001CE6C
    /* D658 8001CE58 00020224 */   addiu     $v0, $zero, 0x200
  .L8001CE5C:
    /* D65C 8001CE5C 01000224 */  addiu      $v0, $zero, 0x1
    /* D660 8001CE60 0000C2AC */  sw         $v0, 0x0($a2)
  .L8001CE64:
    /* D664 8001CE64 0000C38C */  lw         $v1, 0x0($a2)
    /* D668 8001CE68 00020224 */  addiu      $v0, $zero, 0x200
  .L8001CE6C:
    /* D66C 8001CE6C 10006214 */  bne        $v1, $v0, .L8001CEB0
    /* D670 8001CE70 00000000 */   nop
    /* D674 8001CE74 0800828C */  lw         $v0, 0x8($a0)
    /* D678 8001CE78 00000000 */  nop
    /* D67C 8001CE7C 0C004014 */  bnez       $v0, .L8001CEB0
    /* D680 8001CE80 00000000 */   nop
    /* D684 8001CE84 1000838C */  lw         $v1, 0x10($a0)
    /* D688 8001CE88 00000000 */  nop
    /* D68C 8001CE8C 1800628C */  lw         $v0, 0x18($v1)
    /* D690 8001CE90 00000000 */  nop
    /* D694 8001CE94 18004484 */  lh         $a0, 0x18($v0)
    /* D698 8001CE98 1C00428C */  lw         $v0, 0x1C($v0)
    /* D69C 8001CE9C 00000000 */  nop
    /* D6A0 8001CEA0 09F84000 */  jalr       $v0
    /* D6A4 8001CEA4 21206400 */   addu      $a0, $v1, $a0
    /* D6A8 8001CEA8 BB730008 */  j          .L8001CEEC
    /* D6AC 8001CEAC 00000000 */   nop
  .L8001CEB0:
    /* D6B0 8001CEB0 0000C38C */  lw         $v1, 0x0($a2)
    /* D6B4 8001CEB4 00040224 */  addiu      $v0, $zero, 0x400
    /* D6B8 8001CEB8 0A006214 */  bne        $v1, $v0, .L8001CEE4
    /* D6BC 8001CEBC 00000000 */   nop
    /* D6C0 8001CEC0 0800828C */  lw         $v0, 0x8($a0)
    /* D6C4 8001CEC4 00000000 */  nop
    /* D6C8 8001CEC8 01004224 */  addiu      $v0, $v0, 0x1
    /* D6CC 8001CECC 80100200 */  sll        $v0, $v0, 2
    /* D6D0 8001CED0 21108200 */  addu       $v0, $a0, $v0
    /* D6D4 8001CED4 1000428C */  lw         $v0, 0x10($v0)
    /* D6D8 8001CED8 00000000 */  nop
    /* D6DC 8001CEDC 03004010 */  beqz       $v0, .L8001CEEC
    /* D6E0 8001CEE0 00000000 */   nop
  .L8001CEE4:
    /* D6E4 8001CEE4 5E95000C */  jal        ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* D6E8 8001CEE8 00000000 */   nop
  .L8001CEEC:
    /* D6EC 8001CEEC 1000BF8F */  lw         $ra, 0x10($sp)
    /* D6F0 8001CEF0 00000000 */  nop
    /* D6F4 8001CEF4 0800E003 */  jr         $ra
    /* D6F8 8001CEF8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
