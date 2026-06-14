.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDrawStp, 0x28

glabel SetDrawStp
    /* DEB94 800EE394 02000224 */  addiu      $v0, $zero, 0x2
    /* DEB98 800EE398 0400A010 */  beqz       $a1, .L800EE3AC
    /* DEB9C 800EE39C 030082A0 */   sb        $v0, 0x3($a0)
    /* DEBA0 800EE3A0 00E6023C */  lui        $v0, (0xE6000001 >> 16)
    /* DEBA4 800EE3A4 ECB80308 */  j          .L800EE3B0
    /* DEBA8 800EE3A8 01004234 */   ori       $v0, $v0, (0xE6000001 & 0xFFFF)
  .L800EE3AC:
    /* DEBAC 800EE3AC 00E6023C */  lui        $v0, (0xE6000000 >> 16)
  .L800EE3B0:
    /* DEBB0 800EE3B0 040082AC */  sw         $v0, 0x4($a0)
    /* DEBB4 800EE3B4 0800E003 */  jr         $ra
    /* DEBB8 800EE3B8 080080AC */   sw        $zero, 0x8($a0)
endlabel SetDrawStp
