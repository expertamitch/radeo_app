class CreateMessageRequestModel
{
  String qrResult = '';
  String location = '';
  String selectedMessageType='';
  int selectedMessageId=0;
  List<int> selectedCustomResponseId=[];
  bool response=false;


  String? attachmentFile;


  String? selectedResponseType;

}