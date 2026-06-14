.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_DriverCleanUp__Fv, 0x7C

glabel AudioMus_DriverCleanUp__Fv
    /* 6B510 8007AD10 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B514 8007AD14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6B518 8007AD18 18004010 */  beqz       $v0, .L8007AD7C
    /* 6B51C 8007AD1C 1000BFAF */   sw        $ra, 0x10($sp)
    /* 6B520 8007AD20 7C00428C */  lw         $v0, 0x7C($v0)
    /* 6B524 8007AD24 00000000 */  nop
    /* 6B528 8007AD28 06004010 */  beqz       $v0, .L8007AD44
    /* 6B52C 8007AD2C 0880043C */   lui       $a0, %hi(AudioMus_Server__Fii)
    /* 6B530 8007AD30 EA9A030C */  jal        delsystemtask
    /* 6B534 8007AD34 D0A38424 */   addiu     $a0, $a0, %lo(AudioMus_Server__Fii)
    /* 6B538 8007AD38 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B53C 8007AD3C 00000000 */  nop
    /* 6B540 8007AD40 7C0040AC */  sw         $zero, 0x7C($v0)
  .L8007AD44:
    /* 6B544 8007AD44 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B548 8007AD48 00000000 */  nop
    /* 6B54C 8007AD4C 7400448C */  lw         $a0, 0x74($v0)
    /* 6B550 8007AD50 00000000 */  nop
    /* 6B554 8007AD54 07008004 */  bltz       $a0, .L8007AD74
    /* 6B558 8007AD58 00000000 */   nop
    /* 6B55C 8007AD5C DCA6030C */  jal        SNDSTRM_destroy
    /* 6B560 8007AD60 00000000 */   nop
    /* 6B564 8007AD64 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B568 8007AD68 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6B56C 8007AD6C 740062AC */  sw         $v0, 0x74($v1)
    /* 6B570 8007AD70 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
  .L8007AD74:
    /* 6B574 8007AD74 00000000 */  nop
    /* 6B578 8007AD78 800040AC */  sw         $zero, 0x80($v0)
  .L8007AD7C:
    /* 6B57C 8007AD7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6B580 8007AD80 00000000 */  nop
    /* 6B584 8007AD84 0800E003 */  jr         $ra
    /* 6B588 8007AD88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_DriverCleanUp__Fv
