.set noat
.set noreorder

glabel func_8009A5B0
/* 8009A5B0 8f830b74 */  lw       $v1,2932($gp)
/* 8009A5B4 8f820b70 */  lw       $v0,2928($gp)
/* 8009A5B8 27bdffe8 */  addiu    $sp,$sp,-24
/* 8009A5BC afbf0014 */  sw       $ra,20($sp)
/* 8009A5C0 1062000e */  beq      $v1,$v0,.L8009A5FC
/* 8009A5C4 afb00010 */  sw       $s0,16($sp)
/* 8009A5C8 0c026958 */  jal      func_8009A560
/* 8009A5CC 00000000 */  nop      
/* 8009A5D0 0802697a */  j        .L8009A5E8
/* 8009A5D4 00000000 */  nop      
.L8009A5D8:
/* 8009A5D8 0c0268a8 */  jal      func_8009A2A0
/* 8009A5DC 00000000 */  nop      
/* 8009A5E0 0c039df7 */  jal      func_800E77DC
/* 8009A5E4 00002021 */  move     $a0,$zero
.L8009A5E8:
/* 8009A5E8 8f830b74 */  lw       $v1,2932($gp)
/* 8009A5EC 8f820b70 */  lw       $v0,2928($gp)
/* 8009A5F0 00000000 */  nop      
/* 8009A5F4 1462fff8 */  bne      $v1,$v0,.L8009A5D8
/* 8009A5F8 00000000 */  nop      
.L8009A5FC:
/* 8009A5FC 8f840b68 */  lw       $a0,2920($gp)
/* 8009A600 2410ffff */  li       $s0,-1
/* 8009A604 10900003 */  beq      $a0,$s0,.L8009A614
/* 8009A608 00000000 */  nop      
/* 8009A60C 0c03a296 */  jal      func_800E8A58
/* 8009A610 00000000 */  nop      
.L8009A614:
/* 8009A614 0c02681b */  jal      func_8009A06C
/* 8009A618 00000000 */  nop      
/* 8009A61C 3c048011 */  lui      $a0,0x8011
/* 8009A620 af900b68 */  sw       $s0,2920($gp)
/* 8009A624 0c026835 */  jal      func_8009A0D4
/* 8009A628 248431f4 */  addiu    $a0,$a0,12788
/* 8009A62C 8fbf0014 */  lw       $ra,20($sp)
/* 8009A630 8fb00010 */  lw       $s0,16($sp)
/* 8009A634 24027ffc */  li       $v0,32764
/* 8009A638 af800b60 */  sw       $zero,2912($gp)
/* 8009A63C af800b70 */  sw       $zero,2928($gp)
/* 8009A640 af800b74 */  sw       $zero,2932($gp)
/* 8009A644 af800b64 */  sw       $zero,2916($gp)
/* 8009A648 a7800b84 */  sh       $zero,2948($gp)
/* 8009A64C a7800b8a */  sh       $zero,2954($gp)
/* 8009A650 a7800b86 */  sh       $zero,2950($gp)
/* 8009A654 a7820b88 */  sh       $v0,2952($gp)
/* 8009A658 03e00008 */  jr       $ra
/* 8009A65C 27bd0018 */  addiu    $sp,$sp,24
