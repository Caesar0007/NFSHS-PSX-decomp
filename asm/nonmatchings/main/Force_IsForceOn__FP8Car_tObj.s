.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_IsForceOn__FP8Car_tObj, 0x5C

glabel Force_IsForceOn__FP8Car_tObj
    /* BB958 800CB158 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* BB95C 800CB15C F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* BB960 800CB160 00000000 */  nop
    /* BB964 800CB164 02004228 */  slti       $v0, $v0, 0x2
    /* BB968 800CB168 10004010 */  beqz       $v0, .L800CB1AC
    /* BB96C 800CB16C 21100000 */   addu      $v0, $zero, $zero
    /* BB970 800CB170 5402848C */  lw         $a0, 0x254($a0)
    /* BB974 800CB174 00000000 */  nop
    /* BB978 800CB178 0200822C */  sltiu      $v0, $a0, 0x2
    /* BB97C 800CB17C 09004010 */  beqz       $v0, .L800CB1A4
    /* BB980 800CB180 C0100400 */   sll       $v0, $a0, 3
    /* BB984 800CB184 1280033C */  lui        $v1, %hi(Force_g)
    /* BB988 800CB188 60FD6324 */  addiu      $v1, $v1, %lo(Force_g)
    /* BB98C 800CB18C 21104300 */  addu       $v0, $v0, $v1
    /* BB990 800CB190 00004290 */  lbu        $v0, 0x0($v0)
    /* BB994 800CB194 00000000 */  nop
    /* BB998 800CB198 01004238 */  xori       $v0, $v0, 0x1
    /* BB99C 800CB19C 0800E003 */  jr         $ra
    /* BB9A0 800CB1A0 0100422C */   sltiu     $v0, $v0, 0x1
  .L800CB1A4:
    /* BB9A4 800CB1A4 0800E003 */  jr         $ra
    /* BB9A8 800CB1A8 21100000 */   addu      $v0, $zero, $zero
  .L800CB1AC:
    /* BB9AC 800CB1AC 0800E003 */  jr         $ra
    /* BB9B0 800CB1B0 00000000 */   nop
endlabel Force_IsForceOn__FP8Car_tObj
