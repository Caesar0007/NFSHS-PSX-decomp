.set noat
.set noreorder

glabel func_800FB5C4
/* 800FB5C4 27bdffe0 */  addiu    $sp,$sp,-32
/* 800FB5C8 afb00010 */  sw       $s0,16($sp)
/* 800FB5CC 00808021 */  move     $s0,$a0
/* 800FB5D0 afbf0018 */  sw       $ra,24($sp)
/* 800FB5D4 afb10014 */  sw       $s1,20($sp)
/* 800FB5D8 8e030000 */  lw       $v1,0($s0)
/* 800FB5DC 00000000 */  nop      
/* 800FB5E0 2c620020 */  sltiu    $v0,$v1,32
/* 800FB5E4 1040007e */  beqz     $v0,.L800FB7E0
/* 800FB5E8 00031080 */  sll      $v0,$v1,0x2
/* 800FB5EC 3c018005 */  lui      $at,%hi(jtbl_80057B68)
/* 800FB5F0 00220821 */  addu     $at,$at,$v0
/* 800FB5F4 8c227b68 */  lw       $v0,%lo(jtbl_80057B68)($at)
/* 800FB5F8 00000000 */  nop      
/* 800FB5FC 00400008 */  jr       $v0
/* 800FB600 00000000 */  nop      
.L800FB604:
/* 800FB604 3c048010 */  lui      $a0,0x8010
/* 800FB608 2484b388 */  addiu    $a0,$a0,-19576
/* 800FB60C 3c018015 */  lui      $at,0x8015
/* 800FB610 ac208638 */  sw       $zero,-31176($at)
/* 800FB614 3c018015 */  lui      $at,0x8015
/* 800FB618 ac208634 */  sw       $zero,-31180($at)
/* 800FB61C 3c018015 */  lui      $at,0x8015
/* 800FB620 0c04298e */  jal      func_8010A638
/* 800FB624 ac208630 */  sw       $zero,-31184($at)
/* 800FB628 2402000a */  li       $v0,10
/* 800FB62C 0803edf8 */  j        .L800FB7E0
/* 800FB630 ae020000 */  sw       $v0,0($s0)
.L800FB634:
/* 800FB634 3c118015 */  lui      $s1,0x8015
/* 800FB638 26318644 */  addiu    $s1,$s1,-31164
/* 800FB63C 8e230000 */  lw       $v1,0($s1)
/* 800FB640 00000000 */  nop      
/* 800FB644 10600052 */  beqz     $v1,.L800FB790
/* 800FB648 24020003 */  li       $v0,3
/* 800FB64C 14620065 */  bne      $v1,$v0,.L800FB7E4
/* 800FB650 24020001 */  li       $v0,1
/* 800FB654 8e240008 */  lw       $a0,8($s1)
/* 800FB658 3c028015 */  lui      $v0,0x8015
/* 800FB65C 8c42863c */  lw       $v0,-31172($v0)
/* 800FB660 24030001 */  li       $v1,1
/* 800FB664 3c018015 */  lui      $at,0x8015
/* 800FB668 ac238638 */  sw       $v1,-31176($at)
/* 800FB66C 00831804 */  sllv     $v1,$v1,$a0
/* 800FB670 00431025 */  or       $v0,$v0,$v1
/* 800FB674 3c018015 */  lui      $at,0x8015
/* 800FB678 0c0428be */  jal      func_8010A2F8
/* 800FB67C ac22863c */  sw       $v0,-31172($at)
/* 800FB680 8e240008 */  lw       $a0,8($s1)
/* 800FB684 0c0429d2 */  jal      func_8010A748
/* 800FB688 00000000 */  nop      
/* 800FB68C 24020015 */  li       $v0,21
/* 800FB690 0803edf8 */  j        .L800FB7E0
/* 800FB694 ae020000 */  sw       $v0,0($s0)
.L800FB698:
/* 800FB698 0c04297b */  jal      func_8010A5EC
/* 800FB69C 00000000 */  nop      
/* 800FB6A0 10400050 */  beqz     $v0,.L800FB7E4
/* 800FB6A4 00001021 */  move     $v0,$zero
/* 800FB6A8 0c042936 */  jal      func_8010A4D8
/* 800FB6AC 00000000 */  nop      
/* 800FB6B0 2402001e */  li       $v0,30
/* 800FB6B4 ae020000 */  sw       $v0,0($s0)
.L800FB6B8:
/* 800FB6B8 0c0428be */  jal      func_8010A2F8
/* 800FB6BC 00000000 */  nop      
/* 800FB6C0 3c048015 */  lui      $a0,0x8015
/* 800FB6C4 8c84864c */  lw       $a0,-31156($a0)
/* 800FB6C8 0c0429e2 */  jal      func_8010A788
/* 800FB6CC 00000000 */  nop      
/* 800FB6D0 8e020000 */  lw       $v0,0($s0)
/* 800FB6D4 00000000 */  nop      
/* 800FB6D8 24420001 */  addiu    $v0,$v0,1
/* 800FB6DC 0803edf8 */  j        .L800FB7E0
/* 800FB6E0 ae020000 */  sw       $v0,0($s0)
.L800FB6E4:
/* 800FB6E4 0c04296c */  jal      func_8010A5B0
/* 800FB6E8 00000000 */  nop      
/* 800FB6EC 1040003d */  beqz     $v0,.L800FB7E4
/* 800FB6F0 00001021 */  move     $v0,$zero
/* 800FB6F4 0c042900 */  jal      func_8010A400
/* 800FB6F8 00000000 */  nop      
/* 800FB6FC 00401821 */  move     $v1,$v0
/* 800FB700 3c018015 */  lui      $at,0x8015
/* 800FB704 ac228634 */  sw       $v0,-31180($at)
/* 800FB708 28620003 */  slti     $v0,$v1,3
/* 800FB70C 10400007 */  beqz     $v0,.L800FB72C
/* 800FB710 00000000 */  nop      
/* 800FB714 1c600015 */  bgtz     $v1,.L800FB76C
/* 800FB718 00000000 */  nop      
/* 800FB71C 10600008 */  beqz     $v1,.L800FB740
/* 800FB720 00000000 */  nop      
/* 800FB724 0803ede7 */  j        .L800FB79C
/* 800FB728 00000000 */  nop      
.L800FB72C:
/* 800FB72C 24020004 */  li       $v0,4
/* 800FB730 1062000e */  beq      $v1,$v0,.L800FB76C
/* 800FB734 00000000 */  nop      
/* 800FB738 0803ede7 */  j        .L800FB79C
/* 800FB73C 00000000 */  nop      
.L800FB740:
/* 800FB740 3c028015 */  lui      $v0,0x8015
/* 800FB744 8c428638 */  lw       $v0,-31176($v0)
/* 800FB748 00000000 */  nop      
/* 800FB74C 10400002 */  beqz     $v0,.L800FB758
/* 800FB750 00001821 */  move     $v1,$zero
/* 800FB754 24030003 */  li       $v1,3
.L800FB758:
/* 800FB758 3c028015 */  lui      $v0,0x8015
/* 800FB75C 24428640 */  addiu    $v0,$v0,-31168
/* 800FB760 ac430004 */  sw       $v1,4($v0)
/* 800FB764 0803edf9 */  j        .L800FB7E4
/* 800FB768 24020001 */  li       $v0,1
.L800FB76C:
/* 800FB76C 3c028015 */  lui      $v0,0x8015
/* 800FB770 8c428630 */  lw       $v0,-31184($v0)
/* 800FB774 00000000 */  nop      
/* 800FB778 24420001 */  addiu    $v0,$v0,1
/* 800FB77C 3c018015 */  lui      $at,0x8015
/* 800FB780 ac228630 */  sw       $v0,-31184($at)
/* 800FB784 28420005 */  slti     $v0,$v0,5
/* 800FB788 10400004 */  beqz     $v0,.L800FB79C
/* 800FB78C 00000000 */  nop      
.L800FB790:
/* 800FB790 2402001e */  li       $v0,30
/* 800FB794 0803edf8 */  j        .L800FB7E0
/* 800FB798 ae020000 */  sw       $v0,0($s0)
.L800FB79C:
/* 800FB79C 3c048015 */  lui      $a0,0x8015
/* 800FB7A0 8c848634 */  lw       $a0,-31180($a0)
/* 800FB7A4 24020004 */  li       $v0,4
/* 800FB7A8 14820006 */  bne      $a0,$v0,.L800FB7C4
/* 800FB7AC 00000000 */  nop      
/* 800FB7B0 3c028015 */  lui      $v0,0x8015
/* 800FB7B4 24428640 */  addiu    $v0,$v0,-31168
/* 800FB7B8 ac440004 */  sw       $a0,4($v0)
/* 800FB7BC 0803edf9 */  j        .L800FB7E4
/* 800FB7C0 24020001 */  li       $v0,1
.L800FB7C4:
/* 800FB7C4 0c03f22d */  jal      func_800FC8B4
/* 800FB7C8 00000000 */  nop      
/* 800FB7CC 3c038015 */  lui      $v1,0x8015
/* 800FB7D0 24638640 */  addiu    $v1,$v1,-31168
/* 800FB7D4 ac620004 */  sw       $v0,4($v1)
/* 800FB7D8 0803edf9 */  j        .L800FB7E4
/* 800FB7DC 24020001 */  li       $v0,1
.L800FB7E0:
/* 800FB7E0 00001021 */  move     $v0,$zero
.L800FB7E4:
/* 800FB7E4 8fbf0018 */  lw       $ra,24($sp)
/* 800FB7E8 8fb10014 */  lw       $s1,20($sp)
/* 800FB7EC 8fb00010 */  lw       $s0,16($sp)
/* 800FB7F0 03e00008 */  jr       $ra
/* 800FB7F4 27bd0020 */  addiu    $sp,$sp,32

.section .rodata
glabel jtbl_80057B68
.word .L800FB604
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB634
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB698
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB7E0
.word .L800FB6B8
.word .L800FB6E4
