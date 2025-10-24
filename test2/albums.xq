

let $albums := doc("albums.xml")/albums/album
let $nombre := count( $albums )
let $min_annee := min( $albums/date/annee )
let $max_annee := max( $albums/date/annee )
return
element html {
element body {
"Il y a", $nombre, "albums de",
$min_annee, "à", $max_annee
}
}