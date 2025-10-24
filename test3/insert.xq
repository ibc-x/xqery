
insert node
<livre id="L2">
  <titre>XQuery en action</titre>
  <auteur>
    <prenom>Marie</prenom>
    <nom>Konaté</nom>
  </auteur>
</livre>
into doc("bibliotheques.xml")/bibliotheque



for $l in doc("bibliotheque.xml")/bibliotheque/livre,
    $c in doc("commandes.xml")/commandes/commande
where $l/@id = $c/livreId
return <resultat>
         <titre>{$l/titre/text()}</titre>
         <client>{$c/client/text()}</client>
         <quantite>{$c/quantite/text()}</quantite>
       </resultat>


