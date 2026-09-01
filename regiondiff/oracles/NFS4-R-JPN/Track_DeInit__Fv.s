.set noat
.set noreorder

glabel func_800BB7F4
/* 800BB7F4 27bdffe8 */  addiu    $sp,$sp,-24
/* 800BB7F8 afb00010 */  sw       $s0,16($sp)
/* 800BB7FC 8f900f84 */  lw       $s0,3972($gp)
/* 800BB800 00000000 */  nop      
/* 800BB804 12000007 */  beqz     $s0,.L800BB824
/* 800BB808 afbf0014 */  sw       $ra,20($sp)
/* 800BB80C 8e040000 */  lw       $a0,0($s0)
/* 800BB810 0c0397c6 */  jal      func_800E5F18
/* 800BB814 00000000 */  nop      
/* 800BB818 02002021 */  move     $a0,$s0
/* 800BB81C 0c029244 */  jal      func_800A4910
/* 800BB820 ac800004 */  sw       $zero,4($a0)
.L800BB824:
/* 800BB824 8f840f74 */  lw       $a0,3956($gp)
/* 800BB828 00000000 */  nop      
/* 800BB82C 10800005 */  beqz     $a0,.L800BB844
/* 800BB830 3c028012 */  lui      $v0,0x8012
/* 800BB834 0c02eecf */  jal      func_800BBB3C
/* 800BB838 24050003 */  li       $a1,3
/* 800BB83C af800f74 */  sw       $zero,3956($gp)
/* 800BB840 3c028012 */  lui      $v0,0x8012
.L800BB844:
/* 800BB844 2443f234 */  addiu    $v1,$v0,-3532
/* 800BB848 8c620004 */  lw       $v0,4($v1)
/* 800BB84C 00000000 */  nop      
/* 800BB850 10400002 */  beqz     $v0,.L800BB85C
/* 800BB854 00000000 */  nop      
/* 800BB858 ac600004 */  sw       $zero,4($v1)
.L800BB85C:
/* 800BB85C 0c01fce3 */  jal      func_8007F38C
/* 800BB860 00000000 */  nop      
/* 800BB864 0c029df0 */  jal      func_800A77C0
/* 800BB868 00000000 */  nop      
/* 800BB86C 0c02e7a1 */  jal      func_800B9E84
/* 800BB870 00000000 */  nop      
/* 800BB874 3c048014 */  lui      $a0,0x8014
/* 800BB878 8c84d8f8 */  lw       $a0,-9992($a0)
/* 800BB87C 00000000 */  nop      
/* 800BB880 10800005 */  beqz     $a0,.L800BB898
/* 800BB884 00000000 */  nop      
/* 800BB888 0c0397c6 */  jal      func_800E5F18
/* 800BB88C 00000000 */  nop      
/* 800BB890 3c018014 */  lui      $at,0x8014
/* 800BB894 ac20d8f8 */  sw       $zero,-9992($at)
.L800BB898:
/* 800BB898 8f840f70 */  lw       $a0,3952($gp)
/* 800BB89C 00000000 */  nop      
/* 800BB8A0 10800003 */  beqz     $a0,.L800BB8B0
/* 800BB8A4 00000000 */  nop      
/* 800BB8A8 0c0397c6 */  jal      func_800E5F18
/* 800BB8AC 00000000 */  nop      
.L800BB8B0:
/* 800BB8B0 8fbf0014 */  lw       $ra,20($sp)
/* 800BB8B4 8fb00010 */  lw       $s0,16($sp)
/* 800BB8B8 af800f70 */  sw       $zero,3952($gp)
/* 800BB8BC af800f6c */  sw       $zero,3948($gp)
/* 800BB8C0 af800f68 */  sw       $zero,3944($gp)
/* 800BB8C4 af800f64 */  sw       $zero,3940($gp)
/* 800BB8C8 03e00008 */  jr       $ra
/* 800BB8CC 27bd0018 */  addiu    $sp,$sp,24
