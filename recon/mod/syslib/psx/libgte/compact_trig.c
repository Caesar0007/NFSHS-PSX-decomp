/* Exact compact replacement data path for PsyQ CSTBL.  Public matrix entry points are kept out
 * until their call-level differential tests are ready; this helper proves the lookup semantics. */

typedef signed short s16;
typedef unsigned int u32;

static const s16 nfs4_gte_sin_quarter[1025] = {
#include "quarter_table.inc"
};

static int nfs4_gte_sin12(int angle)
{
    unsigned int a=(unsigned int)angle&4095;
    unsigned int quadrant=a>>10;
    unsigned int pos=a&1023;
    int value=nfs4_gte_sin_quarter[(quadrant&1)?1024-pos:pos];
    return (quadrant&2)?-value:value;
}

void nfs4_gte_sincos12(int angle,int *sine,int *cosine)
{
    *sine=nfs4_gte_sin12(angle);
    *cosine=nfs4_gte_sin12(angle+1024);
}

typedef struct Nfs4CompactMatrix {
    s16 m[3][3];
    int t[3];
} Nfs4CompactMatrix;

typedef struct Nfs4CompactSVector { s16 vx,vy,vz,pad; } Nfs4CompactSVector;

/* PsyQ's handwritten functions use `multu` and arithmetic-shift the low 32-bit word. */
static int nfs4_gte_mul12(int a,int b){return (int)((u32)a*(u32)b)>>12;}
static int nfs4_gte_mulneg12(int a,int b){return (int)(0-(u32)a*(u32)b)>>12;}
static int nfs4_gte_mixsub12(int a,int b,int c,int d){return (int)((u32)a*(u32)b-(u32)c*(u32)d)>>12;}
static int nfs4_gte_mixadd12(int a,int b,int c,int d){return (int)((u32)a*(u32)b+(u32)c*(u32)d)>>12;}

Nfs4CompactMatrix *nfs4_RotMatrix_compact(Nfs4CompactSVector *r,Nfs4CompactMatrix *m)
{
 int sx,cx,sy,cy,sz,cz,nsy;
 nfs4_gte_sincos12(r->vx,&sx,&cx);nfs4_gte_sincos12(r->vy,&sy,&cy);nfs4_gte_sincos12(r->vz,&sz,&cz);
 nsy=-sy;
 m->m[0][0]=(s16)nfs4_gte_mul12(cz,cy);
 m->m[0][1]=(s16)nfs4_gte_mulneg12(sz,cy);
 m->m[0][2]=(s16)sy;
 {int czsy=nfs4_gte_mul12(cz,nsy);int szsy=nfs4_gte_mul12(sz,nsy);
  m->m[1][0]=(s16)(nfs4_gte_mul12(sz,cx)-nfs4_gte_mul12(czsy,sx));
  m->m[1][1]=(s16)(nfs4_gte_mul12(cz,cx)+nfs4_gte_mul12(szsy,sx));
  m->m[2][0]=(s16)(nfs4_gte_mul12(sz,sx)+nfs4_gte_mul12(czsy,cx));
  m->m[2][1]=(s16)(nfs4_gte_mul12(cz,sx)-nfs4_gte_mul12(szsy,cx));}
 m->m[1][2]=(s16)nfs4_gte_mulneg12(cy,sx);
 m->m[2][2]=(s16)nfs4_gte_mul12(cy,cx);
 return m;
}

Nfs4CompactMatrix *nfs4_RotMatrixZ_compact(int angle,Nfs4CompactMatrix *matrix)
{
    int sine,cosine;
    int m00,m01,m02,m10,m11,m12;
    nfs4_gte_sincos12(angle,&sine,&cosine);
    m00=matrix->m[0][0];m01=matrix->m[0][1];m02=matrix->m[0][2];
    m10=matrix->m[1][0];m11=matrix->m[1][1];m12=matrix->m[1][2];
    matrix->m[0][0]=(s16)nfs4_gte_mixsub12(cosine,m00,sine,m10);
    matrix->m[0][1]=(s16)nfs4_gte_mixsub12(cosine,m01,sine,m11);
    matrix->m[0][2]=(s16)nfs4_gte_mixsub12(cosine,m02,sine,m12);
    matrix->m[1][0]=(s16)nfs4_gte_mixadd12(sine,m00,cosine,m10);
    matrix->m[1][1]=(s16)nfs4_gte_mixadd12(sine,m01,cosine,m11);
    matrix->m[1][2]=(s16)nfs4_gte_mixadd12(sine,m02,cosine,m12);
    return matrix;
}

