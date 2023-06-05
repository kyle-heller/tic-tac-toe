```
████████╗██╗ ██████╗    ████████╗ █████╗  ██████╗    ████████╗ ██████╗ ███████╗
╚══██╔══╝██║██╔════╝    ╚══██╔══╝██╔══██╗██╔════╝    ╚══██╔══╝██╔═══██╗██╔════╝
   ██║   ██║██║            ██║   ███████║██║            ██║   ██║   ██║█████╗
   ██║   ██║██║            ██║   ██╔══██║██║            ██║   ██║   ██║██╔══╝
   ██║   ██║╚██████╗       ██║   ██║  ██║╚██████╗       ██║   ╚██████╔╝███████╗
   ╚═╝   ╚═╝ ╚═════╝       ╚═╝   ╚═╝  ╚═╝ ╚═════╝       ╚═╝    ╚═════╝ ╚══════╝

```

Command-line version of tic-tac-toe, playable by two players or vs computer

Play Online at Replit:
[https://replit.com/@xsys/Tic-Tac-Toe#](https://replit.com/@xsys/Tic-Tac-Toe#)

## Problems

Create a tic-tac-toe game that clears the console and prints the game board after every turn, accepts user input, and determines a winner

## What I used

Ruby classes, public and private methods, accessor methods, loops

## What I learned

How to use OOP to split a program into multiple logical components, minimizing how much of a class is exposed by privatizing methods, create a game loop, sanitizing and validating user input, debugging faulty logic (for instance with Array#intersection, I found the difference in ordering between "[1, 2, 3] & [3, 2, 1]" and "[3, 2, 1] & [1, 2, 3]" which caused issues when comparing against the winning condition arrays), and refactoring my code to be more segmented and concise
