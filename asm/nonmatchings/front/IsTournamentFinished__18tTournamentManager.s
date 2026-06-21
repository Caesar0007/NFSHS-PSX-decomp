.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsTournamentFinished__18tTournamentManager, 0x94

glabel IsTournamentFinished__18tTournamentManager
    /* 231BC 800329BC 21288000 */  addu       $a1, $a0, $zero
    /* 231C0 800329C0 0400A38C */  lw         $v1, 0x4($a1)
    /* 231C4 800329C4 1800A48C */  lw         $a0, 0x18($a1)
    /* 231C8 800329C8 40100300 */  sll        $v0, $v1, 1
    /* 231CC 800329CC 21104300 */  addu       $v0, $v0, $v1
    /* 231D0 800329D0 80100200 */  sll        $v0, $v0, 2
    /* 231D4 800329D4 21108200 */  addu       $v0, $a0, $v0
    /* 231D8 800329D8 02004390 */  lbu        $v1, 0x2($v0)
    /* 231DC 800329DC 0800A28C */  lw         $v0, 0x8($a1)
    /* 231E0 800329E0 00000000 */  nop
    /* 231E4 800329E4 21186200 */  addu       $v1, $v1, $v0
    /* 231E8 800329E8 80100300 */  sll        $v0, $v1, 2
    /* 231EC 800329EC 21104300 */  addu       $v0, $v0, $v1
    /* 231F0 800329F0 80100200 */  sll        $v0, $v0, 2
    /* 231F4 800329F4 21104300 */  addu       $v0, $v0, $v1
    /* 231F8 800329F8 80100200 */  sll        $v0, $v0, 2
    /* 231FC 800329FC 24004224 */  addiu      $v0, $v0, 0x24
    /* 23200 80032A00 21208200 */  addu       $a0, $a0, $v0
    /* 23204 80032A04 01008290 */  lbu        $v0, 0x1($a0)
    /* 23208 80032A08 0C00A38C */  lw         $v1, 0xC($a1)
    /* 2320C 80032A0C 00000000 */  nop
    /* 23210 80032A10 2A106200 */  slt        $v0, $v1, $v0
    /* 23214 80032A14 0A004010 */  beqz       $v0, .L80032A40
    /* 23218 80032A18 00000000 */   nop
    /* 2321C 80032A1C 05008290 */  lbu        $v0, 0x5($a0)
    /* 23220 80032A20 00000000 */  nop
    /* 23224 80032A24 08004010 */  beqz       $v0, .L80032A48
    /* 23228 80032A28 00000000 */   nop
    /* 2322C 80032A2C 2401A294 */  lhu        $v0, 0x124($a1)
    /* 23230 80032A30 00000000 */  nop
    /* 23234 80032A34 2A104300 */  slt        $v0, $v0, $v1
    /* 23238 80032A38 03004010 */  beqz       $v0, .L80032A48
    /* 2323C 80032A3C 00000000 */   nop
  .L80032A40:
    /* 23240 80032A40 0800E003 */  jr         $ra
    /* 23244 80032A44 01000224 */   addiu     $v0, $zero, 0x1
  .L80032A48:
    /* 23248 80032A48 0800E003 */  jr         $ra
    /* 2324C 80032A4C 21100000 */   addu      $v0, $zero, $zero
endlabel IsTournamentFinished__18tTournamentManager
