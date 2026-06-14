.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetCameraZoom__Fii, 0x110

glabel SetCameraZoom__Fii
    /* 72538 80081D38 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7253C 80081D3C 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 72540 80081D40 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* 72544 80081D44 00190400 */  sll        $v1, $a0, 4
    /* 72548 80081D48 21186400 */  addu       $v1, $v1, $a0
    /* 7254C 80081D4C 00190300 */  sll        $v1, $v1, 4
    /* 72550 80081D50 21186200 */  addu       $v1, $v1, $v0
    /* 72554 80081D54 1000BFAF */  sw         $ra, 0x10($sp)
    /* 72558 80081D58 7400638C */  lw         $v1, 0x74($v1)
    /* 7255C 80081D5C 00000000 */  nop
    /* 72560 80081D60 C2110300 */  srl        $v0, $v1, 7
    /* 72564 80081D64 01004230 */  andi       $v0, $v0, 0x1
    /* 72568 80081D68 04004010 */  beqz       $v0, .L80081D7C
    /* 7256C 80081D6C BE000224 */   addiu     $v0, $zero, 0xBE
    /* 72570 80081D70 900282AF */  sw         $v0, %gp_rel(Camera_gGeomScreen)($gp)
    /* 72574 80081D74 8B070208 */  j          .L80081E2C
    /* 72578 80081D78 00000000 */   nop
  .L80081D7C:
    /* 7257C 80081D7C 0130A228 */  slti       $v0, $a1, 0x3001
    /* 72580 80081D80 2A004014 */  bnez       $v0, .L80081E2C
    /* 72584 80081D84 42160300 */   srl       $v0, $v1, 25
    /* 72588 80081D88 03004330 */  andi       $v1, $v0, 0x3
    /* 7258C 80081D8C 01000224 */  addiu      $v0, $zero, 0x1
    /* 72590 80081D90 0D006214 */  bne        $v1, $v0, .L80081DC8
    /* 72594 80081D94 04104500 */   sllv      $v0, $a1, $v0
    /* 72598 80081D98 AA2A033C */  lui        $v1, (0x2AAAAAAB >> 16)
    /* 7259C 80081D9C ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* 725A0 80081DA0 21104500 */  addu       $v0, $v0, $a1
    /* 725A4 80081DA4 40110200 */  sll        $v0, $v0, 5
    /* 725A8 80081DA8 23104500 */  subu       $v0, $v0, $a1
    /* 725AC 80081DAC 40100200 */  sll        $v0, $v0, 1
    /* 725B0 80081DB0 18004300 */  mult       $v0, $v1
    /* 725B4 80081DB4 C3170200 */  sra        $v0, $v0, 31
    /* 725B8 80081DB8 10300000 */  mfhi       $a2
    /* 725BC 80081DBC C31A0600 */  sra        $v1, $a2, 11
    /* 725C0 80081DC0 8A070208 */  j          .L80081E28
    /* 725C4 80081DC4 23186200 */   subu      $v1, $v1, $v0
  .L80081DC8:
    /* 725C8 80081DC8 02000224 */  addiu      $v0, $zero, 0x2
    /* 725CC 80081DCC 17006214 */  bne        $v1, $v0, .L80081E2C
    /* 725D0 80081DD0 AA2A033C */   lui       $v1, (0x2AAAAAAB >> 16)
    /* 725D4 80081DD4 ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* 725D8 80081DD8 40100500 */  sll        $v0, $a1, 1
    /* 725DC 80081DDC 21104500 */  addu       $v0, $v0, $a1
    /* 725E0 80081DE0 40110200 */  sll        $v0, $v0, 5
    /* 725E4 80081DE4 23104500 */  subu       $v0, $v0, $a1
    /* 725E8 80081DE8 40100200 */  sll        $v0, $v0, 1
    /* 725EC 80081DEC 18004300 */  mult       $v0, $v1
    /* 725F0 80081DF0 C3170200 */  sra        $v0, $v0, 31
    /* 725F4 80081DF4 10300000 */  mfhi       $a2
    /* 725F8 80081DF8 C31A0600 */  sra        $v1, $a2, 11
    /* 725FC 80081DFC 23186200 */  subu       $v1, $v1, $v0
    /* 72600 80081E00 900283AF */  sw         $v1, %gp_rel(Camera_gGeomScreen)($gp)
    /* 72604 80081E04 B1046228 */  slti       $v0, $v1, 0x4B1
    /* 72608 80081E08 08004014 */  bnez       $v0, .L80081E2C
    /* 7260C 80081E0C 70170224 */   addiu     $v0, $zero, 0x1770
    /* 72610 80081E10 23104300 */  subu       $v0, $v0, $v1
    /* 72614 80081E14 83180200 */  sra        $v1, $v0, 2
    /* 72618 80081E18 EE026228 */  slti       $v0, $v1, 0x2EE
    /* 7261C 80081E1C 02004010 */  beqz       $v0, .L80081E28
    /* 72620 80081E20 00000000 */   nop
    /* 72624 80081E24 EE020324 */  addiu      $v1, $zero, 0x2EE
  .L80081E28:
    /* 72628 80081E28 900283AF */  sw         $v1, %gp_rel(Camera_gGeomScreen)($gp)
  .L80081E2C:
    /* 7262C 80081E2C 9002848F */  lw         $a0, %gp_rel(Camera_gGeomScreen)($gp)
    /* 72630 80081E30 E7AA030C */  jal        SetGeomScreen
    /* 72634 80081E34 00000000 */   nop
    /* 72638 80081E38 1000BF8F */  lw         $ra, 0x10($sp)
    /* 7263C 80081E3C 00000000 */  nop
    /* 72640 80081E40 0800E003 */  jr         $ra
    /* 72644 80081E44 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetCameraZoom__Fii
