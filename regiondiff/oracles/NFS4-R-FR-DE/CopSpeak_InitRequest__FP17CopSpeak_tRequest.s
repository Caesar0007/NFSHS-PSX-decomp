.set noat
.set noreorder

glabel func_8009A0D4
/* 8009A0D4 2403ffff */  li       $v1,-1
/* 8009A0D8 24020002 */  li       $v0,2
/* 8009A0DC ac800000 */  sw       $zero,0($a0)
/* 8009A0E0 ac830004 */  sw       $v1,4($a0)
/* 8009A0E4 ac830018 */  sw       $v1,24($a0)
/* 8009A0E8 ac800008 */  sw       $zero,8($a0)
/* 8009A0EC ac80000c */  sw       $zero,12($a0)
/* 8009A0F0 a080001c */  sb       $zero,28($a0)
/* 8009A0F4 a080001d */  sb       $zero,29($a0)
/* 8009A0F8 a082001e */  sb       $v0,30($a0)
/* 8009A0FC a080001f */  sb       $zero,31($a0)
/* 8009A100 03e00008 */  jr       $ra
/* 8009A104 ac830014 */  sw       $v1,20($a0)
