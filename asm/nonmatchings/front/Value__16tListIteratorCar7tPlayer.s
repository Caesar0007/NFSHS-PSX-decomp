.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__16tListIteratorCar7tPlayer, 0x2C

glabel Value__16tListIteratorCar7tPlayer
    /* 8150 80017950 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8154 80017954 0200A210 */  beq        $a1, $v0, .L80017960
    /* 8158 80017958 21180000 */   addu      $v1, $zero, $zero
    /* 815C 8001795C 2118A000 */  addu       $v1, $a1, $zero
  .L80017960:
    /* 8160 80017960 00140300 */  sll        $v0, $v1, 16
    /* 8164 80017964 0400838C */  lw         $v1, 0x4($a0)
    /* 8168 80017968 03140200 */  sra        $v0, $v0, 16
    /* 816C 8001796C 21186200 */  addu       $v1, $v1, $v0
    /* 8170 80017970 00006290 */  lbu        $v0, 0x0($v1)
    /* 8174 80017974 0800E003 */  jr         $ra
    /* 8178 80017978 00000000 */   nop
endlabel Value__16tListIteratorCar7tPlayer
