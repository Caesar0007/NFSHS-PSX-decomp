.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1, 0x168

glabel Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
    /* AA3C4 800B9BC4 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* AA3C8 800B9BC8 5800B2AF */  sw         $s2, 0x58($sp)
    /* AA3CC 800B9BCC 21908000 */  addu       $s2, $a0, $zero
    /* AA3D0 800B9BD0 5400B1AF */  sw         $s1, 0x54($sp)
    /* AA3D4 800B9BD4 21880000 */  addu       $s1, $zero, $zero
    /* AA3D8 800B9BD8 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* AA3DC 800B9BDC 2198C000 */  addu       $s3, $a2, $zero
    /* AA3E0 800B9BE0 5000B0AF */  sw         $s0, 0x50($sp)
    /* AA3E4 800B9BE4 10004232 */  andi       $v0, $s2, 0x10
    /* AA3E8 800B9BE8 6000BFAF */  sw         $ra, 0x60($sp)
    /* AA3EC 800B9BEC 0300A788 */  lwl        $a3, 0x3($a1)
    /* AA3F0 800B9BF0 0000A798 */  lwr        $a3, 0x0($a1)
    /* AA3F4 800B9BF4 0700A888 */  lwl        $t0, 0x7($a1)
    /* AA3F8 800B9BF8 0400A898 */  lwr        $t0, 0x4($a1)
    /* AA3FC 800B9BFC 0B00A988 */  lwl        $t1, 0xB($a1)
    /* AA400 800B9C00 0800A998 */  lwr        $t1, 0x8($a1)
    /* AA404 800B9C04 0F00AA88 */  lwl        $t2, 0xF($a1)
    /* AA408 800B9C08 0C00AA98 */  lwr        $t2, 0xC($a1)
    /* AA40C 800B9C0C 1300A7AB */  swl        $a3, 0x13($sp)
    /* AA410 800B9C10 1000A7BB */  swr        $a3, 0x10($sp)
    /* AA414 800B9C14 1700A8AB */  swl        $t0, 0x17($sp)
    /* AA418 800B9C18 1400A8BB */  swr        $t0, 0x14($sp)
    /* AA41C 800B9C1C 1B00A9AB */  swl        $t1, 0x1B($sp)
    /* AA420 800B9C20 1800A9BB */  swr        $t1, 0x18($sp)
    /* AA424 800B9C24 1F00AAAB */  swl        $t2, 0x1F($sp)
    /* AA428 800B9C28 1C00AABB */  swr        $t2, 0x1C($sp)
    /* AA42C 800B9C2C 06004010 */  beqz       $v0, .L800B9C48
    /* AA430 800B9C30 1000B027 */   addiu     $s0, $sp, 0x10
    /* AA434 800B9C34 21200002 */  addu       $a0, $s0, $zero
    /* AA438 800B9C38 21282002 */  addu       $a1, $s1, $zero
    /* AA43C 800B9C3C D680030C */  jal        Texture_CloneUVPmx__FP12Draw_tPixMapiT0
    /* AA440 800B9C40 2000A627 */   addiu     $a2, $sp, 0x20
    /* AA444 800B9C44 01001124 */  addiu      $s1, $zero, 0x1
  .L800B9C48:
    /* AA448 800B9C48 40004232 */  andi       $v0, $s2, 0x40
    /* AA44C 800B9C4C 07004010 */  beqz       $v0, .L800B9C6C
    /* AA450 800B9C50 01000524 */   addiu     $a1, $zero, 0x1
    /* AA454 800B9C54 00311100 */  sll        $a2, $s1, 4
    /* AA458 800B9C58 21200602 */  addu       $a0, $s0, $a2
    /* AA45C 800B9C5C 1000C624 */  addiu      $a2, $a2, 0x10
    /* AA460 800B9C60 D680030C */  jal        Texture_CloneUVPmx__FP12Draw_tPixMapiT0
    /* AA464 800B9C64 21300602 */   addu      $a2, $s0, $a2
    /* AA468 800B9C68 01003126 */  addiu      $s1, $s1, 0x1
  .L800B9C6C:
    /* AA46C 800B9C6C 0E004232 */  andi       $v0, $s2, 0xE
    /* AA470 800B9C70 14004010 */  beqz       $v0, .L800B9CC4
    /* AA474 800B9C74 02004232 */   andi      $v0, $s2, 0x2
    /* AA478 800B9C78 04004010 */  beqz       $v0, .L800B9C8C
    /* AA47C 800B9C7C 00311100 */   sll       $a2, $s1, 4
    /* AA480 800B9C80 21200602 */  addu       $a0, $s0, $a2
    /* AA484 800B9C84 2DE70208 */  j          .L800B9CB4
    /* AA488 800B9C88 02000524 */   addiu     $a1, $zero, 0x2
  .L800B9C8C:
    /* AA48C 800B9C8C 04004232 */  andi       $v0, $s2, 0x4
    /* AA490 800B9C90 03004010 */  beqz       $v0, .L800B9CA0
    /* AA494 800B9C94 21200602 */   addu      $a0, $s0, $a2
    /* AA498 800B9C98 2DE70208 */  j          .L800B9CB4
    /* AA49C 800B9C9C 03000524 */   addiu     $a1, $zero, 0x3
  .L800B9CA0:
    /* AA4A0 800B9CA0 08004232 */  andi       $v0, $s2, 0x8
    /* AA4A4 800B9CA4 06004010 */  beqz       $v0, .L800B9CC0
    /* AA4A8 800B9CA8 04000524 */   addiu     $a1, $zero, 0x4
    /* AA4AC 800B9CAC 00311100 */  sll        $a2, $s1, 4
    /* AA4B0 800B9CB0 21200602 */  addu       $a0, $s0, $a2
  .L800B9CB4:
    /* AA4B4 800B9CB4 1000C624 */  addiu      $a2, $a2, 0x10
    /* AA4B8 800B9CB8 D680030C */  jal        Texture_CloneUVPmx__FP12Draw_tPixMapiT0
    /* AA4BC 800B9CBC 21300602 */   addu      $a2, $s0, $a2
  .L800B9CC0:
    /* AA4C0 800B9CC0 01003126 */  addiu      $s1, $s1, 0x1
  .L800B9CC4:
    /* AA4C4 800B9CC4 00191100 */  sll        $v1, $s1, 4
    /* AA4C8 800B9CC8 1000A227 */  addiu      $v0, $sp, 0x10
    /* AA4CC 800B9CCC 21104300 */  addu       $v0, $v0, $v1
    /* AA4D0 800B9CD0 03004788 */  lwl        $a3, 0x3($v0)
    /* AA4D4 800B9CD4 00004798 */  lwr        $a3, 0x0($v0)
    /* AA4D8 800B9CD8 07004888 */  lwl        $t0, 0x7($v0)
    /* AA4DC 800B9CDC 04004898 */  lwr        $t0, 0x4($v0)
    /* AA4E0 800B9CE0 0B004988 */  lwl        $t1, 0xB($v0)
    /* AA4E4 800B9CE4 08004998 */  lwr        $t1, 0x8($v0)
    /* AA4E8 800B9CE8 0F004A88 */  lwl        $t2, 0xF($v0)
    /* AA4EC 800B9CEC 0C004A98 */  lwr        $t2, 0xC($v0)
    /* AA4F0 800B9CF0 030067AA */  swl        $a3, 0x3($s3)
    /* AA4F4 800B9CF4 000067BA */  swr        $a3, 0x0($s3)
    /* AA4F8 800B9CF8 070068AA */  swl        $t0, 0x7($s3)
    /* AA4FC 800B9CFC 040068BA */  swr        $t0, 0x4($s3)
    /* AA500 800B9D00 0B0069AA */  swl        $t1, 0xB($s3)
    /* AA504 800B9D04 080069BA */  swr        $t1, 0x8($s3)
    /* AA508 800B9D08 0F006AAA */  swl        $t2, 0xF($s3)
    /* AA50C 800B9D0C 0C006ABA */  swr        $t2, 0xC($s3)
    /* AA510 800B9D10 6000BF8F */  lw         $ra, 0x60($sp)
    /* AA514 800B9D14 5C00B38F */  lw         $s3, 0x5C($sp)
    /* AA518 800B9D18 5800B28F */  lw         $s2, 0x58($sp)
    /* AA51C 800B9D1C 5400B18F */  lw         $s1, 0x54($sp)
    /* AA520 800B9D20 5000B08F */  lw         $s0, 0x50($sp)
    /* AA524 800B9D24 0800E003 */  jr         $ra
    /* AA528 800B9D28 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
