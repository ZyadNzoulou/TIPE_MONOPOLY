(*Création du type joueur, qui prend en compte sa position et son état*)
type player = {
  id: int;  
  risky: float;
  mutable pos: int;
  mutable in_jail: bool;
  mutable turns_injail: int;
  mutable money: int;
  mutable properties: bool array
} 

(*Création du type propriété*)
type property_type = Railroad | Utility | Plot

type color = Brown | Light_Blue | Pink | Orange | Red | Yellow | Green | Dark_Blue | Station | Utility | Void

type property = {
  id:int;
  p_color: color;
  price : int; 
  rent : int
}

(*Création de la fonction mouvement*)
let go_to_jail pl =
  pl.in_jail <- true;
  pl.pos <- 30 
let move (pl:player) (moves:int)=
  (*On vérifie si le joueur est en prison*)
  if pl.in_jail then () else  
  pl.pos <- pl.pos + moves;
  (*On vérifie si on veut envoyer le joueur en prison et on vérifie si il est dans une case allez en prison*)
  if (pl.pos = 30) then go_to_jail pl


(*Jette un dè et renvoie sa valeur*)
let dice_roll () = (Random.int 6 + 1)

let player_dr (pl:player) =
  (*On veut les valeurs des deux dès de façon à ce qu'elles soient mutables*) 
  let d1 = ref (dice_roll()) in
  let d2 = ref(dice_roll()) in
  (*On vérifie si on a des premiers doubles*)
  if !d1 = !d2 then begin 
    (*On sort de prison si on a deux doubles*)
    pl.in_jail <- false;
    move pl (!d1 + !d2);
    (*On a le droit à un nouveau lancer de dès*)
    d1 := dice_roll();
    d2 := dice_roll();
      if !d1 = !d2 then begin 
      move pl (!d1 + !d2);
      (*On a le droit à un nouveau lancer de dès*)
      d1 := dice_roll();
      d2 := dice_roll();
      (*Si on a encore deux doubles on part en prison*)
        if !d1 = !d2 then go_to_jail pl else move pl (!d1 + !d2) 
      end
    else
      move pl (!d1 + !d2) 
  end
  else
    move pl (!d1 + !d2) 

(*Création du plateau de jeu*)
let base_property = {id= -1; p_color = Void; price = 0; rent = 0}

let (properties: property array) = Array.make 28 base_property
let create_board () = let board = Hashtbl.create 40 in
    for i=0 to 39 do 
      Hashtbl.add board i (properties.(i))
    done;
    board
