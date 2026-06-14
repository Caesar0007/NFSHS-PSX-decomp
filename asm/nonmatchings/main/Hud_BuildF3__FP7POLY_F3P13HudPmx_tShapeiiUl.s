.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl, 0xC4

glabel Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl
    /* C29C4 800D21C4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C29C8 800D21C8 1800B2AF */  sw         $s2, 0x18($sp)
    /* C29CC 800D21CC 21908000 */  addu       $s2, $a0, $zero
    /* C29D0 800D21D0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C29D4 800D21D4 2198A000 */  addu       $s3, $a1, $zero
    /* C29D8 800D21D8 1400B1AF */  sw         $s1, 0x14($sp)
    /* C29DC 800D21DC 2188C000 */  addu       $s1, $a2, $zero
    /* C29E0 800D21E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* C29E4 800D21E4 2180E000 */  addu       $s0, $a3, $zero
    /* C29E8 800D21E8 3800A28F */  lw         $v0, 0x38($sp)
    /* C29EC 800D21EC 2000BFAF */  sw         $ra, 0x20($sp)
    /* C29F0 800D21F0 7CCD030C */  jal        SetPolyF3
    /* C29F4 800D21F4 040042AE */   sw        $v0, 0x4($s2)
    /* C29F8 800D21F8 00141000 */  sll        $v0, $s0, 16
    /* C29FC 800D21FC 25105100 */  or         $v0, $v0, $s1
    /* C2A00 800D2200 080042AE */  sw         $v0, 0x8($s2)
    /* C2A04 800D2204 12006396 */  lhu        $v1, 0x12($s3)
    /* C2A08 800D2208 00000000 */  nop
    /* C2A0C 800D220C 001C0300 */  sll        $v1, $v1, 16
    /* C2A10 800D2210 03140300 */  sra        $v0, $v1, 16
    /* C2A14 800D2214 C21F0300 */  srl        $v1, $v1, 31
    /* C2A18 800D2218 21104300 */  addu       $v0, $v0, $v1
    /* C2A1C 800D221C 43100200 */  sra        $v0, $v0, 1
    /* C2A20 800D2220 23100202 */  subu       $v0, $s0, $v0
    /* C2A24 800D2224 10006386 */  lh         $v1, 0x10($s3)
    /* C2A28 800D2228 00140200 */  sll        $v0, $v0, 16
    /* C2A2C 800D222C 21182302 */  addu       $v1, $s1, $v1
    /* C2A30 800D2230 25104300 */  or         $v0, $v0, $v1
    /* C2A34 800D2234 0C0042AE */  sw         $v0, 0xC($s2)
    /* C2A38 800D2238 12006296 */  lhu        $v0, 0x12($s3)
    /* C2A3C 800D223C 00000000 */  nop
    /* C2A40 800D2240 00140200 */  sll        $v0, $v0, 16
    /* C2A44 800D2244 031C0200 */  sra        $v1, $v0, 16
    /* C2A48 800D2248 C2170200 */  srl        $v0, $v0, 31
    /* C2A4C 800D224C 21186200 */  addu       $v1, $v1, $v0
    /* C2A50 800D2250 43180300 */  sra        $v1, $v1, 1
    /* C2A54 800D2254 21800302 */  addu       $s0, $s0, $v1
    /* C2A58 800D2258 10006286 */  lh         $v0, 0x10($s3)
    /* C2A5C 800D225C 00841000 */  sll        $s0, $s0, 16
    /* C2A60 800D2260 21882202 */  addu       $s1, $s1, $v0
    /* C2A64 800D2264 25801102 */  or         $s0, $s0, $s1
    /* C2A68 800D2268 100050AE */  sw         $s0, 0x10($s2)
    /* C2A6C 800D226C 2000BF8F */  lw         $ra, 0x20($sp)
    /* C2A70 800D2270 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2A74 800D2274 1800B28F */  lw         $s2, 0x18($sp)
    /* C2A78 800D2278 1400B18F */  lw         $s1, 0x14($sp)
    /* C2A7C 800D227C 1000B08F */  lw         $s0, 0x10($sp)
    /* C2A80 800D2280 0800E003 */  jr         $ra
    /* C2A84 800D2284 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl
