.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncsystemtask, 0x90

glabel asyncsystemtask
    /* E1920 800F1120 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1924 800F1124 1480043C */  lui        $a0, %hi(D_8013DEA8)
    /* E1928 800F1128 A8DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA8)
    /* E192C 800F112C 1400BFAF */  sw         $ra, 0x14($sp)
    /* E1930 800F1130 63C40308 */  j          .L800F118C
    /* E1934 800F1134 1000B0AF */   sw        $s0, 0x10($sp)
  .L800F1138:
    /* E1938 800F1138 0C00028E */  lw         $v0, 0xC($s0)
    /* E193C 800F113C 00000000 */  nop
    /* E1940 800F1140 05004010 */  beqz       $v0, .L800F1158
    /* E1944 800F1144 00000000 */   nop
    /* E1948 800F1148 14C3030C */  jal        cancelrequest
    /* E194C 800F114C 21200002 */   addu      $a0, $s0, $zero
    /* E1950 800F1150 61C40308 */  j          .L800F1184
    /* E1954 800F1154 00000000 */   nop
  .L800F1158:
    /* E1958 800F1158 0000048E */  lw         $a0, 0x0($s0)
    /* E195C 800F115C 1400028E */  lw         $v0, 0x14($s0)
    /* E1960 800F1160 00000000 */  nop
    /* E1964 800F1164 09F84000 */  jalr       $v0
    /* E1968 800F1168 00000000 */   nop
    /* E196C 800F116C 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E1970 800F1170 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E1974 800F1174 00000292 */  lbu        $v0, 0x0($s0)
    /* E1978 800F1178 21280002 */  addu       $a1, $s0, $zero
    /* E197C 800F117C C7C2030C */  jal        queueadd
    /* E1980 800F1180 000002AE */   sw        $v0, 0x0($s0)
  .L800F1184:
    /* E1984 800F1184 1480043C */  lui        $a0, %hi(D_8013DEA8)
    /* E1988 800F1188 A8DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA8)
  .L800F118C:
    /* E198C 800F118C DDC2030C */  jal        queuefetch
    /* E1990 800F1190 00000000 */   nop
    /* E1994 800F1194 21804000 */  addu       $s0, $v0, $zero
    /* E1998 800F1198 E7FF0016 */  bnez       $s0, .L800F1138
    /* E199C 800F119C 21100000 */   addu      $v0, $zero, $zero
    /* E19A0 800F11A0 1400BF8F */  lw         $ra, 0x14($sp)
    /* E19A4 800F11A4 1000B08F */  lw         $s0, 0x10($sp)
    /* E19A8 800F11A8 0800E003 */  jr         $ra
    /* E19AC 800F11AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel asyncsystemtask
