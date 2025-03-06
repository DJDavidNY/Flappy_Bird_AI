# Neural Network-Based Flappy Bird AI

This project is a Flappy Bird-inspired game that uses a Neural Network and Genetic Algorithm to evolve an AI capable of playing the game on its own. The AI-controlled birds learn to navigate obstacles and improve performance over multiple generations.

## Neural Network
The AI birds utilize a neural network with:
- **5 input nodes**: Bird's height, top pipe height, bottom pipe height, pipe x-position, and vertical velocity.
- **1 hidden layer** with 15 neurons.
- **2 output nodes**: Determines whether the bird should flap or not.

The neural network is trained using a simple **feedforward algorithm** and optimized through a **genetic algorithm** to evolve better-performing birds.

## Genetic Algorithm
The project implements a genetic algorithm to optimize the AI birds:
1. **Fitness Calculation**: Birds accumulate points based on survival time.
2. **Selection**: Two parent birds are chosen using fitness proportionate selection.
3. **Crossover**: The parents' neural networks are combined to create a new bird.
4. **Mutation**: Small random changes are introduced to weights for variation.

This process repeats every generation to improve the AI birds over time.

## Game Mechanics
- The game spawns **200 birds** at the start of each generation.
- Birds must navigate past obstacles (pipes) without hitting them or going off-screen.
- Once all birds are eliminated, the next generation is created based on the genetic algorithm.

## Controls
- Press **'S'** to save the best-performing neural network.
- Press **'G'** to toggle game speed between normal and fast mode.

## File Saving
When the best-performing neural network reaches a high score, or when the user presses 'S', the neural network's weights are saved as text files:
- `weightsIH.txt` (input-to-hidden weights)
- `weightsHO.txt` (hidden-to-output weights)

## Installation Steps
To run this project on your own computer:
1. Install [Processing](https://processing.org/download/) if you haven't already.
2. Download/Clone the entire project folder and ensure all files are present.
3. Open `main.pde` in Processing.
4. Click **Run** to start the game.
5. Use the 'S' key to save the neural network if you want to reuse it later.

This setup will allow you to experiment with the AI and see how it evolves over time.

## Project Credits

**Creator**: David Wexler
**Technologies**: Processing, Java
