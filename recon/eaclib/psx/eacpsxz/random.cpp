/* eaclib/psx/eacpsxz/random.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\random.obj (EACPSXZ.LIB).  2 fns: random@0x800E77A8, seedrandom@0x800E7878.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  A 192-bit additive PRNG with carry.
 *
 *   State = six 32-bit words @0x8012349C (obj-local rodata->RW, materialized; init == seedrandom(0)).
 *   Each step folds the words together with full carry propagation, then increments the 192-bit
 *   counter, and returns the top word.  seedrandom loads the six words from a running sum of fixed
 *   constants offset by the seed.
 */

static unsigned g_rngstate[6] = {            /* @0x8012349C (== seedrandom(0)) */
    0xF22D0E56u, 0x883126E9u, 0xC624DD2Fu, 0x0702C49Cu, 0x9E353F7Du, 0x6FDF3B64u
};

extern "C" int random(void)   /* @0x800E77A8 */
{
    unsigned t0 = g_rngstate[0], t1 = g_rngstate[1], t2 = g_rngstate[2];
    unsigned t3 = g_rngstate[3], t4 = g_rngstate[4], t5 = g_rngstate[5];
    unsigned a1, a2;

    t4 += t5;  a1 = (t4 < t5);
    t3 += t4;  a2 = (t3 < t4);
    t3 += a1;  a1 = (t3 < a1);  a1 += a2;
    t2 += t3;  a2 = (t2 < t3);
    t2 += a1;  a1 = (t2 < a1);  a1 += a2;
    t1 += t2;  a2 = (t1 < t2);
    t1 += a1;  a1 = (t1 < a1);  a1 += a2;
    t0 += t1;
    t0 += a1;

    if (++t5 == 0)                            /* 192-bit increment (carry on word wrap) */
      if (++t4 == 0)
        if (++t3 == 0)
          if (++t2 == 0)
            if (++t1 == 0)
              ++t0;

    g_rngstate[0] = t0; g_rngstate[1] = t1; g_rngstate[2] = t2;
    g_rngstate[3] = t3; g_rngstate[4] = t4; g_rngstate[5] = t5;
    return (int)t0;
}

extern "C" void seedrandom(int seed)   /* @0x800E7878 */
{
    unsigned a = (unsigned)seed;
    a += 0xF22D0E56u; g_rngstate[0] = a;
    a += 0x96041893u; g_rngstate[1] = a;
    a += 0x3DF3B646u; g_rngstate[2] = a;
    a += 0x40DDE76Du; g_rngstate[3] = a;
    a += 0x97327AE1u; g_rngstate[4] = a;
    a += 0xD1A9FBE7u; g_rngstate[5] = a;
}
