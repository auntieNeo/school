t0 = 0;

loop:
if(y == 0)
  goto finish;
t0 += x;
y -= 1;
goto loop;

finish:
t0 += 10;
return t0 + 0;
