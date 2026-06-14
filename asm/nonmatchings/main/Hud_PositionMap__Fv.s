.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_PositionMap__Fv, 0x108

glabel Hud_PositionMap__Fv
    /* C9CC0 800D94C0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C9CC4 800D94C4 1280023C */  lui        $v0, %hi(fMapScaleX)
    /* C9CC8 800D94C8 1800B2AF */  sw         $s2, 0x18($sp)
    /* C9CCC 800D94CC 1180123C */  lui        $s2, %hi(GameSetup_gData)
    /* C9CD0 800D94D0 EC315226 */  addiu      $s2, $s2, %lo(GameSetup_gData)
    /* C9CD4 800D94D4 C00A4224 */  addiu      $v0, $v0, %lo(fMapScaleX)
    /* C9CD8 800D94D8 2000BFAF */  sw         $ra, 0x20($sp)
    /* C9CDC 800D94DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C9CE0 800D94E0 1400B1AF */  sw         $s1, 0x14($sp)
    /* C9CE4 800D94E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* C9CE8 800D94E8 3C00538E */  lw         $s3, 0x3C($s2)
    /* C9CEC 800D94EC 8047113C */  lui        $s1, (0x47800000 >> 16)
    /* C9CF0 800D94F0 80801300 */  sll        $s0, $s3, 2
    /* C9CF4 800D94F4 21100202 */  addu       $v0, $s0, $v0
    /* C9CF8 800D94F8 0000448C */  lw         $a0, 0x0($v0)
    /* C9CFC 800D94FC 2CCD030C */  jal        __mulsf3
    /* C9D00 800D9500 21282002 */   addu      $a1, $s1, $zero
    /* C9D04 800D9504 4ECE030C */  jal        __fixsfsi
    /* C9D08 800D9508 21204000 */   addu      $a0, $v0, $zero
    /* C9D0C 800D950C 1280033C */  lui        $v1, %hi(fMapScaleY)
    /* C9D10 800D9510 EC0A6324 */  addiu      $v1, $v1, %lo(fMapScaleY)
    /* C9D14 800D9514 21800302 */  addu       $s0, $s0, $v1
    /* C9D18 800D9518 0000048E */  lw         $a0, 0x0($s0)
    /* C9D1C 800D951C 281482AF */  sw         $v0, %gp_rel(gMapScaleX)($gp)
    /* C9D20 800D9520 2CCD030C */  jal        __mulsf3
    /* C9D24 800D9524 21282002 */   addu      $a1, $s1, $zero
    /* C9D28 800D9528 4ECE030C */  jal        __fixsfsi
    /* C9D2C 800D952C 21204000 */   addu      $a0, $v0, $zero
    /* C9D30 800D9530 1280033C */  lui        $v1, %hi(fMapOffX)
    /* C9D34 800D9534 180B6324 */  addiu      $v1, $v1, %lo(fMapOffX)
    /* C9D38 800D9538 40981300 */  sll        $s3, $s3, 1
    /* C9D3C 800D953C 21186302 */  addu       $v1, $s3, $v1
    /* C9D40 800D9540 00006484 */  lh         $a0, 0x0($v1)
    /* C9D44 800D9544 2C00438E */  lw         $v1, 0x2C($s2)
    /* C9D48 800D9548 2C1482AF */  sw         $v0, %gp_rel(gMapScaleY)($gp)
    /* C9D4C 800D954C 301484AF */  sw         $a0, %gp_rel(gMapOffX)($gp)
    /* C9D50 800D9550 02006010 */  beqz       $v1, .L800D955C
    /* C9D54 800D9554 FEFF8224 */   addiu     $v0, $a0, -0x2
    /* C9D58 800D9558 301482AF */  sw         $v0, %gp_rel(gMapOffX)($gp)
  .L800D955C:
    /* C9D5C 800D955C 1280033C */  lui        $v1, %hi(fMapOffY)
    /* C9D60 800D9560 300B6324 */  addiu      $v1, $v1, %lo(fMapOffY)
    /* C9D64 800D9564 21186302 */  addu       $v1, $s3, $v1
    /* C9D68 800D9568 1280023C */  lui        $v0, %hi(fMapRotate)
    /* C9D6C 800D956C 480B4224 */  addiu      $v0, $v0, %lo(fMapRotate)
    /* C9D70 800D9570 21106202 */  addu       $v0, $s3, $v0
    /* C9D74 800D9574 00004484 */  lh         $a0, 0x0($v0)
    /* C9D78 800D9578 00006284 */  lh         $v0, 0x0($v1)
    /* C9D7C 800D957C 00000000 */  nop
    /* C9D80 800D9580 341482AF */  sw         $v0, %gp_rel(gMapOffY)($gp)
    /* C9D84 800D9584 241484AF */  sw         $a0, %gp_rel(gMapRotate)($gp)
    /* C9D88 800D9588 CACD030C */  jal        ccos
    /* C9D8C 800D958C 00000000 */   nop
    /* C9D90 800D9590 2414848F */  lw         $a0, %gp_rel(gMapRotate)($gp)
    /* C9D94 800D9594 00110200 */  sll        $v0, $v0, 4
    /* C9D98 800D9598 FC1382AF */  sw         $v0, %gp_rel(mapMarkerMCos)($gp)
    /* C9D9C 800D959C FECD030C */  jal        csin
    /* C9DA0 800D95A0 00000000 */   nop
    /* C9DA4 800D95A4 2000BF8F */  lw         $ra, 0x20($sp)
    /* C9DA8 800D95A8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C9DAC 800D95AC 1800B28F */  lw         $s2, 0x18($sp)
    /* C9DB0 800D95B0 1400B18F */  lw         $s1, 0x14($sp)
    /* C9DB4 800D95B4 1000B08F */  lw         $s0, 0x10($sp)
    /* C9DB8 800D95B8 00110200 */  sll        $v0, $v0, 4
    /* C9DBC 800D95BC 001482AF */  sw         $v0, %gp_rel(mapMarkerMSin)($gp)
    /* C9DC0 800D95C0 0800E003 */  jr         $ra
    /* C9DC4 800D95C4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_PositionMap__Fv
