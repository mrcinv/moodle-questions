name = '0701';
filename = [name '.xml'];
category = ['nelinearne enačbe/regula falsi/' name];
odgovor_f = '{1:NUMERICAL:=%f:0.00001}';

%=============================================
%            vprašanje
%============================================
questions_f = ["Izračunaj rešitev enačbe\n \
\\\\[ %s=0 \\\\]\n\
z metodo regula falsi na intervalu \\\\([%f,%f]\\\\).\
<br/> Vpiši rešitev enačbe:", odgovor_f];

%=============================================
%            podatki
%=============================================
pod1 = ['sin(x)-1';'x^2-2'];
pod_tex = ['\\sin(x)';'x^2-2'];
pod2 = [0 pi; 0 2];
% izračunaj odgovore
code = 'resitev = fsolve(fun,x0);';
[n m] = size(pod2);
% sestavi vprašanja
questions="";
for i=1:n
    fun=inline(pod1(i,:),'x');
    x0=mean(pod2(i,:));
    eval(code);
    questions=[questions; sprintf(questions_f,pod_tex(i,:),pod2(i,:),resitev)];
end
% za zapis xml potrebujemo rezultate in questions
write_moodle_xml(filename,questions, name, code, category)
