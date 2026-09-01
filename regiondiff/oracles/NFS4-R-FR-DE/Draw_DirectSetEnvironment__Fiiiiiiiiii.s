.set noat
.set noreorder

glabel func_800BF200
/* 800BF200 27bdff68 */  addiu    $sp,$sp,-152
/* 800BF204 8fa200a8 */  lw       $v0,168($sp)
/* 800BF208 afb5008c */  sw       $s5,140($sp)
/* 800BF20C 8fb500ac */  lw       $s5,172($sp)
/* 800BF210 afb00078 */  sw       $s0,120($sp)
/* 800BF214 8fb000b0 */  lw       $s0,176($sp)
/* 800BF218 afb1007c */  sw       $s1,124($sp)
/* 800BF21C 00808821 */  move     $s1,$a0
/* 800BF220 afb20080 */  sw       $s2,128($sp)
/* 800BF224 00a09021 */  move     $s2,$a1
/* 800BF228 afb30084 */  sw       $s3,132($sp)
/* 800BF22C 00c09821 */  move     $s3,$a2
/* 800BF230 afb40088 */  sw       $s4,136($sp)
/* 800BF234 00e0a021 */  move     $s4,$a3
/* 800BF238 10400018 */  beqz     $v0,.L800BF29C
/* 800BF23C afbf0090 */  sw       $ra,144($sp)
/* 800BF240 afb40010 */  sw       $s4,16($sp)
/* 800BF244 27a40018 */  addiu    $a0,$sp,24
/* 800BF248 02202821 */  move     $a1,$s1
/* 800BF24C 02403021 */  move     $a2,$s2
/* 800BF250 0c03caed */  jal      func_800F2BB4
/* 800BF254 02603821 */  move     $a3,$s3
/* 800BF258 1200000d */  beqz     $s0,.L800BF290
/* 800BF25C 00000000 */  nop      
/* 800BF260 8fa200b4 */  lw       $v0,180($sp)
/* 800BF264 00000000 */  nop      
/* 800BF268 a3a20031 */  sb       $v0,49($sp)
/* 800BF26C 8fa200b8 */  lw       $v0,184($sp)
/* 800BF270 00000000 */  nop      
/* 800BF274 a3a20032 */  sb       $v0,50($sp)
/* 800BF278 8fa200bc */  lw       $v0,188($sp)
/* 800BF27C 00000000 */  nop      
/* 800BF280 a3a20033 */  sb       $v0,51($sp)
/* 800BF284 24020001 */  li       $v0,1
/* 800BF288 0802fca5 */  j        .L800BF294
/* 800BF28C a3a20030 */  sb       $v0,48($sp)
.L800BF290:
/* 800BF290 a3a00030 */  sb       $zero,48($sp)
.L800BF294:
/* 800BF294 0c03b99b */  jal      func_800EE66C
/* 800BF298 27a40018 */  addiu    $a0,$sp,24
.L800BF29C:
/* 800BF29C 12a00014 */  beqz     $s5,.L800BF2F0
/* 800BF2A0 02202821 */  move     $a1,$s1
/* 800BF2A4 27a40018 */  addiu    $a0,$sp,24
/* 800BF2A8 02403021 */  move     $a2,$s2
/* 800BF2AC 02603821 */  move     $a3,$s3
/* 800BF2B0 0c03cb1a */  jal      func_800F2C68
/* 800BF2B4 afb40010 */  sw       $s4,16($sp)
/* 800BF2B8 00002021 */  move     $a0,$zero
/* 800BF2BC 24020015 */  li       $v0,21
/* 800BF2C0 a7a20022 */  sh       $v0,34($sp)
/* 800BF2C4 24020100 */  li       $v0,256
/* 800BF2C8 0c03b84b */  jal      func_800EE12C
/* 800BF2CC a7a20026 */  sh       $v0,38($sp)
/* 800BF2D0 0c03b9cb */  jal      func_800EE72C
/* 800BF2D4 27a40018 */  addiu    $a0,$sp,24
/* 800BF2D8 3c048014 */  lui      $a0,0x8014
/* 800BF2DC 8c84efd0 */  lw       $a0,-4144($a0)
/* 800BF2E0 0c03a397 */  jal      func_800E8E5C
/* 800BF2E4 00042043 */  sra      $a0,$a0,0x1
/* 800BF2E8 0c03b84b */  jal      func_800EE12C
/* 800BF2EC 24040001 */  li       $a0,1
.L800BF2F0:
/* 800BF2F0 8fbf0090 */  lw       $ra,144($sp)
/* 800BF2F4 8fb5008c */  lw       $s5,140($sp)
/* 800BF2F8 8fb40088 */  lw       $s4,136($sp)
/* 800BF2FC 8fb30084 */  lw       $s3,132($sp)
/* 800BF300 8fb20080 */  lw       $s2,128($sp)
/* 800BF304 8fb1007c */  lw       $s1,124($sp)
/* 800BF308 8fb00078 */  lw       $s0,120($sp)
/* 800BF30C 03e00008 */  jr       $ra
/* 800BF310 27bd0098 */  addiu    $sp,$sp,152
