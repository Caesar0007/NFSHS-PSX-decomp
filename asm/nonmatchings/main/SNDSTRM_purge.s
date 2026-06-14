.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_purge, 0xD8

glabel SNDSTRM_purge
    /* DA458 800E9C58 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA45C 800E9C5C 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA460 800E9C60 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DA464 800E9C64 1400BFAF */  sw         $ra, 0x14($sp)
    /* DA468 800E9C68 03004014 */  bnez       $v0, .L800E9C78
    /* DA46C 800E9C6C 1000B0AF */   sw        $s0, 0x10($sp)
    /* DA470 800E9C70 48A70308 */  j          .L800E9D20
    /* DA474 800E9C74 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9C78:
    /* DA478 800E9C78 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA47C 800E9C7C 00000000 */   nop
    /* DA480 800E9C80 21804000 */  addu       $s0, $v0, $zero
    /* DA484 800E9C84 26000012 */  beqz       $s0, .L800E9D20
    /* DA488 800E9C88 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* DA48C 800E9C8C 0800028E */  lw         $v0, 0x8($s0)
    /* DA490 800E9C90 00000000 */  nop
    /* DA494 800E9C94 05004004 */  bltz       $v0, .L800E9CAC
    /* DA498 800E9C98 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DA49C 800E9C9C 0C00048E */  lw         $a0, 0xC($s0)
    /* DA4A0 800E9CA0 460C040C */  jal        SNDPKTPLAY_stop
    /* DA4A4 800E9CA4 00000000 */   nop
    /* DA4A8 800E9CA8 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800E9CAC:
    /* DA4AC 800E9CAC 080002AE */  sw         $v0, 0x8($s0)
    /* DA4B0 800E9CB0 18000292 */  lbu        $v0, 0x18($s0)
    /* DA4B4 800E9CB4 00000000 */  nop
    /* DA4B8 800E9CB8 05004014 */  bnez       $v0, .L800E9CD0
    /* DA4BC 800E9CBC 1C000426 */   addiu     $a0, $s0, 0x1C
    /* DA4C0 800E9CC0 0400048E */  lw         $a0, 0x4($s0)
    /* DA4C4 800E9CC4 02F6030C */  jal        STREAM_kill
    /* DA4C8 800E9CC8 00000000 */   nop
    /* DA4CC 800E9CCC 1C000426 */  addiu      $a0, $s0, 0x1C
  .L800E9CD0:
    /* DA4D0 800E9CD0 21280000 */  addu       $a1, $zero, $zero
    /* DA4D4 800E9CD4 04000624 */  addiu      $a2, $zero, 0x4
    /* DA4D8 800E9CD8 160000A2 */  sb         $zero, 0x16($s0)
    /* DA4DC 800E9CDC 170000A2 */  sb         $zero, 0x17($s0)
    /* DA4E0 800E9CE0 140000A2 */  sb         $zero, 0x14($s0)
    /* DA4E4 800E9CE4 C690030C */  jal        memset
    /* DA4E8 800E9CE8 00000000 */   nop
    /* DA4EC 800E9CEC 20000426 */  addiu      $a0, $s0, 0x20
    /* DA4F0 800E9CF0 21280000 */  addu       $a1, $zero, $zero
    /* DA4F4 800E9CF4 C690030C */  jal        memset
    /* DA4F8 800E9CF8 04000624 */   addiu     $a2, $zero, 0x4
    /* DA4FC 800E9CFC 24000426 */  addiu      $a0, $s0, 0x24
    /* DA500 800E9D00 21280000 */  addu       $a1, $zero, $zero
    /* DA504 800E9D04 C690030C */  jal        memset
    /* DA508 800E9D08 14000624 */   addiu     $a2, $zero, 0x14
    /* DA50C 800E9D0C 38000426 */  addiu      $a0, $s0, 0x38
    /* DA510 800E9D10 21280000 */  addu       $a1, $zero, $zero
    /* DA514 800E9D14 C690030C */  jal        memset
    /* DA518 800E9D18 14000624 */   addiu     $a2, $zero, 0x14
    /* DA51C 800E9D1C 21100000 */  addu       $v0, $zero, $zero
  .L800E9D20:
    /* DA520 800E9D20 1400BF8F */  lw         $ra, 0x14($sp)
    /* DA524 800E9D24 1000B08F */  lw         $s0, 0x10($sp)
    /* DA528 800E9D28 0800E003 */  jr         $ra
    /* DA52C 800E9D2C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSTRM_purge
