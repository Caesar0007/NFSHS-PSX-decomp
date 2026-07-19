/* eaclib/psx/eacpsxz/memstd.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\memstd.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   13 fns @ [0x800E4D4C, 0x800E5608) -- EA "memstd" standard heap allocator.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT stubs/thunks.
 *   No SYM debug info for these (LIB built without -g) -> param/field names reasoned from
 *   the MIPS + the EA memstd design; every field keeps a /* +0xNN *\/ byte-offset breadcrumb.
 *   C-linkage symbols (the .obj XDEFs these names); cross-obj callers resolve via lib/libfns.h.
 *
 *   HEAP MODEL (recovered byte-for-byte from the disasm):
 *     Every allocation is prefixed by a 16-byte MemBlock header; the user pointer = hdr + 0x10.
 *     Blocks are threaded on TWO doubly-linked lists:
 *       - physical list (+0x08 physnext / +0x0C physprev) : ALL blocks, address-ordered, adjacent.
 *       - free list     (+0x10 freenext / +0x14 freeprev) : free blocks only; links live in the
 *                                                            payload area (valid only while free).
 *     Magics: 'MB'=0x424D (in-use), 'FB'=0x4246 (free), 0x4253 (ring-head sentinel).
 *     flags bit 0x4000 = "currently on the free list".  flags low nibble = owning class id.
 *     A MemClass (64 B, lives at membuf+0x10) owns one buffer carved into LOW/middle/HIGH blocks;
 *     its embedded free-head sentinel sits at class+0x10.  gMemClassTable[id&0xF] indexes classes.
 */


/* ---- block / class structures (library-internal; not shared in nfs4_types.h) ---- */
typedef struct MemBlock {
    unsigned short   magic;     /* +0x00  'MB'/'FB'/0x4253 sentinel            */
    unsigned short   flags;     /* +0x02  bit0x4000=on-freelist; low nibble=class id */
    int              size;      /* +0x04  payload size                         */
    struct MemBlock *physnext;  /* +0x08  next block by address (adjacent)     */
    struct MemBlock *physprev;  /* +0x0C  prev block by address                */
    struct MemBlock *freenext;  /* +0x10  free-list forward  (overlays payload)*/
    struct MemBlock *freeprev;  /* +0x14  free-list backward                   */
} MemBlock;

typedef struct MemClass {
    char       name[8];         /* +0x00  class name (strcpy'd)                */
    MemBlock  *phys_first;      /* +0x08  first physical block (=membuf)       */
    MemBlock  *phys_last;       /* +0x0C  last  physical block (=HIGH block)   */
    char       freehead[0x18];  /* +0x10  embedded free-ring sentinel MemBlock */
                                /*        (magic@+0x10 size@+0x14 next@+0x20 prev@+0x24) */
    int        granularity;     /* +0x28  per-alloc size granularity           */
    int        alignment;       /* +0x2C  buffer/alloc alignment               */
    int        infosize;        /* +0x30  per-block overhead reserved          */
    int        flags;           /* +0x34  class flags (0x100=named,0x700 mask) */
    void      *mutex;           /* +0x38  optional mutex handle                */
    int        field3c;         /* +0x3C  user field                          */
} MemClass;                     /* 0x40                                        */

static const unsigned short MAGIC_USED = 0x424D;   /* 'MB' */
static const unsigned short MAGIC_FREE = 0x4246;   /* 'FB' */
static const unsigned short MAGIC_HEAD = 0x4253;   /* free-ring sentinel */

/* ---- globals (BSS/rodata, defined in the data-materialization pass) ---- */
extern "C" MemClass *gMemClassTable[16];   /* @0x8013E900 (BSS) */
extern "C" int       mb_default;           /* @0x8013DCC8       */

/* ---- helpers defined in sibling eacpsxz / libc objs (called, not defined here) ---- */
extern "C" int    sprintf(char *, const char *, ...);   /* libc SPRINTF     */
extern "C" char  *strcpy(char *, const char *);         /* eacpsxz strcpy   */
extern "C" unsigned strlen(const char *);               /* eacpsxz strlen   */
extern "C" void   blockclear(void *, int);              /* eacpsxz blockclear */
extern "C" void   putm(void *, unsigned, int);          /* guard-band writer  */
extern "C" void   puti(void *, unsigned, int);          /* guard-band writer  */
extern "C" void  *allocmutex(void);                     /* mutex allocator    */

/* forward decls of intra-obj XDEFs (all C-linkage) */
extern "C" MemBlock *FREE_find(MemClass *mb, int size, int reverse);
extern "C" MemBlock *FREE_findlargest(MemClass *mb, int size, int reverse);
extern "C" void      FREE_add(MemClass *mb, MemBlock *node);
extern "C" void      FREE_remove(MemClass *mb, MemBlock *node);
extern "C" int       initmemblock(MemBlock *blk, char *name, int size, int tailextra,
                                  int flags, MemBlock *physprev, MemBlock *physnext);
extern "C" int       MEM_infosize(int id);
extern "C" int       MEM_tailsize(char *name, int id);

/* ===================================================================== *
 *  FREE_find  @0x800E4D4C : first free block whose size >= `size`.       *
 *  `reverse`!=0 scans the ring backward (freeprev) instead of forward.   *
 *  Returns NULL if only the sentinel qualifies (size 0x7FFFFFFF).        *
 * ===================================================================== */
extern "C" MemBlock *FREE_find(MemClass *mb, int size, int reverse)   /* @0x800E4D4C */
{
    /* MATCH: forward walk = the if-BODY (bnez a2 -> out-of-line reverse loop); walker
     * reuses the dead param reg (addiu a0,a0,16 in the bnez slot); ring-head tail is a
     * FUNNEL (p = 0) not an early return. */
    MemBlock *p = (MemBlock *)((char *)mb + 0x10);   /* &freehead (delay-slot a0+=0x10) */
    if (reverse == 0) {
        do { p = p->freenext; } while (p->size < size);
    } else {
        do { p = p->freeprev; } while (p->size < size);
    }
    if (p->magic == MAGIC_HEAD)          /* wrapped to the ring head -> none */
        p = 0;
    return p;
}

/* ===================================================================== *
 *  FREE_findlargest @0x800E4DB0 : largest free block with size > size-1. *
 *  The sentinel (size 0x7FFFFFFF) always terminates the walk.           *
 * ===================================================================== */
extern "C" MemBlock *FREE_findlargest(MemClass *mb, int size, int reverse)   /* @0x800E4DB0 */
{
    MemBlock *best = 0;
    int       min  = size - 1;
    MemBlock *p    = (MemBlock *)((char *)mb + 0x10);   /* delay slot: always +0x10 */
    if (min < 0) min = 0;

    if (reverse == 0) {
        for (;;) {
            p = p->freenext;
            if (min < p->size) {
                if (p->magic == MAGIC_HEAD) break;     /* reached sentinel */
                best = p; min = p->size;
            }
        }
    } else {
        for (;;) {
            p = p->freeprev;
            if (min < p->size) {
                if (p->magic == MAGIC_HEAD) break;
                best = p; min = p->size;
            }
        }
    }
    return best;
}

/* ===================================================================== *
 *  FREE_add @0x800E4E70 : insert `node` into the address-ordered free    *
 *  ring of class `mb`.  Search direction is picked by comparing node to  *
 *  the midpoint of (head,tail) so insertion stays ~O(n/2).               *
 * ===================================================================== */
extern "C" void FREE_add(MemClass *mb, MemBlock *node)   /* @0x800E4E70 */
{
    MemBlock *head  = (MemBlock *)((char *)mb + 0x10);
    int       span  = (int)((char *)node->physnext - (char *)node);   /* node end - node */
    int       payload = span - 0x10;
    MemBlock *last  = head->freeprev;
    MemBlock *first = head->freenext;
    /* midpoint = first + ((last-first) >> 1)  (unsigned shift, per srl) */
    MemBlock *mid = (MemBlock *)((char *)first
                    + (((unsigned)((char *)last - (char *)first)) >> 1));
    MemBlock *q = head;

    if (mid < node) {                       /* scan backward from tail */
        do { q = q->freeprev; } while (node < q);
        head = q->freenext;                 /* MATCH: reuse dead 'head' reg for 'after' */
    } else {                                /* scan forward from head  */
        do { head = head->freenext; } while (head < node);
        q = head->freeprev;                 /* MATCH: reuse 'q' reg for 'before' */
    }

    node->freenext = head;                  /* head now holds 'after' */
    node->freeprev = q;                     /* q now holds 'before' */
    node->size     = payload;
    q->freenext = node;
    head->freeprev  = node;
    node->magic = MAGIC_FREE;
    node->flags = (unsigned short)(node->flags | 0x4000);
}

/* ===================================================================== *
 *  FREE_remove @0x800E4F04 : unlink `node` from the free ring.           *
 *  (`mb` is unused -- the .obj passes it but the code ignores it.)       *
 * ===================================================================== */
extern "C" void FREE_remove(MemClass *mb, MemBlock *node)   /* @0x800E4F04 */
{
    (void)mb;
    MemBlock *prev = node->freeprev;
    MemBlock *next = node->freenext;
    prev->freenext = next;
    next->freeprev = prev;
    node->magic = 0;
    node->flags = (unsigned short)(node->flags & 0xBFFF);   /* clear 0x4000 */
}

/* ===================================================================== *
 *  initmemblock @0x800E4F2C : stamp a 16-byte header on `blk`, optionally *
 *  write debug guard bands and copy a block name into the tail region.    *
 *  Returns the total span consumed (header+payload+name) in bytes.        *
 * ===================================================================== */
extern "C" int initmemblock(MemBlock *blk, char *name, int size, int tailextra,
                            int flags, MemBlock *physprev, MemBlock *physnext)   /* @0x800E4F2C */
{
    char *end = (char *)blk + (size + 0x10);     /* s0 = blk + (size + 16) */

    blk->magic    = MAGIC_USED;                  /* +0x00 'MB' */
    blk->size     = size;                        /* +0x04 */
    blk->flags    = (unsigned short)flags;       /* +0x02 */
    blk->physnext = physnext;                    /* +0x08 (arg7) */
    blk->physprev = physprev;                    /* +0x0C (arg6, always written) */

    if (flags & 0x200)
        putm(end, 0x42454E44, 4);                /* "BEND" end-guard */
    if (flags & 0x800)
        puti(end + 0xC, 0, 4);

    /* MATCH: `end += tailextra` is the DELAY SLOT of the `name!=0` test below -- it runs
     * UNCONDITIONALLY (both taken/not-taken), not gated by name!=0 (real bug fix vs the
     * prior gated form: `beqz s3,.L800E4FE4 / [delay] addu s0,s0,s4`). */
    end += tailextra;                             /* s0 += a3 (always) */
    if (name != 0) {
        if (flags & 0x100) {                     /* named block */
            strcpy(end, name);
            end += (int)strlen(end) + 1;         /* MATCH: strlen(end), the just-copied dest, not name */
        }
    }
    return (int)(end - (char *)blk);
}

/* ===================================================================== *
 *  MEM_infosize @0x800E5008 : per-block overhead of class `id`.          *
 * ===================================================================== */
extern "C" int MEM_infosize(int id)   /* @0x800E5008 */
{
    return gMemClassTable[id & 0xF]->infosize;   /* +0x30 */
}

/* ===================================================================== *
 *  MEM_tailsize @0x800E5030 : bytes reserved after the payload =         *
 *  infosize + (named class & name given ? strlen(name)+1 : 0).          *
 * ===================================================================== */
extern "C" int MEM_tailsize(char *name, int id)   /* @0x800E5030 */
{
    MemClass *cls = gMemClassTable[id & 0xF];
    int extra = 0;
    if (name != 0 && (cls->flags & 0x100))       /* +0x34 flags */
        extra = (int)strlen(name) + 1;
    return cls->infosize + extra;                /* +0x30 */
}

/* ===================================================================== *
 *  creatememclass @0x800E5094 : carve `membuf[bufsize]` into a class     *
 *  (LOW block holding the MemClass struct, a big middle free block, and  *
 *  a HIGH guard block) and register it in gMemClassTable[id&0xF].        *
 *  Returns the usable size of the big free block.                       *
 * ===================================================================== */
extern "C" int creatememclass(int id, char *name, char *membuf, int bufsize,
                              int granularity, int alignment, int infosize,
                              int lowguard, int reserved9, int highguard,
                              int usemutex, int field3c)   /* @0x800E5094 */
{
    char namebuf[256];                           /* sp+0x20 scratch */
    int  flags = id;                             /* s2 starts = id  */
    (void)reserved9;                             /* arg9 unreferenced by the asm */

    if (lowguard)  flags |= 0x200;
    if (highguard) flags |= 0x100;

    /* s3 = (membuf + (infosize+0x50) + (alignment+0x1F)) & -alignment, then -0x10
     * MATCH: grouped as TWO separate constant-adds materialized in SEPARATE statements
     * (infosize+0x50, alignment+0x1F) so gcc's constant folder can't merge them into one
     * 0x6F literal -- reproduces the oracle's addiu/addiu pair. MATCH: `lo` declared BEFORE
     * `hi` -- the oracle combines membuf+lo first (v0), then computes+adds hi (v1) LAST,
     * right before the &-alignment; declaring hi first (as before) materialized it too
     * early, landing in the wrong delay slot. */
    unsigned lo = (unsigned)infosize + 0x50u;
    unsigned hi = (unsigned)alignment + 0x1Fu;
    unsigned a = ((unsigned)membuf + lo) + hi;
    a &= (unsigned)(-alignment);
    char *low_end = (char *)a - 0x10;            /* s3 */

    /* s0 = membuf + bufsize - infosize - 0x20  (start of HIGH block) */
    char *high = membuf + bufsize - (infosize + 0x20);   /* s0 */

    MemClass *cls = (MemClass *)(membuf + 0x10); /* s1 = membuf+0x10 */

    /* RESIDUAL (16 diffs, count-exact 124/124): the oracle materializes namebuf's address
     * (a0=sp+0x20) INTO the highguard branch's delay slot (always-executes) and delays the
     * `hi` (alignment+0x1F) add until right before the &-alignment combine; ours schedules
     * `lo` (infosize+0x50) into that delay slot instead and `hi` right after the branch
     * merge. Tried: hoisting the sprintf() call itself before this block (regresses to 33
     * diffs -- moving the actual `jal` also moves the bufsize/a3 caller-saved-clobber
     * point, forcing an extra cache store). A pure scheduling tie-break within one basic
     * block; not further source-reachable without pinning. Accept as floor. */
    sprintf(namebuf, "%s LOW", name);            /* @0x8013DC20 */
    initmemblock((MemBlock *)membuf,  namebuf, 0x40, infosize,
                 flags | 0x8000, 0,                 (MemBlock *)low_end);
    initmemblock((MemBlock *)low_end, 0,       (int)(high - low_end) - 0x10, infosize,
                 flags,          (MemBlock *)membuf, (MemBlock *)high);
    sprintf(namebuf, "%s HIGH", name);           /* @0x8013DC28 */
    initmemblock((MemBlock *)high,    namebuf, 0,    infosize,
                 flags | 0x8010, (MemBlock *)low_end, 0);

    gMemClassTable[id & 0xF] = cls;               /* MATCH: assigned before the call (lands in its delay slot) */
    blockclear(cls, 0x40);                        /* zero the 64-byte class */
    strcpy((char *)cls, name);                    /* class->name */

    {   /* initialise the embedded free-ring sentinel + class fields, in oracle store order.
         * MATCH: no separate `fh` pointer -- the oracle addresses every one of these fields
         * via cls(s1)+FIXED-DISPLACEMENT (sh/sw …,0x10/0x14/0x20/0x24(s1)); materializing a
         * distinct `fh=cls+0x10` C pointer lets gcc fold it back through cls's own known
         * membuf+0x10 origin into a membuf-relative base (sh v0,0x20(s4) et al) instead. */
        *(unsigned short *)((char *)cls + 0x10) = MAGIC_HEAD;      /* fh->magic  +0x10 */
        cls->phys_first = (MemBlock *)membuf;                      /* +0x08 */
        cls->phys_last  = (MemBlock *)high;                        /* +0x0C */
        *(MemBlock **)((char *)cls + 0x20) = (MemBlock *)((char *)membuf + 0x20); /* fh->freenext +0x20 -> self */
        *(MemBlock **)((char *)cls + 0x24) = (MemBlock *)((char *)membuf + 0x20); /* fh->freeprev +0x24 */
        *(int *)((char *)cls + 0x14) = 0x7FFFFFFF;                 /* fh->size   +0x14 */
        /* MATCH: `granularity` (a stack-passed param, never register-resident) is READ
         * EARLY into a named temp -- the oracle reloads it (lw v0,sp+..) right up front,
         * before the alignment/infosize/flags/mutex stores, and only USES it (the store to
         * +0x28) at the end of the block; a bare `cls->granularity = granularity;` placed
         * last reads-and-stores in one step, one instruction too late. */
        int gran = granularity;
        cls->alignment   = alignment;                             /* +0x2C */
        cls->infosize    = infosize;                              /* +0x30 */
        cls->flags       = flags;                                 /* +0x34 */
        cls->mutex       = 0;                                     /* +0x38 */
        cls->granularity = gran;                                  /* +0x28 */
    }

    cls->field3c     = field3c;                                  /* +0x3C, right at the FREE_add call */
    FREE_add(cls, (MemBlock *)low_end);           /* publish the big free block */
    if (usemutex)
        cls->mutex = allocmutex();                /* +0x38 */

    return ((MemBlock *)low_end)->size;           /* *(int*)(s3+4) = usable size */
}

/* ===================================================================== *
 *  largestunused @0x800E5284 : size of the largest free block in the     *
 *  default class (0 if none).                                            *
 * ===================================================================== */
extern "C" int largestunused(void)   /* @0x800E5284 */
{
    MemBlock *b = FREE_findlargest(gMemClassTable[mb_default & 0xF], 0, 0);
    return b ? b->size : 0;
}

/* ===================================================================== *
 *  getblocksize @0x800E52D4 : payload size recorded in a block header.   *
 * ===================================================================== */
extern "C" int getblocksize(void *p)   /* @0x800E52D4 */
{
    return ((MemBlock *)((char *)p - 0x10))->size;   /* *(int*)(p-12) */
}

/* ===================================================================== *
 *  getblockname @0x800E52E0 : pointer to a named block's stored name,    *
 *  or NULL when the block is unnamed.                                    *
 * ===================================================================== */
extern "C" char *getblockname(void *p)   /* @0x800E52E0 */
{
    MemBlock *hdr   = (MemBlock *)((char *)p - 0x10);
    int       flags = hdr->flags;         /* single lhu into $a0 (reused as the MEM_infosize arg) */
    char     *result = 0;                 /* asm: $v1=0 in the beqz delay slot; result built in $v1 */
    if (flags & 0x100)                    /* named */
        result = (char *)p + hdr->size + MEM_infosize(flags);  /* asm: full flags halfword, no &0xF */
    return result;
}

/* ===================================================================== *
 *  reservememadr @0x800E533C : allocate `size` bytes (named `name`) from  *
 *  class `classid`.  classid carries control bits: 0x10=allocate at the  *
 *  HIGH end, 0x20=pick the largest free block.  Returns the user pointer *
 *  (header+0x10) or NULL.                                                *
 * ===================================================================== */
extern "C" void *reservememadr(char *name, int size, int classid)   /* @0x800E533C */
{
    /* RESIDUAL (65 diffs, count-exact 128/129 off-by-1 frame slot): a systemic s0<->s1
     * register-coloring swap between `need` and `blk` runs through the WHOLE body (every
     * site that touches either). Tried: decl-order swap (need declared before/after blk,
     * both scopes) -- no change. Same allocator-priority-tie-break class as resize.cpp's
     * documented 3-way s2/s3/s4 rotation floor; not source-reachable via decl/order/type
     * tries so far. Accept as floor. */
    void     *result = 0;                              /* s5: single-exit funnel (MATCH: oracle
                                                           inits s5=0 up front and `j END` on both
                                                           failure paths without touching it) */
    int       need;                                    /* s1 */
    MemClass *cls   = gMemClassTable[classid & 0xF];   /* s3 */

    /* MATCH: `need = size` is the DELAY SLOT of the `size<8` branch -- it runs
     * UNCONDITIONALLY before the clamp-to-8 override (real bug fix vs the prior
     * else-only assignment). */
    need = size;
    if (size < 8) {
        if (size < 0) goto end;
        need = 8;                                      /* clamp to minimum */
    }

    {
        int  tail = MEM_tailsize(name, classid);       /* v0 */
        int  gran = cls->granularity;                  /* +0x28 */
        int  mask = gran - 1;                          /* s4 */
        unsigned rounded = ((unsigned)(need + tail) + (unsigned)(gran + 0x0F))
                         & (unsigned)(~mask);
        MemBlock *blk;                                 /* s0 */
        int  leftover;

        need = (int)rounded - 0x10;                    /* s1 = aligned span - 16 */

        if (classid & 0x20)
            blk = FREE_findlargest(cls, need, classid & 0x10);
        else
            blk = FREE_find(cls, need, classid & 0x10);
        if (blk == 0) goto end;

        FREE_remove(cls, blk);
        leftover = blk->size - need;                   /* v1 */

        if (leftover >= 0x41) {                         /* enough to split off a block */
            if (classid & 0x10) {
                /* HIGH split: keep front as free, carve the allocation from the top */
                MemBlock *front = blk;                                       /* s1 */
                MemBlock *alloc = (MemBlock *)((char *)blk + (leftover & ~mask)); /* s0 */
                front->physnext->physprev = alloc;
                alloc->physprev = front;
                alloc->physnext = front->physnext;
                initmemblock(front, 0, 0, 0, 0, front->physprev, alloc);
                FREE_add(cls, front);
                blk = alloc;
            } else {
                /* LOW split: allocation at the front, remainder freed */
                MemBlock *rem = (MemBlock *)((char *)blk + (need + 0x10));   /* s1 */
                blk->physnext->physprev = rem;
                initmemblock(rem, 0, 0, 0, 0, blk, blk->physnext);
                FREE_add(cls, rem);
                blk->physnext = rem;
            }
        }

        {   /* finalise the allocated block -- MATCH: mutate classid IN PLACE (no separate
               'flags' copy), the oracle ORs/ANDs classid's own register then stores it
               straight into the stack arg slot */
            if (name == 0) {
                classid |= (cls->flags & 0x700);
                classid &= ~0x100;
            }
            initmemblock(blk, name, size, cls->infosize, classid,
                         blk->physprev, blk->physnext);
        }
        result = (char *)blk + 0x10;                    /* user pointer */
    }
end:
    return result;
}

/* ===================================================================== *
 *  purgememadr @0x800E5540 : free a block, coalescing with free physical *
 *  neighbours on either side.  Always returns 1.                        *
 * ===================================================================== */
extern "C" int purgememadr(void *p)   /* @0x800E5540 */
{
    if (p != 0) {
        MemBlock *blk  = (MemBlock *)((char *)p - 0x10);     /* s0 */
        MemBlock *next = blk->physnext;                      /* s1 */
        /* read flags off the still-live incoming p (asm: lhu $v1,-0xE($a0)) -> root on p, not blk */
        MemClass *cls  = gMemClassTable[((unsigned short *)p)[-7] & 0xF]; /* s3; p-0xE == &blk->flags */
        MemBlock *prev = blk->physprev;                      /* s2 */

        if (prev->flags & 0x4000) {                          /* prev is free -> merge down */
            FREE_remove(cls, prev);
            blk  = prev;
            prev = blk->physprev;
            blk->physnext  = next;
            prev->physnext = blk;
            next->physprev = blk;
        }
        if (next->flags & 0x4000) {                          /* next is free -> merge up */
            FREE_remove(cls, next);
            next = next->physnext;
            blk->physprev  = prev;
            blk->physnext  = next;
            next->physprev = blk;
        }
        FREE_add(cls, blk);
    }
    return 1;
}

extern "C" { MemClass *gMemClassTable[16]; }  /* owning-TU def (BSS) -- at EOF for type visibility */
