.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDcalcvol, 0xF0

glabel iSNDcalcvol
    /* EF850 800FF050 1480053C */  lui        $a1, %hi(sndgs)
    /* EF854 800FF054 6078A524 */  addiu      $a1, $a1, %lo(sndgs)
    /* EF858 800FF058 40100400 */  sll        $v0, $a0, 1
    /* EF85C 800FF05C 21104400 */  addu       $v0, $v0, $a0
    /* EF860 800FF060 C0100200 */  sll        $v0, $v0, 3
    /* EF864 800FF064 21104400 */  addu       $v0, $v0, $a0
    /* EF868 800FF068 9400A38C */  lw         $v1, 0x94($a1)
    /* EF86C 800FF06C 80100200 */  sll        $v0, $v0, 2
    /* EF870 800FF070 21206200 */  addu       $a0, $v1, $v0
    /* EF874 800FF074 2C008380 */  lb         $v1, 0x2C($a0)
    /* EF878 800FF078 1E008284 */  lh         $v0, 0x1E($a0)
    /* EF87C 800FF07C 00000000 */  nop
    /* EF880 800FF080 18006200 */  mult       $v1, $v0
    /* EF884 800FF084 12180000 */  mflo       $v1
    /* EF888 800FF088 26008284 */  lh         $v0, 0x26($a0)
    /* EF88C 800FF08C 00000000 */  nop
    /* EF890 800FF090 18006200 */  mult       $v1, $v0
    /* EF894 800FF094 12180000 */  mflo       $v1
    /* EF898 800FF098 3D00A280 */  lb         $v0, 0x3D($a1)
    /* EF89C 800FF09C 00000000 */  nop
    /* EF8A0 800FF0A0 18006200 */  mult       $v1, $v0
    /* EF8A4 800FF0A4 12100000 */  mflo       $v0
    /* EF8A8 800FF0A8 8641033C */  lui        $v1, (0x4186143D >> 16)
    /* EF8AC 800FF0AC 3D146334 */  ori        $v1, $v1, (0x4186143D & 0xFFFF)
    /* EF8B0 800FF0B0 18004300 */  mult       $v0, $v1
    /* EF8B4 800FF0B4 5000858C */  lw         $a1, 0x50($a0)
    /* EF8B8 800FF0B8 C3170200 */  sra        $v0, $v0, 31
    /* EF8BC 800FF0BC 10180000 */  mfhi       $v1
    /* EF8C0 800FF0C0 C31C0300 */  sra        $v1, $v1, 19
    /* EF8C4 800FF0C4 23186200 */  subu       $v1, $v1, $v0
    /* EF8C8 800FF0C8 1100A010 */  beqz       $a1, .L800FF110
    /* EF8CC 800FF0CC 2D0083A0 */   sb        $v1, 0x2D($a0)
    /* EF8D0 800FF0D0 3A008290 */  lbu        $v0, 0x3A($a0)
    /* EF8D4 800FF0D4 001E0300 */  sll        $v1, $v1, 24
    /* EF8D8 800FF0D8 2110A200 */  addu       $v0, $a1, $v0
    /* EF8DC 800FF0DC 00004280 */  lb         $v0, 0x0($v0)
    /* EF8E0 800FF0E0 031E0300 */  sra        $v1, $v1, 24
    /* EF8E4 800FF0E4 18006200 */  mult       $v1, $v0
    /* EF8E8 800FF0E8 12180000 */  mflo       $v1
    /* EF8EC 800FF0EC 0281023C */  lui        $v0, (0x81020409 >> 16)
    /* EF8F0 800FF0F0 09044234 */  ori        $v0, $v0, (0x81020409 & 0xFFFF)
    /* EF8F4 800FF0F4 18006200 */  mult       $v1, $v0
    /* EF8F8 800FF0F8 10100000 */  mfhi       $v0
    /* EF8FC 800FF0FC 21104300 */  addu       $v0, $v0, $v1
    /* EF900 800FF100 83110200 */  sra        $v0, $v0, 6
    /* EF904 800FF104 C31F0300 */  sra        $v1, $v1, 31
    /* EF908 800FF108 23104300 */  subu       $v0, $v0, $v1
    /* EF90C 800FF10C 2D0082A0 */  sb         $v0, 0x2D($a0)
  .L800FF110:
    /* EF910 800FF110 4400838C */  lw         $v1, 0x44($a0)
    /* EF914 800FF114 00000000 */  nop
    /* EF918 800FF118 07006010 */  beqz       $v1, .L800FF138
    /* EF91C 800FF11C 00000000 */   nop
    /* EF920 800FF120 2D008280 */  lb         $v0, 0x2D($a0)
    /* EF924 800FF124 00000000 */  nop
    /* EF928 800FF128 21106200 */  addu       $v0, $v1, $v0
    /* EF92C 800FF12C 00004290 */  lbu        $v0, 0x0($v0)
    /* EF930 800FF130 00000000 */  nop
    /* EF934 800FF134 2D0082A0 */  sb         $v0, 0x2D($a0)
  .L800FF138:
    /* EF938 800FF138 0800E003 */  jr         $ra
    /* EF93C 800FF13C 00000000 */   nop
endlabel iSNDcalcvol
