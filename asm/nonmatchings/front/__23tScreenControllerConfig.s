.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __23tScreenControllerConfig, 0x50

glabel __23tScreenControllerConfig
    /* 3605C 8004585C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 36060 80045860 1000B0AF */  sw         $s0, 0x10($sp)
    /* 36064 80045864 1400BFAF */  sw         $ra, 0x14($sp)
    /* 36068 80045868 0898000C */  jal        __7tScreen
    /* 3606C 8004586C 21808000 */   addu      $s0, $a0, $zero
    /* 36070 80045870 B8000426 */  addiu      $a0, $s0, 0xB8
    /* 36074 80045874 0180023C */  lui        $v0, %hi(_vt_23tScreenControllerConfig)
    /* 36078 80045878 78204224 */  addiu      $v0, $v0, %lo(_vt_23tScreenControllerConfig)
    /* 3607C 8004587C A366000C */  jal        __12tDialogYesNo
    /* 36080 80045880 600002AE */   sw        $v0, 0x60($s0)
    /* 36084 80045884 21100002 */  addu       $v0, $s0, $zero
    /* 36088 80045888 7C0040A4 */  sh         $zero, 0x7C($v0)
    /* 3608C 8004588C 7E0040A4 */  sh         $zero, 0x7E($v0)
    /* 36090 80045890 720040A4 */  sh         $zero, 0x72($v0)
    /* 36094 80045894 700040A4 */  sh         $zero, 0x70($v0)
    /* 36098 80045898 780140AC */  sw         $zero, 0x178($v0)
    /* 3609C 8004589C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 360A0 800458A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 360A4 800458A4 0800E003 */  jr         $ra
    /* 360A8 800458A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __23tScreenControllerConfig
