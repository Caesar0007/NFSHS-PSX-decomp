.set noat
.set noreorder

glabel func_8007B9C4
/* 8007B9C4 8f8201d8 */  lw       $v0,472($gp)
/* 8007B9C8 27bdff58 */  addiu    $sp,$sp,-168
/* 8007B9CC afb3009c */  sw       $s3,156($sp)
/* 8007B9D0 00809821 */  move     $s3,$a0
/* 8007B9D4 afbf00a0 */  sw       $ra,160($sp)
/* 8007B9D8 afb20098 */  sw       $s2,152($sp)
/* 8007B9DC afb10094 */  sw       $s1,148($sp)
/* 8007B9E0 10400090 */  beqz     $v0,.L8007BC24
/* 8007B9E4 afb00090 */  sw       $s0,144($sp)
/* 8007B9E8 12600014 */  beqz     $s3,.L8007BA3C
/* 8007B9EC 00000000 */  nop      
/* 8007B9F0 0c01ee3d */  jal      func_8007B8F4
/* 8007B9F4 00000000 */  nop      
/* 8007B9F8 8f8201d8 */  lw       $v0,472($gp)
/* 8007B9FC 00000000 */  nop      
/* 8007BA00 8c420008 */  lw       $v0,8($v0)
/* 8007BA04 00000000 */  nop      
/* 8007BA08 1440000c */  bnez     $v0,.L8007BA3C
/* 8007BA0C 00000000 */  nop      
/* 8007BA10 0c03a9af */  jal      func_800EA6BC
/* 8007BA14 02602021 */  move     $a0,$s3
/* 8007BA18 2c42003d */  sltiu    $v0,$v0,61
/* 8007BA1C 10400007 */  beqz     $v0,.L8007BA3C
/* 8007BA20 3c058014 */  lui      $a1,0x8014
/* 8007BA24 27a40010 */  addiu    $a0,$sp,16
/* 8007BA28 24a5d804 */  addiu    $a1,$a1,-10236
/* 8007BA2C 0c0393a5 */  jal      func_800E4E94
/* 8007BA30 02603021 */  move     $a2,$s3
/* 8007BA34 0c01ee3d */  jal      func_8007B8F4
/* 8007BA38 27a40010 */  addiu    $a0,$sp,16
.L8007BA3C:
/* 8007BA3C 8f8301d8 */  lw       $v1,472($gp)
/* 8007BA40 00000000 */  nop      
/* 8007BA44 8c620000 */  lw       $v0,0($v1)
/* 8007BA48 00000000 */  nop      
/* 8007BA4C 10400076 */  beqz     $v0,.L8007BC28
/* 8007BA50 00001021 */  move     $v0,$zero
/* 8007BA54 8c620008 */  lw       $v0,8($v1)
/* 8007BA58 00000000 */  nop      
/* 8007BA5C 1040006c */  beqz     $v0,.L8007BC10
/* 8007BA60 00408021 */  move     $s0,$v0
/* 8007BA64 24020001 */  li       $v0,1
/* 8007BA68 16020003 */  bne      $s0,$v0,.L8007BA78
/* 8007BA6C ac620024 */  sw       $v0,36($v1)
/* 8007BA70 0801eedf */  j        .L8007BB7C
/* 8007BA74 00008021 */  move     $s0,$zero
.L8007BA78:
/* 8007BA78 12600019 */  beqz     $s3,.L8007BAE0
/* 8007BA7C 00002021 */  move     $a0,$zero
/* 8007BA80 0c03a995 */  jal      func_800EA654
/* 8007BA84 00002021 */  move     $a0,$zero
/* 8007BA88 18400005 */  blez     $v0,.L8007BAA0
/* 8007BA8C 00000000 */  nop      
/* 8007BA90 0c03a995 */  jal      func_800EA654
/* 8007BA94 00002021 */  move     $a0,$zero
/* 8007BA98 0801eeab */  j        .L8007BAAC
/* 8007BA9C 00000000 */  nop      
.L8007BAA0:
/* 8007BAA0 0c03a995 */  jal      func_800EA654
/* 8007BAA4 00002021 */  move     $a0,$zero
/* 8007BAA8 00021023 */  negu     $v0,$v0
.L8007BAAC:
/* 8007BAAC 0050001a */  div      $zero,$v0,$s0
/* 8007BAB0 16000002 */  bnez     $s0,.L8007BABC
/* 8007BAB4 00000000 */  nop      
/* 8007BAB8 0007000d */  break    0x7
.L8007BABC:
/* 8007BABC 2401ffff */  li       $at,-1
/* 8007BAC0 16010004 */  bne      $s0,$at,.L8007BAD4
/* 8007BAC4 3c018000 */  lui      $at,0x8000
/* 8007BAC8 14410002 */  bne      $v0,$at,.L8007BAD4
/* 8007BACC 00000000 */  nop      
/* 8007BAD0 0006000d */  break    0x6
.L8007BAD4:
/* 8007BAD4 00001810 */  mfhi     $v1
/* 8007BAD8 0801eedf */  j        .L8007BB7C
/* 8007BADC 00608021 */  move     $s0,$v1
.L8007BAE0:
/* 8007BAE0 8c62000c */  lw       $v0,12($v1)
/* 8007BAE4 2611ffff */  addiu    $s1,$s0,-1
/* 8007BAE8 0c03a995 */  jal      func_800EA654
/* 8007BAEC 24520001 */  addiu    $s2,$v0,1
/* 8007BAF0 18400005 */  blez     $v0,.L8007BB08
/* 8007BAF4 00000000 */  nop      
/* 8007BAF8 0c03a995 */  jal      func_800EA654
/* 8007BAFC 00002021 */  move     $a0,$zero
/* 8007BB00 0801eec5 */  j        .L8007BB14
/* 8007BB04 00000000 */  nop      
.L8007BB08:
/* 8007BB08 0c03a995 */  jal      func_800EA654
/* 8007BB0C 00002021 */  move     $a0,$zero
/* 8007BB10 00021023 */  negu     $v0,$v0
.L8007BB14:
/* 8007BB14 0051001a */  div      $zero,$v0,$s1
/* 8007BB18 16200002 */  bnez     $s1,.L8007BB24
/* 8007BB1C 00000000 */  nop      
/* 8007BB20 0007000d */  break    0x7
.L8007BB24:
/* 8007BB24 2401ffff */  li       $at,-1
/* 8007BB28 16210004 */  bne      $s1,$at,.L8007BB3C
/* 8007BB2C 3c018000 */  lui      $at,0x8000
/* 8007BB30 14410002 */  bne      $v0,$at,.L8007BB3C
/* 8007BB34 00000000 */  nop      
/* 8007BB38 0006000d */  break    0x6
.L8007BB3C:
/* 8007BB3C 00001810 */  mfhi     $v1
/* 8007BB40 00000000 */  nop      
/* 8007BB44 02431821 */  addu     $v1,$s2,$v1
/* 8007BB48 0070001a */  div      $zero,$v1,$s0
/* 8007BB4C 16000002 */  bnez     $s0,.L8007BB58
/* 8007BB50 00000000 */  nop      
/* 8007BB54 0007000d */  break    0x7
.L8007BB58:
/* 8007BB58 2401ffff */  li       $at,-1
/* 8007BB5C 16010004 */  bne      $s0,$at,.L8007BB70
/* 8007BB60 3c018000 */  lui      $at,0x8000
/* 8007BB64 14610002 */  bne      $v1,$at,.L8007BB70
/* 8007BB68 00000000 */  nop      
/* 8007BB6C 0006000d */  break    0x6
.L8007BB70:
/* 8007BB70 00001010 */  mfhi     $v0
/* 8007BB74 00000000 */  nop      
/* 8007BB78 00408021 */  move     $s0,$v0
.L8007BB7C:
/* 8007BB7C 8f8301d8 */  lw       $v1,472($gp)
/* 8007BB80 00000000 */  nop      
/* 8007BB84 8c620014 */  lw       $v0,20($v1)
/* 8007BB88 00000000 */  nop      
/* 8007BB8C 10400004 */  beqz     $v0,.L8007BBA0
/* 8007BB90 24020001 */  li       $v0,1
/* 8007BB94 ac620014 */  sw       $v0,20($v1)
/* 8007BB98 0801eefe */  j        .L8007BBF8
/* 8007BB9C ac70000c */  sw       $s0,12($v1)
.L8007BBA0:
/* 8007BBA0 8c62000c */  lw       $v0,12($v1)
/* 8007BBA4 00000000 */  nop      
/* 8007BBA8 0440000c */  bltz     $v0,.L8007BBDC
/* 8007BBAC 240507d0 */  li       $a1,2000
/* 8007BBB0 8c640070 */  lw       $a0,112($v1)
/* 8007BBB4 0c03a94c */  jal      func_800EA530
/* 8007BBB8 00003021 */  move     $a2,$zero
/* 8007BBBC 8f8201d8 */  lw       $v0,472($gp)
/* 8007BBC0 240307d0 */  li       $v1,2000
/* 8007BBC4 ac430020 */  sw       $v1,32($v0)
/* 8007BBC8 24030001 */  li       $v1,1
/* 8007BBCC ac430014 */  sw       $v1,20($v0)
/* 8007BBD0 ac50000c */  sw       $s0,12($v0)
/* 8007BBD4 0801eefe */  j        .L8007BBF8
/* 8007BBD8 ac400028 */  sw       $zero,40($v0)
.L8007BBDC:
/* 8007BBDC 8c640070 */  lw       $a0,112($v1)
/* 8007BBE0 00002821 */  move     $a1,$zero
/* 8007BBE4 0c03aa08 */  jal      func_800EA820
/* 8007BBE8 ac600020 */  sw       $zero,32($v1)
/* 8007BBEC 8f8201d8 */  lw       $v0,472($gp)
/* 8007BBF0 0c01eb39 */  jal      func_8007ACE4
/* 8007BBF4 ac50000c */  sw       $s0,12($v0)
.L8007BBF8:
/* 8007BBF8 8f8201d8 */  lw       $v0,472($gp)
/* 8007BBFC 24030001 */  li       $v1,1
/* 8007BC00 ac430010 */  sw       $v1,16($v0)
/* 8007BC04 12600002 */  beqz     $s3,.L8007BC10
/* 8007BC08 ac40001c */  sw       $zero,28($v0)
/* 8007BC0C ac430018 */  sw       $v1,24($v0)
.L8007BC10:
/* 8007BC10 8f8201d8 */  lw       $v0,472($gp)
/* 8007BC14 00000000 */  nop      
/* 8007BC18 8c420008 */  lw       $v0,8($v0)
/* 8007BC1C 0801ef0a */  j        .L8007BC28
/* 8007BC20 00000000 */  nop      
.L8007BC24:
/* 8007BC24 00001021 */  move     $v0,$zero
.L8007BC28:
/* 8007BC28 8fbf00a0 */  lw       $ra,160($sp)
/* 8007BC2C 8fb3009c */  lw       $s3,156($sp)
/* 8007BC30 8fb20098 */  lw       $s2,152($sp)
/* 8007BC34 8fb10094 */  lw       $s1,148($sp)
/* 8007BC38 8fb00090 */  lw       $s0,144($sp)
/* 8007BC3C 03e00008 */  jr       $ra
/* 8007BC40 27bd00a8 */  addiu    $sp,$sp,168
