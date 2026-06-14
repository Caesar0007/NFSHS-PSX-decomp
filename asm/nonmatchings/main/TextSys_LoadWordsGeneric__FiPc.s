.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_LoadWordsGeneric__FiPc, 0x84

glabel TextSys_LoadWordsGeneric__FiPc
    /* A9958 800B9158 E0FEBD27 */  addiu      $sp, $sp, -0x120
    /* A995C 800B915C 1001B0AF */  sw         $s0, 0x110($sp)
    /* A9960 800B9160 21808000 */  addu       $s0, $a0, $zero
    /* A9964 800B9164 1401B1AF */  sw         $s1, 0x114($sp)
    /* A9968 800B9168 2188A000 */  addu       $s1, $a1, $zero
    /* A996C 800B916C 0700022A */  slti       $v0, $s0, 0x7
    /* A9970 800B9170 15004010 */  beqz       $v0, .L800B91C8
    /* A9974 800B9174 1801BFAF */   sw        $ra, 0x118($sp)
    /* A9978 800B9178 0C0F848F */  lw         $a0, %gp_rel(wordFile)($gp)
    /* A997C 800B917C 00000000 */  nop
    /* A9980 800B9180 03008010 */  beqz       $a0, .L800B9190
    /* A9984 800B9184 00000000 */   nop
    /* A9988 800B9188 5095030C */  jal        purgememadr
    /* A998C 800B918C 00000000 */   nop
  .L800B9190:
    /* A9990 800B9190 1000A427 */  addiu      $a0, $sp, 0x10
    /* A9994 800B9194 1480053C */  lui        $a1, %hi(D_8013D45C)
    /* A9998 800B9198 5CD4A524 */  addiu      $a1, $a1, %lo(D_8013D45C)
    /* A999C 800B919C 1280033C */  lui        $v1, %hi(langFileName)
    /* A99A0 800B91A0 40E16324 */  addiu      $v1, $v1, %lo(langFileName)
    /* A99A4 800B91A4 80101000 */  sll        $v0, $s0, 2
    /* A99A8 800B91A8 21104300 */  addu       $v0, $v0, $v1
    /* A99AC 800B91AC 0000478C */  lw         $a3, 0x0($v0)
    /* A99B0 800B91B0 2F91030C */  jal        sprintf
    /* A99B4 800B91B4 21302002 */   addu      $a2, $s1, $zero
    /* A99B8 800B91B8 1000A427 */  addiu      $a0, $sp, 0x10
    /* A99BC 800B91BC FA95030C */  jal        loadfileadr
    /* A99C0 800B91C0 21280000 */   addu      $a1, $zero, $zero
    /* A99C4 800B91C4 0C0F82AF */  sw         $v0, %gp_rel(wordFile)($gp)
  .L800B91C8:
    /* A99C8 800B91C8 1801BF8F */  lw         $ra, 0x118($sp)
    /* A99CC 800B91CC 1401B18F */  lw         $s1, 0x114($sp)
    /* A99D0 800B91D0 1001B08F */  lw         $s0, 0x110($sp)
    /* A99D4 800B91D4 0800E003 */  jr         $ra
    /* A99D8 800B91D8 2001BD27 */   addiu     $sp, $sp, 0x120
endlabel TextSys_LoadWordsGeneric__FiPc
