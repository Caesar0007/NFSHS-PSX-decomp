.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching cluttype, 0x44

glabel cluttype
    /* ECA50 800FC250 F1FF8324 */  addiu      $v1, $a0, -0xF
    /* ECA54 800FC254 1200622C */  sltiu      $v0, $v1, 0x12
    /* ECA58 800FC258 0C004010 */  beqz       $v0, .L800FC28C
    /* ECA5C 800FC25C 21280000 */   addu      $a1, $zero, $zero
    /* ECA60 800FC260 0580023C */  lui        $v0, %hi(jtbl_800574F0)
    /* ECA64 800FC264 F0744224 */  addiu      $v0, $v0, %lo(jtbl_800574F0)
    /* ECA68 800FC268 80180300 */  sll        $v1, $v1, 2
    /* ECA6C 800FC26C 21186200 */  addu       $v1, $v1, $v0
    /* ECA70 800FC270 0000628C */  lw         $v0, 0x0($v1)
    /* ECA74 800FC274 00000000 */  nop
    /* ECA78 800FC278 08004000 */  jr         $v0
    /* ECA7C 800FC27C 00000000 */   nop
  jlabel .L800FC280
    /* ECA80 800FC280 A3F00308 */  j          .L800FC28C
    /* ECA84 800FC284 23000524 */   addiu     $a1, $zero, 0x23
  jlabel .L800FC288
    /* ECA88 800FC288 21280000 */  addu       $a1, $zero, $zero
  jlabel .L800FC28C
    /* ECA8C 800FC28C 0800E003 */  jr         $ra
    /* ECA90 800FC290 2110A000 */   addu      $v0, $a1, $zero
endlabel cluttype
