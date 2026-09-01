.set noat
.set noreorder

glabel func_800FB804
/* 800FB804 27bdffe0 */  addiu    $sp,$sp,-32
/* 800FB808 afb00010 */  sw       $s0,16($sp)
/* 800FB80C 00808021 */  move     $s0,$a0
/* 800FB810 afbf0018 */  sw       $ra,24($sp)
/* 800FB814 afb10014 */  sw       $s1,20($sp)
/* 800FB818 8e030000 */  lw       $v1,0($s0)
/* 800FB81C 00000000 */  nop      
/* 800FB820 2c620020 */  sltiu    $v0,$v1,32
/* 800FB824 1040007e */  beqz     $v0,.L800FBA20
/* 800FB828 00031080 */  sll      $v0,$v1,0x2
/* 800FB82C 3c018005 */  lui      $at,%hi(jtbl_80057B68)
/* 800FB830 00220821 */  addu     $at,$at,$v0
/* 800FB834 8c227b68 */  lw       $v0,%lo(jtbl_80057B68)($at)
/* 800FB838 00000000 */  nop      
/* 800FB83C 00400008 */  jr       $v0
/* 800FB840 00000000 */  nop      
.L800FB844:
/* 800FB844 3c048010 */  lui      $a0,0x8010
/* 800FB848 2484b5c8 */  addiu    $a0,$a0,-19000
/* 800FB84C 3c018015 */  lui      $at,0x8015
/* 800FB850 ac208878 */  sw       $zero,-30600($at)
/* 800FB854 3c018015 */  lui      $at,0x8015
/* 800FB858 ac208874 */  sw       $zero,-30604($at)
/* 800FB85C 3c018015 */  lui      $at,0x8015
/* 800FB860 0c042a1e */  jal      func_8010A878
/* 800FB864 ac208870 */  sw       $zero,-30608($at)
/* 800FB868 2402000a */  li       $v0,10
/* 800FB86C 0803ee88 */  j        .L800FBA20
/* 800FB870 ae020000 */  sw       $v0,0($s0)
.L800FB874:
/* 800FB874 3c118015 */  lui      $s1,0x8015
/* 800FB878 26318884 */  addiu    $s1,$s1,-30588
/* 800FB87C 8e230000 */  lw       $v1,0($s1)
/* 800FB880 00000000 */  nop      
/* 800FB884 10600052 */  beqz     $v1,.L800FB9D0
/* 800FB888 24020003 */  li       $v0,3
/* 800FB88C 14620065 */  bne      $v1,$v0,.L800FBA24
/* 800FB890 24020001 */  li       $v0,1
/* 800FB894 8e240008 */  lw       $a0,8($s1)
/* 800FB898 3c028015 */  lui      $v0,0x8015
/* 800FB89C 8c42887c */  lw       $v0,-30596($v0)
/* 800FB8A0 24030001 */  li       $v1,1
/* 800FB8A4 3c018015 */  lui      $at,0x8015
/* 800FB8A8 ac238878 */  sw       $v1,-30600($at)
/* 800FB8AC 00831804 */  sllv     $v1,$v1,$a0
/* 800FB8B0 00431025 */  or       $v0,$v0,$v1
/* 800FB8B4 3c018015 */  lui      $at,0x8015
/* 800FB8B8 0c04294e */  jal      func_8010A538
/* 800FB8BC ac22887c */  sw       $v0,-30596($at)
/* 800FB8C0 8e240008 */  lw       $a0,8($s1)
/* 800FB8C4 0c042a62 */  jal      func_8010A988
/* 800FB8C8 00000000 */  nop      
/* 800FB8CC 24020015 */  li       $v0,21
/* 800FB8D0 0803ee88 */  j        .L800FBA20
/* 800FB8D4 ae020000 */  sw       $v0,0($s0)
.L800FB8D8:
/* 800FB8D8 0c042a0b */  jal      func_8010A82C
/* 800FB8DC 00000000 */  nop      
/* 800FB8E0 10400050 */  beqz     $v0,.L800FBA24
/* 800FB8E4 00001021 */  move     $v0,$zero
/* 800FB8E8 0c0429c6 */  jal      func_8010A718
/* 800FB8EC 00000000 */  nop      
/* 800FB8F0 2402001e */  li       $v0,30
/* 800FB8F4 ae020000 */  sw       $v0,0($s0)
.L800FB8F8:
/* 800FB8F8 0c04294e */  jal      func_8010A538
/* 800FB8FC 00000000 */  nop      
/* 800FB900 3c048015 */  lui      $a0,0x8015
/* 800FB904 8c84888c */  lw       $a0,-30580($a0)
/* 800FB908 0c042a72 */  jal      func_8010A9C8
/* 800FB90C 00000000 */  nop      
/* 800FB910 8e020000 */  lw       $v0,0($s0)
/* 800FB914 00000000 */  nop      
/* 800FB918 24420001 */  addiu    $v0,$v0,1
/* 800FB91C 0803ee88 */  j        .L800FBA20
/* 800FB920 ae020000 */  sw       $v0,0($s0)
.L800FB924:
/* 800FB924 0c0429fc */  jal      func_8010A7F0
/* 800FB928 00000000 */  nop      
/* 800FB92C 1040003d */  beqz     $v0,.L800FBA24
/* 800FB930 00001021 */  move     $v0,$zero
/* 800FB934 0c042990 */  jal      func_8010A640
/* 800FB938 00000000 */  nop      
/* 800FB93C 00401821 */  move     $v1,$v0
/* 800FB940 3c018015 */  lui      $at,0x8015
/* 800FB944 ac228874 */  sw       $v0,-30604($at)
/* 800FB948 28620003 */  slti     $v0,$v1,3
/* 800FB94C 10400007 */  beqz     $v0,.L800FB96C
/* 800FB950 00000000 */  nop      
/* 800FB954 1c600015 */  bgtz     $v1,.L800FB9AC
/* 800FB958 00000000 */  nop      
/* 800FB95C 10600008 */  beqz     $v1,.L800FB980
/* 800FB960 00000000 */  nop      
/* 800FB964 0803ee77 */  j        .L800FB9DC
/* 800FB968 00000000 */  nop      
.L800FB96C:
/* 800FB96C 24020004 */  li       $v0,4
/* 800FB970 1062000e */  beq      $v1,$v0,.L800FB9AC
/* 800FB974 00000000 */  nop      
/* 800FB978 0803ee77 */  j        .L800FB9DC
/* 800FB97C 00000000 */  nop      
.L800FB980:
/* 800FB980 3c028015 */  lui      $v0,0x8015
/* 800FB984 8c428878 */  lw       $v0,-30600($v0)
/* 800FB988 00000000 */  nop      
/* 800FB98C 10400002 */  beqz     $v0,.L800FB998
/* 800FB990 00001821 */  move     $v1,$zero
/* 800FB994 24030003 */  li       $v1,3
.L800FB998:
/* 800FB998 3c028015 */  lui      $v0,0x8015
/* 800FB99C 24428880 */  addiu    $v0,$v0,-30592
/* 800FB9A0 ac430004 */  sw       $v1,4($v0)
/* 800FB9A4 0803ee89 */  j        .L800FBA24
/* 800FB9A8 24020001 */  li       $v0,1
.L800FB9AC:
/* 800FB9AC 3c028015 */  lui      $v0,0x8015
/* 800FB9B0 8c428870 */  lw       $v0,-30608($v0)
/* 800FB9B4 00000000 */  nop      
/* 800FB9B8 24420001 */  addiu    $v0,$v0,1
/* 800FB9BC 3c018015 */  lui      $at,0x8015
/* 800FB9C0 ac228870 */  sw       $v0,-30608($at)
/* 800FB9C4 28420005 */  slti     $v0,$v0,5
/* 800FB9C8 10400004 */  beqz     $v0,.L800FB9DC
/* 800FB9CC 00000000 */  nop      
.L800FB9D0:
/* 800FB9D0 2402001e */  li       $v0,30
/* 800FB9D4 0803ee88 */  j        .L800FBA20
/* 800FB9D8 ae020000 */  sw       $v0,0($s0)
.L800FB9DC:
/* 800FB9DC 3c048015 */  lui      $a0,0x8015
/* 800FB9E0 8c848874 */  lw       $a0,-30604($a0)
/* 800FB9E4 24020004 */  li       $v0,4
/* 800FB9E8 14820006 */  bne      $a0,$v0,.L800FBA04
/* 800FB9EC 00000000 */  nop      
/* 800FB9F0 3c028015 */  lui      $v0,0x8015
/* 800FB9F4 24428880 */  addiu    $v0,$v0,-30592
/* 800FB9F8 ac440004 */  sw       $a0,4($v0)
/* 800FB9FC 0803ee89 */  j        .L800FBA24
/* 800FBA00 24020001 */  li       $v0,1
.L800FBA04:
/* 800FBA04 0c03f2bd */  jal      func_800FCAF4
/* 800FBA08 00000000 */  nop      
/* 800FBA0C 3c038015 */  lui      $v1,0x8015
/* 800FBA10 24638880 */  addiu    $v1,$v1,-30592
/* 800FBA14 ac620004 */  sw       $v0,4($v1)
/* 800FBA18 0803ee89 */  j        .L800FBA24
/* 800FBA1C 24020001 */  li       $v0,1
.L800FBA20:
/* 800FBA20 00001021 */  move     $v0,$zero
.L800FBA24:
/* 800FBA24 8fbf0018 */  lw       $ra,24($sp)
/* 800FBA28 8fb10014 */  lw       $s1,20($sp)
/* 800FBA2C 8fb00010 */  lw       $s0,16($sp)
/* 800FBA30 03e00008 */  jr       $ra
/* 800FBA34 27bd0020 */  addiu    $sp,$sp,32

.section .rodata
glabel jtbl_80057B68
.word .L800FB844
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FB874
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FB8D8
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FBA20
.word .L800FB8F8
.word .L800FB924
