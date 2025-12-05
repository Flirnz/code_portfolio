#include<iostream>
#include<string>
#include <list>

// Define a class named 'car' with public members: brand, model, year, and features
class car {
public:
	std::string brand;
	std::string model;
	int year;
	std::list<std::string> features;

};
int main()
{
	car myCar;
	myCar.brand = "Nissan";
	myCar.model = "Innova";
	myCar.year = 2023;
	myCar.features = { "Air Conditioning", "Leather Seats", "Bluetooth Connectivity" };

	std::cout << "Car Brand: " << myCar.brand << std::endl;
	std::cout << "Car Model: " << myCar.model << std::endl;
	std::cout << "Car Year: " << myCar.year << std::endl;
	std::cout << "Features: " << std::endl;
	for (std::string carFeature : myCar.features) {
		std::cout << carFeature << std::endl;
	}
	return 0;

}