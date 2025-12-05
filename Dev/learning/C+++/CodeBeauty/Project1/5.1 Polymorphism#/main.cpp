#include <iostream>
#include <list>
#include <string>
using namespace std;
class YoutubeChannel {
private:
	string name;
	int subscribersCount;
	list<string> publishedVideo;
protected:
	string ownerName;
	int contentQuality;
public:
	YoutubeChannel(string _name, string _ownerName) {
		name = _name;
		ownerName = _ownerName;
		subscribersCount = 0;
		contentQuality = 0;

	}
	void getInfo() {
		cout << "Channel Name: " << name << endl;
		cout << "Owner Name: " << ownerName << endl;
		cout << "Number of Subscribers: " << subscribersCount << endl;
		cout << " Videos: " << endl;
		for (string video : publishedVideo) {
			cout << video << endl;
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
	void publishVideo(string _videoTitle) {
		publishedVideo.push_back(_videoTitle);
	}
	void YoutubeQualityChecker() {
		if (contentQuality < 5) {
			cout << "Bad Channel" << endl;
		}
		else {
			cout << "Great Channel" << endl;
		}
	}
	
};
class cookingYoutubeChannel : public YoutubeChannel {
public:
	cookingYoutubeChannel(string _name, string _ownerName) :YoutubeChannel(_name, _ownerName) {

	}
	void practice() {
		cout << ownerName << " is Practicing cooking" << endl;
		contentQuality++;
	}
};
class SingingYoutubeChannel :public YoutubeChannel {
public: SingingYoutubeChannel(string _name, string ownerName) : YoutubeChannel(_name, ownerName) {

}
	  void practice() {
		  cout << ownerName << " is Practicing singing" << endl;
		  contentQuality++;

	  }
};

int main()
{
	SingingYoutubeChannel ytChannel("John sing", "John");
	cookingYoutubeChannel ytChannel2("Amy cooks", "Amy");

	ytChannel.practice();
	ytChannel.practice();
	ytChannel.practice();
	ytChannel.practice();
	ytChannel.practice();


	ytChannel2.practice();

	ytChannel.YoutubeQualityChecker();
	ytChannel2.YoutubeQualityChecker();

	return 0;
}