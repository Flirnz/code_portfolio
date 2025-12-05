#include <iostream>


int g_guess_counter = 0;
int g_chances = 0;

int main()
{
	int choice = 0;
	std::cout << "Welcome to the NUmber Guessing Game!\n";
	std::cout << "I'm thinking of a number between 1 adn 100\n";
	std::cout << "You have 5 chances to guess the correct Number\n \n";

	std::cout << "Please select the difficulty level:\n";
	std::cout << "1. Easy (10 chances)\n";
	std::cout << "2. Medium (5 chances)\n";
	std::cout << "3. Hard (3 chances)\n \n";

	std::cout << "Enter your choice: \n";
	std::cin >> choice;

	if (choice < 1 && choice > 3)
	{
		while (choice < 1 && choice > 3)
		{
			std::cout << "Invalid choice, Select the number between 1 to 3\n";
			std::cin >> choice;
		}
		if (choice == 1)
		{

			g_chances = 10;
			std::cout << "You Have selected Easy difficulty, you now have " << g_chances << " chances";
		}
		else if (choice == 2)
		{
			g_chances = 5;
			std::cout << "You Have selected Medium difficulty, you now have " << g_chances << " chances";
		}
		else
		{
			g_chances = 3;
			std::cout << "You Have selected Hard difficulty, you now have " << g_chances << " chances";
		}
	}
	


	return 0;
}