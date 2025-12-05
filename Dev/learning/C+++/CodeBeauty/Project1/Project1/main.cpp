#include<iostream>
#include<cstring>
#include <string>
#include <stdlib.h>
#include <list>
class YoutubeChannel {
public:
	std::string Name;
	std::string OwnerName;
	int SubscribersCount;
	std::list <std::string> PublishedVideoTitles;

};

int main() {
	YoutubeChannel ytChannel;
	ytChannel.Name = "CodeBeauty";
	ytChannel.OwnerName = "Ferdinand";
	ytChannel.SubscribersCount = 10000000;
	ytChannel.PublishedVideoTitles = { "C++ for Beginners", "Python for Beginners", "Java for Beginners" };

	std::cout << "Channel Name: " << ytChannel.Name << std::endl;
	std::cout << "Owner name: " << ytChannel.OwnerName << std::endl;
	std::cout << "Subscriber count: " << ytChannel.SubscribersCount << std::endl;
	std::cout << "Videos: " << std::endl;
	for (std::string videoTitle : ytChannel.PublishedVideoTitles) {
		std::cout << videoTitle << std::endl;
	}

	return 0;
}