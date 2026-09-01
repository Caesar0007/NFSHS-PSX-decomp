.set noat
.set noreorder

glabel func_800FA230
/* 800FA230 27bdffc8 */  addiu    $sp,$sp,-56
/* 800FA234 afb00028 */  sw       $s0,40($sp)
/* 800FA238 00008021 */  move     $s0,$zero
/* 800FA23C 24040001 */  li       $a0,1
/* 800FA240 afbf0034 */  sw       $ra,52($sp)
/* 800FA244 afb20030 */  sw       $s2,48($sp)
/* 800FA248 0c042609 */  jal      func_80109824
/* 800FA24C afb1002c */  sw       $s1,44($sp)
/* 800FA250 00401821 */  move     $v1,$v0
/* 800FA254 24020005 */  li       $v0,5
/* 800FA258 10620015 */  beq      $v1,$v0,.L800FA2B0
/* 800FA25C 28620006 */  slti     $v0,$v1,6
/* 800FA260 10400005 */  beqz     $v0,.L800FA278
/* 800FA264 24020002 */  li       $v0,2
/* 800FA268 10620008 */  beq      $v1,$v0,.L800FA28C
/* 800FA26C 00000000 */  nop      
/* 800FA270 0803e8c4 */  j        .L800FA310
/* 800FA274 00000000 */  nop      
.L800FA278:
/* 800FA278 24020010 */  li       $v0,16
/* 800FA27C 10620023 */  beq      $v1,$v0,.L800FA30C
/* 800FA280 3c028014 */  lui      $v0,0x8014
/* 800FA284 0803e8c4 */  j        .L800FA310
/* 800FA288 00000000 */  nop      
.L800FA28C:
/* 800FA28C 0c042658 */  jal      func_80109960
/* 800FA290 00000000 */  nop      
/* 800FA294 2442ffff */  addiu    $v0,$v0,-1
/* 800FA298 2c420002 */  sltiu    $v0,$v0,2
/* 800FA29C 1040001c */  beqz     $v0,.L800FA310
/* 800FA2A0 3c028014 */  lui      $v0,0x8014
/* 800FA2A4 ac407e04 */  sw       $zero,32260($v0)
/* 800FA2A8 0803e8c4 */  j        .L800FA310
/* 800FA2AC 24100001 */  li       $s0,1
.L800FA2B0:
/* 800FA2B0 3c028014 */  lui      $v0,0x8014
/* 800FA2B4 24457dec */  addiu    $a1,$v0,32236
/* 800FA2B8 8ca30018 */  lw       $v1,24($a1)
/* 800FA2BC 00000000 */  nop      
/* 800FA2C0 1460000a */  bnez     $v1,.L800FA2EC
/* 800FA2C4 3c028014 */  lui      $v0,0x8014
/* 800FA2C8 3c028014 */  lui      $v0,0x8014
/* 800FA2CC 3c038014 */  lui      $v1,0x8014
/* 800FA2D0 8c44ed90 */  lw       $a0,-4720($v0)
/* 800FA2D4 8c63ed7c */  lw       $v1,-4740($v1)
/* 800FA2D8 00041080 */  sll      $v0,$a0,0x2
/* 800FA2DC 00441021 */  addu     $v0,$v0,$a0
/* 800FA2E0 00621821 */  addu     $v1,$v1,$v0
/* 800FA2E4 0803e8c4 */  j        .L800FA310
/* 800FA2E8 aca30018 */  sw       $v1,24($a1)
.L800FA2EC:
/* 800FA2EC 8c42ed7c */  lw       $v0,-4740($v0)
/* 800FA2F0 00000000 */  nop      
/* 800FA2F4 0043102a */  slt      $v0,$v0,$v1
/* 800FA2F8 14400005 */  bnez     $v0,.L800FA310
/* 800FA2FC 00000000 */  nop      
/* 800FA300 aca00018 */  sw       $zero,24($a1)
/* 800FA304 0803e8c4 */  j        .L800FA310
/* 800FA308 24100001 */  li       $s0,1
.L800FA30C:
/* 800FA30C ac407e04 */  sw       $zero,32260($v0)
.L800FA310:
/* 800FA310 1200002c */  beqz     $s0,.L800FA3C4
/* 800FA314 3c048010 */  lui      $a0,0x8010
/* 800FA318 0c039d60 */  jal      func_800E7580
/* 800FA31C 2484a230 */  addiu    $a0,$a0,-24016
/* 800FA320 0c03dfbd */  jal      func_800F7EF4
/* 800FA324 00002021 */  move     $a0,$zero
/* 800FA328 2404000e */  li       $a0,14
/* 800FA32C 27a50020 */  addiu    $a1,$sp,32
/* 800FA330 27a60010 */  addiu    $a2,$sp,16
/* 800FA334 240200a0 */  li       $v0,160
/* 800FA338 0c03e09b */  jal      func_800F826C
/* 800FA33C a3a20020 */  sb       $v0,32($sp)
/* 800FA340 0c03ca99 */  jal      func_800F2A64
/* 800FA344 24040003 */  li       $a0,3
/* 800FA348 0c03dfd8 */  jal      func_800F7F60
/* 800FA34C 3c118014 */  lui      $s1,0x8014
/* 800FA350 00002021 */  move     $a0,$zero
/* 800FA354 0c03dfe5 */  jal      func_800F7F94
/* 800FA358 00802821 */  move     $a1,$a0
/* 800FA35C 26327dec */  addiu    $s2,$s1,32236
/* 800FA360 27b00018 */  addiu    $s0,$sp,24
/* 800FA364 8e44000c */  lw       $a0,12($s2)
/* 800FA368 0c03e10f */  jal      func_800F843C
/* 800FA36C 02002821 */  move     $a1,$s0
/* 800FA370 2404001b */  li       $a0,27
/* 800FA374 02002821 */  move     $a1,$s0
/* 800FA378 0c03dfff */  jal      func_800F7FFC
/* 800FA37C 27a60010 */  addiu    $a2,$sp,16
/* 800FA380 3c048010 */  lui      $a0,0x8010
/* 800FA384 0c03dffa */  jal      func_800F7FE8
/* 800FA388 2484a440 */  addiu    $a0,$a0,-23488
/* 800FA38C 8e227dec */  lw       $v0,32236($s1)
/* 800FA390 00000000 */  nop      
/* 800FA394 30420001 */  andi     $v0,$v0,0x1
/* 800FA398 1040000a */  beqz     $v0,.L800FA3C4
/* 800FA39C 3c028014 */  lui      $v0,0x8014
/* 800FA3A0 3c048010 */  lui      $a0,0x8010
/* 800FA3A4 8c43ed90 */  lw       $v1,-4720($v0)
/* 800FA3A8 2484a3e0 */  addiu    $a0,$a0,-23584
/* 800FA3AC ae40001c */  sw       $zero,28($s2)
/* 800FA3B0 00031040 */  sll      $v0,$v1,0x1
/* 800FA3B4 00431021 */  addu     $v0,$v0,$v1
/* 800FA3B8 00021080 */  sll      $v0,$v0,0x2
/* 800FA3BC 0c03adcc */  jal      func_800EB730
/* 800FA3C0 ae420018 */  sw       $v0,24($s2)
.L800FA3C4:
/* 800FA3C4 8fbf0034 */  lw       $ra,52($sp)
/* 800FA3C8 8fb20030 */  lw       $s2,48($sp)
/* 800FA3CC 8fb1002c */  lw       $s1,44($sp)
/* 800FA3D0 8fb00028 */  lw       $s0,40($sp)
/* 800FA3D4 00001021 */  move     $v0,$zero
/* 800FA3D8 03e00008 */  jr       $ra
/* 800FA3DC 27bd0038 */  addiu    $sp,$sp,56
