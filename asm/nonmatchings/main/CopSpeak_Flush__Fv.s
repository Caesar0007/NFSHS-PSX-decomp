.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Flush__Fv, 0x50

glabel CopSpeak_Flush__Fv
    /* 8B144 8009A944 800B838F */  lw         $v1, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B148 8009A948 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B14C 8009A94C 00000000 */  nop
    /* 8B150 8009A950 0E006210 */  beq        $v1, $v0, .L8009A98C
    /* 8B154 8009A954 1180023C */   lui       $v0, %hi(CopSpeak_gQueue)
    /* 8B158 8009A958 241F4624 */  addiu      $a2, $v0, %lo(CopSpeak_gQueue)
    /* 8B15C 8009A95C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 8B160 8009A960 40110300 */  sll        $v0, $v1, 5
  .L8009A964:
    /* 8B164 8009A964 21104600 */  addu       $v0, $v0, $a2
    /* 8B168 8009A968 1E0045A0 */  sb         $a1, 0x1E($v0)
    /* 8B16C 8009A96C 3F006228 */  slti       $v0, $v1, 0x3F
    /* 8B170 8009A970 02004010 */  beqz       $v0, .L8009A97C
    /* 8B174 8009A974 21200000 */   addu      $a0, $zero, $zero
    /* 8B178 8009A978 01006424 */  addiu      $a0, $v1, 0x1
  .L8009A97C:
    /* 8B17C 8009A97C 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B180 8009A980 21188000 */  addu       $v1, $a0, $zero
    /* 8B184 8009A984 F7FF6214 */  bne        $v1, $v0, .L8009A964
    /* 8B188 8009A988 40110300 */   sll       $v0, $v1, 5
  .L8009A98C:
    /* 8B18C 8009A98C 0800E003 */  jr         $ra
    /* 8B190 8009A990 00000000 */   nop
endlabel CopSpeak_Flush__Fv
