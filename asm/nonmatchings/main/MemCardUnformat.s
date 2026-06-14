.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardUnformat, 0xB4

glabel MemCardUnformat
    /* EC868 800FC068 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* EC86C 800FC06C 1480023C */  lui        $v0, %hi(D_80147518)
    /* EC870 800FC070 18754224 */  addiu      $v0, $v0, %lo(D_80147518)
    /* EC874 800FC074 9800BFAF */  sw         $ra, 0x98($sp)
    /* EC878 800FC078 9400B1AF */  sw         $s1, 0x94($sp)
    /* EC87C 800FC07C 9000B0AF */  sw         $s0, 0x90($sp)
    /* EC880 800FC080 0000428C */  lw         $v0, 0x0($v0)
    /* EC884 800FC084 00000000 */  nop
    /* EC888 800FC088 08004010 */  beqz       $v0, .L800FC0AC
    /* EC88C 800FC08C 21888000 */   addu      $s1, $a0, $zero
    /* EC890 800FC090 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EC894 800FC094 2B0A040C */  jal        printf
    /* EC898 800FC098 C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
    /* EC89C 800FC09C 42F00308 */  j          .L800FC108
    /* EC8A0 800FC0A0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800FC0A4:
    /* EC8A4 800FC0A4 42F00308 */  j          .L800FC108
    /* EC8A8 800FC0A8 21100000 */   addu      $v0, $zero, $zero
  .L800FC0AC:
    /* EC8AC 800FC0AC FFFF0324 */  addiu      $v1, $zero, -0x1
    /* EC8B0 800FC0B0 7F001024 */  addiu      $s0, $zero, 0x7F
    /* EC8B4 800FC0B4 8F00A227 */  addiu      $v0, $sp, 0x8F
  .L800FC0B8:
    /* EC8B8 800FC0B8 000043A0 */  sb         $v1, 0x0($v0)
    /* EC8BC 800FC0BC FFFF1026 */  addiu      $s0, $s0, -0x1
    /* EC8C0 800FC0C0 FDFF0106 */  bgez       $s0, .L800FC0B8
    /* EC8C4 800FC0C4 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* EC8C8 800FC0C8 21800000 */  addu       $s0, $zero, $zero
  .L800FC0CC:
    /* EC8CC 800FC0CC 3426040C */  jal        _clr_card_event
    /* EC8D0 800FC0D0 00000000 */   nop
    /* EC8D4 800FC0D4 2428040C */  jal        _new_card
    /* EC8D8 800FC0D8 00000000 */   nop
    /* EC8DC 800FC0DC 21202002 */  addu       $a0, $s1, $zero
    /* EC8E0 800FC0E0 21280002 */  addu       $a1, $s0, $zero
    /* EC8E4 800FC0E4 2828040C */  jal        _card_write
    /* EC8E8 800FC0E8 1000A627 */   addiu     $a2, $sp, 0x10
    /* EC8EC 800FC0EC AC26040C */  jal        _get_card_event_x
    /* EC8F0 800FC0F0 00000000 */   nop
    /* EC8F4 800FC0F4 EBFF4014 */  bnez       $v0, .L800FC0A4
    /* EC8F8 800FC0F8 01001026 */   addiu     $s0, $s0, 0x1
    /* EC8FC 800FC0FC 0F00022A */  slti       $v0, $s0, 0xF
    /* EC900 800FC100 F2FF4014 */  bnez       $v0, .L800FC0CC
    /* EC904 800FC104 01000224 */   addiu     $v0, $zero, 0x1
  .L800FC108:
    /* EC908 800FC108 9800BF8F */  lw         $ra, 0x98($sp)
    /* EC90C 800FC10C 9400B18F */  lw         $s1, 0x94($sp)
    /* EC910 800FC110 9000B08F */  lw         $s0, 0x90($sp)
    /* EC914 800FC114 0800E003 */  jr         $ra
    /* EC918 800FC118 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel MemCardUnformat
