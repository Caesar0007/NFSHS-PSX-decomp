.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman, 0x40

glabel UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
    /* 4F6F8 8005EEF8 6000838C */  lw         $v1, 0x60($a0)
    /* 4F6FC 8005EEFC 03000224 */  addiu      $v0, $zero, 0x3
    /* 4F700 8005EF00 09006210 */  beq        $v1, $v0, .L8005EF28
    /* 4F704 8005EF04 01000324 */   addiu     $v1, $zero, 0x1
    /* 4F708 8005EF08 0000828C */  lw         $v0, 0x0($a0)
    /* 4F70C 8005EF0C 00000000 */  nop
    /* 4F710 8005EF10 780240AC */  sw         $zero, 0x278($v0)
    /* 4F714 8005EF14 6000828C */  lw         $v0, 0x60($a0)
    /* 4F718 8005EF18 600080AC */  sw         $zero, 0x60($a0)
    /* 4F71C 8005EF1C 04004238 */  xori       $v0, $v0, 0x4
    /* 4F720 8005EF20 0800E003 */  jr         $ra
    /* 4F724 8005EF24 0100422C */   sltiu     $v0, $v0, 0x1
  .L8005EF28:
    /* 4F728 8005EF28 21100000 */  addu       $v0, $zero, $zero
    /* 4F72C 8005EF2C 0000848C */  lw         $a0, 0x0($a0)
    /* 4F730 8005EF30 0800E003 */  jr         $ra
    /* 4F734 8005EF34 780283AC */   sw        $v1, 0x278($a0)
endlabel UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
