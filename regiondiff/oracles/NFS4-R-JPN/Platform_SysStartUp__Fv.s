.set noat
.set noreorder

glabel func_800DCD60
/* 800DCD60 27bdffd8 */  addiu    $sp,$sp,-40
/* 800DCD64 3c05801f */  lui      $a1,0x801f
/* 800DCD68 34a5c000 */  ori      $a1,$a1,0xc000
/* 800DCD6C 3c048015 */  lui      $a0,0x8015
/* 800DCD70 24849c34 */  addiu    $a0,$a0,-25548
/* 800DCD74 00a42823 */  subu     $a1,$a1,$a0
/* 800DCD78 afbf0024 */  sw       $ra,36($sp)
/* 800DCD7C afb00020 */  sw       $s0,32($sp)
/* 800DCD80 3c018014 */  lui      $at,0x8014
/* 800DCD84 ac20ed24 */  sw       $zero,-4828($at)
/* 800DCD88 3c018014 */  lui      $at,0x8014
/* 800DCD8C ac25e37c */  sw       $a1,-7300($at)
/* 800DCD90 0c03d232 */  jal      func_800F48C8
/* 800DCD94 00000000 */  nop      
/* 800DCD98 0c037394 */  jal      func_800DCE50
/* 800DCD9C 00000000 */  nop      
/* 800DCDA0 24040200 */  li       $a0,512
/* 800DCDA4 240500f0 */  li       $a1,240
/* 800DCDA8 24060001 */  li       $a2,1
/* 800DCDAC 00c08021 */  move     $s0,$a2
/* 800DCDB0 00003821 */  move     $a3,$zero
/* 800DCDB4 afb00010 */  sw       $s0,16($sp)
/* 800DCDB8 afa00014 */  sw       $zero,20($sp)
/* 800DCDBC afa00018 */  sw       $zero,24($sp)
/* 800DCDC0 0c02fc3b */  jal      func_800BF0EC
/* 800DCDC4 afa0001c */  sw       $zero,28($sp)
/* 800DCDC8 00002021 */  move     $a0,$zero
/* 800DCDCC 24050001 */  li       $a1,1
/* 800DCDD0 0c03c445 */  jal      func_800F1114
/* 800DCDD4 00a03021 */  move     $a2,$a1
/* 800DCDD8 3c048014 */  lui      $a0,0x8014
/* 800DCDDC 0c03d085 */  jal      func_800F4214
/* 800DCDE0 2484eb6c */  addiu    $a0,$a0,-5268
/* 800DCDE4 00002021 */  move     $a0,$zero
/* 800DCDE8 240503e8 */  li       $a1,1000
/* 800DCDEC 0c03c445 */  jal      func_800F1114
/* 800DCDF0 24060001 */  li       $a2,1
/* 800DCDF4 00002021 */  move     $a0,$zero
/* 800DCDF8 240503e8 */  li       $a1,1000
/* 800DCDFC 0c03c445 */  jal      func_800F1114
/* 800DCE00 24060001 */  li       $a2,1
/* 800DCE04 af901540 */  sw       $s0,5440($gp)
/* 800DCE08 0c03d24e */  jal      func_800F4938
/* 800DCE0C 24040080 */  li       $a0,128
/* 800DCE10 3c02800e */  lui      $v0,0x800e
/* 800DCE14 2442cc98 */  addiu    $v0,$v0,-13160
/* 800DCE18 3c018014 */  lui      $at,0x8014
/* 800DCE1C ac22ee30 */  sw       $v0,-4560($at)
/* 800DCE20 0c029eaa */  jal      func_800A7AA8
/* 800DCE24 00000000 */  nop      
/* 800DCE28 2404001e */  li       $a0,30
/* 800DCE2C 24052000 */  li       $a1,8192
/* 800DCE30 0c03c734 */  jal      func_800F1CD0
/* 800DCE34 00003021 */  move     $a2,$zero
/* 800DCE38 8fbf0024 */  lw       $ra,36($sp)
/* 800DCE3C 8fb00020 */  lw       $s0,32($sp)
/* 800DCE40 03e00008 */  jr       $ra
/* 800DCE44 27bd0028 */  addiu    $sp,$sp,40
