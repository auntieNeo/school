t0 = A + f;
t1 = B + g;
f = *t0;
t2 = t0 + 4;
t0 = *t2;
t0 += f;
*t1 = t0;

t0 = &A[f];
t1 = &B[g];
f = *t0;
t2 = t0 + 4;


