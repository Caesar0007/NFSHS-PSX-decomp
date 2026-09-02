.set noat
.set noreorder

glabel func_8002C584
/* 8002C584 27bdff40 */  addiu    $sp,$sp,-192
/* 8002C588 afbf00bc */  sw       $ra,188($sp)
/* 8002C58C 0c008e26 */  jal      func_80023898
/* 8002C590 afb000b8 */  sw       $s0,184($sp)
/* 8002C594 38420001 */  xori     $v0,$v0,0x1
/* 8002C598 10400014 */  beqz     $v0,.L8002C5EC
/* 8002C59C 00001021 */  move     $v0,$zero
/* 8002C5A0 0c006719 */  jal      func_80019C64
/* 8002C5A4 27a40010 */  addiu    $a0,$sp,16
/* 8002C5A8 0c02e7c7 */  jal      func_800B9F1C
/* 8002C5AC 24040332 */  li       $a0,818
/* 8002C5B0 27b00010 */  addiu    $s0,$sp,16
/* 8002C5B4 02002021 */  move     $a0,$s0
/* 8002C5B8 ae020090 */  sw       $v0,144($s0)
/* 8002C5BC 24020322 */  li       $v0,802
/* 8002C5C0 ae0200a0 */  sw       $v0,160($s0)
/* 8002C5C4 24020323 */  li       $v0,803
/* 8002C5C8 ae0200a4 */  sw       $v0,164($s0)
/* 8002C5CC 0c006670 */  jal      func_800199C0
/* 8002C5D0 a6000088 */  sh       $zero,136($s0)
/* 8002C5D4 02002021 */  move     $a0,$s0
/* 8002C5D8 00028400 */  sll      $s0,$v0,0x10
/* 8002C5DC 00108403 */  sra      $s0,$s0,0x10
/* 8002C5E0 0c00984f */  jal      func_8002613C
/* 8002C5E4 24050002 */  li       $a1,2
/* 8002C5E8 02001021 */  move     $v0,$s0
.L8002C5EC:
/* 8002C5EC 8fbf00bc */  lw       $ra,188($sp)
/* 8002C5F0 8fb000b8 */  lw       $s0,184($sp)
/* 8002C5F4 03e00008 */  jr       $ra
/* 8002C5F8 27bd00c0 */  addiu    $sp,$sp,192
