.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ShouldTimeOut__11tDialogBase, 0x38

glabel ShouldTimeOut__11tDialogBase
    /* 8EC8 800186C8 7800858C */  lw         $a1, 0x78($a0)
    /* 8ECC 800186CC 00000000 */  nop
    /* 8ED0 800186D0 0800A018 */  blez       $a1, .L800186F4
    /* 8ED4 800186D4 1480023C */   lui       $v0, %hi(ticks)
    /* 8ED8 800186D8 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 8EDC 800186DC 7400848C */  lw         $a0, 0x74($a0)
    /* 8EE0 800186E0 00000000 */  nop
    /* 8EE4 800186E4 23186400 */  subu       $v1, $v1, $a0
    /* 8EE8 800186E8 2A186500 */  slt        $v1, $v1, $a1
    /* 8EEC 800186EC 02006010 */  beqz       $v1, .L800186F8
    /* 8EF0 800186F0 01000224 */   addiu     $v0, $zero, 0x1
  .L800186F4:
    /* 8EF4 800186F4 21100000 */  addu       $v0, $zero, $zero
  .L800186F8:
    /* 8EF8 800186F8 0800E003 */  jr         $ra
    /* 8EFC 800186FC 00000000 */   nop
endlabel ShouldTimeOut__11tDialogBase
