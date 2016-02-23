fh=fopen(filename,'wt');
% xml vsebina
xml = ["<?xml version=\"1.0\"?> \n \
<quiz> \n \
  <question type=\"category\"> \n \
    <category><text>$course$/.koda</text></category> \n  \
  </question> \n  \
\n  \
<!-- question: 1  --> \n \
  <question type=\"description\"> \n \
      <name><text> ", kategorija, " \n \
      </text></name> \n \
    <questiontext format=\"html\"> \n \
	<text><![CDATA[<pre>", koda, "</pre>]]></text>\n \
    </questiontext>\n \
    <image></image>\n \
    <generalfeedback><text></text></generalfeedback>\n \
    <defaultgrade>0</defaultgrade><penalty>0</penalty>\n \
    <hidden>0</hidden><shuffleanswers>0</shuffleanswers>\n \
</question>\n \
  <question type=\"category\">\n \
      <category><text>$course$/",kategorija, "</text></category>\n \
  </question>\n\n"];
  
q_format = ["<!-- question: %d    -->\n \
  <question type=\"cloze\">\n \
      <name><text>%s %d</text></name>\n \
    <questiontext>\n \
	<text><![CDATA[%s]]></text>\n \
    </questiontext>\n \
    <shuffleanswers>0</shuffleanswers>\n \
</question>\n"];
% zaporedna vprašanja
for i = 1:st_vprasanj 
    xml = [xml sprintf(q_format,i,ime,i, besedilo(i,:))];
end
xml = [xml "\n</quiz>"];
fwrite(fh,xml);
fclose(fh);
