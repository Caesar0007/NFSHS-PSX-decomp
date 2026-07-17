typedef unsigned short u_short;
struct S3 { int c[3]; char n[3], f[3], r[3]; };
struct CC { short x,y,z,light; };
extern S3 *g3;
extern int gi3;
extern int fm(int,int);
void w3(void) {
  CC arr[4];
  short fx; short sx;
  int i;
  fx = (short)((signed char)g3[gi3].f[0] >> 1);
  sx = (short)(fm(5,6) >> 10);
  arr[0].x = sx - fx;
  fm(1,2);
  arr[1].x = sx + fx;
  for (i=1;i<3;i++) arr[i+1].x = *(u_short *)&arr[i].x + fx;
  fm((int)(long)arr, 0);
}
