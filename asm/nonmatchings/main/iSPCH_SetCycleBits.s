.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SetCycleBits, 0x158

glabel iSPCH_SetCycleBits
    /* DBBC8 800EB3C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBBCC 800EB3CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* DBBD0 800EB3D0 1400BFAF */  sw         $ra, 0x14($sp)
    /* DBBD4 800EB3D4 6502040C */  jal        iSPCH_GetBankBits
    /* DBBD8 800EB3D8 21808000 */   addu      $s0, $a0, $zero
    /* DBBDC 800EB3DC 21484000 */  addu       $t1, $v0, $zero
    /* DBBE0 800EB3E0 00002591 */  lbu        $a1, 0x0($t1)
    /* DBBE4 800EB3E4 00000000 */  nop
    /* DBBE8 800EB3E8 4900A018 */  blez       $a1, .L800EB510
    /* DBBEC 800EB3EC 1580023C */   lui       $v0, %hi(gGameNum)
    /* DBBF0 800EB3F0 2884428C */  lw         $v0, %lo(gGameNum)($v0)
    /* DBBF4 800EB3F4 00000000 */  nop
    /* DBBF8 800EB3F8 1A004500 */  div        $zero, $v0, $a1
    /* DBBFC 800EB3FC 0200A014 */  bnez       $a1, .L800EB408
    /* DBC00 800EB400 00000000 */   nop
    /* DBC04 800EB404 0D000700 */  break      7
  .L800EB408:
    /* DBC08 800EB408 FFFF0124 */  addiu      $at, $zero, -0x1
    /* DBC0C 800EB40C 0400A114 */  bne        $a1, $at, .L800EB420
    /* DBC10 800EB410 0080013C */   lui       $at, (0x80000000 >> 16)
    /* DBC14 800EB414 02004114 */  bne        $v0, $at, .L800EB420
    /* DBC18 800EB418 00000000 */   nop
    /* DBC1C 800EB41C 0D000600 */  break      6
  .L800EB420:
    /* DBC20 800EB420 10180000 */  mfhi       $v1
    /* DBC24 800EB424 03000292 */  lbu        $v0, 0x3($s0)
    /* DBC28 800EB428 00000000 */  nop
    /* DBC2C 800EB42C 18006200 */  mult       $v1, $v0
    /* DBC30 800EB430 12300000 */  mflo       $a2
    /* DBC34 800EB434 00000000 */  nop
    /* DBC38 800EB438 00000000 */  nop
    /* DBC3C 800EB43C 1A00C500 */  div        $zero, $a2, $a1
    /* DBC40 800EB440 0200A014 */  bnez       $a1, .L800EB44C
    /* DBC44 800EB444 00000000 */   nop
    /* DBC48 800EB448 0D000700 */  break      7
  .L800EB44C:
    /* DBC4C 800EB44C FFFF0124 */  addiu      $at, $zero, -0x1
    /* DBC50 800EB450 0400A114 */  bne        $a1, $at, .L800EB464
    /* DBC54 800EB454 0080013C */   lui       $at, (0x80000000 >> 16)
    /* DBC58 800EB458 0200C114 */  bne        $a2, $at, .L800EB464
    /* DBC5C 800EB45C 00000000 */   nop
    /* DBC60 800EB460 0D000600 */  break      6
  .L800EB464:
    /* DBC64 800EB464 12300000 */  mflo       $a2
    /* DBC68 800EB468 01006324 */  addiu      $v1, $v1, 0x1
    /* DBC6C 800EB46C 00000000 */  nop
    /* DBC70 800EB470 18006200 */  mult       $v1, $v0
    /* DBC74 800EB474 12180000 */  mflo       $v1
    /* DBC78 800EB478 00000000 */  nop
    /* DBC7C 800EB47C 00000000 */  nop
    /* DBC80 800EB480 1A006500 */  div        $zero, $v1, $a1
    /* DBC84 800EB484 0200A014 */  bnez       $a1, .L800EB490
    /* DBC88 800EB488 00000000 */   nop
    /* DBC8C 800EB48C 0D000700 */  break      7
  .L800EB490:
    /* DBC90 800EB490 FFFF0124 */  addiu      $at, $zero, -0x1
    /* DBC94 800EB494 0400A114 */  bne        $a1, $at, .L800EB4A8
    /* DBC98 800EB498 0080013C */   lui       $at, (0x80000000 >> 16)
    /* DBC9C 800EB49C 02006114 */  bne        $v1, $at, .L800EB4A8
    /* DBCA0 800EB4A0 00000000 */   nop
    /* DBCA4 800EB4A4 0D000600 */  break      6
  .L800EB4A8:
    /* DBCA8 800EB4A8 12100000 */  mflo       $v0
    /* DBCAC 800EB4AC 2118C000 */  addu       $v1, $a2, $zero
    /* DBCB0 800EB4B0 0200C104 */  bgez       $a2, .L800EB4BC
    /* DBCB4 800EB4B4 23404600 */   subu      $t0, $v0, $a2
    /* DBCB8 800EB4B8 0700C324 */  addiu      $v1, $a2, 0x7
  .L800EB4BC:
    /* DBCBC 800EB4BC C3100300 */  sra        $v0, $v1, 3
    /* DBCC0 800EB4C0 01004724 */  addiu      $a3, $v0, 0x1
    /* DBCC4 800EB4C4 C0100200 */  sll        $v0, $v0, 3
    /* DBCC8 800EB4C8 2328C200 */  subu       $a1, $a2, $v0
    /* DBCCC 800EB4CC 10000019 */  blez       $t0, .L800EB510
    /* DBCD0 800EB4D0 21300000 */   addu      $a2, $zero, $zero
    /* DBCD4 800EB4D4 01000B24 */  addiu      $t3, $zero, 0x1
    /* DBCD8 800EB4D8 08000A24 */  addiu      $t2, $zero, 0x8
    /* DBCDC 800EB4DC 0420AB00 */  sllv       $a0, $t3, $a1
  .L800EB4E0:
    /* DBCE0 800EB4E0 21182701 */  addu       $v1, $t1, $a3
    /* DBCE4 800EB4E4 00006290 */  lbu        $v0, 0x0($v1)
    /* DBCE8 800EB4E8 0100A524 */  addiu      $a1, $a1, 0x1
    /* DBCEC 800EB4EC 25104400 */  or         $v0, $v0, $a0
    /* DBCF0 800EB4F0 0300AA14 */  bne        $a1, $t2, .L800EB500
    /* DBCF4 800EB4F4 000062A0 */   sb        $v0, 0x0($v1)
    /* DBCF8 800EB4F8 21280000 */  addu       $a1, $zero, $zero
    /* DBCFC 800EB4FC 0100E724 */  addiu      $a3, $a3, 0x1
  .L800EB500:
    /* DBD00 800EB500 0100C624 */  addiu      $a2, $a2, 0x1
    /* DBD04 800EB504 2A10C800 */  slt        $v0, $a2, $t0
    /* DBD08 800EB508 F5FF4014 */  bnez       $v0, .L800EB4E0
    /* DBD0C 800EB50C 0420AB00 */   sllv      $a0, $t3, $a1
  .L800EB510:
    /* DBD10 800EB510 1400BF8F */  lw         $ra, 0x14($sp)
    /* DBD14 800EB514 1000B08F */  lw         $s0, 0x10($sp)
    /* DBD18 800EB518 0800E003 */  jr         $ra
    /* DBD1C 800EB51C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_SetCycleBits
