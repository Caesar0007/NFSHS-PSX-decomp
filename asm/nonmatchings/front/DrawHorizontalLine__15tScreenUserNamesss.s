.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawHorizontalLine__15tScreenUserNamesss, 0x84

glabel DrawHorizontalLine__15tScreenUserNamesss
    /* 3B928 8004B128 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3B92C 8004B12C 00140700 */  sll        $v0, $a3, 16
    /* 3B930 8004B130 031C0200 */  sra        $v1, $v0, 16
    /* 3B934 8004B134 04006018 */  blez       $v1, .L8004B148
    /* 3B938 8004B138 2000BFAF */   sw        $ra, 0x20($sp)
    /* 3B93C 8004B13C 40006228 */  slti       $v0, $v1, 0x40
    /* 3B940 8004B140 05004010 */  beqz       $v0, .L8004B158
    /* 3B944 8004B144 7800043C */   lui       $a0, (0x785A5A >> 16)
  .L8004B148:
    /* 3B948 8004B148 04006104 */  bgez       $v1, .L8004B15C
    /* 3B94C 8004B14C 7800043C */   lui       $a0, (0x785A5A >> 16)
    /* 3B950 8004B150 572C0108 */  j          .L8004B15C
    /* 3B954 8004B154 21380000 */   addu      $a3, $zero, $zero
  .L8004B158:
    /* 3B958 8004B158 40000724 */  addiu      $a3, $zero, 0x40
  .L8004B15C:
    /* 3B95C 8004B15C 5A5A8434 */  ori        $a0, $a0, (0x785A5A & 0xFFFF)
    /* 3B960 8004B160 01000224 */  addiu      $v0, $zero, 0x1
    /* 3B964 8004B164 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3B968 8004B168 02000224 */  addiu      $v0, $zero, 0x2
    /* 3B96C 8004B16C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 3B970 8004B170 00140700 */  sll        $v0, $a3, 16
    /* 3B974 8004B174 C3130200 */  sra        $v0, $v0, 15
    /* 3B978 8004B178 1800A2AF */  sw         $v0, 0x18($sp)
    /* 3B97C 8004B17C 0C000224 */  addiu      $v0, $zero, 0xC
    /* 3B980 8004B180 002C0500 */  sll        $a1, $a1, 16
    /* 3B984 8004B184 00340600 */  sll        $a2, $a2, 16
    /* 3B988 8004B188 032C0500 */  sra        $a1, $a1, 16
    /* 3B98C 8004B18C 03340600 */  sra        $a2, $a2, 16
    /* 3B990 8004B190 C0000724 */  addiu      $a3, $zero, 0xC0
    /* 3B994 8004B194 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 3B998 8004B198 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 3B99C 8004B19C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 3B9A0 8004B1A0 00000000 */  nop
    /* 3B9A4 8004B1A4 0800E003 */  jr         $ra
    /* 3B9A8 8004B1A8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawHorizontalLine__15tScreenUserNamesss
