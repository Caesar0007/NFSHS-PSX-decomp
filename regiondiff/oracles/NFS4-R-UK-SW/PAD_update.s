.set noat
.set noreorder

glabel func_800E4DF4
/* 800E4DF4 27bdffd8 */  addiu    $sp,$sp,-40
/* 800E4DF8 afb20018 */  sw       $s2,24($sp)
/* 800E4DFC 00009021 */  move     $s2,$zero
/* 800E4E00 3c028014 */  lui      $v0,0x8014
/* 800E4E04 2442fbd4 */  addiu    $v0,$v0,-1068
/* 800E4E08 afb3001c */  sw       $s3,28($sp)
/* 800E4E0C 24530008 */  addiu    $s3,$v0,8
/* 800E4E10 afb10014 */  sw       $s1,20($sp)
/* 800E4E14 00408821 */  move     $s1,$v0
/* 800E4E18 3c028014 */  lui      $v0,0x8014
/* 800E4E1C afb00010 */  sw       $s0,16($sp)
/* 800E4E20 2450fc24 */  addiu    $s0,$v0,-988
/* 800E4E24 afbf0020 */  sw       $ra,32($sp)
.L800E4E28:
/* 800E4E28 92020000 */  lbu      $v0,0($s0)
/* 800E4E2C 00000000 */  nop      
/* 800E4E30 10400003 */  beqz     $v0,.L800E4E40
/* 800E4E34 02202021 */  move     $a0,$s1
/* 800E4E38 08039396 */  j        .L800E4E58
/* 800E4E3C 24050020 */  li       $a1,32
.L800E4E40:
/* 800E4E40 02002021 */  move     $a0,$s0
/* 800E4E44 02202821 */  move     $a1,$s1
/* 800E4E48 0c039bad */  jal      func_800E6EB4
/* 800E4E4C 24060008 */  li       $a2,8
/* 800E4E50 02602021 */  move     $a0,$s3
/* 800E4E54 24050018 */  li       $a1,24
.L800E4E58:
/* 800E4E58 0c03c941 */  jal      func_800F2504
/* 800E4E5C 240600ff */  li       $a2,255
/* 800E4E60 26730020 */  addiu    $s3,$s3,32
/* 800E4E64 26310020 */  addiu    $s1,$s1,32
/* 800E4E68 26520001 */  addiu    $s2,$s2,1
/* 800E4E6C 2a420002 */  slti     $v0,$s2,2
/* 800E4E70 1440ffed */  bnez     $v0,.L800E4E28
/* 800E4E74 26100022 */  addiu    $s0,$s0,34
/* 800E4E78 00009021 */  move     $s2,$zero
/* 800E4E7C 3c028014 */  lui      $v0,0x8014
/* 800E4E80 2444fbd0 */  addiu    $a0,$v0,-1072
/* 800E4E84 00803021 */  move     $a2,$a0
.L800E4E88:
/* 800E4E88 90c20004 */  lbu      $v0,4($a2)
/* 800E4E8C 90830044 */  lbu      $v1,68($a0)
/* 800E4E90 2c450001 */  sltiu    $a1,$v0,1
/* 800E4E94 10a3000a */  beq      $a1,$v1,.L800E4EC0
/* 800E4E98 00000000 */  nop      
/* 800E4E9C 90820045 */  lbu      $v0,69($a0)
/* 800E4EA0 00000000 */  nop      
/* 800E4EA4 24430001 */  addiu    $v1,$v0,1
/* 800E4EA8 304200ff */  andi     $v0,$v0,0xff
/* 800E4EAC 2c420006 */  sltiu    $v0,$v0,6
/* 800E4EB0 14400003 */  bnez     $v0,.L800E4EC0
/* 800E4EB4 a0830045 */  sb       $v1,69($a0)
/* 800E4EB8 a0850044 */  sb       $a1,68($a0)
/* 800E4EBC a0800045 */  sb       $zero,69($a0)
.L800E4EC0:
/* 800E4EC0 24840002 */  addiu    $a0,$a0,2
/* 800E4EC4 26520001 */  addiu    $s2,$s2,1
/* 800E4EC8 2a420008 */  slti     $v0,$s2,8
/* 800E4ECC 1440ffee */  bnez     $v0,.L800E4E88
/* 800E4ED0 24c60008 */  addiu    $a2,$a2,8
/* 800E4ED4 8fbf0020 */  lw       $ra,32($sp)
/* 800E4ED8 8fb3001c */  lw       $s3,28($sp)
/* 800E4EDC 8fb20018 */  lw       $s2,24($sp)
/* 800E4EE0 8fb10014 */  lw       $s1,20($sp)
/* 800E4EE4 8fb00010 */  lw       $s0,16($sp)
/* 800E4EE8 03e00008 */  jr       $ra
/* 800E4EEC 27bd0028 */  addiu    $sp,$sp,40
