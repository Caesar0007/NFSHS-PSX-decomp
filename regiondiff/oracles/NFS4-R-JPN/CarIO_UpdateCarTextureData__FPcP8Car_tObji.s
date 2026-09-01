.set noat
.set noreorder

glabel func_800BDA58
/* 800BDA58 27bdff98 */  addiu    $sp,$sp,-104
/* 800BDA5C afbf0064 */  sw       $ra,100($sp)
/* 800BDA60 afbe0060 */  sw       $s8,96($sp)
/* 800BDA64 afb7005c */  sw       $s7,92($sp)
/* 800BDA68 afb60058 */  sw       $s6,88($sp)
/* 800BDA6C afb50054 */  sw       $s5,84($sp)
/* 800BDA70 afb40050 */  sw       $s4,80($sp)
/* 800BDA74 afb3004c */  sw       $s3,76($sp)
/* 800BDA78 afb20048 */  sw       $s2,72($sp)
/* 800BDA7C afb10044 */  sw       $s1,68($sp)
/* 800BDA80 afb00040 */  sw       $s0,64($sp)
/* 800BDA84 afa40068 */  sw       $a0,104($sp)
/* 800BDA88 afa5006c */  sw       $a1,108($sp)
/* 800BDA8C 8ca80844 */  lw       $t0,2116($a1)
/* 800BDA90 3c028014 */  lui      $v0,0x8014
/* 800BDA94 8c42e3f4 */  lw       $v0,-7180($v0)
/* 800BDA98 afa8002c */  sw       $t0,44($sp)
/* 800BDA9C 84a808bc */  lh       $t0,2236($a1)
/* 800BDAA0 00000000 */  nop      
/* 800BDAA4 afa80020 */  sw       $t0,32($sp)
/* 800BDAA8 84a808c4 */  lh       $t0,2244($a1)
/* 800BDAAC 00c08021 */  move     $s0,$a2
/* 800BDAB0 afa80024 */  sw       $t0,36($sp)
/* 800BDAB4 84a808c6 */  lh       $t0,2246($a1)
/* 800BDAB8 241e0008 */  li       $s8,8
/* 800BDABC 14400002 */  bnez     $v0,.L800BDAC8
/* 800BDAC0 afa80028 */  sw       $t0,40($sp)
/* 800BDAC4 241e0018 */  li       $s8,24
.L800BDAC8:
/* 800BDAC8 8fa8006c */  lw       $t0,108($sp)
/* 800BDACC 00000000 */  nop      
/* 800BDAD0 8d020884 */  lw       $v0,2180($t0)
/* 800BDAD4 8fa8002c */  lw       $t0,44($sp)
/* 800BDAD8 0000b021 */  move     $s6,$zero
/* 800BDADC 3c018014 */  lui      $at,0x8014
/* 800BDAE0 ac22ebd8 */  sw       $v0,-5160($at)
/* 800BDAE4 0c03801c */  jal      func_800E0070
/* 800BDAE8 0008a900 */  sll      $s5,$t0,0x4
/* 800BDAEC 3c038012 */  lui      $v1,0x8012
/* 800BDAF0 2463fbbc */  addiu    $v1,$v1,-1092
/* 800BDAF4 8fa80020 */  lw       $t0,32($sp)
/* 800BDAF8 00108080 */  sll      $s0,$s0,0x2
/* 800BDAFC afb00038 */  sw       $s0,56($sp)
/* 800BDB00 00081040 */  sll      $v0,$t0,0x1
/* 800BDB04 00481021 */  addu     $v0,$v0,$t0
/* 800BDB08 00021080 */  sll      $v0,$v0,0x2
/* 800BDB0C 00439021 */  addu     $s2,$v0,$v1
/* 800BDB10 3c028012 */  lui      $v0,0x8012
/* 800BDB14 8fa8006c */  lw       $t0,108($sp)
/* 800BDB18 2457f8e0 */  addiu    $s7,$v0,-1824
.L800BDB1C:
/* 800BDB1C 2ac20033 */  slti     $v0,$s6,51
/* 800BDB20 104000f1 */  beqz     $v0,.L800BDEE8
/* 800BDB24 afa8003c */  sw       $t0,60($sp)
/* 800BDB28 8fa40068 */  lw       $a0,104($sp)
/* 800BDB2C 8ee50004 */  lw       $a1,4($s7)
/* 800BDB30 24080001 */  li       $t0,1
/* 800BDB34 0c03ae2e */  jal      func_800EB8B8
/* 800BDB38 afa80034 */  sw       $t0,52($sp)
/* 800BDB3C 8ee80008 */  lw       $t0,8($s7)
/* 800BDB40 00408821 */  move     $s1,$v0
/* 800BDB44 16200009 */  bnez     $s1,.L800BDB6C
/* 800BDB48 afa80030 */  sw       $t0,48($sp)
/* 800BDB4C 15000008 */  bnez     $t0,.L800BDB70
/* 800BDB50 24020014 */  li       $v0,20
/* 800BDB54 afa00034 */  sw       $zero,52($sp)
/* 800BDB58 8ee50000 */  lw       $a1,0($s7)
/* 800BDB5C 8fa40068 */  lw       $a0,104($sp)
/* 800BDB60 0c03ae2e */  jal      func_800EB8B8
/* 800BDB64 00000000 */  nop      
/* 800BDB68 00408821 */  move     $s1,$v0
.L800BDB6C:
/* 800BDB6C 24020014 */  li       $v0,20
.L800BDB70:
/* 800BDB70 16c20002 */  bne      $s6,$v0,.L800BDB7C
/* 800BDB74 00000000 */  nop      
/* 800BDB78 0000f021 */  move     $s8,$zero
.L800BDB7C:
/* 800BDB7C 1220005f */  beqz     $s1,.L800BDCFC
/* 800BDB80 00000000 */  nop      
/* 800BDB84 8f8211c8 */  lw       $v0,4552($gp)
/* 800BDB88 00000000 */  nop      
/* 800BDB8C 02a22821 */  addu     $a1,$s5,$v0
/* 800BDB90 94a2000e */  lhu      $v0,14($a1)
/* 800BDB94 00000000 */  nop      
/* 800BDB98 30420080 */  andi     $v0,$v0,0x80
/* 800BDB9C 104000c9 */  beqz     $v0,.L800BDEC4
/* 800BDBA0 00008021 */  move     $s0,$zero
/* 800BDBA4 94a30002 */  lhu      $v1,2($a1)
/* 800BDBA8 00000000 */  nop      
/* 800BDBAC 3062003f */  andi     $v0,$v1,0x3f
/* 800BDBB0 0003a182 */  srl      $s4,$v1,0x6
/* 800BDBB4 96430000 */  lhu      $v1,0($s2)
/* 800BDBB8 13c00006 */  beqz     $s8,.L800BDBD4
/* 800BDBBC 00029900 */  sll      $s3,$v0,0x4
/* 800BDBC0 8fa8003c */  lw       $t0,60($sp)
/* 800BDBC4 00000000 */  nop      
/* 800BDBC8 8502088a */  lh       $v0,2186($t0)
/* 800BDBCC 3c018014 */  lui      $at,0x8014
/* 800BDBD0 ac22ebdc */  sw       $v0,-5156($at)
.L800BDBD4:
/* 800BDBD4 8fa80020 */  lw       $t0,32($sp)
/* 800BDBD8 00000000 */  nop      
/* 800BDBDC 29020016 */  slti     $v0,$t0,22
/* 800BDBE0 10400029 */  beqz     $v0,.L800BDC88
/* 800BDBE4 00031400 */  sll      $v0,$v1,0x10
/* 800BDBE8 00021403 */  sra      $v0,$v0,0x10
/* 800BDBEC 04400026 */  bltz     $v0,.L800BDC88
/* 800BDBF0 00000000 */  nop      
/* 800BDBF4 16c2000f */  bne      $s6,$v0,.L800BDC34
/* 800BDBF8 00002021 */  move     $a0,$zero
/* 800BDBFC 24100001 */  li       $s0,1
/* 800BDC00 86420004 */  lh       $v0,4($s2)
/* 800BDC04 8fa80028 */  lw       $t0,40($sp)
/* 800BDC08 86470002 */  lh       $a3,2($s2)
/* 800BDC0C 01021021 */  addu     $v0,$t0,$v0
/* 800BDC10 8fa80038 */  lw       $t0,56($sp)
/* 800BDC14 afb30014 */  sw       $s3,20($sp)
/* 800BDC18 afb40018 */  sw       $s4,24($sp)
/* 800BDC1C afa5001c */  sw       $a1,28($sp)
/* 800BDC20 afa20010 */  sw       $v0,16($sp)
/* 800BDC24 3c028014 */  lui      $v0,0x8014
/* 800BDC28 2442e81c */  addiu    $v0,$v0,-6116
/* 800BDC2C 0802f71d */  j        .L800BDC74
/* 800BDC30 03c03021 */  move     $a2,$s8
.L800BDC34:
/* 800BDC34 86420006 */  lh       $v0,6($s2)
/* 800BDC38 00000000 */  nop      
/* 800BDC3C 16c20012 */  bne      $s6,$v0,.L800BDC88
/* 800BDC40 03c03021 */  move     $a2,$s8
/* 800BDC44 24100001 */  li       $s0,1
/* 800BDC48 8642000a */  lh       $v0,10($s2)
/* 800BDC4C 8fa80028 */  lw       $t0,40($sp)
/* 800BDC50 86470008 */  lh       $a3,8($s2)
/* 800BDC54 01021021 */  addu     $v0,$t0,$v0
/* 800BDC58 8fa80038 */  lw       $t0,56($sp)
/* 800BDC5C afb30014 */  sw       $s3,20($sp)
/* 800BDC60 afb40018 */  sw       $s4,24($sp)
/* 800BDC64 afa5001c */  sw       $a1,28($sp)
/* 800BDC68 afa20010 */  sw       $v0,16($sp)
/* 800BDC6C 3c028014 */  lui      $v0,0x8014
/* 800BDC70 2442e824 */  addiu    $v0,$v0,-6108
.L800BDC74:
/* 800BDC74 01021021 */  addu     $v0,$t0,$v0
/* 800BDC78 8fa80024 */  lw       $t0,36($sp)
/* 800BDC7C 8c450000 */  lw       $a1,0($v0)
/* 800BDC80 0c038244 */  jal      func_800E0910
/* 800BDC84 01073821 */  addu     $a3,$t0,$a3
.L800BDC88:
/* 800BDC88 1600000e */  bnez     $s0,.L800BDCC4
/* 800BDC8C 24020020 */  li       $v0,32
/* 800BDC90 00002021 */  move     $a0,$zero
/* 800BDC94 02202821 */  move     $a1,$s1
/* 800BDC98 8f8211c8 */  lw       $v0,4552($gp)
/* 800BDC9C 8fa70024 */  lw       $a3,36($sp)
/* 800BDCA0 8fa80028 */  lw       $t0,40($sp)
/* 800BDCA4 03c03021 */  move     $a2,$s8
/* 800BDCA8 afb30014 */  sw       $s3,20($sp)
/* 800BDCAC afb40018 */  sw       $s4,24($sp)
/* 800BDCB0 00551021 */  addu     $v0,$v0,$s5
/* 800BDCB4 afa80010 */  sw       $t0,16($sp)
/* 800BDCB8 0c038244 */  jal      func_800E0910
/* 800BDCBC afa2001c */  sw       $v0,28($sp)
/* 800BDCC0 24020020 */  li       $v0,32
.L800BDCC4:
/* 800BDCC4 16c20006 */  bne      $s6,$v0,.L800BDCE0
/* 800BDCC8 24050002 */  li       $a1,2
/* 800BDCCC 8f8411c8 */  lw       $a0,4552($gp)
/* 800BDCD0 00000000 */  nop      
/* 800BDCD4 00952021 */  addu     $a0,$a0,$s5
/* 800BDCD8 0c02fc90 */  jal      func_800BF240
/* 800BDCDC 24840006 */  addiu    $a0,$a0,6
.L800BDCE0:
/* 800BDCE0 8f8311c8 */  lw       $v1,4552($gp)
/* 800BDCE4 00000000 */  nop      
/* 800BDCE8 02a31821 */  addu     $v1,$s5,$v1
/* 800BDCEC 9462000e */  lhu      $v0,14($v1)
/* 800BDCF0 00000000 */  nop      
/* 800BDCF4 34420080 */  ori      $v0,$v0,0x80
/* 800BDCF8 a462000e */  sh       $v0,14($v1)
.L800BDCFC:
/* 800BDCFC 8fa80034 */  lw       $t0,52($sp)
/* 800BDD00 00000000 */  nop      
/* 800BDD04 1100006f */  beqz     $t0,.L800BDEC4
/* 800BDD08 00000000 */  nop      
/* 800BDD0C 8fa80030 */  lw       $t0,48($sp)
/* 800BDD10 8fb0002c */  lw       $s0,44($sp)
/* 800BDD14 1100000f */  beqz     $t0,.L800BDD54
/* 800BDD18 00000000 */  nop      
/* 800BDD1C 13c00008 */  beqz     $s8,.L800BDD40
/* 800BDD20 2510ffff */  addiu    $s0,$t0,-1
/* 800BDD24 8fa8006c */  lw       $t0,108($sp)
/* 800BDD28 00101040 */  sll      $v0,$s0,0x1
/* 800BDD2C 01021021 */  addu     $v0,$t0,$v0
/* 800BDD30 9442088a */  lhu      $v0,2186($v0)
/* 800BDD34 8fa8003c */  lw       $t0,60($sp)
/* 800BDD38 00000000 */  nop      
/* 800BDD3C a502088a */  sh       $v0,2186($t0)
.L800BDD40:
/* 800BDD40 8fa8006c */  lw       $t0,108($sp)
/* 800BDD44 00000000 */  nop      
/* 800BDD48 8d020844 */  lw       $v0,2116($t0)
/* 800BDD4C 00000000 */  nop      
/* 800BDD50 02028021 */  addu     $s0,$s0,$v0
.L800BDD54:
/* 800BDD54 8ee50000 */  lw       $a1,0($s7)
/* 800BDD58 8fa40068 */  lw       $a0,104($sp)
/* 800BDD5C 0c03ae2e */  jal      func_800EB8B8
/* 800BDD60 00000000 */  nop      
/* 800BDD64 00408821 */  move     $s1,$v0
/* 800BDD68 12200056 */  beqz     $s1,.L800BDEC4
/* 800BDD6C 00101100 */  sll      $v0,$s0,0x4
/* 800BDD70 8f8511c8 */  lw       $a1,4552($gp)
/* 800BDD74 00000000 */  nop      
/* 800BDD78 00451021 */  addu     $v0,$v0,$a1
/* 800BDD7C 94430002 */  lhu      $v1,2($v0)
/* 800BDD80 8fa80020 */  lw       $t0,32($sp)
/* 800BDD84 3062003f */  andi     $v0,$v1,0x3f
/* 800BDD88 00029900 */  sll      $s3,$v0,0x4
/* 800BDD8C 0003a182 */  srl      $s4,$v1,0x6
/* 800BDD90 29020016 */  slti     $v0,$t0,22
/* 800BDD94 96430000 */  lhu      $v1,0($s2)
/* 800BDD98 10400029 */  beqz     $v0,.L800BDE40
/* 800BDD9C 00008021 */  move     $s0,$zero
/* 800BDDA0 00031400 */  sll      $v0,$v1,0x10
/* 800BDDA4 00021403 */  sra      $v0,$v0,0x10
/* 800BDDA8 04400025 */  bltz     $v0,.L800BDE40
/* 800BDDAC 00000000 */  nop      
/* 800BDDB0 16c2000d */  bne      $s6,$v0,.L800BDDE8
/* 800BDDB4 00002021 */  move     $a0,$zero
/* 800BDDB8 24100001 */  li       $s0,1
/* 800BDDBC 86470002 */  lh       $a3,2($s2)
/* 800BDDC0 86430004 */  lh       $v1,4($s2)
/* 800BDDC4 8fa80028 */  lw       $t0,40($sp)
/* 800BDDC8 00b51021 */  addu     $v0,$a1,$s5
/* 800BDDCC afa2001c */  sw       $v0,28($sp)
/* 800BDDD0 01031821 */  addu     $v1,$t0,$v1
/* 800BDDD4 8fa80038 */  lw       $t0,56($sp)
/* 800BDDD8 3c028014 */  lui      $v0,0x8014
/* 800BDDDC 2442e81c */  addiu    $v0,$v0,-6116
/* 800BDDE0 0802f788 */  j        .L800BDE20
/* 800BDDE4 24060020 */  li       $a2,32
.L800BDDE8:
/* 800BDDE8 86420006 */  lh       $v0,6($s2)
/* 800BDDEC 00000000 */  nop      
/* 800BDDF0 16c20013 */  bne      $s6,$v0,.L800BDE40
/* 800BDDF4 24060020 */  li       $a2,32
/* 800BDDF8 24100001 */  li       $s0,1
/* 800BDDFC 86470008 */  lh       $a3,8($s2)
/* 800BDE00 8643000a */  lh       $v1,10($s2)
/* 800BDE04 8fa80028 */  lw       $t0,40($sp)
/* 800BDE08 00b51021 */  addu     $v0,$a1,$s5
/* 800BDE0C afa2001c */  sw       $v0,28($sp)
/* 800BDE10 01031821 */  addu     $v1,$t0,$v1
/* 800BDE14 8fa80038 */  lw       $t0,56($sp)
/* 800BDE18 3c028014 */  lui      $v0,0x8014
/* 800BDE1C 2442e824 */  addiu    $v0,$v0,-6108
.L800BDE20:
/* 800BDE20 afb30014 */  sw       $s3,20($sp)
/* 800BDE24 afb40018 */  sw       $s4,24($sp)
/* 800BDE28 afa30010 */  sw       $v1,16($sp)
/* 800BDE2C 01021021 */  addu     $v0,$t0,$v0
/* 800BDE30 8fa80024 */  lw       $t0,36($sp)
/* 800BDE34 8c450000 */  lw       $a1,0($v0)
/* 800BDE38 0c038244 */  jal      func_800E0910
/* 800BDE3C 01073821 */  addu     $a3,$t0,$a3
.L800BDE40:
/* 800BDE40 1600000e */  bnez     $s0,.L800BDE7C
/* 800BDE44 24020020 */  li       $v0,32
/* 800BDE48 00002021 */  move     $a0,$zero
/* 800BDE4C 02202821 */  move     $a1,$s1
/* 800BDE50 8f8211c8 */  lw       $v0,4552($gp)
/* 800BDE54 8fa70024 */  lw       $a3,36($sp)
/* 800BDE58 8fa80028 */  lw       $t0,40($sp)
/* 800BDE5C 24060020 */  li       $a2,32
/* 800BDE60 afb30014 */  sw       $s3,20($sp)
/* 800BDE64 afb40018 */  sw       $s4,24($sp)
/* 800BDE68 00551021 */  addu     $v0,$v0,$s5
/* 800BDE6C afa80010 */  sw       $t0,16($sp)
/* 800BDE70 0c038244 */  jal      func_800E0910
/* 800BDE74 afa2001c */  sw       $v0,28($sp)
/* 800BDE78 24020020 */  li       $v0,32
.L800BDE7C:
/* 800BDE7C 16c20006 */  bne      $s6,$v0,.L800BDE98
/* 800BDE80 24050002 */  li       $a1,2
/* 800BDE84 8f8411c8 */  lw       $a0,4552($gp)
/* 800BDE88 00000000 */  nop      
/* 800BDE8C 00952021 */  addu     $a0,$a0,$s5
/* 800BDE90 0c02fc90 */  jal      func_800BF240
/* 800BDE94 24840006 */  addiu    $a0,$a0,6
.L800BDE98:
/* 800BDE98 8fa80030 */  lw       $t0,48($sp)
/* 800BDE9C 00000000 */  nop      
/* 800BDEA0 15000008 */  bnez     $t0,.L800BDEC4
/* 800BDEA4 00000000 */  nop      
/* 800BDEA8 8f8311c8 */  lw       $v1,4552($gp)
/* 800BDEAC 00000000 */  nop      
/* 800BDEB0 02a31821 */  addu     $v1,$s5,$v1
/* 800BDEB4 9462000e */  lhu      $v0,14($v1)
/* 800BDEB8 00000000 */  nop      
/* 800BDEBC 34420080 */  ori      $v0,$v0,0x80
/* 800BDEC0 a462000e */  sh       $v0,14($v1)
.L800BDEC4:
/* 800BDEC4 26b50010 */  addiu    $s5,$s5,16
/* 800BDEC8 8fa8002c */  lw       $t0,44($sp)
/* 800BDECC 26f7000c */  addiu    $s7,$s7,12
/* 800BDED0 25080001 */  addiu    $t0,$t0,1
/* 800BDED4 afa8002c */  sw       $t0,44($sp)
/* 800BDED8 8fa8003c */  lw       $t0,60($sp)
/* 800BDEDC 26d60001 */  addiu    $s6,$s6,1
/* 800BDEE0 0802f6c7 */  j        .L800BDB1C
/* 800BDEE4 25080002 */  addiu    $t0,$t0,2
.L800BDEE8:
/* 800BDEE8 8fbf0064 */  lw       $ra,100($sp)
/* 800BDEEC 8fbe0060 */  lw       $s8,96($sp)
/* 800BDEF0 8fb7005c */  lw       $s7,92($sp)
/* 800BDEF4 8fb60058 */  lw       $s6,88($sp)
/* 800BDEF8 8fb50054 */  lw       $s5,84($sp)
/* 800BDEFC 8fb40050 */  lw       $s4,80($sp)
/* 800BDF00 8fb3004c */  lw       $s3,76($sp)
/* 800BDF04 8fb20048 */  lw       $s2,72($sp)
/* 800BDF08 8fb10044 */  lw       $s1,68($sp)
/* 800BDF0C 8fb00040 */  lw       $s0,64($sp)
/* 800BDF10 03e00008 */  jr       $ra
/* 800BDF14 27bd0068 */  addiu    $sp,$sp,104
