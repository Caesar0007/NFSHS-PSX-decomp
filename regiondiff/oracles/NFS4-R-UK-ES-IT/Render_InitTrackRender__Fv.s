.set noat
.set noreorder

glabel func_800B43C8
/* 800B43C8 27bdffe0 */  addiu    $sp,$sp,-32
/* 800B43CC 3c028011 */  lui      $v0,0x8011
/* 800B43D0 244244d0 */  addiu    $v0,$v0,17616
/* 800B43D4 afbf0018 */  sw       $ra,24($sp)
/* 800B43D8 8c440048 */  lw       $a0,72($v0)
/* 800B43DC 8c450054 */  lw       $a1,84($v0)
/* 800B43E0 0c038941 */  jal      func_800E2504
/* 800B43E4 00000000 */  nop      
/* 800B43E8 0c02cfac */  jal      func_800B3EB0
/* 800B43EC 00000000 */  nop      
/* 800B43F0 24040140 */  li       $a0,320
/* 800B43F4 24050100 */  li       $a1,256
/* 800B43F8 00801021 */  move     $v0,$a0
/* 800B43FC afa20010 */  sw       $v0,16($sp)
/* 800B4400 00a01021 */  move     $v0,$a1
/* 800B4404 00003021 */  move     $a2,$zero
/* 800B4408 00a03821 */  move     $a3,$a1
/* 800B440C 0c02fcdc */  jal      func_800BF370
/* 800B4410 afa20014 */  sw       $v0,20($sp)
/* 800B4414 0c02fdb2 */  jal      func_800BF6C8
/* 800B4418 00000000 */  nop      
/* 800B441C 0c03843c */  jal      func_800E10F0
/* 800B4420 00000000 */  nop      
/* 800B4424 0c026fa2 */  jal      func_8009BE88
/* 800B4428 00000000 */  nop      
/* 800B442C 0c02e2eb */  jal      func_800B8BAC
/* 800B4430 00000000 */  nop      
/* 800B4434 0c03804f */  jal      func_800E013C
/* 800B4438 00000000 */  nop      
/* 800B443C 0c02f1b6 */  jal      func_800BC6D8
/* 800B4440 00000000 */  nop      
/* 800B4444 0c026e3b */  jal      func_8009B8EC
/* 800B4448 00000000 */  nop      
/* 800B444C 0c036f86 */  jal      func_800DBE18
/* 800B4450 24040003 */  li       $a0,3
/* 800B4454 0c038719 */  jal      func_800E1C64
/* 800B4458 00000000 */  nop      
/* 800B445C 3c04800b */  lui      $a0,0x800b
/* 800B4460 0c02fc3a */  jal      func_800BF0E8
/* 800B4464 248442bc */  addiu    $a0,$a0,17084
/* 800B4468 0c02d1b6 */  jal      func_800B46D8
/* 800B446C 00000000 */  nop      
/* 800B4470 8fbf0018 */  lw       $ra,24($sp)
/* 800B4474 00000000 */  nop      
/* 800B4478 03e00008 */  jr       $ra
/* 800B447C 27bd0020 */  addiu    $sp,$sp,32
