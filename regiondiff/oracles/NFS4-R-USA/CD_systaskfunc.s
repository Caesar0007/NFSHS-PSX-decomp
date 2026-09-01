.set noat
.set noreorder

glabel func_800FA444
/* 800FA444 27bdffc8 */  addiu    $sp,$sp,-56
/* 800FA448 afb00028 */  sw       $s0,40($sp)
/* 800FA44C 00008021 */  move     $s0,$zero
/* 800FA450 24040001 */  li       $a0,1
/* 800FA454 afbf0034 */  sw       $ra,52($sp)
/* 800FA458 afb20030 */  sw       $s2,48($sp)
/* 800FA45C 0c04268e */  jal      func_80109A38
/* 800FA460 afb1002c */  sw       $s1,44($sp)
/* 800FA464 00401821 */  move     $v1,$v0
/* 800FA468 24020005 */  li       $v0,5
/* 800FA46C 10620015 */  beq      $v1,$v0,.L800FA4C4
/* 800FA470 28620006 */  slti     $v0,$v1,6
/* 800FA474 10400005 */  beqz     $v0,.L800FA48C
/* 800FA478 24020002 */  li       $v0,2
/* 800FA47C 10620008 */  beq      $v1,$v0,.L800FA4A0
/* 800FA480 00000000 */  nop      
/* 800FA484 0803e949 */  j        .L800FA524
/* 800FA488 00000000 */  nop      
.L800FA48C:
/* 800FA48C 24020010 */  li       $v0,16
/* 800FA490 10620023 */  beq      $v1,$v0,.L800FA520
/* 800FA494 3c028015 */  lui      $v0,0x8015
/* 800FA498 0803e949 */  j        .L800FA524
/* 800FA49C 00000000 */  nop      
.L800FA4A0:
/* 800FA4A0 0c0426dd */  jal      func_80109B74
/* 800FA4A4 00000000 */  nop      
/* 800FA4A8 2442ffff */  addiu    $v0,$v0,-1
/* 800FA4AC 2c420002 */  sltiu    $v0,$v0,2
/* 800FA4B0 1040001c */  beqz     $v0,.L800FA524
/* 800FA4B4 3c028015 */  lui      $v0,0x8015
/* 800FA4B8 ac408018 */  sw       $zero,-32744($v0)
/* 800FA4BC 0803e949 */  j        .L800FA524
/* 800FA4C0 24100001 */  li       $s0,1
.L800FA4C4:
/* 800FA4C4 3c028015 */  lui      $v0,0x8015
/* 800FA4C8 24458000 */  addiu    $a1,$v0,-32768
/* 800FA4CC 8ca30018 */  lw       $v1,24($a1)
/* 800FA4D0 00000000 */  nop      
/* 800FA4D4 1460000a */  bnez     $v1,.L800FA500
/* 800FA4D8 3c028014 */  lui      $v0,0x8014
/* 800FA4DC 3c028014 */  lui      $v0,0x8014
/* 800FA4E0 3c038014 */  lui      $v1,0x8014
/* 800FA4E4 8c44efa4 */  lw       $a0,-4188($v0)
/* 800FA4E8 8c63ef90 */  lw       $v1,-4208($v1)
/* 800FA4EC 00041080 */  sll      $v0,$a0,0x2
/* 800FA4F0 00441021 */  addu     $v0,$v0,$a0
/* 800FA4F4 00621821 */  addu     $v1,$v1,$v0
/* 800FA4F8 0803e949 */  j        .L800FA524
/* 800FA4FC aca30018 */  sw       $v1,24($a1)
.L800FA500:
/* 800FA500 8c42ef90 */  lw       $v0,-4208($v0)
/* 800FA504 00000000 */  nop      
/* 800FA508 0043102a */  slt      $v0,$v0,$v1
/* 800FA50C 14400005 */  bnez     $v0,.L800FA524
/* 800FA510 00000000 */  nop      
/* 800FA514 aca00018 */  sw       $zero,24($a1)
/* 800FA518 0803e949 */  j        .L800FA524
/* 800FA51C 24100001 */  li       $s0,1
.L800FA520:
/* 800FA520 ac408018 */  sw       $zero,-32744($v0)
.L800FA524:
/* 800FA524 1200002c */  beqz     $s0,.L800FA5D8
/* 800FA528 3c048010 */  lui      $a0,0x8010
/* 800FA52C 0c039de5 */  jal      func_800E7794
/* 800FA530 2484a444 */  addiu    $a0,$a0,-23484
/* 800FA534 0c03e042 */  jal      func_800F8108
/* 800FA538 00002021 */  move     $a0,$zero
/* 800FA53C 2404000e */  li       $a0,14
/* 800FA540 27a50020 */  addiu    $a1,$sp,32
/* 800FA544 27a60010 */  addiu    $a2,$sp,16
/* 800FA548 240200a0 */  li       $v0,160
/* 800FA54C 0c03e120 */  jal      func_800F8480
/* 800FA550 a3a20020 */  sb       $v0,32($sp)
/* 800FA554 0c03cb1e */  jal      func_800F2C78
/* 800FA558 24040003 */  li       $a0,3
/* 800FA55C 0c03e05d */  jal      func_800F8174
/* 800FA560 3c118015 */  lui      $s1,0x8015
/* 800FA564 00002021 */  move     $a0,$zero
/* 800FA568 0c03e06a */  jal      func_800F81A8
/* 800FA56C 00802821 */  move     $a1,$a0
/* 800FA570 26328000 */  addiu    $s2,$s1,-32768
/* 800FA574 27b00018 */  addiu    $s0,$sp,24
/* 800FA578 8e44000c */  lw       $a0,12($s2)
/* 800FA57C 0c03e194 */  jal      func_800F8650
/* 800FA580 02002821 */  move     $a1,$s0
/* 800FA584 2404001b */  li       $a0,27
/* 800FA588 02002821 */  move     $a1,$s0
/* 800FA58C 0c03e084 */  jal      func_800F8210
/* 800FA590 27a60010 */  addiu    $a2,$sp,16
/* 800FA594 3c048010 */  lui      $a0,0x8010
/* 800FA598 0c03e07f */  jal      func_800F81FC
/* 800FA59C 2484a654 */  addiu    $a0,$a0,-22956
/* 800FA5A0 8e228000 */  lw       $v0,-32768($s1)
/* 800FA5A4 00000000 */  nop      
/* 800FA5A8 30420001 */  andi     $v0,$v0,0x1
/* 800FA5AC 1040000a */  beqz     $v0,.L800FA5D8
/* 800FA5B0 3c028014 */  lui      $v0,0x8014
/* 800FA5B4 3c048010 */  lui      $a0,0x8010
/* 800FA5B8 8c43efa4 */  lw       $v1,-4188($v0)
/* 800FA5BC 2484a5f4 */  addiu    $a0,$a0,-23052
/* 800FA5C0 ae40001c */  sw       $zero,28($s2)
/* 800FA5C4 00031040 */  sll      $v0,$v1,0x1
/* 800FA5C8 00431021 */  addu     $v0,$v0,$v1
/* 800FA5CC 00021080 */  sll      $v0,$v0,0x2
/* 800FA5D0 0c03ae51 */  jal      func_800EB944
/* 800FA5D4 ae420018 */  sw       $v0,24($s2)
.L800FA5D8:
/* 800FA5D8 8fbf0034 */  lw       $ra,52($sp)
/* 800FA5DC 8fb20030 */  lw       $s2,48($sp)
/* 800FA5E0 8fb1002c */  lw       $s1,44($sp)
/* 800FA5E4 8fb00028 */  lw       $s0,40($sp)
/* 800FA5E8 00001021 */  move     $v0,$zero
/* 800FA5EC 03e00008 */  jr       $ra
/* 800FA5F0 27bd0038 */  addiu    $sp,$sp,56
