.set noat
.set noreorder

glabel func_800BEBC0
/* 800BEBC0 3c038012 */  lui      $v1,0x8012
/* 800BEBC4 2463ff44 */  addiu    $v1,$v1,-188
/* 800BEBC8 00041040 */  sll      $v0,$a0,0x1
/* 800BEBCC 00441021 */  addu     $v0,$v0,$a0
/* 800BEBD0 000210c0 */  sll      $v0,$v0,0x3
/* 800BEBD4 00441021 */  addu     $v0,$v0,$a0
/* 800BEBD8 000210c0 */  sll      $v0,$v0,0x3
/* 800BEBDC 00431021 */  addu     $v0,$v0,$v1
/* 800BEBE0 24a5fe60 */  addiu    $a1,$a1,-416
/* 800BEBE4 03e00008 */  jr       $ra
/* 800BEBE8 ac450004 */  sw       $a1,4($v0)
