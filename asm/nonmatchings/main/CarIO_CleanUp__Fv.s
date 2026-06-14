.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_CleanUp__Fv, 0x28

glabel CarIO_CleanUp__Fv
    /* AC77C 800BBF7C D011848F */  lw         $a0, %gp_rel(CarIO_carPixMap)($gp)
    /* AC780 800BBF80 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC784 800BBF84 03008010 */  beqz       $a0, .L800BBF94
    /* AC788 800BBF88 1000BFAF */   sw        $ra, 0x10($sp)
    /* AC78C 800BBF8C 5095030C */  jal        purgememadr
    /* AC790 800BBF90 00000000 */   nop
  .L800BBF94:
    /* AC794 800BBF94 1000BF8F */  lw         $ra, 0x10($sp)
    /* AC798 800BBF98 D01180AF */  sw         $zero, %gp_rel(CarIO_carPixMap)($gp)
    /* AC79C 800BBF9C 0800E003 */  jr         $ra
    /* AC7A0 800BBFA0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CarIO_CleanUp__Fv
