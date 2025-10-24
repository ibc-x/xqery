let $doc := doc("bibliotheques.xml")/bibliotheque

(: Insertion d'un nouveau livre :)
let $insert := 
  insert node
    <livre id="L2">
      <titre>XQuery en action</titre>
      <auteur>
        <prenom>Marie</prenom>
        <nom>Konaté</nom>
      </auteur>
    </livre>
  into $doc

(: Mise à jour du titre du livre avec id "L1" :)
let $update := 
  replace value of node
    $doc/bibliotheque/livre[@id="L1"]/titre
  with "XML et XQuery — Concepts et Pratiques"

(: Remplacement de l'auteur du livre avec id "L1" :)
let $replace := 
  replace node
    $doc/bibliotheque/livre[@id="L1"]/auteur
  with
    <auteur>
      <prenom>Issa</prenom>
      <nom>Coulibaly</nom>
    </auteur>

(: Suppression du livre avec id "L2" :)
let $delete := 
  delete node
    $doc/bibliotheque/livre[@id="L2"]

return
  <html>
    <body>
      <h2>Contenu actuel de la bibliothèque :</h2>
      {
        for $livre in $doc/bibliotheque/livre
        return
          <div style="margin-bottom:10px;">
            <h3>{ $livre/titre/text() }</h3>
            <p>Auteur : { $livre/auteur/prenom/text() } { $livre/auteur/nom/text() }</p>
          </div>
      }
    </body>
  </html>
