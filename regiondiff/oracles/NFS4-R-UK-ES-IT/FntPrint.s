.set noat
.set noreorder

glabel func_800F79BC
/* 800F79BC afa40000 */  sw       $a0,0($sp)
/* 800F79C0 afa50004 */  sw       $a1,4($sp)
/* 800F79C4 afa60008 */  sw       $a2,8($sp)
/* 800F79C8 afa7000c */  sw       $a3,12($sp)
/* 800F79CC 27bdfdc8 */  addiu    $sp,$sp,-568
/* 800F79D0 27a2023c */  addiu    $v0,$sp,572
/* 800F79D4 afbf0230 */  sw       $ra,560($sp)
/* 800F79D8 afb5022c */  sw       $s5,556($sp)
/* 800F79DC afb40228 */  sw       $s4,552($sp)
/* 800F79E0 afb30224 */  sw       $s3,548($sp)
/* 800F79E4 afb20220 */  sw       $s2,544($sp)
/* 800F79E8 afb1021c */  sw       $s1,540($sp)
/* 800F79EC afb00218 */  sw       $s0,536($sp)
/* 800F79F0 afa40238 */  sw       $a0,568($sp)
/* 800F79F4 04800007 */  bltz     $a0,.L800F7A14
/* 800F79F8 afa20210 */  sw       $v0,528($sp)
/* 800F79FC 3c028013 */  lui      $v0,0x8013
/* 800F7A00 8c4272f4 */  lw       $v0,29428($v0)
/* 800F7A04 00000000 */  nop      
/* 800F7A08 0082102a */  slt      $v0,$a0,$v0
/* 800F7A0C 1440000f */  bnez     $v0,.L800F7A4C
/* 800F7A10 27a20240 */  addiu    $v0,$sp,576
.L800F7A14:
/* 800F7A14 3c028013 */  lui      $v0,0x8013
/* 800F7A18 8c4272f8 */  lw       $v0,29432($v0)
/* 800F7A1C 00000000 */  nop      
/* 800F7A20 00021840 */  sll      $v1,$v0,0x1
/* 800F7A24 00621821 */  addu     $v1,$v1,$v0
/* 800F7A28 00031900 */  sll      $v1,$v1,0x4
/* 800F7A2C 3c018013 */  lui      $at,0x8013
/* 800F7A30 00230821 */  addu     $at,$at,$v1
/* 800F7A34 8c237198 */  lw       $v1,29080($at)
/* 800F7A38 00809821 */  move     $s3,$a0
/* 800F7A3C 14600005 */  bnez     $v1,.L800F7A54
/* 800F7A40 afa20238 */  sw       $v0,568($sp)
.L800F7A44:
/* 800F7A44 0803df56 */  j        .L800F7D58
/* 800F7A48 2402ffff */  li       $v0,-1
.L800F7A4C:
/* 800F7A4C 8fb3023c */  lw       $s3,572($sp)
/* 800F7A50 afa20210 */  sw       $v0,528($sp)
.L800F7A54:
/* 800F7A54 8fa30238 */  lw       $v1,568($sp)
/* 800F7A58 00000000 */  nop      
/* 800F7A5C 00031040 */  sll      $v0,$v1,0x1
/* 800F7A60 00431021 */  addu     $v0,$v0,$v1
/* 800F7A64 00021100 */  sll      $v0,$v0,0x4
/* 800F7A68 3c038013 */  lui      $v1,0x8013
/* 800F7A6C 24637174 */  addiu    $v1,$v1,29044
/* 800F7A70 00438821 */  addu     $s1,$v0,$v1
/* 800F7A74 8e230028 */  lw       $v1,40($s1)
/* 800F7A78 8e22001c */  lw       $v0,28($s1)
/* 800F7A7C 00000000 */  nop      
/* 800F7A80 0043102a */  slt      $v0,$v0,$v1
/* 800F7A84 1440ffef */  bnez     $v0,.L800F7A44
/* 800F7A88 00000000 */  nop      
/* 800F7A8C 82640000 */  lb       $a0,0($s3)
/* 800F7A90 00000000 */  nop      
/* 800F7A94 108000aa */  beqz     $a0,.L800F7D40
/* 800F7A98 00000000 */  nop      
/* 800F7A9C 24140025 */  li       $s4,37
/* 800F7AA0 3c15cccc */  lui      $s5,0xcccc
/* 800F7AA4 36b5cccd */  ori      $s5,$s5,0xcccd
.L800F7AA8:
/* 800F7AA8 14940006 */  bne      $a0,$s4,.L800F7AC4
/* 800F7AAC 00000000 */  nop      
/* 800F7AB0 26730001 */  addiu    $s3,$s3,1
/* 800F7AB4 82640000 */  lb       $a0,0($s3)
/* 800F7AB8 00000000 */  nop      
/* 800F7ABC 1494000d */  bne      $a0,$s4,.L800F7AF4
/* 800F7AC0 00009021 */  move     $s2,$zero
.L800F7AC4:
/* 800F7AC4 8e220028 */  lw       $v0,40($s1)
/* 800F7AC8 8e230024 */  lw       $v1,36($s1)
/* 800F7ACC 00000000 */  nop      
/* 800F7AD0 00621821 */  addu     $v1,$v1,$v0
/* 800F7AD4 a0640000 */  sb       $a0,0($v1)
/* 800F7AD8 8e23001c */  lw       $v1,28($s1)
/* 800F7ADC 24420001 */  addiu    $v0,$v0,1
/* 800F7AE0 0062182a */  slt      $v1,$v1,$v0
/* 800F7AE4 10600091 */  beqz     $v1,.L800F7D2C
/* 800F7AE8 ae220028 */  sw       $v0,40($s1)
/* 800F7AEC 0803df56 */  j        .L800F7D58
/* 800F7AF0 2402ffff */  li       $v0,-1
.L800F7AF4:
/* 800F7AF4 38820030 */  xori     $v0,$a0,0x30
/* 800F7AF8 2c420001 */  sltiu    $v0,$v0,1
/* 800F7AFC 0803dec8 */  j        .L800F7B20
/* 800F7B00 00403021 */  move     $a2,$v0
.L800F7B04:
/* 800F7B04 00521021 */  addu     $v0,$v0,$s2
/* 800F7B08 00021040 */  sll      $v0,$v0,0x1
/* 800F7B0C 2442ffd0 */  addiu    $v0,$v0,-48
/* 800F7B10 00449021 */  addu     $s2,$v0,$a0
/* 800F7B14 26730001 */  addiu    $s3,$s3,1
/* 800F7B18 82640000 */  lb       $a0,0($s3)
/* 800F7B1C 00000000 */  nop      
.L800F7B20:
/* 800F7B20 2482ffd0 */  addiu    $v0,$a0,-48
/* 800F7B24 2c42000a */  sltiu    $v0,$v0,10
/* 800F7B28 1440fff6 */  bnez     $v0,.L800F7B04
/* 800F7B2C 00121080 */  sll      $v0,$s2,0x2
/* 800F7B30 1e400002 */  bgtz     $s2,.L800F7B3C
/* 800F7B34 2483ffa8 */  addiu    $v1,$a0,-88
/* 800F7B38 24120001 */  li       $s2,1
.L800F7B3C:
/* 800F7B3C 2c620021 */  sltiu    $v0,$v1,33
/* 800F7B40 10400056 */  beqz     $v0,.L800F7C9C
/* 800F7B44 27b00210 */  addiu    $s0,$sp,528
/* 800F7B48 00031080 */  sll      $v0,$v1,0x2
/* 800F7B4C 3c018005 */  lui      $at,%hi(jtbl_80057848)
/* 800F7B50 00220821 */  addu     $at,$at,$v0
/* 800F7B54 8c227848 */  lw       $v0,%lo(jtbl_80057848)($at)
/* 800F7B58 00000000 */  nop      
/* 800F7B5C 00400008 */  jr       $v0
/* 800F7B60 00000000 */  nop      
.L800F7B64:
/* 800F7B64 8fa20210 */  lw       $v0,528($sp)
/* 800F7B68 00000000 */  nop      
/* 800F7B6C 8c440000 */  lw       $a0,0($v0)
/* 800F7B70 24420004 */  addiu    $v0,$v0,4
/* 800F7B74 04810004 */  bgez     $a0,.L800F7B88
/* 800F7B78 afa20210 */  sw       $v0,528($sp)
/* 800F7B7C 00042023 */  negu     $a0,$a0
/* 800F7B80 0803dee3 */  j        .L800F7B8C
/* 800F7B84 2406002d */  li       $a2,45
.L800F7B88:
/* 800F7B88 00003021 */  move     $a2,$zero
.L800F7B8C:
/* 800F7B8C 00002821 */  move     $a1,$zero
.L800F7B90:
/* 800F7B90 00950019 */  multu    $a0,$s5
/* 800F7B94 2610ffff */  addiu    $s0,$s0,-1
/* 800F7B98 24a50001 */  addiu    $a1,$a1,1
/* 800F7B9C 00003810 */  mfhi     $a3
/* 800F7BA0 000718c2 */  srl      $v1,$a3,0x3
/* 800F7BA4 00031080 */  sll      $v0,$v1,0x2
/* 800F7BA8 00431021 */  addu     $v0,$v0,$v1
/* 800F7BAC 00021040 */  sll      $v0,$v0,0x1
/* 800F7BB0 00821023 */  subu     $v0,$a0,$v0
/* 800F7BB4 24420030 */  addiu    $v0,$v0,48
/* 800F7BB8 a2020000 */  sb       $v0,0($s0)
/* 800F7BBC 10a0fff4 */  beqz     $a1,.L800F7B90
/* 800F7BC0 00602021 */  move     $a0,$v1
/* 800F7BC4 1480fff2 */  bnez     $a0,.L800F7B90
/* 800F7BC8 00000000 */  nop      
/* 800F7BCC 10c00034 */  beqz     $a2,.L800F7CA0
/* 800F7BD0 00b2102a */  slt      $v0,$a1,$s2
/* 800F7BD4 2610ffff */  addiu    $s0,$s0,-1
/* 800F7BD8 a2060000 */  sb       $a2,0($s0)
/* 800F7BDC 0803df27 */  j        .L800F7C9C
/* 800F7BE0 24a50001 */  addiu    $a1,$a1,1
.L800F7BE4:
/* 800F7BE4 8fa20210 */  lw       $v0,528($sp)
/* 800F7BE8 00002821 */  move     $a1,$zero
/* 800F7BEC 8c440000 */  lw       $a0,0($v0)
/* 800F7BF0 24420004 */  addiu    $v0,$v0,4
/* 800F7BF4 afa20210 */  sw       $v0,528($sp)
.L800F7BF8:
/* 800F7BF8 2610ffff */  addiu    $s0,$s0,-1
.L800F7BFC:
/* 800F7BFC 3082000f */  andi     $v0,$a0,0xf
/* 800F7C00 3c038013 */  lui      $v1,0x8013
/* 800F7C04 8c637d00 */  lw       $v1,32000($v1)
/* 800F7C08 00042102 */  srl      $a0,$a0,0x4
/* 800F7C0C 00621821 */  addu     $v1,$v1,$v0
/* 800F7C10 90620000 */  lbu      $v0,0($v1)
/* 800F7C14 24a50001 */  addiu    $a1,$a1,1
/* 800F7C18 10a0fff7 */  beqz     $a1,.L800F7BF8
/* 800F7C1C a2020000 */  sb       $v0,0($s0)
/* 800F7C20 1480fff6 */  bnez     $a0,.L800F7BFC
/* 800F7C24 2610ffff */  addiu    $s0,$s0,-1
/* 800F7C28 26100001 */  addiu    $s0,$s0,1
/* 800F7C2C 00c01021 */  move     $v0,$a2
/* 800F7C30 1040001a */  beqz     $v0,.L800F7C9C
/* 800F7C34 00b2102a */  slt      $v0,$a1,$s2
/* 800F7C38 10400029 */  beqz     $v0,.L800F7CE0
/* 800F7C3C 24030030 */  li       $v1,48
.L800F7C40:
/* 800F7C40 2610ffff */  addiu    $s0,$s0,-1
/* 800F7C44 24a50001 */  addiu    $a1,$a1,1
/* 800F7C48 00b2102a */  slt      $v0,$a1,$s2
/* 800F7C4C 1440fffc */  bnez     $v0,.L800F7C40
/* 800F7C50 a2030000 */  sb       $v1,0($s0)
/* 800F7C54 0803df28 */  j        .L800F7CA0
/* 800F7C58 00000000 */  nop      
.L800F7C5C:
/* 800F7C5C 2610ffff */  addiu    $s0,$s0,-1
/* 800F7C60 8fa20210 */  lw       $v0,528($sp)
/* 800F7C64 24050001 */  li       $a1,1
/* 800F7C68 90430000 */  lbu      $v1,0($v0)
/* 800F7C6C 24420004 */  addiu    $v0,$v0,4
/* 800F7C70 a2030000 */  sb       $v1,0($s0)
/* 800F7C74 0803df27 */  j        .L800F7C9C
/* 800F7C78 afa20210 */  sw       $v0,528($sp)
.L800F7C7C:
/* 800F7C7C 8fa20210 */  lw       $v0,528($sp)
/* 800F7C80 00000000 */  nop      
/* 800F7C84 8c500000 */  lw       $s0,0($v0)
/* 800F7C88 24420004 */  addiu    $v0,$v0,4
/* 800F7C8C afa20210 */  sw       $v0,528($sp)
/* 800F7C90 0c03aa2f */  jal      func_800EA8BC
/* 800F7C94 02002021 */  move     $a0,$s0
/* 800F7C98 00402821 */  move     $a1,$v0
.L800F7C9C:
/* 800F7C9C 00b2102a */  slt      $v0,$a1,$s2
.L800F7CA0:
/* 800F7CA0 1040000f */  beqz     $v0,.L800F7CE0
/* 800F7CA4 24040020 */  li       $a0,32
.L800F7CA8:
/* 800F7CA8 8e220028 */  lw       $v0,40($s1)
/* 800F7CAC 8e230024 */  lw       $v1,36($s1)
/* 800F7CB0 00000000 */  nop      
/* 800F7CB4 00621821 */  addu     $v1,$v1,$v0
/* 800F7CB8 a0640000 */  sb       $a0,0($v1)
/* 800F7CBC 8e23001c */  lw       $v1,28($s1)
/* 800F7CC0 24420001 */  addiu    $v0,$v0,1
/* 800F7CC4 0062182a */  slt      $v1,$v1,$v0
/* 800F7CC8 1460ff5e */  bnez     $v1,.L800F7A44
/* 800F7CCC ae220028 */  sw       $v0,40($s1)
/* 800F7CD0 2652ffff */  addiu    $s2,$s2,-1
/* 800F7CD4 00b2102a */  slt      $v0,$a1,$s2
/* 800F7CD8 1440fff3 */  bnez     $v0,.L800F7CA8
/* 800F7CDC 00000000 */  nop      
.L800F7CE0:
/* 800F7CE0 24a5ffff */  addiu    $a1,$a1,-1
/* 800F7CE4 2402ffff */  li       $v0,-1
/* 800F7CE8 10a20010 */  beq      $a1,$v0,.L800F7D2C
/* 800F7CEC 00000000 */  nop      
/* 800F7CF0 2406ffff */  li       $a2,-1
.L800F7CF4:
/* 800F7CF4 8e230028 */  lw       $v1,40($s1)
/* 800F7CF8 8e220024 */  lw       $v0,36($s1)
/* 800F7CFC 92040000 */  lbu      $a0,0($s0)
/* 800F7D00 26100001 */  addiu    $s0,$s0,1
/* 800F7D04 00431021 */  addu     $v0,$v0,$v1
/* 800F7D08 a0440000 */  sb       $a0,0($v0)
/* 800F7D0C 8e22001c */  lw       $v0,28($s1)
/* 800F7D10 24630001 */  addiu    $v1,$v1,1
/* 800F7D14 0043102a */  slt      $v0,$v0,$v1
/* 800F7D18 1440ff4a */  bnez     $v0,.L800F7A44
/* 800F7D1C ae230028 */  sw       $v1,40($s1)
/* 800F7D20 24a5ffff */  addiu    $a1,$a1,-1
/* 800F7D24 14a6fff3 */  bne      $a1,$a2,.L800F7CF4
/* 800F7D28 00000000 */  nop      
.L800F7D2C:
/* 800F7D2C 26730001 */  addiu    $s3,$s3,1
/* 800F7D30 82640000 */  lb       $a0,0($s3)
/* 800F7D34 00000000 */  nop      
/* 800F7D38 1480ff5b */  bnez     $a0,.L800F7AA8
/* 800F7D3C 00000000 */  nop      
.L800F7D40:
/* 800F7D40 8e220024 */  lw       $v0,36($s1)
/* 800F7D44 8e230028 */  lw       $v1,40($s1)
/* 800F7D48 00000000 */  nop      
/* 800F7D4C 00431021 */  addu     $v0,$v0,$v1
/* 800F7D50 a0400000 */  sb       $zero,0($v0)
/* 800F7D54 8e220028 */  lw       $v0,40($s1)
.L800F7D58:
/* 800F7D58 8fbf0230 */  lw       $ra,560($sp)
/* 800F7D5C 8fb5022c */  lw       $s5,556($sp)
/* 800F7D60 8fb40228 */  lw       $s4,552($sp)
/* 800F7D64 8fb30224 */  lw       $s3,548($sp)
/* 800F7D68 8fb20220 */  lw       $s2,544($sp)
/* 800F7D6C 8fb1021c */  lw       $s1,540($sp)
/* 800F7D70 8fb00218 */  lw       $s0,536($sp)
/* 800F7D74 03e00008 */  jr       $ra
/* 800F7D78 27bd0238 */  addiu    $sp,$sp,568
/* 800F7D7C 00000000 */  nop      
/* 800F7D80 00000000 */  nop      
/* 800F7D84 00000000 */  nop      

.section .rodata
glabel jtbl_80057848
.word .L800F7BE4
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C5C
.word .L800F7B64
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C7C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7C9C
.word .L800F7BE4
