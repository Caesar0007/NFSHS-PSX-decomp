struct A { int a; A(); ~A(); };
struct B : public A { int b; ~B(); };
struct C : public B { int c; ~C(); };
struct D : public C { int d; ~D(); };

B::~B() { }
C::~C() { }
D::~D() { }
