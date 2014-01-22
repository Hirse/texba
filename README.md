texba
=====

Template für Projekt- und Bachelorarbeiten für Duale Studenten der SAP

1. Miktex runterladen. Es muss nicht installiert werden, das Archive reicht.
2. Miktex zu den Umgebungsvariablen hinzufügen oder den Pfad auf Nachfrage eingeben 
   z.B. C:\ ... \MiKTeX\miktex\bin\
3. settings-template.tex kopieren und/oder in settings.tex umbenennen und ausfüllen
4. text/abstract.tex erstellen
5. text/text.tex erstellen
6. Bilder und Code in die entsprechenden Ordner einfügen
   Literatur in die bib/Quellen.bib eintragen
7. tex.bat ausführen



Verfügbare Kommandos zur Gliederung sind:
	\chapter{__INPUT__}
	\section{__INPUT__}
	\subsection{__INPUT__}
	\subsubsection{__INPUT__}

Einfügen von Bilder:
	\begin{figure}[ht!]
		\centering
		\includegraphics[scale=__INPUT[0-1]__]{\Imgpath __INPUT[Dateiname]__}
		\caption{__INPUT[Bildunterschrift]__}
		\label{__INPUT__} %optional
	\end{figure}

Einfügen von Code:
	\begin{figure}[h!]
		\lstinputlisting[language=__INPUT[Programmiersprache]__,caption={__INPUT[Bildunterschrift__}]{\Codepath __INPUT[Dateiname]__}
		\label{__INPUT__} %optional
	\end{figure}

Referenzieren von Labels:
	\autoref{__INPUT__}

Fußnoten:
	\footnote{__INPUT__}

Quellenverweis:
	\autocite[__INPUT[prenote]__][__INPUT[postnote]__]{__INPUT[key]__}