%% Copyright Martin Vuk

%% -*- texinfo -*-
%% @deftypefn {Function File} {[@var{doc},@var{fun},@var{test}] =} parsem (mfile)
%% Parse @var{mfile} into documentation string @var{doc},
%% function body @var{fun} and test and demo code @var{test}
%% @seealso{}
%% @end deftypefn

function [doc,fun,test] = parsem(fncname)
  fn = which(fncname);
  fp = fopen(fn);
  store = {"","",""};
  idx = 1;
  while (ischar (l = fgets(fp)))
    if regexp(l,"^\s*function")
      idx = 2;
    elseif regexp(l,"^%!")
      idx = 3;
    end
    store{idx} = [store{idx},l];
    if regexp(l,"^\s*endfunction")
      idx = 3;
    end
  end
  doc = store{1};
  fun = store{2};
  test = store{3};
  fclose(fp); 

endfunction

% endfunction
