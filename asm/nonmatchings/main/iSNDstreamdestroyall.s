.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamdestroyall, 0x34

glabel iSNDstreamdestroyall
    /* D9414 800E8C14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D9418 800E8C18 1000B0AF */  sw         $s0, 0x10($sp)
    /* D941C 800E8C1C 21800000 */  addu       $s0, $zero, $zero
    /* D9420 800E8C20 1400BFAF */  sw         $ra, 0x14($sp)
  .L800E8C24:
    /* D9424 800E8C24 DCA6030C */  jal        SNDSTRM_destroy
    /* D9428 800E8C28 21200002 */   addu      $a0, $s0, $zero
    /* D942C 800E8C2C 01001026 */  addiu      $s0, $s0, 0x1
    /* D9430 800E8C30 FCFF001A */  blez       $s0, .L800E8C24
    /* D9434 800E8C34 21100000 */   addu      $v0, $zero, $zero
    /* D9438 800E8C38 1400BF8F */  lw         $ra, 0x14($sp)
    /* D943C 800E8C3C 1000B08F */  lw         $s0, 0x10($sp)
    /* D9440 800E8C40 0800E003 */  jr         $ra
    /* D9444 800E8C44 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDstreamdestroyall
