.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_SetViewMemBudget__Fii, 0x28

glabel Draw_SetViewMemBudget__Fii
    /* AE5D8 800BDDD8 1280033C */  lui        $v1, %hi(Draw_gView)
    /* AE5DC 800BDDDC 54EC6324 */  addiu      $v1, $v1, %lo(Draw_gView)
    /* AE5E0 800BDDE0 40100400 */  sll        $v0, $a0, 1
    /* AE5E4 800BDDE4 21104400 */  addu       $v0, $v0, $a0
    /* AE5E8 800BDDE8 C0100200 */  sll        $v0, $v0, 3
    /* AE5EC 800BDDEC 21104400 */  addu       $v0, $v0, $a0
    /* AE5F0 800BDDF0 C0100200 */  sll        $v0, $v0, 3
    /* AE5F4 800BDDF4 21104300 */  addu       $v0, $v0, $v1
    /* AE5F8 800BDDF8 0800E003 */  jr         $ra
    /* AE5FC 800BDDFC 040045AC */   sw        $a1, 0x4($v0)
endlabel Draw_SetViewMemBudget__Fii
