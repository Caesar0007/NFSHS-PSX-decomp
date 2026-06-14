.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR, 0xA0

glabel SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR
    /* 838F8 800930F8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 838FC 800930FC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83900 80093100 0B000824 */  addiu      $t0, $zero, 0xB
    /* 83904 80093104 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093108:
    /* 83908 80093108 000040AC */  sw         $zero, 0x0($v0)
    /* 8390C 8009310C FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 83910 80093110 FDFF0105 */  bgez       $t0, .L80093108
    /* 83914 80093114 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83918 80093118 56010224 */  addiu      $v0, $zero, 0x156
    /* 8391C 8009311C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83920 80093120 0000828C */  lw         $v0, 0x0($a0)
    /* 83924 80093124 00000000 */  nop
    /* 83928 80093128 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8392C 8009312C 0000A28C */  lw         $v0, 0x0($a1)
    /* 83930 80093130 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83934 80093134 1800A2AF */  sw         $v0, 0x18($sp)
    /* 83938 80093138 5800A28F */  lw         $v0, 0x58($sp)
    /* 8393C 8009313C 0000E38C */  lw         $v1, 0x0($a3)
    /* 83940 80093140 2400A2AF */  sw         $v0, 0x24($sp)
    /* 83944 80093144 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 83948 80093148 2000A3AF */  sw         $v1, 0x20($sp)
    /* 8394C 8009314C 0000438C */  lw         $v1, 0x0($v0)
    /* 83950 80093150 6000A28F */  lw         $v0, 0x60($sp)
    /* 83954 80093154 00000000 */  nop
    /* 83958 80093158 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 8395C 8009315C 6400A28F */  lw         $v0, 0x64($sp)
    /* 83960 80093160 2800A3AF */  sw         $v1, 0x28($sp)
    /* 83964 80093164 0000428C */  lw         $v0, 0x0($v0)
    /* 83968 80093168 00000000 */  nop
    /* 8396C 8009316C 3000A2AF */  sw         $v0, 0x30($sp)
    /* 83970 80093170 6800A28F */  lw         $v0, 0x68($sp)
    /* 83974 80093174 00000000 */  nop
    /* 83978 80093178 0000428C */  lw         $v0, 0x0($v0)
    /* 8397C 8009317C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83980 80093180 6E9C030C */  jal        SPCH_AddEvent
    /* 83984 80093184 3400A2AF */   sw        $v0, 0x34($sp)
    /* 83988 80093188 4000BF8F */  lw         $ra, 0x40($sp)
    /* 8398C 8009318C 00000000 */  nop
    /* 83990 80093190 0800E003 */  jr         $ra
    /* 83994 80093194 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR
