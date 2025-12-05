#include<iostream>
#include<list>
#include<string>

class YoutubeChannel {
private:
	std::string name;
	std::string ownerName;
	int subscribersCount;
	std::list<std::string>publishedVideo;

public:
	YoutubeChannel(std::string _name, std::string _owner) {
		name = _name;
		ownerName = _owner;
		subscribersCount = 0;

	}
	void getInfo() {
		std::cout << "Name: " << name << std::endl;
		std::cout << "Owner name: " << ownerName << std::endl;
		std::cout << "Numbers of subscriber: " << subscribersCount << std::endl;
		std::cout << "Videos: " << std::endl;
		for (std::string video : publishedVideo) {
			std::cout << video << std::endl;
		}
		
	}
	void subscribe() {
		subscribersCount++;
	}
	void unsubscribe() {
		if (subscribersCount > 0) {
			subscribersCount--;
		}
	}
	void publishVideo(std::string _videoTitle) {
		publishedVideo.push_back(_videoTitle);
	}
	void changeUsername(std::string _newOwnerName) {
		ownerName = _newOwnerName;
	}
	void changeChannelName(std::string _newChannelName) {
		name = _newChannelName;
	}
	void deleteLatestVideo() {
		publishedVideo.pop_back();
	}
};

int main()
{
	YoutubeChannel YtChannel("Ferdinand", "Ferdinand Gaming");
	YtChannel.subscribe();
	YtChannel.subscribe();
	YtChannel.subscribe();
	YtChannel.subscribe();
	YtChannel.publishVideo("Clash of Clans");
	YtChannel.getInfo();

	YtChannel.unsubscribe();
	YtChannel.getInfo();

	YtChannel.changeUsername("Najmi");
	YtChannel.changeChannelName("Najmi Voyage");
	YtChannel.deleteLatestVideo();
	YtChannel.getInfo();

	

	

	return 0;

}