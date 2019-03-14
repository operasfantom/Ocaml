open LogiсTree;;

open Buffer;;
open Printf;;
open Core.Std;;

let (|>) x f = f x;;

type op with
        member x.format() = match x with | Conj -> "&" | Disj -> "|" | Impl -> "->"

let ExpressionToTree text =
    let rec analyse tree : seq<string> = seq {
        match tree with
            | Var v ->
                yield v
            | Neg t ->
                yield "(!"
                yield! (analyse t)
                yield ")"
            | Binop(op, t1, t2) ->
                yield "("
                yield op.format()
                yield ","
                yield! (analyse t1)
                yield ","
                yield! (analyse t2)
                yield ")"
    }
    let lexbuf = LexBuffer<_>.FromString text
    let t = LoginputParser.parse LoginputLexer.tokenize lexbuf

    analyse t |> String.concat ""

let (input,output) = (open_in "input.txt", open_out "output.txt");;

input |> input_line |> ExpressionToTree |> output_line

output |> close_out ;;
input |> close_in;;