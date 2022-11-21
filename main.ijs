NB. For Drawing
require 'viewmat'

NB. Begin: Drawing Utilities

    NB. Show board
    sb =: '.X'&$: : ({~)

    NB. Color Pallets
    defaultPallet  =: 255 ,: 0 0 0
    borderPallet  =: 127 127 127 , defaultPallet
    diffPallet    =: 255 , 255 0 0 , 0 255 0 ,: 0
    diffBorPallet =: 127 127 127 , diffPallet

    NB. Put a border
    border =: _1&$: : ([ ,"1~ [ (,"1) [ ,~ ,)

    NB. View board (in a window)
    vb =: defaultPallet&$: : (viewmat)

    NB. View border board (in a window)
    vbb =: borderPallet viewmat border : [:

    NB. View board diff (in a window)
    NB. inputs: (answer) vdiff (other)
    vdiff =: diffPallet vb +:@[ + ]

    NB. View border board diff (in a window)
    NB. inputs: (answer) vbdiff (other)
    vbdiff =: diffBorPallet vb [: border +:@[ + ]

NB. End: Drawing Utilities

NB. Begin: Board Examples
    face    =: 5 5 $ 0 0 0 1 0 , 0 1 0 0 1 , 0 0 0 0 1 , 0 1 0 0 1 , 0 0 0 1 0
    heart   =: 5 5 $ 0 1 0 1 0 , 1 1 1 1 1 , 1 1 1 1 1 , 0 1 1 1 0 , 0 0 1 0 0
    random5 =: 5 5 $ 1 1 0 1 1 , 1 0 1 0 0 , 0 1 0 1 0 , 0 1 0 1 0 , 1 0 0 0 0
NB. End: Board Examples

NB. Make a (y y) random board
b =: 2 ?@:$~ ,~

NB. Transform one line to list of numbers
n2l =: [: ((0<#) {:: (,0) ; ]) [: (#~ 0&<) [: +/;._1 (0) , ]

NB. Transform one board to two list of numbers
n2b =: (,:&:(<@n2l"1) |:)~~

NB. build random path
NB. inputs: (ignored) rpath (feromone)
rpath =: (0&{ > +/ * 0 ?@$~ 1&}.@$)@]

NB. build <ant> random paths
NB. inputs: (feromone) rpaths (ant)
NB. output is boxed list
rpaths =: [ <@rpath~"_ 0 i.@]

NB. pick the best thing acording to <f>
NB. inputs: (ignored) ((f) best) (list of boxed things)
NB. output: boxed list: f(bthing) ; bthing
best =: 1 : '] (] ; [ {::~ i.~@]) [: <./ u@>@]'

NB. create a feromone table with <num>
NB. inputs: (num) newfer (board) OR newfer (board)
NB. default <num> is 1
newfer =: 1&$: : ([ $~ 2 , $@])

NB. update feromone
NB. inputs: (best_path) ((evaporation) uf) (feromone)
uf =: 1 : '(-.m)&*@] + (,:~ -.)@[ * m * +/@:(+/)@:(+/)@] % */@$@['
NB. '+/@:(+/)@:(+/)@]' could be '+/@,@]'

NB. one iteration with <ant> ants
NB. inputs: (ignored) ((evaporation ; f ; ant) it) (feromone)
NB. output: boxed list: new feromone ; f(bpath) ; bpath
it =: 1 : '((m@.1 best)@rpaths&(2 {:: m) ([ ;~ 1&{::@[ ((0 {:: m) uf) ]) ])@]'

NB. first (dumb) function to minimize
NB. inputs: (graph) flist (board)
flist =: [: +/@, [ (|@-/)@(,:!.0)&> n2b@]

NB. function to minimize
NB. inputs: (graph) f (board)
f =: flist

NB. initial state
NB. inputs: (timer) ((params) init) (feromone)
NB. output: boxed list:
NB.     timer ; feromone ; f(bpath) ; first bpath
init =: 1 : '[ ; ] ; [: (m@.1 ; ]) 0 $~ }.@$@]'

NB. This is a multi line comment
NB. that ends on a )
0 : 0
NB. parameter list (params):
* evaporation
* f
* ant
)

NB. Begin "Data Type": Picked
NB. "Haskell type": Picked a = Keep a | New a

    NB. "Constructors"
    K =: 0 ; <@]
    N =: 1 ; <@]

    NB. Apply <u> if is New else do nothing
    Ap =: 1 : '0&{:: ([ ; {) (; <@u)@{::~&1'

    NB. "Destructor/Elimination"
    P =: 2 : '0&{:: ([ {:: (u@] ; <@v@])@]) 1&{::'
    unP =: 1&{::

NB. End "Data Type": Picked

NB. check/update termination condition and run 'it'
NB. inputs: (params) loop (boxed list from init)
loop =: 1 : 0
    NB. runs an iteration, updates feromone, f(bpath), bpath
    new =. {. , (2 3&{) (0&{@] , ({::~&0@[ > {::~&1@]) { [ ,: 1 2&{@]) (m it)@{::~&1
    NB. decrement timer
    dec =. ] (}.@[ ;~ 0 >. <:@]) {::~&0@]
    NB. checks if should terminate: (timer = 0) or (f(bpath) = 0)
    NB. returns 0 if should stop
    finish =. (<@] ;~ 0 *./@:< >@{~&0 2)@unP@]
    finish (dec@:new) Ap y
)

NB. Read and Write random seed
rrand =: 9!:0
wrand =: 9!:1

NB. Read and Write random state
rrands =: 9!:44
wrands =: 9!:45

NB. Time a function random seed
timeit =: 6!:2

NB. main loop
NB. inputs: (params) main (boxed list from init)
main =: 4 : 0
    rseed =. rrand''
    rstate =. rrands''
    run =. 4 : 'ret_main_ =: x loop y'
    t =. timeit 'x run^:_ N y'
    (rseed ; <rstate) ; t ; ret_main_
)
