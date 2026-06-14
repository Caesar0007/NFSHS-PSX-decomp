.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_GetDRAWENV__Fii, 0x3C

glabel Draw_GetDRAWENV__Fii
    /* AE59C 800BDD9C 40180400 */  sll        $v1, $a0, 1
    /* AE5A0 800BDDA0 21186400 */  addu       $v1, $v1, $a0
    /* AE5A4 800BDDA4 C0180300 */  sll        $v1, $v1, 3
    /* AE5A8 800BDDA8 21186400 */  addu       $v1, $v1, $a0
    /* AE5AC 800BDDAC C0180300 */  sll        $v1, $v1, 3
    /* AE5B0 800BDDB0 1280023C */  lui        $v0, %hi(D_8011EC5C)
    /* AE5B4 800BDDB4 5CEC4224 */  addiu      $v0, $v0, %lo(D_8011EC5C)
    /* AE5B8 800BDDB8 21186200 */  addu       $v1, $v1, $v0
    /* AE5BC 800BDDBC 40100500 */  sll        $v0, $a1, 1
    /* AE5C0 800BDDC0 21104500 */  addu       $v0, $v0, $a1
    /* AE5C4 800BDDC4 C0100200 */  sll        $v0, $v0, 3
    /* AE5C8 800BDDC8 23104500 */  subu       $v0, $v0, $a1
    /* AE5CC 800BDDCC 80100200 */  sll        $v0, $v0, 2
    /* AE5D0 800BDDD0 0800E003 */  jr         $ra
    /* AE5D4 800BDDD4 21106200 */   addu      $v0, $v1, $v0
endlabel Draw_GetDRAWENV__Fii
