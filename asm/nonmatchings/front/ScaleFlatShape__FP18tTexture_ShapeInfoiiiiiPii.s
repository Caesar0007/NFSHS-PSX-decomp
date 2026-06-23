.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii, 0x50

glabel ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii
    /* 3F238 8004EA38 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3F23C 8004EA3C 4000A38F */  lw         $v1, 0x40($sp)
    /* 3F240 8004EA40 3800A88F */  lw         $t0, 0x38($sp)
    /* 3F244 8004EA44 3C00A98F */  lw         $t1, 0x3C($sp)
    /* 3F248 8004EA48 4400AA8F */  lw         $t2, 0x44($sp)
    /* 3F24C 8004EA4C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 3F250 8004EA50 0000628C */  lw         $v0, 0x0($v1)
    /* 3F254 8004EA54 00000000 */  nop
    /* 3F258 8004EA58 0C0062AC */  sw         $v0, 0xC($v1)
    /* 3F25C 8004EA5C 080062AC */  sw         $v0, 0x8($v1)
    /* 3F260 8004EA60 040062AC */  sw         $v0, 0x4($v1)
    /* 3F264 8004EA64 1000A8AF */  sw         $t0, 0x10($sp)
    /* 3F268 8004EA68 1400A9AF */  sw         $t1, 0x14($sp)
    /* 3F26C 8004EA6C 1800A3AF */  sw         $v1, 0x18($sp)
    /* 3F270 8004EA70 DF39010C */  jal        ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
    /* 3F274 8004EA74 1C00AAAF */   sw        $t2, 0x1C($sp)
    /* 3F278 8004EA78 2000BF8F */  lw         $ra, 0x20($sp)
    /* 3F27C 8004EA7C 00000000 */  nop
    /* 3F280 8004EA80 0800E003 */  jr         $ra
    /* 3F284 8004EA84 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii
