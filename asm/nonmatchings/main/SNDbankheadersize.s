.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDbankheadersize, 0x44

glabel SNDbankheadersize
    /* D8364 800E7B64 1480023C */  lui        $v0, %hi(sndgs)
    /* D8368 800E7B68 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* D836C 800E7B6C 3C006280 */  lb         $v0, 0x3C($v1)
    /* D8370 800E7B70 00000000 */  nop
    /* D8374 800E7B74 0A004010 */  beqz       $v0, .L800E7BA0
    /* D8378 800E7B78 40100400 */   sll       $v0, $a0, 1
    /* D837C 800E7B7C 21104400 */  addu       $v0, $v0, $a0
    /* D8380 800E7B80 9800638C */  lw         $v1, 0x98($v1)
    /* D8384 800E7B84 80100200 */  sll        $v0, $v0, 2
    /* D8388 800E7B88 21104300 */  addu       $v0, $v0, $v1
    /* D838C 800E7B8C 0000428C */  lw         $v0, 0x0($v0)
    /* D8390 800E7B90 00000000 */  nop
    /* D8394 800E7B94 0800428C */  lw         $v0, 0x8($v0)
    /* D8398 800E7B98 0800E003 */  jr         $ra
    /* D839C 800E7B9C 00000000 */   nop
  .L800E7BA0:
    /* D83A0 800E7BA0 0800E003 */  jr         $ra
    /* D83A4 800E7BA4 F6FF0224 */   addiu     $v0, $zero, -0xA
endlabel SNDbankheadersize
