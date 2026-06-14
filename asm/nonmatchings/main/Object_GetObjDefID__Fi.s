.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetObjDefID__Fi, 0x54

glabel Object_GetObjDefID__Fi
    /* 96158 800A5958 1480023C */  lui        $v0, %hi(gPersistObjDef)
    /* 9615C 800A595C BCD4428C */  lw         $v0, %lo(gPersistObjDef)($v0)
    /* 96160 800A5960 00000000 */  nop
    /* 96164 800A5964 0F004010 */  beqz       $v0, .L800A59A4
    /* 96168 800A5968 00000000 */   nop
    /* 9616C 800A596C 0000428C */  lw         $v0, 0x0($v0)
    /* 96170 800A5970 00000000 */  nop
    /* 96174 800A5974 2A108200 */  slt        $v0, $a0, $v0
    /* 96178 800A5978 0A004010 */  beqz       $v0, .L800A59A4
    /* 9617C 800A597C 80180400 */   sll       $v1, $a0, 2
    /* 96180 800A5980 1480023C */  lui        $v0, %hi(Track_gObjDefs)
    /* 96184 800A5984 D4D4428C */  lw         $v0, %lo(Track_gObjDefs)($v0)
    /* 96188 800A5988 00000000 */  nop
    /* 9618C 800A598C 21186200 */  addu       $v1, $v1, $v0
    /* 96190 800A5990 0000628C */  lw         $v0, 0x0($v1)
    /* 96194 800A5994 00000000 */  nop
    /* 96198 800A5998 00004284 */  lh         $v0, 0x0($v0)
    /* 9619C 800A599C 0800E003 */  jr         $ra
    /* 961A0 800A59A0 00000000 */   nop
  .L800A59A4:
    /* 961A4 800A59A4 0800E003 */  jr         $ra
    /* 961A8 800A59A8 21100000 */   addu      $v0, $zero, $zero
endlabel Object_GetObjDefID__Fi
