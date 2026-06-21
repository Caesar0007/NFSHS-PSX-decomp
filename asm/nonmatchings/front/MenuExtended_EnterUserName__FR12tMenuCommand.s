.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_EnterUserName__FR12tMenuCommand, 0x64

glabel MenuExtended_EnterUserName__FR12tMenuCommand
    /* 1DA14 8002D214 0580033C */  lui        $v1, %hi(FEApp)
    /* 1DA18 8002D218 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1DA1C 8002D21C 581A468C */  lw         $a2, %lo(menuDefs)($v0)
    /* 1DA20 8002D220 C014628C */  lw         $v0, %lo(FEApp)($v1)
    /* 1DA24 8002D224 2C31C524 */  addiu      $a1, $a2, 0x312C
    /* 1DA28 8002D228 2D024790 */  lbu        $a3, 0x22D($v0)
    /* 1DA2C 8002D22C 2D024390 */  lbu        $v1, 0x22D($v0)
    /* 1DA30 8002D230 07000224 */  addiu      $v0, $zero, 0x7
    /* 1DA34 8002D234 2000A2A4 */  sh         $v0, 0x20($a1)
    /* 1DA38 8002D238 1180023C */  lui        $v0, %hi(D_80114964)
    /* 1DA3C 8002D23C 64494224 */  addiu      $v0, $v0, %lo(D_80114964)
    /* 1DA40 8002D240 C0180300 */  sll        $v1, $v1, 3
    /* 1DA44 8002D244 21186200 */  addu       $v1, $v1, $v0
    /* 1DA48 8002D248 0580023C */  lui        $v0, %hi(screenUserName)
    /* 1DA4C 8002D24C B429428C */  lw         $v0, %lo(screenUserName)($v0)
    /* 1DA50 8002D250 D032C624 */  addiu      $a2, $a2, 0x32D0
    /* 1DA54 8002D254 2400A0A4 */  sh         $zero, 0x24($a1)
    /* 1DA58 8002D258 2200A0A4 */  sh         $zero, 0x22($a1)
    /* 1DA5C 8002D25C 8000A7A4 */  sh         $a3, 0x80($a1)
    /* 1DA60 8002D260 1C00A3AC */  sw         $v1, 0x1C($a1)
    /* 1DA64 8002D264 640046AC */  sw         $a2, 0x64($v0)
    /* 1DA68 8002D268 01000224 */  addiu      $v0, $zero, 0x1
    /* 1DA6C 8002D26C 000082AC */  sw         $v0, 0x0($a0)
    /* 1DA70 8002D270 0800E003 */  jr         $ra
    /* 1DA74 8002D274 040086AC */   sw        $a2, 0x4($a0)
endlabel MenuExtended_EnterUserName__FR12tMenuCommand
