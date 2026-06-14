.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_GetClutId__FiPiT1, 0x6C

glabel Texture_GetClutId__FiPiT1
    /* D0138 800DF938 09008014 */  bnez       $a0, .L800DF960
    /* D013C 800DF93C 21180000 */   addu      $v1, $zero, $zero
    /* D0140 800DF940 E415828F */  lw         $v0, %gp_rel(gNbFreePal4)($gp)
    /* D0144 800DF944 00000000 */  nop
    /* D0148 800DF948 0E004010 */  beqz       $v0, .L800DF984
    /* D014C 800DF94C FFFF4224 */   addiu     $v0, $v0, -0x1
    /* D0150 800DF950 E015838F */  lw         $v1, %gp_rel(gFreePal4)($gp)
    /* D0154 800DF954 E41582AF */  sw         $v0, %gp_rel(gNbFreePal4)($gp)
    /* D0158 800DF958 5F7E0308 */  j          .L800DF97C
    /* D015C 800DF95C 40100200 */   sll       $v0, $v0, 1
  .L800DF960:
    /* D0160 800DF960 EC15828F */  lw         $v0, %gp_rel(gNbFreePal8)($gp)
    /* D0164 800DF964 00000000 */  nop
    /* D0168 800DF968 06004010 */  beqz       $v0, .L800DF984
    /* D016C 800DF96C FFFF4224 */   addiu     $v0, $v0, -0x1
    /* D0170 800DF970 E815838F */  lw         $v1, %gp_rel(gFreePal8)($gp)
    /* D0174 800DF974 EC1582AF */  sw         $v0, %gp_rel(gNbFreePal8)($gp)
    /* D0178 800DF978 40100200 */  sll        $v0, $v0, 1
  .L800DF97C:
    /* D017C 800DF97C 21104300 */  addu       $v0, $v0, $v1
    /* D0180 800DF980 00004394 */  lhu        $v1, 0x0($v0)
  .L800DF984:
    /* D0184 800DF984 00000000 */  nop
    /* D0188 800DF988 3F006230 */  andi       $v0, $v1, 0x3F
    /* D018C 800DF98C 00110200 */  sll        $v0, $v0, 4
    /* D0190 800DF990 0000A2AC */  sw         $v0, 0x0($a1)
    /* D0194 800DF994 00140300 */  sll        $v0, $v1, 16
    /* D0198 800DF998 83150200 */  sra        $v0, $v0, 22
    /* D019C 800DF99C 0800E003 */  jr         $ra
    /* D01A0 800DF9A0 0000C2AC */   sw        $v0, 0x0($a2)
endlabel Texture_GetClutId__FiPiT1
