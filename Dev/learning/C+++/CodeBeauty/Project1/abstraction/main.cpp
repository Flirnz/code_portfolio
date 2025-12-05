#include<iostream>
#include<list>
#include<string>
using namespace std;
class Smartphone {
public:
	virtual void takeASelfie() = 0;
	virtual void makeACall() = 0;
};
class android :public Smartphone {
public:
	 void takeASelfie() {
		cout << "Android take a Selfie" << endl;
	}
	 void makeACall() {
		 cout << "Android make a call" << endl;
	 }
};
class IPhone :public Smartphone {
public:
	void takeASelfie() {
		cout << "Iphone take a Selfie" << endl;
	}
	void makeACall() {
		cout << "Iphone make a call" << endl;
	}
};
int main() {
	Smartphone* s1 = new android;
	Smartphone* s2 = new IPhone;
	s1->takeASelfie();
	s2->takeASelfie();
	s1->makeACall();
	s2->makeACall();




	return 0;
}