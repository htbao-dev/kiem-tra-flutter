const String apiKey = "22017bed8d2e44d8aa8b38d4aececb76";
class NewsType{
  String type;
  String displayName;
  String imgUrl;

  NewsType(this.type, this.displayName, this.imgUrl);

  static List<NewsType> getListNewsType(){
    List<NewsType> listNewsType = [];
    listNewsType.add(NewsType("apple", "Apple", "https://cdn.tgdd.vn/Files/2021/01/04/1317960/san-pham-cua-apple-2021-hinh1_800x450.jpg"));
    listNewsType.add(NewsType("tesla", "Tesla", "https://www.reuters.com/resizer/i-1EJo70FqrMUlErS53dSb4S8ng=/1200x0/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/RNBIKZANUVMH3OQGNLHUWQZS7A.jpg"));
    listNewsType.add(NewsType("entertainment", "Entertainment", "https://enmota.com/wp-content/uploads/2018/04/100-bai-tieng-anh-giao-tiep-co-ban-bai-14-entertainment-giai-tri-1024x576.jpg"));
    listNewsType.add(NewsType("covid", "Covid-19", "https://images.theconversation.com/files/422498/original/file-20210921-19-1kb6j0s.jpg?ixlib=rb-1.1.0&rect=0%2C25%2C5700%2C3763&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip"));
    listNewsType.add(NewsType("vietnam", "Việt Nam", "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/2560px-Flag_of_Vietnam.svg.png"));
    listNewsType.add(NewsType("worldcup", "World cup", "http://admin.tapchithethao.vn/js/tiny_mce/plugins/imagemanager/files_new/GettyImages-453347919.jpg"));
    return listNewsType;
  }
}