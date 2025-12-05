#include <iostream>
#include <string>
#include<list>
class YoutubeChannel {
public:
	std::string Name;
	std::string Owner;
	int SubscriberCount;
	std::list<std::string> videoTitle;
	YoutubeChannel(std::string name, std::string owner) {
		Name = name;
		Owner = owner;
		SubscriberCount = 0;

	}
	void getInfo() {
		std::cout << "Channel Name: " << Name << std::endl;
		std::cout << "Owner Name: " << Owner << std::endl;
		std::cout << "Subscriber counts: " << SubscriberCount << std::endl;
		std::cout << "Videos: " << std::endl;
		for (std::string video : videoTitle) {
			std::cout << video << std::endl;
		}
	}
};

int main()
{
	YoutubeChannel ytChannel("Code Beauty", "Ferdinand");
	ytChannel.videoTitle.push_back("C++ Tutorial");
	ytChannel.videoTitle.push_back("Html Tutorial");
	ytChannel.videoTitle.push_back("Java tutorial");
	ytChannel.SubscriberCount = 10000;
	YoutubeChannel ytChannel2("Code Handsome", "Ferdinand Lienardy");
	ytChannel.getInfo();
	ytChannel2.getInfo();


	return 0;

}