.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_MainExitKey__Fv, 0x28

glabel Input_MainExitKey__Fv
    /* 8DBBC 8009D3BC 1180033C */  lui        $v1, %hi(Input_gInterfaceResults)
    /* 8DBC0 8009D3C0 1280023C */  lui        $v0, %hi(D_8011E0B4)
    /* 8DBC4 8009D3C4 B4E0428C */  lw         $v0, %lo(D_8011E0B4)($v0)
    /* 8DBC8 8009D3C8 143F6324 */  addiu      $v1, $v1, %lo(Input_gInterfaceResults)
    /* 8DBCC 8009D3CC 1F004230 */  andi       $v0, $v0, 0x1F
    /* 8DBD0 8009D3D0 80100200 */  sll        $v0, $v0, 2
    /* 8DBD4 8009D3D4 21104300 */  addu       $v0, $v0, $v1
    /* 8DBD8 8009D3D8 0000428C */  lw         $v0, 0x0($v0)
    /* 8DBDC 8009D3DC 0800E003 */  jr         $ra
    /* 8DBE0 8009D3E0 01004230 */   andi      $v0, $v0, 0x1
endlabel Input_MainExitKey__Fv
