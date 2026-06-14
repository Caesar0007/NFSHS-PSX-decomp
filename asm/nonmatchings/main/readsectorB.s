.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching readsectorB, 0x54

glabel readsectorB
    /* EA954 800FA154 1480053C */  lui        $a1, %hi(Cdinfo)
    /* EA958 800FA158 C46CA424 */  addiu      $a0, $a1, %lo(Cdinfo)
    /* EA95C 800FA15C 00080224 */  addiu      $v0, $zero, 0x800
    /* EA960 800FA160 200082AC */  sw         $v0, 0x20($a0)
    /* EA964 800FA164 0A000224 */  addiu      $v0, $zero, 0xA
    /* EA968 800FA168 1C0080AC */  sw         $zero, 0x1C($a0)
    /* EA96C 800FA16C C46CA2AC */  sw         $v0, %lo(Cdinfo)($a1)
    /* EA970 800FA170 C46CA28C */  lw         $v0, %lo(Cdinfo)($a1)
    /* EA974 800FA174 3C008324 */  addiu      $v1, $a0, 0x3C
    /* EA978 800FA178 03004230 */  andi       $v0, $v0, 0x3
    /* EA97C 800FA17C 07004010 */  beqz       $v0, .L800FA19C
    /* EA980 800FA180 2C0083AC */   sw        $v1, 0x2C($a0)
    /* EA984 800FA184 2120A000 */  addu       $a0, $a1, $zero
  .L800FA188:
    /* EA988 800FA188 C46C828C */  lw         $v0, %lo(Cdinfo)($a0)
    /* EA98C 800FA18C 00000000 */  nop
    /* EA990 800FA190 03004230 */  andi       $v0, $v0, 0x3
    /* EA994 800FA194 FCFF4014 */  bnez       $v0, .L800FA188
    /* EA998 800FA198 00000000 */   nop
  .L800FA19C:
    /* EA99C 800FA19C 1480023C */  lui        $v0, %hi(D_80146D00)
    /* EA9A0 800FA1A0 0800E003 */  jr         $ra
    /* EA9A4 800FA1A4 006D4224 */   addiu     $v0, $v0, %lo(D_80146D00)
endlabel readsectorB
