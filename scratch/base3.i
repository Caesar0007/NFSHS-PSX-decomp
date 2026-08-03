extern int ext(int,int); extern void snk(int);
int arr[100]; int tbl[8];
static int helper(int x){ return x*5+1; }
int g(int n, int m){
  int a=n+1,b=m+2,c=n*m,d=n-m,e=n^m,i,s=0;
  for(i=0;i<n;i++){ s += arr[i]*3 + helper(i); }
  s += ext(a,b) + ext(c,d) + ext(e,s);
  snk(a); snk(b); snk(c); snk(d); snk(e);
  return s + a + b + c + d + e;
}
int h(int *p,int n){ int i,s=0; for(i=0;i<n;i++) s+=p[i]; return s; }
