.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_CloneUVPmx__FP12Draw_tPixMapiT0, 0x160

glabel Texture_CloneUVPmx__FP12Draw_tPixMapiT0
    /* D0B58 800E0358 03008788 */  lwl        $a3, 0x3($a0)
    /* D0B5C 800E035C 00008798 */  lwr        $a3, 0x0($a0)
    /* D0B60 800E0360 07008888 */  lwl        $t0, 0x7($a0)
    /* D0B64 800E0364 04008898 */  lwr        $t0, 0x4($a0)
    /* D0B68 800E0368 0B008988 */  lwl        $t1, 0xB($a0)
    /* D0B6C 800E036C 08008998 */  lwr        $t1, 0x8($a0)
    /* D0B70 800E0370 0F008A88 */  lwl        $t2, 0xF($a0)
    /* D0B74 800E0374 0C008A98 */  lwr        $t2, 0xC($a0)
    /* D0B78 800E0378 0300C7A8 */  swl        $a3, 0x3($a2)
    /* D0B7C 800E037C 0000C7B8 */  swr        $a3, 0x0($a2)
    /* D0B80 800E0380 0700C8A8 */  swl        $t0, 0x7($a2)
    /* D0B84 800E0384 0400C8B8 */  swr        $t0, 0x4($a2)
    /* D0B88 800E0388 0B00C9A8 */  swl        $t1, 0xB($a2)
    /* D0B8C 800E038C 0800C9B8 */  swr        $t1, 0x8($a2)
    /* D0B90 800E0390 0F00CAA8 */  swl        $t2, 0xF($a2)
    /* D0B94 800E0394 0500A22C */  sltiu      $v0, $a1, 0x5
    /* D0B98 800E0398 45004010 */  beqz       $v0, .L800E04B0
    /* D0B9C 800E039C 0C00CAB8 */   swr       $t2, 0xC($a2)
    /* D0BA0 800E03A0 0580023C */  lui        $v0, %hi(jtbl_80056A98)
    /* D0BA4 800E03A4 986A4224 */  addiu      $v0, $v0, %lo(jtbl_80056A98)
    /* D0BA8 800E03A8 80180500 */  sll        $v1, $a1, 2
    /* D0BAC 800E03AC 21186200 */  addu       $v1, $v1, $v0
    /* D0BB0 800E03B0 0000628C */  lw         $v0, 0x0($v1)
    /* D0BB4 800E03B4 00000000 */  nop
    /* D0BB8 800E03B8 08004000 */  jr         $v0
    /* D0BBC 800E03BC 00000000 */   nop
  jlabel .L800E03C0
    /* D0BC0 800E03C0 04008294 */  lhu        $v0, 0x4($a0)
    /* D0BC4 800E03C4 00000000 */  nop
    /* D0BC8 800E03C8 0000C2A4 */  sh         $v0, 0x0($a2)
    /* D0BCC 800E03CC 00008294 */  lhu        $v0, 0x0($a0)
    /* D0BD0 800E03D0 00000000 */  nop
    /* D0BD4 800E03D4 0400C2A4 */  sh         $v0, 0x4($a2)
    /* D0BD8 800E03D8 0C008294 */  lhu        $v0, 0xC($a0)
    /* D0BDC 800E03DC 00000000 */  nop
    /* D0BE0 800E03E0 0800C2A4 */  sh         $v0, 0x8($a2)
    /* D0BE4 800E03E4 08008294 */  lhu        $v0, 0x8($a0)
    /* D0BE8 800E03E8 0800E003 */  jr         $ra
    /* D0BEC 800E03EC 0C00C2A4 */   sh        $v0, 0xC($a2)
  jlabel .L800E03F0
    /* D0BF0 800E03F0 04008294 */  lhu        $v0, 0x4($a0)
    /* D0BF4 800E03F4 00000000 */  nop
    /* D0BF8 800E03F8 0C00C2A4 */  sh         $v0, 0xC($a2)
    /* D0BFC 800E03FC 0C008294 */  lhu        $v0, 0xC($a0)
    /* D0C00 800E0400 00000000 */  nop
    /* D0C04 800E0404 0400C2A4 */  sh         $v0, 0x4($a2)
    /* D0C08 800E0408 00008294 */  lhu        $v0, 0x0($a0)
    /* D0C0C 800E040C 00000000 */  nop
    /* D0C10 800E0410 0800C2A4 */  sh         $v0, 0x8($a2)
    /* D0C14 800E0414 08008294 */  lhu        $v0, 0x8($a0)
    /* D0C18 800E0418 0800E003 */  jr         $ra
    /* D0C1C 800E041C 0000C2A4 */   sh        $v0, 0x0($a2)
  jlabel .L800E0420
    /* D0C20 800E0420 08008294 */  lhu        $v0, 0x8($a0)
    /* D0C24 800E0424 00000000 */  nop
    /* D0C28 800E0428 0000C2A4 */  sh         $v0, 0x0($a2)
    /* D0C2C 800E042C 00008294 */  lhu        $v0, 0x0($a0)
    /* D0C30 800E0430 00000000 */  nop
    /* D0C34 800E0434 0400C2A4 */  sh         $v0, 0x4($a2)
    /* D0C38 800E0438 04008294 */  lhu        $v0, 0x4($a0)
    /* D0C3C 800E043C 00000000 */  nop
    /* D0C40 800E0440 0C00C2A4 */  sh         $v0, 0xC($a2)
    /* D0C44 800E0444 0C008294 */  lhu        $v0, 0xC($a0)
    /* D0C48 800E0448 0800E003 */  jr         $ra
    /* D0C4C 800E044C 0800C2A4 */   sh        $v0, 0x8($a2)
  jlabel .L800E0450
    /* D0C50 800E0450 0C008294 */  lhu        $v0, 0xC($a0)
    /* D0C54 800E0454 00000000 */  nop
    /* D0C58 800E0458 0000C2A4 */  sh         $v0, 0x0($a2)
    /* D0C5C 800E045C 08008294 */  lhu        $v0, 0x8($a0)
    /* D0C60 800E0460 00000000 */  nop
    /* D0C64 800E0464 0400C2A4 */  sh         $v0, 0x4($a2)
    /* D0C68 800E0468 00008294 */  lhu        $v0, 0x0($a0)
    /* D0C6C 800E046C 00000000 */  nop
    /* D0C70 800E0470 0C00C2A4 */  sh         $v0, 0xC($a2)
    /* D0C74 800E0474 04008294 */  lhu        $v0, 0x4($a0)
    /* D0C78 800E0478 0800E003 */  jr         $ra
    /* D0C7C 800E047C 0800C2A4 */   sh        $v0, 0x8($a2)
  jlabel .L800E0480
    /* D0C80 800E0480 04008294 */  lhu        $v0, 0x4($a0)
    /* D0C84 800E0484 00000000 */  nop
    /* D0C88 800E0488 0000C2A4 */  sh         $v0, 0x0($a2)
    /* D0C8C 800E048C 0C008294 */  lhu        $v0, 0xC($a0)
    /* D0C90 800E0490 00000000 */  nop
    /* D0C94 800E0494 0400C2A4 */  sh         $v0, 0x4($a2)
    /* D0C98 800E0498 08008294 */  lhu        $v0, 0x8($a0)
    /* D0C9C 800E049C 00000000 */  nop
    /* D0CA0 800E04A0 0C00C2A4 */  sh         $v0, 0xC($a2)
    /* D0CA4 800E04A4 00008294 */  lhu        $v0, 0x0($a0)
    /* D0CA8 800E04A8 00000000 */  nop
    /* D0CAC 800E04AC 0800C2A4 */  sh         $v0, 0x8($a2)
  .L800E04B0:
    /* D0CB0 800E04B0 0800E003 */  jr         $ra
    /* D0CB4 800E04B4 00000000 */   nop
endlabel Texture_CloneUVPmx__FP12Draw_tPixMapiT0
