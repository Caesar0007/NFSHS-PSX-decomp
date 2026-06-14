.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDgetchan, 0x6C

glabel iSNDgetchan
    /* EF5C4 800FEDC4 07008004 */  bltz       $a0, .L800FEDE4
    /* EF5C8 800FEDC8 1480023C */   lui       $v0, %hi(sndgs)
    /* EF5CC 800FEDCC 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* EF5D0 800FEDD0 11006290 */  lbu        $v0, 0x11($v1)
    /* EF5D4 800FEDD4 1F008530 */  andi       $a1, $a0, 0x1F
    /* EF5D8 800FEDD8 2A10A200 */  slt        $v0, $a1, $v0
    /* EF5DC 800FEDDC 03004014 */  bnez       $v0, .L800FEDEC
    /* EF5E0 800FEDE0 40100500 */   sll       $v0, $a1, 1
  .L800FEDE4:
    /* EF5E4 800FEDE4 0800E003 */  jr         $ra
    /* EF5E8 800FEDE8 F8FF0224 */   addiu     $v0, $zero, -0x8
  .L800FEDEC:
    /* EF5EC 800FEDEC 21104500 */  addu       $v0, $v0, $a1
    /* EF5F0 800FEDF0 C0100200 */  sll        $v0, $v0, 3
    /* EF5F4 800FEDF4 21104500 */  addu       $v0, $v0, $a1
    /* EF5F8 800FEDF8 9400638C */  lw         $v1, 0x94($v1)
    /* EF5FC 800FEDFC 80100200 */  sll        $v0, $v0, 2
    /* EF600 800FEE00 21186200 */  addu       $v1, $v1, $v0
    /* EF604 800FEE04 0B006280 */  lb         $v0, 0xB($v1)
    /* EF608 800FEE08 00000000 */  nop
    /* EF60C 800FEE0C 05004010 */  beqz       $v0, .L800FEE24
    /* EF610 800FEE10 00000000 */   nop
    /* EF614 800FEE14 0000628C */  lw         $v0, 0x0($v1)
    /* EF618 800FEE18 00000000 */  nop
    /* EF61C 800FEE1C 02004410 */  beq        $v0, $a0, .L800FEE28
    /* EF620 800FEE20 00000000 */   nop
  .L800FEE24:
    /* EF624 800FEE24 F8FF0524 */  addiu      $a1, $zero, -0x8
  .L800FEE28:
    /* EF628 800FEE28 0800E003 */  jr         $ra
    /* EF62C 800FEE2C 2110A000 */   addu      $v0, $a1, $zero
endlabel iSNDgetchan
