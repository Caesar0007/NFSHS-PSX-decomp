.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching seedrandom, 0x70

glabel seedrandom
    /* D8078 800E7878 1280053C */  lui        $a1, %hi(seed)
    /* D807C 800E787C 9C34A524 */  addiu      $a1, $a1, %lo(seed)
    /* D8080 800E7880 2DF2013C */  lui        $at, (0xF22D0E56 >> 16)
    /* D8084 800E7884 560E2134 */  ori        $at, $at, (0xF22D0E56 & 0xFFFF)
    /* D8088 800E7888 21208100 */  addu       $a0, $a0, $at
    /* D808C 800E788C 0000A4AC */  sw         $a0, 0x0($a1)
    /* D8090 800E7890 0496013C */  lui        $at, (0x96041893 >> 16)
    /* D8094 800E7894 93182134 */  ori        $at, $at, (0x96041893 & 0xFFFF)
    /* D8098 800E7898 21208100 */  addu       $a0, $a0, $at
    /* D809C 800E789C 0400A4AC */  sw         $a0, 0x4($a1)
    /* D80A0 800E78A0 F33D013C */  lui        $at, (0x3DF3B646 >> 16)
    /* D80A4 800E78A4 46B62134 */  ori        $at, $at, (0x3DF3B646 & 0xFFFF)
    /* D80A8 800E78A8 21208100 */  addu       $a0, $a0, $at
    /* D80AC 800E78AC 0800A4AC */  sw         $a0, 0x8($a1)
    /* D80B0 800E78B0 DD40013C */  lui        $at, (0x40DDE76D >> 16)
    /* D80B4 800E78B4 6DE72134 */  ori        $at, $at, (0x40DDE76D & 0xFFFF)
    /* D80B8 800E78B8 21208100 */  addu       $a0, $a0, $at
    /* D80BC 800E78BC 0C00A4AC */  sw         $a0, 0xC($a1)
    /* D80C0 800E78C0 3297013C */  lui        $at, (0x97327AE1 >> 16)
    /* D80C4 800E78C4 E17A2134 */  ori        $at, $at, (0x97327AE1 & 0xFFFF)
    /* D80C8 800E78C8 21208100 */  addu       $a0, $a0, $at
    /* D80CC 800E78CC 1000A4AC */  sw         $a0, 0x10($a1)
    /* D80D0 800E78D0 A9D1013C */  lui        $at, (0xD1A9FBE7 >> 16)
    /* D80D4 800E78D4 E7FB2134 */  ori        $at, $at, (0xD1A9FBE7 & 0xFFFF)
    /* D80D8 800E78D8 21208100 */  addu       $a0, $a0, $at
    /* D80DC 800E78DC 1400A4AC */  sw         $a0, 0x14($a1)
    /* D80E0 800E78E0 0800E003 */  jr         $ra
    /* D80E4 800E78E4 00000000 */   nop
endlabel seedrandom
