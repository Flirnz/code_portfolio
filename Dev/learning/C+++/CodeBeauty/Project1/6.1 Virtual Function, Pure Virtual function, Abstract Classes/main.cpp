#include<iostream>
#include<list>
#include<string>
using namespace std;

class intstrument {
public:
	virtual void makeSound() = 0;

};
class Guitar : public intstrument {
public: 
	void makeSound() {
		cout << "Guitar is Playing" << endl;
	}
};
class Piano : public intstrument {
	void makeSound() {
		cout << "Piano is Playing" << endl;
	}
	
};
class Drum : public intstrument {
	void makeSound() {
		cout << "Drum is Playing" << endl;
	}
};
int main()
{
	intstrument* i2 = new Guitar();
	intstrument* i3 = new Piano();
	intstrument* i4 = new Drum();
	intstrument* instruments[3] = { i2,i3,i4};
	for (int i = 0; i < 3; i++) {
		instruments[i]->makeSound();
	}

	for (int i = 0; i < 3; i++) {
		delete instruments[i];
	}
	

	



	return 0;

}