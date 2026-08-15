struct A {
    int a;
    A();
    ~A();
    void f();
};

struct B : public A { int b; };
struct C : public B { int c; };
struct E : public B { int e; E(); };
struct F : public B { int f2; virtual void v(); };

B gB;

void del(C *p) { delete p; }

typedef void (*dp)(E *);
void *takeaddr();

E::E() { }

void useF(F *p) { p->~F(); }
