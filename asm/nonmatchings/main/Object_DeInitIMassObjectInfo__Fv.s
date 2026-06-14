.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_DeInitIMassObjectInfo__Fv, 0x28

glabel Object_DeInitIMassObjectInfo__Fv
    /* 967DC 800A5FDC 8C0D848F */  lw         $a0, %gp_rel(Object_IMassObjInst)($gp)
    /* 967E0 800A5FE0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 967E4 800A5FE4 03008010 */  beqz       $a0, .L800A5FF4
    /* 967E8 800A5FE8 1000BFAF */   sw        $ra, 0x10($sp)
    /* 967EC 800A5FEC 5095030C */  jal        purgememadr
    /* 967F0 800A5FF0 00000000 */   nop
  .L800A5FF4:
    /* 967F4 800A5FF4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 967F8 800A5FF8 00000000 */  nop
    /* 967FC 800A5FFC 0800E003 */  jr         $ra
    /* 96800 800A6000 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Object_DeInitIMassObjectInfo__Fv
