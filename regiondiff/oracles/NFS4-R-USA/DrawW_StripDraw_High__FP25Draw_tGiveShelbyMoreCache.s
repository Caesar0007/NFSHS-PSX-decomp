.set noat
.set noreorder

glabel func_800C7C30
/* 800C7C30 27bdffd0 */  addiu    $sp,$sp,-48
/* 800C7C34 afb40028 */  sw       $s4,40($sp)
/* 800C7C38 0080a021 */  move     $s4,$a0
/* 800C7C3C afbf002c */  sw       $ra,44($sp)
/* 800C7C40 afb30024 */  sw       $s3,36($sp)
/* 800C7C44 afb20020 */  sw       $s2,32($sp)
/* 800C7C48 afb1001c */  sw       $s1,28($sp)
/* 800C7C4C afb00018 */  sw       $s0,24($sp)
/* 800C7C50 8e910100 */  lw       $s1,256($s4)
/* 800C7C54 24020001 */  li       $v0,1
/* 800C7C58 a68200da */  sh       $v0,218($s4)
.L800C7C5C:
/* 800C7C5C 96820104 */  lhu      $v0,260($s4)
/* 800C7C60 2403ffff */  li       $v1,-1
/* 800C7C64 2442ffff */  addiu    $v0,$v0,-1
/* 800C7C68 a6820104 */  sh       $v0,260($s4)
/* 800C7C6C 00021400 */  sll      $v0,$v0,0x10
/* 800C7C70 00021403 */  sra      $v0,$v0,0x10
/* 800C7C74 1043001a */  beq      $v0,$v1,.L800C7CE0
/* 800C7C78 00008021 */  move     $s0,$zero
/* 800C7C7C 92330002 */  lbu      $s3,2($s1)
/* 800C7C80 26320004 */  addiu    $s2,$s1,4
.L800C7C84:
/* 800C7C84 0213102a */  slt      $v0,$s0,$s3
/* 800C7C88 10400012 */  beqz     $v0,.L800C7CD4
/* 800C7C8C 02802021 */  move     $a0,$s4
/* 800C7C90 96420000 */  lhu      $v0,0($s2)
/* 800C7C94 26520002 */  addiu    $s2,$s2,2
/* 800C7C98 27a50010 */  addiu    $a1,$sp,16
/* 800C7C9C a7a20010 */  sh       $v0,16($sp)
/* 800C7CA0 92220000 */  lbu      $v0,0($s1)
/* 800C7CA4 92230001 */  lbu      $v1,1($s1)
/* 800C7CA8 00501021 */  addu     $v0,$v0,$s0
/* 800C7CAC a3a20013 */  sb       $v0,19($sp)
/* 800C7CB0 24420001 */  addiu    $v0,$v0,1
/* 800C7CB4 00701821 */  addu     $v1,$v1,$s0
/* 800C7CB8 a3a30014 */  sb       $v1,20($sp)
/* 800C7CBC 24630001 */  addiu    $v1,$v1,1
/* 800C7CC0 a3a20012 */  sb       $v0,18($sp)
/* 800C7CC4 0c031ca2 */  jal      func_800C7288
/* 800C7CC8 a3a30015 */  sb       $v1,21($sp)
/* 800C7CCC 08031f21 */  j        .L800C7C84
/* 800C7CD0 26100001 */  addiu    $s0,$s0,1
.L800C7CD4:
/* 800C7CD4 92220003 */  lbu      $v0,3($s1)
/* 800C7CD8 08031f17 */  j        .L800C7C5C
/* 800C7CDC 02228821 */  addu     $s1,$s1,$v0
.L800C7CE0:
/* 800C7CE0 8fbf002c */  lw       $ra,44($sp)
/* 800C7CE4 8fb40028 */  lw       $s4,40($sp)
/* 800C7CE8 8fb30024 */  lw       $s3,36($sp)
/* 800C7CEC 8fb20020 */  lw       $s2,32($sp)
/* 800C7CF0 8fb1001c */  lw       $s1,28($sp)
/* 800C7CF4 8fb00018 */  lw       $s0,24($sp)
/* 800C7CF8 03e00008 */  jr       $ra
/* 800C7CFC 27bd0030 */  addiu    $sp,$sp,48
