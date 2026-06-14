.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpacketfreeframes, 0x60

glabel iSNDpacketfreeframes
    /* F3BC4 801033C4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F3BC8 801033C8 1580033C */  lui        $v1, %hi(sndpps)
    /* F3BCC 801033CC 74856324 */  addiu      $v1, $v1, %lo(sndpps)
    /* F3BD0 801033D0 80100400 */  sll        $v0, $a0, 2
    /* F3BD4 801033D4 21104300 */  addu       $v0, $v0, $v1
    /* F3BD8 801033D8 1000BFAF */  sw         $ra, 0x10($sp)
    /* F3BDC 801033DC 0000438C */  lw         $v1, 0x0($v0)
    /* F3BE0 801033E0 00000000 */  nop
    /* F3BE4 801033E4 26006290 */  lbu        $v0, 0x26($v1)
    /* F3BE8 801033E8 0100A524 */  addiu      $a1, $a1, 0x1
    /* F3BEC 801033EC 0900A214 */  bne        $a1, $v0, .L80103414
    /* F3BF0 801033F0 00000000 */   nop
    /* F3BF4 801033F4 1400628C */  lw         $v0, 0x14($v1)
    /* F3BF8 801033F8 2000678C */  lw         $a3, 0x20($v1)
    /* F3BFC 801033FC 23104600 */  subu       $v0, $v0, $a2
    /* F3C00 80103400 140062AC */  sw         $v0, 0x14($v1)
    /* F3C04 80103404 0300E010 */  beqz       $a3, .L80103414
    /* F3C08 80103408 00000000 */   nop
    /* F3C0C 8010340C 09F8E000 */  jalr       $a3
    /* F3C10 80103410 2128C000 */   addu      $a1, $a2, $zero
  .L80103414:
    /* F3C14 80103414 1000BF8F */  lw         $ra, 0x10($sp)
    /* F3C18 80103418 00000000 */  nop
    /* F3C1C 8010341C 0800E003 */  jr         $ra
    /* F3C20 80103420 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDpacketfreeframes
