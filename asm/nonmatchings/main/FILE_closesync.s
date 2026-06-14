.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_closesync, 0x54

glabel FILE_closesync
    /* DB150 800EA950 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB154 800EA954 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB158 800EA958 21880000 */  addu       $s1, $zero, $zero
    /* DB15C 800EA95C 21302002 */  addu       $a2, $s1, $zero
    /* DB160 800EA960 1800BFAF */  sw         $ra, 0x18($sp)
    /* DB164 800EA964 0BB1030C */  jal        FILE_close
    /* DB168 800EA968 1000B0AF */   sw        $s0, 0x10($sp)
    /* DB16C 800EA96C 21804000 */  addu       $s0, $v0, $zero
    /* DB170 800EA970 07000012 */  beqz       $s0, .L800EA990
    /* DB174 800EA974 21102002 */   addu      $v0, $s1, $zero
    /* DB178 800EA978 6FB0030C */  jal        FILE_waitop
    /* DB17C 800EA97C 21200002 */   addu      $a0, $s0, $zero
    /* DB180 800EA980 ACB0030C */  jal        FILE_completeop
    /* DB184 800EA984 21200002 */   addu      $a0, $s0, $zero
    /* DB188 800EA988 21884000 */  addu       $s1, $v0, $zero
    /* DB18C 800EA98C 21102002 */  addu       $v0, $s1, $zero
  .L800EA990:
    /* DB190 800EA990 1800BF8F */  lw         $ra, 0x18($sp)
    /* DB194 800EA994 1400B18F */  lw         $s1, 0x14($sp)
    /* DB198 800EA998 1000B08F */  lw         $s0, 0x10($sp)
    /* DB19C 800EA99C 0800E003 */  jr         $ra
    /* DB1A0 800EA9A0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_closesync
