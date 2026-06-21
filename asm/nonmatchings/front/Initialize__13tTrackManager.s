.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__13tTrackManager, 0x40

glabel Initialize__13tTrackManager
    /* 12210 80021A10 21280000 */  addu       $a1, $zero, $zero
    /* 12214 80021A14 000080AC */  sw         $zero, 0x0($a0)
    /* 12218 80021A18 040080AC */  sw         $zero, 0x4($a0)
  .L80021A1C:
    /* 1221C 80021A1C 001C0500 */  sll        $v1, $a1, 16
    /* 12220 80021A20 0100A224 */  addiu      $v0, $a1, 0x1
    /* 12224 80021A24 21284000 */  addu       $a1, $v0, $zero
    /* 12228 80021A28 831B0300 */  sra        $v1, $v1, 14
    /* 1222C 80021A2C 21188300 */  addu       $v1, $a0, $v1
    /* 12230 80021A30 00140200 */  sll        $v0, $v0, 16
    /* 12234 80021A34 03140200 */  sra        $v0, $v0, 16
    /* 12238 80021A38 10004228 */  slti       $v0, $v0, 0x10
    /* 1223C 80021A3C 080060AC */  sw         $zero, 0x8($v1)
    /* 12240 80021A40 F6FF4014 */  bnez       $v0, .L80021A1C
    /* 12244 80021A44 480060AC */   sw        $zero, 0x48($v1)
    /* 12248 80021A48 0800E003 */  jr         $ra
    /* 1224C 80021A4C 00000000 */   nop
endlabel Initialize__13tTrackManager
