.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching allocmutex, 0x5C

glabel allocmutex
    /* EEC24 800FE424 21180000 */  addu       $v1, $zero, $zero
    /* EEC28 800FE428 1480023C */  lui        $v0, %hi(mutexbuf)
    /* EEC2C 800FE42C E0774524 */  addiu      $a1, $v0, %lo(mutexbuf)
  .L800FE430:
    /* EEC30 800FE430 2120A000 */  addu       $a0, $a1, $zero
    /* EEC34 800FE434 00008284 */  lh         $v0, 0x0($a0)
    /* EEC38 800FE438 00000000 */  nop
    /* EEC3C 800FE43C 0C004010 */  beqz       $v0, .L800FE470
    /* EEC40 800FE440 01000224 */   addiu     $v0, $zero, 0x1
    /* EEC44 800FE444 01006324 */  addiu      $v1, $v1, 0x1
    /* EEC48 800FE448 20006228 */  slti       $v0, $v1, 0x20
    /* EEC4C 800FE44C F8FF4014 */  bnez       $v0, .L800FE430
    /* EEC50 800FE450 04008524 */   addiu     $a1, $a0, 0x4
  .L800FE454:
    /* EEC54 800FE454 20000224 */  addiu      $v0, $zero, 0x20
    /* EEC58 800FE458 07006210 */  beq        $v1, $v0, .L800FE478
    /* EEC5C 800FE45C 80180300 */   sll       $v1, $v1, 2
    /* EEC60 800FE460 1480023C */  lui        $v0, %hi(mutexbuf)
    /* EEC64 800FE464 E0774224 */  addiu      $v0, $v0, %lo(mutexbuf)
    /* EEC68 800FE468 0800E003 */  jr         $ra
    /* EEC6C 800FE46C 21106200 */   addu      $v0, $v1, $v0
  .L800FE470:
    /* EEC70 800FE470 15F90308 */  j          .L800FE454
    /* EEC74 800FE474 0000A2A4 */   sh        $v0, 0x0($a1)
  .L800FE478:
    /* EEC78 800FE478 0800E003 */  jr         $ra
    /* EEC7C 800FE47C 21100000 */   addu      $v0, $zero, $zero
endlabel allocmutex
