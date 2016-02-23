ime = 'vzporedna';
filename = [ime '.xml'];
kategorija = ['vektorji/' ime];
odgovor_d = '{1:NUMERICAL:=%d:0.1}';
[doc,fun,testcode] = parsem(ime);
fun = "function ...\n...\nendfunction\n";
koda = char(fileread(mfilename("fullpathext")));
%=============================================
%            vprašanje
%============================================
besedilo_f = ["Skopirajte spodnjo kodo v datoteko <code>", ime, ".m</code> in \
dopolnite funkcijo, kot je napisano v komentarjih.\n Svojo kodo lahko testirate \
z ukazom <code>test ",ime,"</code> v <em>Octave</em>\
<pre><code>\n%s\n </code></pre> \
<br/> Vpišite rezultat, ki ga vrne <code>demo ",ime,"</code>: ", odgovor_d];

%=============================================
%            podatki
%=============================================

% sestavi vprašanja
rand_regex = 'rand\("seed",([0-9]+)\)';
besedilo=[""];
% uporabljamo random, zato moramo nastaviti seed, če želimo ponovljivost
rand("seed",3241);
st_vprasanj = 10;

for i=1:st_vprasanj
  seed=randi(1e10);
  democode = example(ime);
  randseed = ['rand("seed",',num2str(seed),")"];
  democode = regexprep(democode,rand_regex,randseed);
  eval(democode);
  testcode = regexprep(testcode, rand_regex,randseed);
  besedilo=[besedilo; sprintf(besedilo_f,[doc,fun,testcode],odgovor)];
end
% za zapis xml potrebujemo rezultate in besedilo
write_moodle_xml