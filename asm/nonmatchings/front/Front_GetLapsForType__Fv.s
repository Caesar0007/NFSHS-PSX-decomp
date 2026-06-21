.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_GetLapsForType__Fv, 0xA8

glabel Front_GetLapsForType__Fv
    /* 187C0 80027FC0 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* 187C4 80027FC4 02000224 */  addiu      $v0, $zero, 0x2
    /* 187C8 80027FC8 0000A2A7 */  sh         $v0, 0x0($sp)
    /* 187CC 80027FCC 04000224 */  addiu      $v0, $zero, 0x4
    /* 187D0 80027FD0 0200A2A7 */  sh         $v0, 0x2($sp)
    /* 187D4 80027FD4 1180023C */  lui        $v0, %hi(frontEnd)
    /* 187D8 80027FD8 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 187DC 80027FDC 04008390 */  lbu        $v1, 0x4($a0)
    /* 187E0 80027FE0 02000224 */  addiu      $v0, $zero, 0x2
    /* 187E4 80027FE4 0B006210 */  beq        $v1, $v0, .L80028014
    /* 187E8 80027FE8 00000000 */   nop
    /* 187EC 80027FEC 46008290 */  lbu        $v0, 0x46($a0)
    /* 187F0 80027FF0 00000000 */  nop
    /* 187F4 80027FF4 21104400 */  addu       $v0, $v0, $a0
    /* 187F8 80027FF8 2D004290 */  lbu        $v0, 0x2D($v0)
    /* 187FC 80027FFC 00000000 */  nop
    /* 18800 80028000 40100200 */  sll        $v0, $v0, 1
    /* 18804 80028004 2110A203 */  addu       $v0, $sp, $v0
    /* 18808 80028008 00004284 */  lh         $v0, 0x0($v0)
    /* 1880C 8002800C 18A00008 */  j          .L80028060
    /* 18810 80028010 00000000 */   nop
  .L80028014:
    /* 18814 80028014 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 18818 80028018 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 1881C 8002801C 0400838C */  lw         $v1, 0x4($a0)
    /* 18820 80028020 1800858C */  lw         $a1, 0x18($a0)
    /* 18824 80028024 40100300 */  sll        $v0, $v1, 1
    /* 18828 80028028 21104300 */  addu       $v0, $v0, $v1
    /* 1882C 8002802C 80100200 */  sll        $v0, $v0, 2
    /* 18830 80028030 2110A200 */  addu       $v0, $a1, $v0
    /* 18834 80028034 02004390 */  lbu        $v1, 0x2($v0)
    /* 18838 80028038 0800828C */  lw         $v0, 0x8($a0)
    /* 1883C 8002803C 00000000 */  nop
    /* 18840 80028040 21186200 */  addu       $v1, $v1, $v0
    /* 18844 80028044 80100300 */  sll        $v0, $v1, 2
    /* 18848 80028048 21104300 */  addu       $v0, $v0, $v1
    /* 1884C 8002804C 80100200 */  sll        $v0, $v0, 2
    /* 18850 80028050 21104300 */  addu       $v0, $v0, $v1
    /* 18854 80028054 80100200 */  sll        $v0, $v0, 2
    /* 18858 80028058 21104500 */  addu       $v0, $v0, $a1
    /* 1885C 8002805C 69004290 */  lbu        $v0, 0x69($v0)
  .L80028060:
    /* 18860 80028060 0800E003 */  jr         $ra
    /* 18864 80028064 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel Front_GetLapsForType__Fv
