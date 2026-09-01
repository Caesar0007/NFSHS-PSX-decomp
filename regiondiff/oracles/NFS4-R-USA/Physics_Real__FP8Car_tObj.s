.set noat
.set noreorder

glabel func_800ACDF8
/* 800ACDF8 27bdfee8 */  addiu    $sp,$sp,-280
/* 800ACDFC afb5010c */  sw       $s5,268($sp)
/* 800ACE00 0080a821 */  move     $s5,$a0
/* 800ACE04 3c028011 */  lui      $v0,0x8011
/* 800ACE08 afbf0114 */  sw       $ra,276($sp)
/* 800ACE0C afb60110 */  sw       $s6,272($sp)
/* 800ACE10 afb40108 */  sw       $s4,264($sp)
/* 800ACE14 afb30104 */  sw       $s3,260($sp)
/* 800ACE18 afb20100 */  sw       $s2,256($sp)
/* 800ACE1C afb100fc */  sw       $s1,252($sp)
/* 800ACE20 afb000f8 */  sw       $s0,248($sp)
/* 800ACE24 aea0040c */  sw       $zero,1036($s5)
/* 800ACE28 aea00410 */  sw       $zero,1040($s5)
/* 800ACE2C aea00414 */  sw       $zero,1044($s5)
/* 800ACE30 8c4244ec */  lw       $v0,17644($v0)
/* 800ACE34 8eb60464 */  lw       $s6,1124($s5)
/* 800ACE38 24100001 */  li       $s0,1
/* 800ACE3C af900dc4 */  sw       $s0,3524($gp)
/* 800ACE40 af900dc8 */  sw       $s0,3528($gp)
/* 800ACE44 10400009 */  beqz     $v0,.L800ACE6C
/* 800ACE48 00000000 */  nop      
/* 800ACE4C 0c02027e */  jal      func_800809F8
/* 800ACE50 26a40008 */  addiu    $a0,$s5,8
/* 800ACE54 00501026 */  xor      $v0,$v0,$s0
/* 800ACE58 10400004 */  beqz     $v0,.L800ACE6C
/* 800ACE5C 00000000 */  nop      
/* 800ACE60 af900dc0 */  sw       $s0,3520($gp)
/* 800ACE64 0802b39c */  j        .L800ACE70
/* 800ACE68 00000000 */  nop      
.L800ACE6C:
/* 800ACE6C af800dc0 */  sw       $zero,3520($gp)
.L800ACE70:
/* 800ACE70 8ea202ac */  lw       $v0,684($s5)
/* 800ACE74 00000000 */  nop      
/* 800ACE78 1040000b */  beqz     $v0,.L800ACEA8
/* 800ACE7C 00000000 */  nop      
/* 800ACE80 8ea202dc */  lw       $v0,732($s5)
/* 800ACE84 00000000 */  nop      
/* 800ACE88 10400007 */  beqz     $v0,.L800ACEA8
/* 800ACE8C 00000000 */  nop      
/* 800ACE90 8ea20188 */  lw       $v0,392($s5)
/* 800ACE94 00000000 */  nop      
/* 800ACE98 28420ccd */  slti     $v0,$v0,3277
/* 800ACE9C 14400002 */  bnez     $v0,.L800ACEA8
/* 800ACEA0 00000000 */  nop      
/* 800ACEA4 af800dc4 */  sw       $zero,3524($gp)
.L800ACEA8:
/* 800ACEA8 8ea2030c */  lw       $v0,780($s5)
/* 800ACEAC 00000000 */  nop      
/* 800ACEB0 1040000b */  beqz     $v0,.L800ACEE0
/* 800ACEB4 00000000 */  nop      
/* 800ACEB8 8ea2033c */  lw       $v0,828($s5)
/* 800ACEBC 00000000 */  nop      
/* 800ACEC0 10400007 */  beqz     $v0,.L800ACEE0
/* 800ACEC4 00000000 */  nop      
/* 800ACEC8 8ea20188 */  lw       $v0,392($s5)
/* 800ACECC 00000000 */  nop      
/* 800ACED0 28420ccd */  slti     $v0,$v0,3277
/* 800ACED4 14400002 */  bnez     $v0,.L800ACEE0
/* 800ACED8 00000000 */  nop      
/* 800ACEDC af800dc8 */  sw       $zero,3528($gp)
.L800ACEE0:
/* 800ACEE0 8ea400ac */  lw       $a0,172($s5)
/* 800ACEE4 8ea501c4 */  lw       $a1,452($s5)
/* 800ACEE8 0c0393c5 */  jal      func_800E4F14
/* 800ACEEC 00000000 */  nop      
/* 800ACEF0 8ea400b0 */  lw       $a0,176($s5)
/* 800ACEF4 8ea501c8 */  lw       $a1,456($s5)
/* 800ACEF8 0c0393c5 */  jal      func_800E4F14
/* 800ACEFC 00408021 */  move     $s0,$v0
/* 800ACF00 8ea400b4 */  lw       $a0,180($s5)
/* 800ACF04 8ea501cc */  lw       $a1,460($s5)
/* 800ACF08 0c0393c5 */  jal      func_800E4F14
/* 800ACF0C 00408821 */  move     $s1,$v0
/* 800ACF10 02118021 */  addu     $s0,$s0,$s1
/* 800ACF14 8ea400ac */  lw       $a0,172($s5)
/* 800ACF18 8ea501d0 */  lw       $a1,464($s5)
/* 800ACF1C 02028021 */  addu     $s0,$s0,$v0
/* 800ACF20 0c0393c5 */  jal      func_800E4F14
/* 800ACF24 aeb00418 */  sw       $s0,1048($s5)
/* 800ACF28 8ea400b0 */  lw       $a0,176($s5)
/* 800ACF2C 8ea501d4 */  lw       $a1,468($s5)
/* 800ACF30 0c0393c5 */  jal      func_800E4F14
/* 800ACF34 00408021 */  move     $s0,$v0
/* 800ACF38 8ea400b4 */  lw       $a0,180($s5)
/* 800ACF3C 8ea501d8 */  lw       $a1,472($s5)
/* 800ACF40 0c0393c5 */  jal      func_800E4F14
/* 800ACF44 00408821 */  move     $s1,$v0
/* 800ACF48 02118021 */  addu     $s0,$s0,$s1
/* 800ACF4C 8ea400ac */  lw       $a0,172($s5)
/* 800ACF50 8ea501dc */  lw       $a1,476($s5)
/* 800ACF54 02028021 */  addu     $s0,$s0,$v0
/* 800ACF58 0c0393c5 */  jal      func_800E4F14
/* 800ACF5C aeb0041c */  sw       $s0,1052($s5)
/* 800ACF60 8ea400b0 */  lw       $a0,176($s5)
/* 800ACF64 8ea501e0 */  lw       $a1,480($s5)
/* 800ACF68 0c0393c5 */  jal      func_800E4F14
/* 800ACF6C 00408021 */  move     $s0,$v0
/* 800ACF70 8ea400b4 */  lw       $a0,180($s5)
/* 800ACF74 8ea501e4 */  lw       $a1,484($s5)
/* 800ACF78 0c0393c5 */  jal      func_800E4F14
/* 800ACF7C 00408821 */  move     $s1,$v0
/* 800ACF80 02118021 */  addu     $s0,$s0,$s1
/* 800ACF84 8ea40114 */  lw       $a0,276($s5)
/* 800ACF88 8ea501c4 */  lw       $a1,452($s5)
/* 800ACF8C 02028021 */  addu     $s0,$s0,$v0
/* 800ACF90 0c0393c5 */  jal      func_800E4F14
/* 800ACF94 aeb00420 */  sw       $s0,1056($s5)
/* 800ACF98 8ea40118 */  lw       $a0,280($s5)
/* 800ACF9C 8ea501c8 */  lw       $a1,456($s5)
/* 800ACFA0 0c0393c5 */  jal      func_800E4F14
/* 800ACFA4 00408021 */  move     $s0,$v0
/* 800ACFA8 8ea4011c */  lw       $a0,284($s5)
/* 800ACFAC 8ea501cc */  lw       $a1,460($s5)
/* 800ACFB0 0c0393c5 */  jal      func_800E4F14
/* 800ACFB4 00408821 */  move     $s1,$v0
/* 800ACFB8 02118021 */  addu     $s0,$s0,$s1
/* 800ACFBC 8ea40114 */  lw       $a0,276($s5)
/* 800ACFC0 8ea501d0 */  lw       $a1,464($s5)
/* 800ACFC4 02028021 */  addu     $s0,$s0,$v0
/* 800ACFC8 0c0393c5 */  jal      func_800E4F14
/* 800ACFCC aeb00424 */  sw       $s0,1060($s5)
/* 800ACFD0 8ea40118 */  lw       $a0,280($s5)
/* 800ACFD4 8ea501d4 */  lw       $a1,468($s5)
/* 800ACFD8 0c0393c5 */  jal      func_800E4F14
/* 800ACFDC 00408021 */  move     $s0,$v0
/* 800ACFE0 8ea4011c */  lw       $a0,284($s5)
/* 800ACFE4 8ea501d8 */  lw       $a1,472($s5)
/* 800ACFE8 0c0393c5 */  jal      func_800E4F14
/* 800ACFEC 00408821 */  move     $s1,$v0
/* 800ACFF0 02118021 */  addu     $s0,$s0,$s1
/* 800ACFF4 8ea40114 */  lw       $a0,276($s5)
/* 800ACFF8 8ea501dc */  lw       $a1,476($s5)
/* 800ACFFC 02028021 */  addu     $s0,$s0,$v0
/* 800AD000 0c0393c5 */  jal      func_800E4F14
/* 800AD004 aeb00428 */  sw       $s0,1064($s5)
/* 800AD008 8ea40118 */  lw       $a0,280($s5)
/* 800AD00C 8ea501e0 */  lw       $a1,480($s5)
/* 800AD010 0c0393c5 */  jal      func_800E4F14
/* 800AD014 00408021 */  move     $s0,$v0
/* 800AD018 8ea4011c */  lw       $a0,284($s5)
/* 800AD01C 8ea501e4 */  lw       $a1,484($s5)
/* 800AD020 0c0393c5 */  jal      func_800E4F14
/* 800AD024 00408821 */  move     $s1,$v0
/* 800AD028 02118021 */  addu     $s0,$s0,$s1
/* 800AD02C 02028021 */  addu     $s0,$s0,$v0
/* 800AD030 8ea50420 */  lw       $a1,1056($s5)
/* 800AD034 3c020005 */  lui      $v0,0x5
/* 800AD038 0045102a */  slt      $v0,$v0,$a1
/* 800AD03C 10400006 */  beqz     $v0,.L800AD058
/* 800AD040 aeb0042c */  sw       $s0,1068($s5)
/* 800AD044 8ea40418 */  lw       $a0,1048($s5)
/* 800AD048 0c0393fc */  jal      func_800E4FF0
/* 800AD04C 00000000 */  nop      
/* 800AD050 0802b417 */  j        .L800AD05C
/* 800AD054 aea20478 */  sw       $v0,1144($s5)
.L800AD058:
/* 800AD058 aea00478 */  sw       $zero,1144($s5)
.L800AD05C:
/* 800AD05C 8ea20418 */  lw       $v0,1048($s5)
/* 800AD060 00000000 */  nop      
/* 800AD064 00021140 */  sll      $v0,$v0,0x5
/* 800AD068 00021023 */  negu     $v0,$v0
/* 800AD06C 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD070 00431021 */  addu     $v0,$v0,$v1
/* 800AD074 00021043 */  sra      $v0,$v0,0x1
/* 800AD078 afa20090 */  sw       $v0,144($sp)
/* 800AD07C 8ea2041c */  lw       $v0,1052($s5)
/* 800AD080 00000000 */  nop      
/* 800AD084 00021140 */  sll      $v0,$v0,0x5
/* 800AD088 00021023 */  negu     $v0,$v0
/* 800AD08C 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD090 00431021 */  addu     $v0,$v0,$v1
/* 800AD094 00021043 */  sra      $v0,$v0,0x1
/* 800AD098 afa20094 */  sw       $v0,148($sp)
/* 800AD09C 8ea20420 */  lw       $v0,1056($s5)
/* 800AD0A0 00000000 */  nop      
/* 800AD0A4 00021140 */  sll      $v0,$v0,0x5
/* 800AD0A8 00021023 */  negu     $v0,$v0
/* 800AD0AC 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD0B0 00431021 */  addu     $v0,$v0,$v1
/* 800AD0B4 00021043 */  sra      $v0,$v0,0x1
/* 800AD0B8 afa20098 */  sw       $v0,152($sp)
/* 800AD0BC 8ea40118 */  lw       $a0,280($s5)
/* 800AD0C0 8ec501c4 */  lw       $a1,452($s6)
/* 800AD0C4 0c0393c5 */  jal      func_800E4F14
/* 800AD0C8 00042140 */  sll      $a0,$a0,0x5
/* 800AD0CC 00002021 */  move     $a0,$zero
/* 800AD0D0 3c03fff6 */  lui      $v1,0xfff6
/* 800AD0D4 00029023 */  negu     $s2,$v0
/* 800AD0D8 001217c2 */  srl      $v0,$s2,0x1f
/* 800AD0DC 02429021 */  addu     $s2,$s2,$v0
/* 800AD0E0 afa00070 */  sw       $zero,112($sp)
/* 800AD0E4 afa30074 */  sw       $v1,116($sp)
/* 800AD0E8 afa00078 */  sw       $zero,120($sp)
/* 800AD0EC 8ea501c4 */  lw       $a1,452($s5)
/* 800AD0F0 0c0393c5 */  jal      func_800E4F14
/* 800AD0F4 00129043 */  sra      $s2,$s2,0x1
/* 800AD0F8 8fa40074 */  lw       $a0,116($sp)
/* 800AD0FC 8ea501c8 */  lw       $a1,456($s5)
/* 800AD100 0c0393c5 */  jal      func_800E4F14
/* 800AD104 00408021 */  move     $s0,$v0
/* 800AD108 8fa40078 */  lw       $a0,120($sp)
/* 800AD10C 8ea501cc */  lw       $a1,460($s5)
/* 800AD110 0c0393c5 */  jal      func_800E4F14
/* 800AD114 00408821 */  move     $s1,$v0
/* 800AD118 3c138011 */  lui      $s3,0x8011
/* 800AD11C 02118021 */  addu     $s0,$s0,$s1
/* 800AD120 8fa40070 */  lw       $a0,112($sp)
/* 800AD124 02028021 */  addu     $s0,$s0,$v0
/* 800AD128 ae70788c */  sw       $s0,30860($s3)
/* 800AD12C 8ea501d0 */  lw       $a1,464($s5)
/* 800AD130 0c0393c5 */  jal      func_800E4F14
/* 800AD134 2674788c */  addiu    $s4,$s3,30860
/* 800AD138 8fa40074 */  lw       $a0,116($sp)
/* 800AD13C 8ea501d4 */  lw       $a1,468($s5)
/* 800AD140 0c0393c5 */  jal      func_800E4F14
/* 800AD144 00408021 */  move     $s0,$v0
/* 800AD148 8fa40078 */  lw       $a0,120($sp)
/* 800AD14C 8ea501d8 */  lw       $a1,472($s5)
/* 800AD150 0c0393c5 */  jal      func_800E4F14
/* 800AD154 00408821 */  move     $s1,$v0
/* 800AD158 02118021 */  addu     $s0,$s0,$s1
/* 800AD15C 8fa40070 */  lw       $a0,112($sp)
/* 800AD160 02028021 */  addu     $s0,$s0,$v0
/* 800AD164 ae900004 */  sw       $s0,4($s4)
/* 800AD168 8ea501dc */  lw       $a1,476($s5)
/* 800AD16C 0c0393c5 */  jal      func_800E4F14
/* 800AD170 00000000 */  nop      
/* 800AD174 8fa40074 */  lw       $a0,116($sp)
/* 800AD178 8ea501e0 */  lw       $a1,480($s5)
/* 800AD17C 0c0393c5 */  jal      func_800E4F14
/* 800AD180 00408021 */  move     $s0,$v0
/* 800AD184 8fa40078 */  lw       $a0,120($sp)
/* 800AD188 8ea501e4 */  lw       $a1,484($s5)
/* 800AD18C 0c0393c5 */  jal      func_800E4F14
/* 800AD190 00408821 */  move     $s1,$v0
/* 800AD194 02a02021 */  move     $a0,$s5
/* 800AD198 02118021 */  addu     $s0,$s0,$s1
/* 800AD19C 02028021 */  addu     $s0,$s0,$v0
/* 800AD1A0 ae900008 */  sw       $s0,8($s4)
/* 800AD1A4 8fa30090 */  lw       $v1,144($sp)
/* 800AD1A8 8fa50094 */  lw       $a1,148($sp)
/* 800AD1AC 8fa60098 */  lw       $a2,152($sp)
/* 800AD1B0 00721021 */  addu     $v0,$v1,$s2
/* 800AD1B4 00721823 */  subu     $v1,$v1,$s2
/* 800AD1B8 afa20020 */  sw       $v0,32($sp)
/* 800AD1BC afa50024 */  sw       $a1,36($sp)
/* 800AD1C0 afa60028 */  sw       $a2,40($sp)
/* 800AD1C4 afa30050 */  sw       $v1,80($sp)
/* 800AD1C8 afa50054 */  sw       $a1,84($sp)
/* 800AD1CC 0c02aa68 */  jal      func_800AA9A0
/* 800AD1D0 afa60058 */  sw       $a2,88($sp)
/* 800AD1D4 8e63788c */  lw       $v1,30860($s3)
/* 800AD1D8 00000000 */  nop      
/* 800AD1DC 04610002 */  bgez     $v1,.L800AD1E8
/* 800AD1E0 00000000 */  nop      
/* 800AD1E4 246300ff */  addiu    $v1,$v1,255
.L800AD1E8:
/* 800AD1E8 00031a03 */  sra      $v1,$v1,0x8
/* 800AD1EC 00031040 */  sll      $v0,$v1,0x1
/* 800AD1F0 00431021 */  addu     $v0,$v0,$v1
/* 800AD1F4 00021a00 */  sll      $v1,$v0,0x8
/* 800AD1F8 04610002 */  bgez     $v1,.L800AD204
/* 800AD1FC 3402ffff */  li       $v0,0xffff
/* 800AD200 00621821 */  addu     $v1,$v1,$v0
.L800AD204:
/* 800AD204 8ea20450 */  lw       $v0,1104($s5)
/* 800AD208 00038403 */  sra      $s0,$v1,0x10
/* 800AD20C 00501821 */  addu     $v1,$v0,$s0
/* 800AD210 28620080 */  slti     $v0,$v1,128
/* 800AD214 14400003 */  bnez     $v0,.L800AD224
/* 800AD218 2862ff81 */  slti     $v0,$v1,-127
/* 800AD21C 0802b48c */  j        .L800AD230
/* 800AD220 2403007f */  li       $v1,127
.L800AD224:
/* 800AD224 10400002 */  beqz     $v0,.L800AD230
/* 800AD228 00000000 */  nop      
/* 800AD22C 2403ff81 */  li       $v1,-127
.L800AD230:
/* 800AD230 8ec2010c */  lw       $v0,268($s6)
/* 800AD234 00000000 */  nop      
/* 800AD238 00620018 */  mult     $v1,$v0
/* 800AD23C 00001012 */  mflo     $v0
/* 800AD240 04410003 */  bgez     $v0,.L800AD250
/* 800AD244 000229c3 */  sra      $a1,$v0,0x7
/* 800AD248 2442007f */  addiu    $v0,$v0,127
/* 800AD24C 000229c3 */  sra      $a1,$v0,0x7
.L800AD250:
/* 800AD250 afa5001c */  sw       $a1,28($sp)
/* 800AD254 8ea20218 */  lw       $v0,536($s5)
/* 800AD258 8ea3021c */  lw       $v1,540($s5)
/* 800AD25C 00000000 */  nop      
/* 800AD260 00431021 */  addu     $v0,$v0,$v1
/* 800AD264 8ea30220 */  lw       $v1,544($s5)
/* 800AD268 8ea4023c */  lw       $a0,572($s5)
/* 800AD26C 00431021 */  addu     $v0,$v0,$v1
/* 800AD270 00441821 */  addu     $v1,$v0,$a0
/* 800AD274 04610002 */  bgez     $v1,.L800AD280
/* 800AD278 00601021 */  move     $v0,$v1
/* 800AD27C 246201ff */  addiu    $v0,$v1,511
.L800AD280:
/* 800AD280 00021a43 */  sra      $v1,$v0,0x9
/* 800AD284 00a02021 */  move     $a0,$a1
/* 800AD288 3c020001 */  lui      $v0,0x1
/* 800AD28C 04810002 */  bgez     $a0,.L800AD298
/* 800AD290 00431023 */  subu     $v0,$v0,$v1
/* 800AD294 248400ff */  addiu    $a0,$a0,255
.L800AD298:
/* 800AD298 04410002 */  bgez     $v0,.L800AD2A4
/* 800AD29C 00041a03 */  sra      $v1,$a0,0x8
/* 800AD2A0 244200ff */  addiu    $v0,$v0,255
.L800AD2A4:
/* 800AD2A4 00021203 */  sra      $v0,$v0,0x8
/* 800AD2A8 00620018 */  mult     $v1,$v0
/* 800AD2AC 00004012 */  mflo     $t0
/* 800AD2B0 afa8001c */  sw       $t0,28($sp)
/* 800AD2B4 8ea40420 */  lw       $a0,1056($s5)
/* 800AD2B8 3c02003c */  lui      $v0,0x3c
/* 800AD2BC 0044102a */  slt      $v0,$v0,$a0
/* 800AD2C0 10400008 */  beqz     $v0,.L800AD2E4
/* 800AD2C4 3c02001a */  lui      $v0,0x1a
/* 800AD2C8 0c0393c5 */  jal      func_800E4F14
/* 800AD2CC 24050444 */  li       $a1,1092
/* 800AD2D0 8fa4001c */  lw       $a0,28($sp)
/* 800AD2D4 0c0393fc */  jal      func_800E4FF0
/* 800AD2D8 00402821 */  move     $a1,$v0
/* 800AD2DC afa2001c */  sw       $v0,28($sp)
/* 800AD2E0 3c02001a */  lui      $v0,0x1a
.L800AD2E4:
/* 800AD2E4 8ea30420 */  lw       $v1,1056($s5)
/* 800AD2E8 3442b333 */  ori      $v0,$v0,0xb333
/* 800AD2EC 0043102a */  slt      $v0,$v0,$v1
/* 800AD2F0 1040000c */  beqz     $v0,.L800AD324
/* 800AD2F4 3c02000d */  lui      $v0,0xd
/* 800AD2F8 8ea30478 */  lw       $v1,1144($s5)
/* 800AD2FC 00000000 */  nop      
/* 800AD300 28620ccd */  slti     $v0,$v1,3277
/* 800AD304 14400014 */  bnez     $v0,.L800AD358
/* 800AD308 2862f334 */  slti     $v0,$v1,-3276
/* 800AD30C 8fa2001c */  lw       $v0,28($sp)
/* 800AD310 00000000 */  nop      
/* 800AD314 1c400016 */  bgtz     $v0,.L800AD370
/* 800AD318 2862f334 */  slti     $v0,$v1,-3276
/* 800AD31C 0802b4d6 */  j        .L800AD358
/* 800AD320 00000000 */  nop      
.L800AD324:
/* 800AD324 34426666 */  ori      $v0,$v0,0x6666
/* 800AD328 0043102a */  slt      $v0,$v0,$v1
/* 800AD32C 10400020 */  beqz     $v0,.L800AD3B0
/* 800AD330 02a02021 */  move     $a0,$s5
/* 800AD334 8ea30478 */  lw       $v1,1144($s5)
/* 800AD338 00000000 */  nop      
/* 800AD33C 28622667 */  slti     $v0,$v1,9831
/* 800AD340 14400005 */  bnez     $v0,.L800AD358
/* 800AD344 2862d99a */  slti     $v0,$v1,-9830
/* 800AD348 8fa2001c */  lw       $v0,28($sp)
/* 800AD34C 00000000 */  nop      
/* 800AD350 1c400007 */  bgtz     $v0,.L800AD370
/* 800AD354 2862d99a */  slti     $v0,$v1,-9830
.L800AD358:
/* 800AD358 10400015 */  beqz     $v0,.L800AD3B0
/* 800AD35C 02a02021 */  move     $a0,$s5
/* 800AD360 8fa2001c */  lw       $v0,28($sp)
/* 800AD364 00000000 */  nop      
/* 800AD368 04410012 */  bgez     $v0,.L800AD3B4
/* 800AD36C 24020001 */  li       $v0,1
.L800AD370:
/* 800AD370 8ea20478 */  lw       $v0,1144($s5)
/* 800AD374 3c050001 */  lui      $a1,0x1
/* 800AD378 04410002 */  bgez     $v0,.L800AD384
/* 800AD37C 00000000 */  nop      
/* 800AD380 00021023 */  negu     $v0,$v0
.L800AD384:
/* 800AD384 00021840 */  sll      $v1,$v0,0x1
/* 800AD388 00a01021 */  move     $v0,$a1
/* 800AD38C 0043102a */  slt      $v0,$v0,$v1
/* 800AD390 14400002 */  bnez     $v0,.L800AD39C
/* 800AD394 00000000 */  nop      
/* 800AD398 00602821 */  move     $a1,$v1
.L800AD39C:
/* 800AD39C 8fa4001c */  lw       $a0,28($sp)
/* 800AD3A0 0c0393c5 */  jal      func_800E4F14
/* 800AD3A4 00000000 */  nop      
/* 800AD3A8 afa2001c */  sw       $v0,28($sp)
/* 800AD3AC 02a02021 */  move     $a0,$s5
.L800AD3B0:
/* 800AD3B0 24020001 */  li       $v0,1
.L800AD3B4:
/* 800AD3B4 afa0004c */  sw       $zero,76($sp)
/* 800AD3B8 afa20038 */  sw       $v0,56($sp)
/* 800AD3BC 0c02ad86 */  jal      func_800AB618
/* 800AD3C0 afa00068 */  sw       $zero,104($sp)
/* 800AD3C4 00402021 */  move     $a0,$v0
/* 800AD3C8 04810002 */  bgez     $a0,.L800AD3D4
/* 800AD3CC 00801821 */  move     $v1,$a0
/* 800AD3D0 248300ff */  addiu    $v1,$a0,255
.L800AD3D4:
/* 800AD3D4 8ec200f8 */  lw       $v0,248($s6)
/* 800AD3D8 00000000 */  nop      
/* 800AD3DC 04410002 */  bgez     $v0,.L800AD3E8
/* 800AD3E0 00031a03 */  sra      $v1,$v1,0x8
/* 800AD3E4 244200ff */  addiu    $v0,$v0,255
.L800AD3E8:
/* 800AD3E8 00021203 */  sra      $v0,$v0,0x8
/* 800AD3EC 00620018 */  mult     $v1,$v0
/* 800AD3F0 8f830dc4 */  lw       $v1,3524($gp)
/* 800AD3F4 00001012 */  mflo     $v0
/* 800AD3F8 afa20010 */  sw       $v0,16($sp)
/* 800AD3FC 00821023 */  subu     $v0,$a0,$v0
/* 800AD400 14600008 */  bnez     $v1,.L800AD424
/* 800AD404 afa20040 */  sw       $v0,64($sp)
/* 800AD408 8f820dc8 */  lw       $v0,3528($gp)
/* 800AD40C 00000000 */  nop      
/* 800AD410 14400004 */  bnez     $v0,.L800AD424
/* 800AD414 00000000 */  nop      
/* 800AD418 aea00484 */  sw       $zero,1156($s5)
/* 800AD41C 0802b86d */  j        .L800AE1B4
/* 800AD420 aea00488 */  sw       $zero,1160($s5)
.L800AD424:
/* 800AD424 8f830d98 */  lw       $v1,3480($gp)
/* 800AD428 00000000 */  nop      
/* 800AD42C 04610002 */  bgez     $v1,.L800AD438
/* 800AD430 aea003ec */  sw       $zero,1004($s5)
/* 800AD434 246300ff */  addiu    $v1,$v1,255
.L800AD438:
/* 800AD438 8ec200fc */  lw       $v0,252($s6)
/* 800AD43C 00000000 */  nop      
/* 800AD440 04410002 */  bgez     $v0,.L800AD44C
/* 800AD444 00032203 */  sra      $a0,$v1,0x8
/* 800AD448 244200ff */  addiu    $v0,$v0,255
.L800AD44C:
/* 800AD44C 00021203 */  sra      $v0,$v0,0x8
/* 800AD450 00820018 */  mult     $a0,$v0
/* 800AD454 8ea20420 */  lw       $v0,1056($s5)
/* 800AD458 00000000 */  nop      
/* 800AD45C 04410002 */  bgez     $v0,.L800AD468
/* 800AD460 00000000 */  nop      
/* 800AD464 00021023 */  negu     $v0,$v0
.L800AD468:
/* 800AD468 00021140 */  sll      $v0,$v0,0x5
/* 800AD46C 00402021 */  move     $a0,$v0
/* 800AD470 00008012 */  mflo     $s0
/* 800AD474 0090102a */  slt      $v0,$a0,$s0
/* 800AD478 14400002 */  bnez     $v0,.L800AD484
/* 800AD47C 00000000 */  nop      
/* 800AD480 02002021 */  move     $a0,$s0
.L800AD484:
/* 800AD484 8ea3023c */  lw       $v1,572($s5)
/* 800AD488 00000000 */  nop      
/* 800AD48C 1060000f */  beqz     $v1,.L800AD4CC
/* 800AD490 00808021 */  move     $s0,$a0
/* 800AD494 04610002 */  bgez     $v1,.L800AD4A0
/* 800AD498 02002021 */  move     $a0,$s0
/* 800AD49C 2463007f */  addiu    $v1,$v1,127
.L800AD4A0:
/* 800AD4A0 000319c3 */  sra      $v1,$v1,0x7
/* 800AD4A4 3c020001 */  lui      $v0,0x1
/* 800AD4A8 06010002 */  bgez     $s0,.L800AD4B4
/* 800AD4AC 00431023 */  subu     $v0,$v0,$v1
/* 800AD4B0 260400ff */  addiu    $a0,$s0,255
.L800AD4B4:
/* 800AD4B4 04410002 */  bgez     $v0,.L800AD4C0
/* 800AD4B8 00042203 */  sra      $a0,$a0,0x8
/* 800AD4BC 244200ff */  addiu    $v0,$v0,255
.L800AD4C0:
/* 800AD4C0 00021203 */  sra      $v0,$v0,0x8
/* 800AD4C4 00820018 */  mult     $a0,$v0
/* 800AD4C8 00008012 */  mflo     $s0
.L800AD4CC:
/* 800AD4CC 8ea20420 */  lw       $v0,1056($s5)
/* 800AD4D0 00000000 */  nop      
/* 800AD4D4 18400002 */  blez     $v0,.L800AD4E0
/* 800AD4D8 00000000 */  nop      
/* 800AD4DC 00108023 */  negu     $s0,$s0
.L800AD4E0:
/* 800AD4E0 8ec50100 */  lw       $a1,256($s6)
/* 800AD4E4 0c0393c5 */  jal      func_800E4F14
/* 800AD4E8 02002021 */  move     $a0,$s0
/* 800AD4EC 8fa30010 */  lw       $v1,16($sp)
/* 800AD4F0 00000000 */  nop      
/* 800AD4F4 00621821 */  addu     $v1,$v1,$v0
/* 800AD4F8 afa30010 */  sw       $v1,16($sp)
/* 800AD4FC 8fa30040 */  lw       $v1,64($sp)
/* 800AD500 02021023 */  subu     $v0,$s0,$v0
/* 800AD504 00621821 */  addu     $v1,$v1,$v0
/* 800AD508 3c028011 */  lui      $v0,0x8011
/* 800AD50C 8c447890 */  lw       $a0,30864($v0)
/* 800AD510 afa30040 */  sw       $v1,64($sp)
/* 800AD514 8ec50114 */  lw       $a1,276($s6)
/* 800AD518 0c0393c5 */  jal      func_800E4F14
/* 800AD51C 00042023 */  negu     $a0,$a0
/* 800AD520 00408821 */  move     $s1,$v0
/* 800AD524 0c02ad27 */  jal      func_800AB49C
/* 800AD528 02a02021 */  move     $a0,$s5
/* 800AD52C 06210002 */  bgez     $s1,.L800AD538
/* 800AD530 02201821 */  move     $v1,$s1
/* 800AD534 262300ff */  addiu    $v1,$s1,255
.L800AD538:
/* 800AD538 8f820dac */  lw       $v0,3500($gp)
/* 800AD53C 00000000 */  nop      
/* 800AD540 04410002 */  bgez     $v0,.L800AD54C
/* 800AD544 00032203 */  sra      $a0,$v1,0x8
/* 800AD548 244200ff */  addiu    $v0,$v0,255
.L800AD54C:
/* 800AD54C 00021203 */  sra      $v0,$v0,0x8
/* 800AD550 00820018 */  mult     $a0,$v0
/* 800AD554 00008812 */  mflo     $s1
/* 800AD558 06200316 */  bltz     $s1,.L800AE1B4
/* 800AD55C 00000000 */  nop      
/* 800AD560 8f820dc0 */  lw       $v0,3520($gp)
/* 800AD564 00000000 */  nop      
/* 800AD568 10400004 */  beqz     $v0,.L800AD57C
/* 800AD56C 02202021 */  move     $a0,$s1
/* 800AD570 8ec50108 */  lw       $a1,264($s6)
/* 800AD574 0802b560 */  j        .L800AD580
/* 800AD578 24a5028f */  addiu    $a1,$a1,655
.L800AD57C:
/* 800AD57C 8ec50108 */  lw       $a1,264($s6)
.L800AD580:
/* 800AD580 0c0393c5 */  jal      func_800E4F14
/* 800AD584 00000000 */  nop      
/* 800AD588 00409021 */  move     $s2,$v0
/* 800AD58C 8ea20228 */  lw       $v0,552($s5)
/* 800AD590 8ea3022c */  lw       $v1,556($s5)
/* 800AD594 00000000 */  nop      
/* 800AD598 00431021 */  addu     $v0,$v0,$v1
/* 800AD59C 8ea30230 */  lw       $v1,560($s5)
/* 800AD5A0 8ea4023c */  lw       $a0,572($s5)
/* 800AD5A4 00431021 */  addu     $v0,$v0,$v1
/* 800AD5A8 00441021 */  addu     $v0,$v0,$a0
/* 800AD5AC 04410003 */  bgez     $v0,.L800AD5BC
/* 800AD5B0 00021a43 */  sra      $v1,$v0,0x9
/* 800AD5B4 244201ff */  addiu    $v0,$v0,511
/* 800AD5B8 00021a43 */  sra      $v1,$v0,0x9
.L800AD5BC:
/* 800AD5BC 3402c000 */  li       $v0,0xc000
/* 800AD5C0 00628021 */  addu     $s0,$v1,$v0
/* 800AD5C4 8ea4047c */  lw       $a0,1148($s5)
/* 800AD5C8 0c0393c5 */  jal      func_800E4F14
/* 800AD5CC 02002821 */  move     $a1,$s0
/* 800AD5D0 00402021 */  move     $a0,$v0
/* 800AD5D4 0481000b */  bgez     $a0,.L800AD604
/* 800AD5D8 aea4047c */  sw       $a0,1148($s5)
/* 800AD5DC 02002821 */  move     $a1,$s0
/* 800AD5E0 248200ff */  addiu    $v0,$a0,255
/* 800AD5E4 04a10002 */  bgez     $a1,.L800AD5F0
/* 800AD5E8 00021a03 */  sra      $v1,$v0,0x8
/* 800AD5EC 24a500ff */  addiu    $a1,$a1,255
.L800AD5F0:
/* 800AD5F0 00051203 */  sra      $v0,$a1,0x8
/* 800AD5F4 00620018 */  mult     $v1,$v0
/* 800AD5F8 00004012 */  mflo     $t0
/* 800AD5FC 0802b589 */  j        .L800AD624
/* 800AD600 aea8047c */  sw       $t0,1148($s5)
.L800AD604:
/* 800AD604 18800007 */  blez     $a0,.L800AD624
/* 800AD608 00041040 */  sll      $v0,$a0,0x1
/* 800AD60C 00441021 */  addu     $v0,$v0,$a0
/* 800AD610 04410002 */  bgez     $v0,.L800AD61C
/* 800AD614 00000000 */  nop      
/* 800AD618 24420003 */  addiu    $v0,$v0,3
.L800AD61C:
/* 800AD61C 00021083 */  sra      $v0,$v0,0x2
/* 800AD620 aea2047c */  sw       $v0,1148($s5)
.L800AD624:
/* 800AD624 8ea2047c */  lw       $v0,1148($s5)
/* 800AD628 8f830db0 */  lw       $v1,3504($gp)
/* 800AD62C 02421023 */  subu     $v0,$s2,$v0
/* 800AD630 04610002 */  bgez     $v1,.L800AD63C
/* 800AD634 afa20014 */  sw       $v0,20($sp)
/* 800AD638 246300ff */  addiu    $v1,$v1,255
.L800AD63C:
/* 800AD63C 04410002 */  bgez     $v0,.L800AD648
/* 800AD640 00031a03 */  sra      $v1,$v1,0x8
/* 800AD644 244200ff */  addiu    $v0,$v0,255
.L800AD648:
/* 800AD648 00021203 */  sra      $v0,$v0,0x8
/* 800AD64C 00620018 */  mult     $v1,$v0
/* 800AD650 02321023 */  subu     $v0,$s1,$s2
/* 800AD654 00004012 */  mflo     $t0
/* 800AD658 afa80014 */  sw       $t0,20($sp)
/* 800AD65C 8ea3047c */  lw       $v1,1148($s5)
/* 800AD660 8f840db4 */  lw       $a0,3508($gp)
/* 800AD664 00431021 */  addu     $v0,$v0,$v1
/* 800AD668 04810002 */  bgez     $a0,.L800AD674
/* 800AD66C afa20044 */  sw       $v0,68($sp)
/* 800AD670 248400ff */  addiu    $a0,$a0,255
.L800AD674:
/* 800AD674 04410002 */  bgez     $v0,.L800AD680
/* 800AD678 00041a03 */  sra      $v1,$a0,0x8
/* 800AD67C 244200ff */  addiu    $v0,$v0,255
.L800AD680:
/* 800AD680 00021203 */  sra      $v0,$v0,0x8
/* 800AD684 00620018 */  mult     $v1,$v0
/* 800AD688 8f820dc4 */  lw       $v0,3524($gp)
/* 800AD68C 00004012 */  mflo     $t0
/* 800AD690 afa80044 */  sw       $t0,68($sp)
/* 800AD694 aea00474 */  sw       $zero,1140($s5)
/* 800AD698 afa0002c */  sw       $zero,44($sp)
/* 800AD69C afa00034 */  sw       $zero,52($sp)
/* 800AD6A0 afa0005c */  sw       $zero,92($sp)
/* 800AD6A4 10400004 */  beqz     $v0,.L800AD6B8
/* 800AD6A8 afa00064 */  sw       $zero,100($sp)
/* 800AD6AC 02a02021 */  move     $a0,$s5
/* 800AD6B0 0c02b1b4 */  jal      func_800AC6D0
/* 800AD6B4 27a50010 */  addiu    $a1,$sp,16
.L800AD6B8:
/* 800AD6B8 8f820dc8 */  lw       $v0,3528($gp)
/* 800AD6BC 00000000 */  nop      
/* 800AD6C0 10400003 */  beqz     $v0,.L800AD6D0
/* 800AD6C4 02a02021 */  move     $a0,$s5
/* 800AD6C8 0c02b1b4 */  jal      func_800AC6D0
/* 800AD6CC 27a50040 */  addiu    $a1,$sp,64
.L800AD6D0:
/* 800AD6D0 8fa20034 */  lw       $v0,52($sp)
/* 800AD6D4 8fa30064 */  lw       $v1,100($sp)
/* 800AD6D8 00000000 */  nop      
/* 800AD6DC 00431021 */  addu     $v0,$v0,$v1
/* 800AD6E0 aea20414 */  sw       $v0,1044($s5)
/* 800AD6E4 8fa2002c */  lw       $v0,44($sp)
/* 800AD6E8 8fa3005c */  lw       $v1,92($sp)
/* 800AD6EC 8ea40414 */  lw       $a0,1044($s5)
/* 800AD6F0 00431021 */  addu     $v0,$v0,$v1
/* 800AD6F4 aea2040c */  sw       $v0,1036($s5)
/* 800AD6F8 8ec501cc */  lw       $a1,460($s6)
/* 800AD6FC 0c0393c5 */  jal      func_800E4F14
/* 800AD700 00000000 */  nop      
/* 800AD704 00401821 */  move     $v1,$v0
/* 800AD708 3c028011 */  lui      $v0,0x8011
/* 800AD70C aea30414 */  sw       $v1,1044($s5)
/* 800AD710 8c4244dc */  lw       $v0,17628($v0)
/* 800AD714 00000000 */  nop      
/* 800AD718 30420080 */  andi     $v0,$v0,0x80
/* 800AD71C 10400008 */  beqz     $v0,.L800AD740
/* 800AD720 00000000 */  nop      
/* 800AD724 18600006 */  blez     $v1,.L800AD740
/* 800AD728 00000000 */  nop      
/* 800AD72C 92a20446 */  lbu      $v0,1094($s5)
/* 800AD730 00000000 */  nop      
/* 800AD734 10400002 */  beqz     $v0,.L800AD740
/* 800AD738 00031080 */  sll      $v0,$v1,0x2
/* 800AD73C aea20414 */  sw       $v0,1044($s5)
.L800AD740:
/* 800AD740 8f820dc0 */  lw       $v0,3520($gp)
/* 800AD744 00000000 */  nop      
/* 800AD748 14400015 */  bnez     $v0,.L800AD7A0
/* 800AD74C 3c028011 */  lui      $v0,0x8011
/* 800AD750 8ea20288 */  lw       $v0,648($s5)
/* 800AD754 00000000 */  nop      
/* 800AD758 8c430038 */  lw       $v1,56($v0)
/* 800AD75C 24020002 */  li       $v0,2
/* 800AD760 14620009 */  bne      $v1,$v0,.L800AD788
/* 800AD764 3c050001 */  lui      $a1,0x1
/* 800AD768 92a20442 */  lbu      $v0,1090($s5)
/* 800AD76C 00000000 */  nop      
/* 800AD770 2c420004 */  sltiu    $v0,$v0,4
/* 800AD774 10400004 */  beqz     $v0,.L800AD788
/* 800AD778 00000000 */  nop      
/* 800AD77C 8ea40414 */  lw       $a0,1044($s5)
/* 800AD780 0802b5e4 */  j        .L800AD790
/* 800AD784 34a52666 */  ori      $a1,$a1,0x2666
.L800AD788:
/* 800AD788 8ea40414 */  lw       $a0,1044($s5)
/* 800AD78C 34a51999 */  ori      $a1,$a1,0x1999
.L800AD790:
/* 800AD790 0c0393c5 */  jal      func_800E4F14
/* 800AD794 00000000 */  nop      
/* 800AD798 aea20414 */  sw       $v0,1044($s5)
/* 800AD79C 3c028011 */  lui      $v0,0x8011
.L800AD7A0:
/* 800AD7A0 aea00410 */  sw       $zero,1040($s5)
/* 800AD7A4 8c447894 */  lw       $a0,30868($v0)
/* 800AD7A8 0c0393c5 */  jal      func_800E4F14
/* 800AD7AC 24051999 */  li       $a1,6553
/* 800AD7B0 8ea4040c */  lw       $a0,1036($s5)
/* 800AD7B4 00000000 */  nop      
/* 800AD7B8 04810002 */  bgez     $a0,.L800AD7C4
/* 800AD7BC 00028023 */  negu     $s0,$v0
/* 800AD7C0 24840007 */  addiu    $a0,$a0,7
.L800AD7C4:
/* 800AD7C4 8ec50124 */  lw       $a1,292($s6)
/* 800AD7C8 0c0393c5 */  jal      func_800E4F14
/* 800AD7CC 000420c3 */  sra      $a0,$a0,0x3
/* 800AD7D0 8ea40414 */  lw       $a0,1044($s5)
/* 800AD7D4 00021023 */  negu     $v0,$v0
/* 800AD7D8 aea20480 */  sw       $v0,1152($s5)
/* 800AD7DC 8ec50124 */  lw       $a1,292($s6)
/* 800AD7E0 0c0393c5 */  jal      func_800E4F14
/* 800AD7E4 00000000 */  nop      
/* 800AD7E8 00501021 */  addu     $v0,$v0,$s0
/* 800AD7EC aea2047c */  sw       $v0,1148($s5)
/* 800AD7F0 8fa2002c */  lw       $v0,44($sp)
/* 800AD7F4 8fa4005c */  lw       $a0,92($sp)
/* 800AD7F8 8ec501c8 */  lw       $a1,456($s6)
/* 800AD7FC 0c0393c5 */  jal      func_800E4F14
/* 800AD800 00442023 */  subu     $a0,$v0,$a0
/* 800AD804 00408021 */  move     $s0,$v0
/* 800AD808 8fa60034 */  lw       $a2,52($sp)
/* 800AD80C 8fa40064 */  lw       $a0,100($sp)
/* 800AD810 8f830db8 */  lw       $v1,3512($gp)
/* 800AD814 8f850dbc */  lw       $a1,3516($gp)
/* 800AD818 00c42021 */  addu     $a0,$a2,$a0
/* 800AD81C 0c0393c5 */  jal      func_800E4F14
/* 800AD820 00652823 */  subu     $a1,$v1,$a1
/* 800AD824 8ec501c8 */  lw       $a1,456($s6)
/* 800AD828 0c0393c5 */  jal      func_800E4F14
/* 800AD82C 00402021 */  move     $a0,$v0
/* 800AD830 00021040 */  sll      $v0,$v0,0x1
/* 800AD834 02028021 */  addu     $s0,$s0,$v0
/* 800AD838 afb00084 */  sw       $s0,132($sp)
/* 800AD83C 8ea20118 */  lw       $v0,280($s5)
/* 800AD840 00000000 */  nop      
/* 800AD844 18400003 */  blez     $v0,.L800AD854
/* 800AD848 00000000 */  nop      
/* 800AD84C 1e000005 */  bgtz     $s0,.L800AD864
/* 800AD850 00000000 */  nop      
.L800AD854:
/* 800AD854 0441002f */  bgez     $v0,.L800AD914
/* 800AD858 00000000 */  nop      
/* 800AD85C 0601002d */  bgez     $s0,.L800AD914
/* 800AD860 00000000 */  nop      
.L800AD864:
/* 800AD864 92a20445 */  lbu      $v0,1093($s5)
/* 800AD868 00000000 */  nop      
/* 800AD86C 1040000c */  beqz     $v0,.L800AD8A0
/* 800AD870 3c028011 */  lui      $v0,0x8011
/* 800AD874 8c4244dc */  lw       $v0,17628($v0)
/* 800AD878 00000000 */  nop      
/* 800AD87C 30420008 */  andi     $v0,$v0,0x8
/* 800AD880 14400007 */  bnez     $v0,.L800AD8A0
/* 800AD884 00000000 */  nop      
/* 800AD888 8fa20084 */  lw       $v0,132($sp)
/* 800AD88C 00000000 */  nop      
/* 800AD890 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD894 00431021 */  addu     $v0,$v0,$v1
/* 800AD898 0802b644 */  j        .L800AD910
/* 800AD89C 00021043 */  sra      $v0,$v0,0x1
.L800AD8A0:
/* 800AD8A0 8ea3044c */  lw       $v1,1100($s5)
/* 800AD8A4 00000000 */  nop      
/* 800AD8A8 04610006 */  bgez     $v1,.L800AD8C4
/* 800AD8AC 00000000 */  nop      
/* 800AD8B0 8ea20118 */  lw       $v0,280($s5)
/* 800AD8B4 00000000 */  nop      
/* 800AD8B8 28423334 */  slti     $v0,$v0,13108
/* 800AD8BC 10400008 */  beqz     $v0,.L800AD8E0
/* 800AD8C0 00000000 */  nop      
.L800AD8C4:
/* 800AD8C4 1860000d */  blez     $v1,.L800AD8FC
/* 800AD8C8 00000000 */  nop      
/* 800AD8CC 8ea20118 */  lw       $v0,280($s5)
/* 800AD8D0 00000000 */  nop      
/* 800AD8D4 2842cccd */  slti     $v0,$v0,-13107
/* 800AD8D8 10400008 */  beqz     $v0,.L800AD8FC
/* 800AD8DC 00000000 */  nop      
.L800AD8E0:
/* 800AD8E0 8ea3046c */  lw       $v1,1132($s5)
/* 800AD8E4 24020001 */  li       $v0,1
/* 800AD8E8 14620004 */  bne      $v1,$v0,.L800AD8FC
/* 800AD8EC 00000000 */  nop      
/* 800AD8F0 8ea20118 */  lw       $v0,280($s5)
/* 800AD8F4 0802b644 */  j        .L800AD910
/* 800AD8F8 00021023 */  negu     $v0,$v0
.L800AD8FC:
/* 800AD8FC 8ea20464 */  lw       $v0,1124($s5)
/* 800AD900 8fa40084 */  lw       $a0,132($sp)
/* 800AD904 8c45012c */  lw       $a1,300($v0)
/* 800AD908 0c0393c5 */  jal      func_800E4F14
/* 800AD90C 00000000 */  nop      
.L800AD910:
/* 800AD910 afa20084 */  sw       $v0,132($sp)
.L800AD914:
/* 800AD914 26a401c4 */  addiu    $a0,$s5,452
/* 800AD918 27a500a0 */  addiu    $a1,$sp,160
/* 800AD91C afa00080 */  sw       $zero,128($sp)
/* 800AD920 0c0393d1 */  jal      func_800E4F44
/* 800AD924 afa00088 */  sw       $zero,136($sp)
/* 800AD928 02a02021 */  move     $a0,$s5
/* 800AD92C 0c0219ea */  jal      func_800867A8
/* 800AD930 00002821 */  move     $a1,$zero
/* 800AD934 8ea4040c */  lw       $a0,1036($s5)
/* 800AD938 8fa500a0 */  lw       $a1,160($sp)
/* 800AD93C 0c0393c5 */  jal      func_800E4F14
/* 800AD940 00000000 */  nop      
/* 800AD944 8ea40410 */  lw       $a0,1040($s5)
/* 800AD948 8fa500a4 */  lw       $a1,164($sp)
/* 800AD94C 0c0393c5 */  jal      func_800E4F14
/* 800AD950 00408021 */  move     $s0,$v0
/* 800AD954 8ea40414 */  lw       $a0,1044($s5)
/* 800AD958 8fa500a8 */  lw       $a1,168($sp)
/* 800AD95C 0c0393c5 */  jal      func_800E4F14
/* 800AD960 00408821 */  move     $s1,$v0
/* 800AD964 02118021 */  addu     $s0,$s0,$s1
/* 800AD968 8ea4040c */  lw       $a0,1036($s5)
/* 800AD96C 02028021 */  addu     $s0,$s0,$v0
/* 800AD970 aeb00400 */  sw       $s0,1024($s5)
/* 800AD974 8fa500ac */  lw       $a1,172($sp)
/* 800AD978 0c0393c5 */  jal      func_800E4F14
/* 800AD97C 00000000 */  nop      
/* 800AD980 8ea40410 */  lw       $a0,1040($s5)
/* 800AD984 8fa500b0 */  lw       $a1,176($sp)
/* 800AD988 0c0393c5 */  jal      func_800E4F14
/* 800AD98C 00408021 */  move     $s0,$v0
/* 800AD990 8ea40414 */  lw       $a0,1044($s5)
/* 800AD994 8fa500b4 */  lw       $a1,180($sp)
/* 800AD998 0c0393c5 */  jal      func_800E4F14
/* 800AD99C 00408821 */  move     $s1,$v0
/* 800AD9A0 02118021 */  addu     $s0,$s0,$s1
/* 800AD9A4 8ea4040c */  lw       $a0,1036($s5)
/* 800AD9A8 02028021 */  addu     $s0,$s0,$v0
/* 800AD9AC aeb00404 */  sw       $s0,1028($s5)
/* 800AD9B0 8fa500b8 */  lw       $a1,184($sp)
/* 800AD9B4 0c0393c5 */  jal      func_800E4F14
/* 800AD9B8 00000000 */  nop      
/* 800AD9BC 8ea40410 */  lw       $a0,1040($s5)
/* 800AD9C0 8fa500bc */  lw       $a1,188($sp)
/* 800AD9C4 0c0393c5 */  jal      func_800E4F14
/* 800AD9C8 00408021 */  move     $s0,$v0
/* 800AD9CC 8ea40414 */  lw       $a0,1044($s5)
/* 800AD9D0 8fa500c0 */  lw       $a1,192($sp)
/* 800AD9D4 0c0393c5 */  jal      func_800E4F14
/* 800AD9D8 00408821 */  move     $s1,$v0
/* 800AD9DC 02118021 */  addu     $s0,$s0,$s1
/* 800AD9E0 02028021 */  addu     $s0,$s0,$v0
/* 800AD9E4 aeb00408 */  sw       $s0,1032($s5)
/* 800AD9E8 8fa40080 */  lw       $a0,128($sp)
/* 800AD9EC 8fa500a0 */  lw       $a1,160($sp)
/* 800AD9F0 0c0393c5 */  jal      func_800E4F14
/* 800AD9F4 00000000 */  nop      
/* 800AD9F8 8fa40084 */  lw       $a0,132($sp)
/* 800AD9FC 8fa500a4 */  lw       $a1,164($sp)
/* 800ADA00 0c0393c5 */  jal      func_800E4F14
/* 800ADA04 00408021 */  move     $s0,$v0
/* 800ADA08 8fa40088 */  lw       $a0,136($sp)
/* 800ADA0C 8fa500a8 */  lw       $a1,168($sp)
/* 800ADA10 0c0393c5 */  jal      func_800E4F14
/* 800ADA14 00408821 */  move     $s1,$v0
/* 800ADA18 02118021 */  addu     $s0,$s0,$s1
/* 800ADA1C 02028021 */  addu     $s0,$s0,$v0
/* 800ADA20 aeb003f4 */  sw       $s0,1012($s5)
/* 800ADA24 8fa40080 */  lw       $a0,128($sp)
/* 800ADA28 8fa500ac */  lw       $a1,172($sp)
/* 800ADA2C 0c0393c5 */  jal      func_800E4F14
/* 800ADA30 00000000 */  nop      
/* 800ADA34 8fa40084 */  lw       $a0,132($sp)
/* 800ADA38 8fa500b0 */  lw       $a1,176($sp)
/* 800ADA3C 0c0393c5 */  jal      func_800E4F14
/* 800ADA40 00408021 */  move     $s0,$v0
/* 800ADA44 8fa40088 */  lw       $a0,136($sp)
/* 800ADA48 8fa500b4 */  lw       $a1,180($sp)
/* 800ADA4C 0c0393c5 */  jal      func_800E4F14
/* 800ADA50 00408821 */  move     $s1,$v0
/* 800ADA54 02118021 */  addu     $s0,$s0,$s1
/* 800ADA58 02028021 */  addu     $s0,$s0,$v0
/* 800ADA5C aeb003f8 */  sw       $s0,1016($s5)
/* 800ADA60 8fa40080 */  lw       $a0,128($sp)
/* 800ADA64 8fa500b8 */  lw       $a1,184($sp)
/* 800ADA68 0c0393c5 */  jal      func_800E4F14
/* 800ADA6C 00000000 */  nop      
/* 800ADA70 8fa40084 */  lw       $a0,132($sp)
/* 800ADA74 8fa500bc */  lw       $a1,188($sp)
/* 800ADA78 0c0393c5 */  jal      func_800E4F14
/* 800ADA7C 00408021 */  move     $s0,$v0
/* 800ADA80 8fa40088 */  lw       $a0,136($sp)
/* 800ADA84 8fa500c0 */  lw       $a1,192($sp)
/* 800ADA88 0c0393c5 */  jal      func_800E4F14
/* 800ADA8C 00408821 */  move     $s1,$v0
/* 800ADA90 02118021 */  addu     $s0,$s0,$s1
/* 800ADA94 8ea30400 */  lw       $v1,1024($s5)
/* 800ADA98 02028021 */  addu     $s0,$s0,$v0
/* 800ADA9C 04610002 */  bgez     $v1,.L800ADAA8
/* 800ADAA0 aeb003fc */  sw       $s0,1020($s5)
/* 800ADAA4 2463001f */  addiu    $v1,$v1,31
.L800ADAA8:
/* 800ADAA8 00031943 */  sra      $v1,$v1,0x5
/* 800ADAAC 8ea200ac */  lw       $v0,172($s5)
/* 800ADAB0 8ea40404 */  lw       $a0,1028($s5)
/* 800ADAB4 00431021 */  addu     $v0,$v0,$v1
/* 800ADAB8 04810002 */  bgez     $a0,.L800ADAC4
/* 800ADABC aea200ac */  sw       $v0,172($s5)
/* 800ADAC0 2484001f */  addiu    $a0,$a0,31
.L800ADAC4:
/* 800ADAC4 00041943 */  sra      $v1,$a0,0x5
/* 800ADAC8 8ea200b0 */  lw       $v0,176($s5)
/* 800ADACC 8ea50408 */  lw       $a1,1032($s5)
/* 800ADAD0 00431021 */  addu     $v0,$v0,$v1
/* 800ADAD4 04a10002 */  bgez     $a1,.L800ADAE0
/* 800ADAD8 aea200b0 */  sw       $v0,176($s5)
/* 800ADADC 24a5001f */  addiu    $a1,$a1,31
.L800ADAE0:
/* 800ADAE0 00051943 */  sra      $v1,$a1,0x5
/* 800ADAE4 8ea200b4 */  lw       $v0,180($s5)
/* 800ADAE8 8ea403f4 */  lw       $a0,1012($s5)
/* 800ADAEC 00431021 */  addu     $v0,$v0,$v1
/* 800ADAF0 04810002 */  bgez     $a0,.L800ADAFC
/* 800ADAF4 aea200b4 */  sw       $v0,180($s5)
/* 800ADAF8 2484001f */  addiu    $a0,$a0,31
.L800ADAFC:
/* 800ADAFC 00041943 */  sra      $v1,$a0,0x5
/* 800ADB00 8ea20114 */  lw       $v0,276($s5)
/* 800ADB04 8ea503f8 */  lw       $a1,1016($s5)
/* 800ADB08 00431021 */  addu     $v0,$v0,$v1
/* 800ADB0C 04a10002 */  bgez     $a1,.L800ADB18
/* 800ADB10 aea20114 */  sw       $v0,276($s5)
/* 800ADB14 24a5003f */  addiu    $a1,$a1,63
.L800ADB18:
/* 800ADB18 00051983 */  sra      $v1,$a1,0x6
/* 800ADB1C 8ea20118 */  lw       $v0,280($s5)
/* 800ADB20 8ea403fc */  lw       $a0,1020($s5)
/* 800ADB24 00431021 */  addu     $v0,$v0,$v1
/* 800ADB28 04810002 */  bgez     $a0,.L800ADB34
/* 800ADB2C aea20118 */  sw       $v0,280($s5)
/* 800ADB30 2484001f */  addiu    $a0,$a0,31
.L800ADB34:
/* 800ADB34 00041143 */  sra      $v0,$a0,0x5
/* 800ADB38 8ea3011c */  lw       $v1,284($s5)
/* 800ADB3C 8ea40460 */  lw       $a0,1120($s5)
/* 800ADB40 00621821 */  addu     $v1,$v1,$v0
/* 800ADB44 10800119 */  beqz     $a0,.L800ADFAC
/* 800ADB48 aea3011c */  sw       $v1,284($s5)
/* 800ADB4C 3c020004 */  lui      $v0,0x4
/* 800ADB50 8ea3055c */  lw       $v1,1372($s5)
/* 800ADB54 344271c6 */  ori      $v0,$v0,0x71c6
/* 800ADB58 0043102a */  slt      $v0,$v0,$v1
/* 800ADB5C 1440000f */  bnez     $v0,.L800ADB9C
/* 800ADB60 00000000 */  nop      
/* 800ADB64 92a20442 */  lbu      $v0,1090($s5)
/* 800ADB68 00000000 */  nop      
/* 800ADB6C 2c420002 */  sltiu    $v0,$v0,2
/* 800ADB70 14400004 */  bnez     $v0,.L800ADB84
/* 800ADB74 00000000 */  nop      
/* 800ADB78 92a20442 */  lbu      $v0,1090($s5)
/* 800ADB7C 0802b6e2 */  j        .L800ADB88
/* 800ADB80 00021080 */  sll      $v0,$v0,0x2
.L800ADB84:
/* 800ADB84 24020008 */  li       $v0,8
.L800ADB88:
/* 800ADB88 3c040018 */  lui      $a0,0x18
/* 800ADB8C 02c21021 */  addu     $v0,$s6,$v0
/* 800ADB90 8c45000c */  lw       $a1,12($v0)
/* 800ADB94 0802b6f3 */  j        .L800ADBCC
/* 800ADB98 34848000 */  ori      $a0,$a0,0x8000
.L800ADB9C:
/* 800ADB9C 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBA0 00000000 */  nop      
/* 800ADBA4 2c420002 */  sltiu    $v0,$v0,2
/* 800ADBA8 14400004 */  bnez     $v0,.L800ADBBC
/* 800ADBAC 00000000 */  nop      
/* 800ADBB0 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBB4 0802b6f0 */  j        .L800ADBC0
/* 800ADBB8 00021080 */  sll      $v0,$v0,0x2
.L800ADBBC:
/* 800ADBBC 24020008 */  li       $v0,8
.L800ADBC0:
/* 800ADBC0 02c21021 */  addu     $v0,$s6,$v0
/* 800ADBC4 8ea4055c */  lw       $a0,1372($s5)
/* 800ADBC8 8c45000c */  lw       $a1,12($v0)
.L800ADBCC:
/* 800ADBCC 0c0393c5 */  jal      func_800E4F14
/* 800ADBD0 00000000 */  nop      
/* 800ADBD4 00401821 */  move     $v1,$v0
/* 800ADBD8 04610002 */  bgez     $v1,.L800ADBE4
/* 800ADBDC 3402ffff */  li       $v0,0xffff
/* 800ADBE0 00621821 */  addu     $v1,$v1,$v0
.L800ADBE4:
/* 800ADBE4 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBE8 00000000 */  nop      
/* 800ADBEC 2c420002 */  sltiu    $v0,$v0,2
/* 800ADBF0 14400004 */  bnez     $v0,.L800ADC04
/* 800ADBF4 00038403 */  sra      $s0,$v1,0x10
/* 800ADBF8 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBFC 0802b702 */  j        .L800ADC08
/* 800ADC00 00021080 */  sll      $v0,$v0,0x2
.L800ADC04:
/* 800ADC04 24020008 */  li       $v0,8
.L800ADC08:
/* 800ADC08 02c21021 */  addu     $v0,$s6,$v0
/* 800ADC0C 8ea40420 */  lw       $a0,1056($s5)
/* 800ADC10 8c45000c */  lw       $a1,12($v0)
/* 800ADC14 0c0393c5 */  jal      func_800E4F14
/* 800ADC18 00000000 */  nop      
/* 800ADC1C 00402821 */  move     $a1,$v0
/* 800ADC20 04a10002 */  bgez     $a1,.L800ADC2C
/* 800ADC24 3402ffff */  li       $v0,0xffff
/* 800ADC28 00a22821 */  addu     $a1,$a1,$v0
.L800ADC2C:
/* 800ADC2C 8ec300f0 */  lw       $v1,240($s6)
/* 800ADC30 00101200 */  sll      $v0,$s0,0x8
/* 800ADC34 0043001a */  div      $zero,$v0,$v1
/* 800ADC38 14600002 */  bnez     $v1,.L800ADC44
/* 800ADC3C 00000000 */  nop      
/* 800ADC40 0007000d */  break    0x7
.L800ADC44:
/* 800ADC44 2401ffff */  li       $at,-1
/* 800ADC48 14610004 */  bne      $v1,$at,.L800ADC5C
/* 800ADC4C 3c018000 */  lui      $at,0x8000
/* 800ADC50 14410002 */  bne      $v0,$at,.L800ADC5C
/* 800ADC54 00000000 */  nop      
/* 800ADC58 0006000d */  break    0x6
.L800ADC5C:
/* 800ADC5C 00002012 */  mflo     $a0
/* 800ADC60 00051403 */  sra      $v0,$a1,0x10
/* 800ADC64 02022823 */  subu     $a1,$s0,$v0
/* 800ADC68 28a200c9 */  slti     $v0,$a1,201
/* 800ADC6C 14400016 */  bnez     $v0,.L800ADCC8
/* 800ADC70 28a200c8 */  slti     $v0,$a1,200
/* 800ADC74 000511c0 */  sll      $v0,$a1,0x7
/* 800ADC78 0050001a */  div      $zero,$v0,$s0
/* 800ADC7C 16000002 */  bnez     $s0,.L800ADC88
/* 800ADC80 00000000 */  nop      
/* 800ADC84 0007000d */  break    0x7
.L800ADC88:
/* 800ADC88 2401ffff */  li       $at,-1
/* 800ADC8C 16010004 */  bne      $s0,$at,.L800ADCA0
/* 800ADC90 3c018000 */  lui      $at,0x8000
/* 800ADC94 14410002 */  bne      $v0,$at,.L800ADCA0
/* 800ADC98 00000000 */  nop      
/* 800ADC9C 0006000d */  break    0x6
.L800ADCA0:
/* 800ADCA0 00001012 */  mflo     $v0
/* 800ADCA4 00000000 */  nop      
/* 800ADCA8 00822021 */  addu     $a0,$a0,$v0
/* 800ADCAC 00801821 */  move     $v1,$a0
/* 800ADCB0 286200e1 */  slti     $v0,$v1,225
/* 800ADCB4 14400002 */  bnez     $v0,.L800ADCC0
/* 800ADCB8 00000000 */  nop      
/* 800ADCBC 240300e0 */  li       $v1,224
.L800ADCC0:
/* 800ADCC0 0802b762 */  j        .L800ADD88
/* 800ADCC4 a2a30458 */  sb       $v1,1112($s5)
.L800ADCC8:
/* 800ADCC8 1040002f */  beqz     $v0,.L800ADD88
/* 800ADCCC 000511c0 */  sll      $v0,$a1,0x7
/* 800ADCD0 0050001a */  div      $zero,$v0,$s0
/* 800ADCD4 16000002 */  bnez     $s0,.L800ADCE0
/* 800ADCD8 00000000 */  nop      
/* 800ADCDC 0007000d */  break    0x7
.L800ADCE0:
/* 800ADCE0 2401ffff */  li       $at,-1
/* 800ADCE4 16010004 */  bne      $s0,$at,.L800ADCF8
/* 800ADCE8 3c018000 */  lui      $at,0x8000
/* 800ADCEC 14410002 */  bne      $v0,$at,.L800ADCF8
/* 800ADCF0 00000000 */  nop      
/* 800ADCF4 0006000d */  break    0x6
.L800ADCF8:
/* 800ADCF8 00001012 */  mflo     $v0
/* 800ADCFC 00000000 */  nop      
/* 800ADD00 00822021 */  addu     $a0,$a0,$v0
/* 800ADD04 04800003 */  bltz     $a0,.L800ADD14
/* 800ADD08 00000000 */  nop      
/* 800ADD0C 0802b746 */  j        .L800ADD18
/* 800ADD10 a2a40458 */  sb       $a0,1112($s5)
.L800ADD14:
/* 800ADD14 a2a00458 */  sb       $zero,1112($s5)
.L800ADD18:
/* 800ADD18 04a1001c */  bgez     $a1,.L800ADD8C
/* 800ADD1C 3c032aaa */  lui      $v1,0x2aaa
/* 800ADD20 00051240 */  sll      $v0,$a1,0x9
/* 800ADD24 8ec300f0 */  lw       $v1,240($s6)
/* 800ADD28 04410002 */  bgez     $v0,.L800ADD34
/* 800ADD2C 00000000 */  nop      
/* 800ADD30 00021023 */  negu     $v0,$v0
.L800ADD34:
/* 800ADD34 0043001a */  div      $zero,$v0,$v1
/* 800ADD38 14600002 */  bnez     $v1,.L800ADD44
/* 800ADD3C 00000000 */  nop      
/* 800ADD40 0007000d */  break    0x7
.L800ADD44:
/* 800ADD44 2401ffff */  li       $at,-1
/* 800ADD48 14610004 */  bne      $v1,$at,.L800ADD5C
/* 800ADD4C 3c018000 */  lui      $at,0x8000
/* 800ADD50 14410002 */  bne      $v0,$at,.L800ADD5C
/* 800ADD54 00000000 */  nop      
/* 800ADD58 0006000d */  break    0x6
.L800ADD5C:
/* 800ADD5C 00001812 */  mflo     $v1
/* 800ADD60 00000000 */  nop      
/* 800ADD64 28620100 */  slti     $v0,$v1,256
/* 800ADD68 14400003 */  bnez     $v0,.L800ADD78
/* 800ADD6C 306200ff */  andi     $v0,$v1,0xff
/* 800ADD70 240300ff */  li       $v1,255
/* 800ADD74 306200ff */  andi     $v0,$v1,0xff
.L800ADD78:
/* 800ADD78 2c420081 */  sltiu    $v0,$v0,129
/* 800ADD7C 14400002 */  bnez     $v0,.L800ADD88
/* 800ADD80 a2a30459 */  sb       $v1,1113($s5)
/* 800ADD84 a2a00458 */  sb       $zero,1112($s5)
.L800ADD88:
/* 800ADD88 3c032aaa */  lui      $v1,0x2aaa
.L800ADD8C:
/* 800ADD8C 8ea20564 */  lw       $v0,1380($s5)
/* 800ADD90 3463aaab */  ori      $v1,$v1,0xaaab
/* 800ADD94 04410002 */  bgez     $v0,.L800ADDA0
/* 800ADD98 00000000 */  nop      
/* 800ADD9C 00021023 */  negu     $v0,$v0
.L800ADDA0:
/* 800ADDA0 00430018 */  mult     $v0,$v1
/* 800ADDA4 000217c3 */  sra      $v0,$v0,0x1f
/* 800ADDA8 00004010 */  mfhi     $t0
/* 800ADDAC 00081c03 */  sra      $v1,$t0,0x10
/* 800ADDB0 00623023 */  subu     $a2,$v1,$v0
/* 800ADDB4 28c20003 */  slti     $v0,$a2,3
/* 800ADDB8 8ea30460 */  lw       $v1,1120($s5)
/* 800ADDBC 14400005 */  bnez     $v0,.L800ADDD4
/* 800ADDC0 00031040 */  sll      $v0,$v1,0x1
/* 800ADDC4 00660018 */  mult     $v1,$a2
/* 800ADDC8 00001812 */  mflo     $v1
/* 800ADDCC 0802b776 */  j        .L800ADDD8
/* 800ADDD0 00000000 */  nop      
.L800ADDD4:
/* 800ADDD4 00431821 */  addu     $v1,$v0,$v1
.L800ADDD8:
/* 800ADDD8 0460000a */  bltz     $v1,.L800ADE04
/* 800ADDDC 00000000 */  nop      
/* 800ADDE0 86a20008 */  lh       $v0,8($s5)
/* 800ADDE4 3c048014 */  lui      $a0,0x8014
/* 800ADDE8 8c84dabc */  lw       $a0,-9540($a0)
/* 800ADDEC 00432821 */  addu     $a1,$v0,$v1
/* 800ADDF0 00a4102a */  slt      $v0,$a1,$a0
/* 800ADDF4 1440000c */  bnez     $v0,.L800ADE28
/* 800ADDF8 00000000 */  nop      
/* 800ADDFC 0802b78a */  j        .L800ADE28
/* 800ADE00 00a42823 */  subu     $a1,$a1,$a0
.L800ADE04:
/* 800ADE04 86a20008 */  lh       $v0,8($s5)
/* 800ADE08 00000000 */  nop      
/* 800ADE0C 00432821 */  addu     $a1,$v0,$v1
/* 800ADE10 04a10005 */  bgez     $a1,.L800ADE28
/* 800ADE14 00000000 */  nop      
/* 800ADE18 3c028014 */  lui      $v0,0x8014
/* 800ADE1C 8c42dabc */  lw       $v0,-9540($v0)
/* 800ADE20 00000000 */  nop      
/* 800ADE24 00a22821 */  addu     $a1,$a1,$v0
.L800ADE28:
/* 800ADE28 00058140 */  sll      $s0,$a1,0x5
/* 800ADE2C 00033040 */  sll      $a2,$v1,0x1
/* 800ADE30 00c33021 */  addu     $a2,$a2,$v1
/* 800ADE34 3c028014 */  lui      $v0,0x8014
/* 800ADE38 8c42dab4 */  lw       $v0,-9548($v0)
/* 800ADE3C 04c10002 */  bgez     $a2,.L800ADE48
/* 800ADE40 00000000 */  nop      
/* 800ADE44 00063023 */  negu     $a2,$a2
.L800ADE48:
/* 800ADE48 8ea800a0 */  lw       $t0,160($s5)
/* 800ADE4C 8ea900a4 */  lw       $t1,164($s5)
/* 800ADE50 8eaa00a8 */  lw       $t2,168($s5)
/* 800ADE54 afa800c8 */  sw       $t0,200($sp)
/* 800ADE58 afa900cc */  sw       $t1,204($sp)
/* 800ADE5C afaa00d0 */  sw       $t2,208($sp)
/* 800ADE60 02021021 */  addu     $v0,$s0,$v0
/* 800ADE64 8c480000 */  lw       $t0,0($v0)
/* 800ADE68 8c490004 */  lw       $t1,4($v0)
/* 800ADE6C 8c4a0008 */  lw       $t2,8($v0)
/* 800ADE70 afa800d8 */  sw       $t0,216($sp)
/* 800ADE74 afa900dc */  sw       $t1,220($sp)
/* 800ADE78 afaa00e0 */  sw       $t2,224($sp)
/* 800ADE7C 0c02b30e */  jal      func_800ACC38
/* 800ADE80 02a02021 */  move     $a0,$s5
/* 800ADE84 3c038014 */  lui      $v1,0x8014
/* 800ADE88 8c63dab4 */  lw       $v1,-9548($v1)
/* 800ADE8C 00408821 */  move     $s1,$v0
/* 800ADE90 02031821 */  addu     $v1,$s0,$v1
/* 800ADE94 80640012 */  lb       $a0,18($v1)
/* 800ADE98 02202821 */  move     $a1,$s1
/* 800ADE9C 0c0393c5 */  jal      func_800E4F14
/* 800ADEA0 00042240 */  sll      $a0,$a0,0x9
/* 800ADEA4 3c038014 */  lui      $v1,0x8014
/* 800ADEA8 8c63dab4 */  lw       $v1,-9548($v1)
/* 800ADEAC afa200e8 */  sw       $v0,232($sp)
/* 800ADEB0 02031821 */  addu     $v1,$s0,$v1
/* 800ADEB4 80640013 */  lb       $a0,19($v1)
/* 800ADEB8 02202821 */  move     $a1,$s1
/* 800ADEBC 0c0393c5 */  jal      func_800E4F14
/* 800ADEC0 00042240 */  sll      $a0,$a0,0x9
/* 800ADEC4 3c038014 */  lui      $v1,0x8014
/* 800ADEC8 8c63dab4 */  lw       $v1,-9548($v1)
/* 800ADECC afa200ec */  sw       $v0,236($sp)
/* 800ADED0 02038021 */  addu     $s0,$s0,$v1
/* 800ADED4 82040014 */  lb       $a0,20($s0)
/* 800ADED8 02202821 */  move     $a1,$s1
/* 800ADEDC 0c0393c5 */  jal      func_800E4F14
/* 800ADEE0 00042240 */  sll      $a0,$a0,0x9
/* 800ADEE4 8fa500d8 */  lw       $a1,216($sp)
/* 800ADEE8 8fa300e8 */  lw       $v1,232($sp)
/* 800ADEEC 8fa600dc */  lw       $a2,220($sp)
/* 800ADEF0 8fa700ec */  lw       $a3,236($sp)
/* 800ADEF4 00a32821 */  addu     $a1,$a1,$v1
/* 800ADEF8 00c73021 */  addu     $a2,$a2,$a3
/* 800ADEFC 8fa300e0 */  lw       $v1,224($sp)
/* 800ADF00 8fa700c8 */  lw       $a3,200($sp)
/* 800ADF04 afa200f0 */  sw       $v0,240($sp)
/* 800ADF08 afa500d8 */  sw       $a1,216($sp)
/* 800ADF0C 00621821 */  addu     $v1,$v1,$v0
/* 800ADF10 8fa200cc */  lw       $v0,204($sp)
/* 800ADF14 00a72823 */  subu     $a1,$a1,$a3
/* 800ADF18 afa500d8 */  sw       $a1,216($sp)
/* 800ADF1C 8fa500d0 */  lw       $a1,208($sp)
/* 800ADF20 27a400d8 */  addiu    $a0,$sp,216
/* 800ADF24 afa600dc */  sw       $a2,220($sp)
/* 800ADF28 afa300e0 */  sw       $v1,224($sp)
/* 800ADF2C 00c23023 */  subu     $a2,$a2,$v0
/* 800ADF30 00651823 */  subu     $v1,$v1,$a1
/* 800ADF34 afa600dc */  sw       $a2,220($sp)
/* 800ADF38 0c027938 */  jal      func_8009E4E0
/* 800ADF3C afa300e0 */  sw       $v1,224($sp)
/* 800ADF40 8fa400d8 */  lw       $a0,216($sp)
/* 800ADF44 8ea500f0 */  lw       $a1,240($s5)
/* 800ADF48 0c0393c5 */  jal      func_800E4F14
/* 800ADF4C 00000000 */  nop      
/* 800ADF50 8fa400dc */  lw       $a0,220($sp)
/* 800ADF54 8ea500f4 */  lw       $a1,244($s5)
/* 800ADF58 0c0393c5 */  jal      func_800E4F14
/* 800ADF5C 00408021 */  move     $s0,$v0
/* 800ADF60 8fa400e0 */  lw       $a0,224($sp)
/* 800ADF64 8ea500f8 */  lw       $a1,248($s5)
/* 800ADF68 0c0393c5 */  jal      func_800E4F14
/* 800ADF6C 00408821 */  move     $s1,$v0
/* 800ADF70 02118021 */  addu     $s0,$s0,$s1
/* 800ADF74 02021021 */  addu     $v0,$s0,$v0
/* 800ADF78 04410003 */  bgez     $v0,.L800ADF88
/* 800ADF7C 00028203 */  sra      $s0,$v0,0x8
/* 800ADF80 244200ff */  addiu    $v0,$v0,255
/* 800ADF84 00028203 */  sra      $s0,$v0,0x8
.L800ADF88:
/* 800ADF88 2a020080 */  slti     $v0,$s0,128
/* 800ADF8C 14400003 */  bnez     $v0,.L800ADF9C
/* 800ADF90 aeb0045c */  sw       $s0,1116($s5)
/* 800ADF94 0802b7ea */  j        .L800ADFA8
/* 800ADF98 2402007f */  li       $v0,127
.L800ADF9C:
/* 800ADF9C 2a02ff81 */  slti     $v0,$s0,-127
/* 800ADFA0 10400002 */  beqz     $v0,.L800ADFAC
/* 800ADFA4 2402ff81 */  li       $v0,-127
.L800ADFA8:
/* 800ADFA8 aea2045c */  sw       $v0,1116($s5)
.L800ADFAC:
/* 800ADFAC 3c028011 */  lui      $v0,0x8011
/* 800ADFB0 8c4244dc */  lw       $v0,17628($v0)
/* 800ADFB4 00000000 */  nop      
/* 800ADFB8 30420008 */  andi     $v0,$v0,0x8
/* 800ADFBC 1440001f */  bnez     $v0,.L800AE03C
/* 800ADFC0 00000000 */  nop      
/* 800ADFC4 92a2043f */  lbu      $v0,1087($s5)
/* 800ADFC8 00000000 */  nop      
/* 800ADFCC 10400009 */  beqz     $v0,.L800ADFF4
/* 800ADFD0 00000000 */  nop      
/* 800ADFD4 8ea20478 */  lw       $v0,1144($s5)
/* 800ADFD8 00000000 */  nop      
/* 800ADFDC 04410002 */  bgez     $v0,.L800ADFE8
/* 800ADFE0 00000000 */  nop      
/* 800ADFE4 00021023 */  negu     $v0,$v0
.L800ADFE8:
/* 800ADFE8 2842199a */  slti     $v0,$v0,6554
/* 800ADFEC 14400013 */  bnez     $v0,.L800AE03C
/* 800ADFF0 00000000 */  nop      
.L800ADFF4:
/* 800ADFF4 8ea20464 */  lw       $v0,1124($s5)
/* 800ADFF8 8ea500ac */  lw       $a1,172($s5)
/* 800ADFFC 8c440158 */  lw       $a0,344($v0)
/* 800AE000 0c0393c5 */  jal      func_800E4F14
/* 800AE004 00000000 */  nop      
/* 800AE008 8ea500b0 */  lw       $a1,176($s5)
/* 800AE00C 8ea30464 */  lw       $v1,1124($s5)
/* 800AE010 aea200ac */  sw       $v0,172($s5)
/* 800AE014 8c640158 */  lw       $a0,344($v1)
/* 800AE018 0c0393c5 */  jal      func_800E4F14
/* 800AE01C 00000000 */  nop      
/* 800AE020 8ea500b4 */  lw       $a1,180($s5)
/* 800AE024 8ea30464 */  lw       $v1,1124($s5)
/* 800AE028 aea200b0 */  sw       $v0,176($s5)
/* 800AE02C 8c640158 */  lw       $a0,344($v1)
/* 800AE030 0c0393c5 */  jal      func_800E4F14
/* 800AE034 00000000 */  nop      
/* 800AE038 aea200b4 */  sw       $v0,180($s5)
.L800AE03C:
/* 800AE03C 8ea301c0 */  lw       $v1,448($s5)
/* 800AE040 24020003 */  li       $v0,3
/* 800AE044 14620010 */  bne      $v1,$v0,.L800AE088
/* 800AE048 3c02002c */  lui      $v0,0x2c
/* 800AE04C 8ea300c0 */  lw       $v1,192($s5)
/* 800AE050 3442a3d7 */  ori      $v0,$v0,0xa3d7
/* 800AE054 0043102a */  slt      $v0,$v0,$v1
/* 800AE058 1040000b */  beqz     $v0,.L800AE088
/* 800AE05C 00000000 */  nop      
/* 800AE060 8ea500ac */  lw       $a1,172($s5)
/* 800AE064 0c0393c5 */  jal      func_800E4F14
/* 800AE068 3404feb8 */  li       $a0,0xfeb8
/* 800AE06C 8ea500b0 */  lw       $a1,176($s5)
/* 800AE070 3404feb8 */  li       $a0,0xfeb8
/* 800AE074 0c0393c5 */  jal      func_800E4F14
/* 800AE078 aea200ac */  sw       $v0,172($s5)
/* 800AE07C 8ea500b4 */  lw       $a1,180($s5)
/* 800AE080 0802b86a */  j        .L800AE1A8
/* 800AE084 3404feb8 */  li       $a0,0xfeb8
.L800AE088:
/* 800AE088 92a30442 */  lbu      $v1,1090($s5)
/* 800AE08C 24020001 */  li       $v0,1
/* 800AE090 14620033 */  bne      $v1,$v0,.L800AE160
/* 800AE094 3c028011 */  lui      $v0,0x8011
/* 800AE098 8c437894 */  lw       $v1,30868($v0)
/* 800AE09C 24027fff */  li       $v0,32767
/* 800AE0A0 04610002 */  bgez     $v1,.L800AE0AC
/* 800AE0A4 00000000 */  nop      
/* 800AE0A8 00031823 */  negu     $v1,$v1
.L800AE0AC:
/* 800AE0AC 0043102a */  slt      $v0,$v0,$v1
/* 800AE0B0 1440002b */  bnez     $v0,.L800AE160
/* 800AE0B4 3c030013 */  lui      $v1,0x13
/* 800AE0B8 8ea20420 */  lw       $v0,1056($s5)
/* 800AE0BC 3463ffff */  ori      $v1,$v1,0xffff
/* 800AE0C0 04410002 */  bgez     $v0,.L800AE0CC
/* 800AE0C4 00000000 */  nop      
/* 800AE0C8 00021023 */  negu     $v0,$v0
.L800AE0CC:
/* 800AE0CC 0062182a */  slt      $v1,$v1,$v0
/* 800AE0D0 1060000a */  beqz     $v1,.L800AE0FC
/* 800AE0D4 3410fd70 */  li       $s0,0xfd70
/* 800AE0D8 8ea20450 */  lw       $v0,1104($s5)
/* 800AE0DC 00000000 */  nop      
/* 800AE0E0 04410002 */  bgez     $v0,.L800AE0EC
/* 800AE0E4 00000000 */  nop      
/* 800AE0E8 00021023 */  negu     $v0,$v0
.L800AE0EC:
/* 800AE0EC 28420021 */  slti     $v0,$v0,33
/* 800AE0F0 14400002 */  bnez     $v0,.L800AE0FC
/* 800AE0F4 3410ff7c */  li       $s0,0xff7c
/* 800AE0F8 3410fd70 */  li       $s0,0xfd70
.L800AE0FC:
/* 800AE0FC 8ea500ac */  lw       $a1,172($s5)
/* 800AE100 0c0393c5 */  jal      func_800E4F14
/* 800AE104 02002021 */  move     $a0,$s0
/* 800AE108 8ea500b0 */  lw       $a1,176($s5)
/* 800AE10C 02002021 */  move     $a0,$s0
/* 800AE110 0c0393c5 */  jal      func_800E4F14
/* 800AE114 aea200ac */  sw       $v0,172($s5)
/* 800AE118 8ea500b4 */  lw       $a1,180($s5)
/* 800AE11C 02002021 */  move     $a0,$s0
/* 800AE120 0c0393c5 */  jal      func_800E4F14
/* 800AE124 aea200b0 */  sw       $v0,176($s5)
/* 800AE128 8ea50114 */  lw       $a1,276($s5)
/* 800AE12C 02002021 */  move     $a0,$s0
/* 800AE130 0c0393c5 */  jal      func_800E4F14
/* 800AE134 aea200b4 */  sw       $v0,180($s5)
/* 800AE138 8ea50118 */  lw       $a1,280($s5)
/* 800AE13C 02002021 */  move     $a0,$s0
/* 800AE140 0c0393c5 */  jal      func_800E4F14
/* 800AE144 aea20114 */  sw       $v0,276($s5)
/* 800AE148 8ea5011c */  lw       $a1,284($s5)
/* 800AE14C 02002021 */  move     $a0,$s0
/* 800AE150 0c0393c5 */  jal      func_800E4F14
/* 800AE154 aea20118 */  sw       $v0,280($s5)
/* 800AE158 0802b86d */  j        .L800AE1B4
/* 800AE15C aea2011c */  sw       $v0,284($s5)
.L800AE160:
/* 800AE160 92a20445 */  lbu      $v0,1093($s5)
/* 800AE164 00000000 */  nop      
/* 800AE168 10400012 */  beqz     $v0,.L800AE1B4
/* 800AE16C 3402ffff */  li       $v0,0xffff
/* 800AE170 8ea300c0 */  lw       $v1,192($s5)
/* 800AE174 00000000 */  nop      
/* 800AE178 0043102a */  slt      $v0,$v0,$v1
/* 800AE17C 1440000d */  bnez     $v0,.L800AE1B4
/* 800AE180 00000000 */  nop      
/* 800AE184 8ea500ac */  lw       $a1,172($s5)
/* 800AE188 0c0393c5 */  jal      func_800E4F14
/* 800AE18C 34048000 */  li       $a0,0x8000
/* 800AE190 8ea500b0 */  lw       $a1,176($s5)
/* 800AE194 34048000 */  li       $a0,0x8000
/* 800AE198 0c0393c5 */  jal      func_800E4F14
/* 800AE19C aea200ac */  sw       $v0,172($s5)
/* 800AE1A0 8ea500b4 */  lw       $a1,180($s5)
/* 800AE1A4 34048000 */  li       $a0,0x8000
.L800AE1A8:
/* 800AE1A8 0c0393c5 */  jal      func_800E4F14
/* 800AE1AC aea200b0 */  sw       $v0,176($s5)
/* 800AE1B0 aea200b4 */  sw       $v0,180($s5)
.L800AE1B4:
/* 800AE1B4 8fbf0114 */  lw       $ra,276($sp)
/* 800AE1B8 8fb60110 */  lw       $s6,272($sp)
/* 800AE1BC 8fb5010c */  lw       $s5,268($sp)
/* 800AE1C0 8fb40108 */  lw       $s4,264($sp)
/* 800AE1C4 8fb30104 */  lw       $s3,260($sp)
/* 800AE1C8 8fb20100 */  lw       $s2,256($sp)
/* 800AE1CC 8fb100fc */  lw       $s1,252($sp)
/* 800AE1D0 8fb000f8 */  lw       $s0,248($sp)
/* 800AE1D4 03e00008 */  jr       $ra
/* 800AE1D8 27bd0118 */  addiu    $sp,$sp,280
