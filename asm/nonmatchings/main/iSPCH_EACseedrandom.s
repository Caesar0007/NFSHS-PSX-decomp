.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_EACseedrandom, 0x6C

glabel iSPCH_EACseedrandom
    /* DC2C4 800EBAC4 2DF2023C */  lui        $v0, (0xF22D0E56 >> 16)
    /* DC2C8 800EBAC8 560E4234 */  ori        $v0, $v0, (0xF22D0E56 & 0xFFFF)
    /* DC2CC 800EBACC 21208200 */  addu       $a0, $a0, $v0
    /* DC2D0 800EBAD0 0496033C */  lui        $v1, (0x96041893 >> 16)
    /* DC2D4 800EBAD4 93186334 */  ori        $v1, $v1, (0x96041893 & 0xFFFF)
    /* DC2D8 800EBAD8 1280023C */  lui        $v0, %hi(seedX)
    /* DC2DC 800EBADC F43544AC */  sw         $a0, %lo(seedX)($v0)
    /* DC2E0 800EBAE0 21208300 */  addu       $a0, $a0, $v1
    /* DC2E4 800EBAE4 F33D033C */  lui        $v1, (0x3DF3B646 >> 16)
    /* DC2E8 800EBAE8 46B66334 */  ori        $v1, $v1, (0x3DF3B646 & 0xFFFF)
    /* DC2EC 800EBAEC F4354224 */  addiu      $v0, $v0, %lo(seedX)
    /* DC2F0 800EBAF0 040044AC */  sw         $a0, 0x4($v0)
    /* DC2F4 800EBAF4 21208300 */  addu       $a0, $a0, $v1
    /* DC2F8 800EBAF8 DD40033C */  lui        $v1, (0x40DDE76D >> 16)
    /* DC2FC 800EBAFC 6DE76334 */  ori        $v1, $v1, (0x40DDE76D & 0xFFFF)
    /* DC300 800EBB00 080044AC */  sw         $a0, 0x8($v0)
    /* DC304 800EBB04 21208300 */  addu       $a0, $a0, $v1
    /* DC308 800EBB08 3297033C */  lui        $v1, (0x97327AE1 >> 16)
    /* DC30C 800EBB0C E17A6334 */  ori        $v1, $v1, (0x97327AE1 & 0xFFFF)
    /* DC310 800EBB10 0C0044AC */  sw         $a0, 0xC($v0)
    /* DC314 800EBB14 21208300 */  addu       $a0, $a0, $v1
    /* DC318 800EBB18 A9D1033C */  lui        $v1, (0xD1A9FBE7 >> 16)
    /* DC31C 800EBB1C E7FB6334 */  ori        $v1, $v1, (0xD1A9FBE7 & 0xFFFF)
    /* DC320 800EBB20 100044AC */  sw         $a0, 0x10($v0)
    /* DC324 800EBB24 21208300 */  addu       $a0, $a0, $v1
    /* DC328 800EBB28 0800E003 */  jr         $ra
    /* DC32C 800EBB2C 140044AC */   sw        $a0, 0x14($v0)
endlabel iSPCH_EACseedrandom
