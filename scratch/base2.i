extern int ext(int,int);
struct S { int a[12]; };
struct S gsrc, gdst;
char *msg = "hello world";
enum E { E0, E1, E2 };
enum E ge;
int arr[100];
int f2(int i, int j){ gdst = gsrc; return ext(i,j) + ext(j,i) + arr[i] + (int)ge; }
int f3(int *p, int n){ int s=0,k; for(k=0;k<n;k++) s += p[k]*3; return s; }
