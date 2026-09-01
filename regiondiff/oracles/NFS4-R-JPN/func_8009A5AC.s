.set noat
.set noreorder

glabel func_8009A5AC
/* 8009A5AC 8f830b74 */  lw       $v1,2932($gp)
/* 8009A5B0 8f820b70 */  lw       $v0,2928($gp)
/* 8009A5B4 27bdffe8 */  addiu    $sp,$sp,-24
/* 8009A5B8 afbf0014 */  sw       $ra,20($sp)
/* 8009A5BC 1062000e */  beq      $v1,$v0,.L8009A5F8
/* 8009A5C0 afb00010 */  sw       $s0,16($sp)
/* 8009A5C4 0c026957 */  jal      func_8009A55C
/* 8009A5C8 00000000 */  nop      
/* 8009A5CC 08026979 */  j        .L8009A5E4
/* 8009A5D0 00000000 */  nop      
.L8009A5D4:
/* 8009A5D4 0c0268a7 */  jal      func_8009A29C
/* 8009A5D8 00000000 */  nop      
/* 8009A5DC 0c039d77 */  jal      func_800E75DC
/* 8009A5E0 00002021 */  move     $a0,$zero
.L8009A5E4:
/* 8009A5E4 8f830b74 */  lw       $v1,2932($gp)
/* 8009A5E8 8f820b70 */  lw       $v0,2928($gp)
/* 8009A5EC 00000000 */  nop      
/* 8009A5F0 1462fff8 */  bne      $v1,$v0,.L8009A5D4
/* 8009A5F4 00000000 */  nop      
.L8009A5F8:
/* 8009A5F8 8f840b68 */  lw       $a0,2920($gp)
/* 8009A5FC 2410ffff */  li       $s0,-1
/* 8009A600 10900003 */  beq      $a0,$s0,.L8009A610
/* 8009A604 00000000 */  nop      
/* 8009A608 0c03a216 */  jal      func_800E8858
/* 8009A60C 00000000 */  nop      
.L8009A610:
/* 8009A610 0c02681a */  jal      func_8009A068
/* 8009A614 00000000 */  nop      
/* 8009A618 3c048011 */  lui      $a0,0x8011
/* 8009A61C af900b68 */  sw       $s0,2920($gp)
/* 8009A620 0c026834 */  jal      func_8009A0D0
/* 8009A624 24842fb4 */  addiu    $a0,$a0,12212
/* 8009A628 8fbf0014 */  lw       $ra,20($sp)
/* 8009A62C 8fb00010 */  lw       $s0,16($sp)
/* 8009A630 24027ffc */  li       $v0,32764
/* 8009A634 af800b60 */  sw       $zero,2912($gp)
/* 8009A638 af800b70 */  sw       $zero,2928($gp)
/* 8009A63C af800b74 */  sw       $zero,2932($gp)
/* 8009A640 af800b64 */  sw       $zero,2916($gp)
/* 8009A644 a7800b84 */  sh       $zero,2948($gp)
/* 8009A648 a7800b8a */  sh       $zero,2954($gp)
/* 8009A64C a7800b86 */  sh       $zero,2950($gp)
/* 8009A650 a7820b88 */  sh       $v0,2952($gp)
/* 8009A654 03e00008 */  jr       $ra
/* 8009A658 27bd0018 */  addiu    $sp,$sp,24
