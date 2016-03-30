# console-game
Create a simple console game in which the computer generates a random math expression like ``7 * 9 / 3`` and asks the user to solve the equation.

The game must take a level parameter, the level determines the length of the generated equation; for example:

--level 1
``
68 = 68
17 = 17
40 = 40
97 = 97
58 = 58
``

--level 2
``
75 - 54 = 21
62 + 15 = 77
88 / 22 = 4
93 + 22 = 115
90 * 11 = 990
``

--level 3
``
( 21 + 13 ) * 56 = 1904
82 - 19 + 16 = 79
51 * ( 68 - 2 ) = 3366
41 + 55 + 31 = 127
82 * 22 - 16 = 1788
``

--level 4
``
99 * 1 * ( 1 + 79 ) = 7920
( 80 + 84 ) * ( 89 + 65 ) = 25256
54 * 64 * 75 * 68 = 17625600
89 + 10 - ( 8 / 2 ) = 95
12 + 70 + 48 + 39 = 169
``

--level 5
``
49 * 11 - ( 33 + 71 - 39 ) = 474
5 / 5 + ( 75 + 91 ) / 83 = 3
42 + 38 + 67 * 37 - 47 = 2512
( 17 - 10 ) * ( 40 + 67 - 67 ) = 280
91 * 80 - ( 40 * 19 / 2 ) = 6900
``
> Note that level 1 is useless! We just have it for simplicity.

The game starts with a command like `./game --level 3`

The numbers in the equations must be integers between and including 1 to 100.

The game must produce equations with addition `+` and multiplication `*` operators like `( 21 + 13 ) * 56`.


## Bonus 1:

The game should print out the simplest form of the expressions (by removing unnecessary parentheses), for example it should simplify ``(5 + 3) + (8 * 3)`` to ``5 + 3 + 8 * 3``.

Add subtraction `-` operator.


## Bonus 2:

Add division `/` operator.

Make sure the result of the equation is always a positive integer.


Running Locally

1. Install Node.js and NPM (http://nodejs.org/)

    `npm install`

2. Then, in command line, from the project's root directory, run:

    `npm start`

3. Run tests

    `npm test`
  or
    `npm test:watch`
