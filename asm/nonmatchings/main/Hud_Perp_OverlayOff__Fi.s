.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Perp_OverlayOff__Fi, 0x18

glabel Hud_Perp_OverlayOff__Fi
    /* CA150 800D9950 80200400 */  sll        $a0, $a0, 2
    /* CA154 800D9954 1480023C */  lui        $v0, %hi(D_8013DE38)
    /* CA158 800D9958 38DE4224 */  addiu      $v0, $v0, %lo(D_8013DE38)
    /* CA15C 800D995C 21208200 */  addu       $a0, $a0, $v0
    /* CA160 800D9960 0800E003 */  jr         $ra
    /* CA164 800D9964 000080AC */   sw        $zero, 0x0($a0)
endlabel Hud_Perp_OverlayOff__Fi
