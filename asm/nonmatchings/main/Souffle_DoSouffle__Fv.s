.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_DoSouffle__Fv, 0x49C

glabel Souffle_DoSouffle__Fv
    /* A80EC 800B78EC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A80F0 800B78F0 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* A80F4 800B78F4 040F828F */  lw         $v0, %gp_rel(gTMoveSouffle)($gp)
    /* A80F8 800B78F8 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* A80FC 800B78FC 5000BFAF */  sw         $ra, 0x50($sp)
    /* A8100 800B7900 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* A8104 800B7904 4800B2AF */  sw         $s2, 0x48($sp)
    /* A8108 800B7908 4400B1AF */  sw         $s1, 0x44($sp)
    /* A810C 800B790C 23106200 */  subu       $v0, $v1, $v0
    /* A8110 800B7910 16014018 */  blez       $v0, .L800B7D6C
    /* A8114 800B7914 4000B0AF */   sw        $s0, 0x40($sp)
    /* A8118 800B7918 000F828F */  lw         $v0, %gp_rel(gCISouffle)($gp)
    /* A811C 800B791C 040F83AF */  sw         $v1, %gp_rel(gTMoveSouffle)($gp)
    /* A8120 800B7920 12004010 */  beqz       $v0, .L800B796C
    /* A8124 800B7924 21880000 */   addu      $s1, $zero, $zero
    /* A8128 800B7928 080F848F */  lw         $a0, %gp_rel(gWindDir)($gp)
    /* A812C 800B792C 00000000 */  nop
    /* A8130 800B7930 02008424 */  addiu      $a0, $a0, 0x2
    /* A8134 800B7934 080F84AF */  sw         $a0, %gp_rel(gWindDir)($gp)
    /* A8138 800B7938 39C6030C */  jal        intcos
    /* A813C 800B793C 00000000 */   nop
    /* A8140 800B7940 21204000 */  addu       $a0, $v0, $zero
    /* A8144 800B7944 CA90030C */  jal        fixedmult
    /* A8148 800B7948 CC0C0524 */   addiu     $a1, $zero, 0xCCC
    /* A814C 800B794C 080F848F */  lw         $a0, %gp_rel(gWindDir)($gp)
    /* A8150 800B7950 3AC6030C */  jal        intsin
    /* A8154 800B7954 1000A2AF */   sw        $v0, 0x10($sp)
    /* A8158 800B7958 21204000 */  addu       $a0, $v0, $zero
    /* A815C 800B795C CA90030C */  jal        fixedmult
    /* A8160 800B7960 CC0C0524 */   addiu     $a1, $zero, 0xCCC
    /* A8164 800B7964 1800A2AF */  sw         $v0, 0x18($sp)
    /* A8168 800B7968 1400A0AF */  sw         $zero, 0x14($sp)
  .L800B796C:
    /* A816C 800B796C 1180023C */  lui        $v0, %hi(Replay_ReplayInterface)
    /* A8170 800B7970 2C705324 */  addiu      $s3, $v0, %lo(Replay_ReplayInterface)
    /* A8174 800B7974 21902002 */  addu       $s2, $s1, $zero
  .L800B7978:
    /* A8178 800B7978 000F828F */  lw         $v0, %gp_rel(gCISouffle)($gp)
    /* A817C 800B797C 00000000 */  nop
    /* A8180 800B7980 2A102202 */  slt        $v0, $s1, $v0
    /* A8184 800B7984 CF004010 */  beqz       $v0, .L800B7CC4
    /* A8188 800B7988 00000000 */   nop
    /* A818C 800B798C FC0E828F */  lw         $v0, %gp_rel(gISouffle)($gp)
    /* A8190 800B7990 00000000 */  nop
    /* A8194 800B7994 21805200 */  addu       $s0, $v0, $s2
    /* A8198 800B7998 1800088E */  lw         $t0, 0x18($s0)
    /* A819C 800B799C 1C00098E */  lw         $t1, 0x1C($s0)
    /* A81A0 800B79A0 20000A8E */  lw         $t2, 0x20($s0)
    /* A81A4 800B79A4 2000A8AF */  sw         $t0, 0x20($sp)
    /* A81A8 800B79A8 2400A9AF */  sw         $t1, 0x24($sp)
    /* A81AC 800B79AC 2800AAAF */  sw         $t2, 0x28($sp)
    /* A81B0 800B79B0 02000292 */  lbu        $v0, 0x2($s0)
    /* A81B4 800B79B4 00000000 */  nop
    /* A81B8 800B79B8 0D004010 */  beqz       $v0, .L800B79F0
    /* A81BC 800B79BC 00000000 */   nop
    /* A81C0 800B79C0 2000A28F */  lw         $v0, 0x20($sp)
    /* A81C4 800B79C4 1000A38F */  lw         $v1, 0x10($sp)
    /* A81C8 800B79C8 1400A48F */  lw         $a0, 0x14($sp)
    /* A81CC 800B79CC 1800A58F */  lw         $a1, 0x18($sp)
    /* A81D0 800B79D0 21104300 */  addu       $v0, $v0, $v1
    /* A81D4 800B79D4 2000A2AF */  sw         $v0, 0x20($sp)
    /* A81D8 800B79D8 2400A28F */  lw         $v0, 0x24($sp)
    /* A81DC 800B79DC 2800A38F */  lw         $v1, 0x28($sp)
    /* A81E0 800B79E0 21104400 */  addu       $v0, $v0, $a0
    /* A81E4 800B79E4 21186500 */  addu       $v1, $v1, $a1
    /* A81E8 800B79E8 2400A2AF */  sw         $v0, 0x24($sp)
    /* A81EC 800B79EC 2800A3AF */  sw         $v1, 0x28($sp)
  .L800B79F0:
    /* A81F0 800B79F0 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A81F4 800B79F4 F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A81F8 800B79F8 02000224 */  addiu      $v0, $zero, 0x2
    /* A81FC 800B79FC 1A006214 */  bne        $v1, $v0, .L800B7A68
    /* A8200 800B7A00 00000000 */   nop
    /* A8204 800B7A04 0400628E */  lw         $v0, 0x4($s3)
    /* A8208 800B7A08 00000000 */  nop
    /* A820C 800B7A0C 23206200 */  subu       $a0, $v1, $v0
    /* A8210 800B7A10 0A008018 */  blez       $a0, .L800B7A3C
    /* A8214 800B7A14 00000000 */   nop
    /* A8218 800B7A18 2000A28F */  lw         $v0, 0x20($sp)
    /* A821C 800B7A1C 2800A38F */  lw         $v1, 0x28($sp)
    /* A8220 800B7A20 07108200 */  srav       $v0, $v0, $a0
    /* A8224 800B7A24 2000A2AF */  sw         $v0, 0x20($sp)
    /* A8228 800B7A28 2400A28F */  lw         $v0, 0x24($sp)
    /* A822C 800B7A2C 07188300 */  srav       $v1, $v1, $a0
    /* A8230 800B7A30 2800A3AF */  sw         $v1, 0x28($sp)
    /* A8234 800B7A34 07108200 */  srav       $v0, $v0, $a0
    /* A8238 800B7A38 2400A2AF */  sw         $v0, 0x24($sp)
  .L800B7A3C:
    /* A823C 800B7A3C 0A008104 */  bgez       $a0, .L800B7A68
    /* A8240 800B7A40 00000000 */   nop
    /* A8244 800B7A44 2000A28F */  lw         $v0, 0x20($sp)
    /* A8248 800B7A48 2800A38F */  lw         $v1, 0x28($sp)
    /* A824C 800B7A4C 40100200 */  sll        $v0, $v0, 1
    /* A8250 800B7A50 2000A2AF */  sw         $v0, 0x20($sp)
    /* A8254 800B7A54 2400A28F */  lw         $v0, 0x24($sp)
    /* A8258 800B7A58 40180300 */  sll        $v1, $v1, 1
    /* A825C 800B7A5C 2800A3AF */  sw         $v1, 0x28($sp)
    /* A8260 800B7A60 40100200 */  sll        $v0, $v0, 1
    /* A8264 800B7A64 2400A2AF */  sw         $v0, 0x24($sp)
  .L800B7A68:
    /* A8268 800B7A68 0C00028E */  lw         $v0, 0xC($s0)
    /* A826C 800B7A6C 2000A38F */  lw         $v1, 0x20($sp)
    /* A8270 800B7A70 00000000 */  nop
    /* A8274 800B7A74 21104300 */  addu       $v0, $v0, $v1
    /* A8278 800B7A78 0C0002AE */  sw         $v0, 0xC($s0)
    /* A827C 800B7A7C 1000028E */  lw         $v0, 0x10($s0)
    /* A8280 800B7A80 2400A38F */  lw         $v1, 0x24($sp)
    /* A8284 800B7A84 00000000 */  nop
    /* A8288 800B7A88 21104300 */  addu       $v0, $v0, $v1
    /* A828C 800B7A8C 100002AE */  sw         $v0, 0x10($s0)
    /* A8290 800B7A90 1400028E */  lw         $v0, 0x14($s0)
    /* A8294 800B7A94 2800A38F */  lw         $v1, 0x28($sp)
    /* A8298 800B7A98 1800048E */  lw         $a0, 0x18($s0)
    /* A829C 800B7A9C 21104300 */  addu       $v0, $v0, $v1
    /* A82A0 800B7AA0 06008104 */  bgez       $a0, .L800B7ABC
    /* A82A4 800B7AA4 140002AE */   sw        $v0, 0x14($s0)
    /* A82A8 800B7AA8 3D0A8224 */  addiu      $v0, $a0, 0xA3D
    /* A82AC 800B7AAC 08004018 */  blez       $v0, .L800B7AD0
    /* A82B0 800B7AB0 180002AE */   sw        $v0, 0x18($s0)
    /* A82B4 800B7AB4 B4DE0208 */  j          .L800B7AD0
    /* A82B8 800B7AB8 180000AE */   sw        $zero, 0x18($s0)
  .L800B7ABC:
    /* A82BC 800B7ABC 04008018 */  blez       $a0, .L800B7AD0
    /* A82C0 800B7AC0 C3F58224 */   addiu     $v0, $a0, -0xA3D
    /* A82C4 800B7AC4 02004104 */  bgez       $v0, .L800B7AD0
    /* A82C8 800B7AC8 180002AE */   sw        $v0, 0x18($s0)
    /* A82CC 800B7ACC 180000AE */  sw         $zero, 0x18($s0)
  .L800B7AD0:
    /* A82D0 800B7AD0 2000028E */  lw         $v0, 0x20($s0)
    /* A82D4 800B7AD4 00000000 */  nop
    /* A82D8 800B7AD8 06004104 */  bgez       $v0, .L800B7AF4
    /* A82DC 800B7ADC 00000000 */   nop
    /* A82E0 800B7AE0 3D0A4224 */  addiu      $v0, $v0, 0xA3D
    /* A82E4 800B7AE4 08004018 */  blez       $v0, .L800B7B08
    /* A82E8 800B7AE8 200002AE */   sw        $v0, 0x20($s0)
    /* A82EC 800B7AEC C2DE0208 */  j          .L800B7B08
    /* A82F0 800B7AF0 200000AE */   sw        $zero, 0x20($s0)
  .L800B7AF4:
    /* A82F4 800B7AF4 04004018 */  blez       $v0, .L800B7B08
    /* A82F8 800B7AF8 C3F54224 */   addiu     $v0, $v0, -0xA3D
    /* A82FC 800B7AFC 02004104 */  bgez       $v0, .L800B7B08
    /* A8300 800B7B00 200002AE */   sw        $v0, 0x20($s0)
    /* A8304 800B7B04 200000AE */  sw         $zero, 0x20($s0)
  .L800B7B08:
    /* A8308 800B7B08 00000392 */  lbu        $v1, 0x0($s0)
    /* A830C 800B7B0C 0D000224 */  addiu      $v0, $zero, 0xD
    /* A8310 800B7B10 5F006214 */  bne        $v1, $v0, .L800B7C90
    /* A8314 800B7B14 00000000 */   nop
    /* A8318 800B7B18 2400088E */  lw         $t0, 0x24($s0)
    /* A831C 800B7B1C 2800098E */  lw         $t1, 0x28($s0)
    /* A8320 800B7B20 2C000A8E */  lw         $t2, 0x2C($s0)
    /* A8324 800B7B24 3000A8AF */  sw         $t0, 0x30($sp)
    /* A8328 800B7B28 3400A9AF */  sw         $t1, 0x34($sp)
    /* A832C 800B7B2C 3800AAAF */  sw         $t2, 0x38($sp)
    /* A8330 800B7B30 0800048E */  lw         $a0, 0x8($s0)
    /* A8334 800B7B34 3AC6030C */  jal        intsin
    /* A8338 800B7B38 00000000 */   nop
    /* A833C 800B7B3C 21284000 */  addu       $a1, $v0, $zero
    /* A8340 800B7B40 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A8344 800B7B44 F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A8348 800B7B48 02000224 */  addiu      $v0, $zero, 0x2
    /* A834C 800B7B4C 1A006214 */  bne        $v1, $v0, .L800B7BB8
    /* A8350 800B7B50 00000000 */   nop
    /* A8354 800B7B54 0400628E */  lw         $v0, 0x4($s3)
    /* A8358 800B7B58 00000000 */  nop
    /* A835C 800B7B5C 23206200 */  subu       $a0, $v1, $v0
    /* A8360 800B7B60 0A008018 */  blez       $a0, .L800B7B8C
    /* A8364 800B7B64 00000000 */   nop
    /* A8368 800B7B68 3000A28F */  lw         $v0, 0x30($sp)
    /* A836C 800B7B6C 3800A38F */  lw         $v1, 0x38($sp)
    /* A8370 800B7B70 07108200 */  srav       $v0, $v0, $a0
    /* A8374 800B7B74 3000A2AF */  sw         $v0, 0x30($sp)
    /* A8378 800B7B78 3400A28F */  lw         $v0, 0x34($sp)
    /* A837C 800B7B7C 07188300 */  srav       $v1, $v1, $a0
    /* A8380 800B7B80 3800A3AF */  sw         $v1, 0x38($sp)
    /* A8384 800B7B84 07108200 */  srav       $v0, $v0, $a0
    /* A8388 800B7B88 3400A2AF */  sw         $v0, 0x34($sp)
  .L800B7B8C:
    /* A838C 800B7B8C 0A008104 */  bgez       $a0, .L800B7BB8
    /* A8390 800B7B90 00000000 */   nop
    /* A8394 800B7B94 3000A28F */  lw         $v0, 0x30($sp)
    /* A8398 800B7B98 3800A38F */  lw         $v1, 0x38($sp)
    /* A839C 800B7B9C 40100200 */  sll        $v0, $v0, 1
    /* A83A0 800B7BA0 3000A2AF */  sw         $v0, 0x30($sp)
    /* A83A4 800B7BA4 3400A28F */  lw         $v0, 0x34($sp)
    /* A83A8 800B7BA8 40180300 */  sll        $v1, $v1, 1
    /* A83AC 800B7BAC 3800A3AF */  sw         $v1, 0x38($sp)
    /* A83B0 800B7BB0 40100200 */  sll        $v0, $v0, 1
    /* A83B4 800B7BB4 3400A2AF */  sw         $v0, 0x34($sp)
  .L800B7BB8:
    /* A83B8 800B7BB8 3000A28F */  lw         $v0, 0x30($sp)
    /* A83BC 800B7BBC 00000000 */  nop
    /* A83C0 800B7BC0 18004500 */  mult       $v0, $a1
    /* A83C4 800B7BC4 0C00028E */  lw         $v0, 0xC($s0)
    /* A83C8 800B7BC8 12400000 */  mflo       $t0
    /* A83CC 800B7BCC 431C0800 */  sra        $v1, $t0, 17
    /* A83D0 800B7BD0 21104300 */  addu       $v0, $v0, $v1
    /* A83D4 800B7BD4 0C0002AE */  sw         $v0, 0xC($s0)
    /* A83D8 800B7BD8 3800A28F */  lw         $v0, 0x38($sp)
    /* A83DC 800B7BDC 00000000 */  nop
    /* A83E0 800B7BE0 18004500 */  mult       $v0, $a1
    /* A83E4 800B7BE4 2400048E */  lw         $a0, 0x24($s0)
    /* A83E8 800B7BE8 1400028E */  lw         $v0, 0x14($s0)
    /* A83EC 800B7BEC 12400000 */  mflo       $t0
    /* A83F0 800B7BF0 431C0800 */  sra        $v1, $t0, 17
    /* A83F4 800B7BF4 21104300 */  addu       $v0, $v0, $v1
    /* A83F8 800B7BF8 06008104 */  bgez       $a0, .L800B7C14
    /* A83FC 800B7BFC 140002AE */   sw        $v0, 0x14($s0)
    /* A8400 800B7C00 47018224 */  addiu      $v0, $a0, 0x147
    /* A8404 800B7C04 08004018 */  blez       $v0, .L800B7C28
    /* A8408 800B7C08 240002AE */   sw        $v0, 0x24($s0)
    /* A840C 800B7C0C 0ADF0208 */  j          .L800B7C28
    /* A8410 800B7C10 240000AE */   sw        $zero, 0x24($s0)
  .L800B7C14:
    /* A8414 800B7C14 04008018 */  blez       $a0, .L800B7C28
    /* A8418 800B7C18 B9FE8224 */   addiu     $v0, $a0, -0x147
    /* A841C 800B7C1C 02004104 */  bgez       $v0, .L800B7C28
    /* A8420 800B7C20 240002AE */   sw        $v0, 0x24($s0)
    /* A8424 800B7C24 240000AE */  sw         $zero, 0x24($s0)
  .L800B7C28:
    /* A8428 800B7C28 2C00028E */  lw         $v0, 0x2C($s0)
    /* A842C 800B7C2C 00000000 */  nop
    /* A8430 800B7C30 06004104 */  bgez       $v0, .L800B7C4C
    /* A8434 800B7C34 00000000 */   nop
    /* A8438 800B7C38 47014224 */  addiu      $v0, $v0, 0x147
    /* A843C 800B7C3C 08004018 */  blez       $v0, .L800B7C60
    /* A8440 800B7C40 2C0002AE */   sw        $v0, 0x2C($s0)
    /* A8444 800B7C44 18DF0208 */  j          .L800B7C60
    /* A8448 800B7C48 2C0000AE */   sw        $zero, 0x2C($s0)
  .L800B7C4C:
    /* A844C 800B7C4C 04004018 */  blez       $v0, .L800B7C60
    /* A8450 800B7C50 B9FE4224 */   addiu     $v0, $v0, -0x147
    /* A8454 800B7C54 02004104 */  bgez       $v0, .L800B7C60
    /* A8458 800B7C58 2C0002AE */   sw        $v0, 0x2C($s0)
    /* A845C 800B7C5C 2C0000AE */  sw         $zero, 0x2C($s0)
  .L800B7C60:
    /* A8460 800B7C60 1000038E */  lw         $v1, 0x10($s0)
    /* A8464 800B7C64 3C00028E */  lw         $v0, 0x3C($s0)
    /* A8468 800B7C68 00000000 */  nop
    /* A846C 800B7C6C 2A104300 */  slt        $v0, $v0, $v1
    /* A8470 800B7C70 03004014 */  bnez       $v0, .L800B7C80
    /* A8474 800B7C74 00000000 */   nop
    /* A8478 800B7C78 24DF0208 */  j          .L800B7C90
    /* A847C 800B7C7C 000000A2 */   sb        $zero, 0x0($s0)
  .L800B7C80:
    /* A8480 800B7C80 1C00028E */  lw         $v0, 0x1C($s0)
    /* A8484 800B7C84 00000000 */  nop
    /* A8488 800B7C88 B9FE4224 */  addiu      $v0, $v0, -0x147
    /* A848C 800B7C8C 1C0002AE */  sw         $v0, 0x1C($s0)
  .L800B7C90:
    /* A8490 800B7C90 B3DD020C */  jal        MoveAngleWind__FP17Souffle_tISouffle
    /* A8494 800B7C94 21200002 */   addu      $a0, $s0, $zero
    /* A8498 800B7C98 03000292 */  lbu        $v0, 0x3($s0)
    /* A849C 800B7C9C 00000000 */  nop
    /* A84A0 800B7CA0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A84A4 800B7CA4 030002A2 */  sb         $v0, 0x3($s0)
    /* A84A8 800B7CA8 FF004230 */  andi       $v0, $v0, 0xFF
    /* A84AC 800B7CAC 02004014 */  bnez       $v0, .L800B7CB8
    /* A84B0 800B7CB0 00000000 */   nop
    /* A84B4 800B7CB4 000000A2 */  sb         $zero, 0x0($s0)
  .L800B7CB8:
    /* A84B8 800B7CB8 44005226 */  addiu      $s2, $s2, 0x44
    /* A84BC 800B7CBC 5EDE0208 */  j          .L800B7978
    /* A84C0 800B7CC0 01003126 */   addiu     $s1, $s1, 0x1
  .L800B7CC4:
    /* A84C4 800B7CC4 000F848F */  lw         $a0, %gp_rel(gCISouffle)($gp)
    /* A84C8 800B7CC8 00000000 */  nop
    /* A84CC 800B7CCC 27008018 */  blez       $a0, .L800B7D6C
    /* A84D0 800B7CD0 21880000 */   addu      $s1, $zero, $zero
    /* A84D4 800B7CD4 21382002 */  addu       $a3, $s1, $zero
  .L800B7CD8:
    /* A84D8 800B7CD8 FC0E868F */  lw         $a2, %gp_rel(gISouffle)($gp)
    /* A84DC 800B7CDC 00000000 */  nop
    /* A84E0 800B7CE0 2118E600 */  addu       $v1, $a3, $a2
    /* A84E4 800B7CE4 00006290 */  lbu        $v0, 0x0($v1)
    /* A84E8 800B7CE8 00000000 */  nop
    /* A84EC 800B7CEC 1A004014 */  bnez       $v0, .L800B7D58
    /* A84F0 800B7CF0 21286000 */   addu      $a1, $v1, $zero
    /* A84F4 800B7CF4 00110400 */  sll        $v0, $a0, 4
    /* A84F8 800B7CF8 21104400 */  addu       $v0, $v0, $a0
    /* A84FC 800B7CFC 80100200 */  sll        $v0, $v0, 2
    /* A8500 800B7D00 21104600 */  addu       $v0, $v0, $a2
    /* A8504 800B7D04 BCFF4324 */  addiu      $v1, $v0, -0x44
    /* A8508 800B7D08 FCFF4224 */  addiu      $v0, $v0, -0x4
  .L800B7D0C:
    /* A850C 800B7D0C 0000698C */  lw         $t1, 0x0($v1)
    /* A8510 800B7D10 04006A8C */  lw         $t2, 0x4($v1)
    /* A8514 800B7D14 08006B8C */  lw         $t3, 0x8($v1)
    /* A8518 800B7D18 0C00688C */  lw         $t0, 0xC($v1)
    /* A851C 800B7D1C 0000A9AC */  sw         $t1, 0x0($a1)
    /* A8520 800B7D20 0400AAAC */  sw         $t2, 0x4($a1)
    /* A8524 800B7D24 0800ABAC */  sw         $t3, 0x8($a1)
    /* A8528 800B7D28 0C00A8AC */  sw         $t0, 0xC($a1)
    /* A852C 800B7D2C 10006324 */  addiu      $v1, $v1, 0x10
    /* A8530 800B7D30 F6FF6214 */  bne        $v1, $v0, .L800B7D0C
    /* A8534 800B7D34 1000A524 */   addiu     $a1, $a1, 0x10
    /* A8538 800B7D38 BCFFE724 */  addiu      $a3, $a3, -0x44
    /* A853C 800B7D3C 000F828F */  lw         $v0, %gp_rel(gCISouffle)($gp)
    /* A8540 800B7D40 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* A8544 800B7D44 0000698C */  lw         $t1, 0x0($v1)
    /* A8548 800B7D48 00000000 */  nop
    /* A854C 800B7D4C 0000A9AC */  sw         $t1, 0x0($a1)
    /* A8550 800B7D50 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A8554 800B7D54 000F82AF */  sw         $v0, %gp_rel(gCISouffle)($gp)
  .L800B7D58:
    /* A8558 800B7D58 000F848F */  lw         $a0, %gp_rel(gCISouffle)($gp)
    /* A855C 800B7D5C 01003126 */  addiu      $s1, $s1, 0x1
    /* A8560 800B7D60 2A102402 */  slt        $v0, $s1, $a0
    /* A8564 800B7D64 DCFF4014 */  bnez       $v0, .L800B7CD8
    /* A8568 800B7D68 4400E724 */   addiu     $a3, $a3, 0x44
  .L800B7D6C:
    /* A856C 800B7D6C 5000BF8F */  lw         $ra, 0x50($sp)
    /* A8570 800B7D70 4C00B38F */  lw         $s3, 0x4C($sp)
    /* A8574 800B7D74 4800B28F */  lw         $s2, 0x48($sp)
    /* A8578 800B7D78 4400B18F */  lw         $s1, 0x44($sp)
    /* A857C 800B7D7C 4000B08F */  lw         $s0, 0x40($sp)
    /* A8580 800B7D80 0800E003 */  jr         $ra
    /* A8584 800B7D84 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Souffle_DoSouffle__Fv
