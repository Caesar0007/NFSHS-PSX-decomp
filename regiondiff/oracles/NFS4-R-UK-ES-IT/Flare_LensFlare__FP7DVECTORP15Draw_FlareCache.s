.set noat
.set noreorder

glabel func_800CF8F8
/* 800CF8F8 27bdff48 */  addiu    $sp,$sp,-184
/* 800CF8FC afbf00b4 */  sw       $ra,180($sp)
/* 800CF900 afbe00b0 */  sw       $s8,176($sp)
/* 800CF904 afb700ac */  sw       $s7,172($sp)
/* 800CF908 afb600a8 */  sw       $s6,168($sp)
/* 800CF90C afb500a4 */  sw       $s5,164($sp)
/* 800CF910 afb400a0 */  sw       $s4,160($sp)
/* 800CF914 afb3009c */  sw       $s3,156($sp)
/* 800CF918 afb20098 */  sw       $s2,152($sp)
/* 800CF91C afb10094 */  sw       $s1,148($sp)
/* 800CF920 afb00090 */  sw       $s0,144($sp)
/* 800CF924 afa400b8 */  sw       $a0,184($sp)
/* 800CF928 8ca20008 */  lw       $v0,8($a1)
/* 800CF92C 8ca30004 */  lw       $v1,4($a1)
/* 800CF930 2442fc00 */  addiu    $v0,$v0,-1024
/* 800CF934 0062182b */  sltu     $v1,$v1,$v0
/* 800CF938 1060017c */  beqz     $v1,.L800CFF2C
/* 800CF93C 3c0700ff */  lui      $a3,0xff
/* 800CF940 34e7ffff */  ori      $a3,$a3,0xffff
/* 800CF944 27a40020 */  addiu    $a0,$sp,32
/* 800CF948 27a50030 */  addiu    $a1,$sp,48
/* 800CF94C 00008021 */  move     $s0,$zero
/* 800CF950 8faf00b8 */  lw       $t7,184($sp)
/* 800CF954 3c068014 */  lui      $a2,0x8014
/* 800CF958 8cc6eac4 */  lw       $a2,-5436($a2)
/* 800CF95C 85e20000 */  lh       $v0,0($t7)
/* 800CF960 85e30002 */  lh       $v1,2($t7)
/* 800CF964 24c6fffe */  addiu    $a2,$a2,-2
/* 800CF968 afa70030 */  sw       $a3,48($sp)
/* 800CF96C 0040f021 */  move     $s8,$v0
/* 800CF970 27c7fffe */  addiu    $a3,$s8,-2
/* 800CF974 0060b821 */  move     $s7,$v1
/* 800CF978 26e2fffe */  addiu    $v0,$s7,-2
/* 800CF97C 27c30003 */  addiu    $v1,$s8,3
/* 800CF980 a7a20022 */  sh       $v0,34($sp)
/* 800CF984 a7a20026 */  sh       $v0,38($sp)
/* 800CF988 26e20003 */  addiu    $v0,$s7,3
/* 800CF98C a7a30024 */  sh       $v1,36($sp)
/* 800CF990 a7a3002c */  sh       $v1,44($sp)
/* 800CF994 03d71821 */  addu     $v1,$s8,$s7
/* 800CF998 000388c0 */  sll      $s1,$v1,0x3
/* 800CF99C a7a2002a */  sh       $v0,42($sp)
/* 800CF9A0 a7a2002e */  sh       $v0,46($sp)
/* 800CF9A4 00031040 */  sll      $v0,$v1,0x1
/* 800CF9A8 00431021 */  addu     $v0,$v0,$v1
/* 800CF9AC 00021040 */  sll      $v0,$v0,0x1
/* 800CF9B0 a7a70020 */  sh       $a3,32($sp)
/* 800CF9B4 a7a70028 */  sh       $a3,40($sp)
/* 800CF9B8 0c033c94 */  jal      func_800CF250
/* 800CF9BC afa20080 */  sw       $v0,128($sp)
/* 800CF9C0 24020140 */  li       $v0,320
/* 800CF9C4 005e1023 */  subu     $v0,$v0,$s8
/* 800CF9C8 afa20078 */  sw       $v0,120($sp)
/* 800CF9CC 24020100 */  li       $v0,256
/* 800CF9D0 00571023 */  subu     $v0,$v0,$s7
/* 800CF9D4 0200a821 */  move     $s5,$s0
/* 800CF9D8 afa2007c */  sw       $v0,124($sp)
/* 800CF9DC 3c028012 */  lui      $v0,0x8012
/* 800CF9E0 24431594 */  addiu    $v1,$v0,5524
/* 800CF9E4 94441594 */  lhu      $a0,5524($v0)
/* 800CF9E8 94650002 */  lhu      $a1,2($v1)
/* 800CF9EC 24067fff */  li       $a2,32767
/* 800CF9F0 a45e1594 */  sh       $s8,5524($v0)
/* 800CF9F4 24020001 */  li       $v0,1
/* 800CF9F8 a4770002 */  sh       $s7,2($v1)
/* 800CF9FC a062007c */  sb       $v0,124($v1)
/* 800CFA00 a4640008 */  sh       $a0,8($v1)
/* 800CFA04 a465000a */  sh       $a1,10($v1)
.L800CFA08:
/* 800CFA08 94620010 */  lhu      $v0,16($v1)
/* 800CFA0C 00000000 */  nop      
/* 800CFA10 30427fff */  andi     $v0,$v0,0x7fff
/* 800CFA14 14460002 */  bne      $v0,$a2,.L800CFA20
/* 800CFA18 00000000 */  nop      
/* 800CFA1C 26b50001 */  addiu    $s5,$s5,1
.L800CFA20:
/* 800CFA20 26100001 */  addiu    $s0,$s0,1
/* 800CFA24 2a020019 */  slti     $v0,$s0,25
/* 800CFA28 1440fff7 */  bnez     $v0,.L800CFA08
/* 800CFA2C 24630002 */  addiu    $v1,$v1,2
/* 800CFA30 32b600ff */  andi     $s6,$s5,0xff
/* 800CFA34 12c0013d */  beqz     $s6,.L800CFF2C
/* 800CFA38 27b00058 */  addiu    $s0,$sp,88
/* 800CFA3C 02002021 */  move     $a0,$s0
/* 800CFA40 001611c0 */  sll      $v0,$s6,0x7
/* 800CFA44 3c138012 */  lui      $s3,0x8012
/* 800CFA48 0016a980 */  sll      $s5,$s6,0x6
/* 800CFA4C afa20038 */  sw       $v0,56($sp)
/* 800CFA50 8e624650 */  lw       $v0,18000($s3)
/* 800CFA54 afb50040 */  sw       $s5,64($sp)
/* 800CFA58 afa00048 */  sw       $zero,72($sp)
/* 800CFA5C afa0003c */  sw       $zero,60($sp)
/* 800CFA60 afa00044 */  sw       $zero,68($sp)
/* 800CFA64 af82131c */  sw       $v0,4892($gp)
/* 800CFA68 0c0332e1 */  jal      func_800CCB84
/* 800CFA6C 26734650 */  addiu    $s3,$s3,18000
/* 800CFA70 02202021 */  move     $a0,$s1
/* 800CFA74 0c03cead */  jal      func_800F3AB4
/* 800CFA78 02002821 */  move     $a1,$s0
/* 800CFA7C 27b40038 */  addiu    $s4,$sp,56
/* 800CFA80 8e8c0000 */  lw       $t4,0($s4)
/* 800CFA84 8e8d0004 */  lw       $t5,4($s4)
/* 800CFA88 48cc0000 */  ctc2     $t4,$0
/* 800CFA8C 48cd0800 */  ctc2     $t5,$1
/* 800CFA90 8e8c0008 */  lw       $t4,8($s4)
/* 800CFA94 8e8d000c */  lw       $t5,12($s4)
/* 800CFA98 8e8e0010 */  lw       $t6,16($s4)
/* 800CFA9C 48cc1000 */  ctc2     $t4,$2
/* 800CFAA0 48cd1800 */  ctc2     $t5,$3
/* 800CFAA4 48ce2000 */  ctc2     $t6,$4
/* 800CFAA8 960c0000 */  lhu      $t4,0($s0)
/* 800CFAAC 960d0006 */  lhu      $t5,6($s0)
/* 800CFAB0 960e000c */  lhu      $t6,12($s0)
/* 800CFAB4 488c4800 */  mtc2     $t4,$9
/* 800CFAB8 488d5000 */  mtc2     $t5,$10
/* 800CFABC 488e5800 */  mtc2     $t6,$11
/* 800CFAC0 00000000 */  nop      
/* 800CFAC4 00000000 */  nop      
/* 800CFAC8 4a49e012 */  cop2     0x49e012
/* 800CFACC 480c4800 */  mfc2     $t4,$9
/* 800CFAD0 480d5000 */  mfc2     $t5,$10
/* 800CFAD4 480e5800 */  mfc2     $t6,$11
/* 800CFAD8 a60c0000 */  sh       $t4,0($s0)
/* 800CFADC a60d0006 */  sh       $t5,6($s0)
/* 800CFAE0 a60e000c */  sh       $t6,12($s0)
/* 800CFAE4 27b2005a */  addiu    $s2,$sp,90
/* 800CFAE8 964c0000 */  lhu      $t4,0($s2)
/* 800CFAEC 964d0006 */  lhu      $t5,6($s2)
/* 800CFAF0 964e000c */  lhu      $t6,12($s2)
/* 800CFAF4 488c4800 */  mtc2     $t4,$9
/* 800CFAF8 488d5000 */  mtc2     $t5,$10
/* 800CFAFC 488e5800 */  mtc2     $t6,$11
/* 800CFB00 00000000 */  nop      
/* 800CFB04 00000000 */  nop      
/* 800CFB08 4a49e012 */  cop2     0x49e012
/* 800CFB0C 480c4800 */  mfc2     $t4,$9
/* 800CFB10 480d5000 */  mfc2     $t5,$10
/* 800CFB14 480e5800 */  mfc2     $t6,$11
/* 800CFB18 a64c0000 */  sh       $t4,0($s2)
/* 800CFB1C a64d0006 */  sh       $t5,6($s2)
/* 800CFB20 a64e000c */  sh       $t6,12($s2)
/* 800CFB24 27b1005c */  addiu    $s1,$sp,92
/* 800CFB28 962c0000 */  lhu      $t4,0($s1)
/* 800CFB2C 962d0006 */  lhu      $t5,6($s1)
/* 800CFB30 962e000c */  lhu      $t6,12($s1)
/* 800CFB34 488c4800 */  mtc2     $t4,$9
/* 800CFB38 488d5000 */  mtc2     $t5,$10
/* 800CFB3C 488e5800 */  mtc2     $t6,$11
/* 800CFB40 00000000 */  nop      
/* 800CFB44 00000000 */  nop      
/* 800CFB48 4a49e012 */  cop2     0x49e012
/* 800CFB4C 480c4800 */  mfc2     $t4,$9
/* 800CFB50 480d5000 */  mfc2     $t5,$10
/* 800CFB54 480e5800 */  mfc2     $t6,$11
/* 800CFB58 a62c0000 */  sh       $t4,0($s1)
/* 800CFB5C a62d0006 */  sh       $t5,6($s1)
/* 800CFB60 a62e000c */  sh       $t6,12($s1)
/* 800CFB64 8e0c0000 */  lw       $t4,0($s0)
/* 800CFB68 8e0d0004 */  lw       $t5,4($s0)
/* 800CFB6C 48cc0000 */  ctc2     $t4,$0
/* 800CFB70 48cd0800 */  ctc2     $t5,$1
/* 800CFB74 8e0c0008 */  lw       $t4,8($s0)
/* 800CFB78 8e0d000c */  lw       $t5,12($s0)
/* 800CFB7C 8e0e0010 */  lw       $t6,16($s0)
/* 800CFB80 48cc1000 */  ctc2     $t4,$2
/* 800CFB84 48cd1800 */  ctc2     $t5,$3
/* 800CFB88 48ce2000 */  ctc2     $t6,$4
/* 800CFB8C 8fa400b8 */  lw       $a0,184($sp)
/* 800CFB90 0c033451 */  jal      func_800CD144
/* 800CFB94 00002821 */  move     $a1,$zero
/* 800CFB98 02002021 */  move     $a0,$s0
/* 800CFB9C 0c0332e1 */  jal      func_800CCB84
/* 800CFBA0 afb50038 */  sw       $s5,56($sp)
/* 800CFBA4 8fa40080 */  lw       $a0,128($sp)
/* 800CFBA8 0c03cead */  jal      func_800F3AB4
/* 800CFBAC 02002821 */  move     $a1,$s0
/* 800CFBB0 8e8c0000 */  lw       $t4,0($s4)
/* 800CFBB4 8e8d0004 */  lw       $t5,4($s4)
/* 800CFBB8 48cc0000 */  ctc2     $t4,$0
/* 800CFBBC 48cd0800 */  ctc2     $t5,$1
/* 800CFBC0 8e8c0008 */  lw       $t4,8($s4)
/* 800CFBC4 8e8d000c */  lw       $t5,12($s4)
/* 800CFBC8 8e8e0010 */  lw       $t6,16($s4)
/* 800CFBCC 48cc1000 */  ctc2     $t4,$2
/* 800CFBD0 48cd1800 */  ctc2     $t5,$3
/* 800CFBD4 48ce2000 */  ctc2     $t6,$4
/* 800CFBD8 960c0000 */  lhu      $t4,0($s0)
/* 800CFBDC 960d0006 */  lhu      $t5,6($s0)
/* 800CFBE0 960e000c */  lhu      $t6,12($s0)
/* 800CFBE4 488c4800 */  mtc2     $t4,$9
/* 800CFBE8 488d5000 */  mtc2     $t5,$10
/* 800CFBEC 488e5800 */  mtc2     $t6,$11
/* 800CFBF0 00000000 */  nop      
/* 800CFBF4 00000000 */  nop      
/* 800CFBF8 4a49e012 */  cop2     0x49e012
/* 800CFBFC 480c4800 */  mfc2     $t4,$9
/* 800CFC00 480d5000 */  mfc2     $t5,$10
/* 800CFC04 480e5800 */  mfc2     $t6,$11
/* 800CFC08 a60c0000 */  sh       $t4,0($s0)
/* 800CFC0C a60d0006 */  sh       $t5,6($s0)
/* 800CFC10 a60e000c */  sh       $t6,12($s0)
/* 800CFC14 964c0000 */  lhu      $t4,0($s2)
/* 800CFC18 964d0006 */  lhu      $t5,6($s2)
/* 800CFC1C 964e000c */  lhu      $t6,12($s2)
/* 800CFC20 488c4800 */  mtc2     $t4,$9
/* 800CFC24 488d5000 */  mtc2     $t5,$10
/* 800CFC28 488e5800 */  mtc2     $t6,$11
/* 800CFC2C 00000000 */  nop      
/* 800CFC30 00000000 */  nop      
/* 800CFC34 4a49e012 */  cop2     0x49e012
/* 800CFC38 480c4800 */  mfc2     $t4,$9
/* 800CFC3C 480d5000 */  mfc2     $t5,$10
/* 800CFC40 480e5800 */  mfc2     $t6,$11
/* 800CFC44 a64c0000 */  sh       $t4,0($s2)
/* 800CFC48 a64d0006 */  sh       $t5,6($s2)
/* 800CFC4C a64e000c */  sh       $t6,12($s2)
/* 800CFC50 962c0000 */  lhu      $t4,0($s1)
/* 800CFC54 962d0006 */  lhu      $t5,6($s1)
/* 800CFC58 962e000c */  lhu      $t6,12($s1)
/* 800CFC5C 488c4800 */  mtc2     $t4,$9
/* 800CFC60 488d5000 */  mtc2     $t5,$10
/* 800CFC64 488e5800 */  mtc2     $t6,$11
/* 800CFC68 00000000 */  nop      
/* 800CFC6C 00000000 */  nop      
/* 800CFC70 4a49e012 */  cop2     0x49e012
/* 800CFC74 480c4800 */  mfc2     $t4,$9
/* 800CFC78 480d5000 */  mfc2     $t5,$10
/* 800CFC7C 480e5800 */  mfc2     $t6,$11
/* 800CFC80 a62c0000 */  sh       $t4,0($s1)
/* 800CFC84 a62d0006 */  sh       $t5,6($s1)
/* 800CFC88 a62e000c */  sh       $t6,12($s1)
/* 800CFC8C 8e0c0000 */  lw       $t4,0($s0)
/* 800CFC90 8e0d0004 */  lw       $t5,4($s0)
/* 800CFC94 48cc0000 */  ctc2     $t4,$0
/* 800CFC98 48cd0800 */  ctc2     $t5,$1
/* 800CFC9C 8e0c0008 */  lw       $t4,8($s0)
/* 800CFCA0 8e0d000c */  lw       $t5,12($s0)
/* 800CFCA4 8e0e0010 */  lw       $t6,16($s0)
/* 800CFCA8 48cc1000 */  ctc2     $t4,$2
/* 800CFCAC 48cd1800 */  ctc2     $t5,$3
/* 800CFCB0 48ce2000 */  ctc2     $t6,$4
/* 800CFCB4 8fa400b8 */  lw       $a0,184($sp)
/* 800CFCB8 0c033451 */  jal      func_800CD144
/* 800CFCBC 00002821 */  move     $a1,$zero
/* 800CFCC0 00008021 */  move     $s0,$zero
/* 800CFCC4 3c028012 */  lui      $v0,0x8012
/* 800CFCC8 24421594 */  addiu    $v0,$v0,5524
/* 800CFCCC 0040a021 */  move     $s4,$v0
/* 800CFCD0 3412ffff */  li       $s2,0xffff
/* 800CFCD4 02c0a821 */  move     $s5,$s6
/* 800CFCD8 3c1151eb */  lui      $s1,0x51eb
/* 800CFCDC 8e830078 */  lw       $v1,120($s4)
/* 800CFCE0 8e620004 */  lw       $v0,4($s3)
/* 800CFCE4 3631851f */  ori      $s1,$s1,0x851f
/* 800CFCE8 ac620008 */  sw       $v0,8($v1)
.L800CFCEC:
/* 800CFCEC 2a020009 */  slti     $v0,$s0,9
/* 800CFCF0 10400072 */  beqz     $v0,.L800CFEBC
/* 800CFCF4 00101100 */  sll      $v0,$s0,0x4
/* 800CFCF8 8e830078 */  lw       $v1,120($s4)
/* 800CFCFC 00000000 */  nop      
/* 800CFD00 00624021 */  addu     $t0,$v1,$v0
/* 800CFD04 8d030000 */  lw       $v1,0($t0)
/* 800CFD08 3c0f0001 */  lui      $t7,0x1
/* 800CFD0C 01e31023 */  subu     $v0,$t7,$v1
/* 800CFD10 005e0018 */  mult     $v0,$s8
/* 800CFD14 00001012 */  mflo     $v0
/* 800CFD18 8faf0078 */  lw       $t7,120($sp)
/* 800CFD1C 00000000 */  nop      
/* 800CFD20 006f0018 */  mult     $v1,$t7
/* 800CFD24 00001812 */  mflo     $v1
/* 800CFD28 00431021 */  addu     $v0,$v0,$v1
/* 800CFD2C 04410002 */  bgez     $v0,.L800CFD38
/* 800CFD30 00000000 */  nop      
/* 800CFD34 00521021 */  addu     $v0,$v0,$s2
.L800CFD38:
/* 800CFD38 00021403 */  sra      $v0,$v0,0x10
/* 800CFD3C a7a20018 */  sh       $v0,24($sp)
/* 800CFD40 8d030000 */  lw       $v1,0($t0)
/* 800CFD44 3c0f0001 */  lui      $t7,0x1
/* 800CFD48 01e31023 */  subu     $v0,$t7,$v1
/* 800CFD4C 00570018 */  mult     $v0,$s7
/* 800CFD50 00001012 */  mflo     $v0
/* 800CFD54 8faf007c */  lw       $t7,124($sp)
/* 800CFD58 00000000 */  nop      
/* 800CFD5C 006f0018 */  mult     $v1,$t7
/* 800CFD60 00001812 */  mflo     $v1
/* 800CFD64 00431021 */  addu     $v0,$v0,$v1
/* 800CFD68 04410002 */  bgez     $v0,.L800CFD74
/* 800CFD6C 00000000 */  nop      
/* 800CFD70 00521021 */  addu     $v0,$v0,$s2
.L800CFD74:
/* 800CFD74 00021403 */  sra      $v0,$v0,0x10
/* 800CFD78 a7a2001a */  sh       $v0,26($sp)
/* 800CFD7C 8e830074 */  lw       $v1,116($s4)
/* 800CFD80 8d020004 */  lw       $v0,4($t0)
/* 800CFD84 00000000 */  nop      
/* 800CFD88 00620018 */  mult     $v1,$v0
/* 800CFD8C 00001012 */  mflo     $v0
/* 800CFD90 04410003 */  bgez     $v0,.L800CFDA0
/* 800CFD94 00023c03 */  sra      $a3,$v0,0x10
/* 800CFD98 00521021 */  addu     $v0,$v0,$s2
/* 800CFD9C 00023c03 */  sra      $a3,$v0,0x10
.L800CFDA0:
/* 800CFDA0 28e20004 */  slti     $v0,$a3,4
/* 800CFDA4 14400043 */  bnez     $v0,.L800CFEB4
/* 800CFDA8 00e03021 */  move     $a2,$a3
/* 800CFDAC 91020008 */  lbu      $v0,8($t0)
/* 800CFDB0 00000000 */  nop      
/* 800CFDB4 00550018 */  mult     $v0,$s5
/* 800CFDB8 00001812 */  mflo     $v1
/* 800CFDBC 00000000 */  nop      
/* 800CFDC0 00000000 */  nop      
/* 800CFDC4 00710018 */  mult     $v1,$s1
/* 800CFDC8 00001810 */  mfhi     $v1
/* 800CFDCC 000310c3 */  sra      $v0,$v1,0x3
/* 800CFDD0 a3a20020 */  sb       $v0,32($sp)
/* 800CFDD4 91020009 */  lbu      $v0,9($t0)
/* 800CFDD8 00000000 */  nop      
/* 800CFDDC 00550018 */  mult     $v0,$s5
/* 800CFDE0 00001812 */  mflo     $v1
/* 800CFDE4 00000000 */  nop      
/* 800CFDE8 00000000 */  nop      
/* 800CFDEC 00710018 */  mult     $v1,$s1
/* 800CFDF0 00001810 */  mfhi     $v1
/* 800CFDF4 000310c3 */  sra      $v0,$v1,0x3
/* 800CFDF8 a3a20021 */  sb       $v0,33($sp)
/* 800CFDFC 9102000a */  lbu      $v0,10($t0)
/* 800CFE00 00000000 */  nop      
/* 800CFE04 00550018 */  mult     $v0,$s5
/* 800CFE08 00001812 */  mflo     $v1
/* 800CFE0C 00000000 */  nop      
/* 800CFE10 00000000 */  nop      
/* 800CFE14 00710018 */  mult     $v1,$s1
/* 800CFE18 00001810 */  mfhi     $v1
/* 800CFE1C 000310c3 */  sra      $v0,$v1,0x3
/* 800CFE20 a3a20022 */  sb       $v0,34($sp)
/* 800CFE24 9103000c */  lbu      $v1,12($t0)
/* 800CFE28 00000000 */  nop      
/* 800CFE2C 2c620005 */  sltiu    $v0,$v1,5
/* 800CFE30 10400020 */  beqz     $v0,.L800CFEB4
/* 800CFE34 3c028005 */  lui      $v0,0x8005
/* 800CFE38 24427048 */  addiu    $v0,$v0,28744
/* 800CFE3C 00031880 */  sll      $v1,$v1,0x2
/* 800CFE40 00621821 */  addu     $v1,$v1,$v0
/* 800CFE44 8c620000 */  lw       $v0,0($v1)
/* 800CFE48 00000000 */  nop      
/* 800CFE4C 00400008 */  jr       $v0
/* 800CFE50 00000000 */  nop      
/* 800CFE54 27a40018 */  addiu    $a0,$sp,24
/* 800CFE58 9102000c */  lbu      $v0,12($t0)
/* 800CFE5C 27a50020 */  addiu    $a1,$sp,32
/* 800CFE60 afa00014 */  sw       $zero,20($sp)
/* 800CFE64 0c033d21 */  jal      func_800CF484
/* 800CFE68 afa20010 */  sw       $v0,16($sp)
/* 800CFE6C 08033f3b */  j        .L800CFCEC
/* 800CFE70 26100001 */  addiu    $s0,$s0,1
/* 800CFE74 afa00010 */  sw       $zero,16($sp)
/* 800CFE78 27a40018 */  addiu    $a0,$sp,24
/* 800CFE7C 0c033d4a */  jal      func_800CF528
/* 800CFE80 27a50020 */  addiu    $a1,$sp,32
/* 800CFE84 08033f3b */  j        .L800CFCEC
/* 800CFE88 26100001 */  addiu    $s0,$s0,1
/* 800CFE8C afa00010 */  sw       $zero,16($sp)
/* 800CFE90 27a40018 */  addiu    $a0,$sp,24
/* 800CFE94 0c033d8f */  jal      func_800CF63C
/* 800CFE98 27a50020 */  addiu    $a1,$sp,32
/* 800CFE9C 08033f3b */  j        .L800CFCEC
/* 800CFEA0 26100001 */  addiu    $s0,$s0,1
/* 800CFEA4 afa00010 */  sw       $zero,16($sp)
/* 800CFEA8 27a40018 */  addiu    $a0,$sp,24
/* 800CFEAC 0c033dc5 */  jal      func_800CF714
/* 800CFEB0 27a50020 */  addiu    $a1,$sp,32
.L800CFEB4:
/* 800CFEB4 08033f3b */  j        .L800CFCEC
/* 800CFEB8 26100001 */  addiu    $s0,$s0,1
.L800CFEBC:
/* 800CFEBC 3c0b1f80 */  lui      $t3,0x1f80
/* 800CFEC0 356b0004 */  ori      $t3,$t3,0x4
/* 800CFEC4 3c0900ff */  lui      $t1,0xff
/* 800CFEC8 3529ffff */  ori      $t1,$t1,0xffff
/* 800CFECC 00002821 */  move     $a1,$zero
/* 800CFED0 00a03021 */  move     $a2,$a1
/* 800CFED4 24070120 */  li       $a3,288
/* 800CFED8 00064080 */  sll      $t0,$a2,0x2
/* 800CFEDC 3c0aff00 */  lui      $t2,0xff00
/* 800CFEE0 3c021f80 */  lui      $v0,0x1f80
/* 800CFEE4 8c420000 */  lw       $v0,0($v0)
/* 800CFEE8 8d640000 */  lw       $a0,0($t3)
/* 800CFEEC 01024021 */  addu     $t0,$t0,$v0
/* 800CFEF0 8c830000 */  lw       $v1,0($a0)
/* 800CFEF4 8d020000 */  lw       $v0,0($t0)
/* 800CFEF8 006a1824 */  and      $v1,$v1,$t2
/* 800CFEFC 00491024 */  and      $v0,$v0,$t1
/* 800CFF00 00621825 */  or       $v1,$v1,$v0
/* 800CFF04 ac830000 */  sw       $v1,0($a0)
/* 800CFF08 8d020000 */  lw       $v0,0($t0)
/* 800CFF0C 2483000c */  addiu    $v1,$a0,12
/* 800CFF10 ad630000 */  sw       $v1,0($t3)
/* 800CFF14 00891824 */  and      $v1,$a0,$t1
/* 800CFF18 004a1024 */  and      $v0,$v0,$t2
/* 800CFF1C 00431025 */  or       $v0,$v0,$v1
/* 800CFF20 ad020000 */  sw       $v0,0($t0)
/* 800CFF24 0c03bb51 */  jal      func_800EED44
/* 800CFF28 afa00010 */  sw       $zero,16($sp)
.L800CFF2C:
/* 800CFF2C 8fbf00b4 */  lw       $ra,180($sp)
/* 800CFF30 8fbe00b0 */  lw       $s8,176($sp)
/* 800CFF34 8fb700ac */  lw       $s7,172($sp)
/* 800CFF38 8fb600a8 */  lw       $s6,168($sp)
/* 800CFF3C 8fb500a4 */  lw       $s5,164($sp)
/* 800CFF40 8fb400a0 */  lw       $s4,160($sp)
/* 800CFF44 8fb3009c */  lw       $s3,156($sp)
/* 800CFF48 8fb20098 */  lw       $s2,152($sp)
/* 800CFF4C 8fb10094 */  lw       $s1,148($sp)
/* 800CFF50 8fb00090 */  lw       $s0,144($sp)
/* 800CFF54 03e00008 */  jr       $ra
/* 800CFF58 27bd00b8 */  addiu    $sp,$sp,184
