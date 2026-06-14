.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching intatan, 0x12C

glabel intatan
    /* D6338 800E5B38 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D633C 800E5B3C 21188000 */  addu       $v1, $a0, $zero
    /* D6340 800E5B40 1800B0AF */  sw         $s0, 0x18($sp)
    /* D6344 800E5B44 2180A000 */  addu       $s0, $a1, $zero
    /* D6348 800E5B48 2000B2AF */  sw         $s2, 0x20($sp)
    /* D634C 800E5B4C 21900000 */  addu       $s2, $zero, $zero
    /* D6350 800E5B50 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D6354 800E5B54 21884002 */  addu       $s1, $s2, $zero
    /* D6358 800E5B58 04000106 */  bgez       $s0, .L800E5B6C
    /* D635C 800E5B5C 2400BFAF */   sw        $ra, 0x24($sp)
    /* D6360 800E5B60 23801000 */  negu       $s0, $s0
    /* D6364 800E5B64 01001224 */  addiu      $s2, $zero, 0x1
    /* D6368 800E5B68 00021124 */  addiu      $s1, $zero, 0x200
  .L800E5B6C:
    /* D636C 800E5B6C 06006104 */  bgez       $v1, .L800E5B88
    /* D6370 800E5B70 2A100302 */   slt       $v0, $s0, $v1
    /* D6374 800E5B74 23180300 */  negu       $v1, $v1
    /* D6378 800E5B78 01000224 */  addiu      $v0, $zero, 0x1
    /* D637C 800E5B7C 23905200 */  subu       $s2, $v0, $s2
    /* D6380 800E5B80 23881100 */  negu       $s1, $s1
    /* D6384 800E5B84 2A100302 */  slt        $v0, $s0, $v1
  .L800E5B88:
    /* D6388 800E5B88 09004010 */  beqz       $v0, .L800E5BB0
    /* D638C 800E5B8C 21106000 */   addu      $v0, $v1, $zero
    /* D6390 800E5B90 21180002 */  addu       $v1, $s0, $zero
    /* D6394 800E5B94 03004012 */  beqz       $s2, .L800E5BA4
    /* D6398 800E5B98 21804000 */   addu      $s0, $v0, $zero
    /* D639C 800E5B9C EA960308 */  j          .L800E5BA8
    /* D63A0 800E5BA0 00FF3126 */   addiu     $s1, $s1, -0x100
  .L800E5BA4:
    /* D63A4 800E5BA4 00013126 */  addiu      $s1, $s1, 0x100
  .L800E5BA8:
    /* D63A8 800E5BA8 01000224 */  addiu      $v0, $zero, 0x1
    /* D63AC 800E5BAC 23905200 */  subu       $s2, $v0, $s2
  .L800E5BB0:
    /* D63B0 800E5BB0 21007010 */  beq        $v1, $s0, .L800E5C38
    /* D63B4 800E5BB4 80000224 */   addiu     $v0, $zero, 0x80
    /* D63B8 800E5BB8 80FF023C */  lui        $v0, (0xFF800000 >> 16)
    /* D63BC 800E5BBC 24106200 */  and        $v0, $v1, $v0
    /* D63C0 800E5BC0 11004010 */  beqz       $v0, .L800E5C08
    /* D63C4 800E5BC4 1000A427 */   addiu     $a0, $sp, 0x10
    /* D63C8 800E5BC8 21286000 */  addu       $a1, $v1, $zero
    /* D63CC 800E5BCC 22F9030C */  jal        make64
    /* D63D0 800E5BD0 20000624 */   addiu     $a2, $zero, 0x20
    /* D63D4 800E5BD4 1000A48F */  lw         $a0, 0x10($sp)
    /* D63D8 800E5BD8 1400A58F */  lw         $a1, 0x14($sp)
    /* D63DC 800E5BDC 38F9030C */  jal        divu64
    /* D63E0 800E5BE0 21300002 */   addu      $a2, $s0, $zero
    /* D63E4 800E5BE4 21184000 */  addu       $v1, $v0, $zero
    /* D63E8 800E5BE8 8000023C */  lui        $v0, (0x800000 >> 16)
    /* D63EC 800E5BEC 24106200 */  and        $v0, $v1, $v0
    /* D63F0 800E5BF0 03004010 */  beqz       $v0, .L800E5C00
    /* D63F4 800E5BF4 02160300 */   srl       $v0, $v1, 24
    /* D63F8 800E5BF8 0A970308 */  j          .L800E5C28
    /* D63FC 800E5BFC 01004324 */   addiu     $v1, $v0, 0x1
  .L800E5C00:
    /* D6400 800E5C00 0A970308 */  j          .L800E5C28
    /* D6404 800E5C04 021E0300 */   srl       $v1, $v1, 24
  .L800E5C08:
    /* D6408 800E5C08 001A0300 */  sll        $v1, $v1, 8
    /* D640C 800E5C0C 43101000 */  sra        $v0, $s0, 1
    /* D6410 800E5C10 21186200 */  addu       $v1, $v1, $v0
    /* D6414 800E5C14 1B007000 */  divu       $zero, $v1, $s0
    /* D6418 800E5C18 02000016 */  bnez       $s0, .L800E5C24
    /* D641C 800E5C1C 00000000 */   nop
    /* D6420 800E5C20 0D000700 */  break      7
  .L800E5C24:
    /* D6424 800E5C24 12180000 */  mflo       $v1
  .L800E5C28:
    /* D6428 800E5C28 1380023C */  lui        $v0, %hi(atantbl)
    /* D642C 800E5C2C E86C4224 */  addiu      $v0, $v0, %lo(atantbl)
    /* D6430 800E5C30 21106200 */  addu       $v0, $v1, $v0
    /* D6434 800E5C34 00004290 */  lbu        $v0, 0x0($v0)
  .L800E5C38:
    /* D6438 800E5C38 03004016 */  bnez       $s2, .L800E5C48
    /* D643C 800E5C3C 00000000 */   nop
    /* D6440 800E5C40 13970308 */  j          .L800E5C4C
    /* D6444 800E5C44 21102202 */   addu      $v0, $s1, $v0
  .L800E5C48:
    /* D6448 800E5C48 23102202 */  subu       $v0, $s1, $v0
  .L800E5C4C:
    /* D644C 800E5C4C 2400BF8F */  lw         $ra, 0x24($sp)
    /* D6450 800E5C50 2000B28F */  lw         $s2, 0x20($sp)
    /* D6454 800E5C54 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D6458 800E5C58 1800B08F */  lw         $s0, 0x18($sp)
    /* D645C 800E5C5C 0800E003 */  jr         $ra
    /* D6460 800E5C60 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel intatan
