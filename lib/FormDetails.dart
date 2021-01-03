class FormDetails{
  String refno;
  String details;
  String form_no;
  String pt;
  String info;

  FormDetails(this.refno, this.details, this.form_no, this.pt, this.info);

  FormDetails.fromJason(Map<String,dynamic> json){
        refno = json['refno'];
        details = json['details'];
        form_no = json['form_no'];
        pt = json['pt'];
        info = json['info'];


  }
}