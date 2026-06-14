.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_FindDefWithThisID__Fi, 0x58

glabel Object_FindDefWithThisID__Fi
    /* 961AC 800A59AC 21180000 */  addu       $v1, $zero, $zero
    /* 961B0 800A59B0 1480023C */  lui        $v0, %hi(gPersistObjDef)
    /* 961B4 800A59B4 BCD4428C */  lw         $v0, %lo(gPersistObjDef)($v0)
    /* 961B8 800A59B8 1480053C */  lui        $a1, %hi(Track_gObjDefs)
    /* 961BC 800A59BC D4D4A58C */  lw         $a1, %lo(Track_gObjDefs)($a1)
    /* 961C0 800A59C0 0000468C */  lw         $a2, 0x0($v0)
  .L800A59C4:
    /* 961C4 800A59C4 00000000 */  nop
    /* 961C8 800A59C8 2A106600 */  slt        $v0, $v1, $a2
    /* 961CC 800A59CC 0B004010 */  beqz       $v0, .L800A59FC
    /* 961D0 800A59D0 00000000 */   nop
    /* 961D4 800A59D4 0000A28C */  lw         $v0, 0x0($a1)
    /* 961D8 800A59D8 00000000 */  nop
    /* 961DC 800A59DC 00004284 */  lh         $v0, 0x0($v0)
    /* 961E0 800A59E0 00000000 */  nop
    /* 961E4 800A59E4 03008214 */  bne        $a0, $v0, .L800A59F4
    /* 961E8 800A59E8 0400A524 */   addiu     $a1, $a1, 0x4
    /* 961EC 800A59EC 0800E003 */  jr         $ra
    /* 961F0 800A59F0 21106000 */   addu      $v0, $v1, $zero
  .L800A59F4:
    /* 961F4 800A59F4 71960208 */  j          .L800A59C4
    /* 961F8 800A59F8 01006324 */   addiu     $v1, $v1, 0x1
  .L800A59FC:
    /* 961FC 800A59FC 0800E003 */  jr         $ra
    /* 96200 800A5A00 FFFF0224 */   addiu     $v0, $zero, -0x1
endlabel Object_FindDefWithThisID__Fi
