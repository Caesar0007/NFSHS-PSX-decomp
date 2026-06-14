.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_opstatus, 0x58

glabel FILE_opstatus
    /* DC5C4 800EBDC4 21308000 */  addu       $a2, $a0, $zero
    /* DC5C8 800EBDC8 0F00C010 */  beqz       $a2, .L800EBE08
    /* DC5CC 800EBDCC F0FFBD27 */   addiu     $sp, $sp, -0x10
    /* DC5D0 800EBDD0 0F00053C */  lui        $a1, (0xFFFFF >> 16)
    /* DC5D4 800EBDD4 FFFFA534 */  ori        $a1, $a1, (0xFFFFF & 0xFFFF)
    /* DC5D8 800EBDD8 1480043C */  lui        $a0, %hi(D_8013EAA0)
    /* DC5DC 800EBDDC 021E0600 */  srl        $v1, $a2, 24
    /* DC5E0 800EBDE0 40100300 */  sll        $v0, $v1, 1
    /* DC5E4 800EBDE4 21104300 */  addu       $v0, $v0, $v1
    /* DC5E8 800EBDE8 A0EA838C */  lw         $v1, %lo(D_8013EAA0)($a0)
    /* DC5EC 800EBDEC 00110200 */  sll        $v0, $v0, 4
    /* DC5F0 800EBDF0 21204300 */  addu       $a0, $v0, $v1
    /* DC5F4 800EBDF4 0000828C */  lw         $v0, 0x0($a0)
    /* DC5F8 800EBDF8 2418C500 */  and        $v1, $a2, $a1
    /* DC5FC 800EBDFC 24104500 */  and        $v0, $v0, $a1
    /* DC600 800EBE00 03006210 */  beq        $v1, $v0, .L800EBE10
    /* DC604 800EBE04 00000000 */   nop
  .L800EBE08:
    /* DC608 800EBE08 85AF0308 */  j          .L800EBE14
    /* DC60C 800EBE0C FDFF0224 */   addiu     $v0, $zero, -0x3
  .L800EBE10:
    /* DC610 800EBE10 0800828C */  lw         $v0, 0x8($a0)
  .L800EBE14:
    /* DC614 800EBE14 0800E003 */  jr         $ra
    /* DC618 800EBE18 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel FILE_opstatus
