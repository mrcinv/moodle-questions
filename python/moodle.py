def num_q(x,p=0.001):
    return "{1:NUMERICAL:=%f:%f#Pravilno~%f:%f#Premalo natančen odgovor}" % (x,p,x,10*p) 

def multi_q(answers):
    q  = "{1:MULTICHOICE:"
    for i in answers:
        q = q+"~%%%f%%%s\n" % (i[1],i[0])
    q = q+"}"
    return q
# usage
num_q(-1.2,0.001)

import sys

def multichoice_question(answers, name):
    q  = """<question type="multichoice">
    <name>
      <text> %s </text>
    </name>
    <questiontext format="html">
      <text><![CDATA[<p>Odkljukaj pravilne izjave!<br></p>]]></text>
    </questiontext>
    <generalfeedback format="html">
      <text></text>
    </generalfeedback>
    <defaultgrade>1.0000000</defaultgrade>
    <penalty>0.3333333</penalty>
    <hidden>0</hidden>
    <single>false</single>
    <shuffleanswers>true</shuffleanswers>
    <answernumbering>abc</answernumbering>
    <correctfeedback format="html">
      <text>Vaš odgovor je pravilen.</text>
    </correctfeedback>
    <partiallycorrectfeedback format="html">
      <text>Vaš odgovor je delno pravilen.</text>
    </partiallycorrectfeedback>
    <incorrectfeedback format="html">
      <text>Vaš odgovor je napačen.</text>
    </incorrectfeedback>
    <shownumcorrect/>""" %name
    for answer in answers:
        q = q + """
        <answer fraction="%f" format="html">
        <text><![CDATA[%s]]></text>
          <feedback format="html">
            <text></text>
          </feedback>
        </answer>
        """ % (answer[1],answer[0])
    q = q + "</question>"
    return q

def close_question(tekst, name):
    q = """
  <question type="cloze">
    <name>
        <text>%s</text>
    </name>
    <questiontext format="html">
        <text><![CDATA[%s]]></text>
    </questiontext>
    <generalfeedback format="html">
      <text></text>
    </generalfeedback>
    <penalty>0.2000000</penalty>
    <hidden>0</hidden>
  </question>
        """ % (name,tekst)
    return q

def moodle_xml(name, questions, iostream=sys.stdout):
    iostream.write("""
<?xml version="1.0" encoding="UTF-8"?>
<quiz>
<!-- question: 0  -->
  <question type="category">
    <category>
    <text>$course$/"""+name+"""</text>

    </category>
  </question>
    """)
    for i in range(len(questions)):
        iostream.write(multichoice_question(questions[i], name+str(i)))
    iostream.write("</quiz>")
print(multi_q([("12",50),("23",50),("34",-100)]))
