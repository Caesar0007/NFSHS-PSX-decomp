.set noat
.set noreorder

glabel func_8003BB60
/* 8003BB60 27bdffd0 */  addiu    $sp,$sp,-48
/* 8003BB64 afb10024 */  sw       $s1,36($sp)
/* 8003BB68 00808821 */  move     $s1,$a0
/* 8003BB6C afb00020 */  sw       $s0,32($sp)
/* 8003BB70 26300304 */  addiu    $s0,$s1,772
/* 8003BB74 02002021 */  move     $a0,$s0
/* 8003BB78 26250124 */  addiu    $a1,$s1,292
/* 8003BB7C 2402000a */  li       $v0,10
/* 8003BB80 afa20010 */  sw       $v0,16($sp)
/* 8003BB84 3c028005 */  lui      $v0,0x8005
/* 8003BB88 24421edc */  addiu    $v0,$v0,7900
/* 8003BB8C afa20014 */  sw       $v0,20($sp)
/* 8003BB90 24020096 */  li       $v0,150
/* 8003BB94 afbf0028 */  sw       $ra,40($sp)
/* 8003BB98 afa20018 */  sw       $v0,24($sp)
/* 8003BB9C 8e260028 */  lw       $a2,40($s1)
/* 8003BBA0 0c00d950 */  jal      func_80036540
/* 8003BBA4 00003821 */  move     $a3,$zero
/* 8003BBA8 02002021 */  move     $a0,$s0
/* 8003BBAC 240500f9 */  li       $a1,249
/* 8003BBB0 24060140 */  li       $a2,320
/* 8003BBB4 0c00d9cf */  jal      func_8003673C
/* 8003BBB8 24070050 */  li       $a3,80
/* 8003BBBC 02002021 */  move     $a0,$s0
/* 8003BBC0 2405001c */  li       $a1,28
/* 8003BBC4 2406000a */  li       $a2,10
/* 8003BBC8 2402003c */  li       $v0,60
/* 8003BBCC afa20010 */  sw       $v0,16($sp)
/* 8003BBD0 8e220000 */  lw       $v0,0($s1)
/* 8003BBD4 24070136 */  li       $a3,310
/* 8003BBD8 0c00d9d6 */  jal      func_80036758
/* 8003BBDC afa20014 */  sw       $v0,20($sp)
/* 8003BBE0 9622003a */  lhu      $v0,58($s1)
/* 8003BBE4 00000000 */  nop      
/* 8003BBE8 30420001 */  andi     $v0,$v0,0x1
/* 8003BBEC 10400005 */  beqz     $v0,.L8003BC04
/* 8003BBF0 00000000 */  nop      
/* 8003BBF4 0c00d97c */  jal      func_800365F0
/* 8003BBF8 02002021 */  move     $a0,$s0
/* 8003BBFC 24020001 */  li       $v0,1
/* 8003BC00 ae220384 */  sw       $v0,900($s1)
.L8003BC04:
/* 8003BC04 8fbf0028 */  lw       $ra,40($sp)
/* 8003BC08 8fb10024 */  lw       $s1,36($sp)
/* 8003BC0C 8fb00020 */  lw       $s0,32($sp)
/* 8003BC10 03e00008 */  jr       $ra
/* 8003BC14 27bd0030 */  addiu    $sp,$sp,48
