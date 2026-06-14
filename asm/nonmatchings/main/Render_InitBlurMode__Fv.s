.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_InitBlurMode__Fv, 0x68

glabel Render_InitBlurMode__Fv
    /* A4204 800B3A04 1180023C */  lui        $v0, %hi(D_80113224)
    /* A4208 800B3A08 2432438C */  lw         $v1, %lo(D_80113224)($v0)
    /* A420C 800B3A0C 20000224 */  addiu      $v0, $zero, 0x20
    /* A4210 800B3A10 0F006210 */  beq        $v1, $v0, .L800B3A50
    /* A4214 800B3A14 21006228 */   slti      $v0, $v1, 0x21
    /* A4218 800B3A18 05004010 */  beqz       $v0, .L800B3A30
    /* A421C 800B3A1C 10000224 */   addiu     $v0, $zero, 0x10
    /* A4220 800B3A20 08006210 */  beq        $v1, $v0, .L800B3A44
    /* A4224 800B3A24 0B000224 */   addiu     $v0, $zero, 0xB
    /* A4228 800B3A28 0800E003 */  jr         $ra
    /* A422C 800B3A2C 00000000 */   nop
  .L800B3A30:
    /* A4230 800B3A30 40000224 */  addiu      $v0, $zero, 0x40
    /* A4234 800B3A34 0A006210 */  beq        $v1, $v0, .L800B3A60
    /* A4238 800B3A38 1F000224 */   addiu     $v0, $zero, 0x1F
    /* A423C 800B3A3C 0800E003 */  jr         $ra
    /* A4240 800B3A40 00000000 */   nop
  .L800B3A44:
    /* A4244 800B3A44 7C0E82AF */  sw         $v0, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A4248 800B3A48 0800E003 */  jr         $ra
    /* A424C 800B3A4C 00000000 */   nop
  .L800B3A50:
    /* A4250 800B3A50 1B000224 */  addiu      $v0, $zero, 0x1B
    /* A4254 800B3A54 7C0E82AF */  sw         $v0, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A4258 800B3A58 0800E003 */  jr         $ra
    /* A425C 800B3A5C 00000000 */   nop
  .L800B3A60:
    /* A4260 800B3A60 7C0E82AF */  sw         $v0, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A4264 800B3A64 0800E003 */  jr         $ra
    /* A4268 800B3A68 00000000 */   nop
endlabel Render_InitBlurMode__Fv
