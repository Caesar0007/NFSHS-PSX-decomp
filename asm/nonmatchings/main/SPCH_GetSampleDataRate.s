.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_GetSampleDataRate, 0x84

glabel SPCH_GetSampleDataRate
    /* DBE6C 800EB66C 18008500 */  mult       $a0, $a1
    /* DBE70 800EB670 12200000 */  mflo       $a0
    /* DBE74 800EB674 02008104 */  bgez       $a0, .L800EB680
    /* DBE78 800EB678 01000224 */   addiu     $v0, $zero, 0x1
    /* DBE7C 800EB67C 07008424 */  addiu      $a0, $a0, 0x7
  .L800EB680:
    /* DBE80 800EB680 0700C210 */  beq        $a2, $v0, .L800EB6A0
    /* DBE84 800EB684 C3180400 */   sra       $v1, $a0, 3
    /* DBE88 800EB688 1600C010 */  beqz       $a2, .L800EB6E4
    /* DBE8C 800EB68C 02000224 */   addiu     $v0, $zero, 0x2
    /* DBE90 800EB690 0B00C210 */  beq        $a2, $v0, .L800EB6C0
    /* DBE94 800EB694 21106000 */   addu      $v0, $v1, $zero
    /* DBE98 800EB698 BAAD0308 */  j          .L800EB6E8
    /* DBE9C 800EB69C 00000000 */   nop
  .L800EB6A0:
    /* DBEA0 800EB6A0 6666023C */  lui        $v0, (0x66666667 >> 16)
    /* DBEA4 800EB6A4 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* DBEA8 800EB6A8 18006200 */  mult       $v1, $v0
    /* DBEAC 800EB6AC C3170400 */  sra        $v0, $a0, 31
    /* DBEB0 800EB6B0 10380000 */  mfhi       $a3
    /* DBEB4 800EB6B4 83180700 */  sra        $v1, $a3, 2
    /* DBEB8 800EB6B8 B9AD0308 */  j          .L800EB6E4
    /* DBEBC 800EB6BC 23186200 */   subu      $v1, $v1, $v0
  .L800EB6C0:
    /* DBEC0 800EB6C0 4992023C */  lui        $v0, (0x92492493 >> 16)
    /* DBEC4 800EB6C4 93244234 */  ori        $v0, $v0, (0x92492493 & 0xFFFF)
    /* DBEC8 800EB6C8 40180300 */  sll        $v1, $v1, 1
    /* DBECC 800EB6CC 18006200 */  mult       $v1, $v0
    /* DBED0 800EB6D0 10380000 */  mfhi       $a3
    /* DBED4 800EB6D4 2110E300 */  addu       $v0, $a3, $v1
    /* DBED8 800EB6D8 83100200 */  sra        $v0, $v0, 2
    /* DBEDC 800EB6DC C31F0300 */  sra        $v1, $v1, 31
    /* DBEE0 800EB6E0 23184300 */  subu       $v1, $v0, $v1
  .L800EB6E4:
    /* DBEE4 800EB6E4 21106000 */  addu       $v0, $v1, $zero
  .L800EB6E8:
    /* DBEE8 800EB6E8 0800E003 */  jr         $ra
    /* DBEEC 800EB6EC 00000000 */   nop
endlabel SPCH_GetSampleDataRate
