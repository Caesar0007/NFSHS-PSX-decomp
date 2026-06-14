.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching rdiv, 0xA8

glabel rdiv
    /* D4C04 800E4404 02008104 */  bgez       $a0, .L800E4410
    /* D4C08 800E4408 2A408000 */   slt       $t0, $a0, $zero
    /* D4C0C 800E440C 23200400 */  negu       $a0, $a0
  .L800E4410:
    /* D4C10 800E4410 0200A104 */  bgez       $a1, .L800E441C
    /* D4C14 800E4414 2A48A000 */   slt       $t1, $a1, $zero
    /* D4C18 800E4418 23280500 */  negu       $a1, $a1
  .L800E441C:
    /* D4C1C 800E441C 1B008500 */  divu       $zero, $a0, $a1
    /* D4C20 800E4420 26400901 */  xor        $t0, $t0, $t1
    /* D4C24 800E4424 23400800 */  negu       $t0, $t0
    /* D4C28 800E4428 1E00A010 */  beqz       $a1, .L800E44A4
    /* D4C2C 800E442C 01000A3C */   lui       $t2, (0x10000 >> 16)
    /* D4C30 800E4430 01000934 */  ori        $t1, $zero, 0x1
    /* D4C34 800E4434 10200000 */  mfhi       $a0
    /* D4C38 800E4438 12100000 */  mflo       $v0
    /* D4C3C 800E443C 0D008004 */  bltz       $a0, .L800E4474
    /* D4C40 800E4440 00140200 */   sll       $v0, $v0, 16
    /* D4C44 800E4444 40200400 */  sll        $a0, $a0, 1
  .L800E4448:
    /* D4C48 800E4448 0D008104 */  bgez       $a0, .L800E4480
    /* D4C4C 800E444C 2B588500 */   sltu      $t3, $a0, $a1
  .L800E4450:
    /* D4C50 800E4450 03006015 */  bnez       $t3, .L800E4460
    /* D4C54 800E4454 42500A00 */   srl       $t2, $t2, 1
    /* D4C58 800E4458 25104A00 */  or         $v0, $v0, $t2
    /* D4C5C 800E445C 23208500 */  subu       $a0, $a0, $a1
  .L800E4460:
    /* D4C60 800E4460 F9FF4915 */  bne        $t2, $t1, .L800E4448
    /* D4C64 800E4464 42280500 */   srl       $a1, $a1, 1
    /* D4C68 800E4468 26104800 */  xor        $v0, $v0, $t0
    /* D4C6C 800E446C 0800E003 */  jr         $ra
    /* D4C70 800E4470 22104800 */   sub       $v0, $v0, $t0 /* handwritten instruction */
  .L800E4474:
    /* D4C74 800E4474 42280500 */  srl        $a1, $a1, 1
  .L800E4478:
    /* D4C78 800E4478 F5FF8004 */  bltz       $a0, .L800E4450
    /* D4C7C 800E447C 2B588500 */   sltu      $t3, $a0, $a1
  .L800E4480:
    /* D4C80 800E4480 03006015 */  bnez       $t3, .L800E4490
    /* D4C84 800E4484 42500A00 */   srl       $t2, $t2, 1
    /* D4C88 800E4488 25104A00 */  or         $v0, $v0, $t2
    /* D4C8C 800E448C 23208500 */  subu       $a0, $a0, $a1
  .L800E4490:
    /* D4C90 800E4490 F9FF4915 */  bne        $t2, $t1, .L800E4478
    /* D4C94 800E4494 40200400 */   sll       $a0, $a0, 1
    /* D4C98 800E4498 26104800 */  xor        $v0, $v0, $t0
    /* D4C9C 800E449C 0800E003 */  jr         $ra
    /* D4CA0 800E44A0 22104800 */   sub       $v0, $v0, $t0 /* handwritten instruction */
  .L800E44A4:
    /* D4CA4 800E44A4 0800E003 */  jr         $ra
    /* D4CA8 800E44A8 25100000 */   or        $v0, $zero, $zero
endlabel rdiv
