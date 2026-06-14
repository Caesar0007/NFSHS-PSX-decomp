.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i, 0xB0

glabel TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i
    /* AB93C 800BB13C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* AB940 800BB140 07008430 */  andi       $a0, $a0, 0x7
    /* AB944 800BB144 1280023C */  lui        $v0, %hi(simGlobal)
    /* AB948 800BB148 ACE04824 */  addiu      $t0, $v0, %lo(simGlobal)
    /* AB94C 800BB14C 1280023C */  lui        $v0, %hi(gTAddCarWheelSfx)
    /* AB950 800BB150 F0E14224 */  addiu      $v0, $v0, %lo(gTAddCarWheelSfx)
    /* AB954 800BB154 80280500 */  sll        $a1, $a1, 2
    /* AB958 800BB158 00210400 */  sll        $a0, $a0, 4
    /* AB95C 800BB15C 2128A400 */  addu       $a1, $a1, $a0
    /* AB960 800BB160 2128A200 */  addu       $a1, $a1, $v0
    /* AB964 800BB164 2800BFAF */  sw         $ra, 0x28($sp)
    /* AB968 800BB168 0400038D */  lw         $v1, 0x4($t0)
    /* AB96C 800BB16C 0000A48C */  lw         $a0, 0x0($a1)
    /* AB970 800BB170 4400A28F */  lw         $v0, 0x44($sp)
    /* AB974 800BB174 23186400 */  subu       $v1, $v1, $a0
    /* AB978 800BB178 2A104300 */  slt        $v0, $v0, $v1
    /* AB97C 800BB17C 17004010 */  beqz       $v0, .L800BB1DC
    /* AB980 800BB180 2120C000 */   addu      $a0, $a2, $zero
    /* AB984 800BB184 4000A28F */  lw         $v0, 0x40($sp)
    /* AB988 800BB188 00000000 */  nop
    /* AB98C 800BB18C 0000498C */  lw         $t1, 0x0($v0)
    /* AB990 800BB190 04004A8C */  lw         $t2, 0x4($v0)
    /* AB994 800BB194 08004B8C */  lw         $t3, 0x8($v0)
    /* AB998 800BB198 1800A9AF */  sw         $t1, 0x18($sp)
    /* AB99C 800BB19C 1C00AAAF */  sw         $t2, 0x1C($sp)
    /* AB9A0 800BB1A0 2000ABAF */  sw         $t3, 0x20($sp)
    /* AB9A4 800BB1A4 1800A28F */  lw         $v0, 0x18($sp)
    /* AB9A8 800BB1A8 1800A627 */  addiu      $a2, $sp, 0x18
    /* AB9AC 800BB1AC 43100200 */  sra        $v0, $v0, 1
    /* AB9B0 800BB1B0 1800A2AF */  sw         $v0, 0x18($sp)
    /* AB9B4 800BB1B4 2000A28F */  lw         $v0, 0x20($sp)
    /* AB9B8 800BB1B8 0400038D */  lw         $v1, 0x4($t0)
    /* AB9BC 800BB1BC 43100200 */  sra        $v0, $v0, 1
    /* AB9C0 800BB1C0 2000A2AF */  sw         $v0, 0x20($sp)
    /* AB9C4 800BB1C4 0000A3AC */  sw         $v1, 0x0($a1)
    /* AB9C8 800BB1C8 2128E000 */  addu       $a1, $a3, $zero
    /* AB9CC 800BB1CC 21380000 */  addu       $a3, $zero, $zero
    /* AB9D0 800BB1D0 1000A0AF */  sw         $zero, 0x10($sp)
    /* AB9D4 800BB1D4 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* AB9D8 800BB1D8 1400A0AF */   sw        $zero, 0x14($sp)
  .L800BB1DC:
    /* AB9DC 800BB1DC 2800BF8F */  lw         $ra, 0x28($sp)
    /* AB9E0 800BB1E0 00000000 */  nop
    /* AB9E4 800BB1E4 0800E003 */  jr         $ra
    /* AB9E8 800BB1E8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i
