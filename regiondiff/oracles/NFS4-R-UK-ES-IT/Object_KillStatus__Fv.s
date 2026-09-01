.set noat
.set noreorder

glabel func_800A5DD0
/* 800A5DD0 27bdffe0 */  addiu    $sp,$sp,-32
/* 800A5DD4 afb10014 */  sw       $s1,20($sp)
/* 800A5DD8 00008821 */  move     $s1,$zero
/* 800A5DDC 3c028011 */  lui      $v0,0x8011
/* 800A5DE0 afb00010 */  sw       $s0,16($sp)
/* 800A5DE4 24507044 */  addiu    $s0,$v0,28740
/* 800A5DE8 afbf0018 */  sw       $ra,24($sp)
.L800A5DEC:
/* 800A5DEC 8e030000 */  lw       $v1,0($s0)
/* 800A5DF0 00000000 */  nop      
/* 800A5DF4 10600009 */  beqz     $v1,.L800A5E1C
/* 800A5DF8 24050003 */  li       $a1,3
/* 800A5DFC 8c620000 */  lw       $v0,0($v1)
/* 800A5E00 00000000 */  nop      
/* 800A5E04 84440008 */  lh       $a0,8($v0)
/* 800A5E08 8c42000c */  lw       $v0,12($v0)
/* 800A5E0C 00000000 */  nop      
/* 800A5E10 0040f809 */  jalr     $v0
/* 800A5E14 00642021 */  addu     $a0,$v1,$a0
/* 800A5E18 ae000000 */  sw       $zero,0($s0)
.L800A5E1C:
/* 800A5E1C 26310001 */  addiu    $s1,$s1,1
/* 800A5E20 2a2201c2 */  slti     $v0,$s1,450
/* 800A5E24 1440fff1 */  bnez     $v0,.L800A5DEC
/* 800A5E28 26100004 */  addiu    $s0,$s0,4
/* 800A5E2C 8fbf0018 */  lw       $ra,24($sp)
/* 800A5E30 8fb10014 */  lw       $s1,20($sp)
/* 800A5E34 8fb00010 */  lw       $s0,16($sp)
/* 800A5E38 03e00008 */  jr       $ra
/* 800A5E3C 27bd0020 */  addiu    $sp,$sp,32
