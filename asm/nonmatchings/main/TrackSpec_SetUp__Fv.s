.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrackSpec_SetUp__Fv, 0x24

glabel TrackSpec_SetUp__Fv
    /* D1F7C 800E177C 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* D1F80 800E1780 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
    /* D1F84 800E1784 7C324224 */  addiu      $v0, $v0, %lo(TrackSpec_gSpec)
    /* D1F88 800E1788 08004484 */  lh         $a0, 0x8($v0)
    /* D1F8C 800E178C 02004284 */  lh         $v0, 0x2($v0)
    /* D1F90 800E1790 EC316324 */  addiu      $v1, $v1, %lo(GameSetup_gData)
    /* D1F94 800E1794 540064AC */  sw         $a0, 0x54($v1)
    /* D1F98 800E1798 0800E003 */  jr         $ra
    /* D1F9C 800E179C 480062AC */   sw        $v0, 0x48($v1)
endlabel TrackSpec_SetUp__Fv
