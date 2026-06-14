.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching chkRC2wait, 0xA0

glabel chkRC2wait
    /* FC808 8010C008 801F023C */  lui        $v0, (0x1F801120 >> 16)
    /* FC80C 8010C00C 20114234 */  ori        $v0, $v0, (0x1F801120 & 0xFFFF)
    /* FC810 8010C010 00004394 */  lhu        $v1, 0x0($v0)
    /* FC814 8010C014 1580023C */  lui        $v0, %hi(_startTime)
    /* FC818 8010C018 B08A428C */  lw         $v0, %lo(_startTime)($v0)
    /* FC81C 8010C01C FFFF6430 */  andi       $a0, $v1, 0xFFFF
    /* FC820 8010C020 2B108200 */  sltu       $v0, $a0, $v0
    /* FC824 8010C024 0A004010 */  beqz       $v0, .L8010C050
    /* FC828 8010C028 801F033C */   lui       $v1, (0x1F801128 >> 16)
    /* FC82C 8010C02C 28116334 */  ori        $v1, $v1, (0x1F801128 & 0xFFFF)
    /* FC830 8010C030 00006294 */  lhu        $v0, 0x0($v1)
    /* FC834 8010C034 00000000 */  nop
    /* FC838 8010C038 04004010 */  beqz       $v0, .L8010C04C
    /* FC83C 8010C03C 0100023C */   lui       $v0, (0x10000 >> 16)
    /* FC840 8010C040 00006294 */  lhu        $v0, 0x0($v1)
    /* FC844 8010C044 14300408 */  j          .L8010C050
    /* FC848 8010C048 21208200 */   addu      $a0, $a0, $v0
  .L8010C04C:
    /* FC84C 8010C04C 21208200 */  addu       $a0, $a0, $v0
  .L8010C050:
    /* FC850 8010C050 801F023C */  lui        $v0, (0x1F801124 >> 16)
    /* FC854 8010C054 24114234 */  ori        $v0, $v0, (0x1F801124 & 0xFFFF)
    /* FC858 8010C058 00004294 */  lhu        $v0, 0x0($v0)
    /* FC85C 8010C05C 00000000 */  nop
    /* FC860 8010C060 00024230 */  andi       $v0, $v0, 0x200
    /* FC864 8010C064 08004014 */  bnez       $v0, .L8010C088
    /* FC868 8010C068 00000000 */   nop
    /* FC86C 8010C06C 1580023C */  lui        $v0, %hi(_startTime)
    /* FC870 8010C070 B08A428C */  lw         $v0, %lo(_startTime)($v0)
    /* FC874 8010C074 1580033C */  lui        $v1, %hi(_waitTime)
    /* FC878 8010C078 AC8A638C */  lw         $v1, %lo(_waitTime)($v1)
    /* FC87C 8010C07C 23108200 */  subu       $v0, $a0, $v0
    /* FC880 8010C080 27300408 */  j          .L8010C09C
    /* FC884 8010C084 C2100200 */   srl       $v0, $v0, 3
  .L8010C088:
    /* FC888 8010C088 1580023C */  lui        $v0, %hi(_startTime)
    /* FC88C 8010C08C B08A428C */  lw         $v0, %lo(_startTime)($v0)
    /* FC890 8010C090 1580033C */  lui        $v1, %hi(_waitTime)
    /* FC894 8010C094 AC8A638C */  lw         $v1, %lo(_waitTime)($v1)
    /* FC898 8010C098 23108200 */  subu       $v0, $a0, $v0
  .L8010C09C:
    /* FC89C 8010C09C 2B104300 */  sltu       $v0, $v0, $v1
    /* FC8A0 8010C0A0 0800E003 */  jr         $ra
    /* FC8A4 8010C0A4 01004238 */   xori      $v0, $v0, 0x1
endlabel chkRC2wait
