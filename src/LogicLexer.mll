{
module LogicLexer

open LogicParser
}

let variable = ['A' - 'Z']+ ['A' - 'Z' '0' - '9' ''']*

rule tokenize = parse
        | variable      { VAR(LexBuffer<_>.LexemeString lexbuf) }
        | "->"          { IMPL }
        | "&"           { AND }
        | "|"           { OR }
        | "!"           { NOT }
        | "("           { OPEN }
        | ")"           { CLOSE }
        | eof           { EOF }