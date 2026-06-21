.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_setfilter, 0xF0

glabel STREAM_setfilter
    /* ED854 800FD054 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* ED858 800FD058 1800B0AF */  sw         $s0, 0x18($sp)
    /* ED85C 800FD05C 2180A000 */  addu       $s0, $a1, $zero
    /* ED860 800FD060 2000B2AF */  sw         $s2, 0x20($sp)
    /* ED864 800FD064 2190C000 */  addu       $s2, $a2, $zero
    /* ED868 800FD068 2400B3AF */  sw         $s3, 0x24($sp)
    /* ED86C 800FD06C 2198E000 */  addu       $s3, $a3, $zero
    /* ED870 800FD070 1000A527 */  addiu      $a1, $sp, 0x10
    /* ED874 800FD074 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* ED878 800FD078 4000B18F */  lw         $s1, 0x40($sp)
    /* ED87C 800FD07C 2800BFAF */  sw         $ra, 0x28($sp)
    /* ED880 800FD080 BEF0030C */  jal        validatehandle
    /* ED884 800FD084 1400A627 */   addiu     $a2, $sp, 0x14
    /* ED888 800FD088 27004014 */  bnez       $v0, .L800FD128
    /* ED88C 800FD08C 00000000 */   nop
    /* ED890 800FD090 2500001A */  blez       $s0, .L800FD128
    /* ED894 800FD094 00000000 */   nop
    /* ED898 800FD098 1000A28F */  lw         $v0, 0x10($sp)
    /* ED89C 800FD09C 00000000 */  nop
    /* ED8A0 800FD0A0 1400438C */  lw         $v1, 0x14($v0)
    /* ED8A4 800FD0A4 00000000 */  nop
    /* ED8A8 800FD0A8 2A107000 */  slt        $v0, $v1, $s0
    /* ED8AC 800FD0AC 1E004014 */  bnez       $v0, .L800FD128
    /* ED8B0 800FD0B0 00000000 */   nop
    /* ED8B4 800FD0B4 03000316 */  bne        $s0, $v1, .L800FD0C4
    /* ED8B8 800FD0B8 25105302 */   or        $v0, $s2, $s3
    /* ED8BC 800FD0BC 1A004014 */  bnez       $v0, .L800FD128
    /* ED8C0 800FD0C0 00000000 */   nop
  .L800FD0C4:
    /* ED8C4 800FD0C4 0500201E */  bgtz       $s1, .L800FD0DC
    /* ED8C8 800FD0C8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* ED8CC 800FD0CC 03002212 */  beq        $s1, $v0, .L800FD0DC
    /* ED8D0 800FD0D0 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* ED8D4 800FD0D4 14002216 */  bne        $s1, $v0, .L800FD128
    /* ED8D8 800FD0D8 00000000 */   nop
  .L800FD0DC:
    /* ED8DC 800FD0DC 1000A38F */  lw         $v1, 0x10($sp)
    /* ED8E0 800FD0E0 00000000 */  nop
    /* ED8E4 800FD0E4 1C00628C */  lw         $v0, 0x1C($v1)
    /* ED8E8 800FD0E8 00000000 */  nop
    /* ED8EC 800FD0EC 2A105100 */  slt        $v0, $v0, $s1
    /* ED8F0 800FD0F0 0D004014 */  bnez       $v0, .L800FD128
    /* ED8F4 800FD0F4 00000000 */   nop
    /* ED8F8 800FD0F8 2800628C */  lw         $v0, 0x28($v1)
    /* ED8FC 800FD0FC 00000000 */  nop
    /* ED900 800FD100 09004014 */  bnez       $v0, .L800FD128
    /* ED904 800FD104 40101000 */   sll       $v0, $s0, 1
    /* ED908 800FD108 21105000 */  addu       $v0, $v0, $s0
    /* ED90C 800FD10C 80100200 */  sll        $v0, $v0, 2
    /* ED910 800FD110 1000638C */  lw         $v1, 0x10($v1)
    /* ED914 800FD114 F4FF4224 */  addiu      $v0, $v0, -0xC
    /* ED918 800FD118 21186200 */  addu       $v1, $v1, $v0
    /* ED91C 800FD11C 000072AC */  sw         $s2, 0x0($v1)
    /* ED920 800FD120 040073AC */  sw         $s3, 0x4($v1)
    /* ED924 800FD124 080071AC */  sw         $s1, 0x8($v1)
  .L800FD128:
    /* ED928 800FD128 2800BF8F */  lw         $ra, 0x28($sp)
    /* ED92C 800FD12C 2400B38F */  lw         $s3, 0x24($sp)
    /* ED930 800FD130 2000B28F */  lw         $s2, 0x20($sp)
    /* ED934 800FD134 1C00B18F */  lw         $s1, 0x1C($sp)
    /* ED938 800FD138 1800B08F */  lw         $s0, 0x18($sp)
    /* ED93C 800FD13C 0800E003 */  jr         $ra
    /* ED940 800FD140 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel STREAM_setfilter
