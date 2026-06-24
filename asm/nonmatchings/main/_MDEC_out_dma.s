.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _MDEC_out_dma, 0x8C

glabel _MDEC_out_dma
    /* E9478 800F8C78 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E947C 800F8C7C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E9480 800F8C80 21888000 */  addu       $s1, $a0, $zero
    /* E9484 800F8C84 1000B0AF */  sw         $s0, 0x10($sp)
    /* E9488 800F8C88 1800BFAF */  sw         $ra, 0x18($sp)
    /* E948C 800F8C8C 66E3030C */  jal        MDEC_out_sync
    /* E9490 800F8C90 2180A000 */   addu      $s0, $a1, $zero
    /* E9494 800F8C94 1380033C */  lui        $v1, %hi(D_80136C40)
    /* E9498 800F8C98 406C638C */  lw         $v1, %lo(D_80136C40)($v1)
    /* E949C 800F8C9C 00000000 */  nop
    /* E94A0 800F8CA0 0000628C */  lw         $v0, 0x0($v1)
    /* E94A4 800F8CA4 42811000 */  srl        $s0, $s0, 5
    /* E94A8 800F8CA8 88004234 */  ori        $v0, $v0, 0x88
    /* E94AC 800F8CAC 000062AC */  sw         $v0, 0x0($v1)
    /* E94B0 800F8CB0 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E94B4 800F8CB4 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E94B8 800F8CB8 00841000 */  sll        $s0, $s0, 16
    /* E94BC 800F8CBC 000040AC */  sw         $zero, 0x0($v0)
    /* E94C0 800F8CC0 1380023C */  lui        $v0, %hi(D_80136C14)
    /* E94C4 800F8CC4 146C428C */  lw         $v0, %lo(D_80136C14)($v0)
    /* E94C8 800F8CC8 20001036 */  ori        $s0, $s0, 0x20
    /* E94CC 800F8CCC 000051AC */  sw         $s1, 0x0($v0)
    /* E94D0 800F8CD0 1380023C */  lui        $v0, %hi(D_80136C18)
    /* E94D4 800F8CD4 186C428C */  lw         $v0, %lo(D_80136C18)($v0)
    /* E94D8 800F8CD8 0001033C */  lui        $v1, (0x1000200 >> 16)
    /* E94DC 800F8CDC 000050AC */  sw         $s0, 0x0($v0)
    /* E94E0 800F8CE0 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E94E4 800F8CE4 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E94E8 800F8CE8 00026334 */  ori        $v1, $v1, (0x1000200 & 0xFFFF)
    /* E94EC 800F8CEC 000043AC */  sw         $v1, 0x0($v0)
    /* E94F0 800F8CF0 1800BF8F */  lw         $ra, 0x18($sp)
    /* E94F4 800F8CF4 1400B18F */  lw         $s1, 0x14($sp)
    /* E94F8 800F8CF8 1000B08F */  lw         $s0, 0x10($sp)
    /* E94FC 800F8CFC 0800E003 */  jr         $ra
    /* E9500 800F8D00 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _MDEC_out_dma
