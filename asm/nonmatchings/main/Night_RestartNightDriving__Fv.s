.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_RestartNightDriving__Fv, 0x88

glabel Night_RestartNightDriving__Fv
    /* CC820 800DC020 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CC824 800DC024 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CC828 800DC028 EC314424 */  addiu      $a0, $v0, %lo(GameSetup_gData)
    /* CC82C 800DC02C 1000BFAF */  sw         $ra, 0x10($sp)
    /* CC830 800DC030 4800838C */  lw         $v1, 0x48($a0)
    /* CC834 800DC034 01000224 */  addiu      $v0, $zero, 0x1
    /* CC838 800DC038 17006214 */  bne        $v1, $v0, .L800DC098
    /* CC83C 800DC03C 00000000 */   nop
    /* CC840 800DC040 5400828C */  lw         $v0, 0x54($a0)
    /* CC844 800DC044 00000000 */  nop
    /* CC848 800DC048 13004010 */  beqz       $v0, .L800DC098
    /* CC84C 800DC04C 00000000 */   nop
    /* CC850 800DC050 181580AF */  sw         $zero, %gp_rel(Night_gLightning)($gp)
    /* CC854 800DC054 EA9D030C */  jal        random
    /* CC858 800DC058 00000000 */   nop
    /* CC85C 800DC05C 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* CC860 800DC060 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* CC864 800DC064 FF014230 */  andi       $v0, $v0, 0x1FF
    /* CC868 800DC068 21186200 */  addu       $v1, $v1, $v0
    /* CC86C 800DC06C 1C1583AF */  sw         $v1, %gp_rel(Night_gNextLightning)($gp)
    /* CC870 800DC070 EA9D030C */  jal        random
    /* CC874 800DC074 00000000 */   nop
    /* CC878 800DC078 31004230 */  andi       $v0, $v0, 0x31
    /* CC87C 800DC07C 1C15838F */  lw         $v1, %gp_rel(Night_gNextLightning)($gp)
    /* CC880 800DC080 00000000 */  nop
    /* CC884 800DC084 21106200 */  addu       $v0, $v1, $v0
    /* CC888 800DC088 201582AF */  sw         $v0, %gp_rel(Night_gEndNextLightning)($gp)
    /* CC88C 800DC08C 241583AF */  sw         $v1, %gp_rel(Night_gNextFlicker)($gp)
    /* CC890 800DC090 D841030C */  jal        Hrz_LightningFlicker__Fi
    /* CC894 800DC094 21200000 */   addu      $a0, $zero, $zero
  .L800DC098:
    /* CC898 800DC098 1000BF8F */  lw         $ra, 0x10($sp)
    /* CC89C 800DC09C 00000000 */  nop
    /* CC8A0 800DC0A0 0800E003 */  jr         $ra
    /* CC8A4 800DC0A4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_RestartNightDriving__Fv
