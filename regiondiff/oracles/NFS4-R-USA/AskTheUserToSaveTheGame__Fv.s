.set noat
.set noreorder

glabel func_8002C49C
/* 8002C49C 27bdff40 */  addiu    $sp,$sp,-192
/* 8002C4A0 afbf00bc */  sw       $ra,188($sp)
/* 8002C4A4 0c008dfc */  jal      func_800237F0
/* 8002C4A8 afb000b8 */  sw       $s0,184($sp)
/* 8002C4AC 38420001 */  xori     $v0,$v0,0x1
/* 8002C4B0 10400014 */  beqz     $v0,.L8002C504
/* 8002C4B4 00001021 */  move     $v0,$zero
/* 8002C4B8 0c0066f3 */  jal      func_80019BCC
/* 8002C4BC 27a40010 */  addiu    $a0,$sp,16
/* 8002C4C0 0c02e7c6 */  jal      func_800B9F18
/* 8002C4C4 24040332 */  li       $a0,818
/* 8002C4C8 27b00010 */  addiu    $s0,$sp,16
/* 8002C4CC 02002021 */  move     $a0,$s0
/* 8002C4D0 ae020090 */  sw       $v0,144($s0)
/* 8002C4D4 24020322 */  li       $v0,802
/* 8002C4D8 ae0200a0 */  sw       $v0,160($s0)
/* 8002C4DC 24020323 */  li       $v0,803
/* 8002C4E0 ae0200a4 */  sw       $v0,164($s0)
/* 8002C4E4 0c00664a */  jal      func_80019928
/* 8002C4E8 a6000088 */  sh       $zero,136($s0)
/* 8002C4EC 02002021 */  move     $a0,$s0
/* 8002C4F0 00028400 */  sll      $s0,$v0,0x10
/* 8002C4F4 00108403 */  sra      $s0,$s0,0x10
/* 8002C4F8 0c009826 */  jal      func_80026098
/* 8002C4FC 24050002 */  li       $a1,2
/* 8002C500 02001021 */  move     $v0,$s0
.L8002C504:
/* 8002C504 8fbf00bc */  lw       $ra,188($sp)
/* 8002C508 8fb000b8 */  lw       $s0,184($sp)
/* 8002C50C 03e00008 */  jr       $ra
/* 8002C510 27bd00c0 */  addiu    $sp,$sp,192
