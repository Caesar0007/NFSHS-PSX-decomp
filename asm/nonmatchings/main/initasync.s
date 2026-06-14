.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initasync, 0x100

glabel initasync
    /* E19B0 800F11B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E19B4 800F11B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* E19B8 800F11B8 21888000 */  addu       $s1, $a0, $zero
    /* E19BC 800F11BC 4C19828F */  lw         $v0, %gp_rel(D_8013DE98)($gp)
    /* E19C0 800F11C0 2118A000 */  addu       $v1, $a1, $zero
    /* E19C4 800F11C4 1800BFAF */  sw         $ra, 0x18($sp)
    /* E19C8 800F11C8 34004014 */  bnez       $v0, .L800F129C
    /* E19CC 800F11CC 1000B0AF */   sw        $s0, 0x10($sp)
    /* E19D0 800F11D0 0101222A */  slti       $v0, $s1, 0x101
    /* E19D4 800F11D4 31004010 */  beqz       $v0, .L800F129C
    /* E19D8 800F11D8 0580043C */   lui       $a0, %hi(D_80056F30)
    /* E19DC 800F11DC 306F8424 */  addiu      $a0, $a0, %lo(D_80056F30)
    /* E19E0 800F11E0 40801100 */  sll        $s0, $s1, 1
    /* E19E4 800F11E4 21801102 */  addu       $s0, $s0, $s1
    /* E19E8 800F11E8 80801000 */  sll        $s0, $s0, 2
    /* E19EC 800F11EC 23801102 */  subu       $s0, $s0, $s1
    /* E19F0 800F11F0 80801000 */  sll        $s0, $s0, 2
    /* E19F4 800F11F4 441983AF */  sw         $v1, %gp_rel(D_8013DE90)($gp)
    /* E19F8 800F11F8 481991AF */  sw         $s1, %gp_rel(D_8013DE94)($gp)
    /* E19FC 800F11FC CF94030C */  jal        reservememadr
    /* E1A00 800F1200 21280002 */   addu      $a1, $s0, $zero
    /* E1A04 800F1204 D4FF1026 */  addiu      $s0, $s0, -0x2C
    /* E1A08 800F1208 4C1982AF */  sw         $v0, %gp_rel(D_8013DE98)($gp)
    /* E1A0C 800F120C 541982AF */  sw         $v0, %gp_rel(D_8013DEA0)($gp)
    /* E1A10 800F1210 21105000 */  addu       $v0, $v0, $s0
    /* E1A14 800F1214 581982AF */  sw         $v0, %gp_rel(D_8013DEA4)($gp)
    /* E1A18 800F1218 5C1980AF */  sw         $zero, %gp_rel(D_8013DEA8)($gp)
    /* E1A1C 800F121C 601980AF */  sw         $zero, %gp_rel(D_8013DEAC)($gp)
    /* E1A20 800F1220 641980AF */  sw         $zero, %gp_rel(D_8013DEB0)($gp)
    /* E1A24 800F1224 09F9030C */  jal        allocmutex
    /* E1A28 800F1228 00000000 */   nop
    /* E1A2C 800F122C 701982AF */  sw         $v0, %gp_rel(D_8013DEBC)($gp)
    /* E1A30 800F1230 0D00201A */  blez       $s1, .L800F1268
    /* E1A34 800F1234 21200000 */   addu      $a0, $zero, $zero
    /* E1A38 800F1238 4C19868F */  lw         $a2, %gp_rel(D_8013DE98)($gp)
    /* E1A3C 800F123C 2C000524 */  addiu      $a1, $zero, 0x2C
    /* E1A40 800F1240 2118C000 */  addu       $v1, $a2, $zero
  .L800F1244:
    /* E1A44 800F1244 2110C500 */  addu       $v0, $a2, $a1
    /* E1A48 800F1248 2C00A524 */  addiu      $a1, $a1, 0x2C
    /* E1A4C 800F124C 000064AC */  sw         $a0, 0x0($v1)
    /* E1A50 800F1250 040062AC */  sw         $v0, 0x4($v1)
    /* E1A54 800F1254 180060AC */  sw         $zero, 0x18($v1)
    /* E1A58 800F1258 01008424 */  addiu      $a0, $a0, 0x1
    /* E1A5C 800F125C 2A109100 */  slt        $v0, $a0, $s1
    /* E1A60 800F1260 F8FF4014 */  bnez       $v0, .L800F1244
    /* E1A64 800F1264 2C006324 */   addiu     $v1, $v1, 0x2C
  .L800F1268:
    /* E1A68 800F1268 0F80043C */  lui        $a0, %hi(func_800F1120)
    /* E1A6C 800F126C 20118424 */  addiu      $a0, $a0, %lo(func_800F1120)
    /* E1A70 800F1270 01000524 */  addiu      $a1, $zero, 0x1
    /* E1A74 800F1274 2130A000 */  addu       $a2, $a1, $zero
    /* E1A78 800F1278 0410B100 */  sllv       $v0, $s1, $a1
    /* E1A7C 800F127C 21105100 */  addu       $v0, $v0, $s1
    /* E1A80 800F1280 80100200 */  sll        $v0, $v0, 2
    /* E1A84 800F1284 23105100 */  subu       $v0, $v0, $s1
    /* E1A88 800F1288 4C19838F */  lw         $v1, %gp_rel(D_8013DE98)($gp)
    /* E1A8C 800F128C 80100200 */  sll        $v0, $v0, 2
    /* E1A90 800F1290 21104300 */  addu       $v0, $v0, $v1
    /* E1A94 800F1294 BD9A030C */  jal        addsystemtask
    /* E1A98 800F1298 D8FF40AC */   sw        $zero, -0x28($v0)
  .L800F129C:
    /* E1A9C 800F129C 1800BF8F */  lw         $ra, 0x18($sp)
    /* E1AA0 800F12A0 1400B18F */  lw         $s1, 0x14($sp)
    /* E1AA4 800F12A4 1000B08F */  lw         $s0, 0x10($sp)
    /* E1AA8 800F12A8 0800E003 */  jr         $ra
    /* E1AAC 800F12AC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel initasync
