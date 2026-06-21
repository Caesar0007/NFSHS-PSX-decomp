.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_ResetPSXAnalogs__Fi, 0x44

glabel Front_ResetPSXAnalogs__Fi
    /* 17950 80027150 1180023C */  lui        $v0, %hi(frontEnd)
    /* 17954 80027154 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 17958 80027158 21208200 */  addu       $a0, $a0, $v0
    /* 1795C 8002715C 79000224 */  addiu      $v0, $zero, 0x79
    /* 17960 80027160 490382A0 */  sb         $v0, 0x349($a0)
    /* 17964 80027164 0A000224 */  addiu      $v0, $zero, 0xA
    /* 17968 80027168 4B0382A0 */  sb         $v0, 0x34B($a0)
    /* 1796C 8002716C FF000224 */  addiu      $v0, $zero, 0xFF
    /* 17970 80027170 7F000324 */  addiu      $v1, $zero, 0x7F
    /* 17974 80027174 4D0382A0 */  sb         $v0, 0x34D($a0)
    /* 17978 80027178 4F0382A0 */  sb         $v0, 0x34F($a0)
    /* 1797C 8002717C 06000224 */  addiu      $v0, $zero, 0x6
    /* 17980 80027180 510383A0 */  sb         $v1, 0x351($a0)
    /* 17984 80027184 530382A0 */  sb         $v0, 0x353($a0)
    /* 17988 80027188 550383A0 */  sb         $v1, 0x355($a0)
    /* 1798C 8002718C 0800E003 */  jr         $ra
    /* 17990 80027190 570382A0 */   sb        $v0, 0x357($a0)
endlabel Front_ResetPSXAnalogs__Fi
