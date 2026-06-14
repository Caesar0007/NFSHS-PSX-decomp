.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ConvertTime, 0x5C

glabel iSPCH_ConvertTime
    /* F14C4 80100CC4 1580023C */  lui        $v0, %hi(gDataRate)
    /* F14C8 80100CC8 3484438C */  lw         $v1, %lo(gDataRate)($v0)
    /* F14CC 80100CCC 00000000 */  nop
    /* F14D0 80100CD0 11006010 */  beqz       $v1, .L80100D18
    /* F14D4 80100CD4 21280000 */   addu      $a1, $zero, $zero
    /* F14D8 80100CD8 40100400 */  sll        $v0, $a0, 1
    /* F14DC 80100CDC 21104400 */  addu       $v0, $v0, $a0
    /* F14E0 80100CE0 C0100200 */  sll        $v0, $v0, 3
    /* F14E4 80100CE4 21104400 */  addu       $v0, $v0, $a0
    /* F14E8 80100CE8 80100200 */  sll        $v0, $v0, 2
    /* F14EC 80100CEC 1A004300 */  div        $zero, $v0, $v1
    /* F14F0 80100CF0 02006014 */  bnez       $v1, .L80100CFC
    /* F14F4 80100CF4 00000000 */   nop
    /* F14F8 80100CF8 0D000700 */  break      7
  .L80100CFC:
    /* F14FC 80100CFC FFFF0124 */  addiu      $at, $zero, -0x1
    /* F1500 80100D00 04006114 */  bne        $v1, $at, .L80100D14
    /* F1504 80100D04 0080013C */   lui       $at, (0x80000000 >> 16)
    /* F1508 80100D08 02004114 */  bne        $v0, $at, .L80100D14
    /* F150C 80100D0C 00000000 */   nop
    /* F1510 80100D10 0D000600 */  break      6
  .L80100D14:
    /* F1514 80100D14 12280000 */  mflo       $a1
  .L80100D18:
    /* F1518 80100D18 0800E003 */  jr         $ra
    /* F151C 80100D1C 2110A000 */   addu      $v0, $a1, $zero
endlabel iSPCH_ConvertTime
