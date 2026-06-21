.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_atomic, 0x58

glabel FILE_atomic
    /* DD340 800ECB40 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DD344 800ECB44 21108000 */  addu       $v0, $a0, $zero
    /* DD348 800ECB48 2120C000 */  addu       $a0, $a2, $zero
    /* DD34C 800ECB4C 1000B0AF */  sw         $s0, 0x10($sp)
    /* DD350 800ECB50 1480103C */  lui        $s0, %hi(gFileDevice)
    /* DD354 800ECB54 88EA1026 */  addiu      $s0, $s0, %lo(gFileDevice)
    /* DD358 800ECB58 1800BFAF */  sw         $ra, 0x18($sp)
    /* DD35C 800ECB5C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DD360 800ECB60 0800118E */  lw         $s1, 0x8($s0)
    /* DD364 800ECB64 2128E000 */  addu       $a1, $a3, $zero
    /* DD368 800ECB68 09F84000 */  jalr       $v0
    /* DD36C 800ECB6C 080004AE */   sw        $a0, 0x8($s0)
    /* DD370 800ECB70 21200000 */  addu       $a0, $zero, $zero
    /* DD374 800ECB74 080011AE */  sw         $s1, 0x8($s0)
    /* DD378 800ECB78 E6B2030C */  jal        iFILE_ExecCommand
    /* DD37C 800ECB7C 21804000 */   addu      $s0, $v0, $zero
    /* DD380 800ECB80 21100002 */  addu       $v0, $s0, $zero
    /* DD384 800ECB84 1800BF8F */  lw         $ra, 0x18($sp)
    /* DD388 800ECB88 1400B18F */  lw         $s1, 0x14($sp)
    /* DD38C 800ECB8C 1000B08F */  lw         $s0, 0x10($sp)
    /* DD390 800ECB90 0800E003 */  jr         $ra
    /* DD394 800ECB94 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_atomic
