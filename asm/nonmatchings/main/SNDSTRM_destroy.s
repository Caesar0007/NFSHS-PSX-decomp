.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_destroy, 0xC8

glabel SNDSTRM_destroy
    /* DA370 800E9B70 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DA374 800E9B74 1480023C */  lui        $v0, %hi(sndgs)
    /* DA378 800E9B78 1800B2AF */  sw         $s2, 0x18($sp)
    /* DA37C 800E9B7C 60785224 */  addiu      $s2, $v0, %lo(sndgs)
    /* DA380 800E9B80 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DA384 800E9B84 1400B1AF */  sw         $s1, 0x14($sp)
    /* DA388 800E9B88 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA38C 800E9B8C 3C004282 */  lb         $v0, 0x3C($s2)
    /* DA390 800E9B90 00000000 */  nop
    /* DA394 800E9B94 03004014 */  bnez       $v0, .L800E9BA4
    /* DA398 800E9B98 21888000 */   addu      $s1, $a0, $zero
    /* DA39C 800E9B9C 08A70308 */  j          .L800E9C20
    /* DA3A0 800E9BA0 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9BA4:
    /* DA3A4 800E9BA4 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA3A8 800E9BA8 21202002 */   addu      $a0, $s1, $zero
    /* DA3AC 800E9BAC 21804000 */  addu       $s0, $v0, $zero
    /* DA3B0 800E9BB0 1B000012 */  beqz       $s0, .L800E9C20
    /* DA3B4 800E9BB4 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* DA3B8 800E9BB8 16A7030C */  jal        SNDSTRM_purge
    /* DA3BC 800E9BBC 21202002 */   addu      $a0, $s1, $zero
    /* DA3C0 800E9BC0 BEA5030C */  jal        iSNDstreamnumcreated
    /* DA3C4 800E9BC4 00000000 */   nop
    /* DA3C8 800E9BC8 01000324 */  addiu      $v1, $zero, 0x1
    /* DA3CC 800E9BCC 04004314 */  bne        $v0, $v1, .L800E9BE0
    /* DA3D0 800E9BD0 0F80043C */   lui       $a0, %hi(iSNDstreamservice)
    /* DA3D4 800E9BD4 F311040C */  jal        iSNDserverremoveclient
    /* DA3D8 800E9BD8 90958424 */   addiu     $a0, $a0, %lo(iSNDstreamservice)
    /* DA3DC 800E9BDC 880040AE */  sw         $zero, 0x88($s2)
  .L800E9BE0:
    /* DA3E0 800E9BE0 0C00048E */  lw         $a0, 0xC($s0)
    /* DA3E4 800E9BE4 7D0C040C */  jal        SNDPKTPLAY_destroy
    /* DA3E8 800E9BE8 00000000 */   nop
    /* DA3EC 800E9BEC 18000292 */  lbu        $v0, 0x18($s0)
    /* DA3F0 800E9BF0 00000000 */  nop
    /* DA3F4 800E9BF4 05004014 */  bnez       $v0, .L800E9C0C
    /* DA3F8 800E9BF8 1480033C */   lui       $v1, %hi(sndss)
    /* DA3FC 800E9BFC 0400048E */  lw         $a0, 0x4($s0)
    /* DA400 800E9C00 51F4030C */  jal        STREAM_destroy
    /* DA404 800E9C04 00000000 */   nop
    /* DA408 800E9C08 1480033C */  lui        $v1, %hi(sndss)
  .L800E9C0C:
    /* DA40C 800E9C0C 80EA6324 */  addiu      $v1, $v1, %lo(sndss)
    /* DA410 800E9C10 80101100 */  sll        $v0, $s1, 2
    /* DA414 800E9C14 21104300 */  addu       $v0, $v0, $v1
    /* DA418 800E9C18 000040AC */  sw         $zero, 0x0($v0)
    /* DA41C 800E9C1C 21100000 */  addu       $v0, $zero, $zero
  .L800E9C20:
    /* DA420 800E9C20 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DA424 800E9C24 1800B28F */  lw         $s2, 0x18($sp)
    /* DA428 800E9C28 1400B18F */  lw         $s1, 0x14($sp)
    /* DA42C 800E9C2C 1000B08F */  lw         $s0, 0x10($sp)
    /* DA430 800E9C30 0800E003 */  jr         $ra
    /* DA434 800E9C34 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSTRM_destroy
