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
  {id = 10; name = "Prison"; c_type = Chance; price = 0; smPrice = 0; bgPrice = 0; rent = [|0;0;0;0;0;0|]; isAvailable = false; ownedBy = None; nbHouses = 0  };
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
  pl.in_jail <- true;
  pl.turns_injail <- 0;
  pl.pos <- 10

let move (pl:player) (moves:int) =
  if pl.in_jail && pl.turns_injail < 3 then pl.turns_injail <- pl.turns_injail + 1
  else
    pl.in_jail <- false;
    pl.turns_injail <- 0;
    if pl.pos + moves >= 40 then pl.money <- pl.money + 200;
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
  else
    if pl.properties.(property.id) && property.nbHouses < 5 then
      match property.nbHouses with
      |a when a < 4 -> if pl.money >= property.smPrice then
        pl.money <- pl.money - property.smPrice;
        property.nbHouses <- property.nbHouses + 1
      |a when a = 4 -> if pl.money >= property.bgPrice then
        pl.money <- pl.money - property.bgPrice;
        property.nbHouses <- property.nbHouses + 1
      |_ -> failwith "Impossible"


let random_buy pl = Random.self_init ();
  if (Random.float 1.0) < pl.risky then buy pl

(*Fonctions de paiement*)
let pay pl =
  let property = properties.(pl.pos) in
  let level = property.nbHouses in
  if not property.isAvailable then 
    match property.ownedBy with
    |None -> pl.money <- pl.money - property.rent.(0)
    |Some(opp) -> 
      pl.money <- pl.money - property.rent.(level);
      opp.money <- opp.money + property.rent.(level);
    else ()
  
(*Fonction de jeu principale*)
let player_dr (pl:player) =
  let d1 = ref(dice_roll()) in
  let d2 = ref(dice_roll()) in
  let dbls = ref 0 in
  while (!d1 = !d2 && !dbls < 3 ) do
    dbls := !dbls + 1;
    move pl (!d1 + !d2);
    random_buy pl;
    pay pl;
    d1 := dice_roll();
    d2 := dice_roll();
  done;
  if !dbls = 0 then
    move pl (!d1 + !d2);
    random_buy pl;
    pay pl;
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

let print_properties pl file_name =
  let oc = open_out file_name in
  for i = 0 to 39 do
    if pl.properties.(i) then Printf.fprintf oc "%s\n" properties.(i).name
    done;
  close_out

let print_list_int liste file_name =
  let oc = open_out file_name in
  let cl = ref liste in
  while !cl <> [] do
    Printf.fprintf oc "%d\n" (List.hd !cl);
    cl := List.tl !cl
  done;
  close_out

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
let test_1player nb = 
  let pl1 = create_player 1 0.5 in
  let i = ref 0 in
  let pos_track = Array.make 40 0 in
  let money_track = ref [] in
  pos_track.(0) <- 1;
  while !i < nb do
    player_dr pl1;
    i := !i + 1;
    pos_track.(pl1.pos) <- pos_track.(pl1.pos) + 1;
    money_track := pl1.money :: !money_track
  done;
  print_properties pl1 "test_1pl_proprietes.csv";
  array_to_csv pos_track "test_1pl_frequences.csv" "Case" "Frequence";
  let proba = array_to_proba pos_track in
  array_to_csv_float proba "test_1pl_probabilités.csv" "Case" "Probabilité";
  print_list_int !money_track "test_1pl_money.csv"


(*Lancement d'un test à deux joueurs*)
let test_2player () =
  let pl1 = create_player 1 0.5 in
  let pl2 = create_player 2 0.5 in 
  let pos_track_pl1 = Array.make 40 0 in
  let pos_track_pl2 = Array.make 40 0 in
  let i = ref 0 in
  let money_track_pl1 = ref [1500] in
  let money_track_pl2 = ref [1500] in
  pos_track_pl1.(0) <- 0;
  pos_track_pl2.(0) <- 0;
  while pl1.money > 0 && pl2.money > 0 do
    player_dr pl1;
    player_dr pl2;
    i := !i + 1;
    pos_track_pl1.(pl1.pos) <- pos_track_pl1.(pl1.pos) + 1;
    pos_track_pl2.(pl2.pos) <- pos_track_pl2.(pl2.pos) + 1;
    money_track_pl1 := pl1.money :: !money_track_pl1;
    money_track_pl2 := pl2.money :: !money_track_pl2
  done;
  print_properties pl1 "player1_test_2pl_proprietes.csv";
  array_to_csv pos_track_pl1 "player1_test_2pl_frequences.csv" "Case" "Frequence";
  let proba1 = array_to_proba pos_track_pl1 in
  array_to_csv_float proba1 "player1_test_2pl_probabilités.csv" "Case" "Probabilité";
  print_properties pl2 "player2_test_2pl_proprietes.csv";
  array_to_csv pos_track_pl2 "player2_test_2pl_frequences.csv" "Case" "Frequence";
  let proba2 = array_to_proba pos_track_pl2 in
  array_to_csv_float proba2 "player2_test_2pl_probabilités.csv" "Case" "Probabilité";
  print_list_int !money_track_pl1 "player1_test_2pl_money.csv";
  print_list_int !money_track_pl2 "player2_test_2pl_money.csv"


;;
test_2player ()
(*test_1player 10000;;*)

