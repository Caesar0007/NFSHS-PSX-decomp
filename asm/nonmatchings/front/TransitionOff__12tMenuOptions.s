.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__12tMenuOptions, 0x3C

glabel TransitionOff__12tMenuOptions
    /* C5C4 8001BDC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C5C8 8001BDC8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* C5CC 8001BDCC 1000BFAF */  sw         $ra, 0x10($sp)
    /* C5D0 8001BDD0 760082A0 */  sb         $v0, 0x76($a0)
    /* C5D4 8001BDD4 1480023C */  lui        $v0, %hi(ticks)
    /* C5D8 8001BDD8 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* C5DC 8001BDDC 01000224 */  addiu      $v0, $zero, 0x1
    /* C5E0 8001BDE0 700082AC */  sw         $v0, 0x70($a0)
    /* C5E4 8001BDE4 7C0083AC */  sw         $v1, 0x7C($a0)
    /* C5E8 8001BDE8 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* C5EC 8001BDEC 12000424 */   addiu     $a0, $zero, 0x12
    /* C5F0 8001BDF0 1000BF8F */  lw         $ra, 0x10($sp)
    /* C5F4 8001BDF4 00000000 */  nop
    /* C5F8 8001BDF8 0800E003 */  jr         $ra
    /* C5FC 8001BDFC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TransitionOff__12tMenuOptions
