.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Chunk_DeInit__Fv, 0x8

glabel Chunk_DeInit__Fv
    /* 7C130 8008B930 0800E003 */  jr         $ra
    /* 7C134 8008B934 00000000 */   nop
endlabel Chunk_DeInit__Fv
