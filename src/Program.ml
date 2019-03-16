(*open LogicTree

open System.IO
open Microsoft.FSharp.Text.Lexing*)
open LogicTree;;
open Buffer;;
open Printf;;
open String;;

let (|>) x f = f x;;

(*type op with*)
(*        member x.format() = match x with | Conj -> "&" | Disj -> "|" | Impl -> "->"*)
let format x = match x with | Conj -> "&" | Disj -> "|" | Impl -> "->"

let tree_from_text text = text |> Lexing.from_string |> (LogicLexer.tokenize |> LogicParser.parse)

let expression_to_tree text =
    (*let rec analyse tree = seq {
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
      }*)
  let rec analyse tree = match tree with
    | Var v -> [v]
    | Neg t -> ["(!"] @ (analyse t) @ [")"]
    | Binop(op, t1, t2) -> ["("] @ [format op] @ [","] @ (analyse t1) @ [","] @ (analyse t2) @ [")"]
  in analyse;

  text |> tree_from_text |> analyse |> String.concat ""


let (input, output) = (open_in "input.txt", open_out "output.txt");;

(*input |> input_line |> expression_to_tree |> fprintf output "%s\n";;*)
stdin |> input_line |> expression_to_tree |> fprintf stdout "%s\n";;


(*[<EntryPoint>]
let main argv =
  use input = File.OpenText("input.txt")
  use output = File.CreateText("output.txt")
  input.ReadLine() |> ExpressionToTree |> output.WriteLine
  0 // return an integer exit code*)
