name = 'nde1';
filename = [ime '.xml'];
category = ['nde/euler/' ime];
odgovor_f = '{1:NUMERICAL:=%f:0.00001}';

%=============================================
%            question
%============================================
question_f = ["Izračunaj rešitev začetnega problema za diferencialno enačbo\n \
$$ y'(x)=%s;\\\\quad y(0) = %f $$\n\
z Eulerjevo metodo na intervalu $[0,1]$.\
<br/> Vpiši $y(1)$:", odgovor_f, "\n in $y'(1)$:", odgovor_f];

%=============================================
%            data
%=============================================
data1 = ['y*sin(x)';'x*y'];
data_tex = ['y\sin(x)';'xy'];
data2 = [1; -1; 0];
% izračunaj odgovore
code = 'resitev = lsode(fun ,y0, [0,1]); y1 = resitev(2); dy1 = fun(resitev(2),1);';
[n m] = size(data1);
[k,l] = size(data2);
% sestavi vprašanja
questions="";
for i=1:n
  for j = 1:k
    fun=inline(data1(i,:),'y','x');
    y0=data2(j);
    eval(code);
    questions=[questions; sprintf(question_f,data_tex(i,:),data2(j),y1,dy1)];
  end
end

% za zapis xml potrebujemo rezultate in questions
write_moodle_xml(filename, questions, name, code, category)
