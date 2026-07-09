/* syslib/psx/libc/BSEARCH.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\BSEARCH.obj ; libc.lib.  1 fn bsearch @0x801091DC (192 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Binary search over `n` elements of width `w`; cmp is called as cmp(element, key).
 *   mid=(lo+n)>>1, el=base+w*mid; c<0 -> lo=mid+1, c>0 -> n=mid, c==0 -> return el; loop while lo<n.
 *   Returns the matching element or 0.
 *   VERIFY: 48/48 insns, STRUCTURALLY EXACT (algorithm + control-flow match the oracle 1:1).  ~30-diff
 *   near-miss WALL: the only residuals are gcc's parameter->callee-saved-register coloring (oracle picks
 *   key->s5,base->s6,n->s3,w->s4,cmp->s7,lo->s2,mid->s0,el->s1; our build shuffles which s-reg holds which
 *   arg).  Not source-reachable -- decl-scope reorder tested, no effect; the mapping is decided by gcc's
 *   full liveness graph over 8 callee-saved regs.  No reference C body exists (psyz leaves it INCLUDE_ASM).
 */
extern void *bsearch(void *key, void *base, unsigned n, unsigned w,
                         int (*cmp)(void *, void *))   /* @0x801091DC */
{
    unsigned lo = 0;
    if (n != 0) {
        do {
            unsigned mid = (lo + n) >> 1;
            unsigned char *el = (unsigned char *)base + w * mid;
            int c = cmp(el, key);
            if (c < 0)
                lo = mid + 1;
            else if (c > 0)
                n = mid;
            else
                return el;
        } while (lo < n);
    }
    return (void *)0;
}
