.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__18tInsideBoxSongMenu, 0x8

glabel DebounceKeys__18tInsideBoxSongMenu
    /* F674 8001EE74 0800E003 */  jr         $ra
    /* F678 8001EE78 001E0224 */   addiu     $v0, $zero, 0x1E00
endlabel DebounceKeys__18tInsideBoxSongMenu
