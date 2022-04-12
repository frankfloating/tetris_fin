(* --------------------------------- *)
(* --------------------------------- *)
(*   Types et fonctions graphique    *)
(* --------------------------------- *)
(* --------------------------------- *)

type t_point = {x : int ; y : int} ;;

(*draw_absolute_pt*)
let draw_absolute_pt(p, base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  let (p_dilat_x, p_dilat_y) : int * int = ((p.x * dilat) + base_draw.x, (p.y * dilat) + base_draw.y) in
  (
  set_color(col) ;
  draw_rect(p_dilat_x, p_dilat_y, dilat - 1, dilat - 1) ;
  )
;;
(*point multiplié par coefficient d'homothétie puis total ajouté au point base (nous faisons donc une translation).
puis nous faisons appel au fonctions graphique ocaml. Contour rectangle de longueur et largeur dilat - 1, de couleur col.*) 


(*fill_absolute_pt*)
let fill_absolute_pt(p, base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  let (p_dilat_x, p_dilat_y) : int * int = ((p.x * dilat) + base_draw.x, (p.y * dilat) + base_draw.y) in
  (
  set_color(col) ;
  fill_rect(p_dilat_x, p_dilat_y, dilat - 1, dilat - 1) ;
  )
;;
(*Rectangle rempli de largeur et longueur dilat - 1 de couleur col.*)


(*drawfill_absolute_pt*)
let drawfill_absolute_pt(p,  base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  (
  fill_absolute_pt(p, base_draw, dilat, col) ;
  draw_absolute_pt(p, base_draw, dilat, black)
  )
;;
(*appel aux fonctions précèdentes avec couleur du contour en noir et rempli de couleur col.*)


(*draw_relative_pt*)
let draw_relative_pt(p, base_point, base_draw, dilat, col : t_point * t_point * t_point * int * t_color) : unit =
  let (p_newx, p_newy) : int * int = (p.x + base_point.x, p.y + base_point.y) in
  draw_absolute_pt({x = p_newx ; y = p_newy}, base_draw, dilat, col)
;;
(*point translaté par base_point avec appel de fonction définie plus haut.*) 


(*fill_relative_pt*)
let fill_relative_pt(p, base_point, base_draw, dilat, col : t_point * t_point * t_point * int * t_color) : unit =
  let (p_newx, p_newy) : int * int = (p.x + base_point.x, p.y + base_point.y) in
  fill_absolute_pt({x = p_newx ; y = p_newy}, base_draw, dilat, col) 
;;
(*point translaté par base_point avec appel de fonction définie plus haut.*)


(*drawfill_relative_pt*)
let drawfill_relative_pt(p, base_point, base_draw, dilat, col : t_point * t_point * t_point * int * t_color) : unit =
  let (p_newx, p_newy) : int * int = (p.x + base_point.x, p.y + base_point.y) in
  drawfill_absolute_pt({x = p_newx ; y = p_newy}, base_draw, dilat , col)
;;
(*point translaté par base_point avec appel de fonction définie plus haut.*)


(*draw_pt_list*)
let rec draw_pt_list(l, base_pt, base_draw, dilat, col : t_point list * t_point * t_point * int * t_color) : unit =
  if isempty(l)
  then ()
  else
    (
    draw_relative_pt(fst(l), base_pt, base_draw, dilat, col) ;
    draw_pt_list(rem_fst(l), base_pt, base_draw, dilat, col)
    )
;;
(*récursivité. première conséquence lorsque conditionnel list l vide. Alternance avec appel de la fonction draw_relative_pt() puis de la fonction récursive avec list où le premier élément est retiré.*)


(*fill_pt_list*)
let rec fill_pt_list(l, base_pt, base_draw, dilat, col : t_point list * t_point * t_point * int * t_color) : unit =
  if isempty(l)
  then ()
  else
    (
    fill_relative_pt(fst(l), base_pt, base_draw, dilat, col) ;
    fill_pt_list(rem_fst(l), base_pt, base_draw, dilat, col)
    )
;;
(*Similaire à draw_pt_list() mais avec appel à la fonction fill_pt_list().*)


(*drawfill_pt_list*)
let drawfill_pt_list(l, base_pt, base_draw, dilat, col : t_point list * t_point * t_point * int * t_color) : unit =
  (
  fill_pt_list(l, base_pt, base_draw, dilat, col) ;
  draw_pt_list(l, base_pt, base_draw, dilat, black) ;
  )
;;
(*Fait appel aux deux fonctions précèdentes.*)


(*draw_frame*)
let draw_frame(base_draw, size_x, size_y, dilat : t_point * int * int * int) : unit =
  (
    for i = -1 to  size_y - 1
    do
       drawfill_absolute_pt({x = -1 ; y = i}, {x = base_draw.x ; y = base_draw.y}, dilat, black)
    done
  ) ;
  (
    for a = -1 to size_x - 1
    do
       drawfill_absolute_pt({x = a ; y = -1}, {x = base_draw.x ; y = base_draw.y}, dilat, black)
    done
  ) ;
  (
    for i = -1 to size_y - 1
    do
       drawfill_absolute_pt({x = size_x ; y = i}, {x = base_draw.x ; y = base_draw.y}, dilat, black)
    done
  )
;;
(*Trois boucles itératives, première pour le côté gauche du cadre, deuxième pour le bas et troisième pour côté droit. Le cadre entour l'espace d' affichage d'où le -1 et size_x comme coordonnés d'ancrage. Tous les boucles font appel à la fonction drawfill_absolute_pt() avec couleur noir.*)


(*fill_frame*)
let fill_frame(base_draw, mat_col, size_x, size_y, dilat : t_point * t_color *int * int * int) : unit =
  for x = 0 to size_x - 1
  do
    for y = 0 to size_y - 1
    do
      fill_absolute_pt({x = x ; y = y}, {x = base_draw.x ; y = base_draw.y}, dilat, mat_col)
    done
  done
;;
(*fonction d'extension pour la question 1. Boucles itératives imbriqués pour avoir accès à tous les points de l'espace d'affichage par fill_absolute_pt(). Sert à remplir l'espace d'affichage avec une couleur de fond choisit par mat_col.*) 

(* ------------------------------------------------- *)
(* ------------------------------------------------- *)
(*    Types, formes, parametrage et initialisation   *)
(* ------------------------------------------------- *)
(* ------------------------------------------------- *)


(* Types *)
type 'a t_array = {len : int ; value : 'a array} ;;

type t_shape = {shape : t_point list ; x_len : int ; y_len : int ;
                rot_rgt_base : t_point ; rot_rgt_shape : int ;
                rot_lft_base : t_point ; rot_lft_shape : int} ;;

type t_cur_shape = {base : t_point ref ; shape : int ref ; color : t_color ref} ;;


type t_param_time = {init : float ; extent : float ; ratio : float} ;;

(*type t_param_graphics*)
type t_param_graphics = 
  {base : t_point ; dilat : int ; color_arr : t_color t_array ; mat_col : t_color} ;;
(*ajout de mat_col : couleur d'espace "vide" de la matrice, pour extension question 1.*)

(*type t_bomb*)
type t_bomb = {bomb : bool ref ; bomb_pos : t_point ref} ;;
(*type pour extension libre avec bomb booléen pour savoir si la bomb existe sur l'espace de travail et bomb_pos pour les coordonnés.*)

type t_param = 
  {time : t_param_time ; 
   mat_szx : int ; mat_szy : int ;
   graphics : t_param_graphics ; 
   shapes : t_shape t_array
} ;;

(*type t_play*)
type t_play = {par : t_param ; cur_shape : t_cur_shape ; mat : t_color matrix ; score : int ref; bomb : t_bomb} ;;
(*ajout de score et bomb, extensions libres, score pour fonction graphique du même nom définie plus bas.*)

(* Initialisation de quelques formes et des parametres *)

let init_sh011() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 1 ; y = 0} ; {x = 2 ; y = 0} ; {x = 3 ; y = 0}]
  ; 
  x_len = 4 ; y_len = 1 ; 
  rot_rgt_base = {x = 1 ;  y = 1} ; rot_rgt_shape = 1 ; 
  rot_lft_base = {x = 2 ; y = 1} ; rot_lft_shape = 1} 
;;
let init_sh112() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 0 ; y = -2} ; {x = 0 ; y = -3}] ; 
  x_len = 1 ; y_len = 4 ; 
  rot_rgt_base = {x = -2 ;  y = -1} ; rot_rgt_shape = 0 ; 
  rot_lft_base = {x = -1 ; y = -1} ; rot_lft_shape = 0} 
;;
let init_sh211() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 1 ; y = 0} ; {x = 1 ; y = -1}] ; 
  x_len = 2 ; y_len = 2 ;
  rot_rgt_base = {x = 0 ;  y = 0} ; rot_rgt_shape = 2 ;
  rot_lft_base = {x = 0 ;  y = 0} ; rot_lft_shape = 2}
;;

(*shape extension*)
let init_sh300() : t_shape =
{shape = [{x = 0 ; y = 0} ; {x = 1 ; y = 0} ; {x = 1 ; y = -1} ; {x = 1 ; y = -2}] ;
x_len = 2 ; y_len = 3 ;
rot_rgt_base = {x = 2 ; y = 0} ; rot_rgt_shape = 4;
rot_lft_base = {x = 0 ; y = -1} ; rot_lft_shape = 6}
;;

let init_sh301() : t_shape =
{shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = -1 ; y = -1} ; {x = -2 ; y = -1}] ;
x_len = 3 ; y_len = 2;
rot_rgt_base = {x = -1 ; y = 0} ; rot_rgt_shape = 5;
rot_lft_base = {x = -2 ; y = 0} ; rot_lft_shape = 3}
;;

let init_sh310() : t_shape =
{shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 0 ; y = -2} ; {x = 1 ; y = -2}] ;
x_len = 2 ; y_len = 3 ;
rot_rgt_base = {x = -1 ; y = -1} ; rot_rgt_shape = 6 ;
rot_lft_base = {x = 1 ; y = 0} ; rot_lft_shape = 4}
;;

let init_sh311() : t_shape =
{shape = [{x = 0 ; y = 0} ; {x = 1 ; y = 0} ; {x = 2 ; y = 0} ; {x = 0 ; y = -1}] ;
x_len = 3 ; y_len = 2 ;
rot_rgt_base = {x = 0 ; y = 1} ; rot_rgt_shape = 3 ;
rot_lft_base = {x = 1 ; y = 1} ; rot_lft_shape = 5}
;;
(*extension libre : nouvelle forme (un L) avec quatre rotations possibles*)


(*init_shape*)
let init_shapes() : t_shape t_array =
  {len = 7 ; value = [| init_sh011() ; init_sh112() ; init_sh211() ; init_sh300() ; init_sh301() ; init_sh310() ; init_sh311()|]}
;;
(*rajout de la nouvelle forme (ses quatres variantes).*)

let init_color() : t_color t_array =
  {len = 7 ; value = [|blue ; red ; green ; yellow ; cyan ; magenta ; grey|]}
;;


let init_param() : t_param =
    {
    time = {init = 1.0 ; extent = 10.0 ; ratio = 0.8} ;
    mat_szx = 15; mat_szy = 28 ;
    graphics = {base = {x = 50 ; y = 50} ; dilat = 20 ; color_arr = init_color() ; mat_col = white} ;
    shapes = init_shapes()
    }
;;


(*fonctions d'extractions*)
let time_get(p : t_param) : t_param_time =
  p.time
;;


let mat_sz_get(pl : t_play) : (int * int) =
  (pl.par.mat_szx, pl.par.mat_szy)
;;


let graphics_get(pl : t_play) : t_param_graphics =
  pl.par.graphics
;;


let shapes_get(pl : t_play) : t_shape t_array =
  pl.par.shapes
;;


let cur_get(pl : t_play) : t_cur_shape =
  pl.cur_shape
;;

let cur_base_get(pl : t_play) : t_point =
  !(pl.cur_shape.base)
;;

let time_init(p : t_param) : float =
  p.time.init
;;

let time_extent(p : t_param) : float =
  p.time.extent
;;

let time_ratio(p : t_param) : float =
  p.time.ratio
;;
(*fonctions peu ou non utilisés, car définies soit après les fonctions qui suivent, soit ne permettent pas un gain de temps assez conséquent.*)


(*color_choice*)
let color_choice(t : t_color t_array) : t_color =
  let pos : int = rand_int(0, (t.len - 1)) in
  t.value.(pos)
;;
(*fonction retourne une couleur de type t_color choisit aléatoirement (rand_int), pos définie la position de la couleur dans la list de couleur (value).*)


(*valid_param*)
let valid_param(param : t_param) : bool =
  if param.mat_szx < 0 || param.mat_szy < 0
  then false
  else
    if param.graphics.dilat < 0
    then false
    else
      if param.graphics.base.x < 0 || param.graphics.base.y < 0
      then false
      else
        if param.time.init < 0.0 || param.time.extent < 0.0 || param.time.ratio < 0.0
        then false
        else true
;;
(*fonction d'extension de la question 2. Vérification se fait pour les variables avec valeurs de type int ou float avec retour booléen.*)


(*cur_shape_choice*)
let cur_shape_choice(shapes, mat_szx, mat_szy, color_arr : t_shape t_array * int * int * t_color t_array) : t_cur_shape =
  let shape_rand : int ref = ref(rand_int(0, shapes.len - 1)) in
  let x_len : int = shapes.value.(!(shape_rand)).x_len in
  let x_pos_max : int = (mat_szx - 1) - (x_len - 1) in
  let x_rand : int = rand_int(x_len - 1, x_pos_max) in
  let color_rand : t_color ref = ref(color_choice(color_arr)) in
  {base = ref({x = x_rand ; y = mat_szy - 1}) ; shape = shape_rand ; color = color_rand}
;;
(*fonction retourn type t_cur_shape, la forme en jeu. Coordonné x choisit alétatoirement entre 0 et position maximale pour pouvoir rentré dans l'espace d'affichage (prise en compte de la longueur horizontale de la forme). Coordonné y au point de la matrix le plus haut (point base de la forme toujours le plus haut à gauche dans cette ordre). Position de la forme dans la list value de init_shape() définie au aléatoirement. Couleur choisit aléatoirement par appel à la fonction color_choice() définie plus haut.*)


(*insert*)
let rec insert(cur, shape, param, mymat : t_cur_shape * t_point list * t_param * t_color matrix) : bool =
  if isempty(shape)
  then
    (
      let shape_bis : t_point list = param.shapes.value.(!(cur.shape)).shape in
      let base_pt : t_point = !(cur.base) in
      let base_draw : t_point = param.graphics.base in
      let dilat : int = param.graphics.dilat in
      let col : t_color = !(cur.color) in
      (
        drawfill_pt_list(shape_bis, base_pt, base_draw, dilat, col) ;
        true
      )
    )
  else
    let (sx, sy) : (int * int) = ((fst(shape)).x + !(cur.base).x, (fst(shape)).y + !(cur.base).y) in
    if mymat.(sx).(sy) <> param.graphics.mat_col 
    then false
    else insert(cur, rem_fst(shape), param, mymat)
;;
(*foncton récursive. Première conséquence lorsque la conditionnel list shape est vide : la forme est dessiné sur l'espace d'affichage et un booléen vraie (true) est renvoyé. L'alternance appel une nouvelle conditionnel : si la position du point (translation du point définissant la forme par le point base de la forme) de la forme courante dans la matrice, est différente de la couleur "vide", un booléen faux est renvoyé (false), sinon l'alternance rappel la fonction avec premier élément retiré.*) 


(*init_play*)
let init_play() : t_play =
  let param : t_param = init_param() in
  let mymat : t_color matrix = mat_make(param.mat_szx, param.mat_szy, param.graphics.mat_col) in
  let cur : t_cur_shape = cur_shape_choice(param.shapes, param.mat_szx, param.mat_szy, param.graphics.color_arr) in
  let shape : t_point list = param.shapes.value.(!(cur.shape)).shape in
  (
  open_graph(900, 900) ;
  draw_frame(param.graphics.base, param.mat_szx, param.mat_szy, param.graphics.dilat) ;
  fill_frame(param.graphics.base, param.graphics.mat_col, param.mat_szx, param.mat_szy, param.graphics.dilat) ;
  insert(cur, shape, param, mymat) ;
  score(0) ;
  {par = param ; cur_shape = cur ; mat = mymat ; score = ref(0) ; bomb = {bomb = ref(false) ; bomb_pos = ref({x = 0 ; y = 0})}}
  )
;;
(*fonction fait appel à la fonction graphique open_graph() de taille 900 sur 900 pixels. Puis de la fonction draw_frame(), fill_frame(), insert() et retourne un type t_play.*)

(* ------------------------------------------------- *)
(* ------------------------------------------------- *)
(*                 extensions libres                 *)
(* ------------------------------------------------- *)
(* ------------------------------------------------- *)

(*score*)
let score(s : int) : unit =
  set_color(yellow) ;
  fill_rect(500, 230, 300, 200) ;
  set_color(black) ;
  draw_rect(500, 230, 300, 200) ;
  moveto(630, 400) ;
  draw_string("score:") ;
  moveto(630, 330) ;
  draw_string(string_of_int(s)) ; 
;;
(*fait appel uniquement à des fonctions graphiques. Un rectangle de couleur jaune et de contour noir de longueur 300 et largeur 200 à la position x : 500 et y : 230. Puis text translaté à la position  x : 630 et y : 400 par la fonction moveto(). On affiche le text score avec la valeur du score en dessous.*)


(*highest_y*)
let highest_y(pl : t_play) : int =
  let mymat : t_color matrix = pl.mat in
  let y_pos : int ref = ref 0 in
  for y = 0 to pl.par.mat_szy - 1
  do
    for x = 0 to pl.par.mat_szx -1
    do
      if mymat.(x).(y) <> pl.par.graphics.mat_col
      then y_pos := y
      else ()
    done
  done ;
  !y_pos
;;
(*fonction qui retourn un entier, celui-ci défini le coordonné du point y occupé (par une couleur non vide) le plus haut dans la matrice. Boucles imbriquées pour avoir accès à tout les cases de la matrice. Conditionnel : si case différent de la couleur de la matrice définissant le "vide" et conséquence y_pos (valeur mutable) prend la valeur y.*)


(*bomb_pos*)
let bomb_pos(pl : t_play) : unit =
  let bomb_xpos : int = rand_int(0, pl.par.mat_szx - 1) in
  let y_pos : int = highest_y(pl) + 1 in
  let bomb_ypos : int = rand_int(y_pos,pl.par.mat_szy - 1) in
  pl.bomb.bomb_pos := {x = bomb_xpos ; y = bomb_ypos}
;;
(*fonction qui retourne coordonné aléatoirement pour la bomb. Position forcement au dessus de l'espace déjà occupé d'où l'appel à la fonction highest_y() ( + 1 car nous ne voulons pas que bomb remplace une case occupé)*)


(*bomb*)
let bomb(pl : t_play) : unit =
  let prob : int = rand_int(0, 10) in
  if !(pl.bomb.bomb)
  then ()
  else
    if prob = 10
    then
      (
        pl.bomb.bomb := true ;
        bomb_pos(pl) ;
        let b_pos : t_point = !(pl.bomb.bomb_pos) in
        let base : t_point = pl.par.graphics.base in
        let dilat : int = pl.par.graphics.dilat in
        pl.mat.(b_pos.x).(b_pos.y) <- black ;
        fill_absolute_pt({x = b_pos.x ; y = b_pos.y}, {x = base.x ; y = base.y}, dilat, black) ;
      )
    else ()
;;
(*Conséquence ne retourne rien si la bomb est en jeu (bomb = ref(true)), ou si la variable local n'est pas égale à 10 (dernière alternance). Si la conditionnel est vérifié (prob = 10), la bomb rentre en jeu (true), un appel à la fonction bomb_pos lui donne sa position, la couleur noir, qui represente la bomb est inséré dans la matrice et dans l'espace d'affichage*) 


(*explosion*)
let explosion(pl : t_play) : unit =
  let h_y : int = highest_y(pl) in
  let y_pos : int ref = ref h_y in
  if h_y > (pl.par.mat_szy - 6)
  then y_pos := pl.par.mat_szy - 6
  else () ;
  let explo_xpos : int = rand_int(0, pl.par.mat_szx - 6) in
  let explo_ypos : int = rand_int(0, !y_pos) in
  let base : t_point = pl.par.graphics.base in
  let dilat : int = pl.par.graphics.dilat in
  if !(pl.bomb.bomb)
  then
    (
    pl.bomb.bomb := false ;
    for x = explo_xpos to explo_xpos + 4
    do
      for y = explo_ypos to explo_ypos + 4
      do
        pl.mat.(x).(y) <- pl.par.graphics.mat_col ;
        fill_absolute_pt({x = x ; y = y}, {x = base.x ; y = base.y}, dilat, red) ;
      done
    done
    )
  else ()
;;
(*première conditionnel permet de ne pas mordre au-delà du point y le plus haut de la matrice (se qui serait hors limite de la matrice). La deuxième conditionnel vérifie que la bomb est bien en jeu et sa conséquence sort la bombe du jeu puis appel des boucles itératives imbriquées. Les coordonnés du point base de l'explosion sont définies aleatoirement par explo_xpos/y_pos, y_pos toujours entre 0 et le point y occupé le plus haut (à minimum 5 cases sont vidés par explosion). L'explosion fait 5 case sur 5. Les point de la matrice concérnés deviennent "vide" et graphiquement la position est définie par la couleur rouge (devient couleur "vide" après que la forme soit immobile), pour meilleur visibilité.*)  

(* -------------------------- *)
(* -------------------------- *)
(*    fonctions utilitaires   *)
(* -------------------------- *)
(* -------------------------- *)


let mywait(x : float) : unit =
  let y : float ref = ref (Sys.time()) in
  while (Sys.time() -. !y) < x
  do ()
  done
;;


(* ----------------------------------------------- *)
(* ----------------------------------------------- *)
(*    Deplacements et controle des deplacements    *)
(* ----------------------------------------------- *)
(* ----------------------------------------------- *)

(*valid_matrix_point*)
let valid_matrix_point(p, param : t_point * t_param) : bool =
  (
    ((p.x >= 0) && (p.y >= 0)) && ((p.x <= param.mat_szx - 1) && (p.y <= param.mat_szy- 1))
  )
;;
(*retourn booléen avec points extrèmes définissant la matrice.*)

(*is_free_move*)
let rec is_free_move(p, shape, mymat, param, pl : t_point * t_point list * t_color matrix * t_param * t_play) : bool =
  if isempty(shape)
  then true
  else
    let sx : int = (fst(shape)).x + p.x in
    let sy : int = (fst(shape)).y + p.y in
    if valid_matrix_point({x = sx ; y = sy}, param)
    then
      (
        if mymat.(sx).(sy) <> param.graphics.mat_col
        then
          (
            if mymat.(sx).(sy) = black
            then
              (
                explosion(pl) ;
                is_free_move(p, rem_fst(shape), mymat, param, pl)
              )
            else false
          )
        else is_free_move(p, rem_fst(shape), mymat, param, pl)
      )
    else false
;;
(*récursive, première conditionnel vérifié lorsque la list shape vide avec retour bool true. On vérifie chaque point définisant la forme translaté par le point p. Conditionnel qui suit vérifie que le point est dans la matrice, suivante si la position dans la matrice est occupé (de couleur non "vide"). Dernière conditionnel vérifie si cette couleur est noir (presence de la bomb), la conséquence est l'appel de la fonction explosion et de la fonction récursive avec list shape où premier élément est retiré. L'alternance de la troisième conditionnel est l'appel à la fonction récursive premier élément de la liste shape retiré.
Ajout de la variable d'entrée pl : pour explosion(). On aurait put tout remplacer par pl seulement mais cela permet une modification plus facile (si on veut retirer explosion()).*)


(*fonctions moves*)
let move_left(pl : t_play) : unit =
  let p : t_point = {x = !(pl.cur_shape.base).x - 1 ; y = !(pl.cur_shape.base).y} in
  let shape : t_point list = pl.par.shapes.value.(!(pl.cur_shape.shape)).shape in
  let mymat : t_color matrix = pl.mat in
  let param : t_param = pl.par in
  (
    if not(is_free_move(p, shape, mymat, param, pl))
    then ()
    else
      (
        let p_white : t_point = {x = !(pl.cur_shape.base).x ; y = !(pl.cur_shape.base).y} in
        let base_draw : t_point = param.graphics.base in
        let dilat : int = param.graphics.dilat in
        let col : t_color = !(pl.cur_shape.color) in
        let cur : t_cur_shape = cur_get(pl) in
        fill_pt_list(shape, p_white, base_draw, dilat, pl.par.graphics.mat_col) ;
        drawfill_pt_list(shape, p, base_draw, dilat, col) ;
        cur.base := p ;
      )
  )
;;


let move_right(pl : t_play) : unit =
  let p : t_point = {x = !(pl.cur_shape.base).x + 1 ; y = !(pl.cur_shape.base).y} in
  let shape : t_point list = pl.par.shapes.value.(!(pl.cur_shape.shape)).shape in
  let mymat : t_color matrix = pl.mat in
  let param : t_param = pl.par in
  (
    if not(is_free_move(p, shape, mymat, param, pl))
    then ()
    else
      (
        let p_white : t_point = {x = !(pl.cur_shape.base).x ; y = !(pl.cur_shape.base).y} in
        let base_draw : t_point = param.graphics.base in
        let dilat : int = param.graphics.dilat in
        let col : t_color = !(pl.cur_shape.color) in
        let cur : t_cur_shape = cur_get(pl) in
        fill_pt_list(shape, p_white, base_draw, dilat, pl.par.graphics.mat_col) ;
        drawfill_pt_list(shape, p, base_draw, dilat, col) ;
        cur.base := p ;
      )
  )
;;


let move_down(pl : t_play) : bool =
  let p : t_point = {x = !(pl.cur_shape.base).x ; y = !(pl.cur_shape.base).y - 1} in
  let shape : t_point list = pl.par.shapes.value.(!(pl.cur_shape.shape)).shape in
  let mymat : t_color matrix = pl.mat in
  let param : t_param = pl.par in
  (
    if not(is_free_move(p, shape, mymat, param, pl))
    then false
    else
      (
        let p_white : t_point = {x = !(pl.cur_shape.base).x ; y = !(pl.cur_shape.base).y} in
        let base_draw : t_point = param.graphics.base in
        let dilat : int = param.graphics.dilat in
        let col : t_color = !(pl.cur_shape.color) in
        let cur : t_cur_shape = cur_get(pl) in
        fill_pt_list(shape, p_white, base_draw, dilat, pl.par.graphics.mat_col) ;
        drawfill_pt_list(shape, p, base_draw, dilat, col) ;
        cur.base := p ;
        true
      )
  )
;;
(*commentées ensembles car même structure, sauf definition du point p. Conditionnel fait appel à la fonction is_free_move() et inverse son retour (not()), conséquence booléen retourné false. L'alternance "éfface" la forme courante (fill_pt_list() en blanc) et dessine la nouvelle forme avec drawfill_pt_list() puis le nouveau point base est pris par la variable mutable base du type t_cur_shape (point base de la forme courrante). Un booléen est retouné : true.*)


(*fonctions rotate*)
let rotate_right(pl : t_play) : unit =
  let rot_rx : int = pl.par.shapes.value.(!(pl.cur_shape.shape)).rot_rgt_base.x in
  let rot_ry : int = pl.par.shapes.value.(!(pl.cur_shape.shape)).rot_rgt_base.y in
  let p : t_point = {x = !(pl.cur_shape.base).x + rot_rx ; y = !(pl.cur_shape.base).y + rot_ry}  in
  let new_shape_pos : int = pl.par.shapes.value.(!(pl.cur_shape.shape)).rot_rgt_shape in
  let shape : t_point list = pl.par.shapes.value.(new_shape_pos).shape in
  let mymat : t_color matrix = pl.mat in
  let param : t_param = pl.par in
  (
    if not(is_free_move(p, shape, mymat, param, pl))
    then ()
    else
      (
        let old_shape : t_point list = pl.par.shapes.value.(!(pl.cur_shape.shape)).shape in
        let p_white : t_point = {x = !(pl.cur_shape.base).x ; y = !(pl.cur_shape.base).y} in
        let base_draw : t_point = param.graphics.base in
        let dilat : int = param.graphics.dilat in
        let col : t_color = !(pl.cur_shape.color) in
        let cur : t_cur_shape = cur_get(pl) in
        fill_pt_list(old_shape, p_white, base_draw, dilat, pl.par.graphics.mat_col) ;
        drawfill_pt_list(shape, p, base_draw, dilat, col) ;
        cur.base := p ;
        cur.shape := new_shape_pos ;
      )
  )
;;


let rotate_left(pl : t_play) : unit =
  let rot_lx : int = pl.par.shapes.value.(!(pl.cur_shape.shape)).rot_lft_base.x in
  let rot_ly : int = pl.par.shapes.value.(!(pl.cur_shape.shape)).rot_lft_base.y in
  let p : t_point = {x = !(pl.cur_shape.base).x + rot_lx ; y = !(pl.cur_shape.base).y + rot_ly}  in
  let new_shape_pos : int = pl.par.shapes.value.(!(pl.cur_shape.shape)).rot_lft_shape in
  let shape : t_point list = pl.par.shapes.value.(new_shape_pos).shape in
  let mymat : t_color matrix = pl.mat in
  let param : t_param = pl.par in
  (
    if not(is_free_move(p, shape, mymat, param, pl))
    then ()
    else
      (
        let old_shape : t_point list = pl.par.shapes.value.(!(pl.cur_shape.shape)).shape in
        let p_white : t_point = {x = !(pl.cur_shape.base).x ; y = !(pl.cur_shape.base).y} in
        let base_draw : t_point = param.graphics.base in
        let dilat : int = param.graphics.dilat in
        let col : t_color = !(pl.cur_shape.color) in
        let cur : t_cur_shape = cur_get(pl) in
        fill_pt_list(old_shape, p_white, base_draw, dilat, pl.par.graphics.mat_col) ;
        drawfill_pt_list(shape, p, base_draw, dilat, col) ;
        cur.base := p ;
        cur.shape := new_shape_pos ;
      )
  )
;;
(*commentées ensemble car même structure. même structure que les fonctions move avec differences : p change par translation par point de rotation. et alternance définit nouvelle position de la forme dans la list des formes, shape du type t_cur_shape.*)


(*move_at_bottom*)
let move_at_bottom(pl : t_play) : unit =
  let the_end : bool ref = ref true in
  while !the_end
  do
    the_end := move_down(pl)
  done ;
;;
(*boucle itérative tant que à pour conditionnel !the_end = true, booléen rendu par appel à move_down()*)


(* choix des deplacements suivant le caractere saisi *)
let move(pl, dir : t_play * char) : bool =
  (
  if dir = 't'
    then rotate_right(pl)
    else
      if dir = 'c'
      then rotate_left(pl)
      else
        if dir = 'd'
        then move_left(pl)
        else
          if dir = 'h'
          then move_right(pl)
          else () ;
  (dir = 'v')
  )
;;

(* ----------------------------------- *)
(* ----------------------------------- *)
(*    Suppression des lignes pleines   *)
(* ----------------------------------- *)
(* ----------------------------------- *)
(*is_column_full*)
let rec is_column_full(mymat, param, y, mat_szx : t_color matrix * t_param * int * int) : bool =
  if mat_szx = 0
  then true
  else
    if mymat.(mat_szx - 1).(y) = param.graphics.mat_col
    then false
    else is_column_full(mymat, param, y, mat_szx - 1)
;;
(*recursive. Première conséquence arrête la boucle et retourn booléen true si conditionnel vérifier. Deuxième conditionnel vérifie que le point x - 1 n'est pas de couleur "vide" avec conséquence arrêt boucle et retour booléen false. L'alternance appel la fonction récursive avec mat_szx soustrait de 1.*)


(*decal*)
let decal(mymat, y, szx, szy, par : t_color matrix * int * int * int * t_param) : unit =
  for a = 0 to szx - 1
  do
    for i = y + 1 to szy - 1
    do
      mymat.(a).(i - 1) <- mymat.(a).(i)
    done
  done
;;
(*boucles itératives imbriquées pour avoir accès à tous les cases de la matrice. La case de y - 1 prend la couleur de la case y et ainsi de suite.*)


(*clear_play*)
let clear_play(pl : t_play) : unit =
  let szy : int = pl.par.mat_szy in
  let szx : int = pl.par.mat_szx in
  let mat : t_color matrix = pl.mat in
  let graphics : t_param_graphics = pl.par.graphics in
  clear_graph() ;
  draw_frame(graphics.base, szx, szy, graphics.dilat) ;
  bomb(pl) ;
  for y = 0 to szy - 1
  do
    if is_column_full(mat, pl.par, y, szx)
    then
      (
        pl.score := !(pl.score) + 1 ;
        decal(mat, y, szx, szy, pl.par) ;
        score(!(pl.score)) 
      )
    else () ;
    for x = 0 to szx -1
    do
      if mat.(x).(y) <> white
      then drawfill_absolute_pt({x = x ; y = y}, graphics.base, graphics.dilat, mat.(x).(y))
      else ()
    done
  done 
;;
(*fonction fait appel à clear_garph() pour éffacer le contenue de la fenêtre graphique, puis draw_frame() pour dessiner le cadre. bomb() est appelé ici car clear_play() est appelé lorsque la forme est immobile (le choix se faisait entre cette fonction et insert(), choix c'est aussi fait car variable d'entrée est pl). Première boucle itérative pour avoir accès à chaque ligne (car is_column_full() parcourt tout les points x de la matrice), conditionnel par retour de la fonction is_column_full() avec conséquence l'appel à decal() et score(), l'alternance est vide. La sous boucle a une fonction graphique : elle dessine l'espace d'affichage mise à jour (les positions où une couleur est présente).*)


(*final_insert*)
let rec final_insert(cur, shape, mymat : t_cur_shape * t_point list * t_color matrix) : unit =
  let base_pt : t_point = !(cur.base) in
  if isempty(shape)
  then ()
  else
    (
      let st : t_point = {x = (fst(shape)).x + base_pt.x ; y = (fst(shape)).y + base_pt.y } in
      mymat.(st.x).(st.y) <- !(cur.color) ;
      final_insert(cur, rem_fst(shape), mymat)
    )
;;
(*récursive. Accès à la conséquence par list shape vide. Alternance permet d'inserer le carré de la forme immobile dans la matrice puis de faire appel à la fonction récursive avec la list shape sans son premier élément.*)


(*final_newstep*)
let final_newstep(pl : t_play) : bool =
  let cur : t_cur_shape = pl.cur_shape in
  let p : t_point = !(cur.base) in
  let shape : t_point list = pl.par.shapes.value.(!(cur.shape)).shape in
  let mymat : t_color matrix = pl.mat in
  let param : t_param = pl.par in
  let py_move : t_point = {x = p.x ; y = p.y - 1} in
  if is_free_move(py_move, shape, mymat, param, pl)
  then false
  else
    (
      let shapes : t_shape t_array = pl.par.shapes in
      let mat_szx : int = pl.par.mat_szx in
      let mat_szy : int = pl.par.mat_szy in
      let color_arr : t_color t_array = pl.par.graphics.color_arr in
      let new_cur : t_cur_shape = cur_shape_choice(shapes, mat_szx, mat_szy, color_arr) in
      final_insert(cur, shape, mymat) ;
      clear_play(pl) ;
      cur.base := !(new_cur.base) ;
      cur.shape := !(new_cur.shape) ;
      cur.color := !(new_cur.color) ;
      not(insert(cur, shape, param, mymat))
    )
;;
(*Conséquence retourne le booléen false. L'alternance fait appel à final_insert(), clear_play() et par l'intermédiaire de cur_shape_choice(), une nouvelle forme est choisit (on change donc les variables mutables base, shape et color avec les nouvelles valeures). Finalement insert() est appelé avec retour inversé (not()) car newstep() arrête le jeu si le retour de final_newstep() est true.*)


(* --------------------- *)
(* --------------------- *)
(*   Une etape de jeu    *)
(* --------------------- *)
(* --------------------- *)

let newstep(pl, new_t, t, dt : t_play * float ref * float * float) : bool =
  let the_end : bool ref = ref (!new_t -. t > dt) and dec : bool ref = ref false in
  let dir : char ref = ref 'x' and notmove : bool ref = ref false in
    (
    while not(!the_end)
    do
      if key_pressed()
      then dir := read_key()
      else () ;
      dec := move(pl, !dir) ;
      dir := 'x' ;
      new_t := Sys.time() ;
      the_end := !dec || (!new_t -. t > dt) ;
    done ;
    if !dec
    then (move_at_bottom(pl) ; notmove := true)
    else notmove := not(move_down(pl)) ;
    if !notmove
    then the_end := final_newstep(pl)
    else the_end := false;
    !the_end ;
    )
;;

(* ------------------------ *)
(* ------------------------ *)
(*    Fonction principale   *)
(* ------------------------ *)
(* ------------------------ *)


let jeuCP2() : unit =
  let pl : t_play = init_play() in
  let t : float ref = ref (Sys.time()) and new_t : float ref = ref (Sys.time()) in
  let dt : float ref = ref (time_init(pl.par)) and t_acc : float ref = ref (Sys.time()) in
  let the_end : bool ref = ref false in
  if valid_param(pl.par)
  then
    (
    while not(!the_end)
    do
      the_end := newstep(pl, new_t, !t, !dt) ;
      if ((!new_t -. !t_acc) > time_extent(pl.par))
      then
        (
        dt := !dt *. time_ratio(pl.par) ;
        t_acc := !new_t
        )
      else () ;
      t := !new_t
    done
    )
  else failwith("erreur : paramètres invalides")
;;


(*
jeuCP2() ;;
close_graph() ;;
 *)

(* ------------------------------- *)
(* ------------------------------- *)
(*  Réponses questions extensions  *)
(* ------------------------------- *)
(* ------------------------------- *)

(*question 1*)

(*Pour modifier facilement le choix de la couleur "vide" il faut que ca couleur soit défini par une composante d'un type : t_param car présent dans la plus part des fonctions. Il faut ensuite crée des variables locales dans les fonctions qui appellent une fonction qui déssine la matrice "vide".*)

(*question 2*)

(*Les contraintes sur les valeurs concernent les entiers et les floats. Nous devons donc vérifier que ces valeurs soit supérieur ou égale à 0 ou 0.0.*)

(*question 3*)

(*Pour éviter ces configurations, il faudrait que les cases de même couleur adjacent redeviennent des formes en jeu lorsque is_column_full() retourn un booléen true. Mais cela se complique si deux formes de même couleur sont immobiles l'un à côté de l'autre, nous pourrions changer la couleur d'une forme si elle est placé à côté d'une autre ayant la même couleur.*)
