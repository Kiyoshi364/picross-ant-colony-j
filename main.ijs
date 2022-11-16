NB. Read and Write random seed
rrand =: 9!:0
wrand =: 9!:1

NB. Make a (y y) random board
b =: 2 ?@:$~ ,~

NB. Transform one line to list of numbers
n2l =: [: ((0<#) {:: (,0) ; ]) [: (#~ 0&<) [: +/;._1 (0) , ]

NB. Transform one board to two list of numbers
n2b =: (,:&:(<@n2l"1) |:)~~

NB. Show board
sb =: '.X'&$: : ({~)

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

0 : 0
NB. parameter list:
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
evap=. 0&{::
f2  =. @.1
ant =. 2&{::

t   =. 0&{::
fer =. 1&{::
fbp =. 2&{::
bp  =. 3&{::

NB. runs an iteration, updates feromone, f(bpath), bpath
new =. {. , (2 3&{) (0&{@] , ({::~&0@[ > {::~&1@]) { [ ,: 1 2&{@]) (m it)@{::~&1
NB. decrement timer
dec =. ] (}.@[ ;~ 0 >. <:@]) {::~&0@]
NB. checks if should terminate (timer == 0)
finish =. (<@] ;~ 0 < 0&{::)@unP@]
finish (dec@:new) Ap y
)

NB. This is a multi line comment
0 : 0
TODO:

NB. **sketch**
NB. fill in between with 0's
NB. inputs: () a ()
a =: todo

NB. stop conditions

NB. main loop
main =: todo
)
