@ECHO off
IF EXIST document/filename (
	SET /p pdfname=<document/filename
) ELSE (
	SET /p pdfname=Pdf name [document]: || SET pdfname=document
)
IF %pdfname:~-4% NEQ .pdf (
	SET pdfname=%pdfname%.pdf
)
ECHO %pdfname%>document/filename

CD document
ECHO Generating %pdfname% ...
pdflatex -quiet document
IF EXIST document.glo (
	makeindex -q -s document.ist -t document.glg -o document.gls document.glo
)
biber -q document
pdflatex -quiet document
pdflatex -quiet document
MOVE /y document.pdf ../"%pdfname%"
CD ..