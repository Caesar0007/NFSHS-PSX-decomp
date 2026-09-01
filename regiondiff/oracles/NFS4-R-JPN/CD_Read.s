.set noat
.set noreorder

glabel func_800FAE14
/* 800FAE14 27bdffd0 */  addiu    $sp,$sp,-48
/* 800FAE18 afb30024 */  sw       $s3,36($sp)
/* 800FAE1C 00e09821 */  move     $s3,$a3
/* 800FAE20 3c078014 */  lui      $a3,0x8014
/* 800FAE24 24e37dec */  addiu    $v1,$a3,32236
/* 800FAE28 00042080 */  sll      $a0,$a0,0x2
/* 800FAE2C afbf002c */  sw       $ra,44($sp)
/* 800FAE30 afb40028 */  sw       $s4,40($sp)
/* 800FAE34 afb20020 */  sw       $s2,32($sp)
/* 800FAE38 afb1001c */  sw       $s1,28($sp)
/* 800FAE3C afb00018 */  sw       $s0,24($sp)
/* 800FAE40 8c620034 */  lw       $v0,52($v1)
/* 800FAE44 2484fffc */  addiu    $a0,$a0,-4
/* 800FAE48 00442021 */  addu     $a0,$v0,$a0
/* 800FAE4C 8ce27dec */  lw       $v0,32236($a3)
/* 800FAE50 00000000 */  nop      
/* 800FAE54 30420003 */  andi     $v0,$v0,0x3
/* 800FAE58 10400003 */  beqz     $v0,.L800FAE68
/* 800FAE5C 24700020 */  addiu    $s0,$v1,32
/* 800FAE60 0803ec1f */  j        .L800FB07C
/* 800FAE64 00001021 */  move     $v0,$zero
.L800FAE68:
/* 800FAE68 8c820000 */  lw       $v0,0($a0)
/* 800FAE6C 00000000 */  nop      
/* 800FAE70 8c420010 */  lw       $v0,16($v0)
/* 800FAE74 00000000 */  nop      
/* 800FAE78 00461823 */  subu     $v1,$v0,$a2
/* 800FAE7C 0073102a */  slt      $v0,$v1,$s3
/* 800FAE80 10400002 */  beqz     $v0,.L800FAE8C
/* 800FAE84 00000000 */  nop      
/* 800FAE88 00609821 */  move     $s3,$v1
.L800FAE8C:
/* 800FAE8C 04c10002 */  bgez     $a2,.L800FAE98
/* 800FAE90 00c01021 */  move     $v0,$a2
/* 800FAE94 24c207ff */  addiu    $v0,$a2,2047
.L800FAE98:
/* 800FAE98 000212c3 */  sra      $v0,$v0,0xb
/* 800FAE9C 000212c0 */  sll      $v0,$v0,0xb
/* 800FAEA0 00c21023 */  subu     $v0,$a2,$v0
/* 800FAEA4 ae020008 */  sw       $v0,8($s0)
/* 800FAEA8 14400004 */  bnez     $v0,.L800FAEBC
/* 800FAEAC ae05000c */  sw       $a1,12($s0)
/* 800FAEB0 2a620800 */  slti     $v0,$s3,2048
/* 800FAEB4 10400005 */  beqz     $v0,.L800FAECC
/* 800FAEB8 00000000 */  nop      
.L800FAEBC:
/* 800FAEBC 8ce27dec */  lw       $v0,32236($a3)
/* 800FAEC0 00000000 */  nop      
/* 800FAEC4 34420008 */  ori      $v0,$v0,0x8
/* 800FAEC8 ace27dec */  sw       $v0,32236($a3)
.L800FAECC:
/* 800FAECC 8e030008 */  lw       $v1,8($s0)
/* 800FAED0 00000000 */  nop      
/* 800FAED4 00731021 */  addu     $v0,$v1,$s3
/* 800FAED8 28420801 */  slti     $v0,$v0,2049
/* 800FAEDC 14400003 */  bnez     $v0,.L800FAEEC
/* 800FAEE0 24020800 */  li       $v0,2048
/* 800FAEE4 0803ebbc */  j        .L800FAEF0
/* 800FAEE8 00431023 */  subu     $v0,$v0,$v1
.L800FAEEC:
/* 800FAEEC 02601021 */  move     $v0,$s3
.L800FAEF0:
/* 800FAEF0 ae020000 */  sw       $v0,0($s0)
/* 800FAEF4 02621023 */  subu     $v0,$s3,$v0
/* 800FAEF8 3c128014 */  lui      $s2,0x8014
/* 800FAEFC ae020004 */  sw       $v0,4($s0)
/* 800FAF00 8c830000 */  lw       $v1,0($a0)
/* 800FAF04 04c10002 */  bgez     $a2,.L800FAF10
/* 800FAF08 26517dec */  addiu    $s1,$s2,32236
/* 800FAF0C 24c607ff */  addiu    $a2,$a2,2047
.L800FAF10:
/* 800FAF10 3c028010 */  lui      $v0,0x8010
/* 800FAF14 2454a3e0 */  addiu    $s4,$v0,-23584
/* 800FAF18 02802021 */  move     $a0,$s4
/* 800FAF1C 8c63000c */  lw       $v1,12($v1)
/* 800FAF20 000612c3 */  sra      $v0,$a2,0xb
/* 800FAF24 ae20001c */  sw       $zero,28($s1)
/* 800FAF28 00621821 */  addu     $v1,$v1,$v0
/* 800FAF2C ae230014 */  sw       $v1,20($s1)
/* 800FAF30 3c038014 */  lui      $v1,0x8014
/* 800FAF34 8e427dec */  lw       $v0,32236($s2)
/* 800FAF38 8c63ed90 */  lw       $v1,-4720($v1)
/* 800FAF3C 34420002 */  ori      $v0,$v0,0x2
/* 800FAF40 ae427dec */  sw       $v0,32236($s2)
/* 800FAF44 00031040 */  sll      $v0,$v1,0x1
/* 800FAF48 00431021 */  addu     $v0,$v0,$v1
/* 800FAF4C 00021080 */  sll      $v0,$v0,0x2
/* 800FAF50 0c03adcc */  jal      func_800EB730
/* 800FAF54 ae220018 */  sw       $v0,24($s1)
/* 800FAF58 8e23000c */  lw       $v1,12($s1)
/* 800FAF5C 8e220014 */  lw       $v0,20($s1)
/* 800FAF60 00000000 */  nop      
/* 800FAF64 14620045 */  bne      $v1,$v0,.L800FB07C
/* 800FAF68 02601021 */  move     $v0,$s3
/* 800FAF6C 8e427dec */  lw       $v0,32236($s2)
/* 800FAF70 00000000 */  nop      
/* 800FAF74 30420010 */  andi     $v0,$v0,0x10
/* 800FAF78 1040003f */  beqz     $v0,.L800FB078
/* 800FAF7C 3c028014 */  lui      $v0,0x8014
/* 800FAF80 8c43ee4c */  lw       $v1,-4532($v0)
/* 800FAF84 24020002 */  li       $v0,2
/* 800FAF88 1462003c */  bne      $v1,$v0,.L800FB07C
/* 800FAF8C 02601021 */  move     $v0,$s3
/* 800FAF90 2622003c */  addiu    $v0,$s1,60
/* 800FAF94 8e040008 */  lw       $a0,8($s0)
/* 800FAF98 8e05000c */  lw       $a1,12($s0)
/* 800FAF9C 8e060000 */  lw       $a2,0($s0)
/* 800FAFA0 0c039b2d */  jal      func_800E6CB4
/* 800FAFA4 00822021 */  addu     $a0,$a0,$v0
/* 800FAFA8 8e020004 */  lw       $v0,4($s0)
/* 800FAFAC 00000000 */  nop      
/* 800FAFB0 1840001e */  blez     $v0,.L800FB02C
/* 800FAFB4 02802021 */  move     $a0,$s4
/* 800FAFB8 8e02000c */  lw       $v0,12($s0)
/* 800FAFBC 8e030000 */  lw       $v1,0($s0)
/* 800FAFC0 8e040004 */  lw       $a0,4($s0)
/* 800FAFC4 ae000008 */  sw       $zero,8($s0)
/* 800FAFC8 00431021 */  addu     $v0,$v0,$v1
/* 800FAFCC ae02000c */  sw       $v0,12($s0)
/* 800FAFD0 28820800 */  slti     $v0,$a0,2048
/* 800FAFD4 10400005 */  beqz     $v0,.L800FAFEC
/* 800FAFD8 00000000 */  nop      
/* 800FAFDC 8e427dec */  lw       $v0,32236($s2)
/* 800FAFE0 ae040000 */  sw       $a0,0($s0)
/* 800FAFE4 0803ec00 */  j        .L800FB000
/* 800FAFE8 34420008 */  ori      $v0,$v0,0x8
.L800FAFEC:
/* 800FAFEC 24020800 */  li       $v0,2048
/* 800FAFF0 ae020000 */  sw       $v0,0($s0)
/* 800FAFF4 8e427dec */  lw       $v0,32236($s2)
/* 800FAFF8 2403fff7 */  li       $v1,-9
/* 800FAFFC 00431024 */  and      $v0,$v0,$v1
.L800FB000:
/* 800FB000 ae427dec */  sw       $v0,32236($s2)
/* 800FB004 3c048014 */  lui      $a0,0x8014
/* 800FB008 24847dec */  addiu    $a0,$a0,32236
/* 800FB00C 8e020004 */  lw       $v0,4($s0)
/* 800FB010 8e050000 */  lw       $a1,0($s0)
/* 800FB014 8c830014 */  lw       $v1,20($a0)
/* 800FB018 00451023 */  subu     $v0,$v0,$a1
/* 800FB01C 24630001 */  addiu    $v1,$v1,1
/* 800FB020 ae020004 */  sw       $v0,4($s0)
/* 800FB024 0803ec1e */  j        .L800FB078
/* 800FB028 ac830014 */  sw       $v1,20($a0)
.L800FB02C:
/* 800FB02C 8e427dec */  lw       $v0,32236($s2)
/* 800FB030 2403fffd */  li       $v1,-3
/* 800FB034 00431024 */  and      $v0,$v0,$v1
/* 800FB038 ae427dec */  sw       $v0,32236($s2)
/* 800FB03C 0c03ade4 */  jal      func_800EB790
/* 800FB040 00000000 */  nop      
/* 800FB044 8e220030 */  lw       $v0,48($s1)
/* 800FB048 00000000 */  nop      
/* 800FB04C 1040000a */  beqz     $v0,.L800FB078
/* 800FB050 ae200018 */  sw       $zero,24($s1)
/* 800FB054 0c03adf6 */  jal      func_800EB7D8
/* 800FB058 27a40010 */  addiu    $a0,$sp,16
/* 800FB05C 8e220030 */  lw       $v0,48($s1)
/* 800FB060 00000000 */  nop      
/* 800FB064 0040f809 */  jalr     $v0
/* 800FB068 24040001 */  li       $a0,1
/* 800FB06C 8fa40010 */  lw       $a0,16($sp)
/* 800FB070 0c03adfb */  jal      func_800EB7EC
/* 800FB074 00000000 */  nop      
.L800FB078:
/* 800FB078 02601021 */  move     $v0,$s3
.L800FB07C:
/* 800FB07C 8fbf002c */  lw       $ra,44($sp)
/* 800FB080 8fb40028 */  lw       $s4,40($sp)
/* 800FB084 8fb30024 */  lw       $s3,36($sp)
/* 800FB088 8fb20020 */  lw       $s2,32($sp)
/* 800FB08C 8fb1001c */  lw       $s1,28($sp)
/* 800FB090 8fb00018 */  lw       $s0,24($sp)
/* 800FB094 03e00008 */  jr       $ra
/* 800FB098 27bd0030 */  addiu    $sp,$sp,48
