.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching func_80106500, 0x30

glabel func_80106500
    /* F6D00 80106500 040041AF */  sw         $at, 0x4($k0) /* handwritten instruction */
    /* F6D04 80106504 080042AF */  sw         $v0, 0x8($k0) /* handwritten instruction */
    /* F6D08 80106508 0C0043AF */  sw         $v1, 0xC($k0) /* handwritten instruction */
    /* F6D0C 8010650C 7C005FAF */  sw         $ra, 0x7C($k0) /* handwritten instruction */
    /* F6D10 80106510 00700340 */  mfc0       $v1, $14 /* handwritten instruction */
    /* F6D14 80106514 00000000 */  nop
  alabel D_80106518
    /* F6D18 80106518 040041AF */  sw         $at, 0x4($k0) /* handwritten instruction */
    /* F6D1C 8010651C 080042AF */  sw         $v0, 0x8($k0) /* handwritten instruction */
    /* F6D20 80106520 00680240 */  mfc0       $v0, $13 /* handwritten instruction */
    /* F6D24 80106524 0C0043AF */  sw         $v1, 0xC($k0) /* handwritten instruction */
    /* F6D28 80106528 00700340 */  mfc0       $v1, $14 /* handwritten instruction */
    /* F6D2C 8010652C 7C005FAF */  sw         $ra, 0x7C($k0) /* handwritten instruction */
endlabel func_80106500
  alabel D_80106530
    /* F6D30 80106530 00000000 */  nop
