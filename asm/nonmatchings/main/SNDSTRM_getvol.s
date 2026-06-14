.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_getvol, 0x5C

glabel SNDSTRM_getvol
    /* D8BEC 800E83EC 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D8BF0 800E83F0 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D8BF4 800E83F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D8BF8 800E83F8 1400BFAF */  sw         $ra, 0x14($sp)
    /* D8BFC 800E83FC 03004014 */  bnez       $v0, .L800E840C
    /* D8C00 800E8400 1000B0AF */   sw        $s0, 0x10($sp)
    /* D8C04 800E8404 0EA10308 */  j          .L800E8438
    /* D8C08 800E8408 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E840C:
    /* D8C0C 800E840C 12A3030C */  jal        iSNDstreamgetstreamptr
    /* D8C10 800E8410 00000000 */   nop
    /* D8C14 800E8414 21804000 */  addu       $s0, $v0, $zero
    /* D8C18 800E8418 07000012 */  beqz       $s0, .L800E8438
    /* D8C1C 800E841C F8FF0224 */   addiu     $v0, $zero, -0x8
    /* D8C20 800E8420 0800048E */  lw         $a0, 0x8($s0)
    /* D8C24 800E8424 040A040C */  jal        SNDgetvol
    /* D8C28 800E8428 00000000 */   nop
    /* D8C2C 800E842C 02004104 */  bgez       $v0, .L800E8438
    /* D8C30 800E8430 00000000 */   nop
    /* D8C34 800E8434 54000282 */  lb         $v0, 0x54($s0)
  .L800E8438:
    /* D8C38 800E8438 1400BF8F */  lw         $ra, 0x14($sp)
    /* D8C3C 800E843C 1000B08F */  lw         $s0, 0x10($sp)
    /* D8C40 800E8440 0800E003 */  jr         $ra
    /* D8C44 800E8444 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSTRM_getvol
