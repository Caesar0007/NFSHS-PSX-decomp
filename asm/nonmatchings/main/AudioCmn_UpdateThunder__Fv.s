.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_UpdateThunder__Fv, 0xAC

glabel AudioCmn_UpdateThunder__Fv
    /* 66CD0 800764D0 C801878F */  lw         $a3, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66CD4 800764D4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 66CD8 800764D8 2400E018 */  blez       $a3, .L8007656C
    /* 66CDC 800764DC 1800BFAF */   sw        $ra, 0x18($sp)
    /* 66CE0 800764E0 D001828F */  lw         $v0, %gp_rel(AudioCmn_ThunderDel)($gp)
    /* 66CE4 800764E4 00000000 */  nop
    /* 66CE8 800764E8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 66CEC 800764EC D00182AF */  sw         $v0, %gp_rel(AudioCmn_ThunderDel)($gp)
    /* 66CF0 800764F0 1E004104 */  bgez       $v0, .L8007656C
    /* 66CF4 800764F4 40000224 */   addiu     $v0, $zero, 0x40
    /* 66CF8 800764F8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 66CFC 800764FC 1180023C */  lui        $v0, %hi(D_8010E8CC)
    /* 66D00 80076500 CC01868F */  lw         $a2, %gp_rel(AudioCmn_ThunderAzi)($gp)
    /* 66D04 80076504 CCE8448C */  lw         $a0, %lo(D_8010E8CC)($v0)
    /* 66D08 80076508 E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* 66D0C 8007650C 16000524 */   addiu     $a1, $zero, 0x16
    /* 66D10 80076510 C801828F */  lw         $v0, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66D14 80076514 00000000 */  nop
    /* 66D18 80076518 2E004228 */  slti       $v0, $v0, 0x2E
    /* 66D1C 8007651C 07004014 */  bnez       $v0, .L8007653C
    /* 66D20 80076520 00000000 */   nop
    /* 66D24 80076524 EA9D030C */  jal        random
    /* 66D28 80076528 00000000 */   nop
    /* 66D2C 8007652C C801838F */  lw         $v1, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66D30 80076530 0F004230 */  andi       $v0, $v0, 0xF
    /* 66D34 80076534 54D90108 */  j          .L80076550
    /* 66D38 80076538 03006324 */   addiu     $v1, $v1, 0x3
  .L8007653C:
    /* 66D3C 8007653C EA9D030C */  jal        random
    /* 66D40 80076540 00000000 */   nop
    /* 66D44 80076544 C801838F */  lw         $v1, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66D48 80076548 07004230 */  andi       $v0, $v0, 0x7
    /* 66D4C 8007654C 02006324 */  addiu      $v1, $v1, 0x2
  .L80076550:
    /* 66D50 80076550 23186200 */  subu       $v1, $v1, $v0
    /* 66D54 80076554 C80183AF */  sw         $v1, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66D58 80076558 EA9D030C */  jal        random
    /* 66D5C 8007655C 00000000 */   nop
    /* 66D60 80076560 14004224 */  addiu      $v0, $v0, 0x14
    /* 66D64 80076564 03004230 */  andi       $v0, $v0, 0x3
    /* 66D68 80076568 D00182AF */  sw         $v0, %gp_rel(AudioCmn_ThunderDel)($gp)
  .L8007656C:
    /* 66D6C 8007656C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 66D70 80076570 00000000 */  nop
    /* 66D74 80076574 0800E003 */  jr         $ra
    /* 66D78 80076578 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_UpdateThunder__Fv
