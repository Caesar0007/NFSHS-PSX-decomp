.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StoreImage, 0x60

glabel StoreImage
    /* DE2F0 800EDAF0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE2F4 800EDAF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE2F8 800EDAF8 21808000 */  addu       $s0, $a0, $zero
    /* DE2FC 800EDAFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE300 800EDB00 2188A000 */  addu       $s1, $a1, $zero
    /* DE304 800EDB04 0580043C */  lui        $a0, %hi(D_80056E10)
    /* DE308 800EDB08 106E8424 */  addiu      $a0, $a0, %lo(D_80056E10)
    /* DE30C 800EDB0C 1800BFAF */  sw         $ra, 0x18($sp)
    /* DE310 800EDB10 39B6030C */  jal        _image
    /* DE314 800EDB14 21280002 */   addu      $a1, $s0, $zero
    /* DE318 800EDB18 21280002 */  addu       $a1, $s0, $zero
    /* DE31C 800EDB1C 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE320 800EDB20 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE324 800EDB24 08000624 */  addiu      $a2, $zero, 0x8
    /* DE328 800EDB28 1C00448C */  lw         $a0, 0x1C($v0)
    /* DE32C 800EDB2C 0800428C */  lw         $v0, 0x8($v0)
    /* DE330 800EDB30 00000000 */  nop
    /* DE334 800EDB34 09F84000 */  jalr       $v0
    /* DE338 800EDB38 21382002 */   addu      $a3, $s1, $zero
    /* DE33C 800EDB3C 1800BF8F */  lw         $ra, 0x18($sp)
    /* DE340 800EDB40 1400B18F */  lw         $s1, 0x14($sp)
    /* DE344 800EDB44 1000B08F */  lw         $s0, 0x10($sp)
    /* DE348 800EDB48 0800E003 */  jr         $ra
    /* DE34C 800EDB4C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel StoreImage
