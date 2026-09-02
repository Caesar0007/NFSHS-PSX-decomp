.set noat
.set noreorder

glabel func_8004AF30
/* 8004AF30 27bdffd8 */  addiu    $sp,$sp,-40
/* 8004AF34 afb20018 */  sw       $s2,24($sp)
/* 8004AF38 00809021 */  move     $s2,$a0
/* 8004AF3C afb10014 */  sw       $s1,20($sp)
/* 8004AF40 00008821 */  move     $s1,$zero
/* 8004AF44 24020080 */  li       $v0,128
/* 8004AF48 3c068005 */  lui      $a2,0x8005
/* 8004AF4C 84c42908 */  lh       $a0,10504($a2)
/* 8004AF50 3c058005 */  lui      $a1,0x8005
/* 8004AF54 afbf0020 */  sw       $ra,32($sp)
/* 8004AF58 afb3001c */  sw       $s3,28($sp)
/* 8004AF5C afb00010 */  sw       $s0,16($sp)
/* 8004AF60 a6420068 */  sh       $v0,104($s2)
/* 8004AF64 24020082 */  li       $v0,130
/* 8004AF68 00041900 */  sll      $v1,$a0,0x4
/* 8004AF6C 00641823 */  subu     $v1,$v1,$a0
/* 8004AF70 00031843 */  sra      $v1,$v1,0x1
/* 8004AF74 00431023 */  subu     $v0,$v0,$v1
/* 8004AF78 18800014 */  blez     $a0,.L8004AFCC
/* 8004AF7C a4a2290a */  sh       $v0,10506($a1)
/* 8004AF80 00c09821 */  move     $s3,$a2
/* 8004AF84 00118400 */  sll      $s0,$s1,0x10
.L8004AF88:
/* 8004AF88 00108403 */  sra      $s0,$s0,0x10
/* 8004AF8C 0c02e733 */  jal      func_800B9CCC
/* 8004AF90 260401fc */  addiu    $a0,$s0,508
/* 8004AF94 001020c0 */  sll      $a0,$s0,0x3
/* 8004AF98 00902021 */  addu     $a0,$a0,$s0
/* 8004AF9C 24840070 */  addiu    $a0,$a0,112
/* 8004AFA0 02442021 */  addu     $a0,$s2,$a0
/* 8004AFA4 0c0393a5 */  jal      func_800E4E94
/* 8004AFA8 00402821 */  move     $a1,$v0
/* 8004AFAC 26220001 */  addiu    $v0,$s1,1
/* 8004AFB0 00408821 */  move     $s1,$v0
/* 8004AFB4 00021400 */  sll      $v0,$v0,0x10
/* 8004AFB8 86632908 */  lh       $v1,10504($s3)
/* 8004AFBC 00021403 */  sra      $v0,$v0,0x10
/* 8004AFC0 0043102a */  slt      $v0,$v0,$v1
/* 8004AFC4 1440fff0 */  bnez     $v0,.L8004AF88
/* 8004AFC8 00118400 */  sll      $s0,$s1,0x10
.L8004AFCC:
/* 8004AFCC 0c009765 */  jal      func_80025D94
/* 8004AFD0 02402021 */  move     $a0,$s2
/* 8004AFD4 8fbf0020 */  lw       $ra,32($sp)
/* 8004AFD8 8fb3001c */  lw       $s3,28($sp)
/* 8004AFDC 8fb20018 */  lw       $s2,24($sp)
/* 8004AFE0 8fb10014 */  lw       $s1,20($sp)
/* 8004AFE4 8fb00010 */  lw       $s0,16($sp)
/* 8004AFE8 03e00008 */  jr       $ra
/* 8004AFEC 27bd0028 */  addiu    $sp,$sp,40
