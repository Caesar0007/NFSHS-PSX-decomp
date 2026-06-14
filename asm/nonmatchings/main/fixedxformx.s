.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedxformx, 0x64

glabel fixedxformx
    /* DB3AC 800EABAC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB3B0 800EABB0 1800B0AF */  sw         $s0, 0x18($sp)
    /* DB3B4 800EABB4 21808000 */  addu       $s0, $a0, $zero
    /* DB3B8 800EABB8 2120A000 */  addu       $a0, $a1, $zero
    /* DB3BC 800EABBC 1000A527 */  addiu      $a1, $sp, 0x10
    /* DB3C0 800EABC0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DB3C4 800EABC4 9CCD030C */  jal        fixedsincos
    /* DB3C8 800EABC8 1400A627 */   addiu     $a2, $sp, 0x14
    /* DB3CC 800EABCC 1400A48F */  lw         $a0, 0x14($sp)
    /* DB3D0 800EABD0 1000A38F */  lw         $v1, 0x10($sp)
    /* DB3D4 800EABD4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* DB3D8 800EABD8 000002AE */  sw         $v0, 0x0($s0)
    /* DB3DC 800EABDC 040000AE */  sw         $zero, 0x4($s0)
    /* DB3E0 800EABE0 080000AE */  sw         $zero, 0x8($s0)
    /* DB3E4 800EABE4 0C0000AE */  sw         $zero, 0xC($s0)
    /* DB3E8 800EABE8 180000AE */  sw         $zero, 0x18($s0)
    /* DB3EC 800EABEC 140003AE */  sw         $v1, 0x14($s0)
    /* DB3F0 800EABF0 23180300 */  negu       $v1, $v1
    /* DB3F4 800EABF4 100004AE */  sw         $a0, 0x10($s0)
    /* DB3F8 800EABF8 1C0003AE */  sw         $v1, 0x1C($s0)
    /* DB3FC 800EABFC 200004AE */  sw         $a0, 0x20($s0)
    /* DB400 800EAC00 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DB404 800EAC04 1800B08F */  lw         $s0, 0x18($sp)
    /* DB408 800EAC08 0800E003 */  jr         $ra
    /* DB40C 800EAC0C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel fixedxformx
