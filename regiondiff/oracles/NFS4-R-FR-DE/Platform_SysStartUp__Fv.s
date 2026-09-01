.set noat
.set noreorder

glabel func_800DCFA0
/* 800DCFA0 27bdffd8 */  addiu    $sp,$sp,-40
/* 800DCFA4 3c05801f */  lui      $a1,0x801f
/* 800DCFA8 34a5c000 */  ori      $a1,$a1,0xc000
/* 800DCFAC 3c048015 */  lui      $a0,0x8015
/* 800DCFB0 24849e74 */  addiu    $a0,$a0,-24972
/* 800DCFB4 00a42823 */  subu     $a1,$a1,$a0
/* 800DCFB8 afbf0024 */  sw       $ra,36($sp)
/* 800DCFBC afb00020 */  sw       $s0,32($sp)
/* 800DCFC0 3c018014 */  lui      $at,0x8014
/* 800DCFC4 ac20ef64 */  sw       $zero,-4252($at)
/* 800DCFC8 3c018014 */  lui      $at,0x8014
/* 800DCFCC ac25e5bc */  sw       $a1,-6724($at)
/* 800DCFD0 0c03d2c2 */  jal      func_800F4B08
/* 800DCFD4 00000000 */  nop      
/* 800DCFD8 0c037424 */  jal      func_800DD090
/* 800DCFDC 00000000 */  nop      
/* 800DCFE0 24040200 */  li       $a0,512
/* 800DCFE4 24050100 */  li       $a1,256
/* 800DCFE8 24060001 */  li       $a2,1
/* 800DCFEC 00c08021 */  move     $s0,$a2
/* 800DCFF0 00003821 */  move     $a3,$zero
/* 800DCFF4 afb00010 */  sw       $s0,16($sp)
/* 800DCFF8 afa00014 */  sw       $zero,20($sp)
/* 800DCFFC afa00018 */  sw       $zero,24($sp)
/* 800DD000 0c02fcc5 */  jal      func_800BF314
/* 800DD004 afa0001c */  sw       $zero,28($sp)
/* 800DD008 00002021 */  move     $a0,$zero
/* 800DD00C 24050001 */  li       $a1,1
/* 800DD010 0c03c4d5 */  jal      func_800F1354
/* 800DD014 00a03021 */  move     $a2,$a1
/* 800DD018 3c048014 */  lui      $a0,0x8014
/* 800DD01C 0c03d115 */  jal      func_800F4454
/* 800DD020 2484edac */  addiu    $a0,$a0,-4692
/* 800DD024 00002021 */  move     $a0,$zero
/* 800DD028 240503e8 */  li       $a1,1000
/* 800DD02C 0c03c4d5 */  jal      func_800F1354
/* 800DD030 24060001 */  li       $a2,1
/* 800DD034 00002021 */  move     $a0,$zero
/* 800DD038 240503e8 */  li       $a1,1000
/* 800DD03C 0c03c4d5 */  jal      func_800F1354
/* 800DD040 24060001 */  li       $a2,1
/* 800DD044 af901540 */  sw       $s0,5440($gp)
/* 800DD048 0c03d2de */  jal      func_800F4B78
/* 800DD04C 24040080 */  li       $a0,128
/* 800DD050 3c02800e */  lui      $v0,0x800e
/* 800DD054 2442ced8 */  addiu    $v0,$v0,-12584
/* 800DD058 3c018014 */  lui      $at,0x8014
/* 800DD05C ac22f070 */  sw       $v0,-3984($at)
/* 800DD060 0c029eab */  jal      func_800A7AAC
/* 800DD064 00000000 */  nop      
/* 800DD068 2404001e */  li       $a0,30
/* 800DD06C 24052000 */  li       $a1,8192
/* 800DD070 0c03c7c4 */  jal      func_800F1F10
/* 800DD074 00003021 */  move     $a2,$zero
/* 800DD078 8fbf0024 */  lw       $ra,36($sp)
/* 800DD07C 8fb00020 */  lw       $s0,32($sp)
/* 800DD080 03e00008 */  jr       $ra
/* 800DD084 27bd0028 */  addiu    $sp,$sp,40
