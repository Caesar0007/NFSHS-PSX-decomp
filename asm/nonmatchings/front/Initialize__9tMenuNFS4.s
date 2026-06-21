.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__9tMenuNFS4, 0xB0

glabel Initialize__9tMenuNFS4
    /* B980 8001B180 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* B984 8001B184 1000B0AF */  sw         $s0, 0x10($sp)
    /* B988 8001B188 1400BFAF */  sw         $ra, 0x14($sp)
    /* B98C 8001B18C 3995000C */  jal        Initialize__5tMenu
    /* B990 8001B190 21808000 */   addu      $s0, $a0, $zero
    /* B994 8001B194 08000292 */  lbu        $v0, 0x8($s0)
    /* B998 8001B198 1000038E */  lw         $v1, 0x10($s0)
    /* B99C 8001B19C 6C0000AE */  sw         $zero, 0x6C($s0)
    /* B9A0 8001B1A0 700000AE */  sw         $zero, 0x70($s0)
    /* B9A4 8001B1A4 780000A2 */  sb         $zero, 0x78($s0)
    /* B9A8 8001B1A8 0C006010 */  beqz       $v1, .L8001B1DC
    /* B9AC 8001B1AC 770002A2 */   sb        $v0, 0x77($s0)
  .L8001B1B0:
    /* B9B0 8001B1B0 78000292 */  lbu        $v0, 0x78($s0)
    /* B9B4 8001B1B4 00000000 */  nop
    /* B9B8 8001B1B8 01004224 */  addiu      $v0, $v0, 0x1
    /* B9BC 8001B1BC 780002A2 */  sb         $v0, 0x78($s0)
    /* B9C0 8001B1C0 FF004230 */  andi       $v0, $v0, 0xFF
    /* B9C4 8001B1C4 80100200 */  sll        $v0, $v0, 2
    /* B9C8 8001B1C8 21100202 */  addu       $v0, $s0, $v0
    /* B9CC 8001B1CC 1000428C */  lw         $v0, 0x10($v0)
    /* B9D0 8001B1D0 00000000 */  nop
    /* B9D4 8001B1D4 F6FF4014 */  bnez       $v0, .L8001B1B0
    /* B9D8 8001B1D8 00000000 */   nop
  .L8001B1DC:
    /* B9DC 8001B1DC 0000028E */  lw         $v0, 0x0($s0)
    /* B9E0 8001B1E0 00000000 */  nop
    /* B9E4 8001B1E4 00024230 */  andi       $v0, $v0, 0x200
    /* B9E8 8001B1E8 0D004010 */  beqz       $v0, .L8001B220
    /* B9EC 8001B1EC 21200000 */   addu      $a0, $zero, $zero
  .L8001B1F0:
    /* B9F0 8001B1F0 00140400 */  sll        $v0, $a0, 16
    /* B9F4 8001B1F4 83130200 */  sra        $v0, $v0, 14
    /* B9F8 8001B1F8 21100202 */  addu       $v0, $s0, $v0
    /* B9FC 8001B1FC 1000438C */  lw         $v1, 0x10($v0)
    /* BA00 8001B200 00000000 */  nop
    /* BA04 8001B204 06006010 */  beqz       $v1, .L8001B220
    /* BA08 8001B208 01008424 */   addiu     $a0, $a0, 0x1
    /* BA0C 8001B20C 0000628C */  lw         $v0, 0x0($v1)
    /* BA10 8001B210 00000000 */  nop
    /* BA14 8001B214 00024234 */  ori        $v0, $v0, 0x200
    /* BA18 8001B218 7C6C0008 */  j          .L8001B1F0
    /* BA1C 8001B21C 000062AC */   sw        $v0, 0x0($v1)
  .L8001B220:
    /* BA20 8001B220 1400BF8F */  lw         $ra, 0x14($sp)
    /* BA24 8001B224 1000B08F */  lw         $s0, 0x10($sp)
    /* BA28 8001B228 0800E003 */  jr         $ra
    /* BA2C 8001B22C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__9tMenuNFS4
