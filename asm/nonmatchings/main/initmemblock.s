.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initmemblock, 0xDC

glabel initmemblock
    /* D572C 800E4F2C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D5730 800E4F30 1400B1AF */  sw         $s1, 0x14($sp)
    /* D5734 800E4F34 21888000 */  addu       $s1, $a0, $zero
    /* D5738 800E4F38 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D573C 800E4F3C 2198A000 */  addu       $s3, $a1, $zero
    /* D5740 800E4F40 2000B4AF */  sw         $s4, 0x20($sp)
    /* D5744 800E4F44 21A0E000 */  addu       $s4, $a3, $zero
    /* D5748 800E4F48 1000C224 */  addiu      $v0, $a2, 0x10
    /* D574C 800E4F4C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D5750 800E4F50 21802202 */  addu       $s0, $s1, $v0
    /* D5754 800E4F54 1800B2AF */  sw         $s2, 0x18($sp)
    /* D5758 800E4F58 3800B28F */  lw         $s2, 0x38($sp)
    /* D575C 800E4F5C 3C00A48F */  lw         $a0, 0x3C($sp)
    /* D5760 800E4F60 4000A38F */  lw         $v1, 0x40($sp)
    /* D5764 800E4F64 4D420224 */  addiu      $v0, $zero, 0x424D
    /* D5768 800E4F68 2400BFAF */  sw         $ra, 0x24($sp)
    /* D576C 800E4F6C 000022A6 */  sh         $v0, 0x0($s1)
    /* D5770 800E4F70 040026AE */  sw         $a2, 0x4($s1)
    /* D5774 800E4F74 00024232 */  andi       $v0, $s2, 0x200
    /* D5778 800E4F78 020032A6 */  sh         $s2, 0x2($s1)
    /* D577C 800E4F7C 080023AE */  sw         $v1, 0x8($s1)
    /* D5780 800E4F80 06004010 */  beqz       $v0, .L800E4F9C
    /* D5784 800E4F84 0C0024AE */   sw        $a0, 0xC($s1)
    /* D5788 800E4F88 21200002 */  addu       $a0, $s0, $zero
    /* D578C 800E4F8C 4542053C */  lui        $a1, (0x42454E44 >> 16)
    /* D5790 800E4F90 444EA534 */  ori        $a1, $a1, (0x42454E44 & 0xFFFF)
    /* D5794 800E4F94 2BCC030C */  jal        putm
    /* D5798 800E4F98 04000624 */   addiu     $a2, $zero, 0x4
  .L800E4F9C:
    /* D579C 800E4F9C 00084232 */  andi       $v0, $s2, 0x800
    /* D57A0 800E4FA0 04004010 */  beqz       $v0, .L800E4FB4
    /* D57A4 800E4FA4 0C000426 */   addiu     $a0, $s0, 0xC
    /* D57A8 800E4FA8 21280000 */  addu       $a1, $zero, $zero
    /* D57AC 800E4FAC 35CC030C */  jal        puti
    /* D57B0 800E4FB0 04000624 */   addiu     $a2, $zero, 0x4
  .L800E4FB4:
    /* D57B4 800E4FB4 0B006012 */  beqz       $s3, .L800E4FE4
    /* D57B8 800E4FB8 21801402 */   addu      $s0, $s0, $s4
    /* D57BC 800E4FBC 00014232 */  andi       $v0, $s2, 0x100
    /* D57C0 800E4FC0 09004010 */  beqz       $v0, .L800E4FE8
    /* D57C4 800E4FC4 23101102 */   subu      $v0, $s0, $s1
    /* D57C8 800E4FC8 21200002 */  addu       $a0, $s0, $zero
    /* D57CC 800E4FCC CA96030C */  jal        strcpy
    /* D57D0 800E4FD0 21286002 */   addu      $a1, $s3, $zero
    /* D57D4 800E4FD4 DDA7030C */  jal        strlen
    /* D57D8 800E4FD8 21200002 */   addu      $a0, $s0, $zero
    /* D57DC 800E4FDC 01004224 */  addiu      $v0, $v0, 0x1
    /* D57E0 800E4FE0 21800202 */  addu       $s0, $s0, $v0
  .L800E4FE4:
    /* D57E4 800E4FE4 23101102 */  subu       $v0, $s0, $s1
  .L800E4FE8:
    /* D57E8 800E4FE8 2400BF8F */  lw         $ra, 0x24($sp)
    /* D57EC 800E4FEC 2000B48F */  lw         $s4, 0x20($sp)
    /* D57F0 800E4FF0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D57F4 800E4FF4 1800B28F */  lw         $s2, 0x18($sp)
    /* D57F8 800E4FF8 1400B18F */  lw         $s1, 0x14($sp)
    /* D57FC 800E4FFC 1000B08F */  lw         $s0, 0x10($sp)
    /* D5800 800E5000 0800E003 */  jr         $ra
    /* D5804 800E5004 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel initmemblock
