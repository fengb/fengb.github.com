---
title: I Don't Use Semicolons
---
There is a strong stigma against using automatic semicolon insertion (ASI).  It
does not help that official Javascript spec is intimidating and confusing:

> 1. When the program contains a token that is not allowed by the formal
>    grammar, then a semicolon is inserted if (a) there is a line break at that
>    point, or (b) the unexpected token was a closing brace.
>
> 2. When the end of a file is reached, if the program cannot be parsed
>    otherwise, then a semicolon is inserted.
>
> 3. When a "restricted production" is encountered and contains a line
>    terminator in a place where the grammar contains the annotation "[no
>    LineTerminator here]", then a semicolon is inserted.

Please ignore the official spec; the inverted definition is much simpler.  This
is a comprehensive list of cases where a semicolon is *not* inserted:

> 1. After incomplete statements:
>
>        |  if(a==b)  |  if(a == b) t();
>        |    t()     |
>
> 2. Before statements starting with dots for non-numbers:
>
>        |    abc     |  abc.def
>        |    .def    |
>
>        |    abc     |  abc;.123
>        |    .123    |
>
> 3. Before statements starting with infix operators
>
>        |  abc       |  abc && def || ghi
>        |  && def    |
>        |  || ghi    |
>
>        |  12        |  12 + 34 - 56 * 78 / 90
>        |  + 34      |
>        |  - 56      |
>        |  * 78      |
>        |  / 90      |
>
> 4. Before statements starting with opening brackets/parenthesis
>
>        |  abc       |  abc[0, 1]
>        |  [0, 1]    |
>
>        |  abc       |  abc(0, 1)
>        |  (1, 2)    |

I would argue that Javascript handles most of these special cases correctly, but
there are a handful of statements that confuse ASI.  Therefore, I have adopted
another convention: statements starting with "`[`" or "`(`" gets prepended with
a semicolon.

Example:

>     var default = op('default')
>     ;['far', 'and', 'away'].forEach(function(val){
>       ;(op(val) || default).run()
>     })
