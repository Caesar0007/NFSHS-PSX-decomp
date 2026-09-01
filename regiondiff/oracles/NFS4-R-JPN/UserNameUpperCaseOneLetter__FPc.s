.set noat
.set noreorder

glabel func_8004AA54
/* 8004AA54 90830000 */  lbu      $v1,0($a0)
/* 8004AA58 00000000 */  nop      
/* 8004AA5C 2462ff9f */  addiu    $v0,$v1,-97
/* 8004AA60 2c42001a */  sltiu    $v0,$v0,26
/* 8004AA64 10400003 */  beqz     $v0,.L8004AA74
/* 8004AA68 246200e0 */  addiu    $v0,$v1,224
/* 8004AA6C 03e00008 */  jr       $ra
/* 8004AA70 a0820000 */  sb       $v0,0($a0)
.L8004AA74:
/* 8004AA74 90820000 */  lbu      $v0,0($a0)
/* 8004AA78 00000000 */  nop      
/* 8004AA7C 2443ff20 */  addiu    $v1,$v0,-224
/* 8004AA80 2c62001d */  sltiu    $v0,$v1,29
/* 8004AA84 10400039 */  beqz     $v0,.L8004AB6C
/* 8004AA88 3c028001 */  lui      $v0,%hi(jtbl_800124F0)
/* 8004AA8C 244224f0 */  addiu    $v0,$v0,%lo(jtbl_800124F0)
/* 8004AA90 00031880 */  sll      $v1,$v1,0x2
/* 8004AA94 00621821 */  addu     $v1,$v1,$v0
/* 8004AA98 8c620000 */  lw       $v0,0($v1)
/* 8004AA9C 00000000 */  nop      
/* 8004AAA0 00400008 */  jr       $v0
/* 8004AAA4 00000000 */  nop      
.L8004AAA8:
/* 8004AAA8 240200c4 */  li       $v0,196
/* 8004AAAC 03e00008 */  jr       $ra
/* 8004AAB0 a0820000 */  sb       $v0,0($a0)
.L8004AAB4:
/* 8004AAB4 240200d6 */  li       $v0,214
/* 8004AAB8 03e00008 */  jr       $ra
/* 8004AABC a0820000 */  sb       $v0,0($a0)
.L8004AAC0:
/* 8004AAC0 240200dc */  li       $v0,220
/* 8004AAC4 03e00008 */  jr       $ra
/* 8004AAC8 a0820000 */  sb       $v0,0($a0)
.L8004AACC:
/* 8004AACC 24020045 */  li       $v0,69
.L8004AAD0:
/* 8004AAD0 03e00008 */  jr       $ra
/* 8004AAD4 a0820000 */  sb       $v0,0($a0)
.L8004AAD8:
/* 8004AAD8 24020041 */  li       $v0,65
/* 8004AADC 03e00008 */  jr       $ra
/* 8004AAE0 a0820000 */  sb       $v0,0($a0)
.L8004AAE4:
/* 8004AAE4 24020049 */  li       $v0,73
/* 8004AAE8 03e00008 */  jr       $ra
/* 8004AAEC a0820000 */  sb       $v0,0($a0)
.L8004AAF0:
/* 8004AAF0 2402004f */  li       $v0,79
/* 8004AAF4 03e00008 */  jr       $ra
/* 8004AAF8 a0820000 */  sb       $v0,0($a0)
.L8004AAFC:
/* 8004AAFC 24020055 */  li       $v0,85
/* 8004AB00 03e00008 */  jr       $ra
/* 8004AB04 a0820000 */  sb       $v0,0($a0)
.L8004AB08:
/* 8004AB08 240200d1 */  li       $v0,209
/* 8004AB0C 03e00008 */  jr       $ra
/* 8004AB10 a0820000 */  sb       $v0,0($a0)
.L8004AB14:
/* 8004AB14 240200c5 */  li       $v0,197
/* 8004AB18 03e00008 */  jr       $ra
/* 8004AB1C a0820000 */  sb       $v0,0($a0)
.L8004AB20:
/* 8004AB20 240200c0 */  li       $v0,192
/* 8004AB24 03e00008 */  jr       $ra
/* 8004AB28 a0820000 */  sb       $v0,0($a0)
.L8004AB2C:
/* 8004AB2C 3c028011 */  lui      $v0,0x8011
/* 8004AB30 904359e4 */  lbu      $v1,23012($v0)
/* 8004AB34 24020004 */  li       $v0,4
/* 8004AB38 1462ffe5 */  bne      $v1,$v0,.L8004AAD0
/* 8004AB3C 24020045 */  li       $v0,69
/* 8004AB40 240200c8 */  li       $v0,200
/* 8004AB44 03e00008 */  jr       $ra
/* 8004AB48 a0820000 */  sb       $v0,0($a0)
.L8004AB4C:
/* 8004AB4C 240200cc */  li       $v0,204
/* 8004AB50 03e00008 */  jr       $ra
/* 8004AB54 a0820000 */  sb       $v0,0($a0)
.L8004AB58:
/* 8004AB58 240200d2 */  li       $v0,210
/* 8004AB5C 03e00008 */  jr       $ra
/* 8004AB60 a0820000 */  sb       $v0,0($a0)
.L8004AB64:
/* 8004AB64 240200d9 */  li       $v0,217
/* 8004AB68 a0820000 */  sb       $v0,0($a0)
.L8004AB6C:
/* 8004AB6C 03e00008 */  jr       $ra
/* 8004AB70 00000000 */  nop      

.section .rodata
glabel jtbl_800124F0
.word .L8004AB20
.word .L8004AAD8
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AAA8
.word .L8004AB14
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AB2C
.word .L8004AACC
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AB4C
.word .L8004AAE4
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AB08
.word .L8004AB58
.word .L8004AAF0
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AAB4
.word .L8004AB6C
.word .L8004AB6C
.word .L8004AB64
.word .L8004AAFC
.word .L8004AB6C
.word .L8004AAC0
