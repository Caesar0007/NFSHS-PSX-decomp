.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETexture_LoadPmx__FPciP18tTexture_ShapeInfo, 0x24

glabel FETexture_LoadPmx__FPciP18tTexture_ShapeInfo
    /* 3FBB8 8004F3B8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3FBBC 8004F3BC 21380000 */  addu       $a3, $zero, $zero
    /* 3FBC0 8004F3C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3FBC4 8004F3C4 403C010C */  jal        FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
    /* 3FBC8 8004F3C8 1000A0AF */   sw        $zero, 0x10($sp)
    /* 3FBCC 8004F3CC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3FBD0 8004F3D0 00000000 */  nop
    /* 3FBD4 8004F3D4 0800E003 */  jr         $ra
    /* 3FBD8 8004F3D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FETexture_LoadPmx__FPciP18tTexture_ShapeInfo
    /* 3FBDC 8004F3DC 00000000 */  nop
