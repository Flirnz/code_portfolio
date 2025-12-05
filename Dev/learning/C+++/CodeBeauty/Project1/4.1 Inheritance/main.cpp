#include<iostream>
#include<list>
#include<string>
class YoutubeChannel {
private: 
	std::string name;
	int subcribersCount;
	std::list<std::string> publishedVideo;
protected:
	std::string ownerName;

public:
	YoutubeChannel(std::string _name, std::string _ownerName) {
		name = _name;
		ownerName = _ownerName;
		subcribersCount = 0;
	}
	void getInfo() {
		std::cout << "Channel name: " << name << std::endl;
		std::cout << "Owner Name: " << ownerName << std::endl;
		std::cout << "Subcriber: " << subcribersCount;
		std::cout << "Videos" << std::endl;
		for (std::string video : publishedVideo) {
			std::cout << video << std::endl;
		}
	}
	
};
class CookingYoutubeChannel : public YoutubeChannel {
public:
	CookingYoutubeChannel(std::string _name, std::string _ownerName): YoutubeChannel (_name,_ownerName) {

	}
	void practice() {
		std::cout<<ownerName << " is Pacticing cooking" << std::endl;
	}
};
int main()
{
	CookingYoutubeChannel ytChannel("Ferdinand's Kitchen", "Ferdinand");
	ytChannel.practice();
	CookingYoutubeChannel ytChannel2("Najmi's Kitchen", "Najmi");
	ytChannel2.practice(); 

	return 0;
}