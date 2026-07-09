/* eaclib/psx/eacpsxz/shpsubs.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\shpsubs.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\SHPSUBS.ASM (per SYM SLD @0x800F0AAC line 7).
 *   THREE contiguous XDEFs: shapecount @0x800F0AAC (3), shapepointer @0x800F0AB8 (10, 0x28),
 *   shapename @0x800F0AE0 (15, 0x3C). EA "shape file" accessors -- shapepointer/shapename use the
 *   unsigned `sltu` bounds check + `swr`/`swl` unaligned name store, and a label sitting AT a `jr`
 *   delay slot, none of which the C recon reproduces (shapepointer/shapename FAILed). Transcribed
 *   VERBATIM in ONE __asm__ block; C fallback for the host build.
 *
 *   A shape file: int count @+0x08, then 8-byte dir entries @+0x10: entry[i] = {u32 name, u32 offset}.
 *     shapecount(sf)        = *(int*)(sf+8)
 *     shapepointer(sf,i)    = (i<count) ? sf + entry[i].offset : 0
 *     shapename(sf,i,dst)   = *(u32*)dst = (i<count) ? entry[i].name : 0   (unaligned swr/swl store)
 *   maspsx: load/store offsets DECIMAL; `sltu` comma-joined; `.set noat` for the explicit $at.
 */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl shapecount\n"        /* @0x800F0AAC : int shapecount(void *sf) */
    "shapecount:\n"
    "\tlw\t$v0,8($a0)\n"
    "\tjr\t$ra\n"
    "\t nop\n"

    "\t.globl shapepointer\n"      /* @0x800F0AB8 : void *shapepointer(void *sf, unsigned i) */
    "shapepointer:\n"
    "\tlw\t$t0,8($a0)\n"            /* count */
    "\tsll\t$t2,$a1,3\n"            /* i*8 */
    "\tsltu\t$at,$a1,$t0\n"         /* i < count (unsigned) */
    "\tbeqz\t$at,.L800F0AD8\n"      /* out of range -> 0 */
    "\t addu\t$t2,$a0,$t2\n"        /* delay: sf + i*8 */
    "\tlw\t$v0,20($t2)\n"           /* entry[i].offset  (0x10 + i*8 + 4) */
    "\tjr\t$ra\n"
    "\t addu\t$v0,$a0,$v0\n"        /* delay: sf + offset */
    ".L800F0AD8:\n"
    "\tjr\t$ra\n"
    "\t addiu\t$v0,$zero,0\n"       /* delay: return 0 */

    "\t.globl shapename\n"         /* @0x800F0AE0 : void shapename(void *sf, unsigned i, void *dst) */
    "shapename:\n"
    "\tlw\t$t0,8($a0)\n"            /* count */
    "\tsll\t$t2,$a1,3\n"            /* i*8 */
    "\tsltu\t$at,$a1,$t0\n"         /* i < count */
    "\tbeqz\t$at,.L800F0B08\n"      /* out of range */
    "\t addu\t$t2,$a0,$t2\n"        /* delay: sf + i*8 */
    "\tlw\t$v0,16($t2)\n"           /* entry[i].name  (0x10 + i*8) */
    "\tnop\n"
    "\tswr\t$v0,0($a2)\n"           /* unaligned store name -> dst */
    "\tswl\t$v0,3($a2)\n"
    "\tjr\t$ra\n"
    ".L800F0B08:\n"                 /* (label sits AT the jr delay slot) */
    "\t addiu\t$v0,$zero,0\n"       /* name = 0 */
    "\tswr\t$v0,0($a2)\n"
    "\tswl\t$v0,3($a2)\n"
    "\tjr\t$ra\n"
    "\t nop\n"
    "\t.set pop\n"
);
#else
extern int shapecount(void *shapefile)   /* @0x800F0AAC */
{
    return *(int *)((char *)shapefile + 8);
}

extern void *shapepointer(void *shapefile, unsigned int index)   /* @0x800F0AB8 */
{
    char *sf = (char *)shapefile;
    if (index < (unsigned)*(int *)(sf + 8))
        return sf + *(int *)(sf + index * 8 + 0x14);
    return 0;
}

extern void shapename(void *shapefile, unsigned int index, void *dst)   /* @0x800F0AE0 */
{
    char *sf = (char *)shapefile;
    int name = (index < (unsigned)*(int *)(sf + 8)) ? *(int *)(sf + index * 8 + 0x10) : 0;
    ((char *)dst)[0] = (char)(name);
    ((char *)dst)[1] = (char)(name >> 8);
    ((char *)dst)[2] = (char)(name >> 16);
    ((char *)dst)[3] = (char)(name >> 24);
}
#endif
