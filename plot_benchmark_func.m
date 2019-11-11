% 3D plot of benchmark function
syms x y
f = bm_f12([x y]);
colormap(jet);
fsurf(f);%, [-100 100]);