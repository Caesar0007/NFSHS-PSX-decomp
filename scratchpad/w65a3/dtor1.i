struct A {
    int a;
    A();
    ~A();
    void f();
};

struct B : public A { int b; };

struct C : public B { int c; };

struct D : public C { int d; D(); ~D(); };

D::~D() { }

void useit(D *p) { p->~D(); }
void useit2(C *p) { p->~C(); }
void useit3(B *p) { p->~B(); }
