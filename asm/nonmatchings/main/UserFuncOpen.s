.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UserFuncOpen, 0x7C

glabel UserFuncOpen
    /* FA410 80109C10 1480023C */  lui        $v0, %hi(D_8013C2E0)
    /* FA414 80109C14 E0C2428C */  lw         $v0, %lo(D_8013C2E0)($v0)
    /* FA418 80109C18 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA41C 80109C1C 01004624 */  addiu      $a2, $v0, 0x1
    /* FA420 80109C20 0400C228 */  slti       $v0, $a2, 0x4
    /* FA424 80109C24 06004014 */  bnez       $v0, .L80109C40
    /* FA428 80109C28 1000BFAF */   sw        $ra, 0x10($sp)
    /* FA42C 80109C2C 0580043C */  lui        $a0, %hi(D_80057948)
    /* FA430 80109C30 2B0A040C */  jal        printf
    /* FA434 80109C34 48798424 */   addiu     $a0, $a0, %lo(D_80057948)
    /* FA438 80109C38 1F270408 */  j          .L80109C7C
    /* FA43C 80109C3C 00000000 */   nop
  .L80109C40:
    /* FA440 80109C40 03000524 */  addiu      $a1, $zero, 0x3
    /* FA444 80109C44 00110600 */  sll        $v0, $a2, 4
    /* FA448 80109C48 1580033C */  lui        $v1, %hi(D_80148A38)
    /* FA44C 80109C4C 388A6324 */  addiu      $v1, $v1, %lo(D_80148A38)
    /* FA450 80109C50 21184300 */  addu       $v1, $v0, $v1
    /* FA454 80109C54 80100600 */  sll        $v0, $a2, 2
    /* FA458 80109C58 1480013C */  lui        $at, %hi(D_8013C2E0)
    /* FA45C 80109C5C E0C226AC */  sw         $a2, %lo(D_8013C2E0)($at)
    /* FA460 80109C60 1580013C */  lui        $at, %hi(D_80148A6C)
    /* FA464 80109C64 21082200 */  addu       $at, $at, $v0
    /* FA468 80109C68 6C8A24AC */  sw         $a0, %lo(D_80148A6C)($at)
  .L80109C6C:
    /* FA46C 80109C6C 000060AC */  sw         $zero, 0x0($v1)
    /* FA470 80109C70 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* FA474 80109C74 FDFFA104 */  bgez       $a1, .L80109C6C
    /* FA478 80109C78 FCFF6324 */   addiu     $v1, $v1, -0x4
  .L80109C7C:
    /* FA47C 80109C7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* FA480 80109C80 1800BD27 */  addiu      $sp, $sp, 0x18
    /* FA484 80109C84 0800E003 */  jr         $ra
    /* FA488 80109C88 00000000 */   nop
endlabel UserFuncOpen
