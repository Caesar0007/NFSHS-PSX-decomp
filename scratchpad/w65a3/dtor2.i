struct A {
    int a;
    A();
    ~A();
    void f();
};

struct B : public A { int b; ~B() {} };

struct C : public B { int c; ~C() {} };

struct D : public C { int d; ~D() {} };

void useit(D *p) { p->~D(); }
