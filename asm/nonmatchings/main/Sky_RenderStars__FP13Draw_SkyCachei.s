.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Sky_RenderStars__FP13Draw_SkyCachei, 0x1BC

glabel Sky_RenderStars__FP13Draw_SkyCachei
    /* C1960 800D1160 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* C1964 800D1164 4800B2AF */  sw         $s2, 0x48($sp)
    /* C1968 800D1168 21908000 */  addu       $s2, $a0, $zero
    /* C196C 800D116C 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* C1970 800D1170 2198A000 */  addu       $s3, $a1, $zero
    /* C1974 800D1174 4400B1AF */  sw         $s1, 0x44($sp)
    /* C1978 800D1178 78001124 */  addiu      $s1, $zero, 0x78
    /* C197C 800D117C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* C1980 800D1180 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* C1984 800D1184 01000224 */  addiu      $v0, $zero, 0x1
    /* C1988 800D1188 5000BFAF */  sw         $ra, 0x50($sp)
    /* C198C 800D118C 02006214 */  bne        $v1, $v0, .L800D1198
    /* C1990 800D1190 4000B0AF */   sw        $s0, 0x40($sp)
    /* C1994 800D1194 3C001124 */  addiu      $s1, $zero, 0x3C
  .L800D1198:
    /* C1998 800D1198 1000A427 */  addiu      $a0, $sp, 0x10
    /* C199C 800D119C 21280000 */  addu       $a1, $zero, $zero
    /* C19A0 800D11A0 2C13908F */  lw         $s0, %gp_rel(D_8013D878)($gp)
    /* C19A4 800D11A4 C690030C */  jal        memset
    /* C19A8 800D11A8 0C000624 */   addiu     $a2, $zero, 0xC
    /* C19AC 800D11AC 4742030C */  jal        HrzSetPsxTranslation__FP8coorddef
    /* C19B0 800D11B0 1000A427 */   addiu     $a0, $sp, 0x10
    /* C19B4 800D11B4 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C19B8 800D11B8 00000000 */  nop
    /* C19BC 800D11BC 4400428C */  lw         $v0, 0x44($v0)
    /* C19C0 800D11C0 00000000 */  nop
    /* C19C4 800D11C4 4E004018 */  blez       $v0, .L800D1300
    /* C19C8 800D11C8 21300000 */   addu      $a2, $zero, $zero
    /* C19CC 800D11CC 801F083C */  lui        $t0, (0x1F800004 >> 16)
    /* C19D0 800D11D0 04000835 */  ori        $t0, $t0, (0x1F800004 & 0xFFFF)
    /* C19D4 800D11D4 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* C19D8 800D11D8 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* C19DC 800D11DC 00FF093C */  lui        $t1, (0xFF000000 >> 16)
  .L800D11E0:
    /* C19E0 800D11E0 000000CA */  lwc2       $0, 0x0($s0)
    /* C19E4 800D11E4 040001CA */  lwc2       $1, 0x4($s0)
    /* C19E8 800D11E8 00000000 */  nop
    /* C19EC 800D11EC 00000000 */  nop
    /* C19F0 800D11F0 0100184A */  .word 0x4A180001  /* rtps */
    /* C19F4 800D11F4 08001026 */  addiu      $s0, $s0, 0x8
    /* C19F8 800D11F8 3800A227 */  addiu      $v0, $sp, 0x38
    /* C19FC 800D11FC 000053E8 */  swc2       $19, 0x0($v0)
    /* C1A00 800D1200 3800A28F */  lw         $v0, 0x38($sp)
    /* C1A04 800D1204 00000000 */  nop
    /* C1A08 800D1208 36004018 */  blez       $v0, .L800D12E4
    /* C1A0C 800D120C 2000A227 */   addiu     $v0, $sp, 0x20
    /* C1A10 800D1210 00004EE8 */  swc2       $14, 0x0($v0)
    /* C1A14 800D1214 2800A227 */  addiu      $v0, $sp, 0x28
    /* C1A18 800D1218 000059E8 */  swc2       $25, 0x0($v0)
    /* C1A1C 800D121C 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* C1A20 800D1220 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* C1A24 800D1224 2C00A28F */  lw         $v0, 0x2C($sp)
    /* C1A28 800D1228 2000A487 */  lh         $a0, 0x20($sp)
    /* C1A2C 800D122C 83100200 */  sra        $v0, $v0, 2
    /* C1A30 800D1230 21185100 */  addu       $v1, $v0, $s1
    /* C1A34 800D1234 2200A3A7 */  sh         $v1, 0x22($sp)
    /* C1A38 800D1238 10004286 */  lh         $v0, 0x10($s2)
    /* C1A3C 800D123C 00000000 */  nop
    /* C1A40 800D1240 2A104400 */  slt        $v0, $v0, $a0
    /* C1A44 800D1244 27004014 */  bnez       $v0, .L800D12E4
    /* C1A48 800D1248 00000000 */   nop
    /* C1A4C 800D124C 25008004 */  bltz       $a0, .L800D12E4
    /* C1A50 800D1250 001C0300 */   sll       $v1, $v1, 16
    /* C1A54 800D1254 12004286 */  lh         $v0, 0x12($s2)
    /* C1A58 800D1258 031C0300 */  sra        $v1, $v1, 16
    /* C1A5C 800D125C 2A104300 */  slt        $v0, $v0, $v1
    /* C1A60 800D1260 20004014 */  bnez       $v0, .L800D12E4
    /* C1A64 800D1264 00000000 */   nop
    /* C1A68 800D1268 1E006004 */  bltz       $v1, .L800D12E4
    /* C1A6C 800D126C 80281300 */   sll       $a1, $s3, 2
    /* C1A70 800D1270 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* C1A74 800D1274 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* C1A78 800D1278 0000048D */  lw         $a0, 0x0($t0)
    /* C1A7C 800D127C 2128A200 */  addu       $a1, $a1, $v0
    /* C1A80 800D1280 0000838C */  lw         $v1, 0x0($a0)
    /* C1A84 800D1284 0000A28C */  lw         $v0, 0x0($a1)
    /* C1A88 800D1288 24186900 */  and        $v1, $v1, $t1
    /* C1A8C 800D128C 24104700 */  and        $v0, $v0, $a3
    /* C1A90 800D1290 25186200 */  or         $v1, $v1, $v0
    /* C1A94 800D1294 000083AC */  sw         $v1, 0x0($a0)
    /* C1A98 800D1298 0000A38C */  lw         $v1, 0x0($a1)
    /* C1A9C 800D129C 0C008224 */  addiu      $v0, $a0, 0xC
    /* C1AA0 800D12A0 000002AD */  sw         $v0, 0x0($t0)
    /* C1AA4 800D12A4 24108700 */  and        $v0, $a0, $a3
    /* C1AA8 800D12A8 24186900 */  and        $v1, $v1, $t1
    /* C1AAC 800D12AC 25186200 */  or         $v1, $v1, $v0
    /* C1AB0 800D12B0 0000A3AC */  sw         $v1, 0x0($a1)
    /* C1AB4 800D12B4 3013838F */  lw         $v1, %gp_rel(D_8013D87C)($gp)
    /* C1AB8 800D12B8 80100600 */  sll        $v0, $a2, 2
    /* C1ABC 800D12BC 21104300 */  addu       $v0, $v0, $v1
    /* C1AC0 800D12C0 0000438C */  lw         $v1, 0x0($v0)
    /* C1AC4 800D12C4 02000224 */  addiu      $v0, $zero, 0x2
    /* C1AC8 800D12C8 030082A0 */  sb         $v0, 0x3($a0)
    /* C1ACC 800D12CC 68000224 */  addiu      $v0, $zero, 0x68
    /* C1AD0 800D12D0 040083AC */  sw         $v1, 0x4($a0)
    /* C1AD4 800D12D4 070082A0 */  sb         $v0, 0x7($a0)
    /* C1AD8 800D12D8 2000A28F */  lw         $v0, 0x20($sp)
    /* C1ADC 800D12DC 00000000 */  nop
    /* C1AE0 800D12E0 080082AC */  sw         $v0, 0x8($a0)
  .L800D12E4:
    /* C1AE4 800D12E4 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C1AE8 800D12E8 00000000 */  nop
    /* C1AEC 800D12EC 4400428C */  lw         $v0, 0x44($v0)
    /* C1AF0 800D12F0 0100C624 */  addiu      $a2, $a2, 0x1
    /* C1AF4 800D12F4 2A10C200 */  slt        $v0, $a2, $v0
    /* C1AF8 800D12F8 B9FF4014 */  bnez       $v0, .L800D11E0
    /* C1AFC 800D12FC 00000000 */   nop
  .L800D1300:
    /* C1B00 800D1300 5000BF8F */  lw         $ra, 0x50($sp)
    /* C1B04 800D1304 4C00B38F */  lw         $s3, 0x4C($sp)
    /* C1B08 800D1308 4800B28F */  lw         $s2, 0x48($sp)
    /* C1B0C 800D130C 4400B18F */  lw         $s1, 0x44($sp)
    /* C1B10 800D1310 4000B08F */  lw         $s0, 0x40($sp)
    /* C1B14 800D1314 0800E003 */  jr         $ra
    /* C1B18 800D1318 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Sky_RenderStars__FP13Draw_SkyCachei
