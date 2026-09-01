.set noat
.set noreorder

glabel func_800DCF74
/* 800DCF74 27bdffd8 */  addiu    $sp,$sp,-40
/* 800DCF78 3c05801f */  lui      $a1,0x801f
/* 800DCF7C 34a5c000 */  ori      $a1,$a1,0xc000
/* 800DCF80 3c048015 */  lui      $a0,0x8015
/* 800DCF84 24849e48 */  addiu    $a0,$a0,-25016
/* 800DCF88 00a42823 */  subu     $a1,$a1,$a0
/* 800DCF8C afbf0024 */  sw       $ra,36($sp)
/* 800DCF90 afb00020 */  sw       $s0,32($sp)
/* 800DCF94 3c018014 */  lui      $at,0x8014
/* 800DCF98 ac20ef38 */  sw       $zero,-4296($at)
/* 800DCF9C 3c018014 */  lui      $at,0x8014
/* 800DCFA0 ac25e590 */  sw       $a1,-6768($at)
/* 800DCFA4 0c03d2b7 */  jal      func_800F4ADC
/* 800DCFA8 00000000 */  nop      
/* 800DCFAC 0c037419 */  jal      func_800DD064
/* 800DCFB0 00000000 */  nop      
/* 800DCFB4 24040200 */  li       $a0,512
/* 800DCFB8 240500f0 */  li       $a1,240
/* 800DCFBC 24060001 */  li       $a2,1
/* 800DCFC0 00c08021 */  move     $s0,$a2
/* 800DCFC4 00003821 */  move     $a3,$zero
/* 800DCFC8 afb00010 */  sw       $s0,16($sp)
/* 800DCFCC afa00014 */  sw       $zero,20($sp)
/* 800DCFD0 afa00018 */  sw       $zero,24($sp)
/* 800DCFD4 0c02fcc0 */  jal      func_800BF300
/* 800DCFD8 afa0001c */  sw       $zero,28($sp)
/* 800DCFDC 00002021 */  move     $a0,$zero
/* 800DCFE0 24050001 */  li       $a1,1
/* 800DCFE4 0c03c4ca */  jal      func_800F1328
/* 800DCFE8 00a03021 */  move     $a2,$a1
/* 800DCFEC 3c048014 */  lui      $a0,0x8014
/* 800DCFF0 0c03d10a */  jal      func_800F4428
/* 800DCFF4 2484ed80 */  addiu    $a0,$a0,-4736
/* 800DCFF8 00002021 */  move     $a0,$zero
/* 800DCFFC 240503e8 */  li       $a1,1000
/* 800DD000 0c03c4ca */  jal      func_800F1328
/* 800DD004 24060001 */  li       $a2,1
/* 800DD008 00002021 */  move     $a0,$zero
/* 800DD00C 240503e8 */  li       $a1,1000
/* 800DD010 0c03c4ca */  jal      func_800F1328
/* 800DD014 24060001 */  li       $a2,1
/* 800DD018 af901540 */  sw       $s0,5440($gp)
/* 800DD01C 0c03d2d3 */  jal      func_800F4B4C
/* 800DD020 24040080 */  li       $a0,128
/* 800DD024 3c02800e */  lui      $v0,0x800e
/* 800DD028 2442ceac */  addiu    $v0,$v0,-12628
/* 800DD02C 3c018014 */  lui      $at,0x8014
/* 800DD030 ac22f044 */  sw       $v0,-4028($at)
/* 800DD034 0c029eaa */  jal      func_800A7AA8
/* 800DD038 00000000 */  nop      
/* 800DD03C 2404001e */  li       $a0,30
/* 800DD040 24052000 */  li       $a1,8192
/* 800DD044 0c03c7b9 */  jal      func_800F1EE4
/* 800DD048 00003021 */  move     $a2,$zero
/* 800DD04C 8fbf0024 */  lw       $ra,36($sp)
/* 800DD050 8fb00020 */  lw       $s0,32($sp)
/* 800DD054 03e00008 */  jr       $ra
/* 800DD058 27bd0028 */  addiu    $sp,$sp,40
