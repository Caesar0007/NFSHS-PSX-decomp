.set noat
.set noreorder

glabel func_8002DB7C
/* 8002DB7C 27bdfe00 */  addiu    $sp,$sp,-512
/* 8002DB80 afb501f4 */  sw       $s5,500($sp)
/* 8002DB84 0080a821 */  move     $s5,$a0
/* 8002DB88 afb001e0 */  sw       $s0,480($sp)
/* 8002DB8C 27b00068 */  addiu    $s0,$sp,104
/* 8002DB90 02002021 */  move     $a0,$s0
/* 8002DB94 afbf01f8 */  sw       $ra,504($sp)
/* 8002DB98 afb401f0 */  sw       $s4,496($sp)
/* 8002DB9C afb301ec */  sw       $s3,492($sp)
/* 8002DBA0 afb201e8 */  sw       $s2,488($sp)
/* 8002DBA4 0c00664c */  jal      func_80019930
/* 8002DBA8 afb101e4 */  sw       $s1,484($sp)
/* 8002DBAC 24020292 */  li       $v0,658
/* 8002DBB0 ae0200a0 */  sw       $v0,160($s0)
/* 8002DBB4 24020293 */  li       $v0,659
/* 8002DBB8 ae0200a4 */  sw       $v0,164($s0)
/* 8002DBBC 3c028005 */  lui      $v0,0x8005
/* 8002DBC0 8c43289c */  lw       $v1,10396($v0)
/* 8002DBC4 24020001 */  li       $v0,1
/* 8002DBC8 a6020088 */  sh       $v0,136($s0)
/* 8002DBCC 84730184 */  lh       $s3,388($v1)
/* 8002DBD0 0c02e733 */  jal      func_800B9CCC
/* 8002DBD4 2404029b */  li       $a0,667
/* 8002DBD8 00408021 */  move     $s0,$v0
/* 8002DBDC 0c00adb1 */  jal      func_8002B6C4
/* 8002DBE0 02602021 */  move     $a0,$s3
/* 8002DBE4 27a40018 */  addiu    $a0,$sp,24
/* 8002DBE8 02002821 */  move     $a1,$s0
/* 8002DBEC 00403021 */  move     $a2,$v0
/* 8002DBF0 0c0393a5 */  jal      func_800E4E94
/* 8002DBF4 26670001 */  addiu    $a3,$s3,1
/* 8002DBF8 3c028005 */  lui      $v0,0x8005
/* 8002DBFC 0040a021 */  move     $s4,$v0
/* 8002DC00 8c441470 */  lw       $a0,5232($v0)
/* 8002DC04 27a20018 */  addiu    $v0,$sp,24
/* 8002DC08 248402d0 */  addiu    $a0,$a0,720
/* 8002DC0C 0c0061f2 */  jal      func_800187C8
/* 8002DC10 ac820090 */  sw       $v0,144($a0)
.L8002DC14:
/* 8002DC14 8e841470 */  lw       $a0,5232($s4)
/* 8002DC18 00000000 */  nop      
/* 8002DC1C 8c820354 */  lw       $v0,852($a0)
/* 8002DC20 00000000 */  nop      
/* 8002DC24 38420001 */  xori     $v0,$v0,0x1
/* 8002DC28 10400005 */  beqz     $v0,.L8002DC40
/* 8002DC2C 00000000 */  nop      
/* 8002DC30 0c004dab */  jal      func_800136AC
/* 8002DC34 00000000 */  nop      
/* 8002DC38 0800b705 */  j        .L8002DC14
/* 8002DC3C 00000000 */  nop      
.L8002DC40:
/* 8002DC40 0c004dab */  jal      func_800136AC
/* 8002DC44 3c128011 */  lui      $s2,0x8011
/* 8002DC48 00002021 */  move     $a0,$zero
/* 8002DC4C 0c00d0fd */  jal      func_800343F4
/* 8002DC50 24050001 */  li       $a1,1
/* 8002DC54 26525318 */  addiu    $s2,$s2,21272
/* 8002DC58 02402021 */  move     $a0,$s2
/* 8002DC5C 27a60110 */  addiu    $a2,$sp,272
/* 8002DC60 3c118011 */  lui      $s1,0x8011
/* 8002DC64 263156a4 */  addiu    $s1,$s1,22180
/* 8002DC68 24070001 */  li       $a3,1
/* 8002DC6C 00f33823 */  subu     $a3,$a3,$s3
/* 8002DC70 00f11021 */  addu     $v0,$a3,$s1
/* 8002DC74 00073c00 */  sll      $a3,$a3,0x10
/* 8002DC78 90450125 */  lbu      $a1,293($v0)
/* 8002DC7C 0c005bfa */  jal      func_80016FE8
/* 8002DC80 00073c03 */  sra      $a3,$a3,0x10
/* 8002DC84 02402021 */  move     $a0,$s2
/* 8002DC88 02608021 */  move     $s0,$s3
/* 8002DC8C 83a50110 */  lb       $a1,272($sp)
/* 8002DC90 93a601d5 */  lbu      $a2,469($sp)
/* 8002DC94 0c005a24 */  jal      func_80016890
/* 8002DC98 02003821 */  move     $a3,$s0
/* 8002DC9C 02402021 */  move     $a0,$s2
/* 8002DCA0 02118821 */  addu     $s1,$s0,$s1
/* 8002DCA4 92250125 */  lbu      $a1,293($s1)
/* 8002DCA8 93a601d4 */  lbu      $a2,468($sp)
/* 8002DCAC 0c005a43 */  jal      func_8001690C
/* 8002DCB0 02003821 */  move     $a3,$s0
/* 8002DCB4 02002021 */  move     $a0,$s0
/* 8002DCB8 24050002 */  li       $a1,2
/* 8002DCBC 0c00d53b */  jal      func_800354EC
/* 8002DCC0 2406ffff */  li       $a2,-1
/* 8002DCC4 8e841470 */  lw       $a0,5232($s4)
/* 8002DCC8 0c006223 */  jal      func_8001888C
/* 8002DCCC 248402d0 */  addiu    $a0,$a0,720
/* 8002DCD0 24040275 */  li       $a0,629
/* 8002DCD4 24020002 */  li       $v0,2
/* 8002DCD8 aea20000 */  sw       $v0,0($s5)
/* 8002DCDC 3c028005 */  lui      $v0,0x8005
/* 8002DCE0 8c4219a8 */  lw       $v0,6568($v0)
/* 8002DCE4 8e901470 */  lw       $s0,5232($s4)
/* 8002DCE8 244200b0 */  addiu    $v0,$v0,176
/* 8002DCEC 261002d0 */  addiu    $s0,$s0,720
/* 8002DCF0 0c02e733 */  jal      func_800B9CCC
/* 8002DCF4 aea20004 */  sw       $v0,4($s5)
/* 8002DCF8 8e841470 */  lw       $a0,5232($s4)
/* 8002DCFC 3c118005 */  lui      $s1,0x8005
/* 8002DD00 ae020090 */  sw       $v0,144($s0)
/* 8002DD04 0c0061f2 */  jal      func_800187C8
/* 8002DD08 248402d0 */  addiu    $a0,$a0,720
.L8002DD0C:
/* 8002DD0C 8e241470 */  lw       $a0,5232($s1)
/* 8002DD10 00000000 */  nop      
/* 8002DD14 8c820354 */  lw       $v0,852($a0)
/* 8002DD18 00000000 */  nop      
/* 8002DD1C 38420001 */  xori     $v0,$v0,0x1
/* 8002DD20 10400005 */  beqz     $v0,.L8002DD38
/* 8002DD24 00000000 */  nop      
/* 8002DD28 0c004dab */  jal      func_800136AC
/* 8002DD2C 00000000 */  nop      
/* 8002DD30 0800b743 */  j        .L8002DD0C
/* 8002DD34 00000000 */  nop      
.L8002DD38:
/* 8002DD38 0c004dab */  jal      func_800136AC
/* 8002DD3C 00000000 */  nop      
/* 8002DD40 0c00b541 */  jal      func_8002D504
/* 8002DD44 00002021 */  move     $a0,$zero
/* 8002DD48 0c00d157 */  jal      func_8003455C
/* 8002DD4C 00000000 */  nop      
/* 8002DD50 8e241470 */  lw       $a0,5232($s1)
/* 8002DD54 0c006223 */  jal      func_8001888C
/* 8002DD58 248402d0 */  addiu    $a0,$a0,720
.L8002DD5C:
/* 8002DD5C 0c01ea92 */  jal      func_8007AA48
/* 8002DD60 00000000 */  nop      
/* 8002DD64 0c01ea71 */  jal      func_8007A9C4
/* 8002DD68 00408021 */  move     $s0,$v0
/* 8002DD6C 0202802a */  slt      $s0,$s0,$v0
/* 8002DD70 1200001e */  beqz     $s0,.L8002DDEC
/* 8002DD74 27a40068 */  addiu    $a0,$sp,104
/* 8002DD78 0c00562e */  jal      func_800158B8
/* 8002DD7C 00002021 */  move     $a0,$zero
/* 8002DD80 3c028005 */  lui      $v0,0x8005
/* 8002DD84 8c441470 */  lw       $a0,5232($v0)
/* 8002DD88 0c004dab */  jal      func_800136AC
/* 8002DD8C 00000000 */  nop      
/* 8002DD90 2404027e */  li       $a0,638
/* 8002DD94 240501e0 */  li       $a1,480
/* 8002DD98 240600dc */  li       $a2,220
/* 8002DD9C 24070001 */  li       $a3,1
/* 8002DDA0 00e01021 */  move     $v0,$a3
/* 8002DDA4 afa20010 */  sw       $v0,16($sp)
/* 8002DDA8 24020004 */  li       $v0,4
/* 8002DDAC 0c008410 */  jal      func_80021040
/* 8002DDB0 afa20014 */  sw       $v0,20($sp)
/* 8002DDB4 0c02e733 */  jal      func_800B9CCC
/* 8002DDB8 2404027e */  li       $a0,638
/* 8002DDBC 0c039206 */  jal      func_800E4818
/* 8002DDC0 00402021 */  move     $a0,$v0
/* 8002DDC4 00002021 */  move     $a0,$zero
/* 8002DDC8 240501e0 */  li       $a1,480
/* 8002DDCC 240600dc */  li       $a2,220
/* 8002DDD0 00021023 */  negu     $v0,$v0
/* 8002DDD4 2447fffb */  addiu    $a3,$v0,-5
/* 8002DDD8 24020007 */  li       $v0,7
/* 8002DDDC 0c013afd */  jal      func_8004EBF4
/* 8002DDE0 afa20010 */  sw       $v0,16($sp)
/* 8002DDE4 0800b757 */  j        .L8002DD5C
/* 8002DDE8 00000000 */  nop      
.L8002DDEC:
/* 8002DDEC 24050002 */  li       $a1,2
/* 8002DDF0 3c028005 */  lui      $v0,0x8005
/* 8002DDF4 8c4219a8 */  lw       $v0,6568($v0)
/* 8002DDF8 00a01821 */  move     $v1,$a1
/* 8002DDFC aea30000 */  sw       $v1,0($s5)
/* 8002DE00 244200b0 */  addiu    $v0,$v0,176
/* 8002DE04 0c009758 */  jal      func_80025D60
/* 8002DE08 aea20004 */  sw       $v0,4($s5)
/* 8002DE0C 8fbf01f8 */  lw       $ra,504($sp)
/* 8002DE10 8fb501f4 */  lw       $s5,500($sp)
/* 8002DE14 8fb401f0 */  lw       $s4,496($sp)
/* 8002DE18 8fb301ec */  lw       $s3,492($sp)
/* 8002DE1C 8fb201e8 */  lw       $s2,488($sp)
/* 8002DE20 8fb101e4 */  lw       $s1,484($sp)
/* 8002DE24 8fb001e0 */  lw       $s0,480($sp)
/* 8002DE28 03e00008 */  jr       $ra
/* 8002DE2C 27bd0200 */  addiu    $sp,$sp,512
