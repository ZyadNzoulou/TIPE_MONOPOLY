(*Création du type joueur, qui prend en compte sa position et son état*)
type player = {
  id: int;  
  risky: float;
  mutable pos: int;
  mutable in_jail: bool;
  mutable turns_injail: int;
  mutable doubles: int;
  mutable money: int;
  mutable properties: bool array
} 

(*Création du type propriété*)
type case_type = Marron | Bleu_Ciel | Rose | Orange | Rouge | Jaune | Vert | Bleu | Gare | ServPub | Go | Jail | Chance | Commu |Impot | Park | GoJail

type case = {
  id:int;
  name: string;
  c_type: case_type;
  price : int; 
  mutable rent : int;
  mutable isAvailable : bool;
  mutable ownedBy : int option
}

(*Création de la fonction mouvement*)
let go_to_jail pl =
  pl.in_jail <- true;
  pl.turns_injail <- 0;
  pl.pos <- 10

let move (pl:player) (moves:int)=
  (*On vérifie si le joueur est en prison*)
  if pl.in_jail && pl.turns_injail < 3 then () else
  pl.pos <- (pl.pos + moves) mod 39;
  (*On vérifie si on veut envoyer le joueur en prison et on vérifie si il est dans une case allez en prison*)
  if (pl.pos = 30) then go_to_jail pl


(*Jette un dè et renvoie sa valeur*)
let dice_roll () = (Random.int 6 + 1)
(*
let player_dr (pl:player) =
  let d1 = ref (dice_roll()) in
  let d2 = ref (dice_roll()) in
  if pl.in_jail && pl.turns_injail < 3 then
    if !d1 = !d2 then 
      begin
        pl.in_jail <- false;
        pl.doubles <- pl.doubles + 1; 
        move pl (!d1 + !d2);
      end
    else 
      pl.turns_injail <- pl.turns_injail + 1;
      if pl.turns_injail = 3 then pl.in_jail <- false
  else
    begin
      while !d1 = !d2 do 
        pl.doubles <- pl.doubles + 1;
        move pl (!d1 + !d2);
        if pl.doubles = 3 then go_to_jail pl
      done;
      move pl (!d1 + !d2)
    end
*)

  




(*Création du plateau de jeu*)

let (properties: case array) = [|
  {id = 0; name = "Départ"; c_type = Go; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 1; name = "Boulevard de Belleville"; c_type = Marron; price = 60; rent = 2; isAvailable = true; ownedBy = None };
  {id = 2; name = "Caisse de Communauté"; c_type = Commu; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 3; name = "Rue Lecourbe"; c_type = Marron; price = 60; rent = 4; isAvailable = true; ownedBy = None };
  {id = 4; name = "Impôts sur le Revenu"; c_type = Impot; price = 0; rent = 200; isAvailable = false; ownedBy = None };
  {id = 5; name = "Gare Montparnasse"; c_type = Gare; price = 200; rent = 25; isAvailable = true; ownedBy = None };
  {id = 6; name = "Rue de Vaugirard"; c_type = Bleu_Ciel; price = 100; rent = 6; isAvailable = true; ownedBy = None };
  {id = 7; name = "Chance"; c_type = Chance; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 8; name = "Rue de Courcelles"; c_type = Chance; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 9; name = "Avenue de la République"; c_type = Chance; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 10; name = "Prison"; c_type = Chance; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 11; name = "Boulevard de la Villette"; c_type = Rose; price = 140; rent = 10; isAvailable = true; ownedBy = None };
  {id = 12; name = "Compagnie de Distribution d'Électricité"; c_type = ServPub; price = 150; rent = 1; isAvailable = true; ownedBy = None };
  {id = 13; name = "Avenue de Neuilly"; c_type = Rose; price = 140; rent = 10; isAvailable = true; ownedBy = None };
  {id = 14; name = "Rue de Paradis"; c_type = Rose; price = 160; rent = 12; isAvailable = true; ownedBy = None };
  {id = 15; name = "Gare de Lyon"; c_type = Gare; price = 200; rent = 25; isAvailable = true; ownedBy = None };
  {id = 16; name = "Avenue Mozart"; c_type = Orange; price = 180; rent = 14; isAvailable = true; ownedBy = None };
  {id = 17; name = "Caisse de Communauté"; c_type = Commu; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 18; name = "Boulevard Saint Michel"; c_type = Orange; price = 180; rent = 14; isAvailable = true; ownedBy = None };
  {id = 19; name = "Place Pigalle"; c_type = Orange; price = 200; rent = 16; isAvailable = true; ownedBy = None };
  {id = 20; name = "Parc Gratuit"; c_type = Park; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 21; name = "Avenue Matignon"; c_type = Rouge; price = 220; rent = 18; isAvailable = true; ownedBy = None };
  {id = 22; name = "Chance"; c_type = Chance; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 23; name = "Boulevard Malsherbes"; c_type = Rouge; price = 220; rent = 18; isAvailable = true; ownedBy = None };
  {id = 24; name= "Avenue Henri-Martin"; c_type = Rouge; price = 240; rent = 20 ; isAvailable = true; ownedBy = None};
  {id = 25; name = "Gare du Nord"; c_type = Rouge; price = 200; rent = 1; isAvailable = true; ownedBy = None };
  {id = 26; name = "Faubourg Saint-Honoré"; c_type = Jaune; price = 260; rent = 22; isAvailable = true; ownedBy = None };
  {id = 27; name = "Place de la Bourse"; c_type = Jaune; price = 260; rent = 22; isAvailable = true; ownedBy = None };
  {id = 28; name = "Compagnie de Distribution des Eaux"; c_type = ServPub; price = 150; rent = 1; isAvailable = true; ownedBy = None };
  {id = 29; name = "Rue La Fayette"; c_type = Jaune; price = 280; rent = 24; isAvailable = true; ownedBy = None };
  {id = 30; name = "Allez en Prison"; c_type = GoJail; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 31; name = "Avenue de Breteuil"; c_type = Vert; price = 300; rent = 26; isAvailable = true; ownedBy = None };
  {id = 32; name = "Avenue Foch"; c_type = Vert; price = 300; rent = 26; isAvailable = true; ownedBy = None };
  {id = 33; name = "Caisse de Communauté"; c_type = Commu; price = 300; rent = 26; isAvailable = false; ownedBy = None };
  {id = 34; name = "Boulevard des Capucines"; c_type = Vert; price = 300; rent = 26; isAvailable = true; ownedBy = None };
  {id = 35; name = "Avenue Foch"; c_type = Vert; price = 300; rent = 26; isAvailable = true; ownedBy = None };
  {id = 36; name = "Chance"; c_type = Chance; price = 0; rent = 0; isAvailable = false; ownedBy = None };
  {id = 37; name = "Avenue des Champs-Elysées"; c_type = Bleu; price = 350; rent = 35; isAvailable = true; ownedBy = None };
  {id = 38; name = "Taxe de Luxe"; c_type = Impot; price = 0; rent = 100; isAvailable = false; ownedBy = None };
  {id = 39; name = "Rue de la Paix"; c_type = Bleu; price = 400; rent = 50; isAvailable = true; ownedBy = None };

|]

(*Création de la fonction d'achat*)
let buy player  =
  let property = properties.(player.pos) in
  if property.isAvailable && (player.money) >= property.price then begin
    property.isAvailable <- false;
    player.money <- player.money - property.price;
    (player.properties).(property.id) <- true
  end(*
  else if  player.money < property.price then Printf.printf "Position: %d Pas assez d'argent\n " player.pos*)

let random_buy player  =
  if Random.float 1.0 < player.risky then buy player 

let player_dr (pl:player)  =
  (*On veut les valeurs des deux dès de façon à ce qu'elles soient mutables*) 
  let d1 = ref (dice_roll()) in
  let d2 = ref(dice_roll()) in
  (*On vérifie si on a des premiers doubles*)
  if !d1 = !d2 || pl.turns_injail = 3 then begin 
    (*On sort de prison si on a deux doubles*)
    pl.in_jail <- false;
    move pl (!d1 + !d2);
    random_buy pl;
    (*On a le droit à un nouveau lancer de dès*)
    d1 := dice_roll();
    d2 := dice_roll();
      if !d1 = !d2 then begin 
      move pl (!d1 + !d2);
      random_buy pl ;
      (*On a le droit à un nouveau lancer de dès*)
      d1 := dice_roll();
      d2 := dice_roll();
      (*Si on a encore deux doubles on part en prison*)
        if !d1 = !d2 then go_to_jail pl else (move pl (!d1 + !d2); random_buy pl ;)
      end
    else
      move pl (!d1 + !d2);
      random_buy pl
  end
  else(
    move pl (!d1 + !d2);
    random_buy pl)

(*Partie simulation*)

(*Fonctions statistiques*)
let freq l = 
  let table = Hashtbl.create 38 in
    let rec func_aux l table =
      match l with
      |[] -> ()
      |a::b -> Hashtbl.replace table a ((Hashtbl.find table a) + 1); func_aux b table
    in
    for i=0 to 38 do Hashtbl.add table i 0 done; 
    func_aux l table;
    table

let freq_to_prob t n =
  let table = Hashtbl.create 39 in
  for i = 0 to 38 do
    Hashtbl.add table i ((float_of_int (Hashtbl.find t i))/.n)
  done;
  table

let properties_to_list pl =
  let l = ref [] in
  for i = 0 to 38 do
    if pl.properties.(i) then
      l := properties.(i).name::!l
  done;
  !l

(*Fonctions d'écriture des stats*)

let write_stats file_name table var_x var_y =
  let oc = open_out file_name in
  Printf.fprintf oc "%s, %s\n"var_x var_y;
  for i = 0 to 38 do
    Printf.fprintf oc "%d, %d\n" i (Hashtbl.find table i)
  done;
  close_out

let write_stats_float file_name table var_x var_y =
  let oc = open_out file_name in
  Printf.fprintf oc "%s, %s\n"var_x var_y;
  for i = 0 to 38 do
    Printf.fprintf oc "%d, %f\n" i (Hashtbl.find table i)
  done;
  close_out

let write_list file_name liste =
  let oc = open_out file_name in
  let l = ref liste in
  while !l != [] do
    Printf.fprintf oc "%s\n" (List.hd !l);
    l := List.tl !l
  done;
  close_out

let test () =
  let (player1:player) = {id = 0; risky = 0.5; pos = 0; in_jail = false; money = 1500; properties = (Array.make 39 false); turns_injail = 0; doubles = 0} in
  let pos_track = ref [0] in
  let i = ref 0 in
  while !i < 20000 do 
    player_dr player1;
    pos_track := player1.pos :: !pos_track;
    i := !i + 1;
  done;
  write_stats "frequences.csv" (freq !pos_track) "Numero_Case" "Fréquence";
  write_stats_float "probabilites.csv" (freq_to_prob (freq !pos_track) 20000.0) "Numero_Case" "Probabilité";
  write_list "proprietes.csv" (properties_to_list player1)
;;

test()