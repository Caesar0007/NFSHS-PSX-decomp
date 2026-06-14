.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji, 0x4E4

glabel TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
    /* ABC1C 800BB41C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* ABC20 800BB420 2800B0AF */  sw         $s0, 0x28($sp)
    /* ABC24 800BB424 21808000 */  addu       $s0, $a0, $zero
    /* ABC28 800BB428 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* ABC2C 800BB42C 2188A000 */  addu       $s1, $a1, $zero
    /* ABC30 800BB430 2150C000 */  addu       $t2, $a2, $zero
    /* ABC34 800BB434 2148E000 */  addu       $t1, $a3, $zero
    /* ABC38 800BB438 4C00A78F */  lw         $a3, 0x4C($sp)
    /* ABC3C 800BB43C 4800A48F */  lw         $a0, 0x48($sp)
    /* ABC40 800BB440 5000AC8F */  lw         $t4, 0x50($sp)
    /* ABC44 800BB444 0200222A */  slti       $v0, $s1, 0x2
    /* ABC48 800BB448 3000BFAF */  sw         $ra, 0x30($sp)
    /* ABC4C 800BB44C C000EB8C */  lw         $t3, 0xC0($a3)
    /* ABC50 800BB450 0800ED84 */  lh         $t5, 0x8($a3)
    /* ABC54 800BB454 04004010 */  beqz       $v0, .L800BB468
    /* ABC58 800BB458 AC00E524 */   addiu     $a1, $a3, 0xAC
    /* ABC5C 800BB45C E800E88C */  lw         $t0, 0xE8($a3)
    /* ABC60 800BB460 1CED0208 */  j          .L800BB470
    /* ABC64 800BB464 4992033C */   lui       $v1, (0x92492493 >> 16)
  .L800BB468:
    /* ABC68 800BB468 EC00E88C */  lw         $t0, 0xEC($a3)
    /* ABC6C 800BB46C 4992033C */  lui        $v1, (0x92492493 >> 16)
  .L800BB470:
    /* ABC70 800BB470 93246334 */  ori        $v1, $v1, (0x92492493 & 0xFFFF)
    /* ABC74 800BB474 00120400 */  sll        $v0, $a0, 8
    /* ABC78 800BB478 23104400 */  subu       $v0, $v0, $a0
    /* ABC7C 800BB47C 18004300 */  mult       $v0, $v1
    /* ABC80 800BB480 07001032 */  andi       $s0, $s0, 0x7
    /* ABC84 800BB484 10700000 */  mfhi       $t6
    /* ABC88 800BB488 2118C201 */  addu       $v1, $t6, $v0
    /* ABC8C 800BB48C 831C0300 */  sra        $v1, $v1, 18
    /* ABC90 800BB490 C3170200 */  sra        $v0, $v0, 31
    /* ABC94 800BB494 23186200 */  subu       $v1, $v1, $v0
    /* ABC98 800BB498 00016228 */  slti       $v0, $v1, 0x100
    /* ABC9C 800BB49C 02004010 */  beqz       $v0, .L800BB4A8
    /* ABCA0 800BB4A0 FF000424 */   addiu     $a0, $zero, 0xFF
    /* ABCA4 800BB4A4 21206000 */  addu       $a0, $v1, $zero
  .L800BB4A8:
    /* ABCA8 800BB4A8 21188000 */  addu       $v1, $a0, $zero
    /* ABCAC 800BB4AC 80201100 */  sll        $a0, $s1, 2
    /* ABCB0 800BB4B0 2200A3A3 */  sb         $v1, 0x22($sp)
    /* ABCB4 800BB4B4 2100A3A3 */  sb         $v1, 0x21($sp)
    /* ABCB8 800BB4B8 2000A3A3 */  sb         $v1, 0x20($sp)
    /* ABCBC 800BB4BC 0000A28C */  lw         $v0, 0x0($a1)
    /* ABCC0 800BB4C0 0000438D */  lw         $v1, 0x0($t2)
    /* ABCC4 800BB4C4 83110200 */  sra        $v0, $v0, 6
    /* ABCC8 800BB4C8 21186200 */  addu       $v1, $v1, $v0
    /* ABCCC 800BB4CC 000043AD */  sw         $v1, 0x0($t2)
    /* ABCD0 800BB4D0 0400A28C */  lw         $v0, 0x4($a1)
    /* ABCD4 800BB4D4 0400438D */  lw         $v1, 0x4($t2)
    /* ABCD8 800BB4D8 83110200 */  sra        $v0, $v0, 6
    /* ABCDC 800BB4DC 21186200 */  addu       $v1, $v1, $v0
    /* ABCE0 800BB4E0 040043AD */  sw         $v1, 0x4($t2)
    /* ABCE4 800BB4E4 0800A28C */  lw         $v0, 0x8($a1)
    /* ABCE8 800BB4E8 0800438D */  lw         $v1, 0x8($t2)
    /* ABCEC 800BB4EC 83110200 */  sra        $v0, $v0, 6
    /* ABCF0 800BB4F0 21306200 */  addu       $a2, $v1, $v0
    /* ABCF4 800BB4F4 1280033C */  lui        $v1, %hi(gStatusSm)
    /* ABCF8 800BB4F8 70E66324 */  addiu      $v1, $v1, %lo(gStatusSm)
    /* ABCFC 800BB4FC 00111000 */  sll        $v0, $s0, 4
    /* ABD00 800BB500 21288200 */  addu       $a1, $a0, $v0
    /* ABD04 800BB504 2120A300 */  addu       $a0, $a1, $v1
    /* ABD08 800BB508 080046AD */  sw         $a2, 0x8($t2)
    /* ABD0C 800BB50C 0000838C */  lw         $v1, 0x0($a0)
    /* ABD10 800BB510 00000000 */  nop
    /* ABD14 800BB514 1C006014 */  bnez       $v1, .L800BB588
    /* ABD18 800BB518 00000000 */   nop
    /* ABD1C 800BB51C F3002015 */  bnez       $t1, .L800BB8EC
    /* ABD20 800BB520 01000224 */   addiu     $v0, $zero, 0x1
    /* ABD24 800BB524 000082AC */  sw         $v0, 0x0($a0)
    /* ABD28 800BB528 1280043C */  lui        $a0, %hi(gPrevSkidSm)
    /* ABD2C 800BB52C F0E28424 */  addiu      $a0, $a0, %lo(gPrevSkidSm)
    /* ABD30 800BB530 C0181100 */  sll        $v1, $s1, 3
    /* ABD34 800BB534 23187100 */  subu       $v1, $v1, $s1
    /* ABD38 800BB538 80180300 */  sll        $v1, $v1, 2
    /* ABD3C 800BB53C C0101000 */  sll        $v0, $s0, 3
    /* ABD40 800BB540 23105000 */  subu       $v0, $v0, $s0
    /* ABD44 800BB544 00110200 */  sll        $v0, $v0, 4
    /* ABD48 800BB548 21186200 */  addu       $v1, $v1, $v0
    /* ABD4C 800BB54C 21186400 */  addu       $v1, $v1, $a0
    /* ABD50 800BB550 2300AF8B */  lwl        $t7, 0x23($sp)
    /* ABD54 800BB554 2000AF9B */  lwr        $t7, 0x20($sp)
    /* ABD58 800BB558 00000000 */  nop
    /* ABD5C 800BB55C 0F006FA8 */  swl        $t7, 0xF($v1)
    /* ABD60 800BB560 0C006FB8 */  swr        $t7, 0xC($v1)
    /* ABD64 800BB564 10006CAC */  sw         $t4, 0x10($v1)
    /* ABD68 800BB568 00004F8D */  lw         $t7, 0x0($t2)
    /* ABD6C 800BB56C 0400588D */  lw         $t8, 0x4($t2)
    /* ABD70 800BB570 0800598D */  lw         $t9, 0x8($t2)
    /* ABD74 800BB574 00006FAC */  sw         $t7, 0x0($v1)
    /* ABD78 800BB578 040078AC */  sw         $t8, 0x4($v1)
    /* ABD7C 800BB57C 080079AC */  sw         $t9, 0x8($v1)
    /* ABD80 800BB580 3BEE0208 */  j          .L800BB8EC
    /* ABD84 800BB584 140060AC */   sw        $zero, 0x14($v1)
  .L800BB588:
    /* ABD88 800BB588 34002011 */  beqz       $t1, .L800BB65C
    /* ABD8C 800BB58C 02000224 */   addiu     $v0, $zero, 0x2
    /* ABD90 800BB590 1B006214 */  bne        $v1, $v0, .L800BB600
    /* ABD94 800BB594 C0201100 */   sll       $a0, $s1, 3
    /* ABD98 800BB598 C0181000 */  sll        $v1, $s0, 3
    /* ABD9C 800BB59C 23187000 */  subu       $v1, $v1, $s0
    /* ABDA0 800BB5A0 00190300 */  sll        $v1, $v1, 4
    /* ABDA4 800BB5A4 C0301100 */  sll        $a2, $s1, 3
    /* ABDA8 800BB5A8 2330D100 */  subu       $a2, $a2, $s1
    /* ABDAC 800BB5AC 04304600 */  sllv       $a2, $a2, $v0
    /* ABDB0 800BB5B0 1280023C */  lui        $v0, %hi(gPrevSkidSm)
    /* ABDB4 800BB5B4 F0E24224 */  addiu      $v0, $v0, %lo(gPrevSkidSm)
    /* ABDB8 800BB5B8 2130C200 */  addu       $a2, $a2, $v0
    /* ABDBC 800BB5BC 21306600 */  addu       $a2, $v1, $a2
    /* ABDC0 800BB5C0 2000A227 */  addiu      $v0, $sp, 0x20
    /* ABDC4 800BB5C4 1000A2AF */  sw         $v0, 0x10($sp)
    /* ABDC8 800BB5C8 1280023C */  lui        $v0, %hi(gSaveSeg)
    /* ABDCC 800BB5CC F0E64224 */  addiu      $v0, $v0, %lo(gSaveSeg)
    /* ABDD0 800BB5D0 2110A200 */  addu       $v0, $a1, $v0
    /* ABDD4 800BB5D4 1400A8AF */  sw         $t0, 0x14($sp)
    /* ABDD8 800BB5D8 1800ACAF */  sw         $t4, 0x18($sp)
    /* ABDDC 800BB5DC 0000448C */  lw         $a0, 0x0($v0)
    /* ABDE0 800BB5E0 1280023C */  lui        $v0, %hi(gSaveChunk)
    /* ABDE4 800BB5E4 70E74224 */  addiu      $v0, $v0, %lo(gSaveChunk)
    /* ABDE8 800BB5E8 2110A200 */  addu       $v0, $a1, $v0
    /* ABDEC 800BB5EC 0000458C */  lw         $a1, 0x0($v0)
    /* ABDF0 800BB5F0 C27C030C */  jal        Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
    /* ABDF4 800BB5F4 21384001 */   addu      $a3, $t2, $zero
    /* ABDF8 800BB5F8 90ED0208 */  j          .L800BB640
    /* ABDFC 800BB5FC 1280023C */   lui       $v0, %hi(gStatusSm)
  .L800BB600:
    /* ABE00 800BB600 C0101000 */  sll        $v0, $s0, 3
    /* ABE04 800BB604 23105000 */  subu       $v0, $v0, $s0
    /* ABE08 800BB608 00110200 */  sll        $v0, $v0, 4
    /* ABE0C 800BB60C 23209100 */  subu       $a0, $a0, $s1
    /* ABE10 800BB610 80200400 */  sll        $a0, $a0, 2
    /* ABE14 800BB614 1280033C */  lui        $v1, %hi(gPrevSkidSm)
    /* ABE18 800BB618 F0E26324 */  addiu      $v1, $v1, %lo(gPrevSkidSm)
    /* ABE1C 800BB61C 21208300 */  addu       $a0, $a0, $v1
    /* ABE20 800BB620 21204400 */  addu       $a0, $v0, $a0
    /* ABE24 800BB624 21284001 */  addu       $a1, $t2, $zero
    /* ABE28 800BB628 2000A627 */  addiu      $a2, $sp, 0x20
    /* ABE2C 800BB62C 21380001 */  addu       $a3, $t0, $zero
    /* ABE30 800BB630 1000ACAF */  sw         $t4, 0x10($sp)
    /* ABE34 800BB634 E67A030C */  jal        Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
    /* ABE38 800BB638 1400ADAF */   sw        $t5, 0x14($sp)
    /* ABE3C 800BB63C 1280023C */  lui        $v0, %hi(gStatusSm)
  .L800BB640:
    /* ABE40 800BB640 70E64224 */  addiu      $v0, $v0, %lo(gStatusSm)
    /* ABE44 800BB644 80181100 */  sll        $v1, $s1, 2
    /* ABE48 800BB648 00211000 */  sll        $a0, $s0, 4
    /* ABE4C 800BB64C 21186400 */  addu       $v1, $v1, $a0
    /* ABE50 800BB650 21186200 */  addu       $v1, $v1, $v0
    /* ABE54 800BB654 3BEE0208 */  j          .L800BB8EC
    /* ABE58 800BB658 000060AC */   sw        $zero, 0x0($v1)
  .L800BB65C:
    /* ABE5C 800BB65C 1280043C */  lui        $a0, %hi(gPrevSkidSm)
    /* ABE60 800BB660 F0E28424 */  addiu      $a0, $a0, %lo(gPrevSkidSm)
    /* ABE64 800BB664 C0181100 */  sll        $v1, $s1, 3
    /* ABE68 800BB668 23187100 */  subu       $v1, $v1, $s1
    /* ABE6C 800BB66C 80180300 */  sll        $v1, $v1, 2
    /* ABE70 800BB670 C0101000 */  sll        $v0, $s0, 3
    /* ABE74 800BB674 23105000 */  subu       $v0, $v0, $s0
    /* ABE78 800BB678 00110200 */  sll        $v0, $v0, 4
    /* ABE7C 800BB67C 21186200 */  addu       $v1, $v1, $v0
    /* ABE80 800BB680 21186400 */  addu       $v1, $v1, $a0
    /* ABE84 800BB684 1400628C */  lw         $v0, 0x14($v1)
    /* ABE88 800BB688 00000000 */  nop
    /* ABE8C 800BB68C 1E004010 */  beqz       $v0, .L800BB708
    /* ABE90 800BB690 21380000 */   addu      $a3, $zero, $zero
    /* ABE94 800BB694 0000648C */  lw         $a0, 0x0($v1)
    /* ABE98 800BB698 0000428D */  lw         $v0, 0x0($t2)
    /* ABE9C 800BB69C 00000000 */  nop
    /* ABEA0 800BB6A0 23288200 */  subu       $a1, $a0, $v0
    /* ABEA4 800BB6A4 0200A01C */  bgtz       $a1, .L800BB6B0
    /* ABEA8 800BB6A8 00000000 */   nop
    /* ABEAC 800BB6AC 23284400 */  subu       $a1, $v0, $a0
  .L800BB6B0:
    /* ABEB0 800BB6B0 0800638C */  lw         $v1, 0x8($v1)
    /* ABEB4 800BB6B4 00000000 */  nop
    /* ABEB8 800BB6B8 23206600 */  subu       $a0, $v1, $a2
    /* ABEBC 800BB6BC 0200801C */  bgtz       $a0, .L800BB6C8
    /* ABEC0 800BB6C0 0900023C */   lui       $v0, (0x9FFFF >> 16)
    /* ABEC4 800BB6C4 2320C300 */  subu       $a0, $a2, $v1
  .L800BB6C8:
    /* ABEC8 800BB6C8 FFFF4234 */  ori        $v0, $v0, (0x9FFFF & 0xFFFF)
    /* ABECC 800BB6CC 2A104B00 */  slt        $v0, $v0, $t3
    /* ABED0 800BB6D0 02004014 */  bnez       $v0, .L800BB6DC
    /* ABED4 800BB6D4 00C00334 */   ori       $v1, $zero, 0xC000
    /* ABED8 800BB6D8 00300324 */  addiu      $v1, $zero, 0x3000
  .L800BB6DC:
    /* ABEDC 800BB6DC 2A108500 */  slt        $v0, $a0, $a1
    /* ABEE0 800BB6E0 03004010 */  beqz       $v0, .L800BB6F0
    /* ABEE4 800BB6E4 83100400 */   sra       $v0, $a0, 2
    /* ABEE8 800BB6E8 BEED0208 */  j          .L800BB6F8
    /* ABEEC 800BB6EC 2110A200 */   addu      $v0, $a1, $v0
  .L800BB6F0:
    /* ABEF0 800BB6F0 83100500 */  sra        $v0, $a1, 2
    /* ABEF4 800BB6F4 21108200 */  addu       $v0, $a0, $v0
  .L800BB6F8:
    /* ABEF8 800BB6F8 2A104300 */  slt        $v0, $v0, $v1
    /* ABEFC 800BB6FC 02004010 */  beqz       $v0, .L800BB708
    /* ABF00 800BB700 00000000 */   nop
    /* ABF04 800BB704 01000724 */  addiu      $a3, $zero, 0x1
  .L800BB708:
    /* ABF08 800BB708 3C00E014 */  bnez       $a3, .L800BB7FC
    /* ABF0C 800BB70C 1280023C */   lui       $v0, %hi(gStatusSm)
    /* ABF10 800BB710 70E64224 */  addiu      $v0, $v0, %lo(gStatusSm)
    /* ABF14 800BB714 80201100 */  sll        $a0, $s1, 2
    /* ABF18 800BB718 00191000 */  sll        $v1, $s0, 4
    /* ABF1C 800BB71C 21288300 */  addu       $a1, $a0, $v1
    /* ABF20 800BB720 2110A200 */  addu       $v0, $a1, $v0
    /* ABF24 800BB724 0000438C */  lw         $v1, 0x0($v0)
    /* ABF28 800BB728 02000224 */  addiu      $v0, $zero, 0x2
    /* ABF2C 800BB72C 1B006214 */  bne        $v1, $v0, .L800BB79C
    /* ABF30 800BB730 C0201100 */   sll       $a0, $s1, 3
    /* ABF34 800BB734 C0181000 */  sll        $v1, $s0, 3
    /* ABF38 800BB738 23187000 */  subu       $v1, $v1, $s0
    /* ABF3C 800BB73C 00190300 */  sll        $v1, $v1, 4
    /* ABF40 800BB740 C0301100 */  sll        $a2, $s1, 3
    /* ABF44 800BB744 2330D100 */  subu       $a2, $a2, $s1
    /* ABF48 800BB748 04304600 */  sllv       $a2, $a2, $v0
    /* ABF4C 800BB74C 1280023C */  lui        $v0, %hi(gPrevSkidSm)
    /* ABF50 800BB750 F0E24224 */  addiu      $v0, $v0, %lo(gPrevSkidSm)
    /* ABF54 800BB754 2130C200 */  addu       $a2, $a2, $v0
    /* ABF58 800BB758 21306600 */  addu       $a2, $v1, $a2
    /* ABF5C 800BB75C 2000A227 */  addiu      $v0, $sp, 0x20
    /* ABF60 800BB760 1000A2AF */  sw         $v0, 0x10($sp)
    /* ABF64 800BB764 1280023C */  lui        $v0, %hi(gSaveSeg)
    /* ABF68 800BB768 F0E64224 */  addiu      $v0, $v0, %lo(gSaveSeg)
    /* ABF6C 800BB76C 2110A200 */  addu       $v0, $a1, $v0
    /* ABF70 800BB770 1400A8AF */  sw         $t0, 0x14($sp)
    /* ABF74 800BB774 1800ACAF */  sw         $t4, 0x18($sp)
    /* ABF78 800BB778 0000448C */  lw         $a0, 0x0($v0)
    /* ABF7C 800BB77C 1280023C */  lui        $v0, %hi(gSaveChunk)
    /* ABF80 800BB780 70E74224 */  addiu      $v0, $v0, %lo(gSaveChunk)
    /* ABF84 800BB784 2110A200 */  addu       $v0, $a1, $v0
    /* ABF88 800BB788 0000458C */  lw         $a1, 0x0($v0)
    /* ABF8C 800BB78C E27C030C */  jal        Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
    /* ABF90 800BB790 21384001 */   addu      $a3, $t2, $zero
    /* ABF94 800BB794 F7ED0208 */  j          .L800BB7DC
    /* ABF98 800BB798 1280043C */   lui       $a0, %hi(gStatusSm)
  .L800BB79C:
    /* ABF9C 800BB79C C0101000 */  sll        $v0, $s0, 3
    /* ABFA0 800BB7A0 23105000 */  subu       $v0, $v0, $s0
    /* ABFA4 800BB7A4 00110200 */  sll        $v0, $v0, 4
    /* ABFA8 800BB7A8 23209100 */  subu       $a0, $a0, $s1
    /* ABFAC 800BB7AC 80200400 */  sll        $a0, $a0, 2
    /* ABFB0 800BB7B0 1280033C */  lui        $v1, %hi(gPrevSkidSm)
    /* ABFB4 800BB7B4 F0E26324 */  addiu      $v1, $v1, %lo(gPrevSkidSm)
    /* ABFB8 800BB7B8 21208300 */  addu       $a0, $a0, $v1
    /* ABFBC 800BB7BC 21204400 */  addu       $a0, $v0, $a0
    /* ABFC0 800BB7C0 21284001 */  addu       $a1, $t2, $zero
    /* ABFC4 800BB7C4 2000A627 */  addiu      $a2, $sp, 0x20
    /* ABFC8 800BB7C8 21380001 */  addu       $a3, $t0, $zero
    /* ABFCC 800BB7CC 1000ACAF */  sw         $t4, 0x10($sp)
    /* ABFD0 800BB7D0 E67A030C */  jal        Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
    /* ABFD4 800BB7D4 1400ADAF */   sw        $t5, 0x14($sp)
    /* ABFD8 800BB7D8 1280043C */  lui        $a0, %hi(gStatusSm)
  .L800BB7DC:
    /* ABFDC 800BB7DC 70E68424 */  addiu      $a0, $a0, %lo(gStatusSm)
    /* ABFE0 800BB7E0 80101100 */  sll        $v0, $s1, 2
    /* ABFE4 800BB7E4 00191000 */  sll        $v1, $s0, 4
    /* ABFE8 800BB7E8 21104300 */  addu       $v0, $v0, $v1
    /* ABFEC 800BB7EC 21104400 */  addu       $v0, $v0, $a0
    /* ABFF0 800BB7F0 01000324 */  addiu      $v1, $zero, 0x1
    /* ABFF4 800BB7F4 3BEE0208 */  j          .L800BB8EC
    /* ABFF8 800BB7F8 000043AC */   sw        $v1, 0x0($v0)
  .L800BB7FC:
    /* ABFFC 800BB7FC 70E64224 */  addiu      $v0, $v0, %lo(gStatusSm)
    /* AC000 800BB800 80181100 */  sll        $v1, $s1, 2
    /* AC004 800BB804 00311000 */  sll        $a2, $s0, 4
    /* AC008 800BB808 21286600 */  addu       $a1, $v1, $a2
    /* AC00C 800BB80C 2148A200 */  addu       $t1, $a1, $v0
    /* AC010 800BB810 0000228D */  lw         $v0, 0x0($t1)
    /* AC014 800BB814 02000B24 */  addiu      $t3, $zero, 0x2
    /* AC018 800BB818 1B004B14 */  bne        $v0, $t3, .L800BB888
    /* AC01C 800BB81C 1280043C */   lui       $a0, %hi(gSaveSeg)
    /* AC020 800BB820 C0181000 */  sll        $v1, $s0, 3
    /* AC024 800BB824 23187000 */  subu       $v1, $v1, $s0
    /* AC028 800BB828 00190300 */  sll        $v1, $v1, 4
    /* AC02C 800BB82C C0301100 */  sll        $a2, $s1, 3
    /* AC030 800BB830 2330D100 */  subu       $a2, $a2, $s1
    /* AC034 800BB834 04306601 */  sllv       $a2, $a2, $t3
    /* AC038 800BB838 1280023C */  lui        $v0, %hi(gPrevSkidSm)
    /* AC03C 800BB83C F0E24224 */  addiu      $v0, $v0, %lo(gPrevSkidSm)
    /* AC040 800BB840 2130C200 */  addu       $a2, $a2, $v0
    /* AC044 800BB844 21306600 */  addu       $a2, $v1, $a2
    /* AC048 800BB848 2000A227 */  addiu      $v0, $sp, 0x20
    /* AC04C 800BB84C 1000A2AF */  sw         $v0, 0x10($sp)
    /* AC050 800BB850 1280023C */  lui        $v0, %hi(gSaveSeg)
    /* AC054 800BB854 F0E64224 */  addiu      $v0, $v0, %lo(gSaveSeg)
    /* AC058 800BB858 2110A200 */  addu       $v0, $a1, $v0
    /* AC05C 800BB85C 1400A8AF */  sw         $t0, 0x14($sp)
    /* AC060 800BB860 1800ACAF */  sw         $t4, 0x18($sp)
    /* AC064 800BB864 0000448C */  lw         $a0, 0x0($v0)
    /* AC068 800BB868 1280023C */  lui        $v0, %hi(gSaveChunk)
    /* AC06C 800BB86C 70E74224 */  addiu      $v0, $v0, %lo(gSaveChunk)
    /* AC070 800BB870 2110A200 */  addu       $v0, $a1, $v0
    /* AC074 800BB874 0000458C */  lw         $a1, 0x0($v0)
    /* AC078 800BB878 C27C030C */  jal        Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
    /* AC07C 800BB87C 21384001 */   addu      $a3, $t2, $zero
    /* AC080 800BB880 3BEE0208 */  j          .L800BB8EC
    /* AC084 800BB884 00000000 */   nop
  .L800BB888:
    /* AC088 800BB888 F0E68424 */  addiu      $a0, $a0, %lo(gSaveSeg)
    /* AC08C 800BB88C 21206400 */  addu       $a0, $v1, $a0
    /* AC090 800BB890 2120C400 */  addu       $a0, $a2, $a0
    /* AC094 800BB894 1280053C */  lui        $a1, %hi(gSaveChunk)
    /* AC098 800BB898 70E7A524 */  addiu      $a1, $a1, %lo(gSaveChunk)
    /* AC09C 800BB89C 21286500 */  addu       $a1, $v1, $a1
    /* AC0A0 800BB8A0 2128C500 */  addu       $a1, $a2, $a1
    /* AC0A4 800BB8A4 C0181000 */  sll        $v1, $s0, 3
    /* AC0A8 800BB8A8 23187000 */  subu       $v1, $v1, $s0
    /* AC0AC 800BB8AC 00190300 */  sll        $v1, $v1, 4
    /* AC0B0 800BB8B0 C0301100 */  sll        $a2, $s1, 3
    /* AC0B4 800BB8B4 2330D100 */  subu       $a2, $a2, $s1
    /* AC0B8 800BB8B8 80300600 */  sll        $a2, $a2, 2
    /* AC0BC 800BB8BC 1280023C */  lui        $v0, %hi(gPrevSkidSm)
    /* AC0C0 800BB8C0 F0E24224 */  addiu      $v0, $v0, %lo(gPrevSkidSm)
    /* AC0C4 800BB8C4 2130C200 */  addu       $a2, $a2, $v0
    /* AC0C8 800BB8C8 21306600 */  addu       $a2, $v1, $a2
    /* AC0CC 800BB8CC 21384001 */  addu       $a3, $t2, $zero
    /* AC0D0 800BB8D0 2000A227 */  addiu      $v0, $sp, 0x20
    /* AC0D4 800BB8D4 00002BAD */  sw         $t3, 0x0($t1)
    /* AC0D8 800BB8D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* AC0DC 800BB8DC 1400A8AF */  sw         $t0, 0x14($sp)
    /* AC0E0 800BB8E0 1800ACAF */  sw         $t4, 0x18($sp)
    /* AC0E4 800BB8E4 DB7B030C */  jal        Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
    /* AC0E8 800BB8E8 1C00ADAF */   sw        $t5, 0x1C($sp)
  .L800BB8EC:
    /* AC0EC 800BB8EC 3000BF8F */  lw         $ra, 0x30($sp)
    /* AC0F0 800BB8F0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* AC0F4 800BB8F4 2800B08F */  lw         $s0, 0x28($sp)
    /* AC0F8 800BB8F8 0800E003 */  jr         $ra
    /* AC0FC 800BB8FC 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
