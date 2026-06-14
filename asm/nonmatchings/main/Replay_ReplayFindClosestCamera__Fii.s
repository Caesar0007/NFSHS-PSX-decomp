.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_ReplayFindClosestCamera__Fii, 0x468

glabel Replay_ReplayFindClosestCamera__Fii
    /* A6314 800B5B14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6318 800B5B18 21C08000 */  addu       $t8, $a0, $zero
    /* A631C 800B5B1C 21780000 */  addu       $t7, $zero, $zero
    /* A6320 800B5B20 2170E001 */  addu       $t6, $t7, $zero
    /* A6324 800B5B24 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A6328 800B5B28 DCDB4724 */  addiu      $a3, $v0, %lo(gReplayCameraSlots)
    /* A632C 800B5B2C 2150E000 */  addu       $t2, $a3, $zero
    /* A6330 800B5B30 1480083C */  lui        $t0, %hi(gNumSlices)
    /* A6334 800B5B34 C8C7088D */  lw         $t0, %lo(gNumSlices)($t0)
    /* A6338 800B5B38 A40E8D8F */  lw         $t5, %gp_rel(numValidCams)($gp)
    /* A633C 800B5B3C 01000624 */  addiu      $a2, $zero, 0x1
    /* A6340 800B5B40 1000BFAF */  sw         $ra, 0x10($sp)
    /* A6344 800B5B44 C2170800 */  srl        $v0, $t0, 31
    /* A6348 800B5B48 21100201 */  addu       $v0, $t0, $v0
    /* A634C 800B5B4C 0748C200 */  srav       $t1, $v0, $a2
  .L800B5B50:
    /* A6350 800B5B50 2A10CD01 */  slt        $v0, $t6, $t5
    /* A6354 800B5B54 D4004010 */  beqz       $v0, .L800B5EA8
    /* A6358 800B5B58 1180023C */   lui       $v0, %hi(Replay_ReplayCamera)
    /* A635C 800B5B5C 1E004285 */  lh         $v0, 0x1E($t2)
    /* A6360 800B5B60 00000000 */  nop
    /* A6364 800B5B64 2318A200 */  subu       $v1, $a1, $v0
    /* A6368 800B5B68 2A102301 */  slt        $v0, $t1, $v1
    /* A636C 800B5B6C 05004014 */  bnez       $v0, .L800B5B84
    /* A6370 800B5B70 23100301 */   subu      $v0, $t0, $v1
    /* A6374 800B5B74 0E006018 */  blez       $v1, .L800B5BB0
    /* A6378 800B5B78 00000000 */   nop
    /* A637C 800B5B7C E3D60208 */  j          .L800B5B8C
    /* A6380 800B5B80 00000000 */   nop
  .L800B5B84:
    /* A6384 800B5B84 0A004018 */  blez       $v0, .L800B5BB0
    /* A6388 800B5B88 00000000 */   nop
  .L800B5B8C:
    /* A638C 800B5B8C 1E004285 */  lh         $v0, 0x1E($t2)
    /* A6390 800B5B90 00000000 */  nop
    /* A6394 800B5B94 2310A200 */  subu       $v0, $a1, $v0
    /* A6398 800B5B98 21604000 */  addu       $t4, $v0, $zero
    /* A639C 800B5B9C 2A102C01 */  slt        $v0, $t1, $t4
    /* A63A0 800B5BA0 0B004010 */  beqz       $v0, .L800B5BD0
    /* A63A4 800B5BA4 2A18CD00 */   slt       $v1, $a2, $t5
    /* A63A8 800B5BA8 F4D60208 */  j          .L800B5BD0
    /* A63AC 800B5BAC 23600C01 */   subu      $t4, $t0, $t4
  .L800B5BB0:
    /* A63B0 800B5BB0 1E004485 */  lh         $a0, 0x1E($t2)
    /* A63B4 800B5BB4 00000000 */  nop
    /* A63B8 800B5BB8 2318A400 */  subu       $v1, $a1, $a0
    /* A63BC 800B5BBC 2A102301 */  slt        $v0, $t1, $v1
    /* A63C0 800B5BC0 02004014 */  bnez       $v0, .L800B5BCC
    /* A63C4 800B5BC4 23606800 */   subu      $t4, $v1, $t0
    /* A63C8 800B5BC8 23608500 */  subu       $t4, $a0, $a1
  .L800B5BCC:
    /* A63CC 800B5BCC 2A18CD00 */  slt        $v1, $a2, $t5
  .L800B5BD0:
    /* A63D0 800B5BD0 02006010 */  beqz       $v1, .L800B5BDC
    /* A63D4 800B5BD4 21100000 */   addu      $v0, $zero, $zero
    /* A63D8 800B5BD8 40110600 */  sll        $v0, $a2, 5
  .L800B5BDC:
    /* A63DC 800B5BDC 2110E200 */  addu       $v0, $a3, $v0
    /* A63E0 800B5BE0 1E004284 */  lh         $v0, 0x1E($v0)
    /* A63E4 800B5BE4 00000000 */  nop
    /* A63E8 800B5BE8 2310A200 */  subu       $v0, $a1, $v0
    /* A63EC 800B5BEC 2A102201 */  slt        $v0, $t1, $v0
    /* A63F0 800B5BF0 0D004010 */  beqz       $v0, .L800B5C28
    /* A63F4 800B5BF4 00000000 */   nop
    /* A63F8 800B5BF8 02006010 */  beqz       $v1, .L800B5C04
    /* A63FC 800B5BFC 21100000 */   addu      $v0, $zero, $zero
    /* A6400 800B5C00 40110600 */  sll        $v0, $a2, 5
  .L800B5C04:
    /* A6404 800B5C04 2110E200 */  addu       $v0, $a3, $v0
    /* A6408 800B5C08 1E004284 */  lh         $v0, 0x1E($v0)
    /* A640C 800B5C0C 00000000 */  nop
    /* A6410 800B5C10 2310A200 */  subu       $v0, $a1, $v0
    /* A6414 800B5C14 23100201 */  subu       $v0, $t0, $v0
    /* A6418 800B5C18 0C00401C */  bgtz       $v0, .L800B5C4C
    /* A641C 800B5C1C 2A18CD00 */   slt       $v1, $a2, $t5
    /* A6420 800B5C20 2ED70208 */  j          .L800B5CB8
    /* A6424 800B5C24 21100000 */   addu      $v0, $zero, $zero
  .L800B5C28:
    /* A6428 800B5C28 02006010 */  beqz       $v1, .L800B5C34
    /* A642C 800B5C2C 21100000 */   addu      $v0, $zero, $zero
    /* A6430 800B5C30 40110600 */  sll        $v0, $a2, 5
  .L800B5C34:
    /* A6434 800B5C34 2110E200 */  addu       $v0, $a3, $v0
    /* A6438 800B5C38 1E004284 */  lh         $v0, 0x1E($v0)
    /* A643C 800B5C3C 00000000 */  nop
    /* A6440 800B5C40 2310A200 */  subu       $v0, $a1, $v0
    /* A6444 800B5C44 1B004018 */  blez       $v0, .L800B5CB4
    /* A6448 800B5C48 2A18CD00 */   slt       $v1, $a2, $t5
  .L800B5C4C:
    /* A644C 800B5C4C 02006010 */  beqz       $v1, .L800B5C58
    /* A6450 800B5C50 21100000 */   addu      $v0, $zero, $zero
    /* A6454 800B5C54 40110600 */  sll        $v0, $a2, 5
  .L800B5C58:
    /* A6458 800B5C58 2110E200 */  addu       $v0, $a3, $v0
    /* A645C 800B5C5C 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6460 800B5C60 00000000 */  nop
    /* A6464 800B5C64 2310A200 */  subu       $v0, $a1, $v0
    /* A6468 800B5C68 2A102201 */  slt        $v0, $t1, $v0
    /* A646C 800B5C6C 0A004010 */  beqz       $v0, .L800B5C98
    /* A6470 800B5C70 00000000 */   nop
    /* A6474 800B5C74 02006010 */  beqz       $v1, .L800B5C80
    /* A6478 800B5C78 21100000 */   addu      $v0, $zero, $zero
    /* A647C 800B5C7C 40110600 */  sll        $v0, $a2, 5
  .L800B5C80:
    /* A6480 800B5C80 2110E200 */  addu       $v0, $a3, $v0
    /* A6484 800B5C84 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6488 800B5C88 00000000 */  nop
    /* A648C 800B5C8C 2310A200 */  subu       $v0, $a1, $v0
    /* A6490 800B5C90 48D70208 */  j          .L800B5D20
    /* A6494 800B5C94 23580201 */   subu      $t3, $t0, $v0
  .L800B5C98:
    /* A6498 800B5C98 02006010 */  beqz       $v1, .L800B5CA4
    /* A649C 800B5C9C 21100000 */   addu      $v0, $zero, $zero
    /* A64A0 800B5CA0 40110600 */  sll        $v0, $a2, 5
  .L800B5CA4:
    /* A64A4 800B5CA4 2110E200 */  addu       $v0, $a3, $v0
    /* A64A8 800B5CA8 1E004284 */  lh         $v0, 0x1E($v0)
    /* A64AC 800B5CAC 48D70208 */  j          .L800B5D20
    /* A64B0 800B5CB0 2358A200 */   subu      $t3, $a1, $v0
  .L800B5CB4:
    /* A64B4 800B5CB4 21100000 */  addu       $v0, $zero, $zero
  .L800B5CB8:
    /* A64B8 800B5CB8 03006010 */  beqz       $v1, .L800B5CC8
    /* A64BC 800B5CBC 2110E200 */   addu      $v0, $a3, $v0
    /* A64C0 800B5CC0 40110600 */  sll        $v0, $a2, 5
    /* A64C4 800B5CC4 2110E200 */  addu       $v0, $a3, $v0
  .L800B5CC8:
    /* A64C8 800B5CC8 1E004284 */  lh         $v0, 0x1E($v0)
    /* A64CC 800B5CCC 00000000 */  nop
    /* A64D0 800B5CD0 2310A200 */  subu       $v0, $a1, $v0
    /* A64D4 800B5CD4 2A102201 */  slt        $v0, $t1, $v0
    /* A64D8 800B5CD8 0A004010 */  beqz       $v0, .L800B5D04
    /* A64DC 800B5CDC 00000000 */   nop
    /* A64E0 800B5CE0 02006010 */  beqz       $v1, .L800B5CEC
    /* A64E4 800B5CE4 21100000 */   addu      $v0, $zero, $zero
    /* A64E8 800B5CE8 40110600 */  sll        $v0, $a2, 5
  .L800B5CEC:
    /* A64EC 800B5CEC 2110E200 */  addu       $v0, $a3, $v0
    /* A64F0 800B5CF0 1E004284 */  lh         $v0, 0x1E($v0)
    /* A64F4 800B5CF4 00000000 */  nop
    /* A64F8 800B5CF8 2310A200 */  subu       $v0, $a1, $v0
    /* A64FC 800B5CFC 48D70208 */  j          .L800B5D20
    /* A6500 800B5D00 23584800 */   subu      $t3, $v0, $t0
  .L800B5D04:
    /* A6504 800B5D04 02006010 */  beqz       $v1, .L800B5D10
    /* A6508 800B5D08 21100000 */   addu      $v0, $zero, $zero
    /* A650C 800B5D0C 40110600 */  sll        $v0, $a2, 5
  .L800B5D10:
    /* A6510 800B5D10 2110E200 */  addu       $v0, $a3, $v0
    /* A6514 800B5D14 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6518 800B5D18 00000000 */  nop
    /* A651C 800B5D1C 23584500 */  subu       $t3, $v0, $a1
  .L800B5D20:
    /* A6520 800B5D20 1E004485 */  lh         $a0, 0x1E($t2)
    /* A6524 800B5D24 2A18CD00 */  slt        $v1, $a2, $t5
    /* A6528 800B5D28 02006010 */  beqz       $v1, .L800B5D34
    /* A652C 800B5D2C 21100000 */   addu      $v0, $zero, $zero
    /* A6530 800B5D30 40110600 */  sll        $v0, $a2, 5
  .L800B5D34:
    /* A6534 800B5D34 2110E200 */  addu       $v0, $a3, $v0
    /* A6538 800B5D38 1E004284 */  lh         $v0, 0x1E($v0)
    /* A653C 800B5D3C 00000000 */  nop
    /* A6540 800B5D40 23108200 */  subu       $v0, $a0, $v0
    /* A6544 800B5D44 2A102201 */  slt        $v0, $t1, $v0
    /* A6548 800B5D48 0D004010 */  beqz       $v0, .L800B5D80
    /* A654C 800B5D4C 00000000 */   nop
    /* A6550 800B5D50 02006010 */  beqz       $v1, .L800B5D5C
    /* A6554 800B5D54 21100000 */   addu      $v0, $zero, $zero
    /* A6558 800B5D58 40110600 */  sll        $v0, $a2, 5
  .L800B5D5C:
    /* A655C 800B5D5C 2110E200 */  addu       $v0, $a3, $v0
    /* A6560 800B5D60 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6564 800B5D64 00000000 */  nop
    /* A6568 800B5D68 23108200 */  subu       $v0, $a0, $v0
    /* A656C 800B5D6C 23100201 */  subu       $v0, $t0, $v0
    /* A6570 800B5D70 0C00401C */  bgtz       $v0, .L800B5DA4
    /* A6574 800B5D74 21100000 */   addu      $v0, $zero, $zero
    /* A6578 800B5D78 85D70208 */  j          .L800B5E14
    /* A657C 800B5D7C 00000000 */   nop
  .L800B5D80:
    /* A6580 800B5D80 02006010 */  beqz       $v1, .L800B5D8C
    /* A6584 800B5D84 21100000 */   addu      $v0, $zero, $zero
    /* A6588 800B5D88 40110600 */  sll        $v0, $a2, 5
  .L800B5D8C:
    /* A658C 800B5D8C 2110E200 */  addu       $v0, $a3, $v0
    /* A6590 800B5D90 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6594 800B5D94 00000000 */  nop
    /* A6598 800B5D98 23108200 */  subu       $v0, $a0, $v0
    /* A659C 800B5D9C 1D004018 */  blez       $v0, .L800B5E14
    /* A65A0 800B5DA0 21100000 */   addu      $v0, $zero, $zero
  .L800B5DA4:
    /* A65A4 800B5DA4 1E004485 */  lh         $a0, 0x1E($t2)
    /* A65A8 800B5DA8 2A18CD00 */  slt        $v1, $a2, $t5
    /* A65AC 800B5DAC 02006010 */  beqz       $v1, .L800B5DB8
    /* A65B0 800B5DB0 21100000 */   addu      $v0, $zero, $zero
    /* A65B4 800B5DB4 40110600 */  sll        $v0, $a2, 5
  .L800B5DB8:
    /* A65B8 800B5DB8 2110E200 */  addu       $v0, $a3, $v0
    /* A65BC 800B5DBC 1E004284 */  lh         $v0, 0x1E($v0)
    /* A65C0 800B5DC0 00000000 */  nop
    /* A65C4 800B5DC4 23108200 */  subu       $v0, $a0, $v0
    /* A65C8 800B5DC8 2A102201 */  slt        $v0, $t1, $v0
    /* A65CC 800B5DCC 0A004010 */  beqz       $v0, .L800B5DF8
    /* A65D0 800B5DD0 00000000 */   nop
    /* A65D4 800B5DD4 02006010 */  beqz       $v1, .L800B5DE0
    /* A65D8 800B5DD8 21100000 */   addu      $v0, $zero, $zero
    /* A65DC 800B5DDC 40110600 */  sll        $v0, $a2, 5
  .L800B5DE0:
    /* A65E0 800B5DE0 2110E200 */  addu       $v0, $a3, $v0
    /* A65E4 800B5DE4 1E004284 */  lh         $v0, 0x1E($v0)
    /* A65E8 800B5DE8 00000000 */  nop
    /* A65EC 800B5DEC 23108200 */  subu       $v0, $a0, $v0
    /* A65F0 800B5DF0 A1D70208 */  j          .L800B5E84
    /* A65F4 800B5DF4 23180201 */   subu      $v1, $t0, $v0
  .L800B5DF8:
    /* A65F8 800B5DF8 02006010 */  beqz       $v1, .L800B5E04
    /* A65FC 800B5DFC 21100000 */   addu      $v0, $zero, $zero
    /* A6600 800B5E00 40110600 */  sll        $v0, $a2, 5
  .L800B5E04:
    /* A6604 800B5E04 2110E200 */  addu       $v0, $a3, $v0
    /* A6608 800B5E08 1E004284 */  lh         $v0, 0x1E($v0)
    /* A660C 800B5E0C A1D70208 */  j          .L800B5E84
    /* A6610 800B5E10 23188200 */   subu      $v1, $a0, $v0
  .L800B5E14:
    /* A6614 800B5E14 1E004485 */  lh         $a0, 0x1E($t2)
    /* A6618 800B5E18 2A18CD00 */  slt        $v1, $a2, $t5
    /* A661C 800B5E1C 03006010 */  beqz       $v1, .L800B5E2C
    /* A6620 800B5E20 2110E200 */   addu      $v0, $a3, $v0
    /* A6624 800B5E24 40110600 */  sll        $v0, $a2, 5
    /* A6628 800B5E28 2110E200 */  addu       $v0, $a3, $v0
  .L800B5E2C:
    /* A662C 800B5E2C 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6630 800B5E30 00000000 */  nop
    /* A6634 800B5E34 23108200 */  subu       $v0, $a0, $v0
    /* A6638 800B5E38 2A102201 */  slt        $v0, $t1, $v0
    /* A663C 800B5E3C 0A004010 */  beqz       $v0, .L800B5E68
    /* A6640 800B5E40 00000000 */   nop
    /* A6644 800B5E44 02006010 */  beqz       $v1, .L800B5E50
    /* A6648 800B5E48 21100000 */   addu      $v0, $zero, $zero
    /* A664C 800B5E4C 40110600 */  sll        $v0, $a2, 5
  .L800B5E50:
    /* A6650 800B5E50 2110E200 */  addu       $v0, $a3, $v0
    /* A6654 800B5E54 1E004284 */  lh         $v0, 0x1E($v0)
    /* A6658 800B5E58 00000000 */  nop
    /* A665C 800B5E5C 23108200 */  subu       $v0, $a0, $v0
    /* A6660 800B5E60 A1D70208 */  j          .L800B5E84
    /* A6664 800B5E64 23184800 */   subu      $v1, $v0, $t0
  .L800B5E68:
    /* A6668 800B5E68 02006010 */  beqz       $v1, .L800B5E74
    /* A666C 800B5E6C 21100000 */   addu      $v0, $zero, $zero
    /* A6670 800B5E70 40110600 */  sll        $v0, $a2, 5
  .L800B5E74:
    /* A6674 800B5E74 2110E200 */  addu       $v0, $a3, $v0
    /* A6678 800B5E78 1E004284 */  lh         $v0, 0x1E($v0)
    /* A667C 800B5E7C 00000000 */  nop
    /* A6680 800B5E80 23184400 */  subu       $v1, $v0, $a0
  .L800B5E84:
    /* A6684 800B5E84 21108B01 */  addu       $v0, $t4, $t3
    /* A6688 800B5E88 2A106200 */  slt        $v0, $v1, $v0
    /* A668C 800B5E8C 04004010 */  beqz       $v0, .L800B5EA0
    /* A6690 800B5E90 20004A25 */   addiu     $t2, $t2, 0x20
    /* A6694 800B5E94 0100C624 */  addiu      $a2, $a2, 0x1
    /* A6698 800B5E98 D4D60208 */  j          .L800B5B50
    /* A669C 800B5E9C 0100CE25 */   addiu     $t6, $t6, 0x1
  .L800B5EA0:
    /* A66A0 800B5EA0 2178C001 */  addu       $t7, $t6, $zero
    /* A66A4 800B5EA4 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
  .L800B5EA8:
    /* A66A8 800B5EA8 4C704224 */  addiu      $v0, $v0, %lo(Replay_ReplayCamera)
    /* A66AC 800B5EAC 00311800 */  sll        $a2, $t8, 4
    /* A66B0 800B5EB0 2138C200 */  addu       $a3, $a2, $v0
    /* A66B4 800B5EB4 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A66B8 800B5EB8 DCDB4824 */  addiu      $t0, $v0, %lo(gReplayCameraSlots)
    /* A66BC 800B5EBC 40110F00 */  sll        $v0, $t7, 5
    /* A66C0 800B5EC0 21104800 */  addu       $v0, $v0, $t0
    /* A66C4 800B5EC4 0C00EFAC */  sw         $t7, 0xC($a3)
    /* A66C8 800B5EC8 00004390 */  lbu        $v1, 0x0($v0)
    /* A66CC 800B5ECC 0B000224 */  addiu      $v0, $zero, 0xB
    /* A66D0 800B5ED0 20006214 */  bne        $v1, $v0, .L800B5F54
    /* A66D4 800B5ED4 21200003 */   addu      $a0, $t8, $zero
    /* A66D8 800B5ED8 FFF9043C */  lui        $a0, (0xF9FFFFFF >> 16)
    /* A66DC 800B5EDC FFFF8434 */  ori        $a0, $a0, (0xF9FFFFFF & 0xFFFF)
    /* A66E0 800B5EE0 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* A66E4 800B5EE4 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* A66E8 800B5EE8 2130D800 */  addu       $a2, $a2, $t8
    /* A66EC 800B5EEC 00310600 */  sll        $a2, $a2, 4
    /* A66F0 800B5EF0 2110E001 */  addu       $v0, $t7, $zero
    /* A66F4 800B5EF4 2130C300 */  addu       $a2, $a2, $v1
    /* A66F8 800B5EF8 40110200 */  sll        $v0, $v0, 5
    /* A66FC 800B5EFC 21104800 */  addu       $v0, $v0, $t0
    /* A6700 800B5F00 0000E0AC */  sw         $zero, 0x0($a3)
    /* A6704 800B5F04 7400C38C */  lw         $v1, 0x74($a2)
    /* A6708 800B5F08 0000428C */  lw         $v0, 0x0($v0)
    /* A670C 800B5F0C 24186400 */  and        $v1, $v1, $a0
    /* A6710 800B5F10 42120200 */  srl        $v0, $v0, 9
    /* A6714 800B5F14 03004230 */  andi       $v0, $v0, 0x3
    /* A6718 800B5F18 40160200 */  sll        $v0, $v0, 25
    /* A671C 800B5F1C 25186200 */  or         $v1, $v1, $v0
    /* A6720 800B5F20 7400C3AC */  sw         $v1, 0x74($a2)
    /* A6724 800B5F24 0C00E28C */  lw         $v0, 0xC($a3)
    /* A6728 800B5F28 0B000524 */  addiu      $a1, $zero, 0xB
    /* A672C 800B5F2C 40110200 */  sll        $v0, $v0, 5
    /* A6730 800B5F30 21104800 */  addu       $v0, $v0, $t0
    /* A6734 800B5F34 0000428C */  lw         $v0, 0x0($v0)
    /* A6738 800B5F38 21200003 */  addu       $a0, $t8, $zero
    /* A673C 800B5F3C 0610A200 */  srlv       $v0, $v0, $a1
    /* A6740 800B5F40 07004230 */  andi       $v0, $v0, 0x7
    /* A6744 800B5F44 8215020C */  jal        Camera_SetMode__Fii
    /* A6748 800B5F48 7E00C2A0 */   sb        $v0, 0x7E($a2)
    /* A674C 800B5F4C DBD70208 */  j          .L800B5F6C
    /* A6750 800B5F50 00000000 */   nop
  .L800B5F54:
    /* A6754 800B5F54 0C00E58C */  lw         $a1, 0xC($a3)
    /* A6758 800B5F58 01000224 */  addiu      $v0, $zero, 0x1
    /* A675C 800B5F5C 0000E2AC */  sw         $v0, 0x0($a3)
    /* A6760 800B5F60 40290500 */  sll        $a1, $a1, 5
    /* A6764 800B5F64 F416020C */  jal        Camera_ReplayUpdate__FiP15Camera_tCamSlot
    /* A6768 800B5F68 2128A800 */   addu      $a1, $a1, $t0
  .L800B5F6C:
    /* A676C 800B5F6C 1000BF8F */  lw         $ra, 0x10($sp)
    /* A6770 800B5F70 00000000 */  nop
    /* A6774 800B5F74 0800E003 */  jr         $ra
    /* A6778 800B5F78 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Replay_ReplayFindClosestCamera__Fii
