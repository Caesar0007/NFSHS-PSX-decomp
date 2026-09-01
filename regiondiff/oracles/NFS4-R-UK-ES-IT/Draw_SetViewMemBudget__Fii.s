.set noat
.set noreorder

glabel func_800BEBC4
/* 800BEBC4 3c038012 */  lui      $v1,0x8012
/* 800BEBC8 2463ff70 */  addiu    $v1,$v1,-144
/* 800BEBCC 00041040 */  sll      $v0,$a0,0x1
/* 800BEBD0 00441021 */  addu     $v0,$v0,$a0
/* 800BEBD4 000210c0 */  sll      $v0,$v0,0x3
/* 800BEBD8 00441021 */  addu     $v0,$v0,$a0
/* 800BEBDC 000210c0 */  sll      $v0,$v0,0x3
/* 800BEBE0 00431021 */  addu     $v0,$v0,$v1
/* 800BEBE4 24a5fe60 */  addiu    $a1,$a1,-416
/* 800BEBE8 03e00008 */  jr       $ra
/* 800BEBEC ac450004 */  sw       $a1,4($v0)
