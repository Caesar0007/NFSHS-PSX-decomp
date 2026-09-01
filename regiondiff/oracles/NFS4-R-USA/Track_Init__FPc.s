.set noat
.set noreorder

glabel func_800BB5B4
/* 800BB5B4 27bdff48 */  addiu    $sp,$sp,-184
/* 800BB5B8 afb00090 */  sw       $s0,144($sp)
/* 800BB5BC 00808021 */  move     $s0,$a0
/* 800BB5C0 27a40010 */  addiu    $a0,$sp,16
/* 800BB5C4 3c058014 */  lui      $a1,0x8014
/* 800BB5C8 24a5e774 */  addiu    $a1,$a1,-6284
/* 800BB5CC afbf00b0 */  sw       $ra,176($sp)
/* 800BB5D0 afb700ac */  sw       $s7,172($sp)
/* 800BB5D4 afb600a8 */  sw       $s6,168($sp)
/* 800BB5D8 afb500a4 */  sw       $s5,164($sp)
/* 800BB5DC afb400a0 */  sw       $s4,160($sp)
/* 800BB5E0 afb3009c */  sw       $s3,156($sp)
/* 800BB5E4 afb20098 */  sw       $s2,152($sp)
/* 800BB5E8 afb10094 */  sw       $s1,148($sp)
/* 800BB5EC af800f74 */  sw       $zero,3956($gp)
/* 800BB5F0 af800f80 */  sw       $zero,3968($gp)
/* 800BB5F4 af800f7c */  sw       $zero,3964($gp)
/* 800BB5F8 0c03942a */  jal      func_800E50A8
/* 800BB5FC 02003021 */  move     $a2,$s0
/* 800BB600 0c039896 */  jal      func_800E6258
/* 800BB604 02002021 */  move     $a0,$s0
/* 800BB608 3c048005 */  lui      $a0,0x8005
/* 800BB60C 24846e1c */  addiu    $a0,$a0,28188
/* 800BB610 24050404 */  li       $a1,1028
/* 800BB614 00003021 */  move     $a2,$zero
/* 800BB618 0c0397ca */  jal      func_800E5F28
/* 800BB61C 00409021 */  move     $s2,$v0
/* 800BB620 3c018014 */  lui      $at,0x8014
/* 800BB624 ac22db0c */  sw       $v0,-9460($at)
/* 800BB628 0c038750 */  jal      func_800E1D40
/* 800BB62C 34139080 */  li       $s3,0x9080
/* 800BB630 0c02e828 */  jal      func_800BA0A0
/* 800BB634 02538821 */  addu     $s1,$s2,$s3
/* 800BB638 0c02e93e */  jal      func_800BA4F8
/* 800BB63C 00000000 */  nop      
/* 800BB640 0c029230 */  jal      func_800A48C0
/* 800BB644 2404000c */  li       $a0,12
/* 800BB648 3c048005 */  lui      $a0,0x8005
/* 800BB64C 24846e28 */  addiu    $a0,$a0,28200
/* 800BB650 02202821 */  move     $a1,$s1
/* 800BB654 00003021 */  move     $a2,$zero
/* 800BB658 0c0397ca */  jal      func_800E5F28
/* 800BB65C 00408021 */  move     $s0,$v0
/* 800BB660 ae020000 */  sw       $v0,0($s0)
/* 800BB664 00401821 */  move     $v1,$v0
/* 800BB668 14600002 */  bnez     $v1,.L800BB674
/* 800BB66C ae020004 */  sw       $v0,4($s0)
/* 800BB670 00008821 */  move     $s1,$zero
.L800BB674:
/* 800BB674 02002021 */  move     $a0,$s0
/* 800BB678 ac910008 */  sw       $s1,8($a0)
/* 800BB67C af840f84 */  sw       $a0,3972($gp)
/* 800BB680 0c02dfdc */  jal      func_800B7F70
/* 800BB684 02402821 */  move     $a1,$s2
/* 800BB688 27a40010 */  addiu    $a0,$sp,16
/* 800BB68C 0c039937 */  jal      func_800E64DC
/* 800BB690 00532821 */  addu     $a1,$v0,$s3
/* 800BB694 00408021 */  move     $s0,$v0
/* 800BB698 02002021 */  move     $a0,$s0
/* 800BB69C 2405001f */  li       $a1,31
/* 800BB6A0 8f860f84 */  lw       $a2,3972($gp)
/* 800BB6A4 0c027332 */  jal      func_8009CCC8
/* 800BB6A8 00003821 */  move     $a3,$zero
/* 800BB6AC 02002021 */  move     $a0,$s0
/* 800BB6B0 24050020 */  li       $a1,32
/* 800BB6B4 8f860f84 */  lw       $a2,3972($gp)
/* 800BB6B8 24420004 */  addiu    $v0,$v0,4
/* 800BB6BC af820f5c */  sw       $v0,3932($gp)
/* 800BB6C0 0c027332 */  jal      func_8009CCC8
/* 800BB6C4 00003821 */  move     $a3,$zero
/* 800BB6C8 02002021 */  move     $a0,$s0
/* 800BB6CC 24050023 */  li       $a1,35
/* 800BB6D0 24420004 */  addiu    $v0,$v0,4
/* 800BB6D4 3c018014 */  lui      $at,0x8014
/* 800BB6D8 ac22db10 */  sw       $v0,-9456($at)
/* 800BB6DC 0c027305 */  jal      func_8009CC14
/* 800BB6E0 00003021 */  move     $a2,$zero
/* 800BB6E4 00402821 */  move     $a1,$v0
/* 800BB6E8 3c048014 */  lui      $a0,0x8014
/* 800BB6EC 8c84db0c */  lw       $a0,-9460($a0)
/* 800BB6F0 24a30010 */  addiu    $v1,$a1,16
/* 800BB6F4 00641025 */  or       $v0,$v1,$a0
/* 800BB6F8 30420003 */  andi     $v0,$v0,0x3
/* 800BB6FC 10400016 */  beqz     $v0,.L800BB758
/* 800BB700 24a20410 */  addiu    $v0,$a1,1040
.L800BB704:
/* 800BB704 886b0003 */  lwl      $t3,3($v1)
/* 800BB708 986b0000 */  lwr      $t3,0($v1)
/* 800BB70C 886c0007 */  lwl      $t4,7($v1)
/* 800BB710 986c0004 */  lwr      $t4,4($v1)
/* 800BB714 886d000b */  lwl      $t5,11($v1)
/* 800BB718 986d0008 */  lwr      $t5,8($v1)
/* 800BB71C 886e000f */  lwl      $t6,15($v1)
/* 800BB720 986e000c */  lwr      $t6,12($v1)
/* 800BB724 a88b0003 */  swl      $t3,3($a0)
/* 800BB728 b88b0000 */  swr      $t3,0($a0)
/* 800BB72C a88c0007 */  swl      $t4,7($a0)
/* 800BB730 b88c0004 */  swr      $t4,4($a0)
/* 800BB734 a88d000b */  swl      $t5,11($a0)
/* 800BB738 b88d0008 */  swr      $t5,8($a0)
/* 800BB73C a88e000f */  swl      $t6,15($a0)
/* 800BB740 b88e000c */  swr      $t6,12($a0)
/* 800BB744 24630010 */  addiu    $v1,$v1,16
/* 800BB748 1462ffee */  bne      $v1,$v0,.L800BB704
/* 800BB74C 24840010 */  addiu    $a0,$a0,16
/* 800BB750 0802ede2 */  j        .L800BB788
/* 800BB754 02002021 */  move     $a0,$s0
.L800BB758:
/* 800BB758 8c6b0000 */  lw       $t3,0($v1)
/* 800BB75C 8c6c0004 */  lw       $t4,4($v1)
/* 800BB760 8c6d0008 */  lw       $t5,8($v1)
/* 800BB764 8c6e000c */  lw       $t6,12($v1)
/* 800BB768 ac8b0000 */  sw       $t3,0($a0)
/* 800BB76C ac8c0004 */  sw       $t4,4($a0)
/* 800BB770 ac8d0008 */  sw       $t5,8($a0)
/* 800BB774 ac8e000c */  sw       $t6,12($a0)
/* 800BB778 24630010 */  addiu    $v1,$v1,16
/* 800BB77C 1462fff6 */  bne      $v1,$v0,.L800BB758
/* 800BB780 24840010 */  addiu    $a0,$a0,16
/* 800BB784 02002021 */  move     $a0,$s0
.L800BB788:
/* 800BB788 24050023 */  li       $a1,35
/* 800BB78C 0c027305 */  jal      func_8009CC14
/* 800BB790 00003021 */  move     $a2,$zero
/* 800BB794 00003021 */  move     $a2,$zero
/* 800BB798 00c09021 */  move     $s2,$a2
/* 800BB79C 241603ff */  li       $s6,1023
/* 800BB7A0 00c09821 */  move     $s3,$a2
/* 800BB7A4 00c0a821 */  move     $s5,$a2
/* 800BB7A8 8f840f84 */  lw       $a0,3972($gp)
/* 800BB7AC 8c420004 */  lw       $v0,4($v0)
/* 800BB7B0 8f830f5c */  lw       $v1,3932($gp)
/* 800BB7B4 2442fff0 */  addiu    $v0,$v0,-16
/* 800BB7B8 8c63001c */  lw       $v1,28($v1)
/* 800BB7BC 00021082 */  srl      $v0,$v0,0x2
/* 800BB7C0 af820f98 */  sw       $v0,3992($gp)
/* 800BB7C4 000328c0 */  sll      $a1,$v1,0x3
/* 800BB7C8 00a32821 */  addu     $a1,$a1,$v1
/* 800BB7CC 0c02dfc9 */  jal      func_800B7F24
/* 800BB7D0 000528c0 */  sll      $a1,$a1,0x3
/* 800BB7D4 8f830f5c */  lw       $v1,3932($gp)
/* 800BB7D8 8f840f84 */  lw       $a0,3972($gp)
/* 800BB7DC 8c65001c */  lw       $a1,28($v1)
/* 800BB7E0 af820f54 */  sw       $v0,3924($gp)
/* 800BB7E4 0c02dfc9 */  jal      func_800B7F24
/* 800BB7E8 00003021 */  move     $a2,$zero
/* 800BB7EC 8f830f5c */  lw       $v1,3932($gp)
/* 800BB7F0 8f840f84 */  lw       $a0,3972($gp)
/* 800BB7F4 8c63001c */  lw       $v1,28($v1)
/* 800BB7F8 00003021 */  move     $a2,$zero
/* 800BB7FC af820f58 */  sw       $v0,3928($gp)
/* 800BB800 000328c0 */  sll      $a1,$v1,0x3
/* 800BB804 00a32823 */  subu     $a1,$a1,$v1
/* 800BB808 0c02dfc9 */  jal      func_800B7F24
/* 800BB80C 00052900 */  sll      $a1,$a1,0x4
/* 800BB810 af820f60 */  sw       $v0,3936($gp)
/* 800BB814 0c023106 */  jal      func_8008C418
/* 800BB818 00000000 */  nop      
/* 800BB81C 02002021 */  move     $a0,$s0
/* 800BB820 24050021 */  li       $a1,33
/* 800BB824 0c027305 */  jal      func_8009CC14
/* 800BB828 00003021 */  move     $a2,$zero
/* 800BB82C 02002021 */  move     $a0,$s0
/* 800BB830 2405001d */  li       $a1,29
/* 800BB834 00003021 */  move     $a2,$zero
/* 800BB838 0c027305 */  jal      func_8009CC14
/* 800BB83C 0040b821 */  move     $s7,$v0
/* 800BB840 00408021 */  move     $s0,$v0
.L800BB844:
/* 800BB844 8f820f5c */  lw       $v0,3932($gp)
/* 800BB848 00000000 */  nop      
/* 800BB84C 8c43001c */  lw       $v1,28($v0)
/* 800BB850 00000000 */  nop      
/* 800BB854 0243102a */  slt      $v0,$s2,$v1
/* 800BB858 10400042 */  beqz     $v0,.L800BB964
/* 800BB85C 00000000 */  nop      
/* 800BB860 8f820f60 */  lw       $v0,3936($gp)
/* 800BB864 00000000 */  nop      
/* 800BB868 00558821 */  addu     $s1,$v0,$s5
/* 800BB86C 2462ffff */  addiu    $v0,$v1,-1
/* 800BB870 0242102a */  slt      $v0,$s2,$v0
/* 800BB874 10400005 */  beqz     $v0,.L800BB88C
/* 800BB878 0000a021 */  move     $s4,$zero
/* 800BB87C 02002021 */  move     $a0,$s0
/* 800BB880 0c0272fb */  jal      func_8009CBEC
/* 800BB884 2405001d */  li       $a1,29
/* 800BB888 0040a021 */  move     $s4,$v0
.L800BB88C:
/* 800BB88C 02202021 */  move     $a0,$s1
/* 800BB890 8f860f84 */  lw       $a2,3972($gp)
/* 800BB894 0c022fa2 */  jal      func_8008BE88
/* 800BB898 02002821 */  move     $a1,$s0
/* 800BB89C 02002021 */  move     $a0,$s0
/* 800BB8A0 24050004 */  li       $a1,4
/* 800BB8A4 0c027305 */  jal      func_8009CC14
/* 800BB8A8 00003021 */  move     $a2,$zero
/* 800BB8AC 8c49000c */  lw       $t1,12($v0)
/* 800BB8B0 24430010 */  addiu    $v1,$v0,16
/* 800BB8B4 29220025 */  slti     $v0,$t1,37
/* 800BB8B8 14400002 */  bnez     $v0,.L800BB8C4
/* 800BB8BC 00004021 */  move     $t0,$zero
/* 800BB8C0 24090024 */  li       $t1,36
.L800BB8C4:
/* 800BB8C4 19200012 */  blez     $t1,.L800BB910
/* 800BB8C8 01002821 */  move     $a1,$t0
/* 800BB8CC 00603821 */  move     $a3,$v1
/* 800BB8D0 8f820f54 */  lw       $v0,3924($gp)
/* 800BB8D4 8f8a0f5c */  lw       $t2,3932($gp)
/* 800BB8D8 02623021 */  addu     $a2,$s3,$v0
.L800BB8DC:
/* 800BB8DC 94e40000 */  lhu      $a0,0($a3)
/* 800BB8E0 8d43001c */  lw       $v1,28($t2)
/* 800BB8E4 308203ff */  andi     $v0,$a0,0x3ff
/* 800BB8E8 0043102a */  slt      $v0,$v0,$v1
/* 800BB8EC 10400004 */  beqz     $v0,.L800BB900
/* 800BB8F0 00000000 */  nop      
/* 800BB8F4 a4c40000 */  sh       $a0,0($a2)
/* 800BB8F8 24c60002 */  addiu    $a2,$a2,2
/* 800BB8FC 24a50001 */  addiu    $a1,$a1,1
.L800BB900:
/* 800BB900 25080001 */  addiu    $t0,$t0,1
/* 800BB904 0109102a */  slt      $v0,$t0,$t1
/* 800BB908 1440fff4 */  bnez     $v0,.L800BB8DC
/* 800BB90C 24e70002 */  addiu    $a3,$a3,2
.L800BB910:
/* 800BB910 8f820f58 */  lw       $v0,3928($gp)
/* 800BB914 00000000 */  nop      
/* 800BB918 00521021 */  addu     $v0,$v0,$s2
/* 800BB91C a0450000 */  sb       $a1,0($v0)
/* 800BB920 28a20024 */  slti     $v0,$a1,36
/* 800BB924 1040000a */  beqz     $v0,.L800BB950
/* 800BB928 00051840 */  sll      $v1,$a1,0x1
/* 800BB92C 8f820f54 */  lw       $v0,3924($gp)
/* 800BB930 00000000 */  nop      
/* 800BB934 02621021 */  addu     $v0,$s3,$v0
/* 800BB938 00621821 */  addu     $v1,$v1,$v0
.L800BB93C:
/* 800BB93C a4760000 */  sh       $s6,0($v1)
/* 800BB940 24a50001 */  addiu    $a1,$a1,1
/* 800BB944 28a20024 */  slti     $v0,$a1,36
/* 800BB948 1440fffc */  bnez     $v0,.L800BB93C
/* 800BB94C 24630002 */  addiu    $v1,$v1,2
.L800BB950:
/* 800BB950 02808021 */  move     $s0,$s4
/* 800BB954 26730040 */  addiu    $s3,$s3,64
/* 800BB958 26b50070 */  addiu    $s5,$s5,112
/* 800BB95C 0802ee11 */  j        .L800BB844
/* 800BB960 26520001 */  addiu    $s2,$s2,1
.L800BB964:
/* 800BB964 0c02ecf6 */  jal      func_800BB3D8
/* 800BB968 02e02021 */  move     $a0,$s7
/* 800BB96C 8f840f84 */  lw       $a0,3972($gp)
/* 800BB970 0c02dfe4 */  jal      func_800B7F90
/* 800BB974 00000000 */  nop      
/* 800BB978 3c048014 */  lui      $a0,0x8014
/* 800BB97C 0c02e7f4 */  jal      func_800B9FD0
/* 800BB980 2484e778 */  addiu    $a0,$a0,-6280
/* 800BB984 3c048014 */  lui      $a0,0x8014
/* 800BB988 8f820f64 */  lw       $v0,3940($gp)
/* 800BB98C 2484e780 */  addiu    $a0,$a0,-6272
/* 800BB990 8c450000 */  lw       $a1,0($v0)
/* 800BB994 00003021 */  move     $a2,$zero
/* 800BB998 000528c0 */  sll      $a1,$a1,0x3
/* 800BB99C 0c0397ca */  jal      func_800E5F28
/* 800BB9A0 34a50004 */  ori      $a1,$a1,0x4
/* 800BB9A4 8f840f64 */  lw       $a0,3940($gp)
/* 800BB9A8 00402821 */  move     $a1,$v0
/* 800BB9AC af850f70 */  sw       $a1,3952($gp)
/* 800BB9B0 0c02ec0c */  jal      func_800BB030
/* 800BB9B4 00000000 */  nop      
/* 800BB9B8 8f840f6c */  lw       $a0,3948($gp)
/* 800BB9BC 8f850f64 */  lw       $a1,3940($gp)
/* 800BB9C0 0c02ebc9 */  jal      func_800BAF24
/* 800BB9C4 24060002 */  li       $a2,2
/* 800BB9C8 8f840f68 */  lw       $a0,3944($gp)
/* 800BB9CC 8f850f64 */  lw       $a1,3940($gp)
/* 800BB9D0 0c02ebf1 */  jal      func_800BAFC4
/* 800BB9D4 00000000 */  nop      
/* 800BB9D8 0c029230 */  jal      func_800A48C0
/* 800BB9DC 24040008 */  li       $a0,8
/* 800BB9E0 00402021 */  move     $a0,$v0
/* 800BB9E4 0c02ef51 */  jal      func_800BBD44
/* 800BB9E8 24050030 */  li       $a1,48
/* 800BB9EC af820f74 */  sw       $v0,3956($gp)
/* 800BB9F0 0c02eee2 */  jal      func_800BBB88
/* 800BB9F4 00000000 */  nop      
/* 800BB9F8 8f840f7c */  lw       $a0,3964($gp)
/* 800BB9FC 0c029de2 */  jal      func_800A7788
/* 800BBA00 2484002a */  addiu    $a0,$a0,42
/* 800BBA04 3c028011 */  lui      $v0,0x8011
/* 800BBA08 8c4444e0 */  lw       $a0,17632($v0)
/* 800BBA0C 0c02ecbd */  jal      func_800BB2F4
/* 800BBA10 00000000 */  nop      
/* 800BBA14 8fbf00b0 */  lw       $ra,176($sp)
/* 800BBA18 8fb700ac */  lw       $s7,172($sp)
/* 800BBA1C 8fb600a8 */  lw       $s6,168($sp)
/* 800BBA20 8fb500a4 */  lw       $s5,164($sp)
/* 800BBA24 8fb400a0 */  lw       $s4,160($sp)
/* 800BBA28 8fb3009c */  lw       $s3,156($sp)
/* 800BBA2C 8fb20098 */  lw       $s2,152($sp)
/* 800BBA30 8fb10094 */  lw       $s1,148($sp)
/* 800BBA34 8fb00090 */  lw       $s0,144($sp)
/* 800BBA38 03e00008 */  jr       $ra
/* 800BBA3C 27bd00b8 */  addiu    $sp,$sp,184
