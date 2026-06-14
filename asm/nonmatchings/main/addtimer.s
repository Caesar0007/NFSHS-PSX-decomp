.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching addtimer, 0x60

glabel addtimer
    /* DB7E8 800EAFE8 21280000 */  addu       $a1, $zero, $zero
    /* DB7EC 800EAFEC 1280023C */  lui        $v0, %hi(tmrsub)
    /* DB7F0 800EAFF0 0C364324 */  addiu      $v1, $v0, %lo(tmrsub)
  .L800EAFF4:
    /* DB7F4 800EAFF4 0000628C */  lw         $v0, 0x0($v1)
    /* DB7F8 800EAFF8 00000000 */  nop
    /* DB7FC 800EAFFC 10004410 */  beq        $v0, $a0, .L800EB040
    /* DB800 800EB000 0100A524 */   addiu     $a1, $a1, 0x1
    /* DB804 800EB004 0800A228 */  slti       $v0, $a1, 0x8
    /* DB808 800EB008 FAFF4014 */  bnez       $v0, .L800EAFF4
    /* DB80C 800EB00C 04006324 */   addiu     $v1, $v1, 0x4
    /* DB810 800EB010 21280000 */  addu       $a1, $zero, $zero
    /* DB814 800EB014 1280023C */  lui        $v0, %hi(tmrsub)
    /* DB818 800EB018 0C364324 */  addiu      $v1, $v0, %lo(tmrsub)
  .L800EB01C:
    /* DB81C 800EB01C 0000628C */  lw         $v0, 0x0($v1)
    /* DB820 800EB020 00000000 */  nop
    /* DB824 800EB024 03004014 */  bnez       $v0, .L800EB034
    /* DB828 800EB028 0100A524 */   addiu     $a1, $a1, 0x1
    /* DB82C 800EB02C 0800E003 */  jr         $ra
    /* DB830 800EB030 000064AC */   sw        $a0, 0x0($v1)
  .L800EB034:
    /* DB834 800EB034 0800A228 */  slti       $v0, $a1, 0x8
    /* DB838 800EB038 F8FF4014 */  bnez       $v0, .L800EB01C
    /* DB83C 800EB03C 04006324 */   addiu     $v1, $v1, 0x4
  .L800EB040:
    /* DB840 800EB040 0800E003 */  jr         $ra
    /* DB844 800EB044 00000000 */   nop
endlabel addtimer
