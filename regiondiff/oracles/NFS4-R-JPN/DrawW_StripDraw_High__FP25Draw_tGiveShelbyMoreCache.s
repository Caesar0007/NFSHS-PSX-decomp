.set noat
.set noreorder

glabel func_800C7A1C
/* 800C7A1C 27bdffd0 */  addiu    $sp,$sp,-48
/* 800C7A20 afb40028 */  sw       $s4,40($sp)
/* 800C7A24 0080a021 */  move     $s4,$a0
/* 800C7A28 afbf002c */  sw       $ra,44($sp)
/* 800C7A2C afb30024 */  sw       $s3,36($sp)
/* 800C7A30 afb20020 */  sw       $s2,32($sp)
/* 800C7A34 afb1001c */  sw       $s1,28($sp)
/* 800C7A38 afb00018 */  sw       $s0,24($sp)
/* 800C7A3C 8e910100 */  lw       $s1,256($s4)
/* 800C7A40 24020001 */  li       $v0,1
/* 800C7A44 a68200da */  sh       $v0,218($s4)
.L800C7A48:
/* 800C7A48 96820104 */  lhu      $v0,260($s4)
/* 800C7A4C 2403ffff */  li       $v1,-1
/* 800C7A50 2442ffff */  addiu    $v0,$v0,-1
/* 800C7A54 a6820104 */  sh       $v0,260($s4)
/* 800C7A58 00021400 */  sll      $v0,$v0,0x10
/* 800C7A5C 00021403 */  sra      $v0,$v0,0x10
/* 800C7A60 1043001a */  beq      $v0,$v1,.L800C7ACC
/* 800C7A64 00008021 */  move     $s0,$zero
/* 800C7A68 92330002 */  lbu      $s3,2($s1)
/* 800C7A6C 26320004 */  addiu    $s2,$s1,4
.L800C7A70:
/* 800C7A70 0213102a */  slt      $v0,$s0,$s3
/* 800C7A74 10400012 */  beqz     $v0,.L800C7AC0
/* 800C7A78 02802021 */  move     $a0,$s4
/* 800C7A7C 96420000 */  lhu      $v0,0($s2)
/* 800C7A80 26520002 */  addiu    $s2,$s2,2
/* 800C7A84 27a50010 */  addiu    $a1,$sp,16
/* 800C7A88 a7a20010 */  sh       $v0,16($sp)
/* 800C7A8C 92220000 */  lbu      $v0,0($s1)
/* 800C7A90 92230001 */  lbu      $v1,1($s1)
/* 800C7A94 00501021 */  addu     $v0,$v0,$s0
/* 800C7A98 a3a20013 */  sb       $v0,19($sp)
/* 800C7A9C 24420001 */  addiu    $v0,$v0,1
/* 800C7AA0 00701821 */  addu     $v1,$v1,$s0
/* 800C7AA4 a3a30014 */  sb       $v1,20($sp)
/* 800C7AA8 24630001 */  addiu    $v1,$v1,1
/* 800C7AAC a3a20012 */  sb       $v0,18($sp)
/* 800C7AB0 0c031c1d */  jal      func_800C7074
/* 800C7AB4 a3a30015 */  sb       $v1,21($sp)
/* 800C7AB8 08031e9c */  j        .L800C7A70
/* 800C7ABC 26100001 */  addiu    $s0,$s0,1
.L800C7AC0:
/* 800C7AC0 92220003 */  lbu      $v0,3($s1)
/* 800C7AC4 08031e92 */  j        .L800C7A48
/* 800C7AC8 02228821 */  addu     $s1,$s1,$v0
.L800C7ACC:
/* 800C7ACC 8fbf002c */  lw       $ra,44($sp)
/* 800C7AD0 8fb40028 */  lw       $s4,40($sp)
/* 800C7AD4 8fb30024 */  lw       $s3,36($sp)
/* 800C7AD8 8fb20020 */  lw       $s2,32($sp)
/* 800C7ADC 8fb1001c */  lw       $s1,28($sp)
/* 800C7AE0 8fb00018 */  lw       $s0,24($sp)
/* 800C7AE4 03e00008 */  jr       $ra
/* 800C7AE8 27bd0030 */  addiu    $sp,$sp,48
