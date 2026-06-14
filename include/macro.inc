/* GNU as macros used by splat-generated .s files. */

.macro glabel label
    .global \label
    .type \label, @function
    \label:
.endm

/* jump-table target label — made global so the jtbl in the rodata object can
   reference it across translation units (does not change emitted bytes). */
.macro jlabel label
    .global \label
    \label:
.endm

/* data label (global) */
.macro dlabel label
    .global \label
    \label:
.endm

/* splat "ascii/aligned" data label — same as dlabel for our purposes */
.macro alabel label
    .global \label
    \label:
.endm

/* close a function: emit its size for asm-differ / objdump */
.macro endlabel label
    .size \label, . - \label
.endm

/* close a data object: emit its size */
.macro enddlabel label
    .size \label, . - \label
.endm

/* splat annotation header: `nonmatching <name>[, <size>]` — informational */
.macro nonmatching name, size=0
.endm
