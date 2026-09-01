.set noat
.set noreorder

glabel func_800FB7D8
/* 800FB7D8 27bdffe0 */  addiu    $sp,$sp,-32
/* 800FB7DC afb00010 */  sw       $s0,16($sp)
/* 800FB7E0 00808021 */  move     $s0,$a0
/* 800FB7E4 afbf0018 */  sw       $ra,24($sp)
/* 800FB7E8 afb10014 */  sw       $s1,20($sp)
/* 800FB7EC 8e030000 */  lw       $v1,0($s0)
/* 800FB7F0 00000000 */  nop      
/* 800FB7F4 2c620020 */  sltiu    $v0,$v1,32
/* 800FB7F8 1040007e */  beqz     $v0,.L800FB9F4
/* 800FB7FC 00031080 */  sll      $v0,$v1,0x2
/* 800FB800 3c018005 */  lui      $at,%hi(jtbl_80057B68)
/* 800FB804 00220821 */  addu     $at,$at,$v0
/* 800FB808 8c227b68 */  lw       $v0,%lo(jtbl_80057B68)($at)
/* 800FB80C 00000000 */  nop      
/* 800FB810 00400008 */  jr       $v0
/* 800FB814 00000000 */  nop      
.L800FB818:
/* 800FB818 3c048010 */  lui      $a0,0x8010
/* 800FB81C 2484b59c */  addiu    $a0,$a0,-19044
/* 800FB820 3c018015 */  lui      $at,0x8015
/* 800FB824 ac20884c */  sw       $zero,-30644($at)
/* 800FB828 3c018015 */  lui      $at,0x8015
/* 800FB82C ac208848 */  sw       $zero,-30648($at)
/* 800FB830 3c018015 */  lui      $at,0x8015
/* 800FB834 0c042a13 */  jal      func_8010A84C
/* 800FB838 ac208844 */  sw       $zero,-30652($at)
/* 800FB83C 2402000a */  li       $v0,10
/* 800FB840 0803ee7d */  j        .L800FB9F4
/* 800FB844 ae020000 */  sw       $v0,0($s0)
.L800FB848:
/* 800FB848 3c118015 */  lui      $s1,0x8015
/* 800FB84C 26318858 */  addiu    $s1,$s1,-30632
/* 800FB850 8e230000 */  lw       $v1,0($s1)
/* 800FB854 00000000 */  nop      
/* 800FB858 10600052 */  beqz     $v1,.L800FB9A4
/* 800FB85C 24020003 */  li       $v0,3
/* 800FB860 14620065 */  bne      $v1,$v0,.L800FB9F8
/* 800FB864 24020001 */  li       $v0,1
/* 800FB868 8e240008 */  lw       $a0,8($s1)
/* 800FB86C 3c028015 */  lui      $v0,0x8015
/* 800FB870 8c428850 */  lw       $v0,-30640($v0)
/* 800FB874 24030001 */  li       $v1,1
/* 800FB878 3c018015 */  lui      $at,0x8015
/* 800FB87C ac23884c */  sw       $v1,-30644($at)
/* 800FB880 00831804 */  sllv     $v1,$v1,$a0
/* 800FB884 00431025 */  or       $v0,$v0,$v1
/* 800FB888 3c018015 */  lui      $at,0x8015
/* 800FB88C 0c042943 */  jal      func_8010A50C
/* 800FB890 ac228850 */  sw       $v0,-30640($at)
/* 800FB894 8e240008 */  lw       $a0,8($s1)
/* 800FB898 0c042a57 */  jal      func_8010A95C
/* 800FB89C 00000000 */  nop      
/* 800FB8A0 24020015 */  li       $v0,21
/* 800FB8A4 0803ee7d */  j        .L800FB9F4
/* 800FB8A8 ae020000 */  sw       $v0,0($s0)
.L800FB8AC:
/* 800FB8AC 0c042a00 */  jal      func_8010A800
/* 800FB8B0 00000000 */  nop      
/* 800FB8B4 10400050 */  beqz     $v0,.L800FB9F8
/* 800FB8B8 00001021 */  move     $v0,$zero
/* 800FB8BC 0c0429bb */  jal      func_8010A6EC
/* 800FB8C0 00000000 */  nop      
/* 800FB8C4 2402001e */  li       $v0,30
/* 800FB8C8 ae020000 */  sw       $v0,0($s0)
.L800FB8CC:
/* 800FB8CC 0c042943 */  jal      func_8010A50C
/* 800FB8D0 00000000 */  nop      
/* 800FB8D4 3c048015 */  lui      $a0,0x8015
/* 800FB8D8 8c848860 */  lw       $a0,-30624($a0)
/* 800FB8DC 0c042a67 */  jal      func_8010A99C
/* 800FB8E0 00000000 */  nop      
/* 800FB8E4 8e020000 */  lw       $v0,0($s0)
/* 800FB8E8 00000000 */  nop      
/* 800FB8EC 24420001 */  addiu    $v0,$v0,1
/* 800FB8F0 0803ee7d */  j        .L800FB9F4
/* 800FB8F4 ae020000 */  sw       $v0,0($s0)
.L800FB8F8:
/* 800FB8F8 0c0429f1 */  jal      func_8010A7C4
/* 800FB8FC 00000000 */  nop      
/* 800FB900 1040003d */  beqz     $v0,.L800FB9F8
/* 800FB904 00001021 */  move     $v0,$zero
/* 800FB908 0c042985 */  jal      func_8010A614
/* 800FB90C 00000000 */  nop      
/* 800FB910 00401821 */  move     $v1,$v0
/* 800FB914 3c018015 */  lui      $at,0x8015
/* 800FB918 ac228848 */  sw       $v0,-30648($at)
/* 800FB91C 28620003 */  slti     $v0,$v1,3
/* 800FB920 10400007 */  beqz     $v0,.L800FB940
/* 800FB924 00000000 */  nop      
/* 800FB928 1c600015 */  bgtz     $v1,.L800FB980
/* 800FB92C 00000000 */  nop      
/* 800FB930 10600008 */  beqz     $v1,.L800FB954
/* 800FB934 00000000 */  nop      
/* 800FB938 0803ee6c */  j        .L800FB9B0
/* 800FB93C 00000000 */  nop      
.L800FB940:
/* 800FB940 24020004 */  li       $v0,4
/* 800FB944 1062000e */  beq      $v1,$v0,.L800FB980
/* 800FB948 00000000 */  nop      
/* 800FB94C 0803ee6c */  j        .L800FB9B0
/* 800FB950 00000000 */  nop      
.L800FB954:
/* 800FB954 3c028015 */  lui      $v0,0x8015
/* 800FB958 8c42884c */  lw       $v0,-30644($v0)
/* 800FB95C 00000000 */  nop      
/* 800FB960 10400002 */  beqz     $v0,.L800FB96C
/* 800FB964 00001821 */  move     $v1,$zero
/* 800FB968 24030003 */  li       $v1,3
.L800FB96C:
/* 800FB96C 3c028015 */  lui      $v0,0x8015
/* 800FB970 24428854 */  addiu    $v0,$v0,-30636
/* 800FB974 ac430004 */  sw       $v1,4($v0)
/* 800FB978 0803ee7e */  j        .L800FB9F8
/* 800FB97C 24020001 */  li       $v0,1
.L800FB980:
/* 800FB980 3c028015 */  lui      $v0,0x8015
/* 800FB984 8c428844 */  lw       $v0,-30652($v0)
/* 800FB988 00000000 */  nop      
/* 800FB98C 24420001 */  addiu    $v0,$v0,1
/* 800FB990 3c018015 */  lui      $at,0x8015
/* 800FB994 ac228844 */  sw       $v0,-30652($at)
/* 800FB998 28420005 */  slti     $v0,$v0,5
/* 800FB99C 10400004 */  beqz     $v0,.L800FB9B0
/* 800FB9A0 00000000 */  nop      
.L800FB9A4:
/* 800FB9A4 2402001e */  li       $v0,30
/* 800FB9A8 0803ee7d */  j        .L800FB9F4
/* 800FB9AC ae020000 */  sw       $v0,0($s0)
.L800FB9B0:
/* 800FB9B0 3c048015 */  lui      $a0,0x8015
/* 800FB9B4 8c848848 */  lw       $a0,-30648($a0)
/* 800FB9B8 24020004 */  li       $v0,4
/* 800FB9BC 14820006 */  bne      $a0,$v0,.L800FB9D8
/* 800FB9C0 00000000 */  nop      
/* 800FB9C4 3c028015 */  lui      $v0,0x8015
/* 800FB9C8 24428854 */  addiu    $v0,$v0,-30636
/* 800FB9CC ac440004 */  sw       $a0,4($v0)
/* 800FB9D0 0803ee7e */  j        .L800FB9F8
/* 800FB9D4 24020001 */  li       $v0,1
.L800FB9D8:
/* 800FB9D8 0c03f2b2 */  jal      func_800FCAC8
/* 800FB9DC 00000000 */  nop      
/* 800FB9E0 3c038015 */  lui      $v1,0x8015
/* 800FB9E4 24638854 */  addiu    $v1,$v1,-30636
/* 800FB9E8 ac620004 */  sw       $v0,4($v1)
/* 800FB9EC 0803ee7e */  j        .L800FB9F8
/* 800FB9F0 24020001 */  li       $v0,1
.L800FB9F4:
/* 800FB9F4 00001021 */  move     $v0,$zero
.L800FB9F8:
/* 800FB9F8 8fbf0018 */  lw       $ra,24($sp)
/* 800FB9FC 8fb10014 */  lw       $s1,20($sp)
/* 800FBA00 8fb00010 */  lw       $s0,16($sp)
/* 800FBA04 03e00008 */  jr       $ra
/* 800FBA08 27bd0020 */  addiu    $sp,$sp,32

.section .rodata
glabel jtbl_80057B68
.word .L800FB818
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB848
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB8AC
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB9F4
.word .L800FB8CC
.word .L800FB8F8
