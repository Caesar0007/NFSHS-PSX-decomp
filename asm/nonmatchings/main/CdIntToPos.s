.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdIntToPos, 0x104

glabel CdIntToPos
    /* E84F4 800F7CF4 4E1B033C */  lui        $v1, (0x1B4E81B5 >> 16)
    /* E84F8 800F7CF8 B5816334 */  ori        $v1, $v1, (0x1B4E81B5 & 0xFFFF)
    /* E84FC 800F7CFC 96008424 */  addiu      $a0, $a0, 0x96
    /* E8500 800F7D00 18008300 */  mult       $a0, $v1
    /* E8504 800F7D04 2110A000 */  addu       $v0, $a1, $zero
    /* E8508 800F7D08 8888053C */  lui        $a1, (0x88888889 >> 16)
    /* E850C 800F7D0C 8988A534 */  ori        $a1, $a1, (0x88888889 & 0xFFFF)
    /* E8510 800F7D10 10180000 */  mfhi       $v1
    /* E8514 800F7D14 C3380300 */  sra        $a3, $v1, 3
    /* E8518 800F7D18 C31F0400 */  sra        $v1, $a0, 31
    /* E851C 800F7D1C 2338E300 */  subu       $a3, $a3, $v1
    /* E8520 800F7D20 1800E500 */  mult       $a3, $a1
    /* E8524 800F7D24 6666093C */  lui        $t1, (0x66666667 >> 16)
    /* E8528 800F7D28 67662935 */  ori        $t1, $t1, (0x66666667 & 0xFFFF)
    /* E852C 800F7D2C 80280700 */  sll        $a1, $a3, 2
    /* E8530 800F7D30 2128A700 */  addu       $a1, $a1, $a3
    /* E8534 800F7D34 00190500 */  sll        $v1, $a1, 4
    /* E8538 800F7D38 10300000 */  mfhi       $a2
    /* E853C 800F7D3C 23186500 */  subu       $v1, $v1, $a1
    /* E8540 800F7D40 23208300 */  subu       $a0, $a0, $v1
    /* E8544 800F7D44 18008900 */  mult       $a0, $t1
    /* E8548 800F7D48 C31F0700 */  sra        $v1, $a3, 31
    /* E854C 800F7D4C 2140C700 */  addu       $t0, $a2, $a3
    /* E8550 800F7D50 43410800 */  sra        $t0, $t0, 5
    /* E8554 800F7D54 23400301 */  subu       $t0, $t0, $v1
    /* E8558 800F7D58 00190800 */  sll        $v1, $t0, 4
    /* E855C 800F7D5C 23186800 */  subu       $v1, $v1, $t0
    /* E8560 800F7D60 10280000 */  mfhi       $a1
    /* E8564 800F7D64 80180300 */  sll        $v1, $v1, 2
    /* E8568 800F7D68 2338E300 */  subu       $a3, $a3, $v1
    /* E856C 800F7D6C 1800E900 */  mult       $a3, $t1
    /* E8570 800F7D70 C31F0400 */  sra        $v1, $a0, 31
    /* E8574 800F7D74 83280500 */  sra        $a1, $a1, 2
    /* E8578 800F7D78 2328A300 */  subu       $a1, $a1, $v1
    /* E857C 800F7D7C 00310500 */  sll        $a2, $a1, 4
    /* E8580 800F7D80 80180500 */  sll        $v1, $a1, 2
    /* E8584 800F7D84 21186500 */  addu       $v1, $v1, $a1
    /* E8588 800F7D88 40180300 */  sll        $v1, $v1, 1
    /* E858C 800F7D8C 23208300 */  subu       $a0, $a0, $v1
    /* E8590 800F7D90 10580000 */  mfhi       $t3
    /* E8594 800F7D94 2130C400 */  addu       $a2, $a2, $a0
    /* E8598 800F7D98 C31F0700 */  sra        $v1, $a3, 31
    /* E859C 800F7D9C 18000901 */  mult       $t0, $t1
    /* E85A0 800F7DA0 020046A0 */  sb         $a2, 0x2($v0)
    /* E85A4 800F7DA4 83200B00 */  sra        $a0, $t3, 2
    /* E85A8 800F7DA8 23208300 */  subu       $a0, $a0, $v1
    /* E85AC 800F7DAC 00290400 */  sll        $a1, $a0, 4
    /* E85B0 800F7DB0 80180400 */  sll        $v1, $a0, 2
    /* E85B4 800F7DB4 21186400 */  addu       $v1, $v1, $a0
    /* E85B8 800F7DB8 40180300 */  sll        $v1, $v1, 1
    /* E85BC 800F7DBC 2338E300 */  subu       $a3, $a3, $v1
    /* E85C0 800F7DC0 2128A700 */  addu       $a1, $a1, $a3
    /* E85C4 800F7DC4 C31F0800 */  sra        $v1, $t0, 31
    /* E85C8 800F7DC8 010045A0 */  sb         $a1, 0x1($v0)
    /* E85CC 800F7DCC 10480000 */  mfhi       $t1
    /* E85D0 800F7DD0 83200900 */  sra        $a0, $t1, 2
    /* E85D4 800F7DD4 23208300 */  subu       $a0, $a0, $v1
    /* E85D8 800F7DD8 00290400 */  sll        $a1, $a0, 4
    /* E85DC 800F7DDC 80180400 */  sll        $v1, $a0, 2
    /* E85E0 800F7DE0 21186400 */  addu       $v1, $v1, $a0
    /* E85E4 800F7DE4 40180300 */  sll        $v1, $v1, 1
    /* E85E8 800F7DE8 23400301 */  subu       $t0, $t0, $v1
    /* E85EC 800F7DEC 2128A800 */  addu       $a1, $a1, $t0
    /* E85F0 800F7DF0 0800E003 */  jr         $ra
    /* E85F4 800F7DF4 000045A0 */   sb        $a1, 0x0($v0)
endlabel CdIntToPos
