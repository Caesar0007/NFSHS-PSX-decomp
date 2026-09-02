.set noat
.set noreorder

glabel func_8004D76C
/* 8004D76C 27bdffe8 */  addiu    $sp,$sp,-24
/* 8004D770 afbf0014 */  sw       $ra,20($sp)
/* 8004D774 0c02f9ed */  jal      func_800BE7B4
/* 8004D778 afb00010 */  sw       $s0,16($sp)
/* 8004D77C 3c048001 */  lui      $a0,0x8001
/* 8004D780 2484278c */  addiu    $a0,$a0,10124
/* 8004D784 3c050001 */  lui      $a1,0x1
/* 8004D788 34a55180 */  ori      $a1,$a1,0x5180
/* 8004D78C 0c039745 */  jal      func_800E5D14
/* 8004D790 24060010 */  li       $a2,16
/* 8004D794 3c048001 */  lui      $a0,0x8001
/* 8004D798 24842790 */  addiu    $a0,$a0,10128
/* 8004D79C 3c050001 */  lui      $a1,0x1
/* 8004D7A0 34a55180 */  ori      $a1,$a1,0x5180
/* 8004D7A4 24060010 */  li       $a2,16
/* 8004D7A8 3c108012 */  lui      $s0,0x8012
/* 8004D7AC 26100500 */  addiu    $s0,$s0,1280
/* 8004D7B0 0c039745 */  jal      func_800E5D14
/* 8004D7B4 ae020014 */  sw       $v0,20($s0)
/* 8004D7B8 3c050001 */  lui      $a1,0x1
/* 8004D7BC 3c038014 */  lui      $v1,0x8014
/* 8004D7C0 8c64e49c */  lw       $a0,-7012($v1)
/* 8004D7C4 34a55180 */  ori      $a1,$a1,0x5180
/* 8004D7C8 0c02fa6b */  jal      func_800BE9AC
/* 8004D7CC ae02002c */  sw       $v0,44($s0)
/* 8004D7D0 8fbf0014 */  lw       $ra,20($sp)
/* 8004D7D4 8fb00010 */  lw       $s0,16($sp)
/* 8004D7D8 03e00008 */  jr       $ra
/* 8004D7DC 27bd0018 */  addiu    $sp,$sp,24
