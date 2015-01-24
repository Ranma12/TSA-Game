#include<iostream>
#include"Game.cpp"
using namespace std;
int main() {
	cout << "Starting" << endl;
	Game game;
	game.Running = true;
	if (!game.Running) {
		return -1;
	}
	game.Run();
	return 0;
}
