.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi, 0xB4

glabel Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* A6B80 800B6380 21500000 */  addu       $t2, $zero, $zero
    /* A6B84 800B6384 0400828C */  lw         $v0, 0x4($a0)
    /* A6B88 800B6388 21484001 */  addu       $t1, $t2, $zero
    /* A6B8C 800B638C 01004224 */  addiu      $v0, $v0, 0x1
    /* A6B90 800B6390 22004018 */  blez       $v0, .L800B641C
    /* A6B94 800B6394 040082AC */   sw        $v0, 0x4($a0)
    /* A6B98 800B6398 00110A00 */  sll        $v0, $t2, 4
  .L800B639C:
    /* A6B9C 800B639C 21108200 */  addu       $v0, $a0, $v0
    /* A6BA0 800B63A0 0800428C */  lw         $v0, 0x8($v0)
    /* A6BA4 800B63A4 00000000 */  nop
    /* A6BA8 800B63A8 2A10E200 */  slt        $v0, $a3, $v0
    /* A6BAC 800B63AC 16004010 */  beqz       $v0, .L800B6408
    /* A6BB0 800B63B0 21484001 */   addu      $t1, $t2, $zero
    /* A6BB4 800B63B4 0400828C */  lw         $v0, 0x4($a0)
    /* A6BB8 800B63B8 00000000 */  nop
    /* A6BBC 800B63BC FFFF4824 */  addiu      $t0, $v0, -0x1
    /* A6BC0 800B63C0 2A102801 */  slt        $v0, $t1, $t0
    /* A6BC4 800B63C4 15004010 */  beqz       $v0, .L800B641C
    /* A6BC8 800B63C8 00110800 */   sll       $v0, $t0, 4
    /* A6BCC 800B63CC 21184400 */  addu       $v1, $v0, $a0
  .L800B63D0:
    /* A6BD0 800B63D0 F8FF6B8C */  lw         $t3, -0x8($v1)
    /* A6BD4 800B63D4 FCFF6C8C */  lw         $t4, -0x4($v1)
    /* A6BD8 800B63D8 00006D8C */  lw         $t5, 0x0($v1)
    /* A6BDC 800B63DC 04006E8C */  lw         $t6, 0x4($v1)
    /* A6BE0 800B63E0 08006BAC */  sw         $t3, 0x8($v1)
    /* A6BE4 800B63E4 0C006CAC */  sw         $t4, 0xC($v1)
    /* A6BE8 800B63E8 10006DAC */  sw         $t5, 0x10($v1)
    /* A6BEC 800B63EC 14006EAC */  sw         $t6, 0x14($v1)
    /* A6BF0 800B63F0 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* A6BF4 800B63F4 2A104801 */  slt        $v0, $t2, $t0
    /* A6BF8 800B63F8 F5FF4014 */  bnez       $v0, .L800B63D0
    /* A6BFC 800B63FC F0FF6324 */   addiu     $v1, $v1, -0x10
    /* A6C00 800B6400 08D90208 */  j          .L800B6420
    /* A6C04 800B6404 00110900 */   sll       $v0, $t1, 4
  .L800B6408:
    /* A6C08 800B6408 0400828C */  lw         $v0, 0x4($a0)
    /* A6C0C 800B640C 01002A25 */  addiu      $t2, $t1, 0x1
    /* A6C10 800B6410 2A104201 */  slt        $v0, $t2, $v0
    /* A6C14 800B6414 E1FF4014 */  bnez       $v0, .L800B639C
    /* A6C18 800B6418 00110A00 */   sll       $v0, $t2, 4
  .L800B641C:
    /* A6C1C 800B641C 00110900 */  sll        $v0, $t1, 4
  .L800B6420:
    /* A6C20 800B6420 21108200 */  addu       $v0, $a0, $v0
    /* A6C24 800B6424 080047AC */  sw         $a3, 0x8($v0)
    /* A6C28 800B6428 0C0045AC */  sw         $a1, 0xC($v0)
    /* A6C2C 800B642C 0800E003 */  jr         $ra
    /* A6C30 800B6430 100046AC */   sw        $a2, 0x10($v0)
endlabel Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
