
restart -f

log -r /*

force clk 0 0, 1 20 ns -repeat 40 ns;
force rst 1 0, 0 3 ns;
force btn_in 16#31;

force psh(0) 0 0, 1 80 ns -repeat 100 ns;
force psh(1) 0 0, 1 980 ns -repeat 1000 ns;

run 17 ms;