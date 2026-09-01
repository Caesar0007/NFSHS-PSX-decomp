.set noat
.set noreorder

glabel func_800FA470
/* 800FA470 27bdffc8 */  addiu    $sp,$sp,-56
/* 800FA474 afb00028 */  sw       $s0,40($sp)
/* 800FA478 00008021 */  move     $s0,$zero
/* 800FA47C 24040001 */  li       $a0,1
/* 800FA480 afbf0034 */  sw       $ra,52($sp)
/* 800FA484 afb20030 */  sw       $s2,48($sp)
/* 800FA488 0c042699 */  jal      func_80109A64
/* 800FA48C afb1002c */  sw       $s1,44($sp)
/* 800FA490 00401821 */  move     $v1,$v0
/* 800FA494 24020005 */  li       $v0,5
/* 800FA498 10620015 */  beq      $v1,$v0,.L800FA4F0
/* 800FA49C 28620006 */  slti     $v0,$v1,6
/* 800FA4A0 10400005 */  beqz     $v0,.L800FA4B8
/* 800FA4A4 24020002 */  li       $v0,2
/* 800FA4A8 10620008 */  beq      $v1,$v0,.L800FA4CC
/* 800FA4AC 00000000 */  nop      
/* 800FA4B0 0803e954 */  j        .L800FA550
/* 800FA4B4 00000000 */  nop      
.L800FA4B8:
/* 800FA4B8 24020010 */  li       $v0,16
/* 800FA4BC 10620023 */  beq      $v1,$v0,.L800FA54C
/* 800FA4C0 3c028015 */  lui      $v0,0x8015
/* 800FA4C4 0803e954 */  j        .L800FA550
/* 800FA4C8 00000000 */  nop      
.L800FA4CC:
/* 800FA4CC 0c0426e8 */  jal      func_80109BA0
/* 800FA4D0 00000000 */  nop      
/* 800FA4D4 2442ffff */  addiu    $v0,$v0,-1
/* 800FA4D8 2c420002 */  sltiu    $v0,$v0,2
/* 800FA4DC 1040001c */  beqz     $v0,.L800FA550
/* 800FA4E0 3c028015 */  lui      $v0,0x8015
/* 800FA4E4 ac408044 */  sw       $zero,-32700($v0)
/* 800FA4E8 0803e954 */  j        .L800FA550
/* 800FA4EC 24100001 */  li       $s0,1
.L800FA4F0:
/* 800FA4F0 3c028015 */  lui      $v0,0x8015
/* 800FA4F4 2445802c */  addiu    $a1,$v0,-32724
/* 800FA4F8 8ca30018 */  lw       $v1,24($a1)
/* 800FA4FC 00000000 */  nop      
/* 800FA500 1460000a */  bnez     $v1,.L800FA52C
/* 800FA504 3c028014 */  lui      $v0,0x8014
/* 800FA508 3c028014 */  lui      $v0,0x8014
/* 800FA50C 3c038014 */  lui      $v1,0x8014
/* 800FA510 8c44efd0 */  lw       $a0,-4144($v0)
/* 800FA514 8c63efbc */  lw       $v1,-4164($v1)
/* 800FA518 00041080 */  sll      $v0,$a0,0x2
/* 800FA51C 00441021 */  addu     $v0,$v0,$a0
/* 800FA520 00621821 */  addu     $v1,$v1,$v0
/* 800FA524 0803e954 */  j        .L800FA550
/* 800FA528 aca30018 */  sw       $v1,24($a1)
.L800FA52C:
/* 800FA52C 8c42efbc */  lw       $v0,-4164($v0)
/* 800FA530 00000000 */  nop      
/* 800FA534 0043102a */  slt      $v0,$v0,$v1
/* 800FA538 14400005 */  bnez     $v0,.L800FA550
/* 800FA53C 00000000 */  nop      
/* 800FA540 aca00018 */  sw       $zero,24($a1)
/* 800FA544 0803e954 */  j        .L800FA550
/* 800FA548 24100001 */  li       $s0,1
.L800FA54C:
/* 800FA54C ac408044 */  sw       $zero,-32700($v0)
.L800FA550:
/* 800FA550 1200002c */  beqz     $s0,.L800FA604
/* 800FA554 3c048010 */  lui      $a0,0x8010
/* 800FA558 0c039de0 */  jal      func_800E7780
/* 800FA55C 2484a470 */  addiu    $a0,$a0,-23440
/* 800FA560 0c03e04d */  jal      func_800F8134
/* 800FA564 00002021 */  move     $a0,$zero
/* 800FA568 2404000e */  li       $a0,14
/* 800FA56C 27a50020 */  addiu    $a1,$sp,32
/* 800FA570 27a60010 */  addiu    $a2,$sp,16
/* 800FA574 240200a0 */  li       $v0,160
/* 800FA578 0c03e12b */  jal      func_800F84AC
/* 800FA57C a3a20020 */  sb       $v0,32($sp)
/* 800FA580 0c03cb29 */  jal      func_800F2CA4
/* 800FA584 24040003 */  li       $a0,3
/* 800FA588 0c03e068 */  jal      func_800F81A0
/* 800FA58C 3c118015 */  lui      $s1,0x8015
/* 800FA590 00002021 */  move     $a0,$zero
/* 800FA594 0c03e075 */  jal      func_800F81D4
/* 800FA598 00802821 */  move     $a1,$a0
/* 800FA59C 2632802c */  addiu    $s2,$s1,-32724
/* 800FA5A0 27b00018 */  addiu    $s0,$sp,24
/* 800FA5A4 8e44000c */  lw       $a0,12($s2)
/* 800FA5A8 0c03e19f */  jal      func_800F867C
/* 800FA5AC 02002821 */  move     $a1,$s0
/* 800FA5B0 2404001b */  li       $a0,27
/* 800FA5B4 02002821 */  move     $a1,$s0
/* 800FA5B8 0c03e08f */  jal      func_800F823C
/* 800FA5BC 27a60010 */  addiu    $a2,$sp,16
/* 800FA5C0 3c048010 */  lui      $a0,0x8010
/* 800FA5C4 0c03e08a */  jal      func_800F8228
/* 800FA5C8 2484a680 */  addiu    $a0,$a0,-22912
/* 800FA5CC 8e22802c */  lw       $v0,-32724($s1)
/* 800FA5D0 00000000 */  nop      
/* 800FA5D4 30420001 */  andi     $v0,$v0,0x1
/* 800FA5D8 1040000a */  beqz     $v0,.L800FA604
/* 800FA5DC 3c028014 */  lui      $v0,0x8014
/* 800FA5E0 3c048010 */  lui      $a0,0x8010
/* 800FA5E4 8c43efd0 */  lw       $v1,-4144($v0)
/* 800FA5E8 2484a620 */  addiu    $a0,$a0,-23008
/* 800FA5EC ae40001c */  sw       $zero,28($s2)
/* 800FA5F0 00031040 */  sll      $v0,$v1,0x1
/* 800FA5F4 00431021 */  addu     $v0,$v0,$v1
/* 800FA5F8 00021080 */  sll      $v0,$v0,0x2
/* 800FA5FC 0c03ae4c */  jal      func_800EB930
/* 800FA600 ae420018 */  sw       $v0,24($s2)
.L800FA604:
/* 800FA604 8fbf0034 */  lw       $ra,52($sp)
/* 800FA608 8fb20030 */  lw       $s2,48($sp)
/* 800FA60C 8fb1002c */  lw       $s1,44($sp)
/* 800FA610 8fb00028 */  lw       $s0,40($sp)
/* 800FA614 00001021 */  move     $v0,$zero
/* 800FA618 03e00008 */  jr       $ra
/* 800FA61C 27bd0038 */  addiu    $sp,$sp,56
