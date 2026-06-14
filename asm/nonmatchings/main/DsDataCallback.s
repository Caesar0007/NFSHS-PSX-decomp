.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DsDataCallback, 0x24

glabel DsDataCallback
    /* F9038 80108838 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F903C 8010883C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F9040 80108840 21288000 */  addu       $a1, $a0, $zero
    /* F9044 80108844 2BCA030C */  jal        DMACallback
    /* F9048 80108848 03000424 */   addiu     $a0, $zero, 0x3
    /* F904C 8010884C 1000BF8F */  lw         $ra, 0x10($sp)
    /* F9050 80108850 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F9054 80108854 0800E003 */  jr         $ra
    /* F9058 80108858 00000000 */   nop
endlabel DsDataCallback
