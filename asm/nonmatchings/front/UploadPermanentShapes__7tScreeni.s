.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UploadPermanentShapes__7tScreeni, 0x4C

glabel UploadPermanentShapes__7tScreeni
    /* 16784 80025F84 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 16788 80025F88 1800B0AF */  sw         $s0, 0x18($sp)
    /* 1678C 80025F8C 21808000 */  addu       $s0, $a0, $zero
    /* 16790 80025F90 002C0500 */  sll        $a1, $a1, 16
    /* 16794 80025F94 032C0500 */  sra        $a1, $a1, 16
    /* 16798 80025F98 1000A5AF */  sw         $a1, 0x10($sp)
    /* 1679C 80025F9C 21280002 */  addu       $a1, $s0, $zero
    /* 167A0 80025FA0 21300000 */  addu       $a2, $zero, $zero
    /* 167A4 80025FA4 2138C000 */  addu       $a3, $a2, $zero
    /* 167A8 80025FA8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 167AC 80025FAC 7D99000C */  jal        UploadShapes__7tScreenR17tShapeInformationssss
    /* 167B0 80025FB0 1400A0AF */   sw        $zero, 0x14($sp)
    /* 167B4 80025FB4 0000038E */  lw         $v1, 0x0($s0)
    /* 167B8 80025FB8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 167BC 80025FBC 1800B08F */  lw         $s0, 0x18($sp)
    /* 167C0 80025FC0 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 167C4 80025FC4 CC1743AC */  sw         $v1, %lo(gCurrentShapes)($v0)
    /* 167C8 80025FC8 0800E003 */  jr         $ra
    /* 167CC 80025FCC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UploadPermanentShapes__7tScreeni
