.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80106878, 0xAC

glabel func_80106878
    /* F7078 80106878 21308000 */  addu       $a2, $a0, $zero
    /* F707C 8010687C 1480033C */  lui        $v1, %hi(D_8013BD24)
    /* F7080 80106880 24BD6324 */  addiu      $v1, $v1, %lo(D_8013BD24)
    /* F7084 80106884 80100600 */  sll        $v0, $a2, 2
    /* F7088 80106888 21184300 */  addu       $v1, $v0, $v1
    /* F708C 8010688C 0000678C */  lw         $a3, 0x0($v1)
    /* F7090 80106890 2120A000 */  addu       $a0, $a1, $zero
    /* F7094 80106894 21008710 */  beq        $a0, $a3, .L8010691C
    /* F7098 80106898 2110E000 */   addu      $v0, $a3, $zero
    /* F709C 8010689C 10008010 */  beqz       $a0, .L801068E0
    /* F70A0 801068A0 FF00023C */   lui       $v0, (0xFFFFFF >> 16)
    /* F70A4 801068A4 1480053C */  lui        $a1, %hi(D_8013BD20)
    /* F70A8 801068A8 20BDA58C */  lw         $a1, %lo(D_8013BD20)($a1)
    /* F70AC 801068AC FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* F70B0 801068B0 000064AC */  sw         $a0, 0x0($v1)
    /* F70B4 801068B4 0000A48C */  lw         $a0, 0x0($a1)
    /* F70B8 801068B8 1000C324 */  addiu      $v1, $a2, 0x10
    /* F70BC 801068BC 24208200 */  and        $a0, $a0, $v0
    /* F70C0 801068C0 01000224 */  addiu      $v0, $zero, 0x1
    /* F70C4 801068C4 04106200 */  sllv       $v0, $v0, $v1
    /* F70C8 801068C8 8000033C */  lui        $v1, (0x800000 >> 16)
    /* F70CC 801068CC 25104300 */  or         $v0, $v0, $v1
    /* F70D0 801068D0 25208200 */  or         $a0, $a0, $v0
    /* F70D4 801068D4 0000A4AC */  sw         $a0, 0x0($a1)
    /* F70D8 801068D8 471A0408 */  j          .L8010691C
    /* F70DC 801068DC 2110E000 */   addu      $v0, $a3, $zero
  .L801068E0:
    /* F70E0 801068E0 1480053C */  lui        $a1, %hi(D_8013BD20)
    /* F70E4 801068E4 20BDA58C */  lw         $a1, %lo(D_8013BD20)($a1)
    /* F70E8 801068E8 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* F70EC 801068EC 000060AC */  sw         $zero, 0x0($v1)
    /* F70F0 801068F0 0000A38C */  lw         $v1, 0x0($a1)
    /* F70F4 801068F4 1000C424 */  addiu      $a0, $a2, 0x10
    /* F70F8 801068F8 24186200 */  and        $v1, $v1, $v0
    /* F70FC 801068FC 8000023C */  lui        $v0, (0x800000 >> 16)
    /* F7100 80106900 25186200 */  or         $v1, $v1, $v0
    /* F7104 80106904 01000224 */  addiu      $v0, $zero, 0x1
    /* F7108 80106908 04108200 */  sllv       $v0, $v0, $a0
    /* F710C 8010690C 27100200 */  nor        $v0, $zero, $v0
    /* F7110 80106910 24186200 */  and        $v1, $v1, $v0
    /* F7114 80106914 0000A3AC */  sw         $v1, 0x0($a1)
    /* F7118 80106918 2110E000 */  addu       $v0, $a3, $zero
  .L8010691C:
    /* F711C 8010691C 0800E003 */  jr         $ra
    /* F7120 80106920 00000000 */   nop
endlabel func_80106878
