import sys

def num_q(x,p=0.001):
    """Return formatted string for numerical question, that can be included into
    cloze type moodle question.
    x ... correct answer, p ... precision
    """
    return "{1:NUMERICAL:=%f:%f#Pravilno~%f:%f#Premalo pravilnih decimalk}" % (x,p,x,10*p) 

def multi_q(answers):
    """Return formatted string for multichoice question, that can be included into
    cloze type moodle question.
    answers is a list of pairs (question, percent)
    """
    q  = "{1:MULTICHOICE:"
    for i in answers:
        q = q+"~%%%f%%%s\n" % (i[1],i[0])
    q = q+"}"
    return q

def multichoice_question(answers, name):
    """
    XML string for moodle multiple choice question.
    answers ... a list of pairs (answer,fraction),
              fraction tells how much percent is worth the answer 
    name ... name of the question
    """
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

def cloze_question(tekst, name):
    """
    XML string for moodle cloze question.
    tekst ... string with question in cloze format. (see
         https://docs.moodle.org/29/en/Embedded_Answers_(Cloze)_question_type )
    name ... name of the question
    """
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

def moodle_xml(name, questions, template_fun, category = '',iostream=sys.stdout):
    """Write moodle xml file to be imported into Moodle.
    name ... name of the category, where the questions will be put
    questions ... list of strings containing xml code for the questions
    template_fun ... cloze_question or multichoice_question
    category ... optional upper category (default '')
    iostream ... file handle or other IOStream (default STDOUT)
    """
    iostream.write("""
<?xml version="1.0" encoding="UTF-8"?>
<quiz>
<!-- question: 0  -->
  <question type="category">
    <category>
    <text>$course$/""" + category + name + """</text>

    </category>
  </question>
    """)
    for i in range(len(questions)):
        iostream.write(template_fun(questions[i], name+str(i)))
    iostream.write("</quiz>")
