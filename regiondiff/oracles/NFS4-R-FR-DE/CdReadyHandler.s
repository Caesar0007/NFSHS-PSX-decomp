.set noat
.set noreorder

glabel func_800FA680
/* 800FA680 27bdfea0 */  addiu    $sp,$sp,-352
/* 800FA684 afb30154 */  sw       $s3,340($sp)
/* 800FA688 00a09821 */  move     $s3,$a1
/* 800FA68C afb1014c */  sw       $s1,332($sp)
/* 800FA690 00808821 */  move     $s1,$a0
/* 800FA694 00002021 */  move     $a0,$zero
/* 800FA698 3c028015 */  lui      $v0,0x8015
/* 800FA69C afb00148 */  sw       $s0,328($sp)
/* 800FA6A0 2450804c */  addiu    $s0,$v0,-32692
/* 800FA6A4 afbf0158 */  sw       $ra,344($sp)
/* 800FA6A8 0c03e08a */  jal      func_800F8228
/* 800FA6AC afb20150 */  sw       $s2,336($sp)
/* 800FA6B0 92620000 */  lbu      $v0,0($s3)
/* 800FA6B4 00000000 */  nop      
/* 800FA6B8 30420010 */  andi     $v0,$v0,0x10
/* 800FA6BC 1040000b */  beqz     $v0,.L800FA6EC
/* 800FA6C0 00009021 */  move     $s2,$zero
/* 800FA6C4 3c048010 */  lui      $a0,0x8010
/* 800FA6C8 0c03ae64 */  jal      func_800EB990
/* 800FA6CC 2484a620 */  addiu    $a0,$a0,-23008
/* 800FA6D0 3c048010 */  lui      $a0,0x8010
/* 800FA6D4 2484a470 */  addiu    $a0,$a0,-23440
/* 800FA6D8 02402821 */  move     $a1,$s2
/* 800FA6DC 0c039db3 */  jal      func_800E76CC
/* 800FA6E0 02403021 */  move     $a2,$s2
/* 800FA6E4 0803eac5 */  j        .L800FAB14
/* 800FA6E8 00000000 */  nop      
.L800FA6EC:
/* 800FA6EC 322400ff */  andi     $a0,$s1,0xff
/* 800FA6F0 24020002 */  li       $v0,2
/* 800FA6F4 1082000c */  beq      $a0,$v0,.L800FA728
/* 800FA6F8 28820003 */  slti     $v0,$a0,3
/* 800FA6FC 10400005 */  beqz     $v0,.L800FA714
/* 800FA700 24020001 */  li       $v0,1
/* 800FA704 10820010 */  beq      $a0,$v0,.L800FA748
/* 800FA708 3c048015 */  lui      $a0,0x8015
/* 800FA70C 0803ea83 */  j        .L800FAA0C
/* 800FA710 2491802c */  addiu    $s1,$a0,-32724
.L800FA714:
/* 800FA714 24020005 */  li       $v0,5
/* 800FA718 108200a0 */  beq      $a0,$v0,.L800FA99C
/* 800FA71C 3c048015 */  lui      $a0,0x8015
/* 800FA720 0803ea83 */  j        .L800FAA0C
/* 800FA724 2491802c */  addiu    $s1,$a0,-32724
.L800FA728:
/* 800FA728 2604ffe0 */  addiu    $a0,$s0,-32
/* 800FA72C 8c83001c */  lw       $v1,28($a0)
/* 800FA730 2402ffff */  li       $v0,-1
/* 800FA734 146200b3 */  bne      $v1,$v0,.L800FAA04
/* 800FA738 00000000 */  nop      
/* 800FA73C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA740 0803ea7e */  j        .L800FA9F8
/* 800FA744 ac80001c */  sw       $zero,28($a0)
.L800FA748:
/* 800FA748 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA74C 00000000 */  nop      
/* 800FA750 30420001 */  andi     $v0,$v0,0x1
/* 800FA754 1040006e */  beqz     $v0,.L800FA910
/* 800FA758 00000000 */  nop      
/* 800FA75C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA760 00000000 */  nop      
/* 800FA764 30420004 */  andi     $v0,$v0,0x4
/* 800FA768 10400008 */  beqz     $v0,.L800FA78C
/* 800FA76C 00000000 */  nop      
/* 800FA770 24120001 */  li       $s2,1
/* 800FA774 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA778 2403fffb */  li       $v1,-5
/* 800FA77C 00431024 */  and      $v0,$v0,$v1
/* 800FA780 ae02ffe0 */  sw       $v0,-32($s0)
/* 800FA784 0803ea44 */  j        .L800FA910
/* 800FA788 00000000 */  nop      
.L800FA78C:
/* 800FA78C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA790 00000000 */  nop      
/* 800FA794 30420008 */  andi     $v0,$v0,0x8
/* 800FA798 14400004 */  bnez     $v0,.L800FA7AC
/* 800FA79C 2611001c */  addiu    $s1,$s0,28
/* 800FA7A0 8e11000c */  lw       $s1,12($s0)
/* 800FA7A4 0803e9ec */  j        .L800FA7B0
/* 800FA7A8 27a40010 */  addiu    $a0,$sp,16
.L800FA7AC:
/* 800FA7AC 27a40010 */  addiu    $a0,$sp,16
.L800FA7B0:
/* 800FA7B0 0c03e17e */  jal      func_800F85F8
/* 800FA7B4 24050003 */  li       $a1,3
/* 800FA7B8 02202021 */  move     $a0,$s1
/* 800FA7BC 0c03e17e */  jal      func_800F85F8
/* 800FA7C0 24050200 */  li       $a1,512
/* 800FA7C4 27a4001c */  addiu    $a0,$sp,28
/* 800FA7C8 0c03e17e */  jal      func_800F85F8
/* 800FA7CC 24050046 */  li       $a1,70
/* 800FA7D0 0c03e197 */  jal      func_800F865C
/* 800FA7D4 00002021 */  move     $a0,$zero
/* 800FA7D8 0c03e1e0 */  jal      func_800F8780
/* 800FA7DC 27a40010 */  addiu    $a0,$sp,16
/* 800FA7E0 3c118015 */  lui      $s1,0x8015
/* 800FA7E4 2624802c */  addiu    $a0,$s1,-32724
/* 800FA7E8 8c83000c */  lw       $v1,12($a0)
/* 800FA7EC 00000000 */  nop      
/* 800FA7F0 10430014 */  beq      $v0,$v1,.L800FA844
/* 800FA7F4 3c028014 */  lui      $v0,0x8014
/* 800FA7F8 8c82001c */  lw       $v0,28($a0)
/* 800FA7FC 8c83000c */  lw       $v1,12($a0)
/* 800FA800 24420001 */  addiu    $v0,$v0,1
/* 800FA804 ac82001c */  sw       $v0,28($a0)
/* 800FA808 28420004 */  slti     $v0,$v0,4
/* 800FA80C 10400007 */  beqz     $v0,.L800FA82C
/* 800FA810 ac830014 */  sw       $v1,20($a0)
/* 800FA814 8e22802c */  lw       $v0,-32724($s1)
/* 800FA818 00000000 */  nop      
/* 800FA81C 34420002 */  ori      $v0,$v0,0x2
/* 800FA820 ae22802c */  sw       $v0,-32724($s1)
/* 800FA824 0803ea49 */  j        .L800FA924
/* 800FA828 00000000 */  nop      
.L800FA82C:
/* 800FA82C 2402ffff */  li       $v0,-1
/* 800FA830 ac82001c */  sw       $v0,28($a0)
/* 800FA834 24040009 */  li       $a0,9
/* 800FA838 00002821 */  move     $a1,$zero
/* 800FA83C 0803eac0 */  j        .L800FAB00
/* 800FA840 00a03021 */  move     $a2,$a1
.L800FA844:
/* 800FA844 8c43efd0 */  lw       $v1,-4144($v0)
/* 800FA848 00000000 */  nop      
/* 800FA84C 00031040 */  sll      $v0,$v1,0x1
/* 800FA850 00431021 */  addu     $v0,$v0,$v1
/* 800FA854 8e23802c */  lw       $v1,-32724($s1)
/* 800FA858 00021080 */  sll      $v0,$v0,0x2
/* 800FA85C 30630008 */  andi     $v1,$v1,0x8
/* 800FA860 10600010 */  beqz     $v1,.L800FA8A4
/* 800FA864 ac820018 */  sw       $v0,24($a0)
/* 800FA868 2403fff7 */  li       $v1,-9
/* 800FA86C 8e05000c */  lw       $a1,12($s0)
/* 800FA870 8e22802c */  lw       $v0,-32724($s1)
/* 800FA874 8e060000 */  lw       $a2,0($s0)
/* 800FA878 00431024 */  and      $v0,$v0,$v1
/* 800FA87C 2483003c */  addiu    $v1,$a0,60
/* 800FA880 ae22802c */  sw       $v0,-32724($s1)
/* 800FA884 8e040008 */  lw       $a0,8($s0)
/* 800FA888 8e22802c */  lw       $v0,-32724($s1)
/* 800FA88C 00832021 */  addu     $a0,$a0,$v1
/* 800FA890 34420010 */  ori      $v0,$v0,0x10
/* 800FA894 ae22802c */  sw       $v0,-32724($s1)
/* 800FA898 0c039bad */  jal      func_800E6EB4
/* 800FA89C 00000000 */  nop      
/* 800FA8A0 ae000008 */  sw       $zero,8($s0)
.L800FA8A4:
/* 800FA8A4 8e020004 */  lw       $v0,4($s0)
/* 800FA8A8 00000000 */  nop      
/* 800FA8AC 18400016 */  blez     $v0,.L800FA908
/* 800FA8B0 00000000 */  nop      
/* 800FA8B4 8e02000c */  lw       $v0,12($s0)
/* 800FA8B8 8e030000 */  lw       $v1,0($s0)
/* 800FA8BC 8e040004 */  lw       $a0,4($s0)
/* 800FA8C0 00431021 */  addu     $v0,$v0,$v1
/* 800FA8C4 ae02000c */  sw       $v0,12($s0)
/* 800FA8C8 28820800 */  slti     $v0,$a0,2048
/* 800FA8CC 10400007 */  beqz     $v0,.L800FA8EC
/* 800FA8D0 24020800 */  li       $v0,2048
/* 800FA8D4 8e22802c */  lw       $v0,-32724($s1)
/* 800FA8D8 ae040000 */  sw       $a0,0($s0)
/* 800FA8DC 34420008 */  ori      $v0,$v0,0x8
/* 800FA8E0 ae22802c */  sw       $v0,-32724($s1)
/* 800FA8E4 0803ea3c */  j        .L800FA8F0
/* 800FA8E8 00000000 */  nop      
.L800FA8EC:
/* 800FA8EC ae020000 */  sw       $v0,0($s0)
.L800FA8F0:
/* 800FA8F0 8e020004 */  lw       $v0,4($s0)
/* 800FA8F4 8e030000 */  lw       $v1,0($s0)
/* 800FA8F8 00000000 */  nop      
/* 800FA8FC 00431023 */  subu     $v0,$v0,$v1
/* 800FA900 0803ea49 */  j        .L800FA924
/* 800FA904 ae020004 */  sw       $v0,4($s0)
.L800FA908:
/* 800FA908 0803ea49 */  j        .L800FA924
/* 800FA90C 24120001 */  li       $s2,1
.L800FA910:
/* 800FA910 0c03e068 */  jal      func_800F81A0
/* 800FA914 00000000 */  nop      
/* 800FA918 00002021 */  move     $a0,$zero
/* 800FA91C 0c03e075 */  jal      func_800F81D4
/* 800FA920 00802821 */  move     $a1,$a0
.L800FA924:
/* 800FA924 12400037 */  beqz     $s2,.L800FAA04
/* 800FA928 3c048015 */  lui      $a0,0x8015
/* 800FA92C 2403fffe */  li       $v1,-2
/* 800FA930 8c82802c */  lw       $v0,-32724($a0)
/* 800FA934 2491802c */  addiu    $s1,$a0,-32724
/* 800FA938 00431024 */  and      $v0,$v0,$v1
/* 800FA93C ac82802c */  sw       $v0,-32724($a0)
/* 800FA940 3c048010 */  lui      $a0,0x8010
/* 800FA944 8e22000c */  lw       $v0,12($s1)
/* 800FA948 2484a620 */  addiu    $a0,$a0,-23008
/* 800FA94C 0c03ae64 */  jal      func_800EB990
/* 800FA950 ae220010 */  sw       $v0,16($s1)
/* 800FA954 8e220030 */  lw       $v0,48($s1)
/* 800FA958 00000000 */  nop      
/* 800FA95C 10400029 */  beqz     $v0,.L800FAA04
/* 800FA960 ae200018 */  sw       $zero,24($s1)
/* 800FA964 27a40140 */  addiu    $a0,$sp,320
/* 800FA968 3c108014 */  lui      $s0,0x8014
/* 800FA96C 24020002 */  li       $v0,2
/* 800FA970 0c03ae76 */  jal      func_800EB9D8
/* 800FA974 ae02f08c */  sw       $v0,-3956($s0)
/* 800FA978 8e220030 */  lw       $v0,48($s1)
/* 800FA97C 00000000 */  nop      
/* 800FA980 0040f809 */  jalr     $v0
/* 800FA984 24040001 */  li       $a0,1
/* 800FA988 8fa40140 */  lw       $a0,320($sp)
/* 800FA98C 0c03ae7b */  jal      func_800EB9EC
/* 800FA990 00000000 */  nop      
/* 800FA994 0803ea81 */  j        .L800FAA04
/* 800FA998 ae00f08c */  sw       $zero,-3956($s0)
.L800FA99C:
/* 800FA99C 8e02ffe0 */  lw       $v0,-32($s0)
/* 800FA9A0 00000000 */  nop      
/* 800FA9A4 30420001 */  andi     $v0,$v0,0x1
/* 800FA9A8 10400016 */  beqz     $v0,.L800FAA04
/* 800FA9AC 2611ffe0 */  addiu    $s1,$s0,-32
/* 800FA9B0 24040001 */  li       $a0,1
/* 800FA9B4 00002821 */  move     $a1,$zero
/* 800FA9B8 0c03e08f */  jal      func_800F823C
/* 800FA9BC 27a60010 */  addiu    $a2,$sp,16
/* 800FA9C0 8e22001c */  lw       $v0,28($s1)
/* 800FA9C4 8e23000c */  lw       $v1,12($s1)
/* 800FA9C8 24420001 */  addiu    $v0,$v0,1
/* 800FA9CC ae22001c */  sw       $v0,28($s1)
/* 800FA9D0 28420004 */  slti     $v0,$v0,4
/* 800FA9D4 14400007 */  bnez     $v0,.L800FA9F4
/* 800FA9D8 ae230014 */  sw       $v1,20($s1)
/* 800FA9DC 2402ffff */  li       $v0,-1
/* 800FA9E0 ae22001c */  sw       $v0,28($s1)
/* 800FA9E4 24040009 */  li       $a0,9
/* 800FA9E8 00002821 */  move     $a1,$zero
/* 800FA9EC 0803eac0 */  j        .L800FAB00
/* 800FA9F0 00a03021 */  move     $a2,$a1
.L800FA9F4:
/* 800FA9F4 8e02ffe0 */  lw       $v0,-32($s0)
.L800FA9F8:
/* 800FA9F8 00000000 */  nop      
/* 800FA9FC 34420002 */  ori      $v0,$v0,0x2
/* 800FAA00 ae02ffe0 */  sw       $v0,-32($s0)
.L800FAA04:
/* 800FAA04 3c048015 */  lui      $a0,0x8015
/* 800FAA08 2491802c */  addiu    $s1,$a0,-32724
.L800FAA0C:
/* 800FAA0C 8e22000c */  lw       $v0,12($s1)
/* 800FAA10 00000000 */  nop      
/* 800FAA14 24420001 */  addiu    $v0,$v0,1
/* 800FAA18 ae22000c */  sw       $v0,12($s1)
/* 800FAA1C 8c82802c */  lw       $v0,-32724($a0)
/* 800FAA20 00000000 */  nop      
/* 800FAA24 30420002 */  andi     $v0,$v0,0x2
/* 800FAA28 10400022 */  beqz     $v0,.L800FAAB4
/* 800FAA2C 3c038015 */  lui      $v1,0x8015
/* 800FAA30 8c82802c */  lw       $v0,-32724($a0)
/* 800FAA34 2403fffd */  li       $v1,-3
/* 800FAA38 00431024 */  and      $v0,$v0,$v1
/* 800FAA3C ac82802c */  sw       $v0,-32724($a0)
/* 800FAA40 8c82802c */  lw       $v0,-32724($a0)
/* 800FAA44 2403ffef */  li       $v1,-17
/* 800FAA48 00431024 */  and      $v0,$v0,$v1
/* 800FAA4C ac82802c */  sw       $v0,-32724($a0)
/* 800FAA50 8c82802c */  lw       $v0,-32724($a0)
/* 800FAA54 00000000 */  nop      
/* 800FAA58 34420001 */  ori      $v0,$v0,0x1
/* 800FAA5C ac82802c */  sw       $v0,-32724($a0)
/* 800FAA60 8e23000c */  lw       $v1,12($s1)
/* 800FAA64 8e220014 */  lw       $v0,20($s1)
/* 800FAA68 00000000 */  nop      
/* 800FAA6C 10620010 */  beq      $v1,$v0,.L800FAAB0
/* 800FAA70 00000000 */  nop      
/* 800FAA74 0c03e068 */  jal      func_800F81A0
/* 800FAA78 00000000 */  nop      
/* 800FAA7C 00002021 */  move     $a0,$zero
/* 800FAA80 0c03e075 */  jal      func_800F81D4
/* 800FAA84 00802821 */  move     $a1,$a0
/* 800FAA88 27b00138 */  addiu    $s0,$sp,312
/* 800FAA8C 8e240014 */  lw       $a0,20($s1)
/* 800FAA90 02002821 */  move     $a1,$s0
/* 800FAA94 ae24000c */  sw       $a0,12($s1)
/* 800FAA98 0c03e19f */  jal      func_800F867C
/* 800FAA9C 00000000 */  nop      
/* 800FAAA0 2404001b */  li       $a0,27
/* 800FAAA4 02002821 */  move     $a1,$s0
/* 800FAAA8 0c03e08f */  jal      func_800F823C
/* 800FAAAC 02603021 */  move     $a2,$s3
.L800FAAB0:
/* 800FAAB0 3c038015 */  lui      $v1,0x8015
.L800FAAB4:
/* 800FAAB4 8c62802c */  lw       $v0,-32724($v1)
/* 800FAAB8 00000000 */  nop      
/* 800FAABC 30420001 */  andi     $v0,$v0,0x1
/* 800FAAC0 14400011 */  bnez     $v0,.L800FAB08
/* 800FAAC4 2463802c */  addiu    $v1,$v1,-32724
/* 800FAAC8 8c62000c */  lw       $v0,12($v1)
/* 800FAACC 8c640010 */  lw       $a0,16($v1)
/* 800FAAD0 00000000 */  nop      
/* 800FAAD4 00441023 */  subu     $v0,$v0,$a0
/* 800FAAD8 28420015 */  slti     $v0,$v0,21
/* 800FAADC 1440000a */  bnez     $v0,.L800FAB08
/* 800FAAE0 00000000 */  nop      
/* 800FAAE4 ac64000c */  sw       $a0,12($v1)
/* 800FAAE8 27b00138 */  addiu    $s0,$sp,312
/* 800FAAEC 0c03e19f */  jal      func_800F867C
/* 800FAAF0 02002821 */  move     $a1,$s0
/* 800FAAF4 2404001b */  li       $a0,27
/* 800FAAF8 02002821 */  move     $a1,$s0
/* 800FAAFC 02603021 */  move     $a2,$s3
.L800FAB00:
/* 800FAB00 0c03e08f */  jal      func_800F823C
/* 800FAB04 00000000 */  nop      
.L800FAB08:
/* 800FAB08 3c048010 */  lui      $a0,0x8010
/* 800FAB0C 0c03e08a */  jal      func_800F8228
/* 800FAB10 2484a680 */  addiu    $a0,$a0,-22912
.L800FAB14:
/* 800FAB14 8fbf0158 */  lw       $ra,344($sp)
/* 800FAB18 8fb30154 */  lw       $s3,340($sp)
/* 800FAB1C 8fb20150 */  lw       $s2,336($sp)
/* 800FAB20 8fb1014c */  lw       $s1,332($sp)
/* 800FAB24 8fb00148 */  lw       $s0,328($sp)
/* 800FAB28 03e00008 */  jr       $ra
/* 800FAB2C 27bd0160 */  addiu    $sp,$sp,352
