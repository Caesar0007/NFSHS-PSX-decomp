.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_InitStats__FP8Car_tObj, 0x68

glabel Cars_InitStats__FP8Car_tObj
    /* 7687C 8008607C 21280000 */  addu       $a1, $zero, $zero
    /* 76880 80086080 4C038424 */  addiu      $a0, $a0, 0x34C
    /* 76884 80086084 21188000 */  addu       $v1, $a0, $zero
    /* 76888 80086088 00020224 */  addiu      $v0, $zero, 0x200
    /* 7688C 8008608C 040080AC */  sw         $zero, 0x4($a0)
    /* 76890 80086090 080080AC */  sw         $zero, 0x8($a0)
    /* 76894 80086094 0C0080AC */  sw         $zero, 0xC($a0)
    /* 76898 80086098 100080AC */  sw         $zero, 0x10($a0)
    /* 7689C 8008609C 140080AC */  sw         $zero, 0x14($a0)
    /* 768A0 800860A0 180082AC */  sw         $v0, 0x18($a0)
  .L800860A4:
    /* 768A4 800860A4 1C0060AC */  sw         $zero, 0x1C($v1)
    /* 768A8 800860A8 2C0060AC */  sw         $zero, 0x2C($v1)
    /* 768AC 800860AC 0100A524 */  addiu      $a1, $a1, 0x1
    /* 768B0 800860B0 0400A228 */  slti       $v0, $a1, 0x4
    /* 768B4 800860B4 FBFF4014 */  bnez       $v0, .L800860A4
    /* 768B8 800860B8 04006324 */   addiu     $v1, $v1, 0x4
    /* 768BC 800860BC 3C0080AC */  sw         $zero, 0x3C($a0)
    /* 768C0 800860C0 400080AC */  sw         $zero, 0x40($a0)
    /* 768C4 800860C4 440080AC */  sw         $zero, 0x44($a0)
    /* 768C8 800860C8 4C0080AC */  sw         $zero, 0x4C($a0)
    /* 768CC 800860CC 480080AC */  sw         $zero, 0x48($a0)
    /* 768D0 800860D0 500080AC */  sw         $zero, 0x50($a0)
    /* 768D4 800860D4 540080AC */  sw         $zero, 0x54($a0)
    /* 768D8 800860D8 580080AC */  sw         $zero, 0x58($a0)
    /* 768DC 800860DC 0800E003 */  jr         $ra
    /* 768E0 800860E0 5C0080AC */   sw        $zero, 0x5C($a0)
endlabel Cars_InitStats__FP8Car_tObj
