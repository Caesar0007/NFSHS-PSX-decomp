.set noat
.set noreorder

glabel func_8002C56C
/* 8002C56C 27bdff40 */  addiu    $sp,$sp,-192
/* 8002C570 afbf00bc */  sw       $ra,188($sp)
/* 8002C574 0c008e20 */  jal      func_80023880
/* 8002C578 afb000b8 */  sw       $s0,184($sp)
/* 8002C57C 38420001 */  xori     $v0,$v0,0x1
/* 8002C580 10400014 */  beqz     $v0,.L8002C5D4
/* 8002C584 00001021 */  move     $v0,$zero
/* 8002C588 0c006713 */  jal      func_80019C4C
/* 8002C58C 27a40010 */  addiu    $a0,$sp,16
/* 8002C590 0c02e7c7 */  jal      func_800B9F1C
/* 8002C594 24040332 */  li       $a0,818
/* 8002C598 27b00010 */  addiu    $s0,$sp,16
/* 8002C59C 02002021 */  move     $a0,$s0
/* 8002C5A0 ae020090 */  sw       $v0,144($s0)
/* 8002C5A4 24020322 */  li       $v0,802
/* 8002C5A8 ae0200a0 */  sw       $v0,160($s0)
/* 8002C5AC 24020323 */  li       $v0,803
/* 8002C5B0 ae0200a4 */  sw       $v0,164($s0)
/* 8002C5B4 0c00666a */  jal      func_800199A8
/* 8002C5B8 a6000088 */  sh       $zero,136($s0)
/* 8002C5BC 02002021 */  move     $a0,$s0
/* 8002C5C0 00028400 */  sll      $s0,$v0,0x10
/* 8002C5C4 00108403 */  sra      $s0,$s0,0x10
/* 8002C5C8 0c009849 */  jal      func_80026124
/* 8002C5CC 24050002 */  li       $a1,2
/* 8002C5D0 02001021 */  move     $v0,$s0
.L8002C5D4:
/* 8002C5D4 8fbf00bc */  lw       $ra,188($sp)
/* 8002C5D8 8fb000b8 */  lw       $s0,184($sp)
/* 8002C5DC 03e00008 */  jr       $ra
/* 8002C5E0 27bd00c0 */  addiu    $sp,$sp,192
