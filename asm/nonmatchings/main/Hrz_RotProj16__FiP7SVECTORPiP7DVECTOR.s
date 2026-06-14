.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR, 0x44

glabel Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
    /* C116C 800D096C 0E008010 */  beqz       $a0, .L800D09A8
    /* C1170 800D0970 FFFF8224 */   addiu     $v0, $a0, -0x1
    /* C1174 800D0974 FFFF0324 */  addiu      $v1, $zero, -0x1
  .L800D0978:
    /* C1178 800D0978 0000A0C8 */  lwc2       $0, 0x0($a1)
    /* C117C 800D097C 0400A1C8 */  lwc2       $1, 0x4($a1)
    /* C1180 800D0980 00000000 */  nop
    /* C1184 800D0984 00000000 */  nop
    /* C1188 800D0988 0100184A */  .word 0x4A180001  /* rtps */
    /* C118C 800D098C 0800A524 */  addiu      $a1, $a1, 0x8
    /* C1190 800D0990 0000EEE8 */  swc2       $14, 0x0($a3)
    /* C1194 800D0994 0400E724 */  addiu      $a3, $a3, 0x4
    /* C1198 800D0998 0000DBE8 */  swc2       $27, 0x0($a2) /* handwritten instruction */
    /* C119C 800D099C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* C11A0 800D09A0 F5FF4314 */  bne        $v0, $v1, .L800D0978
    /* C11A4 800D09A4 0400C624 */   addiu     $a2, $a2, 0x4
  .L800D09A8:
    /* C11A8 800D09A8 0800E003 */  jr         $ra
    /* C11AC 800D09AC 00000000 */   nop
endlabel Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
