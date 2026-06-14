.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CalcSpeed__FP8Car_tObj, 0x48

glabel AIWorld_CalcSpeed__FP8Car_tObj
    /* 640D4 800738D4 AC00858C */  lw         $a1, 0xAC($a0)
    /* 640D8 800738D8 B400838C */  lw         $v1, 0xB4($a0)
    /* 640DC 800738DC 0200A104 */  bgez       $a1, .L800738E8
    /* 640E0 800738E0 00000000 */   nop
    /* 640E4 800738E4 23280500 */  negu       $a1, $a1
  .L800738E8:
    /* 640E8 800738E8 02006104 */  bgez       $v1, .L800738F4
    /* 640EC 800738EC 00000000 */   nop
    /* 640F0 800738F0 23180300 */  negu       $v1, $v1
  .L800738F4:
    /* 640F4 800738F4 2A106500 */  slt        $v0, $v1, $a1
    /* 640F8 800738F8 05004010 */  beqz       $v0, .L80073910
    /* 640FC 800738FC 83100500 */   sra       $v0, $a1, 2
    /* 64100 80073900 83100300 */  sra        $v0, $v1, 2
    /* 64104 80073904 2110A200 */  addu       $v0, $a1, $v0
    /* 64108 80073908 0800E003 */  jr         $ra
    /* 6410C 8007390C 680582AC */   sw        $v0, 0x568($a0)
  .L80073910:
    /* 64110 80073910 21106200 */  addu       $v0, $v1, $v0
    /* 64114 80073914 0800E003 */  jr         $ra
    /* 64118 80073918 680582AC */   sw        $v0, 0x568($a0)
endlabel AIWorld_CalcSpeed__FP8Car_tObj
