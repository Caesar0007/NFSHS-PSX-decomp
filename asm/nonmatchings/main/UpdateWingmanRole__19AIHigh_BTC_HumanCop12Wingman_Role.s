.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role, 0x4C

glabel UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
    /* 4E754 8005DF54 01000224 */  addiu      $v0, $zero, 0x1
    /* 4E758 8005DF58 0E00A210 */  beq        $a1, $v0, .L8005DF94
    /* 4E75C 8005DF5C 0200A228 */   slti      $v0, $a1, 0x2
    /* 4E760 8005DF60 05004010 */  beqz       $v0, .L8005DF78
    /* 4E764 8005DF64 00000000 */   nop
    /* 4E768 8005DF68 0800A010 */  beqz       $a1, .L8005DF8C
    /* 4E76C 8005DF6C 00000000 */   nop
  .L8005DF70:
    /* 4E770 8005DF70 0800E003 */  jr         $ra
    /* 4E774 8005DF74 00000000 */   nop
  .L8005DF78:
    /* 4E778 8005DF78 0400A228 */  slti       $v0, $a1, 0x4
    /* 4E77C 8005DF7C FCFF4010 */  beqz       $v0, .L8005DF70
    /* 4E780 8005DF80 05000224 */   addiu     $v0, $zero, 0x5
    /* 4E784 8005DF84 0800E003 */  jr         $ra
    /* 4E788 8005DF88 780082AC */   sw        $v0, 0x78($a0)
  .L8005DF8C:
    /* 4E78C 8005DF8C 0800E003 */  jr         $ra
    /* 4E790 8005DF90 780080AC */   sw        $zero, 0x78($a0)
  .L8005DF94:
    /* 4E794 8005DF94 04000224 */  addiu      $v0, $zero, 0x4
    /* 4E798 8005DF98 0800E003 */  jr         $ra
    /* 4E79C 8005DF9C 780082AC */   sw        $v0, 0x78($a0)
endlabel UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
