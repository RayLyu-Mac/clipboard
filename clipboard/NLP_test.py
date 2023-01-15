import spacy
from PyPDF2 import PdfReader
import sys
import os
print(sys.argv[1])
Direc = sys.argv[1]
nlp = spacy.load("en_core_web_sm")
for x in os.listdir(Direc):
    if x.endswith(".pdf") or x.endswith(".docx"):
        print(x)
        file_path = Direc+"\\"+x
        print(file_path)
        reader = PdfReader(file_path)

        number_of_pages = len(reader.pages)

        page = reader.pages[0]

        text = page.extract_text()

        doc = nlp(text)
        keywords = doc.ents
        print(doc.ents)


f = open("keywords_out.txt", "a")
for i in doc.ents:
    f.writelines(i.text)
f.close()

