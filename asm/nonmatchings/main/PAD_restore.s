.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PAD_restore, 0x54

glabel PAD_restore
    /* D4958 800E4158 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D495C 800E415C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D4960 800E4160 1480103C */  lui        $s0, %hi(gPadinfo)
    /* D4964 800E4164 9CE81026 */  addiu      $s0, $s0, %lo(gPadinfo)
    /* D4968 800E4168 1400BFAF */  sw         $ra, 0x14($sp)
    /* D496C 800E416C 0000028E */  lw         $v0, 0x0($s0)
    /* D4970 800E4170 00000000 */  nop
    /* D4974 800E4174 08004010 */  beqz       $v0, .L800E4198
    /* D4978 800E4178 00000000 */   nop
    /* D497C 800E417C 0E80043C */  lui        $a0, %hi(PAD_update)
    /* D4980 800E4180 10428424 */  addiu      $a0, $a0, %lo(PAD_update)
    /* D4984 800E4184 12AC030C */  jal        deltimer
    /* D4988 800E4188 00000000 */   nop
    /* D498C 800E418C A0BF030C */  jal        PadStopCom
    /* D4990 800E4190 00000000 */   nop
    /* D4994 800E4194 000000AE */  sw         $zero, 0x0($s0)
  .L800E4198:
    /* D4998 800E4198 1400BF8F */  lw         $ra, 0x14($sp)
    /* D499C 800E419C 1000B08F */  lw         $s0, 0x10($sp)
    /* D49A0 800E41A0 1800BD27 */  addiu      $sp, $sp, 0x18
    /* D49A4 800E41A4 0800E003 */  jr         $ra
    /* D49A8 800E41A8 00000000 */   nop
endlabel PAD_restore
