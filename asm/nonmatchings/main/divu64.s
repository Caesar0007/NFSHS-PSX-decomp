.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching divu64, 0x40

glabel divu64
    /* EECE0 800FE4E0 00000224 */  addiu      $v0, $zero, 0x0
    /* EECE4 800FE4E4 20000924 */  addiu      $t1, $zero, 0x20
    /* EECE8 800FE4E8 FFFF2925 */  addiu      $t1, $t1, -0x1
  .L800FE4EC:
    /* EECEC 800FE4EC 40100200 */  sll        $v0, $v0, 1
    /* EECF0 800FE4F0 40280500 */  sll        $a1, $a1, 1
    /* EECF4 800FE4F4 C2570400 */  srl        $t2, $a0, 31
    /* EECF8 800FE4F8 2128AA00 */  addu       $a1, $a1, $t2
    /* EECFC 800FE4FC 2B58A600 */  sltu       $t3, $a1, $a2
    /* EED00 800FE500 03006015 */  bnez       $t3, .L800FE510
    /* EED04 800FE504 40200400 */   sll       $a0, $a0, 1
    /* EED08 800FE508 2328A600 */  subu       $a1, $a1, $a2
    /* EED0C 800FE50C 01004224 */  addiu      $v0, $v0, 0x1
  .L800FE510:
    /* EED10 800FE510 F6FF2015 */  bnez       $t1, .L800FE4EC
    /* EED14 800FE514 FFFF2925 */   addiu     $t1, $t1, -0x1
    /* EED18 800FE518 0800E003 */  jr         $ra
    /* EED1C 800FE51C 00000000 */   nop
endlabel divu64
