# Lita Plugins: Lita-Handler #

## Einrichten der Arbeitsumgebung und Installation ##
Vorraussetzung für die folgenden Punkte ist die Installation von Lita.
Siehe _lita_installation.md_ 

## Testen des Handlers lita-way-to-go ##

Um lita-way-to-go zu starten, muss das Repository chatbots2 geklont werden:   
`git clone https://github.com/arbox/chatbot2.git`  
Dann in das Verzeichnis des Handlers wechseln und lita starten, z.B.:
```
cd ~/chatbot2/lita-way-to-go/
lita start
```
Es erscheint ein Prompt `>`. Mit `lita help` können verfügbare Befehle eingesehen werden (bspw. _lita way to LOCATION_).  
Befehlen, die in der Hilfe mit _"Lita:"_ beginnen, muss _"lita "_ vorangestellt werden, damit sie ausgeführt werden.  
Beispiel:
```
>lita way to Mensa
Many paths lead to Mensa.
```
 
# Erstellen eines Handlers für Lita #

***Anmerkung:*** Diese Beschreibung ist eine Kurzfassung eines Teils der [Dokumentation zu Lita-Handlern](https://docs.lita.io/plugin-authoring/handlers/), mit einigen Beispielen.

## Allgemeines ##
Lita-Handler fügen Lita neue Funktionalitäten zu. Sie werden bei Start des Chatbots geladen und setzen sich im Wesentlichen aus zwei Arten von Methoden zusammen:  
Routen (durchsuchen den Text aus dem Chat nach vorher definierten Mustern oder reagieren auf HTTP-Anfragen zu URLs) und Callbacks (werden ausgeführt,
sobald ein Muster gefunden wurde).

## Generatoren ##
Lita bietet Generatoren für Handler: Um einen neuen Handler mit allen nötigen Dateien und Verzeichnisstrukturen zu erstellen,
in das gewünschte Verzeichnis wechseln und in der shell `lita handler NAME_DES_HANDLERS` eingeben (NAME_DES_HANDLERS wird mit lita präfigiert, falls nicht schon eingegeben).  
Die somit erstellten Dateien ermöglichen das Veröffentlichen eines Lita-Handlers als Ruby-Gem (für Beispiele s. [Lita-Plugins](https://plugins.lita.io/#handlers)).    
Bisher hat der Handler noch keine Funktion. Diese wird in einer Ruby-Klasse spezifiziert (_PFAD_DES_REPOSITORYS/NAME_DES_HANDLERS/lib/lita/handlers/NAME_DES_HANDLERS.rb_).    
Prinzipiell wäre eine einzelne Ruby-Methode als Handler ausreichend, sofern diese in der Kofigurationsdatei von lita deklariert ist - der Ordnung und Veröffentlichbarkeit willen ist allerdings die Erstellung per Generator empfehlenswert.

## Routen ##

Das Kernstück des Handlers ist eine Ruby-Klasse, die von der Klasse _Lita::Handler_ oder einer der drei Unterklassen von Handler abgeleitet ist. Dadurch stehen einige Methoden zur Verfügung, mit denen zum Beispiel auf die Namen der Chatteilnehmer, Admins oder des eingegebenen Textes zugegriffen werden kann.  
Die zunächst wichtigsten Methoden sind Routen und Callbacks. Um ein bestimmtes Muster zu erkennen (also um einen Befehl für Lita entgegenzunehmen), wird die Methode _route_ mit bis zu fünf Argumenten aufgerufen (die letzten drei sind optional):  
1. Ein regulärer Ausdruck spezifiert das Muster, nach dem gesucht wird. 
2. Als zweites Argument wird der Name der Methode übergeben, die bei erkanntem Muster ausgeführt werden soll. Alternativ kann hier ein Block nachgestellt werden, in dem die gewünschte Funktionalität implementiert ist. Vorteil der ersten Variante ist allerdings die bessere Lesbarkeit, eine klare Trennung zwischen Routen und Callbacks sowie die Möglichkeit, ein und denselben Callback von verschiedenen Routen aus aufzurufen.  
3. _:command_ Wenn dieses Argument auf "true" gestetzt ist, muss der Befehl direkt an Lita gerichtet werden.
4. *:restrict_to* Bestimmt die Gruppen, deren Teilnehmer den Befehl ausführen dürfen. 
5. _:help_  Erläuterung der Funktion für die Hilfe (als Hash: EINGABE => VERHALTEN DER METHODE)  

Folgendes Beispiel soll das Erstellen einer Route mit dazugehörigem Callback veranschaulichen:  
Lita soll auf Anfrage ein Wort rückwärts ausgeben können (_marmor_ -> _romram_).  
Wir definieren unseren Aufruf der Methode _route_ folgendermaßen:  
```
route(/reverse (\w)/,:rev, command: true, help:{"reverse WORD" => "returns WORD in reverse"})
```
Das gesuchte Muster ist also der String "reverse " gefolgt von einer Kombination aus Zahlen, Unterstrich und Buchstaben. (/reverse (\w)/). Da _command_ den booleschen Wert "true" zugewiesen bekommt, muss lita direkt adressiert werden. Somit wären also folgende Aufrufe gültig:   
```
lita reverse rot
lita: reverse 54321
lita, reverse rotor
```
Sobald ein entsprechender Befehl an lita gerichtet wird, wird der Callback _:rev_ ausgeführt.


## Callbacks ## 

Da Callbacks gewöhnliche Ruby-Methoden sind, ist die Funktionalität von lita nur durch die Programmiersprache Ruby eingeschränkt. Der Methode muss ein _Lita::Response_-Objekt übergeben werden. Dieses response-Objekt stellt Methoden zur Verfügung, um zum Beispiel Text in Chats auszugeben (`response.reply`) oder auf das dem regulären Ausdruck entsprechende Muster zuzugreifen (`response.matches`).

Zurück zum Beispiel:  
Wird nun ein entsprechender Befehl an lita gerichtet, wird unsere Methode :rev aufgerufen. Diese müssen wir noch schreiben:
```
def rev(response)
  response.reply(response.matches[0][0].reverse)
end
```
Mithilfe der reply-Methode des Response-Objekts können wir das Ergebnis im Chat ausgeben. Dabei steuert der zweite Index des Arrays die durch den regulären Ausdruck "eingefangene" Klammer an, also in unserem Fall das Wort, was rückwärts ausgegeben werden soll.

## Weitere Möglichkeiten ##

Für weitere Methoden, die bei Callbacks verfügbar sind, siehe [Dokumentation](https://docs.lita.io/plugin-authoring/handlers/). Bspw. kann der Handler damit den Datenstrukturspeicher redis nutzen, http-Anfragen stellen, auf die lita-Konfigurationsdatei zugreifen, zu bestimmten Zeiten eine Aktion ausführen usw.  
Desweiteren kann das Verhalten der Callbacks für unterschiedliche Chatdienste variiert werden; dafür werden sog. Templates definiert, die das jeweilige Verhalten spezifizieren und in den Callbacks aufgerufen werden können.
