.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching shapedepth, 0x6C

glabel shapedepth
    /* E4BE4 800F43E4 00008290 */  lbu        $v0, 0x0($a0)
    /* E4BE8 800F43E8 41000334 */  ori        $v1, $zero, 0x41
    /* E4BEC 800F43EC 77004230 */  andi       $v0, $v0, 0x77
    /* E4BF0 800F43F0 11006210 */  beq        $v1, $v0, .L800F4438
    /* E4BF4 800F43F4 40000334 */   ori       $v1, $zero, 0x40
    /* E4BF8 800F43F8 0D006210 */  beq        $v1, $v0, .L800F4430
    /* E4BFC 800F43FC 42000334 */   ori       $v1, $zero, 0x42
    /* E4C00 800F4400 0F006210 */  beq        $v1, $v0, .L800F4440
    /* E4C04 800F4404 23000334 */   ori       $v1, $zero, 0x23
    /* E4C08 800F4408 0D006210 */  beq        $v1, $v0, .L800F4440
    /* E4C0C 800F440C 44000334 */   ori       $v1, $zero, 0x44
    /* E4C10 800F4410 05006210 */  beq        $v1, $v0, .L800F4428
    /* E4C14 800F4414 43000334 */   ori       $v1, $zero, 0x43
    /* E4C18 800F4418 0B006210 */  beq        $v1, $v0, .L800F4448
    /* E4C1C 800F441C 72000334 */   ori       $v1, $zero, 0x72
    /* E4C20 800F4420 05006210 */  beq        $v1, $v0, .L800F4438
    /* E4C24 800F4424 00000000 */   nop
  .L800F4428:
    /* E4C28 800F4428 0800E003 */  jr         $ra
    /* E4C2C 800F442C 01000234 */   ori       $v0, $zero, 0x1
  .L800F4430:
    /* E4C30 800F4430 0800E003 */  jr         $ra
    /* E4C34 800F4434 04000234 */   ori       $v0, $zero, 0x4
  .L800F4438:
    /* E4C38 800F4438 0800E003 */  jr         $ra
    /* E4C3C 800F443C 08000234 */   ori       $v0, $zero, 0x8
  .L800F4440:
    /* E4C40 800F4440 0800E003 */  jr         $ra
    /* E4C44 800F4444 10000234 */   ori       $v0, $zero, 0x10
  .L800F4448:
    /* E4C48 800F4448 0800E003 */  jr         $ra
    /* E4C4C 800F444C 18000234 */   ori       $v0, $zero, 0x18
endlabel shapedepth
