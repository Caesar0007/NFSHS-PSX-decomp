.set noat
.set noreorder

glabel func_800BB368
/* 800BB368 27bdff48 */  addiu    $sp,$sp,-184
/* 800BB36C afb00090 */  sw       $s0,144($sp)
/* 800BB370 00808021 */  move     $s0,$a0
/* 800BB374 27a40010 */  addiu    $a0,$sp,16
/* 800BB378 3c058014 */  lui      $a1,0x8014
/* 800BB37C 24a5e560 */  addiu    $a1,$a1,-6816
/* 800BB380 afbf00b0 */  sw       $ra,176($sp)
/* 800BB384 afb700ac */  sw       $s7,172($sp)
/* 800BB388 afb600a8 */  sw       $s6,168($sp)
/* 800BB38C afb500a4 */  sw       $s5,164($sp)
/* 800BB390 afb400a0 */  sw       $s4,160($sp)
/* 800BB394 afb3009c */  sw       $s3,156($sp)
/* 800BB398 afb20098 */  sw       $s2,152($sp)
/* 800BB39C afb10094 */  sw       $s1,148($sp)
/* 800BB3A0 af800f74 */  sw       $zero,3956($gp)
/* 800BB3A4 af800f80 */  sw       $zero,3968($gp)
/* 800BB3A8 af800f7c */  sw       $zero,3964($gp)
/* 800BB3AC 0c0393a5 */  jal      func_800E4E94
/* 800BB3B0 02003021 */  move     $a2,$s0
/* 800BB3B4 0c039811 */  jal      func_800E6044
/* 800BB3B8 02002021 */  move     $a0,$s0
/* 800BB3BC 3c048005 */  lui      $a0,0x8005
/* 800BB3C0 24846e1c */  addiu    $a0,$a0,28188
/* 800BB3C4 24050404 */  li       $a1,1028
/* 800BB3C8 00003021 */  move     $a2,$zero
/* 800BB3CC 0c039745 */  jal      func_800E5D14
/* 800BB3D0 00409021 */  move     $s2,$v0
/* 800BB3D4 3c018014 */  lui      $at,0x8014
/* 800BB3D8 ac22d8f8 */  sw       $v0,-9992($at)
/* 800BB3DC 0c0386cb */  jal      func_800E1B2C
/* 800BB3E0 34139080 */  li       $s3,0x9080
/* 800BB3E4 0c02e795 */  jal      func_800B9E54
/* 800BB3E8 02538821 */  addu     $s1,$s2,$s3
/* 800BB3EC 0c02e8ab */  jal      func_800BA2AC
/* 800BB3F0 00000000 */  nop      
/* 800BB3F4 0c029230 */  jal      func_800A48C0
/* 800BB3F8 2404000c */  li       $a0,12
/* 800BB3FC 3c048005 */  lui      $a0,0x8005
/* 800BB400 24846e28 */  addiu    $a0,$a0,28200
/* 800BB404 02202821 */  move     $a1,$s1
/* 800BB408 00003021 */  move     $a2,$zero
/* 800BB40C 0c039745 */  jal      func_800E5D14
/* 800BB410 00408021 */  move     $s0,$v0
/* 800BB414 ae020000 */  sw       $v0,0($s0)
/* 800BB418 00401821 */  move     $v1,$v0
/* 800BB41C 14600002 */  bnez     $v1,.L800BB428
/* 800BB420 ae020004 */  sw       $v0,4($s0)
/* 800BB424 00008821 */  move     $s1,$zero
.L800BB428:
/* 800BB428 02002021 */  move     $a0,$s0
/* 800BB42C ac910008 */  sw       $s1,8($a0)
/* 800BB430 af840f84 */  sw       $a0,3972($gp)
/* 800BB434 0c02df49 */  jal      func_800B7D24
/* 800BB438 02402821 */  move     $a1,$s2
/* 800BB43C 27a40010 */  addiu    $a0,$sp,16
/* 800BB440 0c0398b2 */  jal      func_800E62C8
/* 800BB444 00532821 */  addu     $a1,$v0,$s3
/* 800BB448 00408021 */  move     $s0,$v0
/* 800BB44C 02002021 */  move     $a0,$s0
/* 800BB450 2405001f */  li       $a1,31
/* 800BB454 8f860f84 */  lw       $a2,3972($gp)
/* 800BB458 0c027332 */  jal      func_8009CCC8
/* 800BB45C 00003821 */  move     $a3,$zero
/* 800BB460 02002021 */  move     $a0,$s0
/* 800BB464 24050020 */  li       $a1,32
/* 800BB468 8f860f84 */  lw       $a2,3972($gp)
/* 800BB46C 24420004 */  addiu    $v0,$v0,4
/* 800BB470 af820f5c */  sw       $v0,3932($gp)
/* 800BB474 0c027332 */  jal      func_8009CCC8
/* 800BB478 00003821 */  move     $a3,$zero
/* 800BB47C 02002021 */  move     $a0,$s0
/* 800BB480 24050023 */  li       $a1,35
/* 800BB484 24420004 */  addiu    $v0,$v0,4
/* 800BB488 3c018014 */  lui      $at,0x8014
/* 800BB48C ac22d8fc */  sw       $v0,-9988($at)
/* 800BB490 0c027305 */  jal      func_8009CC14
/* 800BB494 00003021 */  move     $a2,$zero
/* 800BB498 00402821 */  move     $a1,$v0
/* 800BB49C 3c048014 */  lui      $a0,0x8014
/* 800BB4A0 8c84d8f8 */  lw       $a0,-9992($a0)
/* 800BB4A4 24a30010 */  addiu    $v1,$a1,16
/* 800BB4A8 00641025 */  or       $v0,$v1,$a0
/* 800BB4AC 30420003 */  andi     $v0,$v0,0x3
/* 800BB4B0 10400016 */  beqz     $v0,.L800BB50C
/* 800BB4B4 24a20410 */  addiu    $v0,$a1,1040
.L800BB4B8:
/* 800BB4B8 886b0003 */  lwl      $t3,3($v1)
/* 800BB4BC 986b0000 */  lwr      $t3,0($v1)
/* 800BB4C0 886c0007 */  lwl      $t4,7($v1)
/* 800BB4C4 986c0004 */  lwr      $t4,4($v1)
/* 800BB4C8 886d000b */  lwl      $t5,11($v1)
/* 800BB4CC 986d0008 */  lwr      $t5,8($v1)
/* 800BB4D0 886e000f */  lwl      $t6,15($v1)
/* 800BB4D4 986e000c */  lwr      $t6,12($v1)
/* 800BB4D8 a88b0003 */  swl      $t3,3($a0)
/* 800BB4DC b88b0000 */  swr      $t3,0($a0)
/* 800BB4E0 a88c0007 */  swl      $t4,7($a0)
/* 800BB4E4 b88c0004 */  swr      $t4,4($a0)
/* 800BB4E8 a88d000b */  swl      $t5,11($a0)
/* 800BB4EC b88d0008 */  swr      $t5,8($a0)
/* 800BB4F0 a88e000f */  swl      $t6,15($a0)
/* 800BB4F4 b88e000c */  swr      $t6,12($a0)
/* 800BB4F8 24630010 */  addiu    $v1,$v1,16
/* 800BB4FC 1462ffee */  bne      $v1,$v0,.L800BB4B8
/* 800BB500 24840010 */  addiu    $a0,$a0,16
/* 800BB504 0802ed4f */  j        .L800BB53C
/* 800BB508 02002021 */  move     $a0,$s0
.L800BB50C:
/* 800BB50C 8c6b0000 */  lw       $t3,0($v1)
/* 800BB510 8c6c0004 */  lw       $t4,4($v1)
/* 800BB514 8c6d0008 */  lw       $t5,8($v1)
/* 800BB518 8c6e000c */  lw       $t6,12($v1)
/* 800BB51C ac8b0000 */  sw       $t3,0($a0)
/* 800BB520 ac8c0004 */  sw       $t4,4($a0)
/* 800BB524 ac8d0008 */  sw       $t5,8($a0)
/* 800BB528 ac8e000c */  sw       $t6,12($a0)
/* 800BB52C 24630010 */  addiu    $v1,$v1,16
/* 800BB530 1462fff6 */  bne      $v1,$v0,.L800BB50C
/* 800BB534 24840010 */  addiu    $a0,$a0,16
/* 800BB538 02002021 */  move     $a0,$s0
.L800BB53C:
/* 800BB53C 24050023 */  li       $a1,35
/* 800BB540 0c027305 */  jal      func_8009CC14
/* 800BB544 00003021 */  move     $a2,$zero
/* 800BB548 00003021 */  move     $a2,$zero
/* 800BB54C 00c09021 */  move     $s2,$a2
/* 800BB550 241603ff */  li       $s6,1023
/* 800BB554 00c09821 */  move     $s3,$a2
/* 800BB558 00c0a821 */  move     $s5,$a2
/* 800BB55C 8f840f84 */  lw       $a0,3972($gp)
/* 800BB560 8c420004 */  lw       $v0,4($v0)
/* 800BB564 8f830f5c */  lw       $v1,3932($gp)
/* 800BB568 2442fff0 */  addiu    $v0,$v0,-16
/* 800BB56C 8c63001c */  lw       $v1,28($v1)
/* 800BB570 00021082 */  srl      $v0,$v0,0x2
/* 800BB574 af820f98 */  sw       $v0,3992($gp)
/* 800BB578 000328c0 */  sll      $a1,$v1,0x3
/* 800BB57C 00a32821 */  addu     $a1,$a1,$v1
/* 800BB580 0c02df36 */  jal      func_800B7CD8
/* 800BB584 000528c0 */  sll      $a1,$a1,0x3
/* 800BB588 8f830f5c */  lw       $v1,3932($gp)
/* 800BB58C 8f840f84 */  lw       $a0,3972($gp)
/* 800BB590 8c65001c */  lw       $a1,28($v1)
/* 800BB594 af820f54 */  sw       $v0,3924($gp)
/* 800BB598 0c02df36 */  jal      func_800B7CD8
/* 800BB59C 00003021 */  move     $a2,$zero
/* 800BB5A0 8f830f5c */  lw       $v1,3932($gp)
/* 800BB5A4 8f840f84 */  lw       $a0,3972($gp)
/* 800BB5A8 8c63001c */  lw       $v1,28($v1)
/* 800BB5AC 00003021 */  move     $a2,$zero
/* 800BB5B0 af820f58 */  sw       $v0,3928($gp)
/* 800BB5B4 000328c0 */  sll      $a1,$v1,0x3
/* 800BB5B8 00a32823 */  subu     $a1,$a1,$v1
/* 800BB5BC 0c02df36 */  jal      func_800B7CD8
/* 800BB5C0 00052900 */  sll      $a1,$a1,0x4
/* 800BB5C4 af820f60 */  sw       $v0,3936($gp)
/* 800BB5C8 0c023106 */  jal      func_8008C418
/* 800BB5CC 00000000 */  nop      
/* 800BB5D0 02002021 */  move     $a0,$s0
/* 800BB5D4 24050021 */  li       $a1,33
/* 800BB5D8 0c027305 */  jal      func_8009CC14
/* 800BB5DC 00003021 */  move     $a2,$zero
/* 800BB5E0 02002021 */  move     $a0,$s0
/* 800BB5E4 2405001d */  li       $a1,29
/* 800BB5E8 00003021 */  move     $a2,$zero
/* 800BB5EC 0c027305 */  jal      func_8009CC14
/* 800BB5F0 0040b821 */  move     $s7,$v0
/* 800BB5F4 00408021 */  move     $s0,$v0
.L800BB5F8:
/* 800BB5F8 8f820f5c */  lw       $v0,3932($gp)
/* 800BB5FC 00000000 */  nop      
/* 800BB600 8c43001c */  lw       $v1,28($v0)
/* 800BB604 00000000 */  nop      
/* 800BB608 0243102a */  slt      $v0,$s2,$v1
/* 800BB60C 10400042 */  beqz     $v0,.L800BB718
/* 800BB610 00000000 */  nop      
/* 800BB614 8f820f60 */  lw       $v0,3936($gp)
/* 800BB618 00000000 */  nop      
/* 800BB61C 00558821 */  addu     $s1,$v0,$s5
/* 800BB620 2462ffff */  addiu    $v0,$v1,-1
/* 800BB624 0242102a */  slt      $v0,$s2,$v0
/* 800BB628 10400005 */  beqz     $v0,.L800BB640
/* 800BB62C 0000a021 */  move     $s4,$zero
/* 800BB630 02002021 */  move     $a0,$s0
/* 800BB634 0c0272fb */  jal      func_8009CBEC
/* 800BB638 2405001d */  li       $a1,29
/* 800BB63C 0040a021 */  move     $s4,$v0
.L800BB640:
/* 800BB640 02202021 */  move     $a0,$s1
/* 800BB644 8f860f84 */  lw       $a2,3972($gp)
/* 800BB648 0c022fa2 */  jal      func_8008BE88
/* 800BB64C 02002821 */  move     $a1,$s0
/* 800BB650 02002021 */  move     $a0,$s0
/* 800BB654 24050004 */  li       $a1,4
/* 800BB658 0c027305 */  jal      func_8009CC14
/* 800BB65C 00003021 */  move     $a2,$zero
/* 800BB660 8c49000c */  lw       $t1,12($v0)
/* 800BB664 24430010 */  addiu    $v1,$v0,16
/* 800BB668 29220025 */  slti     $v0,$t1,37
/* 800BB66C 14400002 */  bnez     $v0,.L800BB678
/* 800BB670 00004021 */  move     $t0,$zero
/* 800BB674 24090024 */  li       $t1,36
.L800BB678:
/* 800BB678 19200012 */  blez     $t1,.L800BB6C4
/* 800BB67C 01002821 */  move     $a1,$t0
/* 800BB680 00603821 */  move     $a3,$v1
/* 800BB684 8f820f54 */  lw       $v0,3924($gp)
/* 800BB688 8f8a0f5c */  lw       $t2,3932($gp)
/* 800BB68C 02623021 */  addu     $a2,$s3,$v0
.L800BB690:
/* 800BB690 94e40000 */  lhu      $a0,0($a3)
/* 800BB694 8d43001c */  lw       $v1,28($t2)
/* 800BB698 308203ff */  andi     $v0,$a0,0x3ff
/* 800BB69C 0043102a */  slt      $v0,$v0,$v1
/* 800BB6A0 10400004 */  beqz     $v0,.L800BB6B4
/* 800BB6A4 00000000 */  nop      
/* 800BB6A8 a4c40000 */  sh       $a0,0($a2)
/* 800BB6AC 24c60002 */  addiu    $a2,$a2,2
/* 800BB6B0 24a50001 */  addiu    $a1,$a1,1
.L800BB6B4:
/* 800BB6B4 25080001 */  addiu    $t0,$t0,1
/* 800BB6B8 0109102a */  slt      $v0,$t0,$t1
/* 800BB6BC 1440fff4 */  bnez     $v0,.L800BB690
/* 800BB6C0 24e70002 */  addiu    $a3,$a3,2
.L800BB6C4:
/* 800BB6C4 8f820f58 */  lw       $v0,3928($gp)
/* 800BB6C8 00000000 */  nop      
/* 800BB6CC 00521021 */  addu     $v0,$v0,$s2
/* 800BB6D0 a0450000 */  sb       $a1,0($v0)
/* 800BB6D4 28a20024 */  slti     $v0,$a1,36
/* 800BB6D8 1040000a */  beqz     $v0,.L800BB704
/* 800BB6DC 00051840 */  sll      $v1,$a1,0x1
/* 800BB6E0 8f820f54 */  lw       $v0,3924($gp)
/* 800BB6E4 00000000 */  nop      
/* 800BB6E8 02621021 */  addu     $v0,$s3,$v0
/* 800BB6EC 00621821 */  addu     $v1,$v1,$v0
.L800BB6F0:
/* 800BB6F0 a4760000 */  sh       $s6,0($v1)
/* 800BB6F4 24a50001 */  addiu    $a1,$a1,1
/* 800BB6F8 28a20024 */  slti     $v0,$a1,36
/* 800BB6FC 1440fffc */  bnez     $v0,.L800BB6F0
/* 800BB700 24630002 */  addiu    $v1,$v1,2
.L800BB704:
/* 800BB704 02808021 */  move     $s0,$s4
/* 800BB708 26730040 */  addiu    $s3,$s3,64
/* 800BB70C 26b50070 */  addiu    $s5,$s5,112
/* 800BB710 0802ed7e */  j        .L800BB5F8
/* 800BB714 26520001 */  addiu    $s2,$s2,1
.L800BB718:
/* 800BB718 0c02ec63 */  jal      func_800BB18C
/* 800BB71C 02e02021 */  move     $a0,$s7
/* 800BB720 8f840f84 */  lw       $a0,3972($gp)
/* 800BB724 0c02df51 */  jal      func_800B7D44
/* 800BB728 00000000 */  nop      
/* 800BB72C 3c048014 */  lui      $a0,0x8014
/* 800BB730 0c02e761 */  jal      func_800B9D84
/* 800BB734 2484e564 */  addiu    $a0,$a0,-6812
/* 800BB738 3c048014 */  lui      $a0,0x8014
/* 800BB73C 8f820f64 */  lw       $v0,3940($gp)
/* 800BB740 2484e56c */  addiu    $a0,$a0,-6804
/* 800BB744 8c450000 */  lw       $a1,0($v0)
/* 800BB748 00003021 */  move     $a2,$zero
/* 800BB74C 000528c0 */  sll      $a1,$a1,0x3
/* 800BB750 0c039745 */  jal      func_800E5D14
/* 800BB754 34a50004 */  ori      $a1,$a1,0x4
/* 800BB758 8f840f64 */  lw       $a0,3940($gp)
/* 800BB75C 00402821 */  move     $a1,$v0
/* 800BB760 af850f70 */  sw       $a1,3952($gp)
/* 800BB764 0c02eb79 */  jal      func_800BADE4
/* 800BB768 00000000 */  nop      
/* 800BB76C 8f840f6c */  lw       $a0,3948($gp)
/* 800BB770 8f850f64 */  lw       $a1,3940($gp)
/* 800BB774 0c02eb36 */  jal      func_800BACD8
/* 800BB778 24060002 */  li       $a2,2
/* 800BB77C 8f840f68 */  lw       $a0,3944($gp)
/* 800BB780 8f850f64 */  lw       $a1,3940($gp)
/* 800BB784 0c02eb5e */  jal      func_800BAD78
/* 800BB788 00000000 */  nop      
/* 800BB78C 0c029230 */  jal      func_800A48C0
/* 800BB790 24040008 */  li       $a0,8
/* 800BB794 00402021 */  move     $a0,$v0
/* 800BB798 0c02eebe */  jal      func_800BBAF8
/* 800BB79C 24050030 */  li       $a1,48
/* 800BB7A0 af820f74 */  sw       $v0,3956($gp)
/* 800BB7A4 0c02ee4f */  jal      func_800BB93C
/* 800BB7A8 00000000 */  nop      
/* 800BB7AC 8f840f7c */  lw       $a0,3964($gp)
/* 800BB7B0 0c029de2 */  jal      func_800A7788
/* 800BB7B4 2484002a */  addiu    $a0,$a0,42
/* 800BB7B8 3c028011 */  lui      $v0,0x8011
/* 800BB7BC 8c4442cc */  lw       $a0,17100($v0)
/* 800BB7C0 0c02ec2a */  jal      func_800BB0A8
/* 800BB7C4 00000000 */  nop      
/* 800BB7C8 8fbf00b0 */  lw       $ra,176($sp)
/* 800BB7CC 8fb700ac */  lw       $s7,172($sp)
/* 800BB7D0 8fb600a8 */  lw       $s6,168($sp)
/* 800BB7D4 8fb500a4 */  lw       $s5,164($sp)
/* 800BB7D8 8fb400a0 */  lw       $s4,160($sp)
/* 800BB7DC 8fb3009c */  lw       $s3,156($sp)
/* 800BB7E0 8fb20098 */  lw       $s2,152($sp)
/* 800BB7E4 8fb10094 */  lw       $s1,148($sp)
/* 800BB7E8 8fb00090 */  lw       $s0,144($sp)
/* 800BB7EC 03e00008 */  jr       $ra
/* 800BB7F0 27bd00b8 */  addiu    $sp,$sp,184
