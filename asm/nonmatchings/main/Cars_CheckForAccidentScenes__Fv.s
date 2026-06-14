.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_CheckForAccidentScenes__Fv, 0xC8

glabel Cars_CheckForAccidentScenes__Fv
    /* 7B9C4 8008B1C4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7B9C8 8008B1C8 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* 7B9CC 8008B1CC EC316424 */  addiu      $a0, $v1, %lo(GameSetup_gData)
    /* 7B9D0 8008B1D0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 7B9D4 8008B1D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7B9D8 8008B1D8 0C00828C */  lw         $v0, 0xC($a0)
    /* 7B9DC 8008B1DC 01001024 */  addiu      $s0, $zero, 0x1
    /* 7B9E0 8008B1E0 26005010 */  beq        $v0, $s0, .L8008B27C
    /* 7B9E4 8008B1E4 00000000 */   nop
    /* 7B9E8 8008B1E8 EC31638C */  lw         $v1, %lo(GameSetup_gData)($v1)
    /* 7B9EC 8008B1EC 00000000 */  nop
    /* 7B9F0 8008B1F0 22007010 */  beq        $v1, $s0, .L8008B27C
    /* 7B9F4 8008B1F4 05000224 */   addiu     $v0, $zero, 0x5
    /* 7B9F8 8008B1F8 20006210 */  beq        $v1, $v0, .L8008B27C
    /* 7B9FC 8008B1FC 00000000 */   nop
    /* 7BA00 8008B200 1480023C */  lui        $v0, %hi(SceneLoaded)
    /* 7BA04 8008B204 58C7428C */  lw         $v0, %lo(SceneLoaded)($v0)
    /* 7BA08 8008B208 00000000 */  nop
    /* 7BA0C 8008B20C 0F004010 */  beqz       $v0, .L8008B24C
    /* 7BA10 8008B210 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* 7BA14 8008B214 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 7BA18 8008B218 00000000 */  nop
    /* 7BA1C 8008B21C 6003438C */  lw         $v1, 0x360($v0)
    /* 7BA20 8008B220 DC00828C */  lw         $v0, 0xDC($a0)
    /* 7BA24 8008B224 00000000 */  nop
    /* 7BA28 8008B228 14006214 */  bne        $v1, $v0, .L8008B27C
    /* 7BA2C 8008B22C 00000000 */   nop
    /* 7BA30 8008B230 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* 7BA34 8008B234 00000000 */   nop
    /* 7BA38 8008B238 1480013C */  lui        $at, %hi(SceneLoaded)
    /* 7BA3C 8008B23C 58C720AC */  sw         $zero, %lo(SceneLoaded)($at)
    /* 7BA40 8008B240 C80280AF */  sw         $zero, %gp_rel(accidentSlice)($gp)
    /* 7BA44 8008B244 9F2C0208 */  j          .L8008B27C
    /* 7BA48 8008B248 00000000 */   nop
  .L8008B24C:
    /* 7BA4C 8008B24C 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 7BA50 8008B250 00000000 */  nop
    /* 7BA54 8008B254 6003438C */  lw         $v1, 0x360($v0)
    /* 7BA58 8008B258 D800828C */  lw         $v0, 0xD8($a0)
    /* 7BA5C 8008B25C 00000000 */  nop
    /* 7BA60 8008B260 06006214 */  bne        $v1, $v0, .L8008B27C
    /* 7BA64 8008B264 00000000 */   nop
    /* 7BA68 8008B268 F9D7020C */  jal        Scene_BuildCustomSceneList__Fv
    /* 7BA6C 8008B26C 00000000 */   nop
    /* 7BA70 8008B270 C80282AF */  sw         $v0, %gp_rel(accidentSlice)($gp)
    /* 7BA74 8008B274 1480013C */  lui        $at, %hi(SceneLoaded)
    /* 7BA78 8008B278 58C730AC */  sw         $s0, %lo(SceneLoaded)($at)
  .L8008B27C:
    /* 7BA7C 8008B27C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 7BA80 8008B280 1000B08F */  lw         $s0, 0x10($sp)
    /* 7BA84 8008B284 0800E003 */  jr         $ra
    /* 7BA88 8008B288 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cars_CheckForAccidentScenes__Fv
