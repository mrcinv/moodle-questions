## Function write_moodle_xml(filename, questions, name, code, category)
##
## writes quiz questions in moodle XML format to file named filename.

function write_moodle_xml(filename,questions, name, code, category)
  write_moodle_xml

  fh=fopen(filename,'wt');
                                % xml vsebina

  xml = ["<?xml version=\"1.0\"?> \n \
<quiz> \n \
  <question type=\"category\"> \n \
    <category><text>$course$/.code</text></category> \n  \
  </question> \n  \
\n  \
<!-- question: 1  --> \n \
  <question type=\"description\"> \n \
      <name><text> ", category, " \n \
      </text></name> \n \
    <questiontext format=\"html\"> \n \
	<text><![CDATA[<pre>", code, "</pre>]]></text>\n \
    </questiontext>\n \
    <image></image>\n \
    <generalfeedback><text></text></generalfeedback>\n \
    <defaultgrade>0</defaultgrade><penalty>0</penalty>\n \
    <hidden>0</hidden><shuffleanswers>0</shuffleanswers>\n \
</question>\n \
  <question type=\"category\">\n \
      <category><text>$course$/",category, "</text></category>\n \
  </question>\n\n"];

  q_format = ["<!-- question: %d    -->\n \
  <question type=\"cloze\">\n \
      <name><text>%s %d</text></name>\n \
    <questiontext>\n \
	<text><![CDATA[%s]]></text>\n \
    </questiontext>\n \
    <shuffleanswers>0</shuffleanswers>\n \
</question>\n"];
num_of_questions = size(questions,1); 
%% zaporedna vprašanja
for i = 1:num_of_questions
    xml = [xml sprintf(q_format,i,name,i, questions(i,:))];
end
xml = [xml "\n</quiz>"];
fwrite(fh,xml);
fclose(fh);
