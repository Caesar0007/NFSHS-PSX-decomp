.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__16tScreenTrackInfo, 0x6C

glabel Initialize__16tScreenTrackInfo
    /* 32D20 80042520 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 32D24 80042524 2000B0AF */  sw         $s0, 0x20($sp)
    /* 32D28 80042528 21808000 */  addu       $s0, $a0, $zero
    /* 32D2C 8004252C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 32D30 80042530 2B98000C */  jal        Initialize__7tScreen
    /* 32D34 80042534 2400B1AF */   sw        $s1, 0x24($sp)
    /* 32D38 80042538 6C021126 */  addiu      $s1, $s0, 0x26C
    /* 32D3C 8004253C 21202002 */  addu       $a0, $s1, $zero
    /* 32D40 80042540 0A000224 */  addiu      $v0, $zero, 0xA
    /* 32D44 80042544 1000A2AF */  sw         $v0, 0x10($sp)
    /* 32D48 80042548 0580023C */  lui        $v0, %hi(D_800520B8)
    /* 32D4C 8004254C B8204224 */  addiu      $v0, $v0, %lo(D_800520B8)
    /* 32D50 80042550 8C000526 */  addiu      $a1, $s0, 0x8C
    /* 32D54 80042554 1400A2AF */  sw         $v0, 0x14($sp)
    /* 32D58 80042558 1800A0AF */  sw         $zero, 0x18($sp)
    /* 32D5C 8004255C 2800068E */  lw         $a2, 0x28($s0)
    /* 32D60 80042560 E4D9000C */  jal        Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 32D64 80042564 21380000 */   addu      $a3, $zero, $zero
    /* 32D68 80042568 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 32D6C 8004256C 21202002 */   addu      $a0, $s1, $zero
    /* 32D70 80042570 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 32D74 80042574 21202002 */   addu      $a0, $s1, $zero
    /* 32D78 80042578 2800BF8F */  lw         $ra, 0x28($sp)
    /* 32D7C 8004257C 2400B18F */  lw         $s1, 0x24($sp)
    /* 32D80 80042580 2000B08F */  lw         $s0, 0x20($sp)
    /* 32D84 80042584 0800E003 */  jr         $ra
    /* 32D88 80042588 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Initialize__16tScreenTrackInfo
