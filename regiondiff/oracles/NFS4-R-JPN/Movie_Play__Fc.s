.set noat
.set noreorder

glabel func_8004CC8C
/* 8004CC8C 3c028014 */  lui      $v0,0x8014
/* 8004CC90 8c42d730 */  lw       $v0,-10448($v0)
/* 8004CC94 27bdff48 */  addiu    $sp,$sp,-184
/* 8004CC98 afb000a0 */  sw       $s0,160($sp)
/* 8004CC9C 00808021 */  move     $s0,$a0
/* 8004CCA0 afb100a4 */  sw       $s1,164($sp)
/* 8004CCA4 27b10030 */  addiu    $s1,$sp,48
/* 8004CCA8 afb400b0 */  sw       $s4,176($sp)
/* 8004CCAC 3c148005 */  lui      $s4,0x8005
/* 8004CCB0 afb300ac */  sw       $s3,172($sp)
/* 8004CCB4 24130001 */  li       $s3,1
/* 8004CCB8 afbf00b4 */  sw       $ra,180($sp)
/* 8004CCBC afb200a8 */  sw       $s2,168($sp)
/* 8004CCC0 000221c0 */  sll      $a0,$v0,0x7
/* 8004CCC4 00822023 */  subu     $a0,$a0,$v0
/* 8004CCC8 0c03ec77 */  jal      func_800FB1DC
/* 8004CCCC 000421c3 */  sra      $a0,$a0,0x7
/* 8004CCD0 321000ff */  andi     $s0,$s0,0xff
/* 8004CCD4 0c01316c */  jal      func_8004C5B0
/* 8004CCD8 02002021 */  move     $a0,$s0
/* 8004CCDC 0c01324b */  jal      func_8004C92C
/* 8004CCE0 02002021 */  move     $a0,$s0
/* 8004CCE4 3c028005 */  lui      $v0,0x8005
/* 8004CCE8 24522c80 */  addiu    $s2,$v0,11392
.L8004CCEC:
/* 8004CCEC 0c01330b */  jal      func_8004CC2C
/* 8004CCF0 00000000 */  nop      
/* 8004CCF4 38420001 */  xori     $v0,$v0,0x1
/* 8004CCF8 10400051 */  beqz     $v0,.L8004CE40
/* 8004CCFC 00000000 */  nop      
/* 8004CD00 0c037324 */  jal      func_800DCC90
/* 8004CD04 00000000 */  nop      
/* 8004CD08 0c0132b6 */  jal      func_8004CAD8
/* 8004CD0C 00000000 */  nop      
/* 8004CD10 2403ffff */  li       $v1,-1
/* 8004CD14 1043004a */  beq      $v0,$v1,.L8004CE40
/* 8004CD18 00000000 */  nop      
/* 8004CD1C 8e500020 */  lw       $s0,32($s2)
/* 8004CD20 00000000 */  nop      
/* 8004CD24 2e100001 */  sltiu    $s0,$s0,1
/* 8004CD28 001080c0 */  sll      $s0,$s0,0x3
/* 8004CD2C 02128021 */  addu     $s0,$s0,$s2
/* 8004CD30 86050010 */  lh       $a1,16($s0)
/* 8004CD34 86060012 */  lh       $a2,18($s0)
/* 8004CD38 86070014 */  lh       $a3,20($s0)
/* 8004CD3C 86020016 */  lh       $v0,22($s0)
/* 8004CD40 27a40018 */  addiu    $a0,$sp,24
/* 8004CD44 0c03ca8a */  jal      func_800F2A28
/* 8004CD48 afa20010 */  sw       $v0,16($sp)
/* 8004CD4C 240200f0 */  li       $v0,240
/* 8004CD50 a7a20026 */  sh       $v0,38($sp)
/* 8004CD54 86050010 */  lh       $a1,16($s0)
/* 8004CD58 86060012 */  lh       $a2,18($s0)
/* 8004CD5C 86070014 */  lh       $a3,20($s0)
/* 8004CD60 86020016 */  lh       $v0,22($s0)
/* 8004CD64 02202021 */  move     $a0,$s1
/* 8004CD68 0c03ca5d */  jal      func_800F2974
/* 8004CD6C afa20010 */  sw       $v0,16($sp)
/* 8004CD70 8e822c5c */  lw       $v0,11356($s4)
/* 8004CD74 00000000 */  nop      
/* 8004CD78 1040000b */  beqz     $v0,.L8004CDA8
/* 8004CD7C 3c035555 */  lui      $v1,0x5555
/* 8004CD80 87a2001c */  lh       $v0,28($sp)
/* 8004CD84 34635556 */  ori      $v1,$v1,0x5556
/* 8004CD88 00021040 */  sll      $v0,$v0,0x1
/* 8004CD8C 00430018 */  mult     $v0,$v1
/* 8004CD90 24030001 */  li       $v1,1
/* 8004CD94 000217c3 */  sra      $v0,$v0,0x1f
/* 8004CD98 a3a30029 */  sb       $v1,41($sp)
/* 8004CD9C 00004010 */  mfhi     $t0
/* 8004CDA0 01021023 */  subu     $v0,$t0,$v0
/* 8004CDA4 a7a2001c */  sh       $v0,28($sp)
.L8004CDA8:
/* 8004CDA8 0c03b94b */  jal      func_800EE52C
/* 8004CDAC 27a40018 */  addiu    $a0,$sp,24
/* 8004CDB0 0c03b91b */  jal      func_800EE46C
/* 8004CDB4 02202021 */  move     $a0,$s1
/* 8004CDB8 0c03b7cb */  jal      func_800EDF2C
/* 8004CDBC 24040001 */  li       $a0,1
/* 8004CDC0 8e822c5c */  lw       $v0,11356($s4)
/* 8004CDC4 00000000 */  nop      
/* 8004CDC8 14400003 */  bnez     $v0,.L8004CDD8
/* 8004CDCC 00000000 */  nop      
/* 8004CDD0 0c03dd18 */  jal      func_800F7460
/* 8004CDD4 2404ffff */  li       $a0,-1
.L8004CDD8:
/* 8004CDD8 0c013303 */  jal      func_8004CC0C
/* 8004CDDC 00000000 */  nop      
/* 8004CDE0 3c028005 */  lui      $v0,0x8005
/* 8004CDE4 0c0392fd */  jal      func_800E4BF4
/* 8004CDE8 a4532988 */  sh       $s3,10632($v0)
/* 8004CDEC 0c0392e4 */  jal      func_800E4B90
/* 8004CDF0 00002021 */  move     $a0,$zero
/* 8004CDF4 24040004 */  li       $a0,4
/* 8004CDF8 0c0392e4 */  jal      func_800E4B90
/* 8004CDFC 00408021 */  move     $s0,$v0
/* 8004CE00 02028025 */  or       $s0,$s0,$v0
/* 8004CE04 3210ffff */  andi     $s0,$s0,0xffff
/* 8004CE08 1200ffb8 */  beqz     $s0,.L8004CCEC
/* 8004CE0C 00000000 */  nop      
/* 8004CE10 0c013307 */  jal      func_8004CC1C
/* 8004CE14 00000000 */  nop      
/* 8004CE18 3c028005 */  lui      $v0,0x8005
/* 8004CE1C 90422986 */  lbu      $v0,10630($v0)
/* 8004CE20 00000000 */  nop      
/* 8004CE24 14400004 */  bnez     $v0,.L8004CE38
/* 8004CE28 3c028005 */  lui      $v0,0x8005
/* 8004CE2C 24020008 */  li       $v0,8
/* 8004CE30 1602ffae */  bne      $s0,$v0,.L8004CCEC
/* 8004CE34 3c028005 */  lui      $v0,0x8005
.L8004CE38:
/* 8004CE38 0801333b */  j        .L8004CCEC
/* 8004CE3C a4532984 */  sh       $s3,10628($v0)
.L8004CE40:
/* 8004CE40 0c0131e0 */  jal      func_8004C780
/* 8004CE44 3c108005 */  lui      $s0,0x8005
/* 8004CE48 26102c90 */  addiu    $s0,$s0,11408
/* 8004CE4C 02002021 */  move     $a0,$s0
/* 8004CE50 00002821 */  move     $a1,$zero
/* 8004CE54 00a03021 */  move     $a2,$a1
/* 8004CE58 0c03b852 */  jal      func_800EE148
/* 8004CE5C 00a03821 */  move     $a3,$a1
/* 8004CE60 26040008 */  addiu    $a0,$s0,8
/* 8004CE64 00002821 */  move     $a1,$zero
/* 8004CE68 00a03021 */  move     $a2,$a1
/* 8004CE6C 0c03b852 */  jal      func_800EE148
/* 8004CE70 00a03821 */  move     $a3,$a1
/* 8004CE74 0c03b7f1 */  jal      func_800EDFC4
/* 8004CE78 00002021 */  move     $a0,$zero
/* 8004CE7C 3c028005 */  lui      $v0,0x8005
/* 8004CE80 84422984 */  lh       $v0,10628($v0)
/* 8004CE84 8fbf00b4 */  lw       $ra,180($sp)
/* 8004CE88 8fb400b0 */  lw       $s4,176($sp)
/* 8004CE8C 8fb300ac */  lw       $s3,172($sp)
/* 8004CE90 8fb200a8 */  lw       $s2,168($sp)
/* 8004CE94 8fb100a4 */  lw       $s1,164($sp)
/* 8004CE98 8fb000a0 */  lw       $s0,160($sp)
/* 8004CE9C 03e00008 */  jr       $ra
/* 8004CEA0 27bd00b8 */  addiu    $sp,$sp,184
