.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculatePrizes__23tScreenBeTheCopCongrats, 0x50

glabel CalculatePrizes__23tScreenBeTheCopCongrats
    /* 39CDC 800494DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39CE0 800494E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 39CE4 800494E4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 39CE8 800494E8 6E22010C */  jal        CalculatePrizes__15tScreenCongrats
    /* 39CEC 800494EC 21808000 */   addu      $s0, $a0, $zero
    /* 39CF0 800494F0 8040033C */  lui        $v1, (0x40800000 >> 16)
    /* 39CF4 800494F4 ECC0043C */  lui        $a0, (0xC0ECCCCD >> 16)
    /* 39CF8 800494F8 CDCC8434 */  ori        $a0, $a0, (0xC0ECCCCD & 0xFFFF)
    /* 39CFC 800494FC 03000224 */  addiu      $v0, $zero, 0x3
    /* 39D00 80049500 680002AE */  sw         $v0, 0x68($s0)
    /* 39D04 80049504 16010224 */  addiu      $v0, $zero, 0x116
    /* 39D08 80049508 780102A6 */  sh         $v0, 0x178($s0)
    /* 39D0C 8004950C 4B000224 */  addiu      $v0, $zero, 0x4B
    /* 39D10 80049510 7A0102A6 */  sh         $v0, 0x17A($s0)
    /* 39D14 80049514 7C0103AE */  sw         $v1, 0x17C($s0)
    /* 39D18 80049518 800104AE */  sw         $a0, 0x180($s0)
    /* 39D1C 8004951C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 39D20 80049520 1000B08F */  lw         $s0, 0x10($sp)
    /* 39D24 80049524 0800E003 */  jr         $ra
    /* 39D28 80049528 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalculatePrizes__23tScreenBeTheCopCongrats
