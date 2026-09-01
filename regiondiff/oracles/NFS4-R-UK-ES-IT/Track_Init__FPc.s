.set noat
.set noreorder

glabel func_800BB5B8
/* 800BB5B8 27bdff48 */  addiu    $sp,$sp,-184
/* 800BB5BC afb00090 */  sw       $s0,144($sp)
/* 800BB5C0 00808021 */  move     $s0,$a0
/* 800BB5C4 27a40010 */  addiu    $a0,$sp,16
/* 800BB5C8 3c058014 */  lui      $a1,0x8014
/* 800BB5CC 24a5e7a0 */  addiu    $a1,$a1,-6240
/* 800BB5D0 afbf00b0 */  sw       $ra,176($sp)
/* 800BB5D4 afb700ac */  sw       $s7,172($sp)
/* 800BB5D8 afb600a8 */  sw       $s6,168($sp)
/* 800BB5DC afb500a4 */  sw       $s5,164($sp)
/* 800BB5E0 afb400a0 */  sw       $s4,160($sp)
/* 800BB5E4 afb3009c */  sw       $s3,156($sp)
/* 800BB5E8 afb20098 */  sw       $s2,152($sp)
/* 800BB5EC afb10094 */  sw       $s1,148($sp)
/* 800BB5F0 af800f74 */  sw       $zero,3956($gp)
/* 800BB5F4 af800f80 */  sw       $zero,3968($gp)
/* 800BB5F8 af800f7c */  sw       $zero,3964($gp)
/* 800BB5FC 0c039425 */  jal      func_800E5094
/* 800BB600 02003021 */  move     $a2,$s0
/* 800BB604 0c039891 */  jal      func_800E6244
/* 800BB608 02002021 */  move     $a0,$s0
/* 800BB60C 3c048005 */  lui      $a0,0x8005
/* 800BB610 24846e1c */  addiu    $a0,$a0,28188
/* 800BB614 24050404 */  li       $a1,1028
/* 800BB618 00003021 */  move     $a2,$zero
/* 800BB61C 0c0397c5 */  jal      func_800E5F14
/* 800BB620 00409021 */  move     $s2,$v0
/* 800BB624 3c018014 */  lui      $at,0x8014
/* 800BB628 ac22db38 */  sw       $v0,-9416($at)
/* 800BB62C 0c03875b */  jal      func_800E1D6C
/* 800BB630 34139080 */  li       $s3,0x9080
/* 800BB634 0c02e829 */  jal      func_800BA0A4
/* 800BB638 02538821 */  addu     $s1,$s2,$s3
/* 800BB63C 0c02e93f */  jal      func_800BA4FC
/* 800BB640 00000000 */  nop      
/* 800BB644 0c029231 */  jal      func_800A48C4
/* 800BB648 2404000c */  li       $a0,12
/* 800BB64C 3c048005 */  lui      $a0,0x8005
/* 800BB650 24846e28 */  addiu    $a0,$a0,28200
/* 800BB654 02202821 */  move     $a1,$s1
/* 800BB658 00003021 */  move     $a2,$zero
/* 800BB65C 0c0397c5 */  jal      func_800E5F14
/* 800BB660 00408021 */  move     $s0,$v0
/* 800BB664 ae020000 */  sw       $v0,0($s0)
/* 800BB668 00401821 */  move     $v1,$v0
/* 800BB66C 14600002 */  bnez     $v1,.L800BB678
/* 800BB670 ae020004 */  sw       $v0,4($s0)
/* 800BB674 00008821 */  move     $s1,$zero
.L800BB678:
/* 800BB678 02002021 */  move     $a0,$s0
/* 800BB67C ac910008 */  sw       $s1,8($a0)
/* 800BB680 af840f84 */  sw       $a0,3972($gp)
/* 800BB684 0c02dfdd */  jal      func_800B7F74
/* 800BB688 02402821 */  move     $a1,$s2
/* 800BB68C 27a40010 */  addiu    $a0,$sp,16
/* 800BB690 0c039932 */  jal      func_800E64C8
/* 800BB694 00532821 */  addu     $a1,$v0,$s3
/* 800BB698 00408021 */  move     $s0,$v0
/* 800BB69C 02002021 */  move     $a0,$s0
/* 800BB6A0 2405001f */  li       $a1,31
/* 800BB6A4 8f860f84 */  lw       $a2,3972($gp)
/* 800BB6A8 0c027333 */  jal      func_8009CCCC
/* 800BB6AC 00003821 */  move     $a3,$zero
/* 800BB6B0 02002021 */  move     $a0,$s0
/* 800BB6B4 24050020 */  li       $a1,32
/* 800BB6B8 8f860f84 */  lw       $a2,3972($gp)
/* 800BB6BC 24420004 */  addiu    $v0,$v0,4
/* 800BB6C0 af820f5c */  sw       $v0,3932($gp)
/* 800BB6C4 0c027333 */  jal      func_8009CCCC
/* 800BB6C8 00003821 */  move     $a3,$zero
/* 800BB6CC 02002021 */  move     $a0,$s0
/* 800BB6D0 24050023 */  li       $a1,35
/* 800BB6D4 24420004 */  addiu    $v0,$v0,4
/* 800BB6D8 3c018014 */  lui      $at,0x8014
/* 800BB6DC ac22db3c */  sw       $v0,-9412($at)
/* 800BB6E0 0c027306 */  jal      func_8009CC18
/* 800BB6E4 00003021 */  move     $a2,$zero
/* 800BB6E8 00402821 */  move     $a1,$v0
/* 800BB6EC 3c048014 */  lui      $a0,0x8014
/* 800BB6F0 8c84db38 */  lw       $a0,-9416($a0)
/* 800BB6F4 24a30010 */  addiu    $v1,$a1,16
/* 800BB6F8 00641025 */  or       $v0,$v1,$a0
/* 800BB6FC 30420003 */  andi     $v0,$v0,0x3
/* 800BB700 10400016 */  beqz     $v0,.L800BB75C
/* 800BB704 24a20410 */  addiu    $v0,$a1,1040
.L800BB708:
/* 800BB708 886b0003 */  lwl      $t3,3($v1)
/* 800BB70C 986b0000 */  lwr      $t3,0($v1)
/* 800BB710 886c0007 */  lwl      $t4,7($v1)
/* 800BB714 986c0004 */  lwr      $t4,4($v1)
/* 800BB718 886d000b */  lwl      $t5,11($v1)
/* 800BB71C 986d0008 */  lwr      $t5,8($v1)
/* 800BB720 886e000f */  lwl      $t6,15($v1)
/* 800BB724 986e000c */  lwr      $t6,12($v1)
/* 800BB728 a88b0003 */  swl      $t3,3($a0)
/* 800BB72C b88b0000 */  swr      $t3,0($a0)
/* 800BB730 a88c0007 */  swl      $t4,7($a0)
/* 800BB734 b88c0004 */  swr      $t4,4($a0)
/* 800BB738 a88d000b */  swl      $t5,11($a0)
/* 800BB73C b88d0008 */  swr      $t5,8($a0)
/* 800BB740 a88e000f */  swl      $t6,15($a0)
/* 800BB744 b88e000c */  swr      $t6,12($a0)
/* 800BB748 24630010 */  addiu    $v1,$v1,16
/* 800BB74C 1462ffee */  bne      $v1,$v0,.L800BB708
/* 800BB750 24840010 */  addiu    $a0,$a0,16
/* 800BB754 0802ede3 */  j        .L800BB78C
/* 800BB758 02002021 */  move     $a0,$s0
.L800BB75C:
/* 800BB75C 8c6b0000 */  lw       $t3,0($v1)
/* 800BB760 8c6c0004 */  lw       $t4,4($v1)
/* 800BB764 8c6d0008 */  lw       $t5,8($v1)
/* 800BB768 8c6e000c */  lw       $t6,12($v1)
/* 800BB76C ac8b0000 */  sw       $t3,0($a0)
/* 800BB770 ac8c0004 */  sw       $t4,4($a0)
/* 800BB774 ac8d0008 */  sw       $t5,8($a0)
/* 800BB778 ac8e000c */  sw       $t6,12($a0)
/* 800BB77C 24630010 */  addiu    $v1,$v1,16
/* 800BB780 1462fff6 */  bne      $v1,$v0,.L800BB75C
/* 800BB784 24840010 */  addiu    $a0,$a0,16
/* 800BB788 02002021 */  move     $a0,$s0
.L800BB78C:
/* 800BB78C 24050023 */  li       $a1,35
/* 800BB790 0c027306 */  jal      func_8009CC18
/* 800BB794 00003021 */  move     $a2,$zero
/* 800BB798 00003021 */  move     $a2,$zero
/* 800BB79C 00c09021 */  move     $s2,$a2
/* 800BB7A0 241603ff */  li       $s6,1023
/* 800BB7A4 00c09821 */  move     $s3,$a2
/* 800BB7A8 00c0a821 */  move     $s5,$a2
/* 800BB7AC 8f840f84 */  lw       $a0,3972($gp)
/* 800BB7B0 8c420004 */  lw       $v0,4($v0)
/* 800BB7B4 8f830f5c */  lw       $v1,3932($gp)
/* 800BB7B8 2442fff0 */  addiu    $v0,$v0,-16
/* 800BB7BC 8c63001c */  lw       $v1,28($v1)
/* 800BB7C0 00021082 */  srl      $v0,$v0,0x2
/* 800BB7C4 af820f98 */  sw       $v0,3992($gp)
/* 800BB7C8 000328c0 */  sll      $a1,$v1,0x3
/* 800BB7CC 00a32821 */  addu     $a1,$a1,$v1
/* 800BB7D0 0c02dfca */  jal      func_800B7F28
/* 800BB7D4 000528c0 */  sll      $a1,$a1,0x3
/* 800BB7D8 8f830f5c */  lw       $v1,3932($gp)
/* 800BB7DC 8f840f84 */  lw       $a0,3972($gp)
/* 800BB7E0 8c65001c */  lw       $a1,28($v1)
/* 800BB7E4 af820f54 */  sw       $v0,3924($gp)
/* 800BB7E8 0c02dfca */  jal      func_800B7F28
/* 800BB7EC 00003021 */  move     $a2,$zero
/* 800BB7F0 8f830f5c */  lw       $v1,3932($gp)
/* 800BB7F4 8f840f84 */  lw       $a0,3972($gp)
/* 800BB7F8 8c63001c */  lw       $v1,28($v1)
/* 800BB7FC 00003021 */  move     $a2,$zero
/* 800BB800 af820f58 */  sw       $v0,3928($gp)
/* 800BB804 000328c0 */  sll      $a1,$v1,0x3
/* 800BB808 00a32823 */  subu     $a1,$a1,$v1
/* 800BB80C 0c02dfca */  jal      func_800B7F28
/* 800BB810 00052900 */  sll      $a1,$a1,0x4
/* 800BB814 af820f60 */  sw       $v0,3936($gp)
/* 800BB818 0c023107 */  jal      func_8008C41C
/* 800BB81C 00000000 */  nop      
/* 800BB820 02002021 */  move     $a0,$s0
/* 800BB824 24050021 */  li       $a1,33
/* 800BB828 0c027306 */  jal      func_8009CC18
/* 800BB82C 00003021 */  move     $a2,$zero
/* 800BB830 02002021 */  move     $a0,$s0
/* 800BB834 2405001d */  li       $a1,29
/* 800BB838 00003021 */  move     $a2,$zero
/* 800BB83C 0c027306 */  jal      func_8009CC18
/* 800BB840 0040b821 */  move     $s7,$v0
/* 800BB844 00408021 */  move     $s0,$v0
.L800BB848:
/* 800BB848 8f820f5c */  lw       $v0,3932($gp)
/* 800BB84C 00000000 */  nop      
/* 800BB850 8c43001c */  lw       $v1,28($v0)
/* 800BB854 00000000 */  nop      
/* 800BB858 0243102a */  slt      $v0,$s2,$v1
/* 800BB85C 10400042 */  beqz     $v0,.L800BB968
/* 800BB860 00000000 */  nop      
/* 800BB864 8f820f60 */  lw       $v0,3936($gp)
/* 800BB868 00000000 */  nop      
/* 800BB86C 00558821 */  addu     $s1,$v0,$s5
/* 800BB870 2462ffff */  addiu    $v0,$v1,-1
/* 800BB874 0242102a */  slt      $v0,$s2,$v0
/* 800BB878 10400005 */  beqz     $v0,.L800BB890
/* 800BB87C 0000a021 */  move     $s4,$zero
/* 800BB880 02002021 */  move     $a0,$s0
/* 800BB884 0c0272fc */  jal      func_8009CBF0
/* 800BB888 2405001d */  li       $a1,29
/* 800BB88C 0040a021 */  move     $s4,$v0
.L800BB890:
/* 800BB890 02202021 */  move     $a0,$s1
/* 800BB894 8f860f84 */  lw       $a2,3972($gp)
/* 800BB898 0c022fa3 */  jal      func_8008BE8C
/* 800BB89C 02002821 */  move     $a1,$s0
/* 800BB8A0 02002021 */  move     $a0,$s0
/* 800BB8A4 24050004 */  li       $a1,4
/* 800BB8A8 0c027306 */  jal      func_8009CC18
/* 800BB8AC 00003021 */  move     $a2,$zero
/* 800BB8B0 8c49000c */  lw       $t1,12($v0)
/* 800BB8B4 24430010 */  addiu    $v1,$v0,16
/* 800BB8B8 29220025 */  slti     $v0,$t1,37
/* 800BB8BC 14400002 */  bnez     $v0,.L800BB8C8
/* 800BB8C0 00004021 */  move     $t0,$zero
/* 800BB8C4 24090024 */  li       $t1,36
.L800BB8C8:
/* 800BB8C8 19200012 */  blez     $t1,.L800BB914
/* 800BB8CC 01002821 */  move     $a1,$t0
/* 800BB8D0 00603821 */  move     $a3,$v1
/* 800BB8D4 8f820f54 */  lw       $v0,3924($gp)
/* 800BB8D8 8f8a0f5c */  lw       $t2,3932($gp)
/* 800BB8DC 02623021 */  addu     $a2,$s3,$v0
.L800BB8E0:
/* 800BB8E0 94e40000 */  lhu      $a0,0($a3)
/* 800BB8E4 8d43001c */  lw       $v1,28($t2)
/* 800BB8E8 308203ff */  andi     $v0,$a0,0x3ff
/* 800BB8EC 0043102a */  slt      $v0,$v0,$v1
/* 800BB8F0 10400004 */  beqz     $v0,.L800BB904
/* 800BB8F4 00000000 */  nop      
/* 800BB8F8 a4c40000 */  sh       $a0,0($a2)
/* 800BB8FC 24c60002 */  addiu    $a2,$a2,2
/* 800BB900 24a50001 */  addiu    $a1,$a1,1
.L800BB904:
/* 800BB904 25080001 */  addiu    $t0,$t0,1
/* 800BB908 0109102a */  slt      $v0,$t0,$t1
/* 800BB90C 1440fff4 */  bnez     $v0,.L800BB8E0
/* 800BB910 24e70002 */  addiu    $a3,$a3,2
.L800BB914:
/* 800BB914 8f820f58 */  lw       $v0,3928($gp)
/* 800BB918 00000000 */  nop      
/* 800BB91C 00521021 */  addu     $v0,$v0,$s2
/* 800BB920 a0450000 */  sb       $a1,0($v0)
/* 800BB924 28a20024 */  slti     $v0,$a1,36
/* 800BB928 1040000a */  beqz     $v0,.L800BB954
/* 800BB92C 00051840 */  sll      $v1,$a1,0x1
/* 800BB930 8f820f54 */  lw       $v0,3924($gp)
/* 800BB934 00000000 */  nop      
/* 800BB938 02621021 */  addu     $v0,$s3,$v0
/* 800BB93C 00621821 */  addu     $v1,$v1,$v0
.L800BB940:
/* 800BB940 a4760000 */  sh       $s6,0($v1)
/* 800BB944 24a50001 */  addiu    $a1,$a1,1
/* 800BB948 28a20024 */  slti     $v0,$a1,36
/* 800BB94C 1440fffc */  bnez     $v0,.L800BB940
/* 800BB950 24630002 */  addiu    $v1,$v1,2
.L800BB954:
/* 800BB954 02808021 */  move     $s0,$s4
/* 800BB958 26730040 */  addiu    $s3,$s3,64
/* 800BB95C 26b50070 */  addiu    $s5,$s5,112
/* 800BB960 0802ee12 */  j        .L800BB848
/* 800BB964 26520001 */  addiu    $s2,$s2,1
.L800BB968:
/* 800BB968 0c02ecf7 */  jal      func_800BB3DC
/* 800BB96C 02e02021 */  move     $a0,$s7
/* 800BB970 8f840f84 */  lw       $a0,3972($gp)
/* 800BB974 0c02dfe5 */  jal      func_800B7F94
/* 800BB978 00000000 */  nop      
/* 800BB97C 3c048014 */  lui      $a0,0x8014
/* 800BB980 0c02e7f5 */  jal      func_800B9FD4
/* 800BB984 2484e7a4 */  addiu    $a0,$a0,-6236
/* 800BB988 3c048014 */  lui      $a0,0x8014
/* 800BB98C 8f820f64 */  lw       $v0,3940($gp)
/* 800BB990 2484e7ac */  addiu    $a0,$a0,-6228
/* 800BB994 8c450000 */  lw       $a1,0($v0)
/* 800BB998 00003021 */  move     $a2,$zero
/* 800BB99C 000528c0 */  sll      $a1,$a1,0x3
/* 800BB9A0 0c0397c5 */  jal      func_800E5F14
/* 800BB9A4 34a50004 */  ori      $a1,$a1,0x4
/* 800BB9A8 8f840f64 */  lw       $a0,3940($gp)
/* 800BB9AC 00402821 */  move     $a1,$v0
/* 800BB9B0 af850f70 */  sw       $a1,3952($gp)
/* 800BB9B4 0c02ec0d */  jal      func_800BB034
/* 800BB9B8 00000000 */  nop      
/* 800BB9BC 8f840f6c */  lw       $a0,3948($gp)
/* 800BB9C0 8f850f64 */  lw       $a1,3940($gp)
/* 800BB9C4 0c02ebca */  jal      func_800BAF28
/* 800BB9C8 24060002 */  li       $a2,2
/* 800BB9CC 8f840f68 */  lw       $a0,3944($gp)
/* 800BB9D0 8f850f64 */  lw       $a1,3940($gp)
/* 800BB9D4 0c02ebf2 */  jal      func_800BAFC8
/* 800BB9D8 00000000 */  nop      
/* 800BB9DC 0c029231 */  jal      func_800A48C4
/* 800BB9E0 24040008 */  li       $a0,8
/* 800BB9E4 00402021 */  move     $a0,$v0
/* 800BB9E8 0c02ef52 */  jal      func_800BBD48
/* 800BB9EC 24050030 */  li       $a1,48
/* 800BB9F0 af820f74 */  sw       $v0,3956($gp)
/* 800BB9F4 0c02eee3 */  jal      func_800BBB8C
/* 800BB9F8 00000000 */  nop      
/* 800BB9FC 8f840f7c */  lw       $a0,3964($gp)
/* 800BBA00 0c029de3 */  jal      func_800A778C
/* 800BBA04 2484002a */  addiu    $a0,$a0,42
/* 800BBA08 3c028011 */  lui      $v0,0x8011
/* 800BBA0C 8c44450c */  lw       $a0,17676($v0)
/* 800BBA10 0c02ecbe */  jal      func_800BB2F8
/* 800BBA14 00000000 */  nop      
/* 800BBA18 8fbf00b0 */  lw       $ra,176($sp)
/* 800BBA1C 8fb700ac */  lw       $s7,172($sp)
/* 800BBA20 8fb600a8 */  lw       $s6,168($sp)
/* 800BBA24 8fb500a4 */  lw       $s5,164($sp)
/* 800BBA28 8fb400a0 */  lw       $s4,160($sp)
/* 800BBA2C 8fb3009c */  lw       $s3,156($sp)
/* 800BBA30 8fb20098 */  lw       $s2,152($sp)
/* 800BBA34 8fb10094 */  lw       $s1,148($sp)
/* 800BBA38 8fb00090 */  lw       $s0,144($sp)
/* 800BBA3C 03e00008 */  jr       $ra
/* 800BBA40 27bd00b8 */  addiu    $sp,$sp,184
