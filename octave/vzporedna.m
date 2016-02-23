% Funkcija rezultat = vzporedna (x,y)
% 
% Vrne 1(true), če sta dva vektorja x in y vzporedna, sicer vrne 0(false).
% Na primer: 
% 
% vzporedna([1,2,3], [2,4,6]) vrne true.

function ret = vzporedna(x,y)
  x = reshape(x,1,numel(x));
  y = reshape(y,1,numel(x));
  ret = rank([x;y]) < 2;
endfunction

%!assert (vzporedna([1,2,3],[2,4,6]), true)
%!error vzporedna([1,2,3,4],[1,2,3])
%!assert (vzporedna([1,2,3],[-1,-2,-3]),true)
%!assert (vzporedna([1,2+eps],[1,2]),true)
%!assert (vzporedna([0,1],[1,1]),false)
%!assert (vzporedna(zeros(10,1),ones(10,1)),true)
%!demo
%! rand("seed",123);
%! s = 0;
%! for i = 1:20
%!   x = rand(randi(100),1);
%!   if rand()<0.5
%! 	    s += 2^i*vzporedna(x,(0.5-rand())*x);
%!   else
%!      s += 2^i*vzporedna(x,rand(size(x)));
%!   end
%! end
%! odgovor = s
%! # ------------------------------------------------
%! # Na učilnici vpišite vrednost spremeljivke odgovor 
