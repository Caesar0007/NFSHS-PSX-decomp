.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearImage, 0x90

glabel ClearImage
    /* DE200 800EDA00 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DE204 800EDA04 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DE208 800EDA08 21988000 */  addu       $s3, $a0, $zero
    /* DE20C 800EDA0C 0580043C */  lui        $a0, %hi(D_80056DEC)
    /* DE210 800EDA10 EC6D8424 */  addiu      $a0, $a0, %lo(D_80056DEC)
    /* DE214 800EDA14 1800B2AF */  sw         $s2, 0x18($sp)
    /* DE218 800EDA18 2190A000 */  addu       $s2, $a1, $zero
    /* DE21C 800EDA1C 21286002 */  addu       $a1, $s3, $zero
    /* DE220 800EDA20 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE224 800EDA24 2188C000 */  addu       $s1, $a2, $zero
    /* DE228 800EDA28 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE22C 800EDA2C 2000BFAF */  sw         $ra, 0x20($sp)
    /* DE230 800EDA30 39B6030C */  jal        _image
    /* DE234 800EDA34 2180E000 */   addu      $s0, $a3, $zero
    /* DE238 800EDA38 21286002 */  addu       $a1, $s3, $zero
    /* DE23C 800EDA3C FF001032 */  andi       $s0, $s0, 0xFF
    /* DE240 800EDA40 00841000 */  sll        $s0, $s0, 16
    /* DE244 800EDA44 FF003132 */  andi       $s1, $s1, 0xFF
    /* DE248 800EDA48 008A1100 */  sll        $s1, $s1, 8
    /* DE24C 800EDA4C 25801102 */  or         $s0, $s0, $s1
    /* DE250 800EDA50 FF005232 */  andi       $s2, $s2, 0xFF
    /* DE254 800EDA54 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE258 800EDA58 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE25C 800EDA5C 08000624 */  addiu      $a2, $zero, 0x8
    /* DE260 800EDA60 0C00448C */  lw         $a0, 0xC($v0)
    /* DE264 800EDA64 0800428C */  lw         $v0, 0x8($v0)
    /* DE268 800EDA68 00000000 */  nop
    /* DE26C 800EDA6C 09F84000 */  jalr       $v0
    /* DE270 800EDA70 25381202 */   or        $a3, $s0, $s2
    /* DE274 800EDA74 2000BF8F */  lw         $ra, 0x20($sp)
    /* DE278 800EDA78 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DE27C 800EDA7C 1800B28F */  lw         $s2, 0x18($sp)
    /* DE280 800EDA80 1400B18F */  lw         $s1, 0x14($sp)
    /* DE284 800EDA84 1000B08F */  lw         $s0, 0x10($sp)
    /* DE288 800EDA88 0800E003 */  jr         $ra
    /* DE28C 800EDA8C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ClearImage
