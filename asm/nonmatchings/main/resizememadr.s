.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching resizememadr, 0x178

glabel resizememadr
    /* E2150 800F1950 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* E2154 800F1954 3800B6AF */  sw         $s6, 0x38($sp)
    /* E2158 800F1958 21B08000 */  addu       $s6, $a0, $zero
    /* E215C 800F195C 3000B4AF */  sw         $s4, 0x30($sp)
    /* E2160 800F1960 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* E2164 800F1964 F0FFD326 */  addiu      $s3, $s6, -0x10
    /* E2168 800F1968 1480023C */  lui        $v0, %hi(memclass)
    /* E216C 800F196C 00E94224 */  addiu      $v0, $v0, %lo(memclass)
    /* E2170 800F1970 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* E2174 800F1974 3400B5AF */  sw         $s5, 0x34($sp)
    /* E2178 800F1978 2800B2AF */  sw         $s2, 0x28($sp)
    /* E217C 800F197C 2400B1AF */  sw         $s1, 0x24($sp)
    /* E2180 800F1980 2000B0AF */  sw         $s0, 0x20($sp)
    /* E2184 800F1984 02007196 */  lhu        $s1, 0x2($s3)
    /* E2188 800F1988 0800728E */  lw         $s2, 0x8($s3)
    /* E218C 800F198C 0F002332 */  andi       $v1, $s1, 0xF
    /* E2190 800F1990 80180300 */  sll        $v1, $v1, 2
    /* E2194 800F1994 21186200 */  addu       $v1, $v1, $v0
    /* E2198 800F1998 02004496 */  lhu        $a0, 0x2($s2)
    /* E219C 800F199C 0000758C */  lw         $s5, 0x0($v1)
    /* E21A0 800F19A0 00408430 */  andi       $a0, $a0, 0x4000
    /* E21A4 800F19A4 07008010 */  beqz       $a0, .L800F19C4
    /* E21A8 800F19A8 21A0A000 */   addu      $s4, $a1, $zero
    /* E21AC 800F19AC 2120A002 */  addu       $a0, $s5, $zero
    /* E21B0 800F19B0 C193030C */  jal        FREE_remove
    /* E21B4 800F19B4 21284002 */   addu      $a1, $s2, $zero
    /* E21B8 800F19B8 0800528E */  lw         $s2, 0x8($s2)
    /* E21BC 800F19BC 00000000 */  nop
    /* E21C0 800F19C0 080072AE */  sw         $s2, 0x8($s3)
  .L800F19C4:
    /* E21C4 800F19C4 21808002 */  addu       $s0, $s4, $zero
    /* E21C8 800F19C8 0800022A */  slti       $v0, $s0, 0x8
    /* E21CC 800F19CC 08004010 */  beqz       $v0, .L800F19F0
    /* E21D0 800F19D0 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* E21D4 800F19D4 03000216 */  bne        $s0, $v0, .L800F19E4
    /* E21D8 800F19D8 00000000 */   nop
    /* E21DC 800F19DC 7CC60308 */  j          .L800F19F0
    /* E21E0 800F19E0 0040103C */   lui       $s0, (0x40000000 >> 16)
  .L800F19E4:
    /* E21E4 800F19E4 02000006 */  bltz       $s0, .L800F19F0
    /* E21E8 800F19E8 00000000 */   nop
    /* E21EC 800F19EC 08001024 */  addiu      $s0, $zero, 0x8
  .L800F19F0:
    /* E21F0 800F19F0 B894030C */  jal        getblockname
    /* E21F4 800F19F4 2120C002 */   addu      $a0, $s6, $zero
    /* E21F8 800F19F8 21204000 */  addu       $a0, $v0, $zero
    /* E21FC 800F19FC 0C94030C */  jal        MEM_tailsize
    /* E2200 800F1A00 21282002 */   addu      $a1, $s1, $zero
    /* E2204 800F1A04 21304000 */  addu       $a2, $v0, $zero
    /* E2208 800F1A08 2800A38E */  lw         $v1, 0x28($s5)
    /* E220C 800F1A0C 21100602 */  addu       $v0, $s0, $a2
    /* E2210 800F1A10 0F006424 */  addiu      $a0, $v1, 0xF
    /* E2214 800F1A14 21104400 */  addu       $v0, $v0, $a0
    /* E2218 800F1A18 23180300 */  negu       $v1, $v1
    /* E221C 800F1A1C 24104300 */  and        $v0, $v0, $v1
    /* E2220 800F1A20 F0FF5024 */  addiu      $s0, $v0, -0x10
    /* E2224 800F1A24 23105302 */  subu       $v0, $s2, $s3
    /* E2228 800F1A28 F0FF5124 */  addiu      $s1, $v0, -0x10
    /* E222C 800F1A2C 2A103002 */  slt        $v0, $s1, $s0
    /* E2230 800F1A30 03004010 */  beqz       $v0, .L800F1A40
    /* E2234 800F1A34 00000000 */   nop
    /* E2238 800F1A38 21802002 */  addu       $s0, $s1, $zero
    /* E223C 800F1A3C 23A02602 */  subu       $s4, $s1, $a2
  .L800F1A40:
    /* E2240 800F1A40 0400648E */  lw         $a0, 0x4($s3)
    /* E2244 800F1A44 2128D402 */  addu       $a1, $s6, $s4
    /* E2248 800F1A48 B798030C */  jal        blockmove
    /* E224C 800F1A4C 2120C402 */   addu      $a0, $s6, $a0
    /* E2250 800F1A50 23103002 */  subu       $v0, $s1, $s0
    /* E2254 800F1A54 41004228 */  slti       $v0, $v0, 0x41
    /* E2258 800F1A58 10004014 */  bnez       $v0, .L800F1A9C
    /* E225C 800F1A5C 040074AE */   sw        $s4, 0x4($s3)
    /* E2260 800F1A60 10001026 */  addiu      $s0, $s0, 0x10
    /* E2264 800F1A64 2180D002 */  addu       $s0, $s6, $s0
    /* E2268 800F1A68 21200002 */  addu       $a0, $s0, $zero
    /* E226C 800F1A6C 21280000 */  addu       $a1, $zero, $zero
    /* E2270 800F1A70 2130A000 */  addu       $a2, $a1, $zero
    /* E2274 800F1A74 2138A000 */  addu       $a3, $a1, $zero
    /* E2278 800F1A78 1000A0AF */  sw         $zero, 0x10($sp)
    /* E227C 800F1A7C 1400B3AF */  sw         $s3, 0x14($sp)
    /* E2280 800F1A80 CB93030C */  jal        initmemblock
    /* E2284 800F1A84 1800B2AF */   sw        $s2, 0x18($sp)
    /* E2288 800F1A88 2120A002 */  addu       $a0, $s5, $zero
    /* E228C 800F1A8C 9C93030C */  jal        FREE_add
    /* E2290 800F1A90 21280002 */   addu      $a1, $s0, $zero
    /* E2294 800F1A94 0C0050AE */  sw         $s0, 0xC($s2)
    /* E2298 800F1A98 080070AE */  sw         $s0, 0x8($s3)
  .L800F1A9C:
    /* E229C 800F1A9C 2110C002 */  addu       $v0, $s6, $zero
    /* E22A0 800F1AA0 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* E22A4 800F1AA4 3800B68F */  lw         $s6, 0x38($sp)
    /* E22A8 800F1AA8 3400B58F */  lw         $s5, 0x34($sp)
    /* E22AC 800F1AAC 3000B48F */  lw         $s4, 0x30($sp)
    /* E22B0 800F1AB0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* E22B4 800F1AB4 2800B28F */  lw         $s2, 0x28($sp)
    /* E22B8 800F1AB8 2400B18F */  lw         $s1, 0x24($sp)
    /* E22BC 800F1ABC 2000B08F */  lw         $s0, 0x20($sp)
    /* E22C0 800F1AC0 0800E003 */  jr         $ra
    /* E22C4 800F1AC4 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel resizememadr
