.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_ParseTime__FiPc, 0x16C

glabel Hud_ParseTime__FiPc
    /* C9564 800D8D64 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C9568 800D8D68 21488000 */  addu       $t1, $a0, $zero
    /* C956C 800D8D6C 02002105 */  bgez       $t1, .L800D8D78
    /* C9570 800D8D70 2000BFAF */   sw        $ra, 0x20($sp)
    /* C9574 800D8D74 21480000 */  addu       $t1, $zero, $zero
  .L800D8D78:
    /* C9578 800D8D78 40100900 */  sll        $v0, $t1, 1
    /* C957C 800D8D7C 21104900 */  addu       $v0, $v0, $t1
    /* C9580 800D8D80 C0100200 */  sll        $v0, $v0, 3
    /* C9584 800D8D84 21104900 */  addu       $v0, $v0, $t1
    /* C9588 800D8D88 801A0200 */  sll        $v1, $v0, 10
    /* C958C 800D8D8C 02006104 */  bgez       $v1, .L800D8D98
    /* C9590 800D8D90 2B380900 */   sltu      $a3, $zero, $t1
    /* C9594 800D8D94 FF3F6324 */  addiu      $v1, $v1, 0x3FFF
  .L800D8D98:
    /* C9598 800D8D98 834B0300 */  sra        $t1, $v1, 14
    /* C959C 800D8D9C 7605023C */  lui        $v0, (0x57619F1 >> 16)
    /* C95A0 800D8DA0 F1194234 */  ori        $v0, $v0, (0x57619F1 & 0xFFFF)
    /* C95A4 800D8DA4 18002201 */  mult       $t1, $v0
    /* C95A8 800D8DA8 EB51043C */  lui        $a0, (0x51EB851F >> 16)
    /* C95AC 800D8DAC 1F858434 */  ori        $a0, $a0, (0x51EB851F & 0xFFFF)
    /* C95B0 800D8DB0 C31F0300 */  sra        $v1, $v1, 31
    /* C95B4 800D8DB4 10580000 */  mfhi       $t3
    /* C95B8 800D8DB8 C3110B00 */  sra        $v0, $t3, 7
    /* C95BC 800D8DBC 23104300 */  subu       $v0, $v0, $v1
    /* C95C0 800D8DC0 00140200 */  sll        $v0, $v0, 16
    /* C95C4 800D8DC4 03340200 */  sra        $a2, $v0, 16
    /* C95C8 800D8DC8 40100600 */  sll        $v0, $a2, 1
    /* C95CC 800D8DCC 21104600 */  addu       $v0, $v0, $a2
    /* C95D0 800D8DD0 00110200 */  sll        $v0, $v0, 4
    /* C95D4 800D8DD4 23104600 */  subu       $v0, $v0, $a2
    /* C95D8 800D8DD8 C0100200 */  sll        $v0, $v0, 3
    /* C95DC 800D8DDC 23104600 */  subu       $v0, $v0, $a2
    /* C95E0 800D8DE0 00110200 */  sll        $v0, $v0, 4
    /* C95E4 800D8DE4 23482201 */  subu       $t1, $t1, $v0
    /* C95E8 800D8DE8 18002401 */  mult       $t1, $a0
    /* C95EC 800D8DEC C31F0900 */  sra        $v1, $t1, 31
    /* C95F0 800D8DF0 10580000 */  mfhi       $t3
    /* C95F4 800D8DF4 43110B00 */  sra        $v0, $t3, 5
    /* C95F8 800D8DF8 23104300 */  subu       $v0, $v0, $v1
    /* C95FC 800D8DFC 00140200 */  sll        $v0, $v0, 16
    /* C9600 800D8E00 03540200 */  sra        $t2, $v0, 16
    /* C9604 800D8E04 40100A00 */  sll        $v0, $t2, 1
    /* C9608 800D8E08 21104A00 */  addu       $v0, $v0, $t2
    /* C960C 800D8E0C C0100200 */  sll        $v0, $v0, 3
    /* C9610 800D8E10 21104A00 */  addu       $v0, $v0, $t2
    /* C9614 800D8E14 80100200 */  sll        $v0, $v0, 2
    /* C9618 800D8E18 23482201 */  subu       $t1, $t1, $v0
    /* C961C 800D8E1C 3C00C228 */  slti       $v0, $a2, 0x3C
    /* C9620 800D8E20 02004014 */  bnez       $v0, .L800D8E2C
    /* C9624 800D8E24 00000000 */   nop
    /* C9628 800D8E28 21380000 */  addu       $a3, $zero, $zero
  .L800D8E2C:
    /* C962C 800D8E2C 1700E010 */  beqz       $a3, .L800D8E8C
    /* C9630 800D8E30 2120A000 */   addu      $a0, $a1, $zero
    /* C9634 800D8E34 0580053C */  lui        $a1, %hi(D_80056904)
    /* C9638 800D8E38 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* C963C 800D8E3C EC310825 */  addiu      $t0, $t0, %lo(GameSetup_gData)
    /* C9640 800D8E40 E000028D */  lw         $v0, 0xE0($t0)
    /* C9644 800D8E44 1480033C */  lui        $v1, %hi(HudminChar)
    /* C9648 800D8E48 9CD86324 */  addiu      $v1, $v1, %lo(HudminChar)
    /* C964C 800D8E4C 21104300 */  addu       $v0, $v0, $v1
    /* C9650 800D8E50 00004790 */  lbu        $a3, 0x0($v0)
    /* C9654 800D8E54 0469A524 */  addiu      $a1, $a1, %lo(D_80056904)
    /* C9658 800D8E58 1000AAAF */  sw         $t2, 0x10($sp)
    /* C965C 800D8E5C E000038D */  lw         $v1, 0xE0($t0)
    /* C9660 800D8E60 1480023C */  lui        $v0, %hi(HudsecChar)
    /* C9664 800D8E64 A4D84224 */  addiu      $v0, $v0, %lo(HudsecChar)
    /* C9668 800D8E68 21186200 */  addu       $v1, $v1, $v0
    /* C966C 800D8E6C 00140900 */  sll        $v0, $t1, 16
    /* C9670 800D8E70 00006390 */  lbu        $v1, 0x0($v1)
    /* C9674 800D8E74 03140200 */  sra        $v0, $v0, 16
    /* C9678 800D8E78 1800A2AF */  sw         $v0, 0x18($sp)
    /* C967C 800D8E7C 2F91030C */  jal        sprintf
    /* C9680 800D8E80 1400A3AF */   sw        $v1, 0x14($sp)
    /* C9684 800D8E84 B0630308 */  j          .L800D8EC0
    /* C9688 800D8E88 00000000 */   nop
  .L800D8E8C:
    /* C968C 800D8E8C 1180023C */  lui        $v0, %hi(D_801132CC)
    /* C9690 800D8E90 CC32438C */  lw         $v1, %lo(D_801132CC)($v0)
    /* C9694 800D8E94 1480023C */  lui        $v0, %hi(HudminChar)
    /* C9698 800D8E98 9CD84224 */  addiu      $v0, $v0, %lo(HudminChar)
    /* C969C 800D8E9C 0580053C */  lui        $a1, %hi(D_80056918)
    /* C96A0 800D8EA0 21106200 */  addu       $v0, $v1, $v0
    /* C96A4 800D8EA4 00004690 */  lbu        $a2, 0x0($v0)
    /* C96A8 800D8EA8 1480023C */  lui        $v0, %hi(HudsecChar)
    /* C96AC 800D8EAC A4D84224 */  addiu      $v0, $v0, %lo(HudsecChar)
    /* C96B0 800D8EB0 21186200 */  addu       $v1, $v1, $v0
    /* C96B4 800D8EB4 00006790 */  lbu        $a3, 0x0($v1)
    /* C96B8 800D8EB8 2F91030C */  jal        sprintf
    /* C96BC 800D8EBC 1869A524 */   addiu     $a1, $a1, %lo(D_80056918)
  .L800D8EC0:
    /* C96C0 800D8EC0 2000BF8F */  lw         $ra, 0x20($sp)
    /* C96C4 800D8EC4 00000000 */  nop
    /* C96C8 800D8EC8 0800E003 */  jr         $ra
    /* C96CC 800D8ECC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_ParseTime__FiPc
