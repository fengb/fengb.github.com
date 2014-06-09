---
title: I Don't Use Semicolons
---
There is a strong stigma against using automatic semicolon insertion (ASI).  I
used to be dogmatically against ASI until my colleague gave me some doubt.  I
did a bit of research and eventually came to embrace ASI.

Using ASI requires a comprehensive view of the rules.  The official Javascript
definition is clumsy and confusing to the point of uselessness so I generally
remember when a semicolon is *not* inserted:

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

While most of these cases are obvious, there are a handful of statements that
are ambiguous at first glance.  Therefore, I have adopted another convention:
statements starting with "`[`" or "`(`" gets prepended with a semicolon.

Example:

>     var default = op('default')
>     ;['far', 'and', 'away'].forEach(function(val){
>       ;(op(val) || default).run()
>     })
