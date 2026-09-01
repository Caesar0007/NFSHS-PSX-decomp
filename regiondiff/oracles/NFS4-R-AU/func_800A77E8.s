.set noat
.set noreorder

glabel func_800A77E8
/* 800A77E8 8f830d84 */  lw       $v1,3460($gp)
/* 800A77EC 00000000 */  nop      
/* 800A77F0 24620001 */  addiu    $v0,$v1,1
/* 800A77F4 af820d84 */  sw       $v0,3460($gp)
/* 800A77F8 00031040 */  sll      $v0,$v1,0x1
/* 800A77FC 00431021 */  addu     $v0,$v0,$v1
/* 800A7800 8f830d80 */  lw       $v1,3456($gp)
/* 800A7804 00021100 */  sll      $v0,$v0,0x4
/* 800A7808 03e00008 */  jr       $ra
/* 800A780C 00621021 */  addu     $v0,$v1,$v0
