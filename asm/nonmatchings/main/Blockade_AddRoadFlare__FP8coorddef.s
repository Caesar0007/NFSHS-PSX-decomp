.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Blockade_AddRoadFlare__FP8coorddef, 0x54

glabel Blockade_AddRoadFlare__FP8coorddef
    /* 4CC14 8005C414 1480063C */  lui        $a2, %hi(Object_customSFXInst)
    /* 4CC18 8005C418 D0D2C68C */  lw         $a2, %lo(Object_customSFXInst)($a2)
    /* 4CC1C 8005C41C 0000858C */  lw         $a1, 0x0($a0)
    /* 4CC20 8005C420 0000C38C */  lw         $v1, 0x0($a2)
    /* 4CC24 8005C424 0400C224 */  addiu      $v0, $a2, 0x4
    /* 4CC28 8005C428 00190300 */  sll        $v1, $v1, 4
    /* 4CC2C 8005C42C 21104300 */  addu       $v0, $v0, $v1
    /* 4CC30 8005C430 000045AC */  sw         $a1, 0x0($v0)
    /* 4CC34 8005C434 0400838C */  lw         $v1, 0x4($a0)
    /* 4CC38 8005C438 00000000 */  nop
    /* 4CC3C 8005C43C 040043AC */  sw         $v1, 0x4($v0)
    /* 4CC40 8005C440 0800848C */  lw         $a0, 0x8($a0)
    /* 4CC44 8005C444 16000324 */  addiu      $v1, $zero, 0x16
    /* 4CC48 8005C448 0C0043A4 */  sh         $v1, 0xC($v0)
    /* 4CC4C 8005C44C 0E0040A4 */  sh         $zero, 0xE($v0)
    /* 4CC50 8005C450 080044AC */  sw         $a0, 0x8($v0)
    /* 4CC54 8005C454 0000C28C */  lw         $v0, 0x0($a2)
    /* 4CC58 8005C458 00000000 */  nop
    /* 4CC5C 8005C45C 01004224 */  addiu      $v0, $v0, 0x1
    /* 4CC60 8005C460 0800E003 */  jr         $ra
    /* 4CC64 8005C464 0000C2AC */   sw        $v0, 0x0($a2)
endlabel Blockade_AddRoadFlare__FP8coorddef
