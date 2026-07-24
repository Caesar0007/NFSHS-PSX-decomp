/* syslib/psx/libc/BSEARCH.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\BSEARCH.obj ; libc.lib.  1 fn bsearch @0x801091DC (192 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Binary search over `n` elements of width `w`; cmp is called as cmp(element, key).
 *   mid=(lo+n)>>1, el=base+w*mid; c<0 -> lo=mid+1, c>0 -> n=mid, c==0 -> return el; loop while lo<n.
 *   Returns the matching element or 0.
 *   VERIFY: 48/48 insns, STRUCTURALLY EXACT (algorithm + control-flow match the oracle 1:1).
 *   30 -> 26-diff near-miss WALL: writing the mid computation as `(n + lo)` (matching the oracle's
 *   `addu v0,s2,s3`==lo+n operand ORDER once each var's home register is known) shaved 4 diffs purely
 *   by matching that one instruction's operand text; the residual is gcc's parameter->callee-saved-
 *   register coloring: oracle picks key->s5,base->s6,n->s3,w->s4,cmp->s7,lo->s2,mid->s0,el->s1; our
 *   build swaps BOTH (n,lo)->(s2,s3) and (cmp,w)->(s4,s7) as two independent pair-transpositions.
 *   Not source-reachable -- tried: mid*w vs w*mid (no effect on the swap), block-scoping lo inside the
 *   `if` (regressed 30->36, added a spill), hoisting w into a fresh `stride` local (regressed 30->30,
 *   added a save slot). The mapping is decided by gcc-2.8's full liveness-graph allocation over 8
 *   callee-saved regs, immune to every operand/decl-order lever tried. No reference C body exists
 *   (psyz leaves it INCLUDE_ASM).
 */
extern void *bsearch(void *key, void *base, unsigned n, unsigned w,
                         int (*cmp)(void *, void *))   /* @0x801091DC */
{
    unsigned lo = 0;
    if (n != 0) {
        do {
            unsigned mid = (n + lo) >> 1;
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
