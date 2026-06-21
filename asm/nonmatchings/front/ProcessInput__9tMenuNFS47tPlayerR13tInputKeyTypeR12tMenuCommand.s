.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand, 0x20

glabel ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
    /* BA30 8001B230 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BA34 8001B234 1000BFAF */  sw         $ra, 0x10($sp)
    /* BA38 8001B238 5E95000C */  jal        ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* BA3C 8001B23C 00000000 */   nop
    /* BA40 8001B240 1000BF8F */  lw         $ra, 0x10($sp)
    /* BA44 8001B244 00000000 */  nop
    /* BA48 8001B248 0800E003 */  jr         $ra
    /* BA4C 8001B24C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
