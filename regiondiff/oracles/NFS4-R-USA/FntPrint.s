.set noat
.set noreorder

glabel func_800F7990
/* 800F7990 afa40000 */  sw       $a0,0($sp)
/* 800F7994 afa50004 */  sw       $a1,4($sp)
/* 800F7998 afa60008 */  sw       $a2,8($sp)
/* 800F799C afa7000c */  sw       $a3,12($sp)
/* 800F79A0 27bdfdc8 */  addiu    $sp,$sp,-568
/* 800F79A4 27a2023c */  addiu    $v0,$sp,572
/* 800F79A8 afbf0230 */  sw       $ra,560($sp)
/* 800F79AC afb5022c */  sw       $s5,556($sp)
/* 800F79B0 afb40228 */  sw       $s4,552($sp)
/* 800F79B4 afb30224 */  sw       $s3,548($sp)
/* 800F79B8 afb20220 */  sw       $s2,544($sp)
/* 800F79BC afb1021c */  sw       $s1,540($sp)
/* 800F79C0 afb00218 */  sw       $s0,536($sp)
/* 800F79C4 afa40238 */  sw       $a0,568($sp)
/* 800F79C8 04800007 */  bltz     $a0,.L800F79E8
/* 800F79CC afa20210 */  sw       $v0,528($sp)
/* 800F79D0 3c028013 */  lui      $v0,0x8013
/* 800F79D4 8c4272c8 */  lw       $v0,29384($v0)
/* 800F79D8 00000000 */  nop      
/* 800F79DC 0082102a */  slt      $v0,$a0,$v0
/* 800F79E0 1440000f */  bnez     $v0,.L800F7A20
/* 800F79E4 27a20240 */  addiu    $v0,$sp,576
.L800F79E8:
/* 800F79E8 3c028013 */  lui      $v0,0x8013
/* 800F79EC 8c4272cc */  lw       $v0,29388($v0)
/* 800F79F0 00000000 */  nop      
/* 800F79F4 00021840 */  sll      $v1,$v0,0x1
/* 800F79F8 00621821 */  addu     $v1,$v1,$v0
/* 800F79FC 00031900 */  sll      $v1,$v1,0x4
/* 800F7A00 3c018013 */  lui      $at,0x8013
/* 800F7A04 00230821 */  addu     $at,$at,$v1
/* 800F7A08 8c23716c */  lw       $v1,29036($at)
/* 800F7A0C 00809821 */  move     $s3,$a0
/* 800F7A10 14600005 */  bnez     $v1,.L800F7A28
/* 800F7A14 afa20238 */  sw       $v0,568($sp)
.L800F7A18:
/* 800F7A18 0803df4b */  j        .L800F7D2C
/* 800F7A1C 2402ffff */  li       $v0,-1
.L800F7A20:
/* 800F7A20 8fb3023c */  lw       $s3,572($sp)
/* 800F7A24 afa20210 */  sw       $v0,528($sp)
.L800F7A28:
/* 800F7A28 8fa30238 */  lw       $v1,568($sp)
/* 800F7A2C 00000000 */  nop      
/* 800F7A30 00031040 */  sll      $v0,$v1,0x1
/* 800F7A34 00431021 */  addu     $v0,$v0,$v1
/* 800F7A38 00021100 */  sll      $v0,$v0,0x4
/* 800F7A3C 3c038013 */  lui      $v1,0x8013
/* 800F7A40 24637148 */  addiu    $v1,$v1,29000
/* 800F7A44 00438821 */  addu     $s1,$v0,$v1
/* 800F7A48 8e230028 */  lw       $v1,40($s1)
/* 800F7A4C 8e22001c */  lw       $v0,28($s1)
/* 800F7A50 00000000 */  nop      
/* 800F7A54 0043102a */  slt      $v0,$v0,$v1
/* 800F7A58 1440ffef */  bnez     $v0,.L800F7A18
/* 800F7A5C 00000000 */  nop      
/* 800F7A60 82640000 */  lb       $a0,0($s3)
/* 800F7A64 00000000 */  nop      
/* 800F7A68 108000aa */  beqz     $a0,.L800F7D14
/* 800F7A6C 00000000 */  nop      
/* 800F7A70 24140025 */  li       $s4,37
/* 800F7A74 3c15cccc */  lui      $s5,0xcccc
/* 800F7A78 36b5cccd */  ori      $s5,$s5,0xcccd
.L800F7A7C:
/* 800F7A7C 14940006 */  bne      $a0,$s4,.L800F7A98
/* 800F7A80 00000000 */  nop      
/* 800F7A84 26730001 */  addiu    $s3,$s3,1
/* 800F7A88 82640000 */  lb       $a0,0($s3)
/* 800F7A8C 00000000 */  nop      
/* 800F7A90 1494000d */  bne      $a0,$s4,.L800F7AC8
/* 800F7A94 00009021 */  move     $s2,$zero
.L800F7A98:
/* 800F7A98 8e220028 */  lw       $v0,40($s1)
/* 800F7A9C 8e230024 */  lw       $v1,36($s1)
/* 800F7AA0 00000000 */  nop      
/* 800F7AA4 00621821 */  addu     $v1,$v1,$v0
/* 800F7AA8 a0640000 */  sb       $a0,0($v1)
/* 800F7AAC 8e23001c */  lw       $v1,28($s1)
/* 800F7AB0 24420001 */  addiu    $v0,$v0,1
/* 800F7AB4 0062182a */  slt      $v1,$v1,$v0
/* 800F7AB8 10600091 */  beqz     $v1,.L800F7D00
/* 800F7ABC ae220028 */  sw       $v0,40($s1)
/* 800F7AC0 0803df4b */  j        .L800F7D2C
/* 800F7AC4 2402ffff */  li       $v0,-1
.L800F7AC8:
/* 800F7AC8 38820030 */  xori     $v0,$a0,0x30
/* 800F7ACC 2c420001 */  sltiu    $v0,$v0,1
/* 800F7AD0 0803debd */  j        .L800F7AF4
/* 800F7AD4 00403021 */  move     $a2,$v0
.L800F7AD8:
/* 800F7AD8 00521021 */  addu     $v0,$v0,$s2
/* 800F7ADC 00021040 */  sll      $v0,$v0,0x1
/* 800F7AE0 2442ffd0 */  addiu    $v0,$v0,-48
/* 800F7AE4 00449021 */  addu     $s2,$v0,$a0
/* 800F7AE8 26730001 */  addiu    $s3,$s3,1
/* 800F7AEC 82640000 */  lb       $a0,0($s3)
/* 800F7AF0 00000000 */  nop      
.L800F7AF4:
/* 800F7AF4 2482ffd0 */  addiu    $v0,$a0,-48
/* 800F7AF8 2c42000a */  sltiu    $v0,$v0,10
/* 800F7AFC 1440fff6 */  bnez     $v0,.L800F7AD8
/* 800F7B00 00121080 */  sll      $v0,$s2,0x2
/* 800F7B04 1e400002 */  bgtz     $s2,.L800F7B10
/* 800F7B08 2483ffa8 */  addiu    $v1,$a0,-88
/* 800F7B0C 24120001 */  li       $s2,1
.L800F7B10:
/* 800F7B10 2c620021 */  sltiu    $v0,$v1,33
/* 800F7B14 10400056 */  beqz     $v0,.L800F7C70
/* 800F7B18 27b00210 */  addiu    $s0,$sp,528
/* 800F7B1C 00031080 */  sll      $v0,$v1,0x2
/* 800F7B20 3c018005 */  lui      $at,%hi(jtbl_80057848)
/* 800F7B24 00220821 */  addu     $at,$at,$v0
/* 800F7B28 8c227848 */  lw       $v0,%lo(jtbl_80057848)($at)
/* 800F7B2C 00000000 */  nop      
/* 800F7B30 00400008 */  jr       $v0
/* 800F7B34 00000000 */  nop      
.L800F7B38:
/* 800F7B38 8fa20210 */  lw       $v0,528($sp)
/* 800F7B3C 00000000 */  nop      
/* 800F7B40 8c440000 */  lw       $a0,0($v0)
/* 800F7B44 24420004 */  addiu    $v0,$v0,4
/* 800F7B48 04810004 */  bgez     $a0,.L800F7B5C
/* 800F7B4C afa20210 */  sw       $v0,528($sp)
/* 800F7B50 00042023 */  negu     $a0,$a0
/* 800F7B54 0803ded8 */  j        .L800F7B60
/* 800F7B58 2406002d */  li       $a2,45
.L800F7B5C:
/* 800F7B5C 00003021 */  move     $a2,$zero
.L800F7B60:
/* 800F7B60 00002821 */  move     $a1,$zero
.L800F7B64:
/* 800F7B64 00950019 */  multu    $a0,$s5
/* 800F7B68 2610ffff */  addiu    $s0,$s0,-1
/* 800F7B6C 24a50001 */  addiu    $a1,$a1,1
/* 800F7B70 00003810 */  mfhi     $a3
/* 800F7B74 000718c2 */  srl      $v1,$a3,0x3
/* 800F7B78 00031080 */  sll      $v0,$v1,0x2
/* 800F7B7C 00431021 */  addu     $v0,$v0,$v1
/* 800F7B80 00021040 */  sll      $v0,$v0,0x1
/* 800F7B84 00821023 */  subu     $v0,$a0,$v0
/* 800F7B88 24420030 */  addiu    $v0,$v0,48
/* 800F7B8C a2020000 */  sb       $v0,0($s0)
/* 800F7B90 10a0fff4 */  beqz     $a1,.L800F7B64
/* 800F7B94 00602021 */  move     $a0,$v1
/* 800F7B98 1480fff2 */  bnez     $a0,.L800F7B64
/* 800F7B9C 00000000 */  nop      
/* 800F7BA0 10c00034 */  beqz     $a2,.L800F7C74
/* 800F7BA4 00b2102a */  slt      $v0,$a1,$s2
/* 800F7BA8 2610ffff */  addiu    $s0,$s0,-1
/* 800F7BAC a2060000 */  sb       $a2,0($s0)
/* 800F7BB0 0803df1c */  j        .L800F7C70
/* 800F7BB4 24a50001 */  addiu    $a1,$a1,1
.L800F7BB8:
/* 800F7BB8 8fa20210 */  lw       $v0,528($sp)
/* 800F7BBC 00002821 */  move     $a1,$zero
/* 800F7BC0 8c440000 */  lw       $a0,0($v0)
/* 800F7BC4 24420004 */  addiu    $v0,$v0,4
/* 800F7BC8 afa20210 */  sw       $v0,528($sp)
.L800F7BCC:
/* 800F7BCC 2610ffff */  addiu    $s0,$s0,-1
.L800F7BD0:
/* 800F7BD0 3082000f */  andi     $v0,$a0,0xf
/* 800F7BD4 3c038013 */  lui      $v1,0x8013
/* 800F7BD8 8c637cd4 */  lw       $v1,31956($v1)
/* 800F7BDC 00042102 */  srl      $a0,$a0,0x4
/* 800F7BE0 00621821 */  addu     $v1,$v1,$v0
/* 800F7BE4 90620000 */  lbu      $v0,0($v1)
/* 800F7BE8 24a50001 */  addiu    $a1,$a1,1
/* 800F7BEC 10a0fff7 */  beqz     $a1,.L800F7BCC
/* 800F7BF0 a2020000 */  sb       $v0,0($s0)
/* 800F7BF4 1480fff6 */  bnez     $a0,.L800F7BD0
/* 800F7BF8 2610ffff */  addiu    $s0,$s0,-1
/* 800F7BFC 26100001 */  addiu    $s0,$s0,1
/* 800F7C00 00c01021 */  move     $v0,$a2
/* 800F7C04 1040001a */  beqz     $v0,.L800F7C70
/* 800F7C08 00b2102a */  slt      $v0,$a1,$s2
/* 800F7C0C 10400029 */  beqz     $v0,.L800F7CB4
/* 800F7C10 24030030 */  li       $v1,48
.L800F7C14:
/* 800F7C14 2610ffff */  addiu    $s0,$s0,-1
/* 800F7C18 24a50001 */  addiu    $a1,$a1,1
/* 800F7C1C 00b2102a */  slt      $v0,$a1,$s2
/* 800F7C20 1440fffc */  bnez     $v0,.L800F7C14
/* 800F7C24 a2030000 */  sb       $v1,0($s0)
/* 800F7C28 0803df1d */  j        .L800F7C74
/* 800F7C2C 00000000 */  nop      
.L800F7C30:
/* 800F7C30 2610ffff */  addiu    $s0,$s0,-1
/* 800F7C34 8fa20210 */  lw       $v0,528($sp)
/* 800F7C38 24050001 */  li       $a1,1
/* 800F7C3C 90430000 */  lbu      $v1,0($v0)
/* 800F7C40 24420004 */  addiu    $v0,$v0,4
/* 800F7C44 a2030000 */  sb       $v1,0($s0)
/* 800F7C48 0803df1c */  j        .L800F7C70
/* 800F7C4C afa20210 */  sw       $v0,528($sp)
.L800F7C50:
/* 800F7C50 8fa20210 */  lw       $v0,528($sp)
/* 800F7C54 00000000 */  nop      
/* 800F7C58 8c500000 */  lw       $s0,0($v0)
/* 800F7C5C 24420004 */  addiu    $v0,$v0,4
/* 800F7C60 afa20210 */  sw       $v0,528($sp)
/* 800F7C64 0c03aa34 */  jal      func_800EA8D0
/* 800F7C68 02002021 */  move     $a0,$s0
/* 800F7C6C 00402821 */  move     $a1,$v0
.L800F7C70:
/* 800F7C70 00b2102a */  slt      $v0,$a1,$s2
.L800F7C74:
/* 800F7C74 1040000f */  beqz     $v0,.L800F7CB4
/* 800F7C78 24040020 */  li       $a0,32
.L800F7C7C:
/* 800F7C7C 8e220028 */  lw       $v0,40($s1)
/* 800F7C80 8e230024 */  lw       $v1,36($s1)
/* 800F7C84 00000000 */  nop      
/* 800F7C88 00621821 */  addu     $v1,$v1,$v0
/* 800F7C8C a0640000 */  sb       $a0,0($v1)
/* 800F7C90 8e23001c */  lw       $v1,28($s1)
/* 800F7C94 24420001 */  addiu    $v0,$v0,1
/* 800F7C98 0062182a */  slt      $v1,$v1,$v0
/* 800F7C9C 1460ff5e */  bnez     $v1,.L800F7A18
/* 800F7CA0 ae220028 */  sw       $v0,40($s1)
/* 800F7CA4 2652ffff */  addiu    $s2,$s2,-1
/* 800F7CA8 00b2102a */  slt      $v0,$a1,$s2
/* 800F7CAC 1440fff3 */  bnez     $v0,.L800F7C7C
/* 800F7CB0 00000000 */  nop      
.L800F7CB4:
/* 800F7CB4 24a5ffff */  addiu    $a1,$a1,-1
/* 800F7CB8 2402ffff */  li       $v0,-1
/* 800F7CBC 10a20010 */  beq      $a1,$v0,.L800F7D00
/* 800F7CC0 00000000 */  nop      
/* 800F7CC4 2406ffff */  li       $a2,-1
.L800F7CC8:
/* 800F7CC8 8e230028 */  lw       $v1,40($s1)
/* 800F7CCC 8e220024 */  lw       $v0,36($s1)
/* 800F7CD0 92040000 */  lbu      $a0,0($s0)
/* 800F7CD4 26100001 */  addiu    $s0,$s0,1
/* 800F7CD8 00431021 */  addu     $v0,$v0,$v1
/* 800F7CDC a0440000 */  sb       $a0,0($v0)
/* 800F7CE0 8e22001c */  lw       $v0,28($s1)
/* 800F7CE4 24630001 */  addiu    $v1,$v1,1
/* 800F7CE8 0043102a */  slt      $v0,$v0,$v1
/* 800F7CEC 1440ff4a */  bnez     $v0,.L800F7A18
/* 800F7CF0 ae230028 */  sw       $v1,40($s1)
/* 800F7CF4 24a5ffff */  addiu    $a1,$a1,-1
/* 800F7CF8 14a6fff3 */  bne      $a1,$a2,.L800F7CC8
/* 800F7CFC 00000000 */  nop      
.L800F7D00:
/* 800F7D00 26730001 */  addiu    $s3,$s3,1
/* 800F7D04 82640000 */  lb       $a0,0($s3)
/* 800F7D08 00000000 */  nop      
/* 800F7D0C 1480ff5b */  bnez     $a0,.L800F7A7C
/* 800F7D10 00000000 */  nop      
.L800F7D14:
/* 800F7D14 8e220024 */  lw       $v0,36($s1)
/* 800F7D18 8e230028 */  lw       $v1,40($s1)
/* 800F7D1C 00000000 */  nop      
/* 800F7D20 00431021 */  addu     $v0,$v0,$v1
/* 800F7D24 a0400000 */  sb       $zero,0($v0)
/* 800F7D28 8e220028 */  lw       $v0,40($s1)
.L800F7D2C:
/* 800F7D2C 8fbf0230 */  lw       $ra,560($sp)
/* 800F7D30 8fb5022c */  lw       $s5,556($sp)
/* 800F7D34 8fb40228 */  lw       $s4,552($sp)
/* 800F7D38 8fb30224 */  lw       $s3,548($sp)
/* 800F7D3C 8fb20220 */  lw       $s2,544($sp)
/* 800F7D40 8fb1021c */  lw       $s1,540($sp)
/* 800F7D44 8fb00218 */  lw       $s0,536($sp)
/* 800F7D48 03e00008 */  jr       $ra
/* 800F7D4C 27bd0238 */  addiu    $sp,$sp,568

.section .rodata
glabel jtbl_80057848
.word .L800F7BB8
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C30
.word .L800F7B38
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C50
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7C70
.word .L800F7BB8
