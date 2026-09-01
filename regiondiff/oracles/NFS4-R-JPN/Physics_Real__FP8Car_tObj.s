.set noat
.set noreorder

glabel func_800ACBAC
/* 800ACBAC 27bdfee8 */  addiu    $sp,$sp,-280
/* 800ACBB0 afb5010c */  sw       $s5,268($sp)
/* 800ACBB4 0080a821 */  move     $s5,$a0
/* 800ACBB8 3c028011 */  lui      $v0,0x8011
/* 800ACBBC afbf0114 */  sw       $ra,276($sp)
/* 800ACBC0 afb60110 */  sw       $s6,272($sp)
/* 800ACBC4 afb40108 */  sw       $s4,264($sp)
/* 800ACBC8 afb30104 */  sw       $s3,260($sp)
/* 800ACBCC afb20100 */  sw       $s2,256($sp)
/* 800ACBD0 afb100fc */  sw       $s1,252($sp)
/* 800ACBD4 afb000f8 */  sw       $s0,248($sp)
/* 800ACBD8 aea0040c */  sw       $zero,1036($s5)
/* 800ACBDC aea00410 */  sw       $zero,1040($s5)
/* 800ACBE0 aea00414 */  sw       $zero,1044($s5)
/* 800ACBE4 8c4242d8 */  lw       $v0,17112($v0)
/* 800ACBE8 8eb60464 */  lw       $s6,1124($s5)
/* 800ACBEC 24100001 */  li       $s0,1
/* 800ACBF0 af900dc4 */  sw       $s0,3524($gp)
/* 800ACBF4 af900dc8 */  sw       $s0,3528($gp)
/* 800ACBF8 10400009 */  beqz     $v0,.L800ACC20
/* 800ACBFC 00000000 */  nop      
/* 800ACC00 0c02027e */  jal      func_800809F8
/* 800ACC04 26a40008 */  addiu    $a0,$s5,8
/* 800ACC08 00501026 */  xor      $v0,$v0,$s0
/* 800ACC0C 10400004 */  beqz     $v0,.L800ACC20
/* 800ACC10 00000000 */  nop      
/* 800ACC14 af900dc0 */  sw       $s0,3520($gp)
/* 800ACC18 0802b309 */  j        .L800ACC24
/* 800ACC1C 00000000 */  nop      
.L800ACC20:
/* 800ACC20 af800dc0 */  sw       $zero,3520($gp)
.L800ACC24:
/* 800ACC24 8ea202ac */  lw       $v0,684($s5)
/* 800ACC28 00000000 */  nop      
/* 800ACC2C 1040000b */  beqz     $v0,.L800ACC5C
/* 800ACC30 00000000 */  nop      
/* 800ACC34 8ea202dc */  lw       $v0,732($s5)
/* 800ACC38 00000000 */  nop      
/* 800ACC3C 10400007 */  beqz     $v0,.L800ACC5C
/* 800ACC40 00000000 */  nop      
/* 800ACC44 8ea20188 */  lw       $v0,392($s5)
/* 800ACC48 00000000 */  nop      
/* 800ACC4C 28420ccd */  slti     $v0,$v0,3277
/* 800ACC50 14400002 */  bnez     $v0,.L800ACC5C
/* 800ACC54 00000000 */  nop      
/* 800ACC58 af800dc4 */  sw       $zero,3524($gp)
.L800ACC5C:
/* 800ACC5C 8ea2030c */  lw       $v0,780($s5)
/* 800ACC60 00000000 */  nop      
/* 800ACC64 1040000b */  beqz     $v0,.L800ACC94
/* 800ACC68 00000000 */  nop      
/* 800ACC6C 8ea2033c */  lw       $v0,828($s5)
/* 800ACC70 00000000 */  nop      
/* 800ACC74 10400007 */  beqz     $v0,.L800ACC94
/* 800ACC78 00000000 */  nop      
/* 800ACC7C 8ea20188 */  lw       $v0,392($s5)
/* 800ACC80 00000000 */  nop      
/* 800ACC84 28420ccd */  slti     $v0,$v0,3277
/* 800ACC88 14400002 */  bnez     $v0,.L800ACC94
/* 800ACC8C 00000000 */  nop      
/* 800ACC90 af800dc8 */  sw       $zero,3528($gp)
.L800ACC94:
/* 800ACC94 8ea400ac */  lw       $a0,172($s5)
/* 800ACC98 8ea501c4 */  lw       $a1,452($s5)
/* 800ACC9C 0c039340 */  jal      func_800E4D00
/* 800ACCA0 00000000 */  nop      
/* 800ACCA4 8ea400b0 */  lw       $a0,176($s5)
/* 800ACCA8 8ea501c8 */  lw       $a1,456($s5)
/* 800ACCAC 0c039340 */  jal      func_800E4D00
/* 800ACCB0 00408021 */  move     $s0,$v0
/* 800ACCB4 8ea400b4 */  lw       $a0,180($s5)
/* 800ACCB8 8ea501cc */  lw       $a1,460($s5)
/* 800ACCBC 0c039340 */  jal      func_800E4D00
/* 800ACCC0 00408821 */  move     $s1,$v0
/* 800ACCC4 02118021 */  addu     $s0,$s0,$s1
/* 800ACCC8 8ea400ac */  lw       $a0,172($s5)
/* 800ACCCC 8ea501d0 */  lw       $a1,464($s5)
/* 800ACCD0 02028021 */  addu     $s0,$s0,$v0
/* 800ACCD4 0c039340 */  jal      func_800E4D00
/* 800ACCD8 aeb00418 */  sw       $s0,1048($s5)
/* 800ACCDC 8ea400b0 */  lw       $a0,176($s5)
/* 800ACCE0 8ea501d4 */  lw       $a1,468($s5)
/* 800ACCE4 0c039340 */  jal      func_800E4D00
/* 800ACCE8 00408021 */  move     $s0,$v0
/* 800ACCEC 8ea400b4 */  lw       $a0,180($s5)
/* 800ACCF0 8ea501d8 */  lw       $a1,472($s5)
/* 800ACCF4 0c039340 */  jal      func_800E4D00
/* 800ACCF8 00408821 */  move     $s1,$v0
/* 800ACCFC 02118021 */  addu     $s0,$s0,$s1
/* 800ACD00 8ea400ac */  lw       $a0,172($s5)
/* 800ACD04 8ea501dc */  lw       $a1,476($s5)
/* 800ACD08 02028021 */  addu     $s0,$s0,$v0
/* 800ACD0C 0c039340 */  jal      func_800E4D00
/* 800ACD10 aeb0041c */  sw       $s0,1052($s5)
/* 800ACD14 8ea400b0 */  lw       $a0,176($s5)
/* 800ACD18 8ea501e0 */  lw       $a1,480($s5)
/* 800ACD1C 0c039340 */  jal      func_800E4D00
/* 800ACD20 00408021 */  move     $s0,$v0
/* 800ACD24 8ea400b4 */  lw       $a0,180($s5)
/* 800ACD28 8ea501e4 */  lw       $a1,484($s5)
/* 800ACD2C 0c039340 */  jal      func_800E4D00
/* 800ACD30 00408821 */  move     $s1,$v0
/* 800ACD34 02118021 */  addu     $s0,$s0,$s1
/* 800ACD38 8ea40114 */  lw       $a0,276($s5)
/* 800ACD3C 8ea501c4 */  lw       $a1,452($s5)
/* 800ACD40 02028021 */  addu     $s0,$s0,$v0
/* 800ACD44 0c039340 */  jal      func_800E4D00
/* 800ACD48 aeb00420 */  sw       $s0,1056($s5)
/* 800ACD4C 8ea40118 */  lw       $a0,280($s5)
/* 800ACD50 8ea501c8 */  lw       $a1,456($s5)
/* 800ACD54 0c039340 */  jal      func_800E4D00
/* 800ACD58 00408021 */  move     $s0,$v0
/* 800ACD5C 8ea4011c */  lw       $a0,284($s5)
/* 800ACD60 8ea501cc */  lw       $a1,460($s5)
/* 800ACD64 0c039340 */  jal      func_800E4D00
/* 800ACD68 00408821 */  move     $s1,$v0
/* 800ACD6C 02118021 */  addu     $s0,$s0,$s1
/* 800ACD70 8ea40114 */  lw       $a0,276($s5)
/* 800ACD74 8ea501d0 */  lw       $a1,464($s5)
/* 800ACD78 02028021 */  addu     $s0,$s0,$v0
/* 800ACD7C 0c039340 */  jal      func_800E4D00
/* 800ACD80 aeb00424 */  sw       $s0,1060($s5)
/* 800ACD84 8ea40118 */  lw       $a0,280($s5)
/* 800ACD88 8ea501d4 */  lw       $a1,468($s5)
/* 800ACD8C 0c039340 */  jal      func_800E4D00
/* 800ACD90 00408021 */  move     $s0,$v0
/* 800ACD94 8ea4011c */  lw       $a0,284($s5)
/* 800ACD98 8ea501d8 */  lw       $a1,472($s5)
/* 800ACD9C 0c039340 */  jal      func_800E4D00
/* 800ACDA0 00408821 */  move     $s1,$v0
/* 800ACDA4 02118021 */  addu     $s0,$s0,$s1
/* 800ACDA8 8ea40114 */  lw       $a0,276($s5)
/* 800ACDAC 8ea501dc */  lw       $a1,476($s5)
/* 800ACDB0 02028021 */  addu     $s0,$s0,$v0
/* 800ACDB4 0c039340 */  jal      func_800E4D00
/* 800ACDB8 aeb00428 */  sw       $s0,1064($s5)
/* 800ACDBC 8ea40118 */  lw       $a0,280($s5)
/* 800ACDC0 8ea501e0 */  lw       $a1,480($s5)
/* 800ACDC4 0c039340 */  jal      func_800E4D00
/* 800ACDC8 00408021 */  move     $s0,$v0
/* 800ACDCC 8ea4011c */  lw       $a0,284($s5)
/* 800ACDD0 8ea501e4 */  lw       $a1,484($s5)
/* 800ACDD4 0c039340 */  jal      func_800E4D00
/* 800ACDD8 00408821 */  move     $s1,$v0
/* 800ACDDC 02118021 */  addu     $s0,$s0,$s1
/* 800ACDE0 02028021 */  addu     $s0,$s0,$v0
/* 800ACDE4 8ea50420 */  lw       $a1,1056($s5)
/* 800ACDE8 3c020005 */  lui      $v0,0x5
/* 800ACDEC 0045102a */  slt      $v0,$v0,$a1
/* 800ACDF0 10400006 */  beqz     $v0,.L800ACE0C
/* 800ACDF4 aeb0042c */  sw       $s0,1068($s5)
/* 800ACDF8 8ea40418 */  lw       $a0,1048($s5)
/* 800ACDFC 0c039377 */  jal      func_800E4DDC
/* 800ACE00 00000000 */  nop      
/* 800ACE04 0802b384 */  j        .L800ACE10
/* 800ACE08 aea20478 */  sw       $v0,1144($s5)
.L800ACE0C:
/* 800ACE0C aea00478 */  sw       $zero,1144($s5)
.L800ACE10:
/* 800ACE10 8ea20418 */  lw       $v0,1048($s5)
/* 800ACE14 00000000 */  nop      
/* 800ACE18 00021140 */  sll      $v0,$v0,0x5
/* 800ACE1C 00021023 */  negu     $v0,$v0
/* 800ACE20 00021fc2 */  srl      $v1,$v0,0x1f
/* 800ACE24 00431021 */  addu     $v0,$v0,$v1
/* 800ACE28 00021043 */  sra      $v0,$v0,0x1
/* 800ACE2C afa20090 */  sw       $v0,144($sp)
/* 800ACE30 8ea2041c */  lw       $v0,1052($s5)
/* 800ACE34 00000000 */  nop      
/* 800ACE38 00021140 */  sll      $v0,$v0,0x5
/* 800ACE3C 00021023 */  negu     $v0,$v0
/* 800ACE40 00021fc2 */  srl      $v1,$v0,0x1f
/* 800ACE44 00431021 */  addu     $v0,$v0,$v1
/* 800ACE48 00021043 */  sra      $v0,$v0,0x1
/* 800ACE4C afa20094 */  sw       $v0,148($sp)
/* 800ACE50 8ea20420 */  lw       $v0,1056($s5)
/* 800ACE54 00000000 */  nop      
/* 800ACE58 00021140 */  sll      $v0,$v0,0x5
/* 800ACE5C 00021023 */  negu     $v0,$v0
/* 800ACE60 00021fc2 */  srl      $v1,$v0,0x1f
/* 800ACE64 00431021 */  addu     $v0,$v0,$v1
/* 800ACE68 00021043 */  sra      $v0,$v0,0x1
/* 800ACE6C afa20098 */  sw       $v0,152($sp)
/* 800ACE70 8ea40118 */  lw       $a0,280($s5)
/* 800ACE74 8ec501c4 */  lw       $a1,452($s6)
/* 800ACE78 0c039340 */  jal      func_800E4D00
/* 800ACE7C 00042140 */  sll      $a0,$a0,0x5
/* 800ACE80 00002021 */  move     $a0,$zero
/* 800ACE84 3c03fff6 */  lui      $v1,0xfff6
/* 800ACE88 00029023 */  negu     $s2,$v0
/* 800ACE8C 001217c2 */  srl      $v0,$s2,0x1f
/* 800ACE90 02429021 */  addu     $s2,$s2,$v0
/* 800ACE94 afa00070 */  sw       $zero,112($sp)
/* 800ACE98 afa30074 */  sw       $v1,116($sp)
/* 800ACE9C afa00078 */  sw       $zero,120($sp)
/* 800ACEA0 8ea501c4 */  lw       $a1,452($s5)
/* 800ACEA4 0c039340 */  jal      func_800E4D00
/* 800ACEA8 00129043 */  sra      $s2,$s2,0x1
/* 800ACEAC 8fa40074 */  lw       $a0,116($sp)
/* 800ACEB0 8ea501c8 */  lw       $a1,456($s5)
/* 800ACEB4 0c039340 */  jal      func_800E4D00
/* 800ACEB8 00408021 */  move     $s0,$v0
/* 800ACEBC 8fa40078 */  lw       $a0,120($sp)
/* 800ACEC0 8ea501cc */  lw       $a1,460($s5)
/* 800ACEC4 0c039340 */  jal      func_800E4D00
/* 800ACEC8 00408821 */  move     $s1,$v0
/* 800ACECC 3c138011 */  lui      $s3,0x8011
/* 800ACED0 02118021 */  addu     $s0,$s0,$s1
/* 800ACED4 8fa40070 */  lw       $a0,112($sp)
/* 800ACED8 02028021 */  addu     $s0,$s0,$v0
/* 800ACEDC ae707678 */  sw       $s0,30328($s3)
/* 800ACEE0 8ea501d0 */  lw       $a1,464($s5)
/* 800ACEE4 0c039340 */  jal      func_800E4D00
/* 800ACEE8 26747678 */  addiu    $s4,$s3,30328
/* 800ACEEC 8fa40074 */  lw       $a0,116($sp)
/* 800ACEF0 8ea501d4 */  lw       $a1,468($s5)
/* 800ACEF4 0c039340 */  jal      func_800E4D00
/* 800ACEF8 00408021 */  move     $s0,$v0
/* 800ACEFC 8fa40078 */  lw       $a0,120($sp)
/* 800ACF00 8ea501d8 */  lw       $a1,472($s5)
/* 800ACF04 0c039340 */  jal      func_800E4D00
/* 800ACF08 00408821 */  move     $s1,$v0
/* 800ACF0C 02118021 */  addu     $s0,$s0,$s1
/* 800ACF10 8fa40070 */  lw       $a0,112($sp)
/* 800ACF14 02028021 */  addu     $s0,$s0,$v0
/* 800ACF18 ae900004 */  sw       $s0,4($s4)
/* 800ACF1C 8ea501dc */  lw       $a1,476($s5)
/* 800ACF20 0c039340 */  jal      func_800E4D00
/* 800ACF24 00000000 */  nop      
/* 800ACF28 8fa40074 */  lw       $a0,116($sp)
/* 800ACF2C 8ea501e0 */  lw       $a1,480($s5)
/* 800ACF30 0c039340 */  jal      func_800E4D00
/* 800ACF34 00408021 */  move     $s0,$v0
/* 800ACF38 8fa40078 */  lw       $a0,120($sp)
/* 800ACF3C 8ea501e4 */  lw       $a1,484($s5)
/* 800ACF40 0c039340 */  jal      func_800E4D00
/* 800ACF44 00408821 */  move     $s1,$v0
/* 800ACF48 02a02021 */  move     $a0,$s5
/* 800ACF4C 02118021 */  addu     $s0,$s0,$s1
/* 800ACF50 02028021 */  addu     $s0,$s0,$v0
/* 800ACF54 ae900008 */  sw       $s0,8($s4)
/* 800ACF58 8fa30090 */  lw       $v1,144($sp)
/* 800ACF5C 8fa50094 */  lw       $a1,148($sp)
/* 800ACF60 8fa60098 */  lw       $a2,152($sp)
/* 800ACF64 00721021 */  addu     $v0,$v1,$s2
/* 800ACF68 00721823 */  subu     $v1,$v1,$s2
/* 800ACF6C afa20020 */  sw       $v0,32($sp)
/* 800ACF70 afa50024 */  sw       $a1,36($sp)
/* 800ACF74 afa60028 */  sw       $a2,40($sp)
/* 800ACF78 afa30050 */  sw       $v1,80($sp)
/* 800ACF7C afa50054 */  sw       $a1,84($sp)
/* 800ACF80 0c02a9d5 */  jal      func_800AA754
/* 800ACF84 afa60058 */  sw       $a2,88($sp)
/* 800ACF88 8e637678 */  lw       $v1,30328($s3)
/* 800ACF8C 00000000 */  nop      
/* 800ACF90 04610002 */  bgez     $v1,.L800ACF9C
/* 800ACF94 00000000 */  nop      
/* 800ACF98 246300ff */  addiu    $v1,$v1,255
.L800ACF9C:
/* 800ACF9C 00031a03 */  sra      $v1,$v1,0x8
/* 800ACFA0 00031040 */  sll      $v0,$v1,0x1
/* 800ACFA4 00431021 */  addu     $v0,$v0,$v1
/* 800ACFA8 00021a00 */  sll      $v1,$v0,0x8
/* 800ACFAC 04610002 */  bgez     $v1,.L800ACFB8
/* 800ACFB0 3402ffff */  li       $v0,0xffff
/* 800ACFB4 00621821 */  addu     $v1,$v1,$v0
.L800ACFB8:
/* 800ACFB8 8ea20450 */  lw       $v0,1104($s5)
/* 800ACFBC 00038403 */  sra      $s0,$v1,0x10
/* 800ACFC0 00501821 */  addu     $v1,$v0,$s0
/* 800ACFC4 28620080 */  slti     $v0,$v1,128
/* 800ACFC8 14400003 */  bnez     $v0,.L800ACFD8
/* 800ACFCC 2862ff81 */  slti     $v0,$v1,-127
/* 800ACFD0 0802b3f9 */  j        .L800ACFE4
/* 800ACFD4 2403007f */  li       $v1,127
.L800ACFD8:
/* 800ACFD8 10400002 */  beqz     $v0,.L800ACFE4
/* 800ACFDC 00000000 */  nop      
/* 800ACFE0 2403ff81 */  li       $v1,-127
.L800ACFE4:
/* 800ACFE4 8ec2010c */  lw       $v0,268($s6)
/* 800ACFE8 00000000 */  nop      
/* 800ACFEC 00620018 */  mult     $v1,$v0
/* 800ACFF0 00001012 */  mflo     $v0
/* 800ACFF4 04410003 */  bgez     $v0,.L800AD004
/* 800ACFF8 000229c3 */  sra      $a1,$v0,0x7
/* 800ACFFC 2442007f */  addiu    $v0,$v0,127
/* 800AD000 000229c3 */  sra      $a1,$v0,0x7
.L800AD004:
/* 800AD004 afa5001c */  sw       $a1,28($sp)
/* 800AD008 8ea20218 */  lw       $v0,536($s5)
/* 800AD00C 8ea3021c */  lw       $v1,540($s5)
/* 800AD010 00000000 */  nop      
/* 800AD014 00431021 */  addu     $v0,$v0,$v1
/* 800AD018 8ea30220 */  lw       $v1,544($s5)
/* 800AD01C 8ea4023c */  lw       $a0,572($s5)
/* 800AD020 00431021 */  addu     $v0,$v0,$v1
/* 800AD024 00441821 */  addu     $v1,$v0,$a0
/* 800AD028 04610002 */  bgez     $v1,.L800AD034
/* 800AD02C 00601021 */  move     $v0,$v1
/* 800AD030 246201ff */  addiu    $v0,$v1,511
.L800AD034:
/* 800AD034 00021a43 */  sra      $v1,$v0,0x9
/* 800AD038 00a02021 */  move     $a0,$a1
/* 800AD03C 3c020001 */  lui      $v0,0x1
/* 800AD040 04810002 */  bgez     $a0,.L800AD04C
/* 800AD044 00431023 */  subu     $v0,$v0,$v1
/* 800AD048 248400ff */  addiu    $a0,$a0,255
.L800AD04C:
/* 800AD04C 04410002 */  bgez     $v0,.L800AD058
/* 800AD050 00041a03 */  sra      $v1,$a0,0x8
/* 800AD054 244200ff */  addiu    $v0,$v0,255
.L800AD058:
/* 800AD058 00021203 */  sra      $v0,$v0,0x8
/* 800AD05C 00620018 */  mult     $v1,$v0
/* 800AD060 00004012 */  mflo     $t0
/* 800AD064 afa8001c */  sw       $t0,28($sp)
/* 800AD068 8ea40420 */  lw       $a0,1056($s5)
/* 800AD06C 3c02003c */  lui      $v0,0x3c
/* 800AD070 0044102a */  slt      $v0,$v0,$a0
/* 800AD074 10400008 */  beqz     $v0,.L800AD098
/* 800AD078 3c02001a */  lui      $v0,0x1a
/* 800AD07C 0c039340 */  jal      func_800E4D00
/* 800AD080 24050444 */  li       $a1,1092
/* 800AD084 8fa4001c */  lw       $a0,28($sp)
/* 800AD088 0c039377 */  jal      func_800E4DDC
/* 800AD08C 00402821 */  move     $a1,$v0
/* 800AD090 afa2001c */  sw       $v0,28($sp)
/* 800AD094 3c02001a */  lui      $v0,0x1a
.L800AD098:
/* 800AD098 8ea30420 */  lw       $v1,1056($s5)
/* 800AD09C 3442b333 */  ori      $v0,$v0,0xb333
/* 800AD0A0 0043102a */  slt      $v0,$v0,$v1
/* 800AD0A4 1040000c */  beqz     $v0,.L800AD0D8
/* 800AD0A8 3c02000d */  lui      $v0,0xd
/* 800AD0AC 8ea30478 */  lw       $v1,1144($s5)
/* 800AD0B0 00000000 */  nop      
/* 800AD0B4 28620ccd */  slti     $v0,$v1,3277
/* 800AD0B8 14400014 */  bnez     $v0,.L800AD10C
/* 800AD0BC 2862f334 */  slti     $v0,$v1,-3276
/* 800AD0C0 8fa2001c */  lw       $v0,28($sp)
/* 800AD0C4 00000000 */  nop      
/* 800AD0C8 1c400016 */  bgtz     $v0,.L800AD124
/* 800AD0CC 2862f334 */  slti     $v0,$v1,-3276
/* 800AD0D0 0802b443 */  j        .L800AD10C
/* 800AD0D4 00000000 */  nop      
.L800AD0D8:
/* 800AD0D8 34426666 */  ori      $v0,$v0,0x6666
/* 800AD0DC 0043102a */  slt      $v0,$v0,$v1
/* 800AD0E0 10400020 */  beqz     $v0,.L800AD164
/* 800AD0E4 02a02021 */  move     $a0,$s5
/* 800AD0E8 8ea30478 */  lw       $v1,1144($s5)
/* 800AD0EC 00000000 */  nop      
/* 800AD0F0 28622667 */  slti     $v0,$v1,9831
/* 800AD0F4 14400005 */  bnez     $v0,.L800AD10C
/* 800AD0F8 2862d99a */  slti     $v0,$v1,-9830
/* 800AD0FC 8fa2001c */  lw       $v0,28($sp)
/* 800AD100 00000000 */  nop      
/* 800AD104 1c400007 */  bgtz     $v0,.L800AD124
/* 800AD108 2862d99a */  slti     $v0,$v1,-9830
.L800AD10C:
/* 800AD10C 10400015 */  beqz     $v0,.L800AD164
/* 800AD110 02a02021 */  move     $a0,$s5
/* 800AD114 8fa2001c */  lw       $v0,28($sp)
/* 800AD118 00000000 */  nop      
/* 800AD11C 04410012 */  bgez     $v0,.L800AD168
/* 800AD120 24020001 */  li       $v0,1
.L800AD124:
/* 800AD124 8ea20478 */  lw       $v0,1144($s5)
/* 800AD128 3c050001 */  lui      $a1,0x1
/* 800AD12C 04410002 */  bgez     $v0,.L800AD138
/* 800AD130 00000000 */  nop      
/* 800AD134 00021023 */  negu     $v0,$v0
.L800AD138:
/* 800AD138 00021840 */  sll      $v1,$v0,0x1
/* 800AD13C 00a01021 */  move     $v0,$a1
/* 800AD140 0043102a */  slt      $v0,$v0,$v1
/* 800AD144 14400002 */  bnez     $v0,.L800AD150
/* 800AD148 00000000 */  nop      
/* 800AD14C 00602821 */  move     $a1,$v1
.L800AD150:
/* 800AD150 8fa4001c */  lw       $a0,28($sp)
/* 800AD154 0c039340 */  jal      func_800E4D00
/* 800AD158 00000000 */  nop      
/* 800AD15C afa2001c */  sw       $v0,28($sp)
/* 800AD160 02a02021 */  move     $a0,$s5
.L800AD164:
/* 800AD164 24020001 */  li       $v0,1
.L800AD168:
/* 800AD168 afa0004c */  sw       $zero,76($sp)
/* 800AD16C afa20038 */  sw       $v0,56($sp)
/* 800AD170 0c02acf3 */  jal      func_800AB3CC
/* 800AD174 afa00068 */  sw       $zero,104($sp)
/* 800AD178 00402021 */  move     $a0,$v0
/* 800AD17C 04810002 */  bgez     $a0,.L800AD188
/* 800AD180 00801821 */  move     $v1,$a0
/* 800AD184 248300ff */  addiu    $v1,$a0,255
.L800AD188:
/* 800AD188 8ec200f8 */  lw       $v0,248($s6)
/* 800AD18C 00000000 */  nop      
/* 800AD190 04410002 */  bgez     $v0,.L800AD19C
/* 800AD194 00031a03 */  sra      $v1,$v1,0x8
/* 800AD198 244200ff */  addiu    $v0,$v0,255
.L800AD19C:
/* 800AD19C 00021203 */  sra      $v0,$v0,0x8
/* 800AD1A0 00620018 */  mult     $v1,$v0
/* 800AD1A4 8f830dc4 */  lw       $v1,3524($gp)
/* 800AD1A8 00001012 */  mflo     $v0
/* 800AD1AC afa20010 */  sw       $v0,16($sp)
/* 800AD1B0 00821023 */  subu     $v0,$a0,$v0
/* 800AD1B4 14600008 */  bnez     $v1,.L800AD1D8
/* 800AD1B8 afa20040 */  sw       $v0,64($sp)
/* 800AD1BC 8f820dc8 */  lw       $v0,3528($gp)
/* 800AD1C0 00000000 */  nop      
/* 800AD1C4 14400004 */  bnez     $v0,.L800AD1D8
/* 800AD1C8 00000000 */  nop      
/* 800AD1CC aea00484 */  sw       $zero,1156($s5)
/* 800AD1D0 0802b7da */  j        .L800ADF68
/* 800AD1D4 aea00488 */  sw       $zero,1160($s5)
.L800AD1D8:
/* 800AD1D8 8f830d98 */  lw       $v1,3480($gp)
/* 800AD1DC 00000000 */  nop      
/* 800AD1E0 04610002 */  bgez     $v1,.L800AD1EC
/* 800AD1E4 aea003ec */  sw       $zero,1004($s5)
/* 800AD1E8 246300ff */  addiu    $v1,$v1,255
.L800AD1EC:
/* 800AD1EC 8ec200fc */  lw       $v0,252($s6)
/* 800AD1F0 00000000 */  nop      
/* 800AD1F4 04410002 */  bgez     $v0,.L800AD200
/* 800AD1F8 00032203 */  sra      $a0,$v1,0x8
/* 800AD1FC 244200ff */  addiu    $v0,$v0,255
.L800AD200:
/* 800AD200 00021203 */  sra      $v0,$v0,0x8
/* 800AD204 00820018 */  mult     $a0,$v0
/* 800AD208 8ea20420 */  lw       $v0,1056($s5)
/* 800AD20C 00000000 */  nop      
/* 800AD210 04410002 */  bgez     $v0,.L800AD21C
/* 800AD214 00000000 */  nop      
/* 800AD218 00021023 */  negu     $v0,$v0
.L800AD21C:
/* 800AD21C 00021140 */  sll      $v0,$v0,0x5
/* 800AD220 00402021 */  move     $a0,$v0
/* 800AD224 00008012 */  mflo     $s0
/* 800AD228 0090102a */  slt      $v0,$a0,$s0
/* 800AD22C 14400002 */  bnez     $v0,.L800AD238
/* 800AD230 00000000 */  nop      
/* 800AD234 02002021 */  move     $a0,$s0
.L800AD238:
/* 800AD238 8ea3023c */  lw       $v1,572($s5)
/* 800AD23C 00000000 */  nop      
/* 800AD240 1060000f */  beqz     $v1,.L800AD280
/* 800AD244 00808021 */  move     $s0,$a0
/* 800AD248 04610002 */  bgez     $v1,.L800AD254
/* 800AD24C 02002021 */  move     $a0,$s0
/* 800AD250 2463007f */  addiu    $v1,$v1,127
.L800AD254:
/* 800AD254 000319c3 */  sra      $v1,$v1,0x7
/* 800AD258 3c020001 */  lui      $v0,0x1
/* 800AD25C 06010002 */  bgez     $s0,.L800AD268
/* 800AD260 00431023 */  subu     $v0,$v0,$v1
/* 800AD264 260400ff */  addiu    $a0,$s0,255
.L800AD268:
/* 800AD268 04410002 */  bgez     $v0,.L800AD274
/* 800AD26C 00042203 */  sra      $a0,$a0,0x8
/* 800AD270 244200ff */  addiu    $v0,$v0,255
.L800AD274:
/* 800AD274 00021203 */  sra      $v0,$v0,0x8
/* 800AD278 00820018 */  mult     $a0,$v0
/* 800AD27C 00008012 */  mflo     $s0
.L800AD280:
/* 800AD280 8ea20420 */  lw       $v0,1056($s5)
/* 800AD284 00000000 */  nop      
/* 800AD288 18400002 */  blez     $v0,.L800AD294
/* 800AD28C 00000000 */  nop      
/* 800AD290 00108023 */  negu     $s0,$s0
.L800AD294:
/* 800AD294 8ec50100 */  lw       $a1,256($s6)
/* 800AD298 0c039340 */  jal      func_800E4D00
/* 800AD29C 02002021 */  move     $a0,$s0
/* 800AD2A0 8fa30010 */  lw       $v1,16($sp)
/* 800AD2A4 00000000 */  nop      
/* 800AD2A8 00621821 */  addu     $v1,$v1,$v0
/* 800AD2AC afa30010 */  sw       $v1,16($sp)
/* 800AD2B0 8fa30040 */  lw       $v1,64($sp)
/* 800AD2B4 02021023 */  subu     $v0,$s0,$v0
/* 800AD2B8 00621821 */  addu     $v1,$v1,$v0
/* 800AD2BC 3c028011 */  lui      $v0,0x8011
/* 800AD2C0 8c44767c */  lw       $a0,30332($v0)
/* 800AD2C4 afa30040 */  sw       $v1,64($sp)
/* 800AD2C8 8ec50114 */  lw       $a1,276($s6)
/* 800AD2CC 0c039340 */  jal      func_800E4D00
/* 800AD2D0 00042023 */  negu     $a0,$a0
/* 800AD2D4 00408821 */  move     $s1,$v0
/* 800AD2D8 0c02ac94 */  jal      func_800AB250
/* 800AD2DC 02a02021 */  move     $a0,$s5
/* 800AD2E0 06210002 */  bgez     $s1,.L800AD2EC
/* 800AD2E4 02201821 */  move     $v1,$s1
/* 800AD2E8 262300ff */  addiu    $v1,$s1,255
.L800AD2EC:
/* 800AD2EC 8f820dac */  lw       $v0,3500($gp)
/* 800AD2F0 00000000 */  nop      
/* 800AD2F4 04410002 */  bgez     $v0,.L800AD300
/* 800AD2F8 00032203 */  sra      $a0,$v1,0x8
/* 800AD2FC 244200ff */  addiu    $v0,$v0,255
.L800AD300:
/* 800AD300 00021203 */  sra      $v0,$v0,0x8
/* 800AD304 00820018 */  mult     $a0,$v0
/* 800AD308 00008812 */  mflo     $s1
/* 800AD30C 06200316 */  bltz     $s1,.L800ADF68
/* 800AD310 00000000 */  nop      
/* 800AD314 8f820dc0 */  lw       $v0,3520($gp)
/* 800AD318 00000000 */  nop      
/* 800AD31C 10400004 */  beqz     $v0,.L800AD330
/* 800AD320 02202021 */  move     $a0,$s1
/* 800AD324 8ec50108 */  lw       $a1,264($s6)
/* 800AD328 0802b4cd */  j        .L800AD334
/* 800AD32C 24a5028f */  addiu    $a1,$a1,655
.L800AD330:
/* 800AD330 8ec50108 */  lw       $a1,264($s6)
.L800AD334:
/* 800AD334 0c039340 */  jal      func_800E4D00
/* 800AD338 00000000 */  nop      
/* 800AD33C 00409021 */  move     $s2,$v0
/* 800AD340 8ea20228 */  lw       $v0,552($s5)
/* 800AD344 8ea3022c */  lw       $v1,556($s5)
/* 800AD348 00000000 */  nop      
/* 800AD34C 00431021 */  addu     $v0,$v0,$v1
/* 800AD350 8ea30230 */  lw       $v1,560($s5)
/* 800AD354 8ea4023c */  lw       $a0,572($s5)
/* 800AD358 00431021 */  addu     $v0,$v0,$v1
/* 800AD35C 00441021 */  addu     $v0,$v0,$a0
/* 800AD360 04410003 */  bgez     $v0,.L800AD370
/* 800AD364 00021a43 */  sra      $v1,$v0,0x9
/* 800AD368 244201ff */  addiu    $v0,$v0,511
/* 800AD36C 00021a43 */  sra      $v1,$v0,0x9
.L800AD370:
/* 800AD370 3402c000 */  li       $v0,0xc000
/* 800AD374 00628021 */  addu     $s0,$v1,$v0
/* 800AD378 8ea4047c */  lw       $a0,1148($s5)
/* 800AD37C 0c039340 */  jal      func_800E4D00
/* 800AD380 02002821 */  move     $a1,$s0
/* 800AD384 00402021 */  move     $a0,$v0
/* 800AD388 0481000b */  bgez     $a0,.L800AD3B8
/* 800AD38C aea4047c */  sw       $a0,1148($s5)
/* 800AD390 02002821 */  move     $a1,$s0
/* 800AD394 248200ff */  addiu    $v0,$a0,255
/* 800AD398 04a10002 */  bgez     $a1,.L800AD3A4
/* 800AD39C 00021a03 */  sra      $v1,$v0,0x8
/* 800AD3A0 24a500ff */  addiu    $a1,$a1,255
.L800AD3A4:
/* 800AD3A4 00051203 */  sra      $v0,$a1,0x8
/* 800AD3A8 00620018 */  mult     $v1,$v0
/* 800AD3AC 00004012 */  mflo     $t0
/* 800AD3B0 0802b4f6 */  j        .L800AD3D8
/* 800AD3B4 aea8047c */  sw       $t0,1148($s5)
.L800AD3B8:
/* 800AD3B8 18800007 */  blez     $a0,.L800AD3D8
/* 800AD3BC 00041040 */  sll      $v0,$a0,0x1
/* 800AD3C0 00441021 */  addu     $v0,$v0,$a0
/* 800AD3C4 04410002 */  bgez     $v0,.L800AD3D0
/* 800AD3C8 00000000 */  nop      
/* 800AD3CC 24420003 */  addiu    $v0,$v0,3
.L800AD3D0:
/* 800AD3D0 00021083 */  sra      $v0,$v0,0x2
/* 800AD3D4 aea2047c */  sw       $v0,1148($s5)
.L800AD3D8:
/* 800AD3D8 8ea2047c */  lw       $v0,1148($s5)
/* 800AD3DC 8f830db0 */  lw       $v1,3504($gp)
/* 800AD3E0 02421023 */  subu     $v0,$s2,$v0
/* 800AD3E4 04610002 */  bgez     $v1,.L800AD3F0
/* 800AD3E8 afa20014 */  sw       $v0,20($sp)
/* 800AD3EC 246300ff */  addiu    $v1,$v1,255
.L800AD3F0:
/* 800AD3F0 04410002 */  bgez     $v0,.L800AD3FC
/* 800AD3F4 00031a03 */  sra      $v1,$v1,0x8
/* 800AD3F8 244200ff */  addiu    $v0,$v0,255
.L800AD3FC:
/* 800AD3FC 00021203 */  sra      $v0,$v0,0x8
/* 800AD400 00620018 */  mult     $v1,$v0
/* 800AD404 02321023 */  subu     $v0,$s1,$s2
/* 800AD408 00004012 */  mflo     $t0
/* 800AD40C afa80014 */  sw       $t0,20($sp)
/* 800AD410 8ea3047c */  lw       $v1,1148($s5)
/* 800AD414 8f840db4 */  lw       $a0,3508($gp)
/* 800AD418 00431021 */  addu     $v0,$v0,$v1
/* 800AD41C 04810002 */  bgez     $a0,.L800AD428
/* 800AD420 afa20044 */  sw       $v0,68($sp)
/* 800AD424 248400ff */  addiu    $a0,$a0,255
.L800AD428:
/* 800AD428 04410002 */  bgez     $v0,.L800AD434
/* 800AD42C 00041a03 */  sra      $v1,$a0,0x8
/* 800AD430 244200ff */  addiu    $v0,$v0,255
.L800AD434:
/* 800AD434 00021203 */  sra      $v0,$v0,0x8
/* 800AD438 00620018 */  mult     $v1,$v0
/* 800AD43C 8f820dc4 */  lw       $v0,3524($gp)
/* 800AD440 00004012 */  mflo     $t0
/* 800AD444 afa80044 */  sw       $t0,68($sp)
/* 800AD448 aea00474 */  sw       $zero,1140($s5)
/* 800AD44C afa0002c */  sw       $zero,44($sp)
/* 800AD450 afa00034 */  sw       $zero,52($sp)
/* 800AD454 afa0005c */  sw       $zero,92($sp)
/* 800AD458 10400004 */  beqz     $v0,.L800AD46C
/* 800AD45C afa00064 */  sw       $zero,100($sp)
/* 800AD460 02a02021 */  move     $a0,$s5
/* 800AD464 0c02b121 */  jal      func_800AC484
/* 800AD468 27a50010 */  addiu    $a1,$sp,16
.L800AD46C:
/* 800AD46C 8f820dc8 */  lw       $v0,3528($gp)
/* 800AD470 00000000 */  nop      
/* 800AD474 10400003 */  beqz     $v0,.L800AD484
/* 800AD478 02a02021 */  move     $a0,$s5
/* 800AD47C 0c02b121 */  jal      func_800AC484
/* 800AD480 27a50040 */  addiu    $a1,$sp,64
.L800AD484:
/* 800AD484 8fa20034 */  lw       $v0,52($sp)
/* 800AD488 8fa30064 */  lw       $v1,100($sp)
/* 800AD48C 00000000 */  nop      
/* 800AD490 00431021 */  addu     $v0,$v0,$v1
/* 800AD494 aea20414 */  sw       $v0,1044($s5)
/* 800AD498 8fa2002c */  lw       $v0,44($sp)
/* 800AD49C 8fa3005c */  lw       $v1,92($sp)
/* 800AD4A0 8ea40414 */  lw       $a0,1044($s5)
/* 800AD4A4 00431021 */  addu     $v0,$v0,$v1
/* 800AD4A8 aea2040c */  sw       $v0,1036($s5)
/* 800AD4AC 8ec501cc */  lw       $a1,460($s6)
/* 800AD4B0 0c039340 */  jal      func_800E4D00
/* 800AD4B4 00000000 */  nop      
/* 800AD4B8 00401821 */  move     $v1,$v0
/* 800AD4BC 3c028011 */  lui      $v0,0x8011
/* 800AD4C0 aea30414 */  sw       $v1,1044($s5)
/* 800AD4C4 8c4242c8 */  lw       $v0,17096($v0)
/* 800AD4C8 00000000 */  nop      
/* 800AD4CC 30420080 */  andi     $v0,$v0,0x80
/* 800AD4D0 10400008 */  beqz     $v0,.L800AD4F4
/* 800AD4D4 00000000 */  nop      
/* 800AD4D8 18600006 */  blez     $v1,.L800AD4F4
/* 800AD4DC 00000000 */  nop      
/* 800AD4E0 92a20446 */  lbu      $v0,1094($s5)
/* 800AD4E4 00000000 */  nop      
/* 800AD4E8 10400002 */  beqz     $v0,.L800AD4F4
/* 800AD4EC 00031080 */  sll      $v0,$v1,0x2
/* 800AD4F0 aea20414 */  sw       $v0,1044($s5)
.L800AD4F4:
/* 800AD4F4 8f820dc0 */  lw       $v0,3520($gp)
/* 800AD4F8 00000000 */  nop      
/* 800AD4FC 14400015 */  bnez     $v0,.L800AD554
/* 800AD500 3c028011 */  lui      $v0,0x8011
/* 800AD504 8ea20288 */  lw       $v0,648($s5)
/* 800AD508 00000000 */  nop      
/* 800AD50C 8c430038 */  lw       $v1,56($v0)
/* 800AD510 24020002 */  li       $v0,2
/* 800AD514 14620009 */  bne      $v1,$v0,.L800AD53C
/* 800AD518 3c050001 */  lui      $a1,0x1
/* 800AD51C 92a20442 */  lbu      $v0,1090($s5)
/* 800AD520 00000000 */  nop      
/* 800AD524 2c420004 */  sltiu    $v0,$v0,4
/* 800AD528 10400004 */  beqz     $v0,.L800AD53C
/* 800AD52C 00000000 */  nop      
/* 800AD530 8ea40414 */  lw       $a0,1044($s5)
/* 800AD534 0802b551 */  j        .L800AD544
/* 800AD538 34a52666 */  ori      $a1,$a1,0x2666
.L800AD53C:
/* 800AD53C 8ea40414 */  lw       $a0,1044($s5)
/* 800AD540 34a51999 */  ori      $a1,$a1,0x1999
.L800AD544:
/* 800AD544 0c039340 */  jal      func_800E4D00
/* 800AD548 00000000 */  nop      
/* 800AD54C aea20414 */  sw       $v0,1044($s5)
/* 800AD550 3c028011 */  lui      $v0,0x8011
.L800AD554:
/* 800AD554 aea00410 */  sw       $zero,1040($s5)
/* 800AD558 8c447680 */  lw       $a0,30336($v0)
/* 800AD55C 0c039340 */  jal      func_800E4D00
/* 800AD560 24051999 */  li       $a1,6553
/* 800AD564 8ea4040c */  lw       $a0,1036($s5)
/* 800AD568 00000000 */  nop      
/* 800AD56C 04810002 */  bgez     $a0,.L800AD578
/* 800AD570 00028023 */  negu     $s0,$v0
/* 800AD574 24840007 */  addiu    $a0,$a0,7
.L800AD578:
/* 800AD578 8ec50124 */  lw       $a1,292($s6)
/* 800AD57C 0c039340 */  jal      func_800E4D00
/* 800AD580 000420c3 */  sra      $a0,$a0,0x3
/* 800AD584 8ea40414 */  lw       $a0,1044($s5)
/* 800AD588 00021023 */  negu     $v0,$v0
/* 800AD58C aea20480 */  sw       $v0,1152($s5)
/* 800AD590 8ec50124 */  lw       $a1,292($s6)
/* 800AD594 0c039340 */  jal      func_800E4D00
/* 800AD598 00000000 */  nop      
/* 800AD59C 00501021 */  addu     $v0,$v0,$s0
/* 800AD5A0 aea2047c */  sw       $v0,1148($s5)
/* 800AD5A4 8fa2002c */  lw       $v0,44($sp)
/* 800AD5A8 8fa4005c */  lw       $a0,92($sp)
/* 800AD5AC 8ec501c8 */  lw       $a1,456($s6)
/* 800AD5B0 0c039340 */  jal      func_800E4D00
/* 800AD5B4 00442023 */  subu     $a0,$v0,$a0
/* 800AD5B8 00408021 */  move     $s0,$v0
/* 800AD5BC 8fa60034 */  lw       $a2,52($sp)
/* 800AD5C0 8fa40064 */  lw       $a0,100($sp)
/* 800AD5C4 8f830db8 */  lw       $v1,3512($gp)
/* 800AD5C8 8f850dbc */  lw       $a1,3516($gp)
/* 800AD5CC 00c42021 */  addu     $a0,$a2,$a0
/* 800AD5D0 0c039340 */  jal      func_800E4D00
/* 800AD5D4 00652823 */  subu     $a1,$v1,$a1
/* 800AD5D8 8ec501c8 */  lw       $a1,456($s6)
/* 800AD5DC 0c039340 */  jal      func_800E4D00
/* 800AD5E0 00402021 */  move     $a0,$v0
/* 800AD5E4 00021040 */  sll      $v0,$v0,0x1
/* 800AD5E8 02028021 */  addu     $s0,$s0,$v0
/* 800AD5EC afb00084 */  sw       $s0,132($sp)
/* 800AD5F0 8ea20118 */  lw       $v0,280($s5)
/* 800AD5F4 00000000 */  nop      
/* 800AD5F8 18400003 */  blez     $v0,.L800AD608
/* 800AD5FC 00000000 */  nop      
/* 800AD600 1e000005 */  bgtz     $s0,.L800AD618
/* 800AD604 00000000 */  nop      
.L800AD608:
/* 800AD608 0441002f */  bgez     $v0,.L800AD6C8
/* 800AD60C 00000000 */  nop      
/* 800AD610 0601002d */  bgez     $s0,.L800AD6C8
/* 800AD614 00000000 */  nop      
.L800AD618:
/* 800AD618 92a20445 */  lbu      $v0,1093($s5)
/* 800AD61C 00000000 */  nop      
/* 800AD620 1040000c */  beqz     $v0,.L800AD654
/* 800AD624 3c028011 */  lui      $v0,0x8011
/* 800AD628 8c4242c8 */  lw       $v0,17096($v0)
/* 800AD62C 00000000 */  nop      
/* 800AD630 30420008 */  andi     $v0,$v0,0x8
/* 800AD634 14400007 */  bnez     $v0,.L800AD654
/* 800AD638 00000000 */  nop      
/* 800AD63C 8fa20084 */  lw       $v0,132($sp)
/* 800AD640 00000000 */  nop      
/* 800AD644 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD648 00431021 */  addu     $v0,$v0,$v1
/* 800AD64C 0802b5b1 */  j        .L800AD6C4
/* 800AD650 00021043 */  sra      $v0,$v0,0x1
.L800AD654:
/* 800AD654 8ea3044c */  lw       $v1,1100($s5)
/* 800AD658 00000000 */  nop      
/* 800AD65C 04610006 */  bgez     $v1,.L800AD678
/* 800AD660 00000000 */  nop      
/* 800AD664 8ea20118 */  lw       $v0,280($s5)
/* 800AD668 00000000 */  nop      
/* 800AD66C 28423334 */  slti     $v0,$v0,13108
/* 800AD670 10400008 */  beqz     $v0,.L800AD694
/* 800AD674 00000000 */  nop      
.L800AD678:
/* 800AD678 1860000d */  blez     $v1,.L800AD6B0
/* 800AD67C 00000000 */  nop      
/* 800AD680 8ea20118 */  lw       $v0,280($s5)
/* 800AD684 00000000 */  nop      
/* 800AD688 2842cccd */  slti     $v0,$v0,-13107
/* 800AD68C 10400008 */  beqz     $v0,.L800AD6B0
/* 800AD690 00000000 */  nop      
.L800AD694:
/* 800AD694 8ea3046c */  lw       $v1,1132($s5)
/* 800AD698 24020001 */  li       $v0,1
/* 800AD69C 14620004 */  bne      $v1,$v0,.L800AD6B0
/* 800AD6A0 00000000 */  nop      
/* 800AD6A4 8ea20118 */  lw       $v0,280($s5)
/* 800AD6A8 0802b5b1 */  j        .L800AD6C4
/* 800AD6AC 00021023 */  negu     $v0,$v0
.L800AD6B0:
/* 800AD6B0 8ea20464 */  lw       $v0,1124($s5)
/* 800AD6B4 8fa40084 */  lw       $a0,132($sp)
/* 800AD6B8 8c45012c */  lw       $a1,300($v0)
/* 800AD6BC 0c039340 */  jal      func_800E4D00
/* 800AD6C0 00000000 */  nop      
.L800AD6C4:
/* 800AD6C4 afa20084 */  sw       $v0,132($sp)
.L800AD6C8:
/* 800AD6C8 26a401c4 */  addiu    $a0,$s5,452
/* 800AD6CC 27a500a0 */  addiu    $a1,$sp,160
/* 800AD6D0 afa00080 */  sw       $zero,128($sp)
/* 800AD6D4 0c03934c */  jal      func_800E4D30
/* 800AD6D8 afa00088 */  sw       $zero,136($sp)
/* 800AD6DC 02a02021 */  move     $a0,$s5
/* 800AD6E0 0c0219ea */  jal      func_800867A8
/* 800AD6E4 00002821 */  move     $a1,$zero
/* 800AD6E8 8ea4040c */  lw       $a0,1036($s5)
/* 800AD6EC 8fa500a0 */  lw       $a1,160($sp)
/* 800AD6F0 0c039340 */  jal      func_800E4D00
/* 800AD6F4 00000000 */  nop      
/* 800AD6F8 8ea40410 */  lw       $a0,1040($s5)
/* 800AD6FC 8fa500a4 */  lw       $a1,164($sp)
/* 800AD700 0c039340 */  jal      func_800E4D00
/* 800AD704 00408021 */  move     $s0,$v0
/* 800AD708 8ea40414 */  lw       $a0,1044($s5)
/* 800AD70C 8fa500a8 */  lw       $a1,168($sp)
/* 800AD710 0c039340 */  jal      func_800E4D00
/* 800AD714 00408821 */  move     $s1,$v0
/* 800AD718 02118021 */  addu     $s0,$s0,$s1
/* 800AD71C 8ea4040c */  lw       $a0,1036($s5)
/* 800AD720 02028021 */  addu     $s0,$s0,$v0
/* 800AD724 aeb00400 */  sw       $s0,1024($s5)
/* 800AD728 8fa500ac */  lw       $a1,172($sp)
/* 800AD72C 0c039340 */  jal      func_800E4D00
/* 800AD730 00000000 */  nop      
/* 800AD734 8ea40410 */  lw       $a0,1040($s5)
/* 800AD738 8fa500b0 */  lw       $a1,176($sp)
/* 800AD73C 0c039340 */  jal      func_800E4D00
/* 800AD740 00408021 */  move     $s0,$v0
/* 800AD744 8ea40414 */  lw       $a0,1044($s5)
/* 800AD748 8fa500b4 */  lw       $a1,180($sp)
/* 800AD74C 0c039340 */  jal      func_800E4D00
/* 800AD750 00408821 */  move     $s1,$v0
/* 800AD754 02118021 */  addu     $s0,$s0,$s1
/* 800AD758 8ea4040c */  lw       $a0,1036($s5)
/* 800AD75C 02028021 */  addu     $s0,$s0,$v0
/* 800AD760 aeb00404 */  sw       $s0,1028($s5)
/* 800AD764 8fa500b8 */  lw       $a1,184($sp)
/* 800AD768 0c039340 */  jal      func_800E4D00
/* 800AD76C 00000000 */  nop      
/* 800AD770 8ea40410 */  lw       $a0,1040($s5)
/* 800AD774 8fa500bc */  lw       $a1,188($sp)
/* 800AD778 0c039340 */  jal      func_800E4D00
/* 800AD77C 00408021 */  move     $s0,$v0
/* 800AD780 8ea40414 */  lw       $a0,1044($s5)
/* 800AD784 8fa500c0 */  lw       $a1,192($sp)
/* 800AD788 0c039340 */  jal      func_800E4D00
/* 800AD78C 00408821 */  move     $s1,$v0
/* 800AD790 02118021 */  addu     $s0,$s0,$s1
/* 800AD794 02028021 */  addu     $s0,$s0,$v0
/* 800AD798 aeb00408 */  sw       $s0,1032($s5)
/* 800AD79C 8fa40080 */  lw       $a0,128($sp)
/* 800AD7A0 8fa500a0 */  lw       $a1,160($sp)
/* 800AD7A4 0c039340 */  jal      func_800E4D00
/* 800AD7A8 00000000 */  nop      
/* 800AD7AC 8fa40084 */  lw       $a0,132($sp)
/* 800AD7B0 8fa500a4 */  lw       $a1,164($sp)
/* 800AD7B4 0c039340 */  jal      func_800E4D00
/* 800AD7B8 00408021 */  move     $s0,$v0
/* 800AD7BC 8fa40088 */  lw       $a0,136($sp)
/* 800AD7C0 8fa500a8 */  lw       $a1,168($sp)
/* 800AD7C4 0c039340 */  jal      func_800E4D00
/* 800AD7C8 00408821 */  move     $s1,$v0
/* 800AD7CC 02118021 */  addu     $s0,$s0,$s1
/* 800AD7D0 02028021 */  addu     $s0,$s0,$v0
/* 800AD7D4 aeb003f4 */  sw       $s0,1012($s5)
/* 800AD7D8 8fa40080 */  lw       $a0,128($sp)
/* 800AD7DC 8fa500ac */  lw       $a1,172($sp)
/* 800AD7E0 0c039340 */  jal      func_800E4D00
/* 800AD7E4 00000000 */  nop      
/* 800AD7E8 8fa40084 */  lw       $a0,132($sp)
/* 800AD7EC 8fa500b0 */  lw       $a1,176($sp)
/* 800AD7F0 0c039340 */  jal      func_800E4D00
/* 800AD7F4 00408021 */  move     $s0,$v0
/* 800AD7F8 8fa40088 */  lw       $a0,136($sp)
/* 800AD7FC 8fa500b4 */  lw       $a1,180($sp)
/* 800AD800 0c039340 */  jal      func_800E4D00
/* 800AD804 00408821 */  move     $s1,$v0
/* 800AD808 02118021 */  addu     $s0,$s0,$s1
/* 800AD80C 02028021 */  addu     $s0,$s0,$v0
/* 800AD810 aeb003f8 */  sw       $s0,1016($s5)
/* 800AD814 8fa40080 */  lw       $a0,128($sp)
/* 800AD818 8fa500b8 */  lw       $a1,184($sp)
/* 800AD81C 0c039340 */  jal      func_800E4D00
/* 800AD820 00000000 */  nop      
/* 800AD824 8fa40084 */  lw       $a0,132($sp)
/* 800AD828 8fa500bc */  lw       $a1,188($sp)
/* 800AD82C 0c039340 */  jal      func_800E4D00
/* 800AD830 00408021 */  move     $s0,$v0
/* 800AD834 8fa40088 */  lw       $a0,136($sp)
/* 800AD838 8fa500c0 */  lw       $a1,192($sp)
/* 800AD83C 0c039340 */  jal      func_800E4D00
/* 800AD840 00408821 */  move     $s1,$v0
/* 800AD844 02118021 */  addu     $s0,$s0,$s1
/* 800AD848 8ea30400 */  lw       $v1,1024($s5)
/* 800AD84C 02028021 */  addu     $s0,$s0,$v0
/* 800AD850 04610002 */  bgez     $v1,.L800AD85C
/* 800AD854 aeb003fc */  sw       $s0,1020($s5)
/* 800AD858 2463001f */  addiu    $v1,$v1,31
.L800AD85C:
/* 800AD85C 00031943 */  sra      $v1,$v1,0x5
/* 800AD860 8ea200ac */  lw       $v0,172($s5)
/* 800AD864 8ea40404 */  lw       $a0,1028($s5)
/* 800AD868 00431021 */  addu     $v0,$v0,$v1
/* 800AD86C 04810002 */  bgez     $a0,.L800AD878
/* 800AD870 aea200ac */  sw       $v0,172($s5)
/* 800AD874 2484001f */  addiu    $a0,$a0,31
.L800AD878:
/* 800AD878 00041943 */  sra      $v1,$a0,0x5
/* 800AD87C 8ea200b0 */  lw       $v0,176($s5)
/* 800AD880 8ea50408 */  lw       $a1,1032($s5)
/* 800AD884 00431021 */  addu     $v0,$v0,$v1
/* 800AD888 04a10002 */  bgez     $a1,.L800AD894
/* 800AD88C aea200b0 */  sw       $v0,176($s5)
/* 800AD890 24a5001f */  addiu    $a1,$a1,31
.L800AD894:
/* 800AD894 00051943 */  sra      $v1,$a1,0x5
/* 800AD898 8ea200b4 */  lw       $v0,180($s5)
/* 800AD89C 8ea403f4 */  lw       $a0,1012($s5)
/* 800AD8A0 00431021 */  addu     $v0,$v0,$v1
/* 800AD8A4 04810002 */  bgez     $a0,.L800AD8B0
/* 800AD8A8 aea200b4 */  sw       $v0,180($s5)
/* 800AD8AC 2484001f */  addiu    $a0,$a0,31
.L800AD8B0:
/* 800AD8B0 00041943 */  sra      $v1,$a0,0x5
/* 800AD8B4 8ea20114 */  lw       $v0,276($s5)
/* 800AD8B8 8ea503f8 */  lw       $a1,1016($s5)
/* 800AD8BC 00431021 */  addu     $v0,$v0,$v1
/* 800AD8C0 04a10002 */  bgez     $a1,.L800AD8CC
/* 800AD8C4 aea20114 */  sw       $v0,276($s5)
/* 800AD8C8 24a5003f */  addiu    $a1,$a1,63
.L800AD8CC:
/* 800AD8CC 00051983 */  sra      $v1,$a1,0x6
/* 800AD8D0 8ea20118 */  lw       $v0,280($s5)
/* 800AD8D4 8ea403fc */  lw       $a0,1020($s5)
/* 800AD8D8 00431021 */  addu     $v0,$v0,$v1
/* 800AD8DC 04810002 */  bgez     $a0,.L800AD8E8
/* 800AD8E0 aea20118 */  sw       $v0,280($s5)
/* 800AD8E4 2484001f */  addiu    $a0,$a0,31
.L800AD8E8:
/* 800AD8E8 00041143 */  sra      $v0,$a0,0x5
/* 800AD8EC 8ea3011c */  lw       $v1,284($s5)
/* 800AD8F0 8ea40460 */  lw       $a0,1120($s5)
/* 800AD8F4 00621821 */  addu     $v1,$v1,$v0
/* 800AD8F8 10800119 */  beqz     $a0,.L800ADD60
/* 800AD8FC aea3011c */  sw       $v1,284($s5)
/* 800AD900 3c020004 */  lui      $v0,0x4
/* 800AD904 8ea3055c */  lw       $v1,1372($s5)
/* 800AD908 344271c6 */  ori      $v0,$v0,0x71c6
/* 800AD90C 0043102a */  slt      $v0,$v0,$v1
/* 800AD910 1440000f */  bnez     $v0,.L800AD950
/* 800AD914 00000000 */  nop      
/* 800AD918 92a20442 */  lbu      $v0,1090($s5)
/* 800AD91C 00000000 */  nop      
/* 800AD920 2c420002 */  sltiu    $v0,$v0,2
/* 800AD924 14400004 */  bnez     $v0,.L800AD938
/* 800AD928 00000000 */  nop      
/* 800AD92C 92a20442 */  lbu      $v0,1090($s5)
/* 800AD930 0802b64f */  j        .L800AD93C
/* 800AD934 00021080 */  sll      $v0,$v0,0x2
.L800AD938:
/* 800AD938 24020008 */  li       $v0,8
.L800AD93C:
/* 800AD93C 3c040018 */  lui      $a0,0x18
/* 800AD940 02c21021 */  addu     $v0,$s6,$v0
/* 800AD944 8c45000c */  lw       $a1,12($v0)
/* 800AD948 0802b660 */  j        .L800AD980
/* 800AD94C 34848000 */  ori      $a0,$a0,0x8000
.L800AD950:
/* 800AD950 92a20442 */  lbu      $v0,1090($s5)
/* 800AD954 00000000 */  nop      
/* 800AD958 2c420002 */  sltiu    $v0,$v0,2
/* 800AD95C 14400004 */  bnez     $v0,.L800AD970
/* 800AD960 00000000 */  nop      
/* 800AD964 92a20442 */  lbu      $v0,1090($s5)
/* 800AD968 0802b65d */  j        .L800AD974
/* 800AD96C 00021080 */  sll      $v0,$v0,0x2
.L800AD970:
/* 800AD970 24020008 */  li       $v0,8
.L800AD974:
/* 800AD974 02c21021 */  addu     $v0,$s6,$v0
/* 800AD978 8ea4055c */  lw       $a0,1372($s5)
/* 800AD97C 8c45000c */  lw       $a1,12($v0)
.L800AD980:
/* 800AD980 0c039340 */  jal      func_800E4D00
/* 800AD984 00000000 */  nop      
/* 800AD988 00401821 */  move     $v1,$v0
/* 800AD98C 04610002 */  bgez     $v1,.L800AD998
/* 800AD990 3402ffff */  li       $v0,0xffff
/* 800AD994 00621821 */  addu     $v1,$v1,$v0
.L800AD998:
/* 800AD998 92a20442 */  lbu      $v0,1090($s5)
/* 800AD99C 00000000 */  nop      
/* 800AD9A0 2c420002 */  sltiu    $v0,$v0,2
/* 800AD9A4 14400004 */  bnez     $v0,.L800AD9B8
/* 800AD9A8 00038403 */  sra      $s0,$v1,0x10
/* 800AD9AC 92a20442 */  lbu      $v0,1090($s5)
/* 800AD9B0 0802b66f */  j        .L800AD9BC
/* 800AD9B4 00021080 */  sll      $v0,$v0,0x2
.L800AD9B8:
/* 800AD9B8 24020008 */  li       $v0,8
.L800AD9BC:
/* 800AD9BC 02c21021 */  addu     $v0,$s6,$v0
/* 800AD9C0 8ea40420 */  lw       $a0,1056($s5)
/* 800AD9C4 8c45000c */  lw       $a1,12($v0)
/* 800AD9C8 0c039340 */  jal      func_800E4D00
/* 800AD9CC 00000000 */  nop      
/* 800AD9D0 00402821 */  move     $a1,$v0
/* 800AD9D4 04a10002 */  bgez     $a1,.L800AD9E0
/* 800AD9D8 3402ffff */  li       $v0,0xffff
/* 800AD9DC 00a22821 */  addu     $a1,$a1,$v0
.L800AD9E0:
/* 800AD9E0 8ec300f0 */  lw       $v1,240($s6)
/* 800AD9E4 00101200 */  sll      $v0,$s0,0x8
/* 800AD9E8 0043001a */  div      $zero,$v0,$v1
/* 800AD9EC 14600002 */  bnez     $v1,.L800AD9F8
/* 800AD9F0 00000000 */  nop      
/* 800AD9F4 0007000d */  break    0x7
.L800AD9F8:
/* 800AD9F8 2401ffff */  li       $at,-1
/* 800AD9FC 14610004 */  bne      $v1,$at,.L800ADA10
/* 800ADA00 3c018000 */  lui      $at,0x8000
/* 800ADA04 14410002 */  bne      $v0,$at,.L800ADA10
/* 800ADA08 00000000 */  nop      
/* 800ADA0C 0006000d */  break    0x6
.L800ADA10:
/* 800ADA10 00002012 */  mflo     $a0
/* 800ADA14 00051403 */  sra      $v0,$a1,0x10
/* 800ADA18 02022823 */  subu     $a1,$s0,$v0
/* 800ADA1C 28a200c9 */  slti     $v0,$a1,201
/* 800ADA20 14400016 */  bnez     $v0,.L800ADA7C
/* 800ADA24 28a200c8 */  slti     $v0,$a1,200
/* 800ADA28 000511c0 */  sll      $v0,$a1,0x7
/* 800ADA2C 0050001a */  div      $zero,$v0,$s0
/* 800ADA30 16000002 */  bnez     $s0,.L800ADA3C
/* 800ADA34 00000000 */  nop      
/* 800ADA38 0007000d */  break    0x7
.L800ADA3C:
/* 800ADA3C 2401ffff */  li       $at,-1
/* 800ADA40 16010004 */  bne      $s0,$at,.L800ADA54
/* 800ADA44 3c018000 */  lui      $at,0x8000
/* 800ADA48 14410002 */  bne      $v0,$at,.L800ADA54
/* 800ADA4C 00000000 */  nop      
/* 800ADA50 0006000d */  break    0x6
.L800ADA54:
/* 800ADA54 00001012 */  mflo     $v0
/* 800ADA58 00000000 */  nop      
/* 800ADA5C 00822021 */  addu     $a0,$a0,$v0
/* 800ADA60 00801821 */  move     $v1,$a0
/* 800ADA64 286200e1 */  slti     $v0,$v1,225
/* 800ADA68 14400002 */  bnez     $v0,.L800ADA74
/* 800ADA6C 00000000 */  nop      
/* 800ADA70 240300e0 */  li       $v1,224
.L800ADA74:
/* 800ADA74 0802b6cf */  j        .L800ADB3C
/* 800ADA78 a2a30458 */  sb       $v1,1112($s5)
.L800ADA7C:
/* 800ADA7C 1040002f */  beqz     $v0,.L800ADB3C
/* 800ADA80 000511c0 */  sll      $v0,$a1,0x7
/* 800ADA84 0050001a */  div      $zero,$v0,$s0
/* 800ADA88 16000002 */  bnez     $s0,.L800ADA94
/* 800ADA8C 00000000 */  nop      
/* 800ADA90 0007000d */  break    0x7
.L800ADA94:
/* 800ADA94 2401ffff */  li       $at,-1
/* 800ADA98 16010004 */  bne      $s0,$at,.L800ADAAC
/* 800ADA9C 3c018000 */  lui      $at,0x8000
/* 800ADAA0 14410002 */  bne      $v0,$at,.L800ADAAC
/* 800ADAA4 00000000 */  nop      
/* 800ADAA8 0006000d */  break    0x6
.L800ADAAC:
/* 800ADAAC 00001012 */  mflo     $v0
/* 800ADAB0 00000000 */  nop      
/* 800ADAB4 00822021 */  addu     $a0,$a0,$v0
/* 800ADAB8 04800003 */  bltz     $a0,.L800ADAC8
/* 800ADABC 00000000 */  nop      
/* 800ADAC0 0802b6b3 */  j        .L800ADACC
/* 800ADAC4 a2a40458 */  sb       $a0,1112($s5)
.L800ADAC8:
/* 800ADAC8 a2a00458 */  sb       $zero,1112($s5)
.L800ADACC:
/* 800ADACC 04a1001c */  bgez     $a1,.L800ADB40
/* 800ADAD0 3c032aaa */  lui      $v1,0x2aaa
/* 800ADAD4 00051240 */  sll      $v0,$a1,0x9
/* 800ADAD8 8ec300f0 */  lw       $v1,240($s6)
/* 800ADADC 04410002 */  bgez     $v0,.L800ADAE8
/* 800ADAE0 00000000 */  nop      
/* 800ADAE4 00021023 */  negu     $v0,$v0
.L800ADAE8:
/* 800ADAE8 0043001a */  div      $zero,$v0,$v1
/* 800ADAEC 14600002 */  bnez     $v1,.L800ADAF8
/* 800ADAF0 00000000 */  nop      
/* 800ADAF4 0007000d */  break    0x7
.L800ADAF8:
/* 800ADAF8 2401ffff */  li       $at,-1
/* 800ADAFC 14610004 */  bne      $v1,$at,.L800ADB10
/* 800ADB00 3c018000 */  lui      $at,0x8000
/* 800ADB04 14410002 */  bne      $v0,$at,.L800ADB10
/* 800ADB08 00000000 */  nop      
/* 800ADB0C 0006000d */  break    0x6
.L800ADB10:
/* 800ADB10 00001812 */  mflo     $v1
/* 800ADB14 00000000 */  nop      
/* 800ADB18 28620100 */  slti     $v0,$v1,256
/* 800ADB1C 14400003 */  bnez     $v0,.L800ADB2C
/* 800ADB20 306200ff */  andi     $v0,$v1,0xff
/* 800ADB24 240300ff */  li       $v1,255
/* 800ADB28 306200ff */  andi     $v0,$v1,0xff
.L800ADB2C:
/* 800ADB2C 2c420081 */  sltiu    $v0,$v0,129
/* 800ADB30 14400002 */  bnez     $v0,.L800ADB3C
/* 800ADB34 a2a30459 */  sb       $v1,1113($s5)
/* 800ADB38 a2a00458 */  sb       $zero,1112($s5)
.L800ADB3C:
/* 800ADB3C 3c032aaa */  lui      $v1,0x2aaa
.L800ADB40:
/* 800ADB40 8ea20564 */  lw       $v0,1380($s5)
/* 800ADB44 3463aaab */  ori      $v1,$v1,0xaaab
/* 800ADB48 04410002 */  bgez     $v0,.L800ADB54
/* 800ADB4C 00000000 */  nop      
/* 800ADB50 00021023 */  negu     $v0,$v0
.L800ADB54:
/* 800ADB54 00430018 */  mult     $v0,$v1
/* 800ADB58 000217c3 */  sra      $v0,$v0,0x1f
/* 800ADB5C 00004010 */  mfhi     $t0
/* 800ADB60 00081c03 */  sra      $v1,$t0,0x10
/* 800ADB64 00623023 */  subu     $a2,$v1,$v0
/* 800ADB68 28c20003 */  slti     $v0,$a2,3
/* 800ADB6C 8ea30460 */  lw       $v1,1120($s5)
/* 800ADB70 14400005 */  bnez     $v0,.L800ADB88
/* 800ADB74 00031040 */  sll      $v0,$v1,0x1
/* 800ADB78 00660018 */  mult     $v1,$a2
/* 800ADB7C 00001812 */  mflo     $v1
/* 800ADB80 0802b6e3 */  j        .L800ADB8C
/* 800ADB84 00000000 */  nop      
.L800ADB88:
/* 800ADB88 00431821 */  addu     $v1,$v0,$v1
.L800ADB8C:
/* 800ADB8C 0460000a */  bltz     $v1,.L800ADBB8
/* 800ADB90 00000000 */  nop      
/* 800ADB94 86a20008 */  lh       $v0,8($s5)
/* 800ADB98 3c048014 */  lui      $a0,0x8014
/* 800ADB9C 8c84d8a8 */  lw       $a0,-10072($a0)
/* 800ADBA0 00432821 */  addu     $a1,$v0,$v1
/* 800ADBA4 00a4102a */  slt      $v0,$a1,$a0
/* 800ADBA8 1440000c */  bnez     $v0,.L800ADBDC
/* 800ADBAC 00000000 */  nop      
/* 800ADBB0 0802b6f7 */  j        .L800ADBDC
/* 800ADBB4 00a42823 */  subu     $a1,$a1,$a0
.L800ADBB8:
/* 800ADBB8 86a20008 */  lh       $v0,8($s5)
/* 800ADBBC 00000000 */  nop      
/* 800ADBC0 00432821 */  addu     $a1,$v0,$v1
/* 800ADBC4 04a10005 */  bgez     $a1,.L800ADBDC
/* 800ADBC8 00000000 */  nop      
/* 800ADBCC 3c028014 */  lui      $v0,0x8014
/* 800ADBD0 8c42d8a8 */  lw       $v0,-10072($v0)
/* 800ADBD4 00000000 */  nop      
/* 800ADBD8 00a22821 */  addu     $a1,$a1,$v0
.L800ADBDC:
/* 800ADBDC 00058140 */  sll      $s0,$a1,0x5
/* 800ADBE0 00033040 */  sll      $a2,$v1,0x1
/* 800ADBE4 00c33021 */  addu     $a2,$a2,$v1
/* 800ADBE8 3c028014 */  lui      $v0,0x8014
/* 800ADBEC 8c42d8a0 */  lw       $v0,-10080($v0)
/* 800ADBF0 04c10002 */  bgez     $a2,.L800ADBFC
/* 800ADBF4 00000000 */  nop      
/* 800ADBF8 00063023 */  negu     $a2,$a2
.L800ADBFC:
/* 800ADBFC 8ea800a0 */  lw       $t0,160($s5)
/* 800ADC00 8ea900a4 */  lw       $t1,164($s5)
/* 800ADC04 8eaa00a8 */  lw       $t2,168($s5)
/* 800ADC08 afa800c8 */  sw       $t0,200($sp)
/* 800ADC0C afa900cc */  sw       $t1,204($sp)
/* 800ADC10 afaa00d0 */  sw       $t2,208($sp)
/* 800ADC14 02021021 */  addu     $v0,$s0,$v0
/* 800ADC18 8c480000 */  lw       $t0,0($v0)
/* 800ADC1C 8c490004 */  lw       $t1,4($v0)
/* 800ADC20 8c4a0008 */  lw       $t2,8($v0)
/* 800ADC24 afa800d8 */  sw       $t0,216($sp)
/* 800ADC28 afa900dc */  sw       $t1,220($sp)
/* 800ADC2C afaa00e0 */  sw       $t2,224($sp)
/* 800ADC30 0c02b27b */  jal      func_800AC9EC
/* 800ADC34 02a02021 */  move     $a0,$s5
/* 800ADC38 3c038014 */  lui      $v1,0x8014
/* 800ADC3C 8c63d8a0 */  lw       $v1,-10080($v1)
/* 800ADC40 00408821 */  move     $s1,$v0
/* 800ADC44 02031821 */  addu     $v1,$s0,$v1
/* 800ADC48 80640012 */  lb       $a0,18($v1)
/* 800ADC4C 02202821 */  move     $a1,$s1
/* 800ADC50 0c039340 */  jal      func_800E4D00
/* 800ADC54 00042240 */  sll      $a0,$a0,0x9
/* 800ADC58 3c038014 */  lui      $v1,0x8014
/* 800ADC5C 8c63d8a0 */  lw       $v1,-10080($v1)
/* 800ADC60 afa200e8 */  sw       $v0,232($sp)
/* 800ADC64 02031821 */  addu     $v1,$s0,$v1
/* 800ADC68 80640013 */  lb       $a0,19($v1)
/* 800ADC6C 02202821 */  move     $a1,$s1
/* 800ADC70 0c039340 */  jal      func_800E4D00
/* 800ADC74 00042240 */  sll      $a0,$a0,0x9
/* 800ADC78 3c038014 */  lui      $v1,0x8014
/* 800ADC7C 8c63d8a0 */  lw       $v1,-10080($v1)
/* 800ADC80 afa200ec */  sw       $v0,236($sp)
/* 800ADC84 02038021 */  addu     $s0,$s0,$v1
/* 800ADC88 82040014 */  lb       $a0,20($s0)
/* 800ADC8C 02202821 */  move     $a1,$s1
/* 800ADC90 0c039340 */  jal      func_800E4D00
/* 800ADC94 00042240 */  sll      $a0,$a0,0x9
/* 800ADC98 8fa500d8 */  lw       $a1,216($sp)
/* 800ADC9C 8fa300e8 */  lw       $v1,232($sp)
/* 800ADCA0 8fa600dc */  lw       $a2,220($sp)
/* 800ADCA4 8fa700ec */  lw       $a3,236($sp)
/* 800ADCA8 00a32821 */  addu     $a1,$a1,$v1
/* 800ADCAC 00c73021 */  addu     $a2,$a2,$a3
/* 800ADCB0 8fa300e0 */  lw       $v1,224($sp)
/* 800ADCB4 8fa700c8 */  lw       $a3,200($sp)
/* 800ADCB8 afa200f0 */  sw       $v0,240($sp)
/* 800ADCBC afa500d8 */  sw       $a1,216($sp)
/* 800ADCC0 00621821 */  addu     $v1,$v1,$v0
/* 800ADCC4 8fa200cc */  lw       $v0,204($sp)
/* 800ADCC8 00a72823 */  subu     $a1,$a1,$a3
/* 800ADCCC afa500d8 */  sw       $a1,216($sp)
/* 800ADCD0 8fa500d0 */  lw       $a1,208($sp)
/* 800ADCD4 27a400d8 */  addiu    $a0,$sp,216
/* 800ADCD8 afa600dc */  sw       $a2,220($sp)
/* 800ADCDC afa300e0 */  sw       $v1,224($sp)
/* 800ADCE0 00c23023 */  subu     $a2,$a2,$v0
/* 800ADCE4 00651823 */  subu     $v1,$v1,$a1
/* 800ADCE8 afa600dc */  sw       $a2,220($sp)
/* 800ADCEC 0c027938 */  jal      func_8009E4E0
/* 800ADCF0 afa300e0 */  sw       $v1,224($sp)
/* 800ADCF4 8fa400d8 */  lw       $a0,216($sp)
/* 800ADCF8 8ea500f0 */  lw       $a1,240($s5)
/* 800ADCFC 0c039340 */  jal      func_800E4D00
/* 800ADD00 00000000 */  nop      
/* 800ADD04 8fa400dc */  lw       $a0,220($sp)
/* 800ADD08 8ea500f4 */  lw       $a1,244($s5)
/* 800ADD0C 0c039340 */  jal      func_800E4D00
/* 800ADD10 00408021 */  move     $s0,$v0
/* 800ADD14 8fa400e0 */  lw       $a0,224($sp)
/* 800ADD18 8ea500f8 */  lw       $a1,248($s5)
/* 800ADD1C 0c039340 */  jal      func_800E4D00
/* 800ADD20 00408821 */  move     $s1,$v0
/* 800ADD24 02118021 */  addu     $s0,$s0,$s1
/* 800ADD28 02021021 */  addu     $v0,$s0,$v0
/* 800ADD2C 04410003 */  bgez     $v0,.L800ADD3C
/* 800ADD30 00028203 */  sra      $s0,$v0,0x8
/* 800ADD34 244200ff */  addiu    $v0,$v0,255
/* 800ADD38 00028203 */  sra      $s0,$v0,0x8
.L800ADD3C:
/* 800ADD3C 2a020080 */  slti     $v0,$s0,128
/* 800ADD40 14400003 */  bnez     $v0,.L800ADD50
/* 800ADD44 aeb0045c */  sw       $s0,1116($s5)
/* 800ADD48 0802b757 */  j        .L800ADD5C
/* 800ADD4C 2402007f */  li       $v0,127
.L800ADD50:
/* 800ADD50 2a02ff81 */  slti     $v0,$s0,-127
/* 800ADD54 10400002 */  beqz     $v0,.L800ADD60
/* 800ADD58 2402ff81 */  li       $v0,-127
.L800ADD5C:
/* 800ADD5C aea2045c */  sw       $v0,1116($s5)
.L800ADD60:
/* 800ADD60 3c028011 */  lui      $v0,0x8011
/* 800ADD64 8c4242c8 */  lw       $v0,17096($v0)
/* 800ADD68 00000000 */  nop      
/* 800ADD6C 30420008 */  andi     $v0,$v0,0x8
/* 800ADD70 1440001f */  bnez     $v0,.L800ADDF0
/* 800ADD74 00000000 */  nop      
/* 800ADD78 92a2043f */  lbu      $v0,1087($s5)
/* 800ADD7C 00000000 */  nop      
/* 800ADD80 10400009 */  beqz     $v0,.L800ADDA8
/* 800ADD84 00000000 */  nop      
/* 800ADD88 8ea20478 */  lw       $v0,1144($s5)
/* 800ADD8C 00000000 */  nop      
/* 800ADD90 04410002 */  bgez     $v0,.L800ADD9C
/* 800ADD94 00000000 */  nop      
/* 800ADD98 00021023 */  negu     $v0,$v0
.L800ADD9C:
/* 800ADD9C 2842199a */  slti     $v0,$v0,6554
/* 800ADDA0 14400013 */  bnez     $v0,.L800ADDF0
/* 800ADDA4 00000000 */  nop      
.L800ADDA8:
/* 800ADDA8 8ea20464 */  lw       $v0,1124($s5)
/* 800ADDAC 8ea500ac */  lw       $a1,172($s5)
/* 800ADDB0 8c440158 */  lw       $a0,344($v0)
/* 800ADDB4 0c039340 */  jal      func_800E4D00
/* 800ADDB8 00000000 */  nop      
/* 800ADDBC 8ea500b0 */  lw       $a1,176($s5)
/* 800ADDC0 8ea30464 */  lw       $v1,1124($s5)
/* 800ADDC4 aea200ac */  sw       $v0,172($s5)
/* 800ADDC8 8c640158 */  lw       $a0,344($v1)
/* 800ADDCC 0c039340 */  jal      func_800E4D00
/* 800ADDD0 00000000 */  nop      
/* 800ADDD4 8ea500b4 */  lw       $a1,180($s5)
/* 800ADDD8 8ea30464 */  lw       $v1,1124($s5)
/* 800ADDDC aea200b0 */  sw       $v0,176($s5)
/* 800ADDE0 8c640158 */  lw       $a0,344($v1)
/* 800ADDE4 0c039340 */  jal      func_800E4D00
/* 800ADDE8 00000000 */  nop      
/* 800ADDEC aea200b4 */  sw       $v0,180($s5)
.L800ADDF0:
/* 800ADDF0 8ea301c0 */  lw       $v1,448($s5)
/* 800ADDF4 24020003 */  li       $v0,3
/* 800ADDF8 14620010 */  bne      $v1,$v0,.L800ADE3C
/* 800ADDFC 3c02002c */  lui      $v0,0x2c
/* 800ADE00 8ea300c0 */  lw       $v1,192($s5)
/* 800ADE04 3442a3d7 */  ori      $v0,$v0,0xa3d7
/* 800ADE08 0043102a */  slt      $v0,$v0,$v1
/* 800ADE0C 1040000b */  beqz     $v0,.L800ADE3C
/* 800ADE10 00000000 */  nop      
/* 800ADE14 8ea500ac */  lw       $a1,172($s5)
/* 800ADE18 0c039340 */  jal      func_800E4D00
/* 800ADE1C 3404feb8 */  li       $a0,0xfeb8
/* 800ADE20 8ea500b0 */  lw       $a1,176($s5)
/* 800ADE24 3404feb8 */  li       $a0,0xfeb8
/* 800ADE28 0c039340 */  jal      func_800E4D00
/* 800ADE2C aea200ac */  sw       $v0,172($s5)
/* 800ADE30 8ea500b4 */  lw       $a1,180($s5)
/* 800ADE34 0802b7d7 */  j        .L800ADF5C
/* 800ADE38 3404feb8 */  li       $a0,0xfeb8
.L800ADE3C:
/* 800ADE3C 92a30442 */  lbu      $v1,1090($s5)
/* 800ADE40 24020001 */  li       $v0,1
/* 800ADE44 14620033 */  bne      $v1,$v0,.L800ADF14
/* 800ADE48 3c028011 */  lui      $v0,0x8011
/* 800ADE4C 8c437680 */  lw       $v1,30336($v0)
/* 800ADE50 24027fff */  li       $v0,32767
/* 800ADE54 04610002 */  bgez     $v1,.L800ADE60
/* 800ADE58 00000000 */  nop      
/* 800ADE5C 00031823 */  negu     $v1,$v1
.L800ADE60:
/* 800ADE60 0043102a */  slt      $v0,$v0,$v1
/* 800ADE64 1440002b */  bnez     $v0,.L800ADF14
/* 800ADE68 3c030013 */  lui      $v1,0x13
/* 800ADE6C 8ea20420 */  lw       $v0,1056($s5)
/* 800ADE70 3463ffff */  ori      $v1,$v1,0xffff
/* 800ADE74 04410002 */  bgez     $v0,.L800ADE80
/* 800ADE78 00000000 */  nop      
/* 800ADE7C 00021023 */  negu     $v0,$v0
.L800ADE80:
/* 800ADE80 0062182a */  slt      $v1,$v1,$v0
/* 800ADE84 1060000a */  beqz     $v1,.L800ADEB0
/* 800ADE88 3410fd70 */  li       $s0,0xfd70
/* 800ADE8C 8ea20450 */  lw       $v0,1104($s5)
/* 800ADE90 00000000 */  nop      
/* 800ADE94 04410002 */  bgez     $v0,.L800ADEA0
/* 800ADE98 00000000 */  nop      
/* 800ADE9C 00021023 */  negu     $v0,$v0
.L800ADEA0:
/* 800ADEA0 28420021 */  slti     $v0,$v0,33
/* 800ADEA4 14400002 */  bnez     $v0,.L800ADEB0
/* 800ADEA8 3410ff7c */  li       $s0,0xff7c
/* 800ADEAC 3410fd70 */  li       $s0,0xfd70
.L800ADEB0:
/* 800ADEB0 8ea500ac */  lw       $a1,172($s5)
/* 800ADEB4 0c039340 */  jal      func_800E4D00
/* 800ADEB8 02002021 */  move     $a0,$s0
/* 800ADEBC 8ea500b0 */  lw       $a1,176($s5)
/* 800ADEC0 02002021 */  move     $a0,$s0
/* 800ADEC4 0c039340 */  jal      func_800E4D00
/* 800ADEC8 aea200ac */  sw       $v0,172($s5)
/* 800ADECC 8ea500b4 */  lw       $a1,180($s5)
/* 800ADED0 02002021 */  move     $a0,$s0
/* 800ADED4 0c039340 */  jal      func_800E4D00
/* 800ADED8 aea200b0 */  sw       $v0,176($s5)
/* 800ADEDC 8ea50114 */  lw       $a1,276($s5)
/* 800ADEE0 02002021 */  move     $a0,$s0
/* 800ADEE4 0c039340 */  jal      func_800E4D00
/* 800ADEE8 aea200b4 */  sw       $v0,180($s5)
/* 800ADEEC 8ea50118 */  lw       $a1,280($s5)
/* 800ADEF0 02002021 */  move     $a0,$s0
/* 800ADEF4 0c039340 */  jal      func_800E4D00
/* 800ADEF8 aea20114 */  sw       $v0,276($s5)
/* 800ADEFC 8ea5011c */  lw       $a1,284($s5)
/* 800ADF00 02002021 */  move     $a0,$s0
/* 800ADF04 0c039340 */  jal      func_800E4D00
/* 800ADF08 aea20118 */  sw       $v0,280($s5)
/* 800ADF0C 0802b7da */  j        .L800ADF68
/* 800ADF10 aea2011c */  sw       $v0,284($s5)
.L800ADF14:
/* 800ADF14 92a20445 */  lbu      $v0,1093($s5)
/* 800ADF18 00000000 */  nop      
/* 800ADF1C 10400012 */  beqz     $v0,.L800ADF68
/* 800ADF20 3402ffff */  li       $v0,0xffff
/* 800ADF24 8ea300c0 */  lw       $v1,192($s5)
/* 800ADF28 00000000 */  nop      
/* 800ADF2C 0043102a */  slt      $v0,$v0,$v1
/* 800ADF30 1440000d */  bnez     $v0,.L800ADF68
/* 800ADF34 00000000 */  nop      
/* 800ADF38 8ea500ac */  lw       $a1,172($s5)
/* 800ADF3C 0c039340 */  jal      func_800E4D00
/* 800ADF40 34048000 */  li       $a0,0x8000
/* 800ADF44 8ea500b0 */  lw       $a1,176($s5)
/* 800ADF48 34048000 */  li       $a0,0x8000
/* 800ADF4C 0c039340 */  jal      func_800E4D00
/* 800ADF50 aea200ac */  sw       $v0,172($s5)
/* 800ADF54 8ea500b4 */  lw       $a1,180($s5)
/* 800ADF58 34048000 */  li       $a0,0x8000
.L800ADF5C:
/* 800ADF5C 0c039340 */  jal      func_800E4D00
/* 800ADF60 aea200b0 */  sw       $v0,176($s5)
/* 800ADF64 aea200b4 */  sw       $v0,180($s5)
.L800ADF68:
/* 800ADF68 8fbf0114 */  lw       $ra,276($sp)
/* 800ADF6C 8fb60110 */  lw       $s6,272($sp)
/* 800ADF70 8fb5010c */  lw       $s5,268($sp)
/* 800ADF74 8fb40108 */  lw       $s4,264($sp)
/* 800ADF78 8fb30104 */  lw       $s3,260($sp)
/* 800ADF7C 8fb20100 */  lw       $s2,256($sp)
/* 800ADF80 8fb100fc */  lw       $s1,252($sp)
/* 800ADF84 8fb000f8 */  lw       $s0,248($sp)
/* 800ADF88 03e00008 */  jr       $ra
/* 800ADF8C 27bd0118 */  addiu    $sp,$sp,280
