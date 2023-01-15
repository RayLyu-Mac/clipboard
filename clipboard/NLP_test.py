import spacy
from PyPDF2 import PdfReader
from tkinter import Tk, filedialog

r = Tk()
r.withdraw()
filename = filedialog.askopenfilename()
print(filename)
r.clipboard_clear()
r.clipboard_append(filename)
r.update() # now it stays on the clipboard after the window is closed


nlp = spacy.load("en_core_web_sm")

reader = PdfReader("C:/Users/Bill Lin/PycharmProjects/tut4/Case Study.pdf")

number_of_pages = len(reader.pages)

page = reader.pages[5]

text = page.extract_text()

doc = nlp(text)

print(doc.ents)
r.destroy()