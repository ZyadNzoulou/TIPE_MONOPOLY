(*Reste à faire:
   ->Moyennage de l'argent: chiant mais intéressant, il faudra dégager les outliers histoire d'avoir un nb de tours cohérent*)
(*Compilation:  ocamlc unix.cma game.ml -o exec *)

(*Creátion des classes du jeu*)
type player = {
  id: int; (*Identifiant unique au joueur*)
  risky: float; (*Paramètre de risque du joueur, utilise pour la simulation*)
  saving: float;
  mutable pos: int; (*Position du joueur sur le plateau de jeu*)
  mutable in_jail: bool; (*Statut du joueur: libre ou pas*)
  mutable turns_injail: int; (*Suit le nb de tours effectués en prison*)
  mutable money: int; (*Argent du joueur*)
  mutable properties: bool array; (*Représente les propriétés possédes par le joueur*)
  mutable nbH_color: int array; (*Suit le nb de 4 maison sur une propriété par couleur*)
  mutable nbH: int;
  mutable nbM: int;
  mutable jailCard: bool;
} 

type case_type = Marron | Bleu_Ciel | Rose | Orange | Rouge | Jaune | Vert | Bleu | Gare | ServPub | Go | Jail | Chance | Commu |Impot | Park | GoJail

type case = {
  id:int;
  name: string;
  c_type: case_type;
  price : int;
  smPrice : int;
  bgPrice : int;
  rent : int array;
  mutable isAvailable : bool;
  mutable ownedBy : player option;
  mutable nbHouses : int;
}

(*Tableau des propriétés*)
let (properties: case array) = [|
  {id = 0; name = "Départ"; c_type = Go; price = 0; smPrice = 50; bgPrice = 50; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0 };
  {id = 1; name = "Boulevard de Belleville"; c_type = Marron; price = 60; smPrice = 50; bgPrice = 50; rent = [|2;10;30;90;160;250|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 2; name = "Caisse de Communauté"; c_type = Commu; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 3; name = "Rue Lecourbe"; c_type = Marron; price = 60; smPrice = 50; bgPrice = 50; rent = [|4;20;60;180;320;450|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 4; name = "Impôts sur le Revenu"; c_type = Impot; price = 0; smPrice = 0; bgPrice = 0; rent = [|200;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 5; name = "Gare Montparnasse"; c_type = Gare; price = 200; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 6; name = "Rue de Vaugirard"; c_type = Bleu_Ciel; price = 100; smPrice = 50; bgPrice = 50; rent = [|6;30;90;270;400;550|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 7; name = "Chance"; c_type = Chance; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 8; name = "Rue de Courcelles"; c_type = Bleu_Ciel; price = 100; smPrice = 50; bgPrice = 50; rent = [|6;30;90;270;400;550|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 9; name = "Avenue de la République"; c_type = Bleu_Ciel; price = 120; smPrice = 50; bgPrice = 50; rent = [|8;40;100;300;450;600|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 10; name = "Prison"; c_type = Jail; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 11; name = "Boulevard de la Villette"; c_type = Rose; price = 140; smPrice = 0; bgPrice = 0; rent = [|10;50;150;450;625;750|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 12; name = "Compagnie de Distribution d'Électricité"; c_type = ServPub; price = 150; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 13; name = "Avenue de Neuilly"; c_type = Rose; price = 140; smPrice = 100; bgPrice = 100; rent = [|10;50;150;450;625;750|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 14; name = "Rue de Paradis"; c_type = Rose; price = 160; smPrice = 100; bgPrice = 100; rent = [|12;60;180;500;700;900|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 15; name = "Gare de Lyon"; c_type = Gare; price = 200; smPrice = 100; bgPrice = 100; rent = [|0;0;0;0;0;0|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 16; name = "Avenue Mozart"; c_type = Orange; price = 180; smPrice = 100; bgPrice = 100; rent = [|14;70;200;550;750;950|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 17; name = "Caisse de Communauté"; c_type = Commu; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 18; name = "Boulevard Saint Michel"; c_type = Orange; price = 180; smPrice = 100; bgPrice = 100;  rent = [|14;70;200;550;750;950|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 19; name = "Place Pigalle"; c_type = Orange; price = 200; smPrice = 100; bgPrice = 100; rent = [|16;80;220;600;800;1000|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 20; name = "Parc Gratuit"; c_type = Park; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 21; name = "Avenue Matignon"; c_type = Rouge; price = 220; smPrice = 150; bgPrice = 150; rent = [|18;90;250;700;875;1050|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 22; name = "Chance"; c_type = Chance; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 23; name = "Boulevard Malsherbes"; c_type = Rouge; price = 220; smPrice = 150; bgPrice = 150; rent = [|18;90;250;700;875;1050|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 24; name= "Avenue Henri-Martin"; c_type = Rouge; price = 240;  smPrice = 150; bgPrice = 150; rent = [|20;100;300;750;925;1100|]; isAvailable = true; ownedBy = None; nbHouses = 0 };
  {id = 25; name = "Gare du Nord"; c_type = Gare; price = 200; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 26; name = "Faubourg Saint-Honoré"; c_type = Jaune; price = 260; smPrice = 150; bgPrice = 150; rent = [|22;110;330;800;975;1150|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 27; name = "Place de la Bourse"; c_type = Jaune; price = 260; smPrice = 150; bgPrice = 150; rent = [|22;110;330;800;975;1150|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 28; name = "Compagnie de Distribution des Eaux"; c_type = ServPub; price = 150; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 29; name = "Rue La Fayette"; c_type = Jaune; price = 280; smPrice = 150; bgPrice = 150; rent = [|24;120;360;850;1025;1200|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 30; name = "Allez en Prison"; c_type = GoJail; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 31; name = "Avenue de Breteuil"; c_type = Vert; price = 300; smPrice = 200; bgPrice = 200; rent = [|26;130;390;900;1100;1275|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 32; name = "Avenue Foch"; c_type = Vert; price = 300; smPrice = 200; bgPrice = 200; rent = [|26;130;390;900;1100;1275|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 33; name = "Caisse de Communauté"; c_type = Commu; price = 300; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 34; name = "Boulevard des Capucines"; c_type = Vert; price = 300; smPrice = 200; bgPrice = 200; rent = [|28;150;450;1000;1200;1400|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 35; name = "Gare Saint-Lazare"; c_type = Gare; price = 200; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 36; name = "Chance"; c_type = Chance; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 37; name = "Avenue des Champs-Elysées"; c_type = Bleu; price = 350; smPrice = 200; bgPrice = 200; rent = [|50;200;600;1400;1700;2000|]; isAvailable = true; ownedBy = None; nbHouses = 0  };
  {id = 38; name = "Taxe de Luxe"; c_type = Impot; price = 0; smPrice = 0; bgPrice = 0; rent = [|100;0;0;0;0;0|];isAvailable = false; ownedBy = None; nbHouses = 0  };
  {id = 39; name = "Rue de la Paix"; c_type = Bleu; price = 400; smPrice = 200; bgPrice = 200; rent = [|50;200;600;1400;1700;2000|]; isAvailable = true; ownedBy = None; nbHouses = 0  };

|]


(*Création d'une fonction de mouvement*)

let go_to_jail pl =
  pl.in_jail <- true; (*Mise à jour statut du joueur*)
  pl.turns_injail <- 0; 
  pl.pos <- 10 (*Renvoie le joueur en prison*)

let move (pl:player) (moves:int) =
  if pl.in_jail && pl.turns_injail < 3 && (not pl.jailCard) then pl.turns_injail <- pl.turns_injail + 1 (*Si le joueur est en prison et qu'il n'a tjrs pas le droit de sortir*)
  else
    (*On s'assure de que le joueur est libre*)
    if pl.jailCard  && pl.in_jail then pl.jailCard <- false;
    pl.in_jail <- false;
    pl.turns_injail <- 0;
    if pl.pos + moves >= 40 then pl.money <- pl.money + 200; (*Si le joueur passe par la case départ il reçoit son argent*)
    pl.pos <- (pl.pos + moves) mod 40; (*Calcule la position du joueur après mouvement*)
  if (pl.pos = 30) then go_to_jail pl (*Case "Allez en prison"*)

let closestGare pl =
let pos = pl.pos in
  match pos with
  |p when p > 0 && p <=10 -> (if p > 5 then pl.money <- pl.money + 200); pl.pos <- 5
  |p when p > 10 && p <= 20 -> (if p > 15 then pl.money <- pl.money + 200); pl.pos <- 15
  |p when p > 20 && p <= 30 -> (if p > 25 then pl.money <- pl.money + 200); pl.pos <- 25
  |p when p > 30 && p <= 40 -> (if p > 35 then pl.money <- pl.money + 200); pl.pos <- 35
  |_ -> failwith "unexpected"
(*Cartes chances*)
let chance pl = 
  Random.self_init ();
  let property = properties.(pl.pos) in
  if property.c_type = Chance then begin
    let cId = 1 + Random.int (16) in
    match cId with
    |n when n = 1 -> pl.pos <- 39
    |n when n = 2 -> pl.pos <- 0
    |n when  n = 3 -> (if pl.pos > 24 then pl.money <- pl.money + 200); pl.pos <- 24
    |n when n = 4 -> (if pl.pos > 11 then pl.money <- pl.money + 200); pl.pos <- 11
    |n when n = 5 -> pl.money <- pl.money - 40*pl.nbM - 115*pl.nbH
    |n when n = 6 -> (if pl.pos > 15 then pl.money <- pl.money + 200); pl.pos <- 15
    |n when n = 7 -> pl.money <- pl.money + 100
    |n when n = 8 -> pl.money <- pl.money + 50
    |n when n = 9 -> pl.jailCard <- true (*Get out of jail card*)
    |n when n = 10 -> move pl (-3)
    |n when n = 11 -> go_to_jail pl
    |n when n = 12 -> pl.money <- pl.money - 25*pl.nbM - 100*pl.nbH
    |n when n = 13 -> pl.money <- pl.money - 15
    |n when n = 14 -> pl.money <- pl.money - 150
    |n when n = 15 -> pl.money <- pl.money - 20
    |n when n = 16 -> pl.money <- pl.money + 150
    |_ -> failwith "unexpected"
  end

let commu pl = 
  Random.self_init ();
  let property = properties.(pl.pos) in
  if property.c_type = Commu then begin
    let cId = 1 + Random.int (16) in
    match cId with
    |n when n = 1 -> pl.pos <- 0
    |n when n = 2 -> pl.money <- pl.money + 200
    |n when n = 3 -> pl.money <- pl.money - 50
    |n when n = 4 -> pl.money <- pl.money + 50
    |n when n = 5 -> pl.jailCard <- true (*Get out of jail card*)
    |n when n = 6 -> go_to_jail pl
    |n when n = 7 -> pl.pos <- 1
    |n when n = 8 -> pl.money <- pl.money + 100
    |n when n = 9 -> pl.money <- pl.money - 10 (*Anniversaire, j'ai un peu triché*)
    |n when n = 10 -> pl.money <- pl.money + 20
    |n when n = 11 -> pl.money <- pl.money + 25
    |n when n = 12 -> pl.money <- pl.money - 50
    |n when n = 13 -> if Random.int(2) = 0 then chance pl else pl.money <- pl.money - 10
    |n when n = 14 -> closestGare pl
    |n when n = 15 -> pl.money <- pl.money + 10
    |n when n = 16 -> pl.money <- pl.money + 100
    |_ -> failwith "unexpected"
  end

(*Jette un dè et renvoie sa valeur*)
let dice_roll () = Random.self_init(); (Random.int 6 + 1)

(*Convertit une couleur à un entier*)
let int_of_color (col:case_type) =
  match col with 
  |a when a = Marron -> 0
  |a when a = Bleu_Ciel -> 1
  |a when a = Rose -> 2
  |a when a = Orange -> 3
  |a when a = Rouge -> 4
  |a when a = Jaune -> 5
  |a when a = Vert -> 6
  |a when a = Bleu -> 7
  |_ -> failwith "n'est pas une couleur"

(*Renvoie le nb de prop associés à une couleur*)
let nbProp (col:case_type):int= 
  match col with
  |a when a = Marron -> 2
  |a when a = Bleu_Ciel -> 3
  |a when a = Rose -> 3
  |a when a = Orange -> 3
  |a when a = Rouge -> 3
  |a when a = Jaune -> 3
  |a when a = Vert -> 3
  |a when a = Bleu -> 2
  |_ -> failwith "n'est pas une couleur"

(*Vérifie qu'il s'agit d'une propriété où l'on peut peut placer des maisons*)
let isHousable (prop:case):bool = 
  let col = prop.c_type in
  match col with
  |a when a = Marron -> true
  |a when a = Bleu_Ciel -> true
  |a when a = Rose -> true
  |a when a = Orange -> true
  |a when a = Rouge -> true
  |a when a = Jaune -> true
  |a when a = Vert -> true
  |a when a = Bleu -> true
  |_ -> false

(*Fonction de jeu d'un joueur*)

(*Fonction achat*)
let buy pl =
  let property = properties.(pl.pos) in
  if property.isAvailable && (pl.money) >= property.price then (*Vérifie que le joueur a les moyens et que la propriété est libre*)
    begin
      property.isAvailable <- false;
      pl.money <- pl.money - property.price;
      (pl.properties).(property.id) <- true;
      property.ownedBy <- Some(pl)
    end
  else
    if isHousable property && pl.properties.(property.id) && property.nbHouses < 5 then (*Sinon on vérifie que le joueur possède la propriété et s'il n'a pas atteint le max de maisons*)
      let col = int_of_color property.c_type in
      match property.nbHouses with
      |a when a < 4 -> if pl.money >= property.smPrice then (*Cas où on a le droit d'acheter que des maisons*)
        pl.money <- pl.money - property.smPrice;
        property.nbHouses <- property.nbHouses + 1;
        pl.nbM <- pl.nbM + 1;
        if property.nbHouses = 4 then (pl.nbH_color.(col) <- pl.nbH_color.(col)+1) (*Si le joueur à 4 maisons sur une propriété on incrémente le compteur *)
      |a when a = 4 -> if pl.money >= property.bgPrice && pl.nbH_color.(col) = (nbProp property.c_type) then (*Cas où on a le droit d'acheter un  hôtel*)
        pl.money <- pl.money - property.bgPrice;
        property.nbHouses <- property.nbHouses + 1;
        pl.nbM <- pl.nbM - 4;
        pl.nbH <- pl.nbH + 1;
      |_ -> ()

(*Stratégie naïve*)
let naiveBuy pl =
  let property = properties.(pl.pos) in
  if (property.c_type = Orange || property.c_type = Jaune) then buy pl

let random_buy pl = Random.self_init (); (*Fonction d'achat aléatoire*)
  if (Random.float 1.0) < pl.risky then buy pl

let savBuy pl =
  let money = float_of_int pl.money in
  let sav = pl.saving in
  let property = properties.(pl.pos) in
  if pl.properties.(property.id) then begin
    if property.nbHouses < 4 then(
      let price = float_of_int property.smPrice in
      let ratio = price/.money in
      if ratio < sav then random_buy pl)
    else
      (
        let price = float_of_int property.bgPrice in
        let ratio = price/.money in
        if ratio < sav then random_buy pl) end
  else
    let price = float_of_int property.price in
    let ratio = price/.money in
    if ratio < sav then random_buy pl

(*Fonctions de paiement*)
let pay pl =
  let property = properties.(pl.pos) in
  let level = property.nbHouses in
  if not property.isAvailable then (*On vérifie que la propriété n'appartient pas au joueur*)
    match property.ownedBy with
    |None when isHousable property -> ()
    |None -> pl.money <- pl.money - property.rent.(0) (*Si elle n'appartient à personne, l'argent est retiré mais ne pars vers personne*)
    |Some(opp) -> (*Dans le cas où elle appartient à qqn, on transfère l'argent à qqn*)
      pl.money <- pl.money - property.rent.(level);
      opp.money <- opp.money + property.rent.(level);
    else ()
  
(*Fonction de jeu principale*)
let player_dr (pl:player) strat =
  (*On jette les dès et on récupère leur valeur*)
  let d1 = ref(dice_roll()) in
  let d2 = ref(dice_roll()) in
  (*Afin de compter le nombre de dès doubles obtenus*)
  let dbls = ref 0 in
  while (!d1 = !d2 && !dbls < 3 ) do (*Cas où on obtient des doubles, on a le droit de continuer à jouer*)
    dbls := !dbls + 1; (*Incrémentation du compteur*)
    move pl (!d1 + !d2);
    chance pl;
    commu pl;
    strat pl; (*Fonction d'achat*)
    pay pl; (*Fct paiement de loyer*) 
    d1 := dice_roll();
    d2 := dice_roll();
  done;
  if !dbls = 0 then
    move pl (!d1 + !d2);
    chance pl;
    commu pl;
    strat pl;
    pay pl;
  if !dbls >= 3 then (*Si le joueur obtient 3 doubles, il part directement en prison*)
    go_to_jail pl

(*Partie simulation*)
let array_to_csv tab file_name var_x var_y = (*Crée un fichier csv à partir d'un tableau*)
  let oc = open_out file_name in
  Printf.fprintf oc "%s,%s\n" var_x var_y;
  for i = 0 to 39 do
    Printf.fprintf oc "%d,%d\n" i tab.(i)
  done;
  close_out oc

let array_to_csv_float tab file_name var_x var_y = (*Idem cependant pour un tableau de float*)
  let oc = open_out file_name in
  Printf.fprintf oc "%s,%s\n" var_x var_y;
  for i = 0 to 39 do
    Printf.fprintf oc "%d,%f\n" i tab.(i)
  done;
  close_out oc

let array_to_proba tab = (*Crée un tableau de probabilités à partir d'un tableau d'entiers*)
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

let print_properties pl file_name = (*Copie les propriétés possédès par un joueur dans un fichier texte*)
  let oc = open_out file_name in
  for i = 0 to 39 do
    if pl.properties.(i) then Printf.fprintf oc "%s\n" properties.(i).name
    done;
  close_out oc

let print_list_int liste file_name = (*Crée un fichier texte à partir d'une liste d'entiers*)
  let oc = open_out file_name in
  let cl = ref liste in
  Printf.fprintf oc "Money\n";
  while !cl <> [] do
    Printf.fprintf oc "%d\n" (List.hd !cl);
    cl := List.tl !cl
  done;
  close_out oc

let printMoney l1 l2 file_name =
  let oc = open_out file_name in
  let cl1 = ref l1 in
  let cl2 = ref l2 in
  Printf.fprintf oc "Player 1,Player 2\n";
  while !cl1 <> [] && !cl2 <> [] do
    Printf.fprintf oc "%d,%d \n" (List.hd !cl1) (List.hd !cl2);
    cl1 := List.tl !cl1;
    cl2 := List.tl !cl2
  done;
  close_out oc

let colArray_to_csv tab file_name var_x var_y = (*Crée un fichier csv à partir d'un tableau*)
  let oc = open_out file_name in
  Printf.fprintf oc "%s,%s\n" var_x var_y;
  let col = [|"Marron"; "Bleu ciel"; "Rose"; "Orange"; "Rouge"; "Jaune"; "Vert"; "Bleu foncé"|] in
  for i = 0 to 7 do
    Printf.fprintf oc "%s,%d\n" col.(i) tab.(i)
  done;
  close_out oc

(*Initialisation d'un joueur*)
let create_player n risk sav =
  {id = n;
  risky = risk;
  saving = sav;
  pos = 0;
  in_jail = false;
  money = 1500;
  properties = Array.make 40 false;
  turns_injail = 0;
  nbH_color = Array.make 8 0;
  nbH = 0;
  nbM = 0;
  jailCard = false}

(*Lancement d'un test à un joueur*)
let test_1player nb = 
  let pl1 = create_player 1 0.5 0.25 in
  let i = ref 0 in
  let pos_track = Array.make 40 0 in
  let color_track = Array.make 8 0 in
  let money_track = ref [] in
  pos_track.(0) <- 1;
  while !i < nb do
    let property = properties.(pl1.pos) in
    player_dr pl1 naiveBuy;
    i := !i + 1;
    pos_track.(pl1.pos) <- pos_track.(pl1.pos) + 1;
    if isHousable property then color_track.(int_of_color property.c_type) <- (color_track.(int_of_color property.c_type) + 1); (*Vérifie que la présente case est une couleur et agit accordingly*)
    money_track := pl1.money :: !money_track
  done;
  (*print_properties pl1 "test_1pl_proprietes.csv";*)
  array_to_csv pos_track "Donnees/freqCase.csv" "Case" "Frequence";
  colArray_to_csv color_track "Donnees/freqCouleur.csv" "Couleur" "Frequence"
  (*let proba = array_to_proba pos_track in
  array_to_csv_float proba "test_1pl_probabilités.csv" "Case" "Probabilité";
  print_list_int !money_track "test_1pl_money.csv"*)

(*Lancement d'un test à deux joueurs*)
let test_2player () =
  (*Initialisation des joueurs avec leur identifiant et leur paramètre risque*)
  let pl1 = create_player 1 0.0 0.5 in
  let pl2 = create_player 2 0.5 0.5 in 
  (*Initialisation du traqueur de position pour chaque joueur*)
  let pos_track_pl1 = Array.make 40 0 in
  let pos_track_pl2 = Array.make 40 0 in
  (*Initialisation du compteur de tours*)
  let i = ref 0 in
  (*Initialisation du traqueur d'argent pour chaque joueur*)
  let money_track_pl1 = ref [1500] in
  let money_track_pl2 = ref [1500] in
  (*Fonction de nommage des fichiers csv par date et heure*)
  let aux_name () =
    let timeStr = string_of_float (Unix.gettimeofday ())  in
    "Donnees/2pl_MoneyEvolution" ^ timeStr ^ ".csv" (*Rq: ces fichiers contiennent l'évolution de l'argent pour les deux joueuurs*)
  in
  (*Les joueurs commencent à la case d'identifiant 0*)
  pos_track_pl1.(0) <- 1;
  pos_track_pl2.(0) <- 1;
  while pl1.money > 0 && pl2.money > 0 do (*Tant qu'aucun joueur n'a fait faillite on joue*)
    player_dr pl1 savBuy;
    player_dr pl2 savBuy;
    i := !i + 1;
    pos_track_pl1.(pl1.pos) <- pos_track_pl1.(pl1.pos) + 1;
    pos_track_pl2.(pl2.pos) <- pos_track_pl2.(pl2.pos) + 1;
    money_track_pl1 := pl1.money :: !money_track_pl1;
    money_track_pl2 := pl2.money :: !money_track_pl2
  done;
  (*----------------------------Fonctions Misc--------------------------------------*)
  (*print_properties pl1 "player1_test_2pl_proprietes.csv";*)(*
  array_to_csv pos_track_pl1 "player1_test_2pl_frequences.csv" "Case" "Frequence";
  let proba1 = array_to_proba pos_track_pl1 in
  array_to_csv_float proba1 "player1_test_2pl_probabilités.csv" "Case" "Probabilité";
  *)(*print_properties pl2 "player2_test_2pl_proprietes.csv";*)(*
  array_to_csv pos_track_pl2 "player2_test_2pl_frequences.csv" "Case" "Frequence";
  let proba2 = array_to_proba pos_track_pl2 in
  array_to_csv_float proba2 "player2_test_2pl_probabilités.csv" "Case" "Probabilité";*)
  (*------------------------------Fin des fonctions misc-----------------------------*)
  printMoney !money_track_pl1 !money_track_pl2 (aux_name ()); (*Création du fichier csv de l'évolution d'argent*)
  flush_all ();
  if pl1.money > 0 then 1 else 2 (*Renvoie l'id du joueur gagnant*)
;;

test_2player ();;



