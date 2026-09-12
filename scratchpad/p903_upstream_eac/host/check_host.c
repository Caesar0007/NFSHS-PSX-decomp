/* P903 test harness only. Never compiled into reconstruction or PSX outputs. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include "eaclib/psx/eacpsxz/blkfill.h"
#include "eaclib/psx/eacpsxz/sinfunc.h"
#include "eaclib/psx/eacpsxz/sintbl.h"
#include "eaclib/psx/eacpsxz/fixddiv.h"
#include "eaclib/psx/eacpsxz/fixdinv.h"
#include "eaclib/psx/eacpsxz/fixdmult.h"

typedef char int_is_32[sizeof(int)==4 && sizeof(unsigned)==4 ? 1 : -1];
typedef char ll_is_64[sizeof(long long)==8 ? 1 : -1];
static unsigned checks, block_cases, angle_cases, mult_cases, div_cases, inv_cases;
static void check(int condition, const char *what, int a, int b) {
    ++checks;
    if (!condition) { fprintf(stderr,"FAIL %s a=%d b=%d\n",what,a,b); exit(1); }
}
static uint64_t magnitude(int a) { return a<0 ? (uint64_t)(-(int64_t)a) : (uint64_t)a; }
static unsigned divide_expected(int a,int b) {
    uint64_t q;
    if (!b) return 0;
    q=(magnitude(a)<<16)/magnitude(b);
    return ((a<0) != (b<0)) ? 0u-(unsigned)q : (unsigned)q;
}
static unsigned inverse_expected(int a) {
    uint64_t mag=magnitude(a),q=UINT32_MAX/mag,r=UINT32_MAX%mag;
    if (r>mag/2) ++q;
    return a<0 ? 0u-(unsigned)q : (unsigned)q;
}
static unsigned multiply_expected(int a,int b) {
    int64_t scaled=(int64_t)a*b+32768;
    /* Define floor without relying on the host's right shift of a negative. */
    int64_t q=scaled>=0 ? scaled/65536 : -((-scaled+65535)/65536);
    return (unsigned)q;
}
static int sine_expected(int a) {
    unsigned phase=(unsigned)a%1024u;
    unsigned index=phase%256u;
    if ((phase/256u)&1u) index=256u-index;
    return phase>=512u ? -sintbl[index] : sintbl[index];
}
static void angles(int a) {
    int s=sine_expected(a),c=sine_expected(a+256);
    check(intsin(a)==s,"sin quadrant",a,0);
    check(fastintsin(a)==s,"fast sin",a,0);
    check(intcos(a)==c,"cos quadrant",a,0);
    check(fastintcos(a)==c,"fast cos",a,0);
    ++angle_cases;
}
int main(void) {
    unsigned char actual[320],expected[320];
    static const unsigned values[]={0,1,0x7f,0x80,0xfe,0xff};
    static const int signed_values[]={INT_MIN,-2147483647,-1073741824,-1000000,-65537,-65536,
        -32768,-257,-256,-255,-3,-2,-1,0,1,2,3,255,256,257,32767,32768,
        65535,65536,65537,1000000,1073741824,INT_MAX};
    unsigned v,x,y;
    int offset,n,a,b;
    check(rdiv==fixeddiv,"rdiv address",0,0);
    check(rinverse==fixedinverse,"rinverse address",0,0);
    check(rmult==fixedmult,"rmult address",0,0);
    check(fastintcos==intcos,"fastintcos address",0,0);
    check(fastintsin==intsin,"fastintsin address",0,0);
    for (offset=0;offset<8;++offset) for(n=-7;n<=257;++n) {
        for(v=0;v<sizeof(values)/sizeof(values[0]);++v) {
            memset(actual,0xa5,sizeof(actual));memset(expected,0xa5,sizeof(expected));
            if(n>0) memset(expected+offset,(int)values[v],(size_t)n);
            blockfill(actual+offset,n,(unsigned char)values[v]);
            check(memcmp(actual,expected,sizeof(actual))==0,"blockfill sentinel",offset,n);
            ++block_cases;
        }
        memset(actual,0xa5,sizeof(actual));memset(expected,0xa5,sizeof(expected));
        if(n>0) memset(expected+offset,0,(size_t)n);
        blockclear(actual+offset,n);
        check(memcmp(actual,expected,sizeof(actual))==0,"blockclear sentinel",offset,n);
        ++block_cases;
    }
    for(a=-131072;a<131072;++a) angles(a);
    angles(INT_MIN);angles(INT_MIN+1);angles(INT_MAX-256);
    for(x=0;x<sizeof(signed_values)/sizeof(signed_values[0]);++x) {
        a=signed_values[x];
        if(a && a!=INT_MIN) {
            unsigned expected_inv=inverse_expected(a);
            check(fixedinverse(a)==expected_inv,"inverse signed",a,0);
            check(rinverse(a)==expected_inv,"inverse alias return",a,0);++inv_cases;
        }
        for(y=0;y<sizeof(signed_values)/sizeof(signed_values[0]);++y) {
            unsigned expected_mult,expected_div;
            a=signed_values[x];b=signed_values[y];
            expected_mult=multiply_expected(a,b);
            check((unsigned)fixedmult(a,b)==expected_mult,"multiply signed",a,b);
            check((unsigned)rmult(a,b)==expected_mult,"multiply alias return",a,b);++mult_cases;
            /* Do not claim portable coverage for pre-existing signed abs(INT_MIN)
             * or negation-of-INT_MIN fallback expressions. No source changes. */
            if(a==INT_MIN || b==INT_MIN) continue;
            expected_div=divide_expected(a,b);
            if(((a<0)!=(b<0)) && expected_div==0x80000000u) continue;
            check((unsigned)fixeddiv(a,b)==expected_div,"divide signed",a,b);
            check((unsigned)rdiv(a,b)==expected_div,"divide alias return",a,b);++div_cases;
        }
    }
    printf("{\"checks\":%u,\"block_cases\":%u,\"angle_cases\":%u,\"multiply_cases\":%u,\"divide_cases\":%u,\"inverse_cases\":%u,\"alias_addresses\":5,\"status\":\"PASS\"}\n",
        checks,block_cases,angle_cases,mult_cases,div_cases,inv_cases);
    return 0;
}
