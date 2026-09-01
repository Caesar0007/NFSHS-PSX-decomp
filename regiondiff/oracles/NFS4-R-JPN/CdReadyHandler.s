.set noat
.set noreorder

glabel func_800FA440
/* 800FA440 27bdfea0 */  addiu    $sp,$sp,-352
/* 800FA444 afb30154 */  sw       $s3,340($sp)
/* 800FA448 00a09821 */  move     $s3,$a1
/* 800FA44C afb1014c */  sw       $s1,332($sp)
/* 800FA450 00808821 */  move     $s1,$a0
/* 800FA454 00002021 */  move     $a0,$zero
/* 800FA458 3c028014 */  lui      $v0,0x8014
/* 800FA45C afb00148 */  sw       $s0,328($sp)
/* 800FA460 24507e0c */  addiu    $s0,$v0,32268
/* 800FA464 afbf0158 */  sw       $ra,344($sp)
/* 800FA468 0c03dffa */  jal      func_800F7FE8
/* 800FA46C afb20150 */  sw       $s2,336($sp)
/* 800FA470 92620000 */  lbu      $v0,0($s3)
/* 800FA474 00000000 */  nop      
/* 800FA478 30420010 */  andi     $v0,$v0,0x10
/* 800FA47C 1040000b */  beqz     $v0,.L800FA4AC
/* 800FA480 00009021 */  move     $s2,$zero
/* 800FA484 3c048010 */  lui      $a0,0x8010
/* 800FA488 0c03ade4 */  jal      func_800EB790
/* 800FA48C 2484a3e0 */  addiu    $a0,$a0,-23584
/* 800FA490 3c048010 */  lui      $a0,0x8010
/* 800FA494 2484a230 */  addiu    $a0,$a0,-24016
/* 800FA498 02402821 */  move     $a1,$s2
/* 800FA49C 0c039d33 */  jal      func_800E74CC
/* 800FA4A0 02403021 */  move     $a2,$s2
/* 800FA4A4 0803ea35 */  j        .L800FA8D4
/* 800FA4A8 00000000 */  nop      
.L800FA4AC:
/* 800FA4AC 322400ff */  andi     $a0,$s1,0xff
/* 800FA4B0 24020002 */  li       $v0,2
/* 800FA4B4 1082000c */  beq      $a0,$v0,.L800FA4E8
/* 800FA4B8 28820003 */  slti     $v0,$a0,3
/* 800FA4BC 10400005 */  beqz     $v0,.L800FA4D4
/* 800FA4C0 24020001 */  li       $v0,1
/* 800FA4C4 10820010 */  beq      $a0,$v0,.L800FA508
/* 800FA4C8 3c048014 */  lui      $a0,0x8014
/* 800FA4CC 0803e9f3 */  j        .L800FA7CC
/* 800FA4D0 24917dec */  addiu    $s1,$a0,32236
.L800FA4D4:
/* 800FA4D4 24020005 */  li       $v0,5
/* 800FA4D8 108200a0 */  beq      $a0,$v0,.L800FA75C
/* 800FA4DC 3c048014 */  lui      $a0,0x8014
/* 800FA4E0 0803e9f3 */  j        .L800FA7CC
/* 800FA4E4 24917dec */  addiu    $s1,$a0,32236
.L800FA4E8:
/* 800FA4E8 2604ffe0 */  addiu    $a0,$s0,-32
/* 800FA4EC 8c83001c */  lw       $v1,28($a0)
/* 800FA4F0 2402ffff */  li       $v0,-1
/* 800FA4F4 146200b3 */  bne      $v1,$v0,.L800FA7C4
/* 800FA4F8 00000000 */  nop      
/* 800FA4FC 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA500 0803e9ee */  j        .L800FA7B8
/* 800FA504 ac80001c */  sw       $zero,28($a0)
.L800FA508:
/* 800FA508 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA50C 00000000 */  nop      
/* 800FA510 30420001 */  andi     $v0,$v0,0x1
/* 800FA514 1040006e */  beqz     $v0,.L800FA6D0
/* 800FA518 00000000 */  nop      
/* 800FA51C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA520 00000000 */  nop      
/* 800FA524 30420004 */  andi     $v0,$v0,0x4
/* 800FA528 10400008 */  beqz     $v0,.L800FA54C
/* 800FA52C 00000000 */  nop      
/* 800FA530 24120001 */  li       $s2,1
/* 800FA534 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA538 2403fffb */  li       $v1,-5
/* 800FA53C 00431024 */  and      $v0,$v0,$v1
/* 800FA540 ae02ffe0 */  sw       $v0,-32($s0)
/* 800FA544 0803e9b4 */  j        .L800FA6D0
/* 800FA548 00000000 */  nop      
.L800FA54C:
/* 800FA54C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA550 00000000 */  nop      
/* 800FA554 30420008 */  andi     $v0,$v0,0x8
/* 800FA558 14400004 */  bnez     $v0,.L800FA56C
/* 800FA55C 2611001c */  addiu    $s1,$s0,28
/* 800FA560 8e11000c */  lw       $s1,12($s0)
/* 800FA564 0803e95c */  j        .L800FA570
/* 800FA568 27a40010 */  addiu    $a0,$sp,16
.L800FA56C:
/* 800FA56C 27a40010 */  addiu    $a0,$sp,16
.L800FA570:
/* 800FA570 0c03e0ee */  jal      func_800F83B8
/* 800FA574 24050003 */  li       $a1,3
/* 800FA578 02202021 */  move     $a0,$s1
/* 800FA57C 0c03e0ee */  jal      func_800F83B8
/* 800FA580 24050200 */  li       $a1,512
/* 800FA584 27a4001c */  addiu    $a0,$sp,28
/* 800FA588 0c03e0ee */  jal      func_800F83B8
/* 800FA58C 24050046 */  li       $a1,70
/* 800FA590 0c03e107 */  jal      func_800F841C
/* 800FA594 00002021 */  move     $a0,$zero
/* 800FA598 0c03e150 */  jal      func_800F8540
/* 800FA59C 27a40010 */  addiu    $a0,$sp,16
/* 800FA5A0 3c118014 */  lui      $s1,0x8014
/* 800FA5A4 26247dec */  addiu    $a0,$s1,32236
/* 800FA5A8 8c83000c */  lw       $v1,12($a0)
/* 800FA5AC 00000000 */  nop      
/* 800FA5B0 10430014 */  beq      $v0,$v1,.L800FA604
/* 800FA5B4 3c028014 */  lui      $v0,0x8014
/* 800FA5B8 8c82001c */  lw       $v0,28($a0)
/* 800FA5BC 8c83000c */  lw       $v1,12($a0)
/* 800FA5C0 24420001 */  addiu    $v0,$v0,1
/* 800FA5C4 ac82001c */  sw       $v0,28($a0)
/* 800FA5C8 28420004 */  slti     $v0,$v0,4
/* 800FA5CC 10400007 */  beqz     $v0,.L800FA5EC
/* 800FA5D0 ac830014 */  sw       $v1,20($a0)
/* 800FA5D4 8e227dec */  lw       $v0,32236($s1)
/* 800FA5D8 00000000 */  nop      
/* 800FA5DC 34420002 */  ori      $v0,$v0,0x2
/* 800FA5E0 ae227dec */  sw       $v0,32236($s1)
/* 800FA5E4 0803e9b9 */  j        .L800FA6E4
/* 800FA5E8 00000000 */  nop      
.L800FA5EC:
/* 800FA5EC 2402ffff */  li       $v0,-1
/* 800FA5F0 ac82001c */  sw       $v0,28($a0)
/* 800FA5F4 24040009 */  li       $a0,9
/* 800FA5F8 00002821 */  move     $a1,$zero
/* 800FA5FC 0803ea30 */  j        .L800FA8C0
/* 800FA600 00a03021 */  move     $a2,$a1
.L800FA604:
/* 800FA604 8c43ed90 */  lw       $v1,-4720($v0)
/* 800FA608 00000000 */  nop      
/* 800FA60C 00031040 */  sll      $v0,$v1,0x1
/* 800FA610 00431021 */  addu     $v0,$v0,$v1
/* 800FA614 8e237dec */  lw       $v1,32236($s1)
/* 800FA618 00021080 */  sll      $v0,$v0,0x2
/* 800FA61C 30630008 */  andi     $v1,$v1,0x8
/* 800FA620 10600010 */  beqz     $v1,.L800FA664
/* 800FA624 ac820018 */  sw       $v0,24($a0)
/* 800FA628 2403fff7 */  li       $v1,-9
/* 800FA62C 8e05000c */  lw       $a1,12($s0)
/* 800FA630 8e227dec */  lw       $v0,32236($s1)
/* 800FA634 8e060000 */  lw       $a2,0($s0)
/* 800FA638 00431024 */  and      $v0,$v0,$v1
/* 800FA63C 2483003c */  addiu    $v1,$a0,60
/* 800FA640 ae227dec */  sw       $v0,32236($s1)
/* 800FA644 8e040008 */  lw       $a0,8($s0)
/* 800FA648 8e227dec */  lw       $v0,32236($s1)
/* 800FA64C 00832021 */  addu     $a0,$a0,$v1
/* 800FA650 34420010 */  ori      $v0,$v0,0x10
/* 800FA654 ae227dec */  sw       $v0,32236($s1)
/* 800FA658 0c039b2d */  jal      func_800E6CB4
/* 800FA65C 00000000 */  nop      
/* 800FA660 ae000008 */  sw       $zero,8($s0)
.L800FA664:
/* 800FA664 8e020004 */  lw       $v0,4($s0)
/* 800FA668 00000000 */  nop      
/* 800FA66C 18400016 */  blez     $v0,.L800FA6C8
/* 800FA670 00000000 */  nop      
/* 800FA674 8e02000c */  lw       $v0,12($s0)
/* 800FA678 8e030000 */  lw       $v1,0($s0)
/* 800FA67C 8e040004 */  lw       $a0,4($s0)
/* 800FA680 00431021 */  addu     $v0,$v0,$v1
/* 800FA684 ae02000c */  sw       $v0,12($s0)
/* 800FA688 28820800 */  slti     $v0,$a0,2048
/* 800FA68C 10400007 */  beqz     $v0,.L800FA6AC
/* 800FA690 24020800 */  li       $v0,2048
/* 800FA694 8e227dec */  lw       $v0,32236($s1)
/* 800FA698 ae040000 */  sw       $a0,0($s0)
/* 800FA69C 34420008 */  ori      $v0,$v0,0x8
/* 800FA6A0 ae227dec */  sw       $v0,32236($s1)
/* 800FA6A4 0803e9ac */  j        .L800FA6B0
/* 800FA6A8 00000000 */  nop      
.L800FA6AC:
/* 800FA6AC ae020000 */  sw       $v0,0($s0)
.L800FA6B0:
/* 800FA6B0 8e020004 */  lw       $v0,4($s0)
/* 800FA6B4 8e030000 */  lw       $v1,0($s0)
/* 800FA6B8 00000000 */  nop      
/* 800FA6BC 00431023 */  subu     $v0,$v0,$v1
/* 800FA6C0 0803e9b9 */  j        .L800FA6E4
/* 800FA6C4 ae020004 */  sw       $v0,4($s0)
.L800FA6C8:
/* 800FA6C8 0803e9b9 */  j        .L800FA6E4
/* 800FA6CC 24120001 */  li       $s2,1
.L800FA6D0:
/* 800FA6D0 0c03dfd8 */  jal      func_800F7F60
/* 800FA6D4 00000000 */  nop      
/* 800FA6D8 00002021 */  move     $a0,$zero
/* 800FA6DC 0c03dfe5 */  jal      func_800F7F94
/* 800FA6E0 00802821 */  move     $a1,$a0
.L800FA6E4:
/* 800FA6E4 12400037 */  beqz     $s2,.L800FA7C4
/* 800FA6E8 3c048014 */  lui      $a0,0x8014
/* 800FA6EC 2403fffe */  li       $v1,-2
/* 800FA6F0 8c827dec */  lw       $v0,32236($a0)
/* 800FA6F4 24917dec */  addiu    $s1,$a0,32236
/* 800FA6F8 00431024 */  and      $v0,$v0,$v1
/* 800FA6FC ac827dec */  sw       $v0,32236($a0)
/* 800FA700 3c048010 */  lui      $a0,0x8010
/* 800FA704 8e22000c */  lw       $v0,12($s1)
/* 800FA708 2484a3e0 */  addiu    $a0,$a0,-23584
/* 800FA70C 0c03ade4 */  jal      func_800EB790
/* 800FA710 ae220010 */  sw       $v0,16($s1)
/* 800FA714 8e220030 */  lw       $v0,48($s1)
/* 800FA718 00000000 */  nop      
/* 800FA71C 10400029 */  beqz     $v0,.L800FA7C4
/* 800FA720 ae200018 */  sw       $zero,24($s1)
/* 800FA724 27a40140 */  addiu    $a0,$sp,320
/* 800FA728 3c108014 */  lui      $s0,0x8014
/* 800FA72C 24020002 */  li       $v0,2
/* 800FA730 0c03adf6 */  jal      func_800EB7D8
/* 800FA734 ae02ee4c */  sw       $v0,-4532($s0)
/* 800FA738 8e220030 */  lw       $v0,48($s1)
/* 800FA73C 00000000 */  nop      
/* 800FA740 0040f809 */  jalr     $v0
/* 800FA744 24040001 */  li       $a0,1
/* 800FA748 8fa40140 */  lw       $a0,320($sp)
/* 800FA74C 0c03adfb */  jal      func_800EB7EC
/* 800FA750 00000000 */  nop      
/* 800FA754 0803e9f1 */  j        .L800FA7C4
/* 800FA758 ae00ee4c */  sw       $zero,-4532($s0)
.L800FA75C:
/* 800FA75C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA760 00000000 */  nop      
/* 800FA764 30420001 */  andi     $v0,$v0,0x1
/* 800FA768 10400016 */  beqz     $v0,.L800FA7C4
/* 800FA76C 2611ffe0 */  addiu    $s1,$s0,-32
/* 800FA770 24040001 */  li       $a0,1
/* 800FA774 00002821 */  move     $a1,$zero
/* 800FA778 0c03dfff */  jal      func_800F7FFC
/* 800FA77C 27a60010 */  addiu    $a2,$sp,16
/* 800FA780 8e22001c */  lw       $v0,28($s1)
/* 800FA784 8e23000c */  lw       $v1,12($s1)
/* 800FA788 24420001 */  addiu    $v0,$v0,1
/* 800FA78C ae22001c */  sw       $v0,28($s1)
/* 800FA790 28420004 */  slti     $v0,$v0,4
/* 800FA794 14400007 */  bnez     $v0,.L800FA7B4
/* 800FA798 ae230014 */  sw       $v1,20($s1)
/* 800FA79C 2402ffff */  li       $v0,-1
/* 800FA7A0 ae22001c */  sw       $v0,28($s1)
/* 800FA7A4 24040009 */  li       $a0,9
/* 800FA7A8 00002821 */  move     $a1,$zero
/* 800FA7AC 0803ea30 */  j        .L800FA8C0
/* 800FA7B0 00a03021 */  move     $a2,$a1
.L800FA7B4:
/* 800FA7B4 8e02ffe0 */  lw       $v0,-32($s0)
.L800FA7B8:
/* 800FA7B8 00000000 */  nop      
/* 800FA7BC 34420002 */  ori      $v0,$v0,0x2
/* 800FA7C0 ae02ffe0 */  sw       $v0,-32($s0)
.L800FA7C4:
/* 800FA7C4 3c048014 */  lui      $a0,0x8014
/* 800FA7C8 24917dec */  addiu    $s1,$a0,32236
.L800FA7CC:
/* 800FA7CC 8e22000c */  lw       $v0,12($s1)
/* 800FA7D0 00000000 */  nop      
/* 800FA7D4 24420001 */  addiu    $v0,$v0,1
/* 800FA7D8 ae22000c */  sw       $v0,12($s1)
/* 800FA7DC 8c827dec */  lw       $v0,32236($a0)
/* 800FA7E0 00000000 */  nop      
/* 800FA7E4 30420002 */  andi     $v0,$v0,0x2
/* 800FA7E8 10400022 */  beqz     $v0,.L800FA874
/* 800FA7EC 3c038014 */  lui      $v1,0x8014
/* 800FA7F0 8c827dec */  lw       $v0,32236($a0)
/* 800FA7F4 2403fffd */  li       $v1,-3
/* 800FA7F8 00431024 */  and      $v0,$v0,$v1
/* 800FA7FC ac827dec */  sw       $v0,32236($a0)
/* 800FA800 8c827dec */  lw       $v0,32236($a0)
/* 800FA804 2403ffef */  li       $v1,-17
/* 800FA808 00431024 */  and      $v0,$v0,$v1
/* 800FA80C ac827dec */  sw       $v0,32236($a0)
/* 800FA810 8c827dec */  lw       $v0,32236($a0)
/* 800FA814 00000000 */  nop      
/* 800FA818 34420001 */  ori      $v0,$v0,0x1
/* 800FA81C ac827dec */  sw       $v0,32236($a0)
/* 800FA820 8e23000c */  lw       $v1,12($s1)
/* 800FA824 8e220014 */  lw       $v0,20($s1)
/* 800FA828 00000000 */  nop      
/* 800FA82C 10620010 */  beq      $v1,$v0,.L800FA870
/* 800FA830 00000000 */  nop      
/* 800FA834 0c03dfd8 */  jal      func_800F7F60
/* 800FA838 00000000 */  nop      
/* 800FA83C 00002021 */  move     $a0,$zero
/* 800FA840 0c03dfe5 */  jal      func_800F7F94
/* 800FA844 00802821 */  move     $a1,$a0
/* 800FA848 27b00138 */  addiu    $s0,$sp,312
/* 800FA84C 8e240014 */  lw       $a0,20($s1)
/* 800FA850 02002821 */  move     $a1,$s0
/* 800FA854 ae24000c */  sw       $a0,12($s1)
/* 800FA858 0c03e10f */  jal      func_800F843C
/* 800FA85C 00000000 */  nop      
/* 800FA860 2404001b */  li       $a0,27
/* 800FA864 02002821 */  move     $a1,$s0
/* 800FA868 0c03dfff */  jal      func_800F7FFC
/* 800FA86C 02603021 */  move     $a2,$s3
.L800FA870:
/* 800FA870 3c038014 */  lui      $v1,0x8014
.L800FA874:
/* 800FA874 8c627dec */  lw       $v0,32236($v1)
/* 800FA878 00000000 */  nop      
/* 800FA87C 30420001 */  andi     $v0,$v0,0x1
/* 800FA880 14400011 */  bnez     $v0,.L800FA8C8
/* 800FA884 24637dec */  addiu    $v1,$v1,32236
/* 800FA888 8c62000c */  lw       $v0,12($v1)
/* 800FA88C 8c640010 */  lw       $a0,16($v1)
/* 800FA890 00000000 */  nop      
/* 800FA894 00441023 */  subu     $v0,$v0,$a0
/* 800FA898 28420015 */  slti     $v0,$v0,21
/* 800FA89C 1440000a */  bnez     $v0,.L800FA8C8
/* 800FA8A0 00000000 */  nop      
/* 800FA8A4 ac64000c */  sw       $a0,12($v1)
/* 800FA8A8 27b00138 */  addiu    $s0,$sp,312
/* 800FA8AC 0c03e10f */  jal      func_800F843C
/* 800FA8B0 02002821 */  move     $a1,$s0
/* 800FA8B4 2404001b */  li       $a0,27
/* 800FA8B8 02002821 */  move     $a1,$s0
/* 800FA8BC 02603021 */  move     $a2,$s3
.L800FA8C0:
/* 800FA8C0 0c03dfff */  jal      func_800F7FFC
/* 800FA8C4 00000000 */  nop      
.L800FA8C8:
/* 800FA8C8 3c048010 */  lui      $a0,0x8010
/* 800FA8CC 0c03dffa */  jal      func_800F7FE8
/* 800FA8D0 2484a440 */  addiu    $a0,$a0,-23488
.L800FA8D4:
/* 800FA8D4 8fbf0158 */  lw       $ra,344($sp)
/* 800FA8D8 8fb30154 */  lw       $s3,340($sp)
/* 800FA8DC 8fb20150 */  lw       $s2,336($sp)
/* 800FA8E0 8fb1014c */  lw       $s1,332($sp)
/* 800FA8E4 8fb00148 */  lw       $s0,328($sp)
/* 800FA8E8 03e00008 */  jr       $ra
/* 800FA8EC 27bd0160 */  addiu    $sp,$sp,352
