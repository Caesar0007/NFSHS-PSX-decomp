.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Chunk_Init__Fv, 0x8

glabel Chunk_Init__Fv
    /* 7C128 8008B928 0800E003 */  jr         $ra
    /* 7C12C 8008B92C 00000000 */   nop
endlabel Chunk_Init__Fv
