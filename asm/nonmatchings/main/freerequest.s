.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching freerequest, 0x9C

glabel freerequest
    /* ECD48 800FC548 4C00828C */  lw         $v0, 0x4C($a0)
    /* ECD4C 800FC54C 00000000 */  nop
    /* ECD50 800FC550 0400A214 */  bne        $a1, $v0, .L800FC564
    /* ECD54 800FC554 00000000 */   nop
    /* ECD58 800FC558 0C00A28C */  lw         $v0, 0xC($a1)
    /* ECD5C 800FC55C 5DF10308 */  j          .L800FC574
    /* ECD60 800FC560 4C0082AC */   sw        $v0, 0x4C($a0)
  .L800FC564:
    /* ECD64 800FC564 0800A38C */  lw         $v1, 0x8($a1)
    /* ECD68 800FC568 0C00A28C */  lw         $v0, 0xC($a1)
    /* ECD6C 800FC56C 00000000 */  nop
    /* ECD70 800FC570 0C0062AC */  sw         $v0, 0xC($v1)
  .L800FC574:
    /* ECD74 800FC574 5400828C */  lw         $v0, 0x54($a0)
    /* ECD78 800FC578 00000000 */  nop
    /* ECD7C 800FC57C 0400A214 */  bne        $a1, $v0, .L800FC590
    /* ECD80 800FC580 00000000 */   nop
    /* ECD84 800FC584 0800A28C */  lw         $v0, 0x8($a1)
    /* ECD88 800FC588 68F10308 */  j          .L800FC5A0
    /* ECD8C 800FC58C 540082AC */   sw        $v0, 0x54($a0)
  .L800FC590:
    /* ECD90 800FC590 0C00A38C */  lw         $v1, 0xC($a1)
    /* ECD94 800FC594 0800A28C */  lw         $v0, 0x8($a1)
    /* ECD98 800FC598 00000000 */  nop
    /* ECD9C 800FC59C 080062AC */  sw         $v0, 0x8($v1)
  .L800FC5A0:
    /* ECDA0 800FC5A0 5000828C */  lw         $v0, 0x50($a0)
    /* ECDA4 800FC5A4 00000000 */  nop
    /* ECDA8 800FC5A8 0800A214 */  bne        $a1, $v0, .L800FC5CC
    /* ECDAC 800FC5AC 00000000 */   nop
    /* ECDB0 800FC5B0 0C00A28C */  lw         $v0, 0xC($a1)
    /* ECDB4 800FC5B4 00000000 */  nop
    /* ECDB8 800FC5B8 02004014 */  bnez       $v0, .L800FC5C4
    /* ECDBC 800FC5BC 00000000 */   nop
    /* ECDC0 800FC5C0 0800A28C */  lw         $v0, 0x8($a1)
  .L800FC5C4:
    /* ECDC4 800FC5C4 00000000 */  nop
    /* ECDC8 800FC5C8 500082AC */  sw         $v0, 0x50($a0)
  .L800FC5CC:
    /* ECDCC 800FC5CC 0400A0AC */  sw         $zero, 0x4($a1)
    /* ECDD0 800FC5D0 5800828C */  lw         $v0, 0x58($a0)
    /* ECDD4 800FC5D4 00000000 */  nop
    /* ECDD8 800FC5D8 0C00A2AC */  sw         $v0, 0xC($a1)
    /* ECDDC 800FC5DC 0800E003 */  jr         $ra
    /* ECDE0 800FC5E0 580085AC */   sw        $a1, 0x58($a0)
endlabel freerequest
