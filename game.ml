(*Creátion des classes du jeu*)
type player = {
  id: int;  
  risky: float;
  mutable pos: int;
  mutable in_jail: bool;
  mutable turns_injail: int;
  mutable money: int;
  mutable properties: bool array
} 

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

(*Tableau des propriétés*)
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

(*Création d'une fonction de mouvement*)

let go_to_jail pl =
  pl.in_jail <- true;
  pl.turns_injail <- 0;
  pl.pos <- 10

let move (pl:player) (moves:int) =
  if pl.in_jail && pl.turns_injail < 3 then pl.turns_injail <- pl.turns_injail + 1
  else
    pl.pos <- (pl.pos + moves) mod 40;
  if (pl.pos = 30) then go_to_jail pl


(*Jette un dè et renvoie sa valeur*)
let dice_roll () = Random.self_init(); (Random.int 6 + 1)

(*Fonction de jeu d'un joueur*)

(*Fonction achat*)
let buy pl =
  let property = properties.(pl.pos) in
  if property.isAvailable && (pl.money) >= property.price then
    begin
      property.isAvailable <- false;
      pl.money <- pl.money - property.price;
      (pl.properties).(property.id) <- true;
    end

let random_buy pl = Random.self_init ();
  if (Random.float 1.0) < pl.risky then buy pl
  
(*Fonction de jeu principale*)
let player_dr (pl:player) =
  let d1 = ref(dice_roll()) in
  let d2 = ref(dice_roll()) in
  let dbls = ref 0 in
  while (!d1 = !d2 && !dbls < 3 ) do
    dbls := !dbls + 1;
    move pl (!d1 + !d2);
    random_buy pl;
    d1 := dice_roll();
    d2 := dice_roll();
  done;
  if !dbls = 0 then
    move pl (!d1 + !d2);
    random_buy pl;
  if !dbls >= 3 then 
    go_to_jail pl

(*Partie simulation*)
let array_to_csv tab file_name var_x var_y =
  let oc = open_out file_name in
  Printf.fprintf oc "%s, %s\n" var_x var_y;
  for i = 0 to 39 do
    Printf.fprintf oc "%d, %d\n" i tab.(i)
  done;
  close_out

let array_to_csv_float tab file_name var_x var_y =
  let oc = open_out file_name in
  Printf.fprintf oc "%s, %s\n" var_x var_y;
  for i = 0 to 39 do
    Printf.fprintf oc "%d, %f\n" i tab.(i)
  done;
  close_out  

let array_to_proba tab =
  let n = Array.length tab in
  let total = ref 0 in
  let res = Array.make n 0.0 in
  for i = 0 to n-1 do
    total := !total + tab.(i);
  done;
  for i=0 to n-1 do
    let freq = float_of_int tab.(i) in
    let tot = float_of_int !total in
    res.(i) <- freq/.tot
  done;
  res


(*Initialisation d'un joeur*)
let create_player n risk =
  {id = n;
  risky = risk;
  pos = 0;
  in_jail = false;
  money = 1500;
  properties = Array.make 40 false;
  turns_injail = 0;}

(*Lancement d'un test à un joueur*)
let test () =
  let pl1 = create_player 1 0.5 in
  let i = ref 0 in
  let pos_track = Array.make 40 0 in
  pos_track.(0) <- 1;
  while !i < 100 do
    player_dr pl1;
    i := !i + 1;
    pos_track.(pl1.pos) <- pos_track.(pl1.pos) + 1
  done;
  array_to_csv pos_track "frequences.csv" "Case" "Frequence";
  let proba = array_to_proba pos_track in
  array_to_csv_float proba "probabilités.csv" "Case" "Probabilité"
;;

test()