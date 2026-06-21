.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculateDimensions__12tDialogYesNo, 0xB8

glabel CalculateDimensions__12tDialogYesNo
    /* A1D4 800199D4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A1D8 800199D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* A1DC 800199DC 1400BFAF */  sw         $ra, 0x14($sp)
    /* A1E0 800199E0 0665000C */  jal        CalculateDimensions__20tDialogMessageString
    /* A1E4 800199E4 21808000 */   addu      $s0, $a0, $zero
    /* A1E8 800199E8 82000286 */  lh         $v0, 0x82($s0)
    /* A1EC 800199EC 00000000 */  nop
    /* A1F0 800199F0 22004014 */  bnez       $v0, .L80019A7C
    /* A1F4 800199F4 1480023C */   lui       $v0, %hi(ticks)
    /* A1F8 800199F8 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* A1FC 800199FC 7400028E */  lw         $v0, 0x74($s0)
    /* A200 80019A00 00000000 */  nop
    /* A204 80019A04 23206200 */  subu       $a0, $v1, $v0
    /* A208 80019A08 32008228 */  slti       $v0, $a0, 0x32
    /* A20C 80019A0C 0C004010 */  beqz       $v0, .L80019A40
    /* A210 80019A10 EB51023C */   lui       $v0, (0x51EB851F >> 16)
    /* A214 80019A14 1F854234 */  ori        $v0, $v0, (0x51EB851F & 0xFFFF)
    /* A218 80019A18 00190400 */  sll        $v1, $a0, 4
    /* A21C 80019A1C 23186400 */  subu       $v1, $v1, $a0
    /* A220 80019A20 18006200 */  mult       $v1, $v0
    /* A224 80019A24 C31F0300 */  sra        $v1, $v1, 31
    /* A228 80019A28 6C000296 */  lhu        $v0, 0x6C($s0)
    /* A22C 80019A2C 10280000 */  mfhi       $a1
    /* A230 80019A30 03210500 */  sra        $a0, $a1, 4
    /* A234 80019A34 23208300 */  subu       $a0, $a0, $v1
    /* A238 80019A38 93660008 */  j          .L80019A4C
    /* A23C 80019A3C 21104400 */   addu      $v0, $v0, $a0
  .L80019A40:
    /* A240 80019A40 6C000296 */  lhu        $v0, 0x6C($s0)
    /* A244 80019A44 00000000 */  nop
    /* A248 80019A48 0F004224 */  addiu      $v0, $v0, 0xF
  .L80019A4C:
    /* A24C 80019A4C 6C0002A6 */  sh         $v0, 0x6C($s0)
    /* A250 80019A50 6C000386 */  lh         $v1, 0x6C($s0)
    /* A254 80019A54 0F000224 */  addiu      $v0, $zero, 0xF
    /* A258 80019A58 6E0002A6 */  sh         $v0, 0x6E($s0)
    /* A25C 80019A5C F0000224 */  addiu      $v0, $zero, 0xF0
    /* A260 80019A60 23104300 */  subu       $v0, $v0, $v1
    /* A264 80019A64 C21F0200 */  srl        $v1, $v0, 31
    /* A268 80019A68 21104300 */  addu       $v0, $v0, $v1
    /* A26C 80019A6C 7E000396 */  lhu        $v1, 0x7E($s0)
    /* A270 80019A70 43100200 */  sra        $v0, $v0, 1
    /* A274 80019A74 21186200 */  addu       $v1, $v1, $v0
    /* A278 80019A78 680003A6 */  sh         $v1, 0x68($s0)
  .L80019A7C:
    /* A27C 80019A7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* A280 80019A80 1000B08F */  lw         $s0, 0x10($sp)
    /* A284 80019A84 0800E003 */  jr         $ra
    /* A288 80019A88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalculateDimensions__12tDialogYesNo
