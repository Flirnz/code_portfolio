#include<iostream>
#include<list>
#include<string>
using namespace std;

struct YoutubeChannel {
	string Name;
	int SubscribersCount;

	YoutubeChannel(string _name, int _subscribersCount)
	{
		Name = _name;
		SubscribersCount = _subscribersCount;
	}
};
void operator<<(ostream& COUT, YoutubeChannel& ytChannel) {
	COUT << "Name: " << ytChannel.Name << endl;
	COUT << "subscribers: " << ytChannel.SubscribersCount << endl;
}
struct myCollection {
	list<YoutubeChannel>myChannel;
	void operator+=(YoutubeChannel& channel) {
		this->myChannel.push_back(channel);
	}
};
ostream& operator<<(ostream& COUT, myCollection& _myCollection) {
	for (YoutubeChannel ytChannel: _myCollection.myChannel ) 
		COUT << ytChannel << endl;
		return COUT;
	
}

int main() {
	

	YoutubeChannel channel1 =YoutubeChannel("Gaming", 1000000000);
	YoutubeChannel channel2 = YoutubeChannel("cooking", 200);
	cout << channel1;
	myCollection collection1;
	collection1 += channel1;
	collection1 += channel2;
	cout << collection1;




	return 0;
}

















