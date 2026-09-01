.set noat
.set noreorder

glabel func_800ACDFC
/* 800ACDFC 27bdfee8 */  addiu    $sp,$sp,-280
/* 800ACE00 afb5010c */  sw       $s5,268($sp)
/* 800ACE04 0080a821 */  move     $s5,$a0
/* 800ACE08 3c028011 */  lui      $v0,0x8011
/* 800ACE0C afbf0114 */  sw       $ra,276($sp)
/* 800ACE10 afb60110 */  sw       $s6,272($sp)
/* 800ACE14 afb40108 */  sw       $s4,264($sp)
/* 800ACE18 afb30104 */  sw       $s3,260($sp)
/* 800ACE1C afb20100 */  sw       $s2,256($sp)
/* 800ACE20 afb100fc */  sw       $s1,252($sp)
/* 800ACE24 afb000f8 */  sw       $s0,248($sp)
/* 800ACE28 aea0040c */  sw       $zero,1036($s5)
/* 800ACE2C aea00410 */  sw       $zero,1040($s5)
/* 800ACE30 aea00414 */  sw       $zero,1044($s5)
/* 800ACE34 8c424518 */  lw       $v0,17688($v0)
/* 800ACE38 8eb60464 */  lw       $s6,1124($s5)
/* 800ACE3C 24100001 */  li       $s0,1
/* 800ACE40 af900dc4 */  sw       $s0,3524($gp)
/* 800ACE44 af900dc8 */  sw       $s0,3528($gp)
/* 800ACE48 10400009 */  beqz     $v0,.L800ACE70
/* 800ACE4C 00000000 */  nop      
/* 800ACE50 0c02027e */  jal      func_800809F8
/* 800ACE54 26a40008 */  addiu    $a0,$s5,8
/* 800ACE58 00501026 */  xor      $v0,$v0,$s0
/* 800ACE5C 10400004 */  beqz     $v0,.L800ACE70
/* 800ACE60 00000000 */  nop      
/* 800ACE64 af900dc0 */  sw       $s0,3520($gp)
/* 800ACE68 0802b39d */  j        .L800ACE74
/* 800ACE6C 00000000 */  nop      
.L800ACE70:
/* 800ACE70 af800dc0 */  sw       $zero,3520($gp)
.L800ACE74:
/* 800ACE74 8ea202ac */  lw       $v0,684($s5)
/* 800ACE78 00000000 */  nop      
/* 800ACE7C 1040000b */  beqz     $v0,.L800ACEAC
/* 800ACE80 00000000 */  nop      
/* 800ACE84 8ea202dc */  lw       $v0,732($s5)
/* 800ACE88 00000000 */  nop      
/* 800ACE8C 10400007 */  beqz     $v0,.L800ACEAC
/* 800ACE90 00000000 */  nop      
/* 800ACE94 8ea20188 */  lw       $v0,392($s5)
/* 800ACE98 00000000 */  nop      
/* 800ACE9C 28420ccd */  slti     $v0,$v0,3277
/* 800ACEA0 14400002 */  bnez     $v0,.L800ACEAC
/* 800ACEA4 00000000 */  nop      
/* 800ACEA8 af800dc4 */  sw       $zero,3524($gp)
.L800ACEAC:
/* 800ACEAC 8ea2030c */  lw       $v0,780($s5)
/* 800ACEB0 00000000 */  nop      
/* 800ACEB4 1040000b */  beqz     $v0,.L800ACEE4
/* 800ACEB8 00000000 */  nop      
/* 800ACEBC 8ea2033c */  lw       $v0,828($s5)
/* 800ACEC0 00000000 */  nop      
/* 800ACEC4 10400007 */  beqz     $v0,.L800ACEE4
/* 800ACEC8 00000000 */  nop      
/* 800ACECC 8ea20188 */  lw       $v0,392($s5)
/* 800ACED0 00000000 */  nop      
/* 800ACED4 28420ccd */  slti     $v0,$v0,3277
/* 800ACED8 14400002 */  bnez     $v0,.L800ACEE4
/* 800ACEDC 00000000 */  nop      
/* 800ACEE0 af800dc8 */  sw       $zero,3528($gp)
.L800ACEE4:
/* 800ACEE4 8ea400ac */  lw       $a0,172($s5)
/* 800ACEE8 8ea501c4 */  lw       $a1,452($s5)
/* 800ACEEC 0c0393c0 */  jal      func_800E4F00
/* 800ACEF0 00000000 */  nop      
/* 800ACEF4 8ea400b0 */  lw       $a0,176($s5)
/* 800ACEF8 8ea501c8 */  lw       $a1,456($s5)
/* 800ACEFC 0c0393c0 */  jal      func_800E4F00
/* 800ACF00 00408021 */  move     $s0,$v0
/* 800ACF04 8ea400b4 */  lw       $a0,180($s5)
/* 800ACF08 8ea501cc */  lw       $a1,460($s5)
/* 800ACF0C 0c0393c0 */  jal      func_800E4F00
/* 800ACF10 00408821 */  move     $s1,$v0
/* 800ACF14 02118021 */  addu     $s0,$s0,$s1
/* 800ACF18 8ea400ac */  lw       $a0,172($s5)
/* 800ACF1C 8ea501d0 */  lw       $a1,464($s5)
/* 800ACF20 02028021 */  addu     $s0,$s0,$v0
/* 800ACF24 0c0393c0 */  jal      func_800E4F00
/* 800ACF28 aeb00418 */  sw       $s0,1048($s5)
/* 800ACF2C 8ea400b0 */  lw       $a0,176($s5)
/* 800ACF30 8ea501d4 */  lw       $a1,468($s5)
/* 800ACF34 0c0393c0 */  jal      func_800E4F00
/* 800ACF38 00408021 */  move     $s0,$v0
/* 800ACF3C 8ea400b4 */  lw       $a0,180($s5)
/* 800ACF40 8ea501d8 */  lw       $a1,472($s5)
/* 800ACF44 0c0393c0 */  jal      func_800E4F00
/* 800ACF48 00408821 */  move     $s1,$v0
/* 800ACF4C 02118021 */  addu     $s0,$s0,$s1
/* 800ACF50 8ea400ac */  lw       $a0,172($s5)
/* 800ACF54 8ea501dc */  lw       $a1,476($s5)
/* 800ACF58 02028021 */  addu     $s0,$s0,$v0
/* 800ACF5C 0c0393c0 */  jal      func_800E4F00
/* 800ACF60 aeb0041c */  sw       $s0,1052($s5)
/* 800ACF64 8ea400b0 */  lw       $a0,176($s5)
/* 800ACF68 8ea501e0 */  lw       $a1,480($s5)
/* 800ACF6C 0c0393c0 */  jal      func_800E4F00
/* 800ACF70 00408021 */  move     $s0,$v0
/* 800ACF74 8ea400b4 */  lw       $a0,180($s5)
/* 800ACF78 8ea501e4 */  lw       $a1,484($s5)
/* 800ACF7C 0c0393c0 */  jal      func_800E4F00
/* 800ACF80 00408821 */  move     $s1,$v0
/* 800ACF84 02118021 */  addu     $s0,$s0,$s1
/* 800ACF88 8ea40114 */  lw       $a0,276($s5)
/* 800ACF8C 8ea501c4 */  lw       $a1,452($s5)
/* 800ACF90 02028021 */  addu     $s0,$s0,$v0
/* 800ACF94 0c0393c0 */  jal      func_800E4F00
/* 800ACF98 aeb00420 */  sw       $s0,1056($s5)
/* 800ACF9C 8ea40118 */  lw       $a0,280($s5)
/* 800ACFA0 8ea501c8 */  lw       $a1,456($s5)
/* 800ACFA4 0c0393c0 */  jal      func_800E4F00
/* 800ACFA8 00408021 */  move     $s0,$v0
/* 800ACFAC 8ea4011c */  lw       $a0,284($s5)
/* 800ACFB0 8ea501cc */  lw       $a1,460($s5)
/* 800ACFB4 0c0393c0 */  jal      func_800E4F00
/* 800ACFB8 00408821 */  move     $s1,$v0
/* 800ACFBC 02118021 */  addu     $s0,$s0,$s1
/* 800ACFC0 8ea40114 */  lw       $a0,276($s5)
/* 800ACFC4 8ea501d0 */  lw       $a1,464($s5)
/* 800ACFC8 02028021 */  addu     $s0,$s0,$v0
/* 800ACFCC 0c0393c0 */  jal      func_800E4F00
/* 800ACFD0 aeb00424 */  sw       $s0,1060($s5)
/* 800ACFD4 8ea40118 */  lw       $a0,280($s5)
/* 800ACFD8 8ea501d4 */  lw       $a1,468($s5)
/* 800ACFDC 0c0393c0 */  jal      func_800E4F00
/* 800ACFE0 00408021 */  move     $s0,$v0
/* 800ACFE4 8ea4011c */  lw       $a0,284($s5)
/* 800ACFE8 8ea501d8 */  lw       $a1,472($s5)
/* 800ACFEC 0c0393c0 */  jal      func_800E4F00
/* 800ACFF0 00408821 */  move     $s1,$v0
/* 800ACFF4 02118021 */  addu     $s0,$s0,$s1
/* 800ACFF8 8ea40114 */  lw       $a0,276($s5)
/* 800ACFFC 8ea501dc */  lw       $a1,476($s5)
/* 800AD000 02028021 */  addu     $s0,$s0,$v0
/* 800AD004 0c0393c0 */  jal      func_800E4F00
/* 800AD008 aeb00428 */  sw       $s0,1064($s5)
/* 800AD00C 8ea40118 */  lw       $a0,280($s5)
/* 800AD010 8ea501e0 */  lw       $a1,480($s5)
/* 800AD014 0c0393c0 */  jal      func_800E4F00
/* 800AD018 00408021 */  move     $s0,$v0
/* 800AD01C 8ea4011c */  lw       $a0,284($s5)
/* 800AD020 8ea501e4 */  lw       $a1,484($s5)
/* 800AD024 0c0393c0 */  jal      func_800E4F00
/* 800AD028 00408821 */  move     $s1,$v0
/* 800AD02C 02118021 */  addu     $s0,$s0,$s1
/* 800AD030 02028021 */  addu     $s0,$s0,$v0
/* 800AD034 8ea50420 */  lw       $a1,1056($s5)
/* 800AD038 3c020005 */  lui      $v0,0x5
/* 800AD03C 0045102a */  slt      $v0,$v0,$a1
/* 800AD040 10400006 */  beqz     $v0,.L800AD05C
/* 800AD044 aeb0042c */  sw       $s0,1068($s5)
/* 800AD048 8ea40418 */  lw       $a0,1048($s5)
/* 800AD04C 0c0393f7 */  jal      func_800E4FDC
/* 800AD050 00000000 */  nop      
/* 800AD054 0802b418 */  j        .L800AD060
/* 800AD058 aea20478 */  sw       $v0,1144($s5)
.L800AD05C:
/* 800AD05C aea00478 */  sw       $zero,1144($s5)
.L800AD060:
/* 800AD060 8ea20418 */  lw       $v0,1048($s5)
/* 800AD064 00000000 */  nop      
/* 800AD068 00021140 */  sll      $v0,$v0,0x5
/* 800AD06C 00021023 */  negu     $v0,$v0
/* 800AD070 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD074 00431021 */  addu     $v0,$v0,$v1
/* 800AD078 00021043 */  sra      $v0,$v0,0x1
/* 800AD07C afa20090 */  sw       $v0,144($sp)
/* 800AD080 8ea2041c */  lw       $v0,1052($s5)
/* 800AD084 00000000 */  nop      
/* 800AD088 00021140 */  sll      $v0,$v0,0x5
/* 800AD08C 00021023 */  negu     $v0,$v0
/* 800AD090 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD094 00431021 */  addu     $v0,$v0,$v1
/* 800AD098 00021043 */  sra      $v0,$v0,0x1
/* 800AD09C afa20094 */  sw       $v0,148($sp)
/* 800AD0A0 8ea20420 */  lw       $v0,1056($s5)
/* 800AD0A4 00000000 */  nop      
/* 800AD0A8 00021140 */  sll      $v0,$v0,0x5
/* 800AD0AC 00021023 */  negu     $v0,$v0
/* 800AD0B0 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD0B4 00431021 */  addu     $v0,$v0,$v1
/* 800AD0B8 00021043 */  sra      $v0,$v0,0x1
/* 800AD0BC afa20098 */  sw       $v0,152($sp)
/* 800AD0C0 8ea40118 */  lw       $a0,280($s5)
/* 800AD0C4 8ec501c4 */  lw       $a1,452($s6)
/* 800AD0C8 0c0393c0 */  jal      func_800E4F00
/* 800AD0CC 00042140 */  sll      $a0,$a0,0x5
/* 800AD0D0 00002021 */  move     $a0,$zero
/* 800AD0D4 3c03fff6 */  lui      $v1,0xfff6
/* 800AD0D8 00029023 */  negu     $s2,$v0
/* 800AD0DC 001217c2 */  srl      $v0,$s2,0x1f
/* 800AD0E0 02429021 */  addu     $s2,$s2,$v0
/* 800AD0E4 afa00070 */  sw       $zero,112($sp)
/* 800AD0E8 afa30074 */  sw       $v1,116($sp)
/* 800AD0EC afa00078 */  sw       $zero,120($sp)
/* 800AD0F0 8ea501c4 */  lw       $a1,452($s5)
/* 800AD0F4 0c0393c0 */  jal      func_800E4F00
/* 800AD0F8 00129043 */  sra      $s2,$s2,0x1
/* 800AD0FC 8fa40074 */  lw       $a0,116($sp)
/* 800AD100 8ea501c8 */  lw       $a1,456($s5)
/* 800AD104 0c0393c0 */  jal      func_800E4F00
/* 800AD108 00408021 */  move     $s0,$v0
/* 800AD10C 8fa40078 */  lw       $a0,120($sp)
/* 800AD110 8ea501cc */  lw       $a1,460($s5)
/* 800AD114 0c0393c0 */  jal      func_800E4F00
/* 800AD118 00408821 */  move     $s1,$v0
/* 800AD11C 3c138011 */  lui      $s3,0x8011
/* 800AD120 02118021 */  addu     $s0,$s0,$s1
/* 800AD124 8fa40070 */  lw       $a0,112($sp)
/* 800AD128 02028021 */  addu     $s0,$s0,$v0
/* 800AD12C ae7078b8 */  sw       $s0,30904($s3)
/* 800AD130 8ea501d0 */  lw       $a1,464($s5)
/* 800AD134 0c0393c0 */  jal      func_800E4F00
/* 800AD138 267478b8 */  addiu    $s4,$s3,30904
/* 800AD13C 8fa40074 */  lw       $a0,116($sp)
/* 800AD140 8ea501d4 */  lw       $a1,468($s5)
/* 800AD144 0c0393c0 */  jal      func_800E4F00
/* 800AD148 00408021 */  move     $s0,$v0
/* 800AD14C 8fa40078 */  lw       $a0,120($sp)
/* 800AD150 8ea501d8 */  lw       $a1,472($s5)
/* 800AD154 0c0393c0 */  jal      func_800E4F00
/* 800AD158 00408821 */  move     $s1,$v0
/* 800AD15C 02118021 */  addu     $s0,$s0,$s1
/* 800AD160 8fa40070 */  lw       $a0,112($sp)
/* 800AD164 02028021 */  addu     $s0,$s0,$v0
/* 800AD168 ae900004 */  sw       $s0,4($s4)
/* 800AD16C 8ea501dc */  lw       $a1,476($s5)
/* 800AD170 0c0393c0 */  jal      func_800E4F00
/* 800AD174 00000000 */  nop      
/* 800AD178 8fa40074 */  lw       $a0,116($sp)
/* 800AD17C 8ea501e0 */  lw       $a1,480($s5)
/* 800AD180 0c0393c0 */  jal      func_800E4F00
/* 800AD184 00408021 */  move     $s0,$v0
/* 800AD188 8fa40078 */  lw       $a0,120($sp)
/* 800AD18C 8ea501e4 */  lw       $a1,484($s5)
/* 800AD190 0c0393c0 */  jal      func_800E4F00
/* 800AD194 00408821 */  move     $s1,$v0
/* 800AD198 02a02021 */  move     $a0,$s5
/* 800AD19C 02118021 */  addu     $s0,$s0,$s1
/* 800AD1A0 02028021 */  addu     $s0,$s0,$v0
/* 800AD1A4 ae900008 */  sw       $s0,8($s4)
/* 800AD1A8 8fa30090 */  lw       $v1,144($sp)
/* 800AD1AC 8fa50094 */  lw       $a1,148($sp)
/* 800AD1B0 8fa60098 */  lw       $a2,152($sp)
/* 800AD1B4 00721021 */  addu     $v0,$v1,$s2
/* 800AD1B8 00721823 */  subu     $v1,$v1,$s2
/* 800AD1BC afa20020 */  sw       $v0,32($sp)
/* 800AD1C0 afa50024 */  sw       $a1,36($sp)
/* 800AD1C4 afa60028 */  sw       $a2,40($sp)
/* 800AD1C8 afa30050 */  sw       $v1,80($sp)
/* 800AD1CC afa50054 */  sw       $a1,84($sp)
/* 800AD1D0 0c02aa69 */  jal      func_800AA9A4
/* 800AD1D4 afa60058 */  sw       $a2,88($sp)
/* 800AD1D8 8e6378b8 */  lw       $v1,30904($s3)
/* 800AD1DC 00000000 */  nop      
/* 800AD1E0 04610002 */  bgez     $v1,.L800AD1EC
/* 800AD1E4 00000000 */  nop      
/* 800AD1E8 246300ff */  addiu    $v1,$v1,255
.L800AD1EC:
/* 800AD1EC 00031a03 */  sra      $v1,$v1,0x8
/* 800AD1F0 00031040 */  sll      $v0,$v1,0x1
/* 800AD1F4 00431021 */  addu     $v0,$v0,$v1
/* 800AD1F8 00021a00 */  sll      $v1,$v0,0x8
/* 800AD1FC 04610002 */  bgez     $v1,.L800AD208
/* 800AD200 3402ffff */  li       $v0,0xffff
/* 800AD204 00621821 */  addu     $v1,$v1,$v0
.L800AD208:
/* 800AD208 8ea20450 */  lw       $v0,1104($s5)
/* 800AD20C 00038403 */  sra      $s0,$v1,0x10
/* 800AD210 00501821 */  addu     $v1,$v0,$s0
/* 800AD214 28620080 */  slti     $v0,$v1,128
/* 800AD218 14400003 */  bnez     $v0,.L800AD228
/* 800AD21C 2862ff81 */  slti     $v0,$v1,-127
/* 800AD220 0802b48d */  j        .L800AD234
/* 800AD224 2403007f */  li       $v1,127
.L800AD228:
/* 800AD228 10400002 */  beqz     $v0,.L800AD234
/* 800AD22C 00000000 */  nop      
/* 800AD230 2403ff81 */  li       $v1,-127
.L800AD234:
/* 800AD234 8ec2010c */  lw       $v0,268($s6)
/* 800AD238 00000000 */  nop      
/* 800AD23C 00620018 */  mult     $v1,$v0
/* 800AD240 00001012 */  mflo     $v0
/* 800AD244 04410003 */  bgez     $v0,.L800AD254
/* 800AD248 000229c3 */  sra      $a1,$v0,0x7
/* 800AD24C 2442007f */  addiu    $v0,$v0,127
/* 800AD250 000229c3 */  sra      $a1,$v0,0x7
.L800AD254:
/* 800AD254 afa5001c */  sw       $a1,28($sp)
/* 800AD258 8ea20218 */  lw       $v0,536($s5)
/* 800AD25C 8ea3021c */  lw       $v1,540($s5)
/* 800AD260 00000000 */  nop      
/* 800AD264 00431021 */  addu     $v0,$v0,$v1
/* 800AD268 8ea30220 */  lw       $v1,544($s5)
/* 800AD26C 8ea4023c */  lw       $a0,572($s5)
/* 800AD270 00431021 */  addu     $v0,$v0,$v1
/* 800AD274 00441821 */  addu     $v1,$v0,$a0
/* 800AD278 04610002 */  bgez     $v1,.L800AD284
/* 800AD27C 00601021 */  move     $v0,$v1
/* 800AD280 246201ff */  addiu    $v0,$v1,511
.L800AD284:
/* 800AD284 00021a43 */  sra      $v1,$v0,0x9
/* 800AD288 00a02021 */  move     $a0,$a1
/* 800AD28C 3c020001 */  lui      $v0,0x1
/* 800AD290 04810002 */  bgez     $a0,.L800AD29C
/* 800AD294 00431023 */  subu     $v0,$v0,$v1
/* 800AD298 248400ff */  addiu    $a0,$a0,255
.L800AD29C:
/* 800AD29C 04410002 */  bgez     $v0,.L800AD2A8
/* 800AD2A0 00041a03 */  sra      $v1,$a0,0x8
/* 800AD2A4 244200ff */  addiu    $v0,$v0,255
.L800AD2A8:
/* 800AD2A8 00021203 */  sra      $v0,$v0,0x8
/* 800AD2AC 00620018 */  mult     $v1,$v0
/* 800AD2B0 00004012 */  mflo     $t0
/* 800AD2B4 afa8001c */  sw       $t0,28($sp)
/* 800AD2B8 8ea40420 */  lw       $a0,1056($s5)
/* 800AD2BC 3c02003c */  lui      $v0,0x3c
/* 800AD2C0 0044102a */  slt      $v0,$v0,$a0
/* 800AD2C4 10400008 */  beqz     $v0,.L800AD2E8
/* 800AD2C8 3c02001a */  lui      $v0,0x1a
/* 800AD2CC 0c0393c0 */  jal      func_800E4F00
/* 800AD2D0 24050444 */  li       $a1,1092
/* 800AD2D4 8fa4001c */  lw       $a0,28($sp)
/* 800AD2D8 0c0393f7 */  jal      func_800E4FDC
/* 800AD2DC 00402821 */  move     $a1,$v0
/* 800AD2E0 afa2001c */  sw       $v0,28($sp)
/* 800AD2E4 3c02001a */  lui      $v0,0x1a
.L800AD2E8:
/* 800AD2E8 8ea30420 */  lw       $v1,1056($s5)
/* 800AD2EC 3442b333 */  ori      $v0,$v0,0xb333
/* 800AD2F0 0043102a */  slt      $v0,$v0,$v1
/* 800AD2F4 1040000c */  beqz     $v0,.L800AD328
/* 800AD2F8 3c02000d */  lui      $v0,0xd
/* 800AD2FC 8ea30478 */  lw       $v1,1144($s5)
/* 800AD300 00000000 */  nop      
/* 800AD304 28620ccd */  slti     $v0,$v1,3277
/* 800AD308 14400014 */  bnez     $v0,.L800AD35C
/* 800AD30C 2862f334 */  slti     $v0,$v1,-3276
/* 800AD310 8fa2001c */  lw       $v0,28($sp)
/* 800AD314 00000000 */  nop      
/* 800AD318 1c400016 */  bgtz     $v0,.L800AD374
/* 800AD31C 2862f334 */  slti     $v0,$v1,-3276
/* 800AD320 0802b4d7 */  j        .L800AD35C
/* 800AD324 00000000 */  nop      
.L800AD328:
/* 800AD328 34426666 */  ori      $v0,$v0,0x6666
/* 800AD32C 0043102a */  slt      $v0,$v0,$v1
/* 800AD330 10400020 */  beqz     $v0,.L800AD3B4
/* 800AD334 02a02021 */  move     $a0,$s5
/* 800AD338 8ea30478 */  lw       $v1,1144($s5)
/* 800AD33C 00000000 */  nop      
/* 800AD340 28622667 */  slti     $v0,$v1,9831
/* 800AD344 14400005 */  bnez     $v0,.L800AD35C
/* 800AD348 2862d99a */  slti     $v0,$v1,-9830
/* 800AD34C 8fa2001c */  lw       $v0,28($sp)
/* 800AD350 00000000 */  nop      
/* 800AD354 1c400007 */  bgtz     $v0,.L800AD374
/* 800AD358 2862d99a */  slti     $v0,$v1,-9830
.L800AD35C:
/* 800AD35C 10400015 */  beqz     $v0,.L800AD3B4
/* 800AD360 02a02021 */  move     $a0,$s5
/* 800AD364 8fa2001c */  lw       $v0,28($sp)
/* 800AD368 00000000 */  nop      
/* 800AD36C 04410012 */  bgez     $v0,.L800AD3B8
/* 800AD370 24020001 */  li       $v0,1
.L800AD374:
/* 800AD374 8ea20478 */  lw       $v0,1144($s5)
/* 800AD378 3c050001 */  lui      $a1,0x1
/* 800AD37C 04410002 */  bgez     $v0,.L800AD388
/* 800AD380 00000000 */  nop      
/* 800AD384 00021023 */  negu     $v0,$v0
.L800AD388:
/* 800AD388 00021840 */  sll      $v1,$v0,0x1
/* 800AD38C 00a01021 */  move     $v0,$a1
/* 800AD390 0043102a */  slt      $v0,$v0,$v1
/* 800AD394 14400002 */  bnez     $v0,.L800AD3A0
/* 800AD398 00000000 */  nop      
/* 800AD39C 00602821 */  move     $a1,$v1
.L800AD3A0:
/* 800AD3A0 8fa4001c */  lw       $a0,28($sp)
/* 800AD3A4 0c0393c0 */  jal      func_800E4F00
/* 800AD3A8 00000000 */  nop      
/* 800AD3AC afa2001c */  sw       $v0,28($sp)
/* 800AD3B0 02a02021 */  move     $a0,$s5
.L800AD3B4:
/* 800AD3B4 24020001 */  li       $v0,1
.L800AD3B8:
/* 800AD3B8 afa0004c */  sw       $zero,76($sp)
/* 800AD3BC afa20038 */  sw       $v0,56($sp)
/* 800AD3C0 0c02ad87 */  jal      func_800AB61C
/* 800AD3C4 afa00068 */  sw       $zero,104($sp)
/* 800AD3C8 00402021 */  move     $a0,$v0
/* 800AD3CC 04810002 */  bgez     $a0,.L800AD3D8
/* 800AD3D0 00801821 */  move     $v1,$a0
/* 800AD3D4 248300ff */  addiu    $v1,$a0,255
.L800AD3D8:
/* 800AD3D8 8ec200f8 */  lw       $v0,248($s6)
/* 800AD3DC 00000000 */  nop      
/* 800AD3E0 04410002 */  bgez     $v0,.L800AD3EC
/* 800AD3E4 00031a03 */  sra      $v1,$v1,0x8
/* 800AD3E8 244200ff */  addiu    $v0,$v0,255
.L800AD3EC:
/* 800AD3EC 00021203 */  sra      $v0,$v0,0x8
/* 800AD3F0 00620018 */  mult     $v1,$v0
/* 800AD3F4 8f830dc4 */  lw       $v1,3524($gp)
/* 800AD3F8 00001012 */  mflo     $v0
/* 800AD3FC afa20010 */  sw       $v0,16($sp)
/* 800AD400 00821023 */  subu     $v0,$a0,$v0
/* 800AD404 14600008 */  bnez     $v1,.L800AD428
/* 800AD408 afa20040 */  sw       $v0,64($sp)
/* 800AD40C 8f820dc8 */  lw       $v0,3528($gp)
/* 800AD410 00000000 */  nop      
/* 800AD414 14400004 */  bnez     $v0,.L800AD428
/* 800AD418 00000000 */  nop      
/* 800AD41C aea00484 */  sw       $zero,1156($s5)
/* 800AD420 0802b86e */  j        .L800AE1B8
/* 800AD424 aea00488 */  sw       $zero,1160($s5)
.L800AD428:
/* 800AD428 8f830d98 */  lw       $v1,3480($gp)
/* 800AD42C 00000000 */  nop      
/* 800AD430 04610002 */  bgez     $v1,.L800AD43C
/* 800AD434 aea003ec */  sw       $zero,1004($s5)
/* 800AD438 246300ff */  addiu    $v1,$v1,255
.L800AD43C:
/* 800AD43C 8ec200fc */  lw       $v0,252($s6)
/* 800AD440 00000000 */  nop      
/* 800AD444 04410002 */  bgez     $v0,.L800AD450
/* 800AD448 00032203 */  sra      $a0,$v1,0x8
/* 800AD44C 244200ff */  addiu    $v0,$v0,255
.L800AD450:
/* 800AD450 00021203 */  sra      $v0,$v0,0x8
/* 800AD454 00820018 */  mult     $a0,$v0
/* 800AD458 8ea20420 */  lw       $v0,1056($s5)
/* 800AD45C 00000000 */  nop      
/* 800AD460 04410002 */  bgez     $v0,.L800AD46C
/* 800AD464 00000000 */  nop      
/* 800AD468 00021023 */  negu     $v0,$v0
.L800AD46C:
/* 800AD46C 00021140 */  sll      $v0,$v0,0x5
/* 800AD470 00402021 */  move     $a0,$v0
/* 800AD474 00008012 */  mflo     $s0
/* 800AD478 0090102a */  slt      $v0,$a0,$s0
/* 800AD47C 14400002 */  bnez     $v0,.L800AD488
/* 800AD480 00000000 */  nop      
/* 800AD484 02002021 */  move     $a0,$s0
.L800AD488:
/* 800AD488 8ea3023c */  lw       $v1,572($s5)
/* 800AD48C 00000000 */  nop      
/* 800AD490 1060000f */  beqz     $v1,.L800AD4D0
/* 800AD494 00808021 */  move     $s0,$a0
/* 800AD498 04610002 */  bgez     $v1,.L800AD4A4
/* 800AD49C 02002021 */  move     $a0,$s0
/* 800AD4A0 2463007f */  addiu    $v1,$v1,127
.L800AD4A4:
/* 800AD4A4 000319c3 */  sra      $v1,$v1,0x7
/* 800AD4A8 3c020001 */  lui      $v0,0x1
/* 800AD4AC 06010002 */  bgez     $s0,.L800AD4B8
/* 800AD4B0 00431023 */  subu     $v0,$v0,$v1
/* 800AD4B4 260400ff */  addiu    $a0,$s0,255
.L800AD4B8:
/* 800AD4B8 04410002 */  bgez     $v0,.L800AD4C4
/* 800AD4BC 00042203 */  sra      $a0,$a0,0x8
/* 800AD4C0 244200ff */  addiu    $v0,$v0,255
.L800AD4C4:
/* 800AD4C4 00021203 */  sra      $v0,$v0,0x8
/* 800AD4C8 00820018 */  mult     $a0,$v0
/* 800AD4CC 00008012 */  mflo     $s0
.L800AD4D0:
/* 800AD4D0 8ea20420 */  lw       $v0,1056($s5)
/* 800AD4D4 00000000 */  nop      
/* 800AD4D8 18400002 */  blez     $v0,.L800AD4E4
/* 800AD4DC 00000000 */  nop      
/* 800AD4E0 00108023 */  negu     $s0,$s0
.L800AD4E4:
/* 800AD4E4 8ec50100 */  lw       $a1,256($s6)
/* 800AD4E8 0c0393c0 */  jal      func_800E4F00
/* 800AD4EC 02002021 */  move     $a0,$s0
/* 800AD4F0 8fa30010 */  lw       $v1,16($sp)
/* 800AD4F4 00000000 */  nop      
/* 800AD4F8 00621821 */  addu     $v1,$v1,$v0
/* 800AD4FC afa30010 */  sw       $v1,16($sp)
/* 800AD500 8fa30040 */  lw       $v1,64($sp)
/* 800AD504 02021023 */  subu     $v0,$s0,$v0
/* 800AD508 00621821 */  addu     $v1,$v1,$v0
/* 800AD50C 3c028011 */  lui      $v0,0x8011
/* 800AD510 8c4478bc */  lw       $a0,30908($v0)
/* 800AD514 afa30040 */  sw       $v1,64($sp)
/* 800AD518 8ec50114 */  lw       $a1,276($s6)
/* 800AD51C 0c0393c0 */  jal      func_800E4F00
/* 800AD520 00042023 */  negu     $a0,$a0
/* 800AD524 00408821 */  move     $s1,$v0
/* 800AD528 0c02ad28 */  jal      func_800AB4A0
/* 800AD52C 02a02021 */  move     $a0,$s5
/* 800AD530 06210002 */  bgez     $s1,.L800AD53C
/* 800AD534 02201821 */  move     $v1,$s1
/* 800AD538 262300ff */  addiu    $v1,$s1,255
.L800AD53C:
/* 800AD53C 8f820dac */  lw       $v0,3500($gp)
/* 800AD540 00000000 */  nop      
/* 800AD544 04410002 */  bgez     $v0,.L800AD550
/* 800AD548 00032203 */  sra      $a0,$v1,0x8
/* 800AD54C 244200ff */  addiu    $v0,$v0,255
.L800AD550:
/* 800AD550 00021203 */  sra      $v0,$v0,0x8
/* 800AD554 00820018 */  mult     $a0,$v0
/* 800AD558 00008812 */  mflo     $s1
/* 800AD55C 06200316 */  bltz     $s1,.L800AE1B8
/* 800AD560 00000000 */  nop      
/* 800AD564 8f820dc0 */  lw       $v0,3520($gp)
/* 800AD568 00000000 */  nop      
/* 800AD56C 10400004 */  beqz     $v0,.L800AD580
/* 800AD570 02202021 */  move     $a0,$s1
/* 800AD574 8ec50108 */  lw       $a1,264($s6)
/* 800AD578 0802b561 */  j        .L800AD584
/* 800AD57C 24a5028f */  addiu    $a1,$a1,655
.L800AD580:
/* 800AD580 8ec50108 */  lw       $a1,264($s6)
.L800AD584:
/* 800AD584 0c0393c0 */  jal      func_800E4F00
/* 800AD588 00000000 */  nop      
/* 800AD58C 00409021 */  move     $s2,$v0
/* 800AD590 8ea20228 */  lw       $v0,552($s5)
/* 800AD594 8ea3022c */  lw       $v1,556($s5)
/* 800AD598 00000000 */  nop      
/* 800AD59C 00431021 */  addu     $v0,$v0,$v1
/* 800AD5A0 8ea30230 */  lw       $v1,560($s5)
/* 800AD5A4 8ea4023c */  lw       $a0,572($s5)
/* 800AD5A8 00431021 */  addu     $v0,$v0,$v1
/* 800AD5AC 00441021 */  addu     $v0,$v0,$a0
/* 800AD5B0 04410003 */  bgez     $v0,.L800AD5C0
/* 800AD5B4 00021a43 */  sra      $v1,$v0,0x9
/* 800AD5B8 244201ff */  addiu    $v0,$v0,511
/* 800AD5BC 00021a43 */  sra      $v1,$v0,0x9
.L800AD5C0:
/* 800AD5C0 3402c000 */  li       $v0,0xc000
/* 800AD5C4 00628021 */  addu     $s0,$v1,$v0
/* 800AD5C8 8ea4047c */  lw       $a0,1148($s5)
/* 800AD5CC 0c0393c0 */  jal      func_800E4F00
/* 800AD5D0 02002821 */  move     $a1,$s0
/* 800AD5D4 00402021 */  move     $a0,$v0
/* 800AD5D8 0481000b */  bgez     $a0,.L800AD608
/* 800AD5DC aea4047c */  sw       $a0,1148($s5)
/* 800AD5E0 02002821 */  move     $a1,$s0
/* 800AD5E4 248200ff */  addiu    $v0,$a0,255
/* 800AD5E8 04a10002 */  bgez     $a1,.L800AD5F4
/* 800AD5EC 00021a03 */  sra      $v1,$v0,0x8
/* 800AD5F0 24a500ff */  addiu    $a1,$a1,255
.L800AD5F4:
/* 800AD5F4 00051203 */  sra      $v0,$a1,0x8
/* 800AD5F8 00620018 */  mult     $v1,$v0
/* 800AD5FC 00004012 */  mflo     $t0
/* 800AD600 0802b58a */  j        .L800AD628
/* 800AD604 aea8047c */  sw       $t0,1148($s5)
.L800AD608:
/* 800AD608 18800007 */  blez     $a0,.L800AD628
/* 800AD60C 00041040 */  sll      $v0,$a0,0x1
/* 800AD610 00441021 */  addu     $v0,$v0,$a0
/* 800AD614 04410002 */  bgez     $v0,.L800AD620
/* 800AD618 00000000 */  nop      
/* 800AD61C 24420003 */  addiu    $v0,$v0,3
.L800AD620:
/* 800AD620 00021083 */  sra      $v0,$v0,0x2
/* 800AD624 aea2047c */  sw       $v0,1148($s5)
.L800AD628:
/* 800AD628 8ea2047c */  lw       $v0,1148($s5)
/* 800AD62C 8f830db0 */  lw       $v1,3504($gp)
/* 800AD630 02421023 */  subu     $v0,$s2,$v0
/* 800AD634 04610002 */  bgez     $v1,.L800AD640
/* 800AD638 afa20014 */  sw       $v0,20($sp)
/* 800AD63C 246300ff */  addiu    $v1,$v1,255
.L800AD640:
/* 800AD640 04410002 */  bgez     $v0,.L800AD64C
/* 800AD644 00031a03 */  sra      $v1,$v1,0x8
/* 800AD648 244200ff */  addiu    $v0,$v0,255
.L800AD64C:
/* 800AD64C 00021203 */  sra      $v0,$v0,0x8
/* 800AD650 00620018 */  mult     $v1,$v0
/* 800AD654 02321023 */  subu     $v0,$s1,$s2
/* 800AD658 00004012 */  mflo     $t0
/* 800AD65C afa80014 */  sw       $t0,20($sp)
/* 800AD660 8ea3047c */  lw       $v1,1148($s5)
/* 800AD664 8f840db4 */  lw       $a0,3508($gp)
/* 800AD668 00431021 */  addu     $v0,$v0,$v1
/* 800AD66C 04810002 */  bgez     $a0,.L800AD678
/* 800AD670 afa20044 */  sw       $v0,68($sp)
/* 800AD674 248400ff */  addiu    $a0,$a0,255
.L800AD678:
/* 800AD678 04410002 */  bgez     $v0,.L800AD684
/* 800AD67C 00041a03 */  sra      $v1,$a0,0x8
/* 800AD680 244200ff */  addiu    $v0,$v0,255
.L800AD684:
/* 800AD684 00021203 */  sra      $v0,$v0,0x8
/* 800AD688 00620018 */  mult     $v1,$v0
/* 800AD68C 8f820dc4 */  lw       $v0,3524($gp)
/* 800AD690 00004012 */  mflo     $t0
/* 800AD694 afa80044 */  sw       $t0,68($sp)
/* 800AD698 aea00474 */  sw       $zero,1140($s5)
/* 800AD69C afa0002c */  sw       $zero,44($sp)
/* 800AD6A0 afa00034 */  sw       $zero,52($sp)
/* 800AD6A4 afa0005c */  sw       $zero,92($sp)
/* 800AD6A8 10400004 */  beqz     $v0,.L800AD6BC
/* 800AD6AC afa00064 */  sw       $zero,100($sp)
/* 800AD6B0 02a02021 */  move     $a0,$s5
/* 800AD6B4 0c02b1b5 */  jal      func_800AC6D4
/* 800AD6B8 27a50010 */  addiu    $a1,$sp,16
.L800AD6BC:
/* 800AD6BC 8f820dc8 */  lw       $v0,3528($gp)
/* 800AD6C0 00000000 */  nop      
/* 800AD6C4 10400003 */  beqz     $v0,.L800AD6D4
/* 800AD6C8 02a02021 */  move     $a0,$s5
/* 800AD6CC 0c02b1b5 */  jal      func_800AC6D4
/* 800AD6D0 27a50040 */  addiu    $a1,$sp,64
.L800AD6D4:
/* 800AD6D4 8fa20034 */  lw       $v0,52($sp)
/* 800AD6D8 8fa30064 */  lw       $v1,100($sp)
/* 800AD6DC 00000000 */  nop      
/* 800AD6E0 00431021 */  addu     $v0,$v0,$v1
/* 800AD6E4 aea20414 */  sw       $v0,1044($s5)
/* 800AD6E8 8fa2002c */  lw       $v0,44($sp)
/* 800AD6EC 8fa3005c */  lw       $v1,92($sp)
/* 800AD6F0 8ea40414 */  lw       $a0,1044($s5)
/* 800AD6F4 00431021 */  addu     $v0,$v0,$v1
/* 800AD6F8 aea2040c */  sw       $v0,1036($s5)
/* 800AD6FC 8ec501cc */  lw       $a1,460($s6)
/* 800AD700 0c0393c0 */  jal      func_800E4F00
/* 800AD704 00000000 */  nop      
/* 800AD708 00401821 */  move     $v1,$v0
/* 800AD70C 3c028011 */  lui      $v0,0x8011
/* 800AD710 aea30414 */  sw       $v1,1044($s5)
/* 800AD714 8c424508 */  lw       $v0,17672($v0)
/* 800AD718 00000000 */  nop      
/* 800AD71C 30420080 */  andi     $v0,$v0,0x80
/* 800AD720 10400008 */  beqz     $v0,.L800AD744
/* 800AD724 00000000 */  nop      
/* 800AD728 18600006 */  blez     $v1,.L800AD744
/* 800AD72C 00000000 */  nop      
/* 800AD730 92a20446 */  lbu      $v0,1094($s5)
/* 800AD734 00000000 */  nop      
/* 800AD738 10400002 */  beqz     $v0,.L800AD744
/* 800AD73C 00031080 */  sll      $v0,$v1,0x2
/* 800AD740 aea20414 */  sw       $v0,1044($s5)
.L800AD744:
/* 800AD744 8f820dc0 */  lw       $v0,3520($gp)
/* 800AD748 00000000 */  nop      
/* 800AD74C 14400015 */  bnez     $v0,.L800AD7A4
/* 800AD750 3c028011 */  lui      $v0,0x8011
/* 800AD754 8ea20288 */  lw       $v0,648($s5)
/* 800AD758 00000000 */  nop      
/* 800AD75C 8c430038 */  lw       $v1,56($v0)
/* 800AD760 24020002 */  li       $v0,2
/* 800AD764 14620009 */  bne      $v1,$v0,.L800AD78C
/* 800AD768 3c050001 */  lui      $a1,0x1
/* 800AD76C 92a20442 */  lbu      $v0,1090($s5)
/* 800AD770 00000000 */  nop      
/* 800AD774 2c420004 */  sltiu    $v0,$v0,4
/* 800AD778 10400004 */  beqz     $v0,.L800AD78C
/* 800AD77C 00000000 */  nop      
/* 800AD780 8ea40414 */  lw       $a0,1044($s5)
/* 800AD784 0802b5e5 */  j        .L800AD794
/* 800AD788 34a52666 */  ori      $a1,$a1,0x2666
.L800AD78C:
/* 800AD78C 8ea40414 */  lw       $a0,1044($s5)
/* 800AD790 34a51999 */  ori      $a1,$a1,0x1999
.L800AD794:
/* 800AD794 0c0393c0 */  jal      func_800E4F00
/* 800AD798 00000000 */  nop      
/* 800AD79C aea20414 */  sw       $v0,1044($s5)
/* 800AD7A0 3c028011 */  lui      $v0,0x8011
.L800AD7A4:
/* 800AD7A4 aea00410 */  sw       $zero,1040($s5)
/* 800AD7A8 8c4478c0 */  lw       $a0,30912($v0)
/* 800AD7AC 0c0393c0 */  jal      func_800E4F00
/* 800AD7B0 24051999 */  li       $a1,6553
/* 800AD7B4 8ea4040c */  lw       $a0,1036($s5)
/* 800AD7B8 00000000 */  nop      
/* 800AD7BC 04810002 */  bgez     $a0,.L800AD7C8
/* 800AD7C0 00028023 */  negu     $s0,$v0
/* 800AD7C4 24840007 */  addiu    $a0,$a0,7
.L800AD7C8:
/* 800AD7C8 8ec50124 */  lw       $a1,292($s6)
/* 800AD7CC 0c0393c0 */  jal      func_800E4F00
/* 800AD7D0 000420c3 */  sra      $a0,$a0,0x3
/* 800AD7D4 8ea40414 */  lw       $a0,1044($s5)
/* 800AD7D8 00021023 */  negu     $v0,$v0
/* 800AD7DC aea20480 */  sw       $v0,1152($s5)
/* 800AD7E0 8ec50124 */  lw       $a1,292($s6)
/* 800AD7E4 0c0393c0 */  jal      func_800E4F00
/* 800AD7E8 00000000 */  nop      
/* 800AD7EC 00501021 */  addu     $v0,$v0,$s0
/* 800AD7F0 aea2047c */  sw       $v0,1148($s5)
/* 800AD7F4 8fa2002c */  lw       $v0,44($sp)
/* 800AD7F8 8fa4005c */  lw       $a0,92($sp)
/* 800AD7FC 8ec501c8 */  lw       $a1,456($s6)
/* 800AD800 0c0393c0 */  jal      func_800E4F00
/* 800AD804 00442023 */  subu     $a0,$v0,$a0
/* 800AD808 00408021 */  move     $s0,$v0
/* 800AD80C 8fa60034 */  lw       $a2,52($sp)
/* 800AD810 8fa40064 */  lw       $a0,100($sp)
/* 800AD814 8f830db8 */  lw       $v1,3512($gp)
/* 800AD818 8f850dbc */  lw       $a1,3516($gp)
/* 800AD81C 00c42021 */  addu     $a0,$a2,$a0
/* 800AD820 0c0393c0 */  jal      func_800E4F00
/* 800AD824 00652823 */  subu     $a1,$v1,$a1
/* 800AD828 8ec501c8 */  lw       $a1,456($s6)
/* 800AD82C 0c0393c0 */  jal      func_800E4F00
/* 800AD830 00402021 */  move     $a0,$v0
/* 800AD834 00021040 */  sll      $v0,$v0,0x1
/* 800AD838 02028021 */  addu     $s0,$s0,$v0
/* 800AD83C afb00084 */  sw       $s0,132($sp)
/* 800AD840 8ea20118 */  lw       $v0,280($s5)
/* 800AD844 00000000 */  nop      
/* 800AD848 18400003 */  blez     $v0,.L800AD858
/* 800AD84C 00000000 */  nop      
/* 800AD850 1e000005 */  bgtz     $s0,.L800AD868
/* 800AD854 00000000 */  nop      
.L800AD858:
/* 800AD858 0441002f */  bgez     $v0,.L800AD918
/* 800AD85C 00000000 */  nop      
/* 800AD860 0601002d */  bgez     $s0,.L800AD918
/* 800AD864 00000000 */  nop      
.L800AD868:
/* 800AD868 92a20445 */  lbu      $v0,1093($s5)
/* 800AD86C 00000000 */  nop      
/* 800AD870 1040000c */  beqz     $v0,.L800AD8A4
/* 800AD874 3c028011 */  lui      $v0,0x8011
/* 800AD878 8c424508 */  lw       $v0,17672($v0)
/* 800AD87C 00000000 */  nop      
/* 800AD880 30420008 */  andi     $v0,$v0,0x8
/* 800AD884 14400007 */  bnez     $v0,.L800AD8A4
/* 800AD888 00000000 */  nop      
/* 800AD88C 8fa20084 */  lw       $v0,132($sp)
/* 800AD890 00000000 */  nop      
/* 800AD894 00021fc2 */  srl      $v1,$v0,0x1f
/* 800AD898 00431021 */  addu     $v0,$v0,$v1
/* 800AD89C 0802b645 */  j        .L800AD914
/* 800AD8A0 00021043 */  sra      $v0,$v0,0x1
.L800AD8A4:
/* 800AD8A4 8ea3044c */  lw       $v1,1100($s5)
/* 800AD8A8 00000000 */  nop      
/* 800AD8AC 04610006 */  bgez     $v1,.L800AD8C8
/* 800AD8B0 00000000 */  nop      
/* 800AD8B4 8ea20118 */  lw       $v0,280($s5)
/* 800AD8B8 00000000 */  nop      
/* 800AD8BC 28423334 */  slti     $v0,$v0,13108
/* 800AD8C0 10400008 */  beqz     $v0,.L800AD8E4
/* 800AD8C4 00000000 */  nop      
.L800AD8C8:
/* 800AD8C8 1860000d */  blez     $v1,.L800AD900
/* 800AD8CC 00000000 */  nop      
/* 800AD8D0 8ea20118 */  lw       $v0,280($s5)
/* 800AD8D4 00000000 */  nop      
/* 800AD8D8 2842cccd */  slti     $v0,$v0,-13107
/* 800AD8DC 10400008 */  beqz     $v0,.L800AD900
/* 800AD8E0 00000000 */  nop      
.L800AD8E4:
/* 800AD8E4 8ea3046c */  lw       $v1,1132($s5)
/* 800AD8E8 24020001 */  li       $v0,1
/* 800AD8EC 14620004 */  bne      $v1,$v0,.L800AD900
/* 800AD8F0 00000000 */  nop      
/* 800AD8F4 8ea20118 */  lw       $v0,280($s5)
/* 800AD8F8 0802b645 */  j        .L800AD914
/* 800AD8FC 00021023 */  negu     $v0,$v0
.L800AD900:
/* 800AD900 8ea20464 */  lw       $v0,1124($s5)
/* 800AD904 8fa40084 */  lw       $a0,132($sp)
/* 800AD908 8c45012c */  lw       $a1,300($v0)
/* 800AD90C 0c0393c0 */  jal      func_800E4F00
/* 800AD910 00000000 */  nop      
.L800AD914:
/* 800AD914 afa20084 */  sw       $v0,132($sp)
.L800AD918:
/* 800AD918 26a401c4 */  addiu    $a0,$s5,452
/* 800AD91C 27a500a0 */  addiu    $a1,$sp,160
/* 800AD920 afa00080 */  sw       $zero,128($sp)
/* 800AD924 0c0393cc */  jal      func_800E4F30
/* 800AD928 afa00088 */  sw       $zero,136($sp)
/* 800AD92C 02a02021 */  move     $a0,$s5
/* 800AD930 0c0219eb */  jal      func_800867AC
/* 800AD934 00002821 */  move     $a1,$zero
/* 800AD938 8ea4040c */  lw       $a0,1036($s5)
/* 800AD93C 8fa500a0 */  lw       $a1,160($sp)
/* 800AD940 0c0393c0 */  jal      func_800E4F00
/* 800AD944 00000000 */  nop      
/* 800AD948 8ea40410 */  lw       $a0,1040($s5)
/* 800AD94C 8fa500a4 */  lw       $a1,164($sp)
/* 800AD950 0c0393c0 */  jal      func_800E4F00
/* 800AD954 00408021 */  move     $s0,$v0
/* 800AD958 8ea40414 */  lw       $a0,1044($s5)
/* 800AD95C 8fa500a8 */  lw       $a1,168($sp)
/* 800AD960 0c0393c0 */  jal      func_800E4F00
/* 800AD964 00408821 */  move     $s1,$v0
/* 800AD968 02118021 */  addu     $s0,$s0,$s1
/* 800AD96C 8ea4040c */  lw       $a0,1036($s5)
/* 800AD970 02028021 */  addu     $s0,$s0,$v0
/* 800AD974 aeb00400 */  sw       $s0,1024($s5)
/* 800AD978 8fa500ac */  lw       $a1,172($sp)
/* 800AD97C 0c0393c0 */  jal      func_800E4F00
/* 800AD980 00000000 */  nop      
/* 800AD984 8ea40410 */  lw       $a0,1040($s5)
/* 800AD988 8fa500b0 */  lw       $a1,176($sp)
/* 800AD98C 0c0393c0 */  jal      func_800E4F00
/* 800AD990 00408021 */  move     $s0,$v0
/* 800AD994 8ea40414 */  lw       $a0,1044($s5)
/* 800AD998 8fa500b4 */  lw       $a1,180($sp)
/* 800AD99C 0c0393c0 */  jal      func_800E4F00
/* 800AD9A0 00408821 */  move     $s1,$v0
/* 800AD9A4 02118021 */  addu     $s0,$s0,$s1
/* 800AD9A8 8ea4040c */  lw       $a0,1036($s5)
/* 800AD9AC 02028021 */  addu     $s0,$s0,$v0
/* 800AD9B0 aeb00404 */  sw       $s0,1028($s5)
/* 800AD9B4 8fa500b8 */  lw       $a1,184($sp)
/* 800AD9B8 0c0393c0 */  jal      func_800E4F00
/* 800AD9BC 00000000 */  nop      
/* 800AD9C0 8ea40410 */  lw       $a0,1040($s5)
/* 800AD9C4 8fa500bc */  lw       $a1,188($sp)
/* 800AD9C8 0c0393c0 */  jal      func_800E4F00
/* 800AD9CC 00408021 */  move     $s0,$v0
/* 800AD9D0 8ea40414 */  lw       $a0,1044($s5)
/* 800AD9D4 8fa500c0 */  lw       $a1,192($sp)
/* 800AD9D8 0c0393c0 */  jal      func_800E4F00
/* 800AD9DC 00408821 */  move     $s1,$v0
/* 800AD9E0 02118021 */  addu     $s0,$s0,$s1
/* 800AD9E4 02028021 */  addu     $s0,$s0,$v0
/* 800AD9E8 aeb00408 */  sw       $s0,1032($s5)
/* 800AD9EC 8fa40080 */  lw       $a0,128($sp)
/* 800AD9F0 8fa500a0 */  lw       $a1,160($sp)
/* 800AD9F4 0c0393c0 */  jal      func_800E4F00
/* 800AD9F8 00000000 */  nop      
/* 800AD9FC 8fa40084 */  lw       $a0,132($sp)
/* 800ADA00 8fa500a4 */  lw       $a1,164($sp)
/* 800ADA04 0c0393c0 */  jal      func_800E4F00
/* 800ADA08 00408021 */  move     $s0,$v0
/* 800ADA0C 8fa40088 */  lw       $a0,136($sp)
/* 800ADA10 8fa500a8 */  lw       $a1,168($sp)
/* 800ADA14 0c0393c0 */  jal      func_800E4F00
/* 800ADA18 00408821 */  move     $s1,$v0
/* 800ADA1C 02118021 */  addu     $s0,$s0,$s1
/* 800ADA20 02028021 */  addu     $s0,$s0,$v0
/* 800ADA24 aeb003f4 */  sw       $s0,1012($s5)
/* 800ADA28 8fa40080 */  lw       $a0,128($sp)
/* 800ADA2C 8fa500ac */  lw       $a1,172($sp)
/* 800ADA30 0c0393c0 */  jal      func_800E4F00
/* 800ADA34 00000000 */  nop      
/* 800ADA38 8fa40084 */  lw       $a0,132($sp)
/* 800ADA3C 8fa500b0 */  lw       $a1,176($sp)
/* 800ADA40 0c0393c0 */  jal      func_800E4F00
/* 800ADA44 00408021 */  move     $s0,$v0
/* 800ADA48 8fa40088 */  lw       $a0,136($sp)
/* 800ADA4C 8fa500b4 */  lw       $a1,180($sp)
/* 800ADA50 0c0393c0 */  jal      func_800E4F00
/* 800ADA54 00408821 */  move     $s1,$v0
/* 800ADA58 02118021 */  addu     $s0,$s0,$s1
/* 800ADA5C 02028021 */  addu     $s0,$s0,$v0
/* 800ADA60 aeb003f8 */  sw       $s0,1016($s5)
/* 800ADA64 8fa40080 */  lw       $a0,128($sp)
/* 800ADA68 8fa500b8 */  lw       $a1,184($sp)
/* 800ADA6C 0c0393c0 */  jal      func_800E4F00
/* 800ADA70 00000000 */  nop      
/* 800ADA74 8fa40084 */  lw       $a0,132($sp)
/* 800ADA78 8fa500bc */  lw       $a1,188($sp)
/* 800ADA7C 0c0393c0 */  jal      func_800E4F00
/* 800ADA80 00408021 */  move     $s0,$v0
/* 800ADA84 8fa40088 */  lw       $a0,136($sp)
/* 800ADA88 8fa500c0 */  lw       $a1,192($sp)
/* 800ADA8C 0c0393c0 */  jal      func_800E4F00
/* 800ADA90 00408821 */  move     $s1,$v0
/* 800ADA94 02118021 */  addu     $s0,$s0,$s1
/* 800ADA98 8ea30400 */  lw       $v1,1024($s5)
/* 800ADA9C 02028021 */  addu     $s0,$s0,$v0
/* 800ADAA0 04610002 */  bgez     $v1,.L800ADAAC
/* 800ADAA4 aeb003fc */  sw       $s0,1020($s5)
/* 800ADAA8 2463001f */  addiu    $v1,$v1,31
.L800ADAAC:
/* 800ADAAC 00031943 */  sra      $v1,$v1,0x5
/* 800ADAB0 8ea200ac */  lw       $v0,172($s5)
/* 800ADAB4 8ea40404 */  lw       $a0,1028($s5)
/* 800ADAB8 00431021 */  addu     $v0,$v0,$v1
/* 800ADABC 04810002 */  bgez     $a0,.L800ADAC8
/* 800ADAC0 aea200ac */  sw       $v0,172($s5)
/* 800ADAC4 2484001f */  addiu    $a0,$a0,31
.L800ADAC8:
/* 800ADAC8 00041943 */  sra      $v1,$a0,0x5
/* 800ADACC 8ea200b0 */  lw       $v0,176($s5)
/* 800ADAD0 8ea50408 */  lw       $a1,1032($s5)
/* 800ADAD4 00431021 */  addu     $v0,$v0,$v1
/* 800ADAD8 04a10002 */  bgez     $a1,.L800ADAE4
/* 800ADADC aea200b0 */  sw       $v0,176($s5)
/* 800ADAE0 24a5001f */  addiu    $a1,$a1,31
.L800ADAE4:
/* 800ADAE4 00051943 */  sra      $v1,$a1,0x5
/* 800ADAE8 8ea200b4 */  lw       $v0,180($s5)
/* 800ADAEC 8ea403f4 */  lw       $a0,1012($s5)
/* 800ADAF0 00431021 */  addu     $v0,$v0,$v1
/* 800ADAF4 04810002 */  bgez     $a0,.L800ADB00
/* 800ADAF8 aea200b4 */  sw       $v0,180($s5)
/* 800ADAFC 2484001f */  addiu    $a0,$a0,31
.L800ADB00:
/* 800ADB00 00041943 */  sra      $v1,$a0,0x5
/* 800ADB04 8ea20114 */  lw       $v0,276($s5)
/* 800ADB08 8ea503f8 */  lw       $a1,1016($s5)
/* 800ADB0C 00431021 */  addu     $v0,$v0,$v1
/* 800ADB10 04a10002 */  bgez     $a1,.L800ADB1C
/* 800ADB14 aea20114 */  sw       $v0,276($s5)
/* 800ADB18 24a5003f */  addiu    $a1,$a1,63
.L800ADB1C:
/* 800ADB1C 00051983 */  sra      $v1,$a1,0x6
/* 800ADB20 8ea20118 */  lw       $v0,280($s5)
/* 800ADB24 8ea403fc */  lw       $a0,1020($s5)
/* 800ADB28 00431021 */  addu     $v0,$v0,$v1
/* 800ADB2C 04810002 */  bgez     $a0,.L800ADB38
/* 800ADB30 aea20118 */  sw       $v0,280($s5)
/* 800ADB34 2484001f */  addiu    $a0,$a0,31
.L800ADB38:
/* 800ADB38 00041143 */  sra      $v0,$a0,0x5
/* 800ADB3C 8ea3011c */  lw       $v1,284($s5)
/* 800ADB40 8ea40460 */  lw       $a0,1120($s5)
/* 800ADB44 00621821 */  addu     $v1,$v1,$v0
/* 800ADB48 10800119 */  beqz     $a0,.L800ADFB0
/* 800ADB4C aea3011c */  sw       $v1,284($s5)
/* 800ADB50 3c020004 */  lui      $v0,0x4
/* 800ADB54 8ea3055c */  lw       $v1,1372($s5)
/* 800ADB58 344271c6 */  ori      $v0,$v0,0x71c6
/* 800ADB5C 0043102a */  slt      $v0,$v0,$v1
/* 800ADB60 1440000f */  bnez     $v0,.L800ADBA0
/* 800ADB64 00000000 */  nop      
/* 800ADB68 92a20442 */  lbu      $v0,1090($s5)
/* 800ADB6C 00000000 */  nop      
/* 800ADB70 2c420002 */  sltiu    $v0,$v0,2
/* 800ADB74 14400004 */  bnez     $v0,.L800ADB88
/* 800ADB78 00000000 */  nop      
/* 800ADB7C 92a20442 */  lbu      $v0,1090($s5)
/* 800ADB80 0802b6e3 */  j        .L800ADB8C
/* 800ADB84 00021080 */  sll      $v0,$v0,0x2
.L800ADB88:
/* 800ADB88 24020008 */  li       $v0,8
.L800ADB8C:
/* 800ADB8C 3c040018 */  lui      $a0,0x18
/* 800ADB90 02c21021 */  addu     $v0,$s6,$v0
/* 800ADB94 8c45000c */  lw       $a1,12($v0)
/* 800ADB98 0802b6f4 */  j        .L800ADBD0
/* 800ADB9C 34848000 */  ori      $a0,$a0,0x8000
.L800ADBA0:
/* 800ADBA0 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBA4 00000000 */  nop      
/* 800ADBA8 2c420002 */  sltiu    $v0,$v0,2
/* 800ADBAC 14400004 */  bnez     $v0,.L800ADBC0
/* 800ADBB0 00000000 */  nop      
/* 800ADBB4 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBB8 0802b6f1 */  j        .L800ADBC4
/* 800ADBBC 00021080 */  sll      $v0,$v0,0x2
.L800ADBC0:
/* 800ADBC0 24020008 */  li       $v0,8
.L800ADBC4:
/* 800ADBC4 02c21021 */  addu     $v0,$s6,$v0
/* 800ADBC8 8ea4055c */  lw       $a0,1372($s5)
/* 800ADBCC 8c45000c */  lw       $a1,12($v0)
.L800ADBD0:
/* 800ADBD0 0c0393c0 */  jal      func_800E4F00
/* 800ADBD4 00000000 */  nop      
/* 800ADBD8 00401821 */  move     $v1,$v0
/* 800ADBDC 04610002 */  bgez     $v1,.L800ADBE8
/* 800ADBE0 3402ffff */  li       $v0,0xffff
/* 800ADBE4 00621821 */  addu     $v1,$v1,$v0
.L800ADBE8:
/* 800ADBE8 92a20442 */  lbu      $v0,1090($s5)
/* 800ADBEC 00000000 */  nop      
/* 800ADBF0 2c420002 */  sltiu    $v0,$v0,2
/* 800ADBF4 14400004 */  bnez     $v0,.L800ADC08
/* 800ADBF8 00038403 */  sra      $s0,$v1,0x10
/* 800ADBFC 92a20442 */  lbu      $v0,1090($s5)
/* 800ADC00 0802b703 */  j        .L800ADC0C
/* 800ADC04 00021080 */  sll      $v0,$v0,0x2
.L800ADC08:
/* 800ADC08 24020008 */  li       $v0,8
.L800ADC0C:
/* 800ADC0C 02c21021 */  addu     $v0,$s6,$v0
/* 800ADC10 8ea40420 */  lw       $a0,1056($s5)
/* 800ADC14 8c45000c */  lw       $a1,12($v0)
/* 800ADC18 0c0393c0 */  jal      func_800E4F00
/* 800ADC1C 00000000 */  nop      
/* 800ADC20 00402821 */  move     $a1,$v0
/* 800ADC24 04a10002 */  bgez     $a1,.L800ADC30
/* 800ADC28 3402ffff */  li       $v0,0xffff
/* 800ADC2C 00a22821 */  addu     $a1,$a1,$v0
.L800ADC30:
/* 800ADC30 8ec300f0 */  lw       $v1,240($s6)
/* 800ADC34 00101200 */  sll      $v0,$s0,0x8
/* 800ADC38 0043001a */  div      $zero,$v0,$v1
/* 800ADC3C 14600002 */  bnez     $v1,.L800ADC48
/* 800ADC40 00000000 */  nop      
/* 800ADC44 0007000d */  break    0x7
.L800ADC48:
/* 800ADC48 2401ffff */  li       $at,-1
/* 800ADC4C 14610004 */  bne      $v1,$at,.L800ADC60
/* 800ADC50 3c018000 */  lui      $at,0x8000
/* 800ADC54 14410002 */  bne      $v0,$at,.L800ADC60
/* 800ADC58 00000000 */  nop      
/* 800ADC5C 0006000d */  break    0x6
.L800ADC60:
/* 800ADC60 00002012 */  mflo     $a0
/* 800ADC64 00051403 */  sra      $v0,$a1,0x10
/* 800ADC68 02022823 */  subu     $a1,$s0,$v0
/* 800ADC6C 28a200c9 */  slti     $v0,$a1,201
/* 800ADC70 14400016 */  bnez     $v0,.L800ADCCC
/* 800ADC74 28a200c8 */  slti     $v0,$a1,200
/* 800ADC78 000511c0 */  sll      $v0,$a1,0x7
/* 800ADC7C 0050001a */  div      $zero,$v0,$s0
/* 800ADC80 16000002 */  bnez     $s0,.L800ADC8C
/* 800ADC84 00000000 */  nop      
/* 800ADC88 0007000d */  break    0x7
.L800ADC8C:
/* 800ADC8C 2401ffff */  li       $at,-1
/* 800ADC90 16010004 */  bne      $s0,$at,.L800ADCA4
/* 800ADC94 3c018000 */  lui      $at,0x8000
/* 800ADC98 14410002 */  bne      $v0,$at,.L800ADCA4
/* 800ADC9C 00000000 */  nop      
/* 800ADCA0 0006000d */  break    0x6
.L800ADCA4:
/* 800ADCA4 00001012 */  mflo     $v0
/* 800ADCA8 00000000 */  nop      
/* 800ADCAC 00822021 */  addu     $a0,$a0,$v0
/* 800ADCB0 00801821 */  move     $v1,$a0
/* 800ADCB4 286200e1 */  slti     $v0,$v1,225
/* 800ADCB8 14400002 */  bnez     $v0,.L800ADCC4
/* 800ADCBC 00000000 */  nop      
/* 800ADCC0 240300e0 */  li       $v1,224
.L800ADCC4:
/* 800ADCC4 0802b763 */  j        .L800ADD8C
/* 800ADCC8 a2a30458 */  sb       $v1,1112($s5)
.L800ADCCC:
/* 800ADCCC 1040002f */  beqz     $v0,.L800ADD8C
/* 800ADCD0 000511c0 */  sll      $v0,$a1,0x7
/* 800ADCD4 0050001a */  div      $zero,$v0,$s0
/* 800ADCD8 16000002 */  bnez     $s0,.L800ADCE4
/* 800ADCDC 00000000 */  nop      
/* 800ADCE0 0007000d */  break    0x7
.L800ADCE4:
/* 800ADCE4 2401ffff */  li       $at,-1
/* 800ADCE8 16010004 */  bne      $s0,$at,.L800ADCFC
/* 800ADCEC 3c018000 */  lui      $at,0x8000
/* 800ADCF0 14410002 */  bne      $v0,$at,.L800ADCFC
/* 800ADCF4 00000000 */  nop      
/* 800ADCF8 0006000d */  break    0x6
.L800ADCFC:
/* 800ADCFC 00001012 */  mflo     $v0
/* 800ADD00 00000000 */  nop      
/* 800ADD04 00822021 */  addu     $a0,$a0,$v0
/* 800ADD08 04800003 */  bltz     $a0,.L800ADD18
/* 800ADD0C 00000000 */  nop      
/* 800ADD10 0802b747 */  j        .L800ADD1C
/* 800ADD14 a2a40458 */  sb       $a0,1112($s5)
.L800ADD18:
/* 800ADD18 a2a00458 */  sb       $zero,1112($s5)
.L800ADD1C:
/* 800ADD1C 04a1001c */  bgez     $a1,.L800ADD90
/* 800ADD20 3c032aaa */  lui      $v1,0x2aaa
/* 800ADD24 00051240 */  sll      $v0,$a1,0x9
/* 800ADD28 8ec300f0 */  lw       $v1,240($s6)
/* 800ADD2C 04410002 */  bgez     $v0,.L800ADD38
/* 800ADD30 00000000 */  nop      
/* 800ADD34 00021023 */  negu     $v0,$v0
.L800ADD38:
/* 800ADD38 0043001a */  div      $zero,$v0,$v1
/* 800ADD3C 14600002 */  bnez     $v1,.L800ADD48
/* 800ADD40 00000000 */  nop      
/* 800ADD44 0007000d */  break    0x7
.L800ADD48:
/* 800ADD48 2401ffff */  li       $at,-1
/* 800ADD4C 14610004 */  bne      $v1,$at,.L800ADD60
/* 800ADD50 3c018000 */  lui      $at,0x8000
/* 800ADD54 14410002 */  bne      $v0,$at,.L800ADD60
/* 800ADD58 00000000 */  nop      
/* 800ADD5C 0006000d */  break    0x6
.L800ADD60:
/* 800ADD60 00001812 */  mflo     $v1
/* 800ADD64 00000000 */  nop      
/* 800ADD68 28620100 */  slti     $v0,$v1,256
/* 800ADD6C 14400003 */  bnez     $v0,.L800ADD7C
/* 800ADD70 306200ff */  andi     $v0,$v1,0xff
/* 800ADD74 240300ff */  li       $v1,255
/* 800ADD78 306200ff */  andi     $v0,$v1,0xff
.L800ADD7C:
/* 800ADD7C 2c420081 */  sltiu    $v0,$v0,129
/* 800ADD80 14400002 */  bnez     $v0,.L800ADD8C
/* 800ADD84 a2a30459 */  sb       $v1,1113($s5)
/* 800ADD88 a2a00458 */  sb       $zero,1112($s5)
.L800ADD8C:
/* 800ADD8C 3c032aaa */  lui      $v1,0x2aaa
.L800ADD90:
/* 800ADD90 8ea20564 */  lw       $v0,1380($s5)
/* 800ADD94 3463aaab */  ori      $v1,$v1,0xaaab
/* 800ADD98 04410002 */  bgez     $v0,.L800ADDA4
/* 800ADD9C 00000000 */  nop      
/* 800ADDA0 00021023 */  negu     $v0,$v0
.L800ADDA4:
/* 800ADDA4 00430018 */  mult     $v0,$v1
/* 800ADDA8 000217c3 */  sra      $v0,$v0,0x1f
/* 800ADDAC 00004010 */  mfhi     $t0
/* 800ADDB0 00081c03 */  sra      $v1,$t0,0x10
/* 800ADDB4 00623023 */  subu     $a2,$v1,$v0
/* 800ADDB8 28c20003 */  slti     $v0,$a2,3
/* 800ADDBC 8ea30460 */  lw       $v1,1120($s5)
/* 800ADDC0 14400005 */  bnez     $v0,.L800ADDD8
/* 800ADDC4 00031040 */  sll      $v0,$v1,0x1
/* 800ADDC8 00660018 */  mult     $v1,$a2
/* 800ADDCC 00001812 */  mflo     $v1
/* 800ADDD0 0802b777 */  j        .L800ADDDC
/* 800ADDD4 00000000 */  nop      
.L800ADDD8:
/* 800ADDD8 00431821 */  addu     $v1,$v0,$v1
.L800ADDDC:
/* 800ADDDC 0460000a */  bltz     $v1,.L800ADE08
/* 800ADDE0 00000000 */  nop      
/* 800ADDE4 86a20008 */  lh       $v0,8($s5)
/* 800ADDE8 3c048014 */  lui      $a0,0x8014
/* 800ADDEC 8c84dae8 */  lw       $a0,-9496($a0)
/* 800ADDF0 00432821 */  addu     $a1,$v0,$v1
/* 800ADDF4 00a4102a */  slt      $v0,$a1,$a0
/* 800ADDF8 1440000c */  bnez     $v0,.L800ADE2C
/* 800ADDFC 00000000 */  nop      
/* 800ADE00 0802b78b */  j        .L800ADE2C
/* 800ADE04 00a42823 */  subu     $a1,$a1,$a0
.L800ADE08:
/* 800ADE08 86a20008 */  lh       $v0,8($s5)
/* 800ADE0C 00000000 */  nop      
/* 800ADE10 00432821 */  addu     $a1,$v0,$v1
/* 800ADE14 04a10005 */  bgez     $a1,.L800ADE2C
/* 800ADE18 00000000 */  nop      
/* 800ADE1C 3c028014 */  lui      $v0,0x8014
/* 800ADE20 8c42dae8 */  lw       $v0,-9496($v0)
/* 800ADE24 00000000 */  nop      
/* 800ADE28 00a22821 */  addu     $a1,$a1,$v0
.L800ADE2C:
/* 800ADE2C 00058140 */  sll      $s0,$a1,0x5
/* 800ADE30 00033040 */  sll      $a2,$v1,0x1
/* 800ADE34 00c33021 */  addu     $a2,$a2,$v1
/* 800ADE38 3c028014 */  lui      $v0,0x8014
/* 800ADE3C 8c42dae0 */  lw       $v0,-9504($v0)
/* 800ADE40 04c10002 */  bgez     $a2,.L800ADE4C
/* 800ADE44 00000000 */  nop      
/* 800ADE48 00063023 */  negu     $a2,$a2
.L800ADE4C:
/* 800ADE4C 8ea800a0 */  lw       $t0,160($s5)
/* 800ADE50 8ea900a4 */  lw       $t1,164($s5)
/* 800ADE54 8eaa00a8 */  lw       $t2,168($s5)
/* 800ADE58 afa800c8 */  sw       $t0,200($sp)
/* 800ADE5C afa900cc */  sw       $t1,204($sp)
/* 800ADE60 afaa00d0 */  sw       $t2,208($sp)
/* 800ADE64 02021021 */  addu     $v0,$s0,$v0
/* 800ADE68 8c480000 */  lw       $t0,0($v0)
/* 800ADE6C 8c490004 */  lw       $t1,4($v0)
/* 800ADE70 8c4a0008 */  lw       $t2,8($v0)
/* 800ADE74 afa800d8 */  sw       $t0,216($sp)
/* 800ADE78 afa900dc */  sw       $t1,220($sp)
/* 800ADE7C afaa00e0 */  sw       $t2,224($sp)
/* 800ADE80 0c02b30f */  jal      func_800ACC3C
/* 800ADE84 02a02021 */  move     $a0,$s5
/* 800ADE88 3c038014 */  lui      $v1,0x8014
/* 800ADE8C 8c63dae0 */  lw       $v1,-9504($v1)
/* 800ADE90 00408821 */  move     $s1,$v0
/* 800ADE94 02031821 */  addu     $v1,$s0,$v1
/* 800ADE98 80640012 */  lb       $a0,18($v1)
/* 800ADE9C 02202821 */  move     $a1,$s1
/* 800ADEA0 0c0393c0 */  jal      func_800E4F00
/* 800ADEA4 00042240 */  sll      $a0,$a0,0x9
/* 800ADEA8 3c038014 */  lui      $v1,0x8014
/* 800ADEAC 8c63dae0 */  lw       $v1,-9504($v1)
/* 800ADEB0 afa200e8 */  sw       $v0,232($sp)
/* 800ADEB4 02031821 */  addu     $v1,$s0,$v1
/* 800ADEB8 80640013 */  lb       $a0,19($v1)
/* 800ADEBC 02202821 */  move     $a1,$s1
/* 800ADEC0 0c0393c0 */  jal      func_800E4F00
/* 800ADEC4 00042240 */  sll      $a0,$a0,0x9
/* 800ADEC8 3c038014 */  lui      $v1,0x8014
/* 800ADECC 8c63dae0 */  lw       $v1,-9504($v1)
/* 800ADED0 afa200ec */  sw       $v0,236($sp)
/* 800ADED4 02038021 */  addu     $s0,$s0,$v1
/* 800ADED8 82040014 */  lb       $a0,20($s0)
/* 800ADEDC 02202821 */  move     $a1,$s1
/* 800ADEE0 0c0393c0 */  jal      func_800E4F00
/* 800ADEE4 00042240 */  sll      $a0,$a0,0x9
/* 800ADEE8 8fa500d8 */  lw       $a1,216($sp)
/* 800ADEEC 8fa300e8 */  lw       $v1,232($sp)
/* 800ADEF0 8fa600dc */  lw       $a2,220($sp)
/* 800ADEF4 8fa700ec */  lw       $a3,236($sp)
/* 800ADEF8 00a32821 */  addu     $a1,$a1,$v1
/* 800ADEFC 00c73021 */  addu     $a2,$a2,$a3
/* 800ADF00 8fa300e0 */  lw       $v1,224($sp)
/* 800ADF04 8fa700c8 */  lw       $a3,200($sp)
/* 800ADF08 afa200f0 */  sw       $v0,240($sp)
/* 800ADF0C afa500d8 */  sw       $a1,216($sp)
/* 800ADF10 00621821 */  addu     $v1,$v1,$v0
/* 800ADF14 8fa200cc */  lw       $v0,204($sp)
/* 800ADF18 00a72823 */  subu     $a1,$a1,$a3
/* 800ADF1C afa500d8 */  sw       $a1,216($sp)
/* 800ADF20 8fa500d0 */  lw       $a1,208($sp)
/* 800ADF24 27a400d8 */  addiu    $a0,$sp,216
/* 800ADF28 afa600dc */  sw       $a2,220($sp)
/* 800ADF2C afa300e0 */  sw       $v1,224($sp)
/* 800ADF30 00c23023 */  subu     $a2,$a2,$v0
/* 800ADF34 00651823 */  subu     $v1,$v1,$a1
/* 800ADF38 afa600dc */  sw       $a2,220($sp)
/* 800ADF3C 0c027939 */  jal      func_8009E4E4
/* 800ADF40 afa300e0 */  sw       $v1,224($sp)
/* 800ADF44 8fa400d8 */  lw       $a0,216($sp)
/* 800ADF48 8ea500f0 */  lw       $a1,240($s5)
/* 800ADF4C 0c0393c0 */  jal      func_800E4F00
/* 800ADF50 00000000 */  nop      
/* 800ADF54 8fa400dc */  lw       $a0,220($sp)
/* 800ADF58 8ea500f4 */  lw       $a1,244($s5)
/* 800ADF5C 0c0393c0 */  jal      func_800E4F00
/* 800ADF60 00408021 */  move     $s0,$v0
/* 800ADF64 8fa400e0 */  lw       $a0,224($sp)
/* 800ADF68 8ea500f8 */  lw       $a1,248($s5)
/* 800ADF6C 0c0393c0 */  jal      func_800E4F00
/* 800ADF70 00408821 */  move     $s1,$v0
/* 800ADF74 02118021 */  addu     $s0,$s0,$s1
/* 800ADF78 02021021 */  addu     $v0,$s0,$v0
/* 800ADF7C 04410003 */  bgez     $v0,.L800ADF8C
/* 800ADF80 00028203 */  sra      $s0,$v0,0x8
/* 800ADF84 244200ff */  addiu    $v0,$v0,255
/* 800ADF88 00028203 */  sra      $s0,$v0,0x8
.L800ADF8C:
/* 800ADF8C 2a020080 */  slti     $v0,$s0,128
/* 800ADF90 14400003 */  bnez     $v0,.L800ADFA0
/* 800ADF94 aeb0045c */  sw       $s0,1116($s5)
/* 800ADF98 0802b7eb */  j        .L800ADFAC
/* 800ADF9C 2402007f */  li       $v0,127
.L800ADFA0:
/* 800ADFA0 2a02ff81 */  slti     $v0,$s0,-127
/* 800ADFA4 10400002 */  beqz     $v0,.L800ADFB0
/* 800ADFA8 2402ff81 */  li       $v0,-127
.L800ADFAC:
/* 800ADFAC aea2045c */  sw       $v0,1116($s5)
.L800ADFB0:
/* 800ADFB0 3c028011 */  lui      $v0,0x8011
/* 800ADFB4 8c424508 */  lw       $v0,17672($v0)
/* 800ADFB8 00000000 */  nop      
/* 800ADFBC 30420008 */  andi     $v0,$v0,0x8
/* 800ADFC0 1440001f */  bnez     $v0,.L800AE040
/* 800ADFC4 00000000 */  nop      
/* 800ADFC8 92a2043f */  lbu      $v0,1087($s5)
/* 800ADFCC 00000000 */  nop      
/* 800ADFD0 10400009 */  beqz     $v0,.L800ADFF8
/* 800ADFD4 00000000 */  nop      
/* 800ADFD8 8ea20478 */  lw       $v0,1144($s5)
/* 800ADFDC 00000000 */  nop      
/* 800ADFE0 04410002 */  bgez     $v0,.L800ADFEC
/* 800ADFE4 00000000 */  nop      
/* 800ADFE8 00021023 */  negu     $v0,$v0
.L800ADFEC:
/* 800ADFEC 2842199a */  slti     $v0,$v0,6554
/* 800ADFF0 14400013 */  bnez     $v0,.L800AE040
/* 800ADFF4 00000000 */  nop      
.L800ADFF8:
/* 800ADFF8 8ea20464 */  lw       $v0,1124($s5)
/* 800ADFFC 8ea500ac */  lw       $a1,172($s5)
/* 800AE000 8c440158 */  lw       $a0,344($v0)
/* 800AE004 0c0393c0 */  jal      func_800E4F00
/* 800AE008 00000000 */  nop      
/* 800AE00C 8ea500b0 */  lw       $a1,176($s5)
/* 800AE010 8ea30464 */  lw       $v1,1124($s5)
/* 800AE014 aea200ac */  sw       $v0,172($s5)
/* 800AE018 8c640158 */  lw       $a0,344($v1)
/* 800AE01C 0c0393c0 */  jal      func_800E4F00
/* 800AE020 00000000 */  nop      
/* 800AE024 8ea500b4 */  lw       $a1,180($s5)
/* 800AE028 8ea30464 */  lw       $v1,1124($s5)
/* 800AE02C aea200b0 */  sw       $v0,176($s5)
/* 800AE030 8c640158 */  lw       $a0,344($v1)
/* 800AE034 0c0393c0 */  jal      func_800E4F00
/* 800AE038 00000000 */  nop      
/* 800AE03C aea200b4 */  sw       $v0,180($s5)
.L800AE040:
/* 800AE040 8ea301c0 */  lw       $v1,448($s5)
/* 800AE044 24020003 */  li       $v0,3
/* 800AE048 14620010 */  bne      $v1,$v0,.L800AE08C
/* 800AE04C 3c02002c */  lui      $v0,0x2c
/* 800AE050 8ea300c0 */  lw       $v1,192($s5)
/* 800AE054 3442a3d7 */  ori      $v0,$v0,0xa3d7
/* 800AE058 0043102a */  slt      $v0,$v0,$v1
/* 800AE05C 1040000b */  beqz     $v0,.L800AE08C
/* 800AE060 00000000 */  nop      
/* 800AE064 8ea500ac */  lw       $a1,172($s5)
/* 800AE068 0c0393c0 */  jal      func_800E4F00
/* 800AE06C 3404feb8 */  li       $a0,0xfeb8
/* 800AE070 8ea500b0 */  lw       $a1,176($s5)
/* 800AE074 3404feb8 */  li       $a0,0xfeb8
/* 800AE078 0c0393c0 */  jal      func_800E4F00
/* 800AE07C aea200ac */  sw       $v0,172($s5)
/* 800AE080 8ea500b4 */  lw       $a1,180($s5)
/* 800AE084 0802b86b */  j        .L800AE1AC
/* 800AE088 3404feb8 */  li       $a0,0xfeb8
.L800AE08C:
/* 800AE08C 92a30442 */  lbu      $v1,1090($s5)
/* 800AE090 24020001 */  li       $v0,1
/* 800AE094 14620033 */  bne      $v1,$v0,.L800AE164
/* 800AE098 3c028011 */  lui      $v0,0x8011
/* 800AE09C 8c4378c0 */  lw       $v1,30912($v0)
/* 800AE0A0 24027fff */  li       $v0,32767
/* 800AE0A4 04610002 */  bgez     $v1,.L800AE0B0
/* 800AE0A8 00000000 */  nop      
/* 800AE0AC 00031823 */  negu     $v1,$v1
.L800AE0B0:
/* 800AE0B0 0043102a */  slt      $v0,$v0,$v1
/* 800AE0B4 1440002b */  bnez     $v0,.L800AE164
/* 800AE0B8 3c030013 */  lui      $v1,0x13
/* 800AE0BC 8ea20420 */  lw       $v0,1056($s5)
/* 800AE0C0 3463ffff */  ori      $v1,$v1,0xffff
/* 800AE0C4 04410002 */  bgez     $v0,.L800AE0D0
/* 800AE0C8 00000000 */  nop      
/* 800AE0CC 00021023 */  negu     $v0,$v0
.L800AE0D0:
/* 800AE0D0 0062182a */  slt      $v1,$v1,$v0
/* 800AE0D4 1060000a */  beqz     $v1,.L800AE100
/* 800AE0D8 3410fd70 */  li       $s0,0xfd70
/* 800AE0DC 8ea20450 */  lw       $v0,1104($s5)
/* 800AE0E0 00000000 */  nop      
/* 800AE0E4 04410002 */  bgez     $v0,.L800AE0F0
/* 800AE0E8 00000000 */  nop      
/* 800AE0EC 00021023 */  negu     $v0,$v0
.L800AE0F0:
/* 800AE0F0 28420021 */  slti     $v0,$v0,33
/* 800AE0F4 14400002 */  bnez     $v0,.L800AE100
/* 800AE0F8 3410ff7c */  li       $s0,0xff7c
/* 800AE0FC 3410fd70 */  li       $s0,0xfd70
.L800AE100:
/* 800AE100 8ea500ac */  lw       $a1,172($s5)
/* 800AE104 0c0393c0 */  jal      func_800E4F00
/* 800AE108 02002021 */  move     $a0,$s0
/* 800AE10C 8ea500b0 */  lw       $a1,176($s5)
/* 800AE110 02002021 */  move     $a0,$s0
/* 800AE114 0c0393c0 */  jal      func_800E4F00
/* 800AE118 aea200ac */  sw       $v0,172($s5)
/* 800AE11C 8ea500b4 */  lw       $a1,180($s5)
/* 800AE120 02002021 */  move     $a0,$s0
/* 800AE124 0c0393c0 */  jal      func_800E4F00
/* 800AE128 aea200b0 */  sw       $v0,176($s5)
/* 800AE12C 8ea50114 */  lw       $a1,276($s5)
/* 800AE130 02002021 */  move     $a0,$s0
/* 800AE134 0c0393c0 */  jal      func_800E4F00
/* 800AE138 aea200b4 */  sw       $v0,180($s5)
/* 800AE13C 8ea50118 */  lw       $a1,280($s5)
/* 800AE140 02002021 */  move     $a0,$s0
/* 800AE144 0c0393c0 */  jal      func_800E4F00
/* 800AE148 aea20114 */  sw       $v0,276($s5)
/* 800AE14C 8ea5011c */  lw       $a1,284($s5)
/* 800AE150 02002021 */  move     $a0,$s0
/* 800AE154 0c0393c0 */  jal      func_800E4F00
/* 800AE158 aea20118 */  sw       $v0,280($s5)
/* 800AE15C 0802b86e */  j        .L800AE1B8
/* 800AE160 aea2011c */  sw       $v0,284($s5)
.L800AE164:
/* 800AE164 92a20445 */  lbu      $v0,1093($s5)
/* 800AE168 00000000 */  nop      
/* 800AE16C 10400012 */  beqz     $v0,.L800AE1B8
/* 800AE170 3402ffff */  li       $v0,0xffff
/* 800AE174 8ea300c0 */  lw       $v1,192($s5)
/* 800AE178 00000000 */  nop      
/* 800AE17C 0043102a */  slt      $v0,$v0,$v1
/* 800AE180 1440000d */  bnez     $v0,.L800AE1B8
/* 800AE184 00000000 */  nop      
/* 800AE188 8ea500ac */  lw       $a1,172($s5)
/* 800AE18C 0c0393c0 */  jal      func_800E4F00
/* 800AE190 34048000 */  li       $a0,0x8000
/* 800AE194 8ea500b0 */  lw       $a1,176($s5)
/* 800AE198 34048000 */  li       $a0,0x8000
/* 800AE19C 0c0393c0 */  jal      func_800E4F00
/* 800AE1A0 aea200ac */  sw       $v0,172($s5)
/* 800AE1A4 8ea500b4 */  lw       $a1,180($s5)
/* 800AE1A8 34048000 */  li       $a0,0x8000
.L800AE1AC:
/* 800AE1AC 0c0393c0 */  jal      func_800E4F00
/* 800AE1B0 aea200b0 */  sw       $v0,176($s5)
/* 800AE1B4 aea200b4 */  sw       $v0,180($s5)
.L800AE1B8:
/* 800AE1B8 8fbf0114 */  lw       $ra,276($sp)
/* 800AE1BC 8fb60110 */  lw       $s6,272($sp)
/* 800AE1C0 8fb5010c */  lw       $s5,268($sp)
/* 800AE1C4 8fb40108 */  lw       $s4,264($sp)
/* 800AE1C8 8fb30104 */  lw       $s3,260($sp)
/* 800AE1CC 8fb20100 */  lw       $s2,256($sp)
/* 800AE1D0 8fb100fc */  lw       $s1,252($sp)
/* 800AE1D4 8fb000f8 */  lw       $s0,248($sp)
/* 800AE1D8 03e00008 */  jr       $ra
/* 800AE1DC 27bd0118 */  addiu    $sp,$sp,280
