.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindObjInstanceFromSerialNum__FP5Groupi, 0x70

glabel FindObjInstanceFromSerialNum__FP5Groupi
    /* 9548C 800A4C8C 82FFA224 */  addiu      $v0, $a1, -0x7E
    /* 95490 800A4C90 0200422C */  sltiu      $v0, $v0, 0x2
    /* 95494 800A4C94 03004010 */  beqz       $v0, .L800A4CA4
    /* 95498 800A4C98 8000A230 */   andi      $v0, $a1, 0x80
  .L800A4C9C:
    /* 9549C 800A4C9C 0800E003 */  jr         $ra
    /* 954A0 800A4CA0 21100000 */   addu      $v0, $zero, $zero
  .L800A4CA4:
    /* 954A4 800A4CA4 06004010 */  beqz       $v0, .L800A4CC0
    /* 954A8 800A4CA8 7FFF0324 */   addiu     $v1, $zero, -0x81
    /* 954AC 800A4CAC 7C0D848F */  lw         $a0, %gp_rel(Object_customObjInst)($gp)
    /* 954B0 800A4CB0 00000000 */  nop
    /* 954B4 800A4CB4 0000828C */  lw         $v0, 0x0($a0)
    /* 954B8 800A4CB8 31930208 */  j          .L800A4CC4
    /* 954BC 800A4CBC 2428A300 */   and       $a1, $a1, $v1
  .L800A4CC0:
    /* 954C0 800A4CC0 0000828C */  lw         $v0, 0x0($a0)
  .L800A4CC4:
    /* 954C4 800A4CC4 00000000 */  nop
    /* 954C8 800A4CC8 2A10A200 */  slt        $v0, $a1, $v0
    /* 954CC 800A4CCC F3FF4010 */  beqz       $v0, .L800A4C9C
    /* 954D0 800A4CD0 FFFFA524 */   addiu     $a1, $a1, -0x1
    /* 954D4 800A4CD4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 954D8 800A4CD8 0600A210 */  beq        $a1, $v0, .L800A4CF4
    /* 954DC 800A4CDC 04008424 */   addiu     $a0, $a0, 0x4
    /* 954E0 800A4CE0 21184000 */  addu       $v1, $v0, $zero
  .L800A4CE4:
    /* 954E4 800A4CE4 00008284 */  lh         $v0, 0x0($a0)
    /* 954E8 800A4CE8 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* 954EC 800A4CEC FDFFA314 */  bne        $a1, $v1, .L800A4CE4
    /* 954F0 800A4CF0 21208200 */   addu      $a0, $a0, $v0
  .L800A4CF4:
    /* 954F4 800A4CF4 0800E003 */  jr         $ra
    /* 954F8 800A4CF8 21108000 */   addu      $v0, $a0, $zero
endlabel FindObjInstanceFromSerialNum__FP5Groupi
