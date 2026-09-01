.set noat
.set noreorder

glabel func_800E4BF4
/* 800E4BF4 27bdffd8 */  addiu    $sp,$sp,-40
/* 800E4BF8 afb20018 */  sw       $s2,24($sp)
/* 800E4BFC 00009021 */  move     $s2,$zero
/* 800E4C00 3c028014 */  lui      $v0,0x8014
/* 800E4C04 2442f994 */  addiu    $v0,$v0,-1644
/* 800E4C08 afb3001c */  sw       $s3,28($sp)
/* 800E4C0C 24530008 */  addiu    $s3,$v0,8
/* 800E4C10 afb10014 */  sw       $s1,20($sp)
/* 800E4C14 00408821 */  move     $s1,$v0
/* 800E4C18 3c028014 */  lui      $v0,0x8014
/* 800E4C1C afb00010 */  sw       $s0,16($sp)
/* 800E4C20 2450f9e4 */  addiu    $s0,$v0,-1564
/* 800E4C24 afbf0020 */  sw       $ra,32($sp)
.L800E4C28:
/* 800E4C28 92020000 */  lbu      $v0,0($s0)
/* 800E4C2C 00000000 */  nop      
/* 800E4C30 10400003 */  beqz     $v0,.L800E4C40
/* 800E4C34 02202021 */  move     $a0,$s1
/* 800E4C38 08039316 */  j        .L800E4C58
/* 800E4C3C 24050020 */  li       $a1,32
.L800E4C40:
/* 800E4C40 02002021 */  move     $a0,$s0
/* 800E4C44 02202821 */  move     $a1,$s1
/* 800E4C48 0c039b2d */  jal      func_800E6CB4
/* 800E4C4C 24060008 */  li       $a2,8
/* 800E4C50 02602021 */  move     $a0,$s3
/* 800E4C54 24050018 */  li       $a1,24
.L800E4C58:
/* 800E4C58 0c03c8b1 */  jal      func_800F22C4
/* 800E4C5C 240600ff */  li       $a2,255
/* 800E4C60 26730020 */  addiu    $s3,$s3,32
/* 800E4C64 26310020 */  addiu    $s1,$s1,32
/* 800E4C68 26520001 */  addiu    $s2,$s2,1
/* 800E4C6C 2a420002 */  slti     $v0,$s2,2
/* 800E4C70 1440ffed */  bnez     $v0,.L800E4C28
/* 800E4C74 26100022 */  addiu    $s0,$s0,34
/* 800E4C78 00009021 */  move     $s2,$zero
/* 800E4C7C 3c028014 */  lui      $v0,0x8014
/* 800E4C80 2444f990 */  addiu    $a0,$v0,-1648
/* 800E4C84 00803021 */  move     $a2,$a0
.L800E4C88:
/* 800E4C88 90c20004 */  lbu      $v0,4($a2)
/* 800E4C8C 90830044 */  lbu      $v1,68($a0)
/* 800E4C90 2c450001 */  sltiu    $a1,$v0,1
/* 800E4C94 10a3000a */  beq      $a1,$v1,.L800E4CC0
/* 800E4C98 00000000 */  nop      
/* 800E4C9C 90820045 */  lbu      $v0,69($a0)
/* 800E4CA0 00000000 */  nop      
/* 800E4CA4 24430001 */  addiu    $v1,$v0,1
/* 800E4CA8 304200ff */  andi     $v0,$v0,0xff
/* 800E4CAC 2c420006 */  sltiu    $v0,$v0,6
/* 800E4CB0 14400003 */  bnez     $v0,.L800E4CC0
/* 800E4CB4 a0830045 */  sb       $v1,69($a0)
/* 800E4CB8 a0850044 */  sb       $a1,68($a0)
/* 800E4CBC a0800045 */  sb       $zero,69($a0)
.L800E4CC0:
/* 800E4CC0 24840002 */  addiu    $a0,$a0,2
/* 800E4CC4 26520001 */  addiu    $s2,$s2,1
/* 800E4CC8 2a420008 */  slti     $v0,$s2,8
/* 800E4CCC 1440ffee */  bnez     $v0,.L800E4C88
/* 800E4CD0 24c60008 */  addiu    $a2,$a2,8
/* 800E4CD4 8fbf0020 */  lw       $ra,32($sp)
/* 800E4CD8 8fb3001c */  lw       $s3,28($sp)
/* 800E4CDC 8fb20018 */  lw       $s2,24($sp)
/* 800E4CE0 8fb10014 */  lw       $s1,20($sp)
/* 800E4CE4 8fb00010 */  lw       $s0,16($sp)
/* 800E4CE8 03e00008 */  jr       $ra
/* 800E4CEC 27bd0028 */  addiu    $sp,$sp,40
