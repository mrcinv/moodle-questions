name = 'vzporedna';
filename = [name '.xml'];
category = ['vektorji/' name];
odgovor_d = '{1:NUMERICAL:=%d:0.1}';
[doc,fun,testcode] = parsem(name);
fun = "function ...\n...\nendfunction\n";
code = char(fileread(mfilename("fullpathext")));
%=============================================
%            vprašanje
%============================================
questions_f = ["Skopirajte spodnjo kodo v datoteko <code>", name, ".m</code> in \
dopolnite funkcijo, kot je napisano v komentarjih.\n Svojo kodo lahko testirate \
z ukazom <code>test ",name,"</code> v <em>Octave</em>\
<pre><code>\n%s\n </code></pre> \
<br/> Vpišite rezultat, ki ga vrne <code>demo ",name,"</code>: ", odgovor_d];

%=============================================
%            podatki
%=============================================

% sestavi vprašanja
rand_regex = 'rand\("seed",([0-9]+)\)';
questions=[""];
% uporabljamo random, zato moramo nastaviti seed, če želimo ponovljivost
rand("seed",3241);
st_vprasanj = 10;

for i=1:st_vprasanj
  seed=randi(1e10);
  democode = example(name);
  randseed = ['rand("seed",',num2str(seed),")"];
  democode = regexprep(democode,rand_regex,randseed);
  eval(democode);
  testcode = regexprep(testcode, rand_regex,randseed);
  questions=[questions; sprintf(questions_f,[doc,fun,testcode],odgovor)];
end
                                % za zapis xml potrebujemo rezultate in questions
filename
write_moodle_xml(filename,questions, name, code, category)
