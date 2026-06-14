.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj, 0x140

glabel R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj
    /* 9F4B4 800AECB4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9F4B8 800AECB8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9F4BC 800AECBC 21888000 */  addu       $s1, $a0, $zero
    /* 9F4C0 800AECC0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 9F4C4 800AECC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9F4C8 800AECC8 BC083086 */  lh         $s0, 0x8BC($s1)
    /* 9F4CC 800AECCC 00000000 */  nop
    /* 9F4D0 800AECD0 1D000006 */  bltz       $s0, .L800AED48
    /* 9F4D4 800AECD4 1180043C */   lui       $a0, %hi(R3DCar_LoadedSceneCounter)
    /* 9F4D8 800AECD8 42082392 */  lbu        $v1, 0x842($s1)
    /* 9F4DC 800AECDC 986A8424 */  addiu      $a0, $a0, %lo(R3DCar_LoadedSceneCounter)
    /* 9F4E0 800AECE0 C2190300 */  srl        $v1, $v1, 7
    /* 9F4E4 800AECE4 40100300 */  sll        $v0, $v1, 1
    /* 9F4E8 800AECE8 21104300 */  addu       $v0, $v0, $v1
    /* 9F4EC 800AECEC C0100200 */  sll        $v0, $v0, 3
    /* 9F4F0 800AECF0 21284300 */  addu       $a1, $v0, $v1
    /* 9F4F4 800AECF4 40180500 */  sll        $v1, $a1, 1
    /* 9F4F8 800AECF8 21180302 */  addu       $v1, $s0, $v1
    /* 9F4FC 800AECFC 21186400 */  addu       $v1, $v1, $a0
    /* 9F500 800AED00 00006290 */  lbu        $v0, 0x0($v1)
    /* 9F504 800AED04 00000000 */  nop
    /* 9F508 800AED08 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 9F50C 800AED0C 000062A0 */  sb         $v0, 0x0($v1)
    /* 9F510 800AED10 FF004230 */  andi       $v0, $v0, 0xFF
    /* 9F514 800AED14 0A004014 */  bnez       $v0, .L800AED40
    /* 9F518 800AED18 1180023C */   lui       $v0, %hi(R3DCar_LoadedScenePointer)
    /* 9F51C 800AED1C 08694224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedScenePointer)
    /* 9F520 800AED20 80801000 */  sll        $s0, $s0, 2
    /* 9F524 800AED24 C0180500 */  sll        $v1, $a1, 3
    /* 9F528 800AED28 21800302 */  addu       $s0, $s0, $v1
    /* 9F52C 800AED2C 21800202 */  addu       $s0, $s0, $v0
    /* 9F530 800AED30 0000048E */  lw         $a0, 0x0($s0)
    /* 9F534 800AED34 5095030C */  jal        purgememadr
    /* 9F538 800AED38 00000000 */   nop
    /* 9F53C 800AED3C 000000AE */  sw         $zero, 0x0($s0)
  .L800AED40:
    /* 9F540 800AED40 D6F4020C */  jal        CarIO_ReleaseCarCluts__FP8Car_tObj
    /* 9F544 800AED44 21202002 */   addu      $a0, $s1, $zero
  .L800AED48:
    /* 9F548 800AED48 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 9F54C 800AED4C BC0822A6 */  sh         $v0, 0x8BC($s1)
    /* 9F550 800AED50 BE082296 */  lhu        $v0, 0x8BE($s1)
    /* 9F554 800AED54 D808238E */  lw         $v1, 0x8D8($s1)
    /* 9F558 800AED58 80004234 */  ori        $v0, $v0, 0x80
    /* 9F55C 800AED5C 19006010 */  beqz       $v1, .L800AEDC4
    /* 9F560 800AED60 BE0822A6 */   sh        $v0, 0x8BE($s1)
  .L800AED64:
    /* 9F564 800AED64 D808248E */  lw         $a0, 0x8D8($s1)
    /* 9F568 800AED68 B6C5030C */  jal        getasyncreadstatus
    /* 9F56C 800AED6C 00000000 */   nop
    /* 9F570 800AED70 21184000 */  addu       $v1, $v0, $zero
    /* 9F574 800AED74 05006014 */  bnez       $v1, .L800AED8C
    /* 9F578 800AED78 00000000 */   nop
    /* 9F57C 800AED7C 019B030C */  jal        systemtask
    /* 9F580 800AED80 21200000 */   addu      $a0, $zero, $zero
    /* 9F584 800AED84 59BB0208 */  j          .L800AED64
    /* 9F588 800AED88 00000000 */   nop
  .L800AED8C:
    /* 9F58C 800AED8C 0300601C */  bgtz       $v1, .L800AED9C
    /* 9F590 800AED90 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 9F594 800AED94 09006214 */  bne        $v1, $v0, .L800AEDBC
    /* 9F598 800AED98 00000000 */   nop
  .L800AED9C:
    /* 9F59C 800AED9C D808248E */  lw         $a0, 0x8D8($s1)
    /* 9F5A0 800AEDA0 90C5030C */  jal        getasyncreadadr
    /* 9F5A4 800AEDA4 00000000 */   nop
    /* 9F5A8 800AEDA8 03004010 */  beqz       $v0, .L800AEDB8
    /* 9F5AC 800AEDAC 00000000 */   nop
    /* 9F5B0 800AEDB0 5095030C */  jal        purgememadr
    /* 9F5B4 800AEDB4 21204000 */   addu      $a0, $v0, $zero
  .L800AEDB8:
    /* 9F5B8 800AEDB8 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800AEDBC:
    /* 9F5BC 800AEDBC D80820AE */  sw         $zero, 0x8D8($s1)
    /* 9F5C0 800AEDC0 380E82AF */  sw         $v0, %gp_rel(R3DCar_aSyncLoading)($gp)
  .L800AEDC4:
    /* 9F5C4 800AEDC4 8408248E */  lw         $a0, 0x884($s1)
    /* 9F5C8 800AEDC8 00000000 */  nop
    /* 9F5CC 800AEDCC 03008010 */  beqz       $a0, .L800AEDDC
    /* 9F5D0 800AEDD0 00000000 */   nop
    /* 9F5D4 800AEDD4 5095030C */  jal        purgememadr
    /* 9F5D8 800AEDD8 00000000 */   nop
  .L800AEDDC:
    /* 9F5DC 800AEDDC 840820AE */  sw         $zero, 0x884($s1)
    /* 9F5E0 800AEDE0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 9F5E4 800AEDE4 1400B18F */  lw         $s1, 0x14($sp)
    /* 9F5E8 800AEDE8 1000B08F */  lw         $s0, 0x10($sp)
    /* 9F5EC 800AEDEC 0800E003 */  jr         $ra
    /* 9F5F0 800AEDF0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj
