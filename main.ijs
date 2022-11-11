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
NB. input: (ignored) rpath (feromone)
rpath =: (0&{ > +/ * 0 ?@$~ 1&}.@$)@]

NB. build <count> random paths
NB. input: (feromone) rpaths (count)
NB. output is boxed list
rpaths =: [ <@rpath~"_ 0 i.@]

NB. pick the best thing acording to <eval>
NB. input: ((eval) best) (list of boxed things)
best =: 1 : '] >@{~ [: (] i. <./) u@>@]'

NB. update feromone
NB. inputs: (best_path) ((evaporation) uf) (feromone)
uf =: 1 : '(-.m)&*@] + (,:~ -.)@[ * m * +/@:(+/)@:(+/)@] % */@$@['

NB. one iteration with <count> ants
NB. inputs: (feromone) ((evaporation) it) (count)
NB. output: boxed list: new feromone ; bpath
it =: 1 : '(f best)@rpaths ([ ;~ m uf) ['

NB. initial state
NB. input: (graph) ((timer) init (count)) (feromone)
NB. output: boxed list: timer ; count ; graph ; feromone ; first bpath
init =: 2 : 'm ; n ; [ ; ] ; 0 $~ }.@$@]'

NB. This is a multi line comment
0 : 0
TODO:
NB. function to minimize
f =: todo

NB. **sketch**
NB. fill in between with 0's
NB. input: () a ()
a =: todo

NB. stop conditions

NB. main loop
main =: todo
)
