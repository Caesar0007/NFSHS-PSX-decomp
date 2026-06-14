.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FB560, 0x108

glabel func_800FB560
    /* EBD60 800FB560 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EBD64 800FB564 1400B1AF */  sw         $s1, 0x14($sp)
    /* EBD68 800FB568 21888000 */  addu       $s1, $a0, $zero
    /* EBD6C 800FB56C 1800BFAF */  sw         $ra, 0x18($sp)
    /* EBD70 800FB570 1000B0AF */  sw         $s0, 0x10($sp)
    /* EBD74 800FB574 0000238E */  lw         $v1, 0x0($s1)
    /* EBD78 800FB578 0A001024 */  addiu      $s0, $zero, 0xA
    /* EBD7C 800FB57C 14007010 */  beq        $v1, $s0, .L800FB5D0
    /* EBD80 800FB580 0B006228 */   slti      $v0, $v1, 0xB
    /* EBD84 800FB584 05004010 */  beqz       $v0, .L800FB59C
    /* EBD88 800FB588 0B000224 */   addiu     $v0, $zero, 0xB
    /* EBD8C 800FB58C 09006010 */  beqz       $v1, .L800FB5B4
    /* EBD90 800FB590 21100000 */   addu      $v0, $zero, $zero
    /* EBD94 800FB594 95ED0308 */  j          .L800FB654
    /* EBD98 800FB598 00000000 */   nop
  .L800FB59C:
    /* EBD9C 800FB59C 1C006210 */  beq        $v1, $v0, .L800FB610
    /* EBDA0 800FB5A0 14000224 */   addiu     $v0, $zero, 0x14
    /* EBDA4 800FB5A4 21006210 */  beq        $v1, $v0, .L800FB62C
    /* EBDA8 800FB5A8 21100000 */   addu      $v0, $zero, $zero
    /* EBDAC 800FB5AC 95ED0308 */  j          .L800FB654
    /* EBDB0 800FB5B0 00000000 */   nop
  .L800FB5B4:
    /* EBDB4 800FB5B4 1080043C */  lui        $a0, %hi(func_800FABF0)
    /* EBDB8 800FB5B8 F0AB8424 */  addiu      $a0, $a0, %lo(func_800FABF0)
    /* EBDBC 800FB5BC 1380013C */  lui        $at, %hi(D_80136CC0)
    /* EBDC0 800FB5C0 0427040C */  jal        UserFuncOpen
    /* EBDC4 800FB5C4 C06C20AC */   sw        $zero, %lo(D_80136CC0)($at)
    /* EBDC8 800FB5C8 94ED0308 */  j          .L800FB650
    /* EBDCC 800FB5CC 000030AE */   sw        $s0, 0x0($s1)
  .L800FB5D0:
    /* EBDD0 800FB5D0 1480103C */  lui        $s0, %hi(D_8014751C)
    /* EBDD4 800FB5D4 1C751026 */  addiu      $s0, $s0, %lo(D_8014751C)
    /* EBDD8 800FB5D8 0000028E */  lw         $v0, 0x0($s0)
    /* EBDDC 800FB5DC 00000000 */  nop
    /* EBDE0 800FB5E0 1C004014 */  bnez       $v0, .L800FB654
    /* EBDE4 800FB5E4 01000224 */   addiu     $v0, $zero, 0x1
    /* EBDE8 800FB5E8 1C000426 */  addiu      $a0, $s0, 0x1C
    /* EBDEC 800FB5EC 5C27040C */  jal        open
    /* EBDF0 800FB5F0 01800534 */   ori       $a1, $zero, 0x8001
    /* EBDF4 800FB5F4 06004104 */  bgez       $v0, .L800FB610
    /* EBDF8 800FB5F8 0C0002AE */   sw        $v0, 0xC($s0)
    /* EBDFC 800FB5FC FCFF0326 */  addiu      $v1, $s0, -0x4
    /* EBE00 800FB600 05000224 */  addiu      $v0, $zero, 0x5
    /* EBE04 800FB604 040062AC */  sw         $v0, 0x4($v1)
    /* EBE08 800FB608 95ED0308 */  j          .L800FB654
    /* EBE0C 800FB60C 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB610:
    /* EBE10 800FB610 14000224 */  addiu      $v0, $zero, 0x14
    /* EBE14 800FB614 1080043C */  lui        $a0, %hi(func_800FB118)
    /* EBE18 800FB618 18B18424 */  addiu      $a0, $a0, %lo(func_800FB118)
    /* EBE1C 800FB61C 0427040C */  jal        UserFuncOpen
    /* EBE20 800FB620 000022AE */   sw        $v0, 0x0($s1)
    /* EBE24 800FB624 95ED0308 */  j          .L800FB654
    /* EBE28 800FB628 21100000 */   addu      $v0, $zero, $zero
  .L800FB62C:
    /* EBE2C 800FB62C 1480103C */  lui        $s0, %hi(D_80147528)
    /* EBE30 800FB630 28751026 */  addiu      $s0, $s0, %lo(D_80147528)
    /* EBE34 800FB634 0000048E */  lw         $a0, 0x0($s0)
    /* EBE38 800FB638 6027040C */  jal        close
    /* EBE3C 800FB63C 00000000 */   nop
    /* EBE40 800FB640 01000224 */  addiu      $v0, $zero, 0x1
    /* EBE44 800FB644 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* EBE48 800FB648 95ED0308 */  j          .L800FB654
    /* EBE4C 800FB64C 000003AE */   sw        $v1, 0x0($s0)
  .L800FB650:
    /* EBE50 800FB650 21100000 */  addu       $v0, $zero, $zero
  .L800FB654:
    /* EBE54 800FB654 1800BF8F */  lw         $ra, 0x18($sp)
    /* EBE58 800FB658 1400B18F */  lw         $s1, 0x14($sp)
    /* EBE5C 800FB65C 1000B08F */  lw         $s0, 0x10($sp)
    /* EBE60 800FB660 0800E003 */  jr         $ra
    /* EBE64 800FB664 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800FB560
