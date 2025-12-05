#include<iostream>
#include<list>
#include<string>
using namespace std;
class Instrument
{
public:
	virtual void makeASound() = 0; 


private:

};

class Guitar : public Instrument
{
public:
	void makeASound() {
		cout << "Guitar is playing" << endl;
	}


private:

};

class Piano : public Instrument {
public:
	void makeASound() {
		cout << "Piano is Playing" << endl;
	}
};



int main() {

	Instrument* i1 = new Guitar;
	Instrument* i2 = new Piano;

	Instrument* instruments[2] = { i1,i2 };
	for (int i = 0; i < 2; i++) {
		instruments[i]->makeASound();
	}


	return 0;

}





















