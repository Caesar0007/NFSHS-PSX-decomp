.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction, 0x30

glabel AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 60158 8006F958 0800838C */  lw         $v1, 0x8($a0)
    /* 6015C 8006F95C 07000224 */  addiu      $v0, $zero, 0x7
    /* 60160 8006F960 07006210 */  beq        $v1, $v0, .L8006F980
    /* 60164 8006F964 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 60168 8006F968 1400828C */  lw         $v0, 0x14($a0)
    /* 6016C 8006F96C 00000000 */  nop
    /* 60170 8006F970 2410A200 */  and        $v0, $a1, $v0
    /* 60174 8006F974 02004010 */  beqz       $v0, .L8006F980
    /* 60178 8006F978 00000000 */   nop
    /* 6017C 8006F97C 0C00868C */  lw         $a2, 0xC($a0)
  .L8006F980:
    /* 60180 8006F980 0800E003 */  jr         $ra
    /* 60184 8006F984 2110C000 */   addu      $v0, $a2, $zero
endlabel AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
