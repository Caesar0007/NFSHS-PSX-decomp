.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateMusic__14tFEApplication, 0xC0

glabel UpdateMusic__14tFEApplication
    /* 4560 80013D60 1180023C */  lui        $v0, %hi(D_80114941)
    /* 4564 80013D64 41494290 */  lbu        $v0, %lo(D_80114941)($v0)
    /* 4568 80013D68 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 456C 80013D6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4570 80013D70 21808000 */  addu       $s0, $a0, $zero
    /* 4574 80013D74 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4578 80013D78 C0200200 */  sll        $a0, $v0, 3
    /* 457C 80013D7C 21208200 */  addu       $a0, $a0, $v0
    /* 4580 80013D80 80200400 */  sll        $a0, $a0, 2
    /* 4584 80013D84 23208200 */  subu       $a0, $a0, $v0
    /* 4588 80013D88 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 458C 80013D8C 83210400 */   sra       $a0, $a0, 6
    /* 4590 80013D90 0000108E */  lw         $s0, 0x0($s0)
    /* 4594 80013D94 00000000 */  nop
    /* 4598 80013D98 00100232 */  andi       $v0, $s0, 0x1000
    /* 459C 80013D9C 05004010 */  beqz       $v0, .L80013DB4
    /* 45A0 80013DA0 0180043C */   lui       $a0, %hi(D_80010050)
    /* 45A4 80013DA4 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 45A8 80013DA8 50008424 */   addiu     $a0, $a0, %lo(D_80010050)
    /* 45AC 80013DAC 844F0008 */  j          .L80013E10
    /* 45B0 80013DB0 00000000 */   nop
  .L80013DB4:
    /* 45B4 80013DB4 00200232 */  andi       $v0, $s0, 0x2000
    /* 45B8 80013DB8 05004010 */  beqz       $v0, .L80013DD0
    /* 45BC 80013DBC 0180043C */   lui       $a0, %hi(D_80010058)
    /* 45C0 80013DC0 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 45C4 80013DC4 58008424 */   addiu     $a0, $a0, %lo(D_80010058)
    /* 45C8 80013DC8 844F0008 */  j          .L80013E10
    /* 45CC 80013DCC 00000000 */   nop
  .L80013DD0:
    /* 45D0 80013DD0 00400232 */  andi       $v0, $s0, 0x4000
    /* 45D4 80013DD4 05004010 */  beqz       $v0, .L80013DEC
    /* 45D8 80013DD8 0180043C */   lui       $a0, %hi(D_80010060)
    /* 45DC 80013DDC 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 45E0 80013DE0 60008424 */   addiu     $a0, $a0, %lo(D_80010060)
    /* 45E4 80013DE4 844F0008 */  j          .L80013E10
    /* 45E8 80013DE8 00000000 */   nop
  .L80013DEC:
    /* 45EC 80013DEC 00800232 */  andi       $v0, $s0, 0x8000
    /* 45F0 80013DF0 05004010 */  beqz       $v0, .L80013E08
    /* 45F4 80013DF4 0180043C */   lui       $a0, %hi(D_8001006C)
    /* 45F8 80013DF8 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 45FC 80013DFC 6C008424 */   addiu     $a0, $a0, %lo(D_8001006C)
    /* 4600 80013E00 844F0008 */  j          .L80013E10
    /* 4604 80013E04 00000000 */   nop
  .L80013E08:
    /* 4608 80013E08 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 460C 80013E0C E8030424 */   addiu     $a0, $zero, 0x3E8
  .L80013E10:
    /* 4610 80013E10 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4614 80013E14 1000B08F */  lw         $s0, 0x10($sp)
    /* 4618 80013E18 0800E003 */  jr         $ra
    /* 461C 80013E1C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateMusic__14tFEApplication
