.set noat
.set noreorder

glabel func_800BE9AC
/* 800BE9AC 3c038012 */  lui      $v1,0x8012
/* 800BE9B0 2463fd30 */  addiu    $v1,$v1,-720
/* 800BE9B4 00041040 */  sll      $v0,$a0,0x1
/* 800BE9B8 00441021 */  addu     $v0,$v0,$a0
/* 800BE9BC 000210c0 */  sll      $v0,$v0,0x3
/* 800BE9C0 00441021 */  addu     $v0,$v0,$a0
/* 800BE9C4 000210c0 */  sll      $v0,$v0,0x3
/* 800BE9C8 00431021 */  addu     $v0,$v0,$v1
/* 800BE9CC 24a5fe60 */  addiu    $a1,$a1,-416
/* 800BE9D0 03e00008 */  jr       $ra
/* 800BE9D4 ac450004 */  sw       $a1,4($v0)
