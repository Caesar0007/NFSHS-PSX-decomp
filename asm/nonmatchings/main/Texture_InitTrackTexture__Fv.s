.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_InitTrackTexture__Fv, 0x58

glabel Texture_InitTrackTexture__Fv
    /* D0CB8 800E04B8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D0CBC 800E04BC F0130424 */  addiu      $a0, $zero, 0x13F0
    /* D0CC0 800E04C0 0580053C */  lui        $a1, %hi(D_80056A50)
    /* D0CC4 800E04C4 1000BFAF */  sw         $ra, 0x10($sp)
    /* D0CC8 800E04C8 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* D0CCC 800E04CC 506AA524 */   addiu     $a1, $a1, %lo(D_80056A50)
    /* D0CD0 800E04D0 10000424 */  addiu      $a0, $zero, 0x10
    /* D0CD4 800E04D4 0580053C */  lui        $a1, %hi(D_80056A5C)
    /* D0CD8 800E04D8 E01582AF */  sw         $v0, %gp_rel(gFreePal4)($gp)
    /* D0CDC 800E04DC 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* D0CE0 800E04E0 5C6AA524 */   addiu     $a1, $a1, %lo(D_80056A5C)
    /* D0CE4 800E04E4 E81582AF */  sw         $v0, %gp_rel(gFreePal8)($gp)
    /* D0CE8 800E04E8 6D7D030C */  jal        Texture_InitPaletteSharing__Fv
    /* D0CEC 800E04EC 00000000 */   nop
    /* D0CF0 800E04F0 4D84030C */  jal        TextureProcess_Init__Fv
    /* D0CF4 800E04F4 00000000 */   nop
    /* D0CF8 800E04F8 0D7E030C */  jal        Texture_InitClut__Fv
    /* D0CFC 800E04FC 00000000 */   nop
    /* D0D00 800E0500 1000BF8F */  lw         $ra, 0x10($sp)
    /* D0D04 800E0504 00000000 */  nop
    /* D0D08 800E0508 0800E003 */  jr         $ra
    /* D0D0C 800E050C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Texture_InitTrackTexture__Fv
