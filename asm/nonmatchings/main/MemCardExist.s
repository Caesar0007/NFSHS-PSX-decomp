.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardExist, 0x68

glabel MemCardExist
    /* EB388 800FAB88 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB38C 800FAB8C 1480033C */  lui        $v1, %hi(D_80147518)
    /* EB390 800FAB90 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EB394 800FAB94 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB398 800FAB98 0000628C */  lw         $v0, 0x0($v1)
    /* EB39C 800FAB9C 00000000 */  nop
    /* EB3A0 800FABA0 0B00401C */  bgtz       $v0, .L800FABD0
    /* EB3A4 800FABA4 21288000 */   addu      $a1, $a0, $zero
    /* EB3A8 800FABA8 1080043C */  lui        $a0, %hi(MemCardExist_cb)
    /* EB3AC 800FABAC F0AB8424 */  addiu      $a0, $a0, %lo(MemCardExist_cb)
    /* EB3B0 800FABB0 01000224 */  addiu      $v0, $zero, 0x1
    /* EB3B4 800FABB4 000062AC */  sw         $v0, 0x0($v1)
    /* EB3B8 800FABB8 040060AC */  sw         $zero, 0x4($v1)
    /* EB3BC 800FABBC 080060AC */  sw         $zero, 0x8($v1)
    /* EB3C0 800FABC0 0427040C */  jal        UserFuncOpen
    /* EB3C4 800FABC4 0C0065AC */   sw        $a1, 0xC($v1)
    /* EB3C8 800FABC8 F8EA0308 */  j          .L800FABE0
    /* EB3CC 800FABCC 01000224 */   addiu     $v0, $zero, 0x1
  .L800FABD0:
    /* EB3D0 800FABD0 0580043C */  lui        $a0, %hi(D_80057370)
    /* EB3D4 800FABD4 2B0A040C */  jal        printf
    /* EB3D8 800FABD8 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
    /* EB3DC 800FABDC 21100000 */  addu       $v0, $zero, $zero
  .L800FABE0:
    /* EB3E0 800FABE0 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB3E4 800FABE4 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB3E8 800FABE8 0800E003 */  jr         $ra
    /* EB3EC 800FABEC 00000000 */   nop
endlabel MemCardExist
