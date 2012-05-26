# Histoire de la revue "Études rurales"

## Un exercice d'histoire des sciences sociales

Ce petit programme a pour fonction de collecter les données des sommaires des numéros de la revue Études rurales, qui sont librement accessibles sur [leur site web](etudesrurales.revues.org "Études rurales").

Le fichier `etu_rur.pl` est un exercice d'utilisation de Perl pour télécharger et analyser (parser) du HTML, avec les modules [WWW::Mechanize](http://search.cpan.org/~jesse/WWW-Mechanize-1.72/lib/WWW/Mechanize.pm) et [HTML::TreeBuilder](http://search.cpan.org/~jfearn/HTML-Tree-4.2/lib/HTML/TreeBuilder.pm).

Le résultat est donné sous la forme d'un fichier texte délimité par des tabulations, `etu_rur.txt`. Le script `etu-rur-auth.pl` calcule le nombre d'articles publiés dans la revue, par auteur.




<!-- # [en] History of "Études rurales"

## An exercise in the history of social science

This project is part of a research in social science, about the history of the studies of "rural worlds" in France in the 1950-1980 period.

We aim at collecting data about several academic papers, in particular "Études rurales" and "Économie rurale", to represent the network of the authors and the history of the research objects of this commmunity.
 -->
