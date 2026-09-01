.set noat
.set noreorder

glabel func_800EECDC
/* 800EECDC 27bdffe8 */  addiu    $sp,$sp,-24
/* 800EECE0 afb00010 */  sw       $s0,16($sp)
/* 800EECE4 00808021 */  move     $s0,$a0
/* 800EECE8 24020002 */  li       $v0,2
/* 800EECEC afbf0014 */  sw       $ra,20($sp)
/* 800EECF0 a2020003 */  sb       $v0,3($s0)
/* 800EECF4 84a40000 */  lh       $a0,0($a1)
/* 800EECF8 84a50002 */  lh       $a1,2($a1)
/* 800EECFC 0c03bcd4 */  jal      func_800EF350
/* 800EED00 00000000 */  nop      
/* 800EED04 ae020004 */  sw       $v0,4($s0)
/* 800EED08 ae000008 */  sw       $zero,8($s0)
/* 800EED0C 8fbf0014 */  lw       $ra,20($sp)
/* 800EED10 8fb00010 */  lw       $s0,16($sp)
/* 800EED14 03e00008 */  jr       $ra
/* 800EED18 27bd0018 */  addiu    $sp,$sp,24
