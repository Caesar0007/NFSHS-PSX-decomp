.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_DownloadFrame__Fv, 0x10

glabel Movie_DownloadFrame__Fv
    /* 3D464 8004CC64 0580033C */  lui        $v1, %hi(download)
    /* 3D468 8004CC68 01000224 */  addiu      $v0, $zero, 0x1
    /* 3D46C 8004CC6C 0800E003 */  jr         $ra
    /* 3D470 8004CC70 302A62A4 */   sh        $v0, %lo(download)($v1)
endlabel Movie_DownloadFrame__Fv
