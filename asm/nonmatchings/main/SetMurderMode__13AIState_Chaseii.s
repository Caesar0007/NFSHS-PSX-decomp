.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetMurderMode__13AIState_Chaseii, 0x2C

glabel SetMurderMode__13AIState_Chaseii
    /* 6066C 8006FE6C 7000828C */  lw         $v0, 0x70($a0)
    /* 60670 8006FE70 00000000 */  nop
    /* 60674 8006FE74 06004014 */  bnez       $v0, .L8006FE90
    /* 60678 8006FE78 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 6067C 8006FE7C 700085AC */  sw         $a1, 0x70($a0)
    /* 60680 8006FE80 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 60684 8006FE84 00000000 */  nop
    /* 60688 8006FE88 21104600 */  addu       $v0, $v0, $a2
    /* 6068C 8006FE8C 740082AC */  sw         $v0, 0x74($a0)
  .L8006FE90:
    /* 60690 8006FE90 0800E003 */  jr         $ra
    /* 60694 8006FE94 00000000 */   nop
endlabel SetMurderMode__13AIState_Chaseii
