> Please read the AI responsibilities before starting.

### Using AI Responsibly for Project Reviews

For guidelines on the responsible and tactical use of AI tools, particularly regarding project reviews, please refer to the information provided in this [link](https://turingcollege.atlassian.net/wiki/x/LwAieg).


___


# Project Goal

The first Python practical graded task will require you to implement a Python program that will answer a simple question – given a board state that the user enters, with 1 white figure and up to 16 black figures, which black figures can the white figure take?

## How to get started with Google Colab to make the project:

- Visit the [Colab page.](https://colab.research.google.com/)

- Log in with your private Google Account or create one.

- After making a copy and downloading the graded task work file from this [link](https://drive.google.com/file/d/1VyT4GALALVrxmPOXyyAmxvGgAqD_1Y8P/view?usp=sharing), upload the notebook file [here](https://colab.research.google.com/) to begin working on the project.

- **Start by adhering to the instructions in the file while considering the criteria below for a broader perspective on the project requirements.**

> If you wish and feel more comfortable, you can use an IDE of your choice to complete the project separately from the Jupyter Notebook provided above.


<br>


# Task Requirements

### 1. User Input for White Piece
- The program must prompt the user to input a white piece and its position on the board.
- The user must choose between two predefined piece types (e.g., pawn and rook).
- The input format must be: <piece> <location> (e.g., knight a5).
- The program must confirm a successful addition or display an error message if the input is invalid.

<br>

### 2. User Input for Black Pieces
- After the white piece is set, the user must input the black pieces one by one.
- Each black piece must follow the same format (e.g., bishop d6).
- The user must add at least one and at most sixteen black pieces.
- The user can enter "done" to stop adding black pieces only after at least one black piece has been added.
- The program must confirm a successful addition or display an error message if the input is invalid.

<br>

### 3. Input Validation
- The program must ensure that input coordinates follow the correct format (where the letter is a-h and the digit is 1-8, e.g., a1, d4, h8).
- The program must handle edge cases, such as:
- Attempting to enter "done" before adding at least one black piece.
- Providing invalid chess piece names.
- Entering out-of-bounds coordinates.

<br>

### 4. Output and Gameplay Logic
- After all pieces are added, the program must display a list of black pieces that the white piece can capture based on valid chess moves.
- If no black pieces are captured, the program should indicate this clearly.

___


## Optional Tasks

After the main functionality is implemented, your code works correctly, and you feel that you want to upgrade your project, choose one or more improvements from this list. Again, this is strictly optional. **Some of these optional tasks may be challenging.**

<br>

### 1. Implement a Nice Visualization Function
- Create a function to print the chessboard using Unicode chess symbols to represent each piece accurately.
- Ensure proper alignment of pieces in an 8x8 grid, with row and column labels.
---

### 2. Implement Danger Squares Visualization
- Create a function that highlights all squares that the white piece can attack, even if the path is blocked by another piece.
- Use the ASCII symbol of X or color coding to mark dangerous squares

<br>

### 3. Implement Starting Position Generation
- Modify your code so that the program will ask you your preference in the beginning. Would you like to enter the figures manually or generate them randomly? If the user selects random generation, implement functions that would place one white figure and sixteen random black ones.

<br>

### 4. Implement a Game Menu System
- Replace the linear input system with an interactive menu that allows flexible commands.
- Menu Options:
Commands:

```pyth
  - white_input <piece> <location>    (e.g., knight a5)
  - black_input <piece> <location>    (e.g., bishop d6)
  - print_board                       (displays the current board)
  - check_captures                    (lists capturable black pieces)
  - exit                              (quits the program)
```

<br>

### **5. Implement a Capture Minigame**
Goal: Allow the white piece to capture a selected black piece, then check if further captures are possible.
How it Works:
```
  1.  The player selects a white piece.
  2.  The program highlights capturable black pieces.
  3.  The player selects which piece to capture.
  4.  The captured piece is removed, and the game updates the board.
  5.  The player can look for new captures and repeat.

```
Extra Challenge:
Create preset scenarios where players must capture all black pieces in the correct order.
Example scenario:

```
  - White piece rook e4
  - Black pieces pawn h4, pawn h8, pawn e8, pawn a8, pawn a1
  - From the given position, the rook can take either e8 or h4, but only one would ensure sequential clearance of the board
  - Correct capture sequence would be h4->h8->e8->a8->a1
```

<br>


> Also, Remember the [20-minute rule](https://turingcollege.atlassian.net/wiki/spaces/DLG/pages/537395978/How+to+learn+at+Turing+College#Asking-for-help): If you get stuck for 20+ minutes on a single exercise, take a break and join an **Open Session** designated to Python or check with your peers. It is okay if you cannot solve these challenges yet on your own.

Finally, if you don’t know chess, keep in mind that to solve problems at work as a data analyst, you will always need to learn more about the industry in which you are working. For example, if you start working as a data analyst for a logistics company, you will benefit greatly from gaining a good understanding of how logistics work.

<br>


### Sample questions during a review

- How do you define a function in Python? How can you easily test whether something is a function in Python? How do you define the parameters of a function? How are values passed into a function?
- What is the difference between a list and a dictionary?
- What is pseudocode?
- Can you show how you debug the program that you have written? Could you make a small change in the code and explain what it will do?

<br>

### Project Evaluation Criteria

- The program correctly adds the white piece. Weight: 1
- The program correctly adds the black pieces. Weight: 1
- The program correctly says which black pieces the white piece can take. Weight: 1
- Code quality (at this point, you are expected to write code that is relatively tidy and easy to follow. You can refer to the hands-on suggested solution for the level that may be expected from you). Weight: 1
- General understanding of the sprint topics (the reviewer may ask you about topics covered in the sprint and the code that you have written). Weight: 2

<br>

# Submission:

Provide your `Google Colab project link` or `notebook`, or submit your project's `.py file` created with your preferred IDE. If necessary, include any relevant additional documents or descriptions about your project work.

