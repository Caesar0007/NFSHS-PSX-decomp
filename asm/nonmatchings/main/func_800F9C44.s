.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F9C44, 0x60

glabel func_800F9C44
    /* EA444 800F9C44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EA448 800F9C48 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EA44C 800F9C4C 1000B0AF */  sw         $s0, 0x10($sp)
    /* EA450 800F9C50 C46C5024 */  addiu      $s0, $v0, %lo(Cdinfo)
    /* EA454 800F9C54 1400BFAF */  sw         $ra, 0x14($sp)
    /* EA458 800F9C58 1800028E */  lw         $v0, 0x18($s0)
    /* EA45C 800F9C5C 00000000 */  nop
    /* EA460 800F9C60 0C004010 */  beqz       $v0, .L800F9C94
    /* EA464 800F9C64 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* EA468 800F9C68 0A004014 */  bnez       $v0, .L800F9C94
    /* EA46C 800F9C6C 180002AE */   sw        $v0, 0x18($s0)
    /* EA470 800F9C70 1080043C */  lui        $a0, %hi(func_800F9AE8)
    /* EA474 800F9C74 E89A8424 */  addiu      $a0, $a0, %lo(func_800F9AE8)
    /* EA478 800F9C78 21280000 */  addu       $a1, $zero, $zero
    /* EA47C 800F9C7C BD9A030C */  jal        addsystemtask
    /* EA480 800F9C80 2130A000 */   addu      $a2, $a1, $zero
    /* EA484 800F9C84 180000AE */  sw         $zero, 0x18($s0)
    /* EA488 800F9C88 1080043C */  lui        $a0, %hi(func_800F9C44)
    /* EA48C 800F9C8C 12AC030C */  jal        deltimer
    /* EA490 800F9C90 449C8424 */   addiu     $a0, $a0, %lo(func_800F9C44)
  .L800F9C94:
    /* EA494 800F9C94 1400BF8F */  lw         $ra, 0x14($sp)
    /* EA498 800F9C98 1000B08F */  lw         $s0, 0x10($sp)
    /* EA49C 800F9C9C 0800E003 */  jr         $ra
    /* EA4A0 800F9CA0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800F9C44
