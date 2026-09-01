.set noat
.set noreorder

glabel func_8007A6A0
/* 8007A6A0 27bdffe8 */  addiu    $sp,$sp,-24
/* 8007A6A4 afbf0010 */  sw       $ra,16($sp)
/* 8007A6A8 0c03a272 */  jal      func_800E89C8
/* 8007A6AC 2404007f */  li       $a0,127
/* 8007A6B0 8f830108 */  lw       $v1,264($gp)
/* 8007A6B4 00000000 */  nop      
/* 8007A6B8 28620055 */  slti     $v0,$v1,85
/* 8007A6BC 14400004 */  bnez     $v0,.L8007A6D0
/* 8007A6C0 00031040 */  sll      $v0,$v1,0x1
/* 8007A6C4 00031840 */  sll      $v1,$v1,0x1
/* 8007A6C8 2463ffac */  addiu    $v1,$v1,-84
/* 8007A6CC 00031040 */  sll      $v0,$v1,0x1
.L8007A6D0:
/* 8007A6D0 00431021 */  addu     $v0,$v0,$v1
/* 8007A6D4 00021140 */  sll      $v0,$v0,0x5
/* 8007A6D8 0c01ef11 */  jal      func_8007BC44
/* 8007A6DC 000221c3 */  sra      $a0,$v0,0x7
/* 8007A6E0 0c01f3b5 */  jal      func_8007CED4
/* 8007A6E4 00000000 */  nop      
/* 8007A6E8 3c028011 */  lui      $v0,0x8011
/* 8007A6EC 8f83010c */  lw       $v1,268($gp)
/* 8007A6F0 8f840108 */  lw       $a0,264($gp)
/* 8007A6F4 24424290 */  addiu    $v0,$v0,17040
/* 8007A6F8 ac4300f4 */  sw       $v1,244($v0)
/* 8007A6FC ac4400f0 */  sw       $a0,240($v0)
/* 8007A700 8fbf0010 */  lw       $ra,16($sp)
/* 8007A704 00000000 */  nop      
/* 8007A708 03e00008 */  jr       $ra
/* 8007A70C 27bd0018 */  addiu    $sp,$sp,24
