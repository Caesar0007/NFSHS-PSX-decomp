.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_HitWallCheck__FP8Car_tObj, 0xB0

glabel AIPhysic_HitWallCheck__FP8Car_tObj
    /* 5D070 8006C870 08008284 */  lh         $v0, 0x8($a0)
    /* 5D074 8006C874 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 5D078 8006C878 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 5D07C 8006C87C C406858C */  lw         $a1, 0x6C4($a0)
    /* 5D080 8006C880 40110200 */  sll        $v0, $v0, 5
    /* 5D084 8006C884 21104300 */  addu       $v0, $v0, $v1
    /* 5D088 8006C888 1D004790 */  lbu        $a3, 0x1D($v0)
    /* 5D08C 8006C88C 07000224 */  addiu      $v0, $zero, 0x7
    /* 5D090 8006C890 02190700 */  srl        $v1, $a3, 4
    /* 5D094 8006C894 23104300 */  subu       $v0, $v0, $v1
    /* 5D098 8006C898 2A10A200 */  slt        $v0, $a1, $v0
    /* 5D09C 8006C89C 05004014 */  bnez       $v0, .L8006C8B4
    /* 5D0A0 8006C8A0 21300000 */   addu      $a2, $zero, $zero
    /* 5D0A4 8006C8A4 0F00E230 */  andi       $v0, $a3, 0xF
    /* 5D0A8 8006C8A8 06004224 */  addiu      $v0, $v0, 0x6
    /* 5D0AC 8006C8AC 2A104500 */  slt        $v0, $v0, $a1
    /* 5D0B0 8006C8B0 01004638 */  xori       $a2, $v0, 0x1
  .L8006C8B4:
    /* 5D0B4 8006C8B4 0300C010 */  beqz       $a2, .L8006C8C4
    /* 5D0B8 8006C8B8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 5D0BC 8006C8BC 0800E003 */  jr         $ra
    /* 5D0C0 8006C8C0 21100000 */   addu      $v0, $zero, $zero
  .L8006C8C4:
    /* 5D0C4 8006C8C4 F006838C */  lw         $v1, 0x6F0($a0)
    /* 5D0C8 8006C8C8 00000000 */  nop
    /* 5D0CC 8006C8CC 07006214 */  bne        $v1, $v0, .L8006C8EC
    /* 5D0D0 8006C8D0 00000000 */   nop
    /* 5D0D4 8006C8D4 2407828C */  lw         $v0, 0x724($a0)
    /* 5D0D8 8006C8D8 5000838F */  lw         $v1, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5D0DC 8006C8DC 00000000 */  nop
    /* 5D0E0 8006C8E0 21104300 */  addu       $v0, $v0, $v1
    /* 5D0E4 8006C8E4 3CB20108 */  j          .L8006C8F0
    /* 5D0E8 8006C8E8 240782AC */   sw        $v0, 0x724($a0)
  .L8006C8EC:
    /* 5D0EC 8006C8EC 240780AC */  sw         $zero, 0x724($a0)
  .L8006C8F0:
    /* 5D0F0 8006C8F0 2407828C */  lw         $v0, 0x724($a0)
    /* 5D0F4 8006C8F4 00000000 */  nop
    /* 5D0F8 8006C8F8 09004228 */  slti       $v0, $v0, 0x9
    /* 5D0FC 8006C8FC 06004010 */  beqz       $v0, .L8006C918
    /* 5D100 8006C900 99D90234 */   ori       $v0, $zero, 0xD999
    /* 5D104 8006C904 5401838C */  lw         $v1, 0x154($a0)
    /* 5D108 8006C908 00000000 */  nop
    /* 5D10C 8006C90C 2A104300 */  slt        $v0, $v0, $v1
    /* 5D110 8006C910 0800E003 */  jr         $ra
    /* 5D114 8006C914 01004238 */   xori      $v0, $v0, 0x1
  .L8006C918:
    /* 5D118 8006C918 0800E003 */  jr         $ra
    /* 5D11C 8006C91C 01000224 */   addiu     $v0, $zero, 0x1
endlabel AIPhysic_HitWallCheck__FP8Car_tObj
