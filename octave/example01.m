ime = '0701';
filename = [ime '.xml'];
kategorija = ['nelinearne enačbe/regula falsi/' ime];
odgovor_f = '{1:NUMERICAL:=%f:0.00001}';

%=============================================
%            vprašanje
%============================================
besedilo_f = ['Izračunaj rešitev enačbe\n \
\\[ %s=0 \\]\n\
z metodo regula falsi na intervalu \\([%f,%f]\\).\
<br/> Vpiši rešitev enačbe:', odgovor_f];

%=============================================
%            podatki
%=============================================
pod1 = ['sin(x)-1';'x^2-2'];
pod_tex = ['\\sin(x)';'x^2-2'];
pod2 = [0 pi; 0 2];
% izračunaj odgovore
koda = 'resitev = fsolve(fun,x0);';
[n m] = size(pod2);
% sestavi vprašanja
besedilo=[];
for i=1:n
    fun=pod1(i,:);
    x0=pod2(i,1);
    eval(koda);
    besedilo=[besedilo; sprintf(besedilo_f,pod_tex(i,:),pod2(i,:),resitev)];
end
% za zapis xml potrebujemo rezultate in besedilo
write_moodle_xml
