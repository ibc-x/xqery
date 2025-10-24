<html>
  <body>
    {
      for $livre in doc("bibliotheques.xml")/bibliotheque/livre
      return <div>
              <h3>{$livre/titre}</h3>
              <p>Auteur: {$livre/auteur/prenom} {$livre/auteur/nom}</p>
             </div>
    }
  </body>
</html>