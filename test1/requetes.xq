% -------------------------------
% 1. Requête XQuery avec XPath
% -------------------------------
\begin{verbatim}
//album[@serie="Tintin" and date/mois="août"]/titre
\end{verbatim}

% -------------------------------
% 2. Script XQuery simple
% -------------------------------
\begin{verbatim}
<html><body lang="fr">
Il y a { count( doc("albums.xml")/albums/album ) } albums.
</body></html>
\end{verbatim}

% -------------------------------
% 3. Génération d’éléments XML
% -------------------------------
\begin{verbatim}
element html {
  element body {
    attribute lang { "fr" },
    "Il y a",
    count(doc("albums.xml")/albums/album),
    "albums."
  }
}
\end{verbatim}

% -------------------------------
% 4. Affectation de variable
% -------------------------------
\begin{verbatim}
let $nombre := count( doc("albums.xml")/albums/album )
return <html><body>Il y a { $nombre } albums.</body></html>
\end{verbatim}

% -------------------------------
% 5. Affectations multiples
% -------------------------------
\begin{verbatim}
let $albums := doc("albums.xml")/albums/album
let $nombre := count( $albums )
let $min_annee := min( $albums/date/annee )
let $max_annee := max( $albums/date/annee )
return
element html {
  element body {
    "Il y a", $nombre, "albums de", $min_annee, "à", $max_annee
  }
}
\end{verbatim}

% -------------------------------
% 6. Conditionnelle
% -------------------------------
\begin{verbatim}
let $nombre := count( doc("albums.xml")/albums/album )
return <html><body>Il y a {
  if ($nombre > 20) then "de nombreux" else $nombre
} albums.</body></html>
\end{verbatim}

% -------------------------------
% 7. Structure with where
% -------------------------------
\begin{verbatim}
let $nombre := count( doc("albums.xml")/albums/album )
where ($nombre > 20)
return <html><body>Il y a de nombreux albums.</body></html>
\end{verbatim}

% -------------------------------
% 8. Boucle for
% -------------------------------
\begin{verbatim}
for $album in doc("albums.xml")/albums/album
return element tr { element td { $album/titre/text() } }
\end{verbatim}

% -------------------------------
% 9. Clause for avec énumération
% -------------------------------
\begin{verbatim}
for $i in (1 to 10) return $i * $i
\end{verbatim}

% -------------------------------
% 10. Boucle for avec distinct-values
% -------------------------------
\begin{verbatim}
let $albums := doc("albums.xml")//album
for $mois in distinct-values( $albums//mois )
return element tr {
  count(//album[date/mois=$mois]), "en", $mois
}
\end{verbatim}

% -------------------------------
% 11. Clause for sur attributs
% -------------------------------
\begin{verbatim}
for $attr_numero in doc("albums.xml")//album/@numero
let $numero := string($attr_numero)
return $numero
\end{verbatim}

% -------------------------------
% 12. Clause let dans boucle for
% -------------------------------
\begin{verbatim}
let $albums := doc("albums.xml")//album
for $mois in distinct-values( $albums//mois )
let $nombre := count( $albums[date/mois=$mois] )
let $titres := $albums[date/mois=$mois]/titre
return element titres {
  attribute nombre { $nombre }, attribute mois { $mois },
  $titres
}
\end{verbatim}

% -------------------------------
% 13. Clause where
% -------------------------------
\begin{verbatim}
let $albums := doc("albums.xml")//album
for $album in $albums
where $album/date/annee >= 1970
return $album
\end{verbatim}

% -------------------------------
% 14. Clause order by
% -------------------------------
\begin{verbatim}
for $album in doc("albums.xml")//album
let $titre := $album/titre
where starts-with($titre, "Tintin")
order by number($album//annee) descending
return $titre
\end{verbatim}

% -------------------------------
% 15. Boucles imbriquées
% -------------------------------
\begin{verbatim}
let $albums := doc("albums.xml")//album
for $mois in distinct-values( $albums//mois )
return element mois {
  attribute nom { $mois },
  for $album in $albums
  where $album/date/mois = $mois
  return $album/titre
}
\end{verbatim}

% -------------------------------
% 16. Insertion d’éléments
% -------------------------------
\begin{verbatim}
insert node
<album numero="25">
  <titre>Tintin et Astérix contre Spirou</titre>
</album>
into /albums

insert node element lu {} into /albums/album[@numero=1]
\end{verbatim}

% -------------------------------
% 17. Insertion sur plusieurs éléments
% -------------------------------
\begin{verbatim}
for $album in /albums/album
where $album/@numero >= 10
return insert node <achat date="2021-12-24"/> into $album
\end{verbatim}

% -------------------------------
% 18. Insertion multiple dans return
% -------------------------------
\begin{verbatim}
for $album in /albums/album
where $album/@numero >= 10
return (
  insert node <achat date="2021-12-24"/> into $album,
  insert node element lu {} into $album
)
\end{verbatim}

% -------------------------------
% 19. Insertion d’attribut
% -------------------------------
\begin{verbatim}
insert node attribute editeur {'Casterman'}
into /albums/album[@numero="13"]
\end{verbatim}

% -------------------------------
% 20. Suppression d’éléments ou attributs
% -------------------------------
\begin{verbatim}
delete node /albums/album[@numero="4"]
delete node /albums/album[date/mois="janvier"]
delete node /albums/album[date/annee>1950]/@numero
\end{verbatim}

% -------------------------------
% 21. Remplacement de valeur de nœud
% -------------------------------
\begin{verbatim}
replace value of node /albums/album[@numero=1]/titre
with 'nouveau titre'

replace value of node /albums/album[@numero=1]/@numero
with -1
\end{verbatim}

% -------------------------------
% 22. Remplacement d’un élément entier
% -------------------------------
\begin{verbatim}
replace node /albums/album[@numero=2]/date
with <auteur nom="hergé"/>
\end{verbatim}

% -------------------------------
% 23. Remplacement et regroupement
% -------------------------------
\begin{verbatim}
let $album := /albums/album[@numero=2]
return (
  replace node $album/date with <auteur nom="sempé"/>,
  replace value of node $album/@serie with 'sempe'
)
\end{verbatim}
