import os
import sys
import fileinput
import re

#### Prepare the array for the original article
text = []
####  Read the file line by line.    
with open('tech4.tex', encoding='utf8') as f:
    for line in f:
        if line.rstrip():
####  split the sentences by the assigined seperators
            text.append(re.split('[，,。,：,！,？,\n]+',line))
