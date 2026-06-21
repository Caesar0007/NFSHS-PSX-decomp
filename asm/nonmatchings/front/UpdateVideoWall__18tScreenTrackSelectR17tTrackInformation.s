.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation, 0x74

glabel UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
    /* 32688 80041E88 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3268C 80041E8C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 32690 80041E90 21808000 */  addu       $s0, $a0, $zero
    /* 32694 80041E94 1400B1AF */  sw         $s1, 0x14($sp)
    /* 32698 80041E98 2188A000 */  addu       $s1, $a1, $zero
    /* 3269C 80041E9C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 326A0 80041EA0 00002382 */  lb         $v1, 0x0($s1)
    /* 326A4 80041EA4 6C000286 */  lh         $v0, 0x6C($s0)
    /* 326A8 80041EA8 00000000 */  nop
    /* 326AC 80041EAC 0E006210 */  beq        $v1, $v0, .L80041EE8
    /* 326B0 80041EB0 00000000 */   nop
    /* 326B4 80041EB4 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 326B8 80041EB8 08002526 */   addiu     $a1, $s1, 0x8
    /* 326BC 80041EBC 980200AE */  sw         $zero, 0x298($s0)
    /* 326C0 80041EC0 00002292 */  lbu        $v0, 0x0($s1)
    /* 326C4 80041EC4 60020426 */  addiu      $a0, $s0, 0x260
    /* 326C8 80041EC8 00160200 */  sll        $v0, $v0, 24
    /* 326CC 80041ECC 03160200 */  sra        $v0, $v0, 24
    /* 326D0 80041ED0 96DB000C */  jal        TurnOff__10tVideoWall
    /* 326D4 80041ED4 6C0002A6 */   sh        $v0, 0x6C($s0)
    /* 326D8 80041ED8 21200002 */  addu       $a0, $s0, $zero
    /* 326DC 80041EDC 5A07010C */  jal        SetBrightness__18tScreenTrackSelects
    /* 326E0 80041EE0 21280000 */   addu      $a1, $zero, $zero
    /* 326E4 80041EE4 7C0000AE */  sw         $zero, 0x7C($s0)
  .L80041EE8:
    /* 326E8 80041EE8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 326EC 80041EEC 1400B18F */  lw         $s1, 0x14($sp)
    /* 326F0 80041EF0 1000B08F */  lw         $s0, 0x10($sp)
    /* 326F4 80041EF4 0800E003 */  jr         $ra
    /* 326F8 80041EF8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
