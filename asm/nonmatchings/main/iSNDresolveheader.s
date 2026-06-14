.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDresolveheader, 0x80

glabel iSNDresolveheader
    /* F237C 80101B7C 4800A28C */  lw         $v0, 0x48($a1)
    /* F2380 80101B80 4800838C */  lw         $v1, 0x48($a0)
    /* F2384 80101B84 00000000 */  nop
    /* F2388 80101B88 21104300 */  addu       $v0, $v0, $v1
    /* F238C 80101B8C 480082AC */  sw         $v0, 0x48($a0)
    /* F2390 80101B90 5400A28C */  lw         $v0, 0x54($a1)
    /* F2394 80101B94 5400838C */  lw         $v1, 0x54($a0)
    /* F2398 80101B98 00000000 */  nop
    /* F239C 80101B9C 21104300 */  addu       $v0, $v0, $v1
    /* F23A0 80101BA0 540082AC */  sw         $v0, 0x54($a0)
    /* F23A4 80101BA4 5C00A28C */  lw         $v0, 0x5C($a1)
    /* F23A8 80101BA8 5C00838C */  lw         $v1, 0x5C($a0)
    /* F23AC 80101BAC 00000000 */  nop
    /* F23B0 80101BB0 21104300 */  addu       $v0, $v0, $v1
    /* F23B4 80101BB4 5C0082AC */  sw         $v0, 0x5C($a0)
    /* F23B8 80101BB8 7400A28C */  lw         $v0, 0x74($a1)
    /* F23BC 80101BBC 7400838C */  lw         $v1, 0x74($a0)
    /* F23C0 80101BC0 00000000 */  nop
    /* F23C4 80101BC4 21104300 */  addu       $v0, $v0, $v1
    /* F23C8 80101BC8 740082AC */  sw         $v0, 0x74($a0)
    /* F23CC 80101BCC 8000A28C */  lw         $v0, 0x80($a1)
    /* F23D0 80101BD0 8000838C */  lw         $v1, 0x80($a0)
    /* F23D4 80101BD4 6400868C */  lw         $a2, 0x64($a0)
    /* F23D8 80101BD8 21104300 */  addu       $v0, $v0, $v1
    /* F23DC 80101BDC 0500C010 */  beqz       $a2, .L80101BF4
    /* F23E0 80101BE0 800082AC */   sw        $v0, 0x80($a0)
    /* F23E4 80101BE4 6400A28C */  lw         $v0, 0x64($a1)
    /* F23E8 80101BE8 00000000 */  nop
    /* F23EC 80101BEC 21104600 */  addu       $v0, $v0, $a2
    /* F23F0 80101BF0 640082AC */  sw         $v0, 0x64($a0)
  .L80101BF4:
    /* F23F4 80101BF4 0800E003 */  jr         $ra
    /* F23F8 80101BF8 00000000 */   nop
endlabel iSNDresolveheader
