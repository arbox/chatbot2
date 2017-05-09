# Installation und Einrichtung

***Anmerkung:** diese Beschreibung ist weitestgehend eine Zusammenfassung der [Installationsanleitung von Lita](https://docs.lita.io/getting-started/installation/), mit einigen Ergänzungen und workarounds zu Problemen, die auftraten. Ich gehe von einem Debian-basierten System aus, obwohl die meisten Schritte unverändert auch auf anderen Systemen funktionieren.*

## Vagrant installieren

Das .deb Paket von https://www.vagrantup.com/downloads.html herunterladen und installieren.
Um zu prüfen, ob vagrant korrekt installiert wurde, im Terminal `vagrant`eingeben. Falls dabei ein Fehler  (`cannot load such file -- vagrant-share/helper/api (LoadError)`) auftritt, muss das Vagrant Plugin vagrant-share in der korrekten Version installiert werden. Dies geht über 
```
vagrant plugin install vagrant-share --plugin-version 1.1.8
```
[siehe dazu folgendes vagrant ticket](https://github.com/mitchellh/vagrant-aws/issues/509#issuecomment-298803049)


## Installiere Virtualbox

Z.B. mit `sudo apt install virtualbox`.


## Lita git repository clonen

```
git clone https://github.com/litaio/development-environment.git lita-dev
```


## Dev-Environment starten

```
cd lita-dev
vagrant up
```
Falls dabei eine Fehlermeldung bezüglich NFS support erscheint, müssen zuvor zwei Pakete nachinstalliert werden:
```
sudo apt install nfs-common nfs-kernel-server
```
[siehe dazu folgendes vagrant ticket](https://github.com/mitchellh/vagrant/issues/1534)

Dann können wir mit `vagrant ssh` in die VM gehen und mit  dem Befehl  `lita-dev` die Umgebung starten.


## Lita Projekt einrichten

Um ein neues Lita Projekt im aktuellen Verzeichnis zu starten, benutze
```
lita new .
```

Füge dem Gemfile den Namen des Wetter Plugins hinzu 
```
gem "lita-your-weather"
```
und installiere alle benötigten Ruby Pakete mittels
```
bundle
```

Lita kann dann mittels `lita start` gestartet werden.
Die bundle und lita Befehle funktionieren nur innerhalb des Lita Dev Environments, das Gemfile und die Konfigurationsdatei `lita_confif.rb`, die sich im Verzeichnis `workspace` befinden und mit denen unsere Lita Instanz eingerichtet wird, werden jedoch mit dem Host-System (also unserem eigenen Betriebssystem) geteilt und sind dort einfach editierbar (*und möglicherweise nur dort? Ich hab im dev env zumindest weder Vi noch nano gefunden..*). 

## lita-your-weather einrichten

Dieser handler benötigt (wie jeder Wetter-Handler) einen API-Key des Dienstes, über den das Wetter abgefragt wird. In diesem Fall ist das www.apixu.com.
Zuletzt müssen einige Einstellungen in der lita_config.rb Datei vorgenommen werden:
```
config.handlers.your_weather.default_location = 'your default City, State, Country'
config.handlers.your_weather.api_key = 'your www.apixu.com Api Key'
```
Nähere Informationen [im git repo von lita-your-weather](https://github.com/zoiec/lita-your-weather)

## lita-your-weather benutzen

Nach dem Start von Lita stehen uns zum Beispiel folgende Befehle zur Verfügung:
```
Lita: weather
Lita: weather f
Lita: weather Trier,Germany
Lita: weather f Trier, Germany
```
Die flag `f` bedeutet, dass nicht das aktuelle Wetter, sondern eine Vorhersage ("forecast") der nächsten 7 Tage angefragt wird. Das funktioniert aufgrund eines kleinen Bugs allerdings bis dato nur für die konfigurierte default-location. Einen Pull-Request mit dem Fix hab ich schon erstellt. Falls dieser nicht zeitnah eingespielt werden sollte, kann stattdessen lita-your-weather [aus meinem Fork](https://github.com/ben-tinc/lita-your-weather) installiert werden.
