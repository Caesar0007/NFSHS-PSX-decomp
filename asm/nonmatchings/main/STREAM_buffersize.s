.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_buffersize, 0x48

glabel STREAM_buffersize
    /* EE498 800FDC98 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE49C 800FDC9C 1800BFAF */  sw         $ra, 0x18($sp)
    /* EE4A0 800FDCA0 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE4A4 800FDCA4 BEF0030C */  jal        func_800FC2F8
    /* EE4A8 800FDCA8 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE4AC 800FDCAC 07004014 */  bnez       $v0, .L800FDCCC
    /* EE4B0 800FDCB0 00000000 */   nop
    /* EE4B4 800FDCB4 1000A28F */  lw         $v0, 0x10($sp)
    /* EE4B8 800FDCB8 00000000 */  nop
    /* EE4BC 800FDCBC 2400438C */  lw         $v1, 0x24($v0)
    /* EE4C0 800FDCC0 2000428C */  lw         $v0, 0x20($v0)
    /* EE4C4 800FDCC4 34F70308 */  j          .L800FDCD0
    /* EE4C8 800FDCC8 23106200 */   subu      $v0, $v1, $v0
  .L800FDCCC:
    /* EE4CC 800FDCCC 21100000 */  addu       $v0, $zero, $zero
  .L800FDCD0:
    /* EE4D0 800FDCD0 1800BF8F */  lw         $ra, 0x18($sp)
    /* EE4D4 800FDCD4 00000000 */  nop
    /* EE4D8 800FDCD8 0800E003 */  jr         $ra
    /* EE4DC 800FDCDC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_buffersize
