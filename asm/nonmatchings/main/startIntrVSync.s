.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching startIntrVSync, 0x58

glabel startIntrVSync
    /* F6D34 80106534 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F6D38 80106538 1380043C */  lui        $a0, %hi(D_80137CF0)
    /* F6D3C 8010653C F07C8424 */  addiu      $a0, $a0, %lo(D_80137CF0)
    /* F6D40 80106540 1380033C */  lui        $v1, %hi(D_80137D14)
    /* F6D44 80106544 147D638C */  lw         $v1, %lo(D_80137D14)($v1)
    /* F6D48 80106548 00010224 */  addiu      $v0, $zero, 0x100
    /* F6D4C 8010654C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F6D50 80106550 000062AC */  sw         $v0, 0x0($v1)
    /* F6D54 80106554 1380013C */  lui        $at, %hi(Vcount)
    /* F6D58 80106558 107D20AC */  sw         $zero, %lo(Vcount)($at)
    /* F6D5C 8010655C 8919040C */  jal        startIntrVSync_helper_3
    /* F6D60 80106560 08000524 */   addiu     $a1, $zero, 0x8
    /* F6D64 80106564 1080053C */  lui        $a1, %hi(startIntrVSync_helper_1)
    /* F6D68 80106568 8C65A524 */  addiu      $a1, $a1, %lo(startIntrVSync_helper_1)
    /* F6D6C 8010656C 1FCA030C */  jal        InterruptCallback
    /* F6D70 80106570 21200000 */   addu      $a0, $zero, $zero
    /* F6D74 80106574 1080023C */  lui        $v0, %hi(startIntrVSync_helper_2)
    /* F6D78 80106578 F8654224 */  addiu      $v0, $v0, %lo(startIntrVSync_helper_2)
    /* F6D7C 8010657C 1000BF8F */  lw         $ra, 0x10($sp)
    /* F6D80 80106580 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F6D84 80106584 0800E003 */  jr         $ra
    /* F6D88 80106588 00000000 */   nop
endlabel startIntrVSync
